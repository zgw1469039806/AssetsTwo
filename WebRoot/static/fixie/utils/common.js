$(function(){
	setTimeout(function(){
		inputPlaceHolder();
	},1000);
});
var rCRLF = /\r?\n/g,
	manipulation_rcheckableType = /^(?:checkbox|radio)$/i,
	rsubmitterTypes = /^(?:submit|button|image|reset|file)$/i,
	rsubmittable = /^(?:input|select|textarea|keygen)/i;
jQuery.fn.extend({
	serializeArrayCustom: function(escape,filtertype) {
		return this.map(function(){
			// Can add propHook for "elements" to filter or add form elements
			var elements = jQuery.prop( this, "elements" );
			return elements ? jQuery.makeArray( elements ) : this;
		})
		.filter(function(){
            var type = this.type;
            filtertype = filtertype||"escape";
            // unUse .is(":disabled")
            var flag = true;
            if (escape){
                if (filtertype == "escape") {
                    if (jQuery(this).parents(escape) && jQuery(this).parents(escape).length > 0) {
                        flag = false;
                    }
                }else if (filtertype == "accept"){
                    if (jQuery(this).parents(escape).length == 0) {
                        flag = false;
                    }
                }
            }
			return this.name &&flag&&
				rsubmittable.test( this.nodeName )
				&& !rsubmitterTypes.test( type )
				&& ( this.checked || !manipulation_rcheckableType.test( type ) || (this.getAttribute('avicrequired') && (!this.checked || !manipulation_rcheckableType.test( type ))));
		})
		.map(function( i, elem ){
			var val = jQuery( this ).val();

			if(this.getAttribute('avicrequired') && manipulation_rcheckableType.test( this.type ) && !this.checked){
				val = "";
			}
			return val == null ?
				null :
				jQuery.isArray( val ) ?
					jQuery.map( val, function( val ){
						return { name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
					}) :
					{ name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
		}).get();
	}
});
/**
 * easyUI长度校验和非空检验
 */
$.extend($.fn.validatebox.defaults.rules, {
	maxLength : {
		validator : function(value, param) {
			if (param[0] == 0) {
				param[0] = 13;
			}
			return param[0] >= value.replace(/[^\x00-\xff]/g, "**").length; //计算字符串长度（可同时字母和汉，字母占一个字符，汉字占两个字符）
		},
		message : '请输入最多 {0} 字符.'
	},
	extendsIsNull : {
		validator : function(value) {
			return value != "请选择";
		},
		message : '该输入项为必输项.'
	}
});
/**
 * 表单序列化
 * 例 ：JSON.stringify(serializeObject($('#form'))) 格式化为 JSON字符串
 *
 * @param b
 * @param a
 * @param escape 逃逸选择器
 * @param filtertype 过滤类型 作用于escape参数 ‘escape’逃逸类型 ‘accept’接受类型
 * @returns JSON对象
 */
function serializeObject(b, a,escape,filtertype) {
		var c = {};
		$.each(b.serializeArrayCustom(escape,filtertype), function(d) {
			if (typeof (a) == "undefined" || (a != null && a == false)) {
				if (c[this["name"]]) {
					c[this["name"]] = c[this["name"]] + "," + $.trim(this["value"]);
				} else {
					c[this["name"]] = $.trim(this["value"]);
				}
			} else {
				if (this["value"].trim() != null && this["value"].trim() != "") {
					if (c[this["name"]]) {
						c[this["name"]] = c[this["name"]] + "," + $.trim(this["value"]);
					} else {
						c[this["name"]] = $.trim(this["value"]);
					}
				}
			}
		});
		return c;
};
var dataOptions = {
	pageSize : 15,
	pageList : [ 10, 15, 30, 50, 100 ]
};

function comboboxOnShowPanel() {
	var a = $(this).combobox("textbox").parent().outerWidth(true);
	$(this).combobox("panel").panel("resize", {
		width : a
	})
}

Date.prototype.format = function(b) {
	var c = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		S : this.getMilliseconds()
	};
	if (/(y+)/.test(b)) {
		b = b.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length))
	}
	for ( var a in c) {
		if (new RegExp("(" + a + ")").test(b)) {
			b = b.replace(RegExp.$1, RegExp.$1.length == 1 ? c[a]
					: ("00" + c[a]).substr(("" + c[a]).length))
		}
	}
	return b
};
String.prototype.getLens = function() {
	var a = 0;
	for (var b = 0; b < this.length; b++) {
		if (this[b].match(/[^\x00-\xff]/ig) != null) {
			a += 2
		} else {
			a += 1
		}
	}
	return a
};

