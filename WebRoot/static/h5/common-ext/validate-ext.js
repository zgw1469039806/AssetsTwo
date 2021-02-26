$.validator.setDefaults({
	errorElement: 'div',
	errorPlacement: function(error, element) {
		error.addClass('tooltip tooltip-inner');
		var pos = $.extend({}, element.offset(), {
			width: element.outerWidth(),
			height: element.outerHeight()
		});
		var parDom;
		if(element.parents('td:eq(0)').length){
			parDom = element.parents('td:eq(0)');
		}else if(element.parents('[class^="col-sm"]').length){
			parDom = element.parents('[class^="col-sm"]');
		}else{
			parDom = element.parent();
		}
		parDom.css('position', 'relative');
		error.css({
			display: 'block',
			opacity: '0.8',
			backgroundColor: '#d9534f',
			top: 0,
			left: 0
		});
		error.on('mouseenter',function(){
			$(this).hide();
		});
		error.insertAfter(element);
	},
	highlight: function(element, errorClass) {
		//高亮显示
		$(element).addClass(errorClass);
		$(element).parents('li:first').children('label').addClass(errorClass);
	},
	unhighlight: function(element, errorClass) {
		$(element).removeClass(errorClass);
		$(element).parent().find('.errDom').remove();
		$(element).parents('li:first').children('label').removeClass(errorClass);
	}
});

function isIdCardNo(num) {
	var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2");
	var varArray = new Array();
	var intValue;
	var lngProduct = 0;
	var intCheckDigit;
	var intStrLen = num.length;
	var idNumber = num;
	// initialize
	if ((intStrLen != 15) && (intStrLen != 18)) {
		return false;
	}
	// check and set value
	for (i = 0; i < intStrLen; i++) {
		varArray[i] = idNumber.charAt(i);
		if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
			return false;
		} else if (i < 17) {
			varArray[i] = varArray[i] * factorArr[i];
		}
	}
	if (intStrLen == 18) {
		//check date
		var date8 = idNumber.substring(6, 14);
		if (isDate8(date8) == false) {
			return false;
		}
		// calculate the sum of the products
		for (i = 0; i < 17; i++) {
			lngProduct = lngProduct + varArray[i];
		}
		// calculate the check digit
		intCheckDigit = parityBit[lngProduct % 11];
		// check last digit
		if (varArray[17] != intCheckDigit) {
			return false;
		}
	} else { //length is 15
		//check date
		var date6 = idNumber.substring(6, 12);
		if (isDate6(date6) == false) {
			return false;
		}
	}
	return true;
}

/**
 * 判断是否为“YYYYMM”式的时期
 *
 */
function isDate6(sDate) {
	if (!/^[0-9]{6}$/.test(sDate)) {
		return false;
	}
	var year, month, day;
	year = sDate.substring(0, 4);
	month = sDate.substring(4, 6);
	if (year < 1700 || year > 2500) return false
	if (month < 1 || month > 12) return false
	return true
}
/**
 * 判断是否为“YYYYMMDD”式的时期
 *
 */
function isDate8(sDate) {
	if (!/^[0-9]{8}$/.test(sDate)) {
		return false;
	}
	var year, month, day;
	year = sDate.substring(0, 4);
	month = sDate.substring(4, 6);
	day = sDate.substring(6, 8);
	var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	if (year < 1700 || year > 2500) return false
	if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
	if (month < 1 || month > 12) return false
	if (day < 1 || day > iaMonthDays[month - 1]) return false
	return true
}

// 验证值小数位数不能超过decimalLength位
$.validator.addMethod("decimalLength", function(value, element, theLength) {
	var decimal = eval("/^-?\\d+(\\.\\d{1," + theLength + "})?$/");
	return this.optional(element) || (decimal.test(value));
}, "小数位数不能超过{0}位!");
$.validator.addMethod("mobile", function(value, element) {
	var length = value.length;
	return this.optional(element) || (length == 11);
}, "请输入正确的手机号码");
// 身份证号码验证 
$.validator.addMethod("idcardno", function(value, element) {
	return this.optional(element) || isIdCardNo(value);
}, "请输入正确的身份证号码");
// 非法脚本校验
$.validator.addMethod("jsValidate", function(value, element) { 
	    return this.optional(element) || !(/<script.*?>.*?<\/script>/ig).test(value);
}, "非法含有JS脚本完整标签");
//只能包括英文字母和数字 
jQuery.validator.addMethod("encharandnum", function(value, element) {
    return this.optional(element) || /[-_a-zA-Z0-9]$/.test(value);
}, "格式非法，只能包括英文字母、数字、分割符（-或_）");