function parserColumnDate(b) {
	var a = Date.parse(b);
	if (!isNaN(a)) {
		return new Date(a)
	} else {
		return new Date()
	}
}
function parserColumnTime(b) {
	var a = Date.parse(b);
	if (!isNaN(a)) {
		return new Date(a)
	} else {
		var c = parseDate(b);
		if (c instanceof Date) {
			return c
		} else {
			return new Date()
		}
	}
}
/**
 * 清空高级查询中的表单
 * 
 * @param formId
 */
function clearFormData(formId){
	$(formId).find('input[type=text]').val('');
	$(formId).find('select').val('');
	$(formId).find('input[type=hidden][name !=bpmState]').val('')// 不能清除name = bpmState 的流程条件
	$(formId).find('textarea').val('');//对 textarea中内容进行清除
	$(formId).find("input[type=checkbox]").attr("checked",false);//对 checkbox中内容进行清除
	$(formId).find("input[type=radio]").attr("checked",false);//对 radio中内容进行清除
	$(formId).find('.easyui-validatebox.validatebox-text').val('');//专门针对新选择控件处理
	//解决IE下清空选人、选部门placeholder
	$.each($(formId).find('input[type=text][name$=Alias]'),function(i,item){
		$(item).val($(item).attr('placeholder'));
	});	
};

/**
 * 详细页面表单元素禁用
 * 
 * @param formId
 */
function setFormDisabled(){
	   //select的禁用方法
	   $("select").attr("disabled","disabled");
	   //input的禁用方法
	   $('input').attr("disabled","disabled");
	   //radio的禁用
	   var input = $("input:radio");
	   input.attr("disabled","disabled");
	   //checkbox的禁用
	   var checkbox = $("input:checkbox");
	   checkbox.attr("disabled","disabled");
}

/**
 * IE下placeHolder问题
 */
function inputPlaceHolder(){
	supportPlaceholder='placeholder'in document.createElement('input');

    placeholder=function(input){
         var text = input.attr('placeholder');
         defaultValue = input.defaultValue;
         var content = input.val(); //是否有值
        if(content ==""){
        	if(!defaultValue){

               input.val(text).addClass("phcolor");
             }
        }

        input.focus(function(){

                if(input.val() == text){

               $(this).val("");
                }
        })


        input.blur(function(){

                if(input.val() == ""){
    
                    $(this).val(text).addClass("phcolor");
                }
        });

        //输入的字符不为灰色
        input.keydown(function(){

                $(this).removeClass("phcolor");
        })
    }

    //当浏览器不支持placeholder属性时，调用placeholder函数
    if(!supportPlaceholder){
               $('input').each(function(){
                text = $(this).attr("placeholder");
    
                if($(this).attr("type") == "text"){
    
                    placeholder($(this));
                }
            })
   }
}


function commonExecte(){
	$(".ext-input-right-icon").on('click', function(e) {
	   $(this).parent().find(".ext-selector-input").triggerHandler('click');
   });
}


function getPath() {
	var b = $("base").attr("href");
	if (typeof (b) != "undefined" && b != "") {
		if (b.indexOf("http") == 0 || b.indexOf("https") == 0) {
			if (b.indexOf("//") > -1) {
				var e = b.indexOf("/", b.indexOf("//") + 2);
				var d = b.substring(e);
				if (d == "/") {
					d = ""
				}
				if (d != "") {
					return d
				}
			}
		}
	}
	if ("undefined" != typeof baseurl && baseurl != null) {
		return baseurl
	}
	var f = window.location.pathname;
	var c = f.indexOf("/", 1);
	a = f.substr(0, c);
	if (a == "/") {
		a = ""
	}
	return a
}
function getPath2() {
	var a = getPath();
	if (a.charAt(a.length - 1) == "/") {
		a = a.substring(0, a.length - 1)
	}
	return a
}