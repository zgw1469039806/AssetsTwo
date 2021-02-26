/**
 *
 */
//保存前置事件
var beforeSaveFunction;

$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
    	if (this.name!=""&&this.name!=null&&this.name!=undefined){
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
    	}
    });
    var $radio = $('input[type=radio],input[type=checkbox]',this);
    $.each($radio,function(){
    	if (this.name!=""&&this.name!=null&&this.name!=undefined){
	        if(!o.hasOwnProperty(this.name)){
	            o[this.name] = '';
	        }
    	}
    });
    return o;
};

function isObjectValueEqual(a, b) {
	var aProps = Object.getOwnPropertyNames(a);
	var bProps = Object.getOwnPropertyNames(b);
	if (aProps.length != bProps.length) {
		return false;
	}
	for (var i = 0; i < aProps.length; i++) {
		var propName = aProps[i]

		var propA = a[propName]
		var propB = b[propName]
		if ((typeof (propA) === 'object')) {
			if (this.isObjectValueEqual(propA, propB)) {
				// return true     这里不能return ,后面的对象还没判断
			} else {
				return false
			}
		} else if (propA !== propB) {
			return false
		} else { }
	}
	return true
}


function getFormBox(domId,pageParams,id,formid,paralist){
	$.ajax({
		url: 'platform/eform/plugin/getFormBox/bootstrap/'+formid,
		type : 'post',
		dataType : 'json',
		data : {fk:'',pageParams:JSON.stringify(pageParams),businessId:id,paralist:paralist},
		async:false,
		success : function(r){
			if (r != null) {

				$("#"+domId).bind("initCustom",function(e,pageParams,beforeSaveEvent){
					$(this).html("");
					$(this).html(r.content);
					$(this).setform(r.data);
					$(this).find('table.datatable').each(function(){
						var tablename = $(this).attr("id");
						eval("window."+tablename+"_comid = r.comid");
					});
					eval(r.script);
				});
				var formBoxbeforeSaveEvent = {
					beforeSaveFunc:null,
					changeFormDataFunc:null,
					addBeforeSaveEvent:function(func){
						var oldFunc =this.beforeSaveFunc;
						if (typeof this.beforeSaveFunc != 'function'){
							this.beforeSaveFunc = func;
						}else{
							this.beforeSaveFunc = function(formData){
								var oldResult = oldFunc(formData);
								var result = func(formData);
								if(oldResult==false||result==false){
									return false;
								}
							}
						}
					},
					addChangeDataFun:function(func){
						var oldFunc =this.changeFormDataFunc;
						if (typeof this.changeFormDataFunc != 'function'){
							this.changeFormDataFunc = func;
						}else{
							this.changeFormDataFunc = function(formData){
								var oldResult = oldFunc(formData);
								var result = func(formData);
								if(oldResult==false||result==false){
									return false;
								}
							}
						}
					},
					exec:function(formData){
						if (typeof this.beforeSaveFunc == 'function')
							if(this.beforeSaveFunc(formData) == false)
								return false;
						return true;
					},
					changeData:function(formData){
						if (typeof this.changeFormDataFunc == 'function')
							if(this.changeFormDataFunc(formData) == false)
								return false;
						return true;
					}
				};

				$("#"+domId).bind("beforeSave",function(e,formData){
					if (!formBoxbeforeSaveEvent.exec(formData)) {
						return false;
					}
					return true;
				});

				$("#"+domId).bind("changeData",function(e,formData){
					formBoxbeforeSaveEvent.changeData(formData);
				});

				var param = r.pageParams;
				param.content = $("#"+domId);
				$("#"+domId).trigger("initCustom",[param,formBoxbeforeSaveEvent]);

			}
		}
	});
}

function setLinkagePara(value,linkageColumnid,pageParams,linkageResult) {
    $.ajax({
        url : 'platform/eform/linkage/getLinkageValue',
        async:false,
        dataType: 'json',
        data : {
            pageParams : pageParams,
            value : value,
            linkageResult : linkageResult
        },
        type : 'POST',
        success : function(result) {
            if (result.error){
                layer.alert(result.error, {
                    icon: 7,
                    area: ['400px', ''],
                    closeBtn: 0
                });
            }else{

                var optionHtml = "<option value=''>请选择</option>";
                for (var i=0;i<result.list.length;i++){
                    var key = result.list[i].lookupCode;
                    var value = result.list[i].lookupName;

                    optionHtml += "<option value='"+key+"'>"+value+"</option>";
                }
                jQuery("#"+linkageColumnid).empty().append(optionHtml);
            }

        }
    });
}


//当控件被联动控件绑定后，该控件变化时动态请求值并在页面修改联动控件的值
function setLinkageValue(value, linkageColumnid, linkageImpl, linkageResultType) {
	$.ajax({
		url: 'platform/eform/linkage/setLinkageValue',
		type: 'POST',
		data: {
			value: value,
			linkageColumnid: linkageColumnid,
			linkageImpl: linkageImpl,
			linkageResultType: linkageResultType
		},
		dataType: 'json',
        async: false,
		success: function (backData, status) {
			if(linkageResultType == "1") {
                var optionHtml = "<option value=''>请选择</option>";
				for(var i = 0; i < backData.length; i++) {
					var key = backData[i].key;
					var value = backData[i].value;

                    optionHtml += "<option value='"+key+"'>"+value+"</option>";
				}

                $("#" + linkageColumnid.toUpperCase()).empty().append(optionHtml).trigger("change");
			}
			if(linkageResultType == "2") {
				$("#" + linkageColumnid.toUpperCase()).val(backData);
			}
		}
	});
}



function setSubLinkagePara(value,pageParams,linkageResult) {
	var row1 = {};

		$.ajax({
	        url : 'platform/eform/linkage/getLinkageValue',
	        async:false,
	        dataType: 'json',
	        data : {
	            pageParams : pageParams,
	            value : value,
	            linkageResult : linkageResult
	        },
	        type : 'POST',
	        success : function(result) {
	            if (result.error){
	                layer.alert(result.error, {
	                    icon: 7,
	                    area: ['400px', ''],
	                    closeBtn: 0
	                });
	            }else{
	                for (var i=0;i<result.list.length;i++){
	                    var key = result.list[i].lookupCode;
	                    var value = result.list[i].lookupName;
	                    row1[key+""]= value+"";
	                    if(i==2){
	                    	break;
	                    }
	                }

	            }

	        }
	    });

    return row1;
}


function setSubLinkageImplPara(value,linkageColumnid, linkageImpl, linkageResultType) {
	var row1 = {};
	$.ajax({
		url: 'platform/eform/linkage/setLinkageValue',
		type: 'POST',
		data: {
			value: value,
			linkageColumnid: linkageColumnid,
			linkageImpl: linkageImpl,
			linkageResultType: linkageResultType
		},
		dataType: 'json',
        async: false,
		success: function (backData, status) {
			if(linkageResultType == "1") {
				for (var i=0;i<backData.length;i++){
                    var key = backData[i].key;
                    var value = backData[i].value;
                    row1[key+""]= value+"";
                    if(i==2){
                    	break;
                    }
                }
			}
			if(linkageResultType == "2") {
				row1[backData+""]= backData+"";
			}
		}
	});
    return row1;
}


function setLinkageParaEasyui(value,linkageColumnid,pageParams,linkageResult) {
    $.ajax({
        url : 'platform/eform/linkage/getLinkageValue',
        async:false,
        dataType: 'json',
        data : {
            pageParams : pageParams,
            value : value,
            linkageResult : linkageResult
        },
        type : 'POST',
        success : function(result) {
            if (result.error){
                layer.alert(result.error, {
                    icon: 7,
                    area: ['400px', ''],
                    closeBtn: 0
                });
            }else{
                jQuery("#"+linkageColumnid).combobox({
                    data:result.list,
                    valueField:'lookupCode',
                    textField:'lookupName'
                });

            }

        }
    });
}


//当控件被联动控件绑定后，该控件变化时动态请求值并在页面修改联动控件的值
function setLinkageValueEasyui(value, linkageColumnid, linkageImpl, linkageResultType) {
    $.ajax({
        url: 'platform/eform/linkage/setLinkageValue',
        type: 'POST',
        data: {
            value: value,
            linkageColumnid: linkageColumnid,
            linkageImpl: linkageImpl,
            linkageResultType: linkageResultType
        },
        dataType: 'json',
        async: false,
        success: function (backData, status) {
            if(linkageResultType == "1") {
                jQuery("#"+linkageColumnid).combobox({
                    data:backData,
                    valueField:'key',
                    textField:'value'
                });
            }
            if(linkageResultType == "2") {
                $("#" + linkageColumnid.toUpperCase()).val(backData);
            }
        }
    });
}




$.fn.setform = function (jsonValue, isChange) {
    var obj = this;
    $.each(jsonValue, function (name, ival) {
        var oinput = obj.find("input[name=" + name + "]");
        if (oinput.length>0){
	        if (oinput.attr("type") == "checkbox") {
	            if (ival !== null) {
	                var checkboxObj = $("[name=" + name + "]");
	                var checkArray = ival;
	                for (var i = 0; i < checkboxObj.length; i++) {
	             	   checkboxObj[i].checked = false;
	                    for (var j = 0; j < checkArray.length; j++) {
	                        if (checkboxObj[i].value == checkArray[j]) {
	                     	   checkboxObj[i].checked=true;
	                        }
	                    }
	                }
	            }
	        }else if (oinput.attr("type") == "radio") {
	            oinput.each(function () {
	                var radioObj = $("[name=" + name + "]");
	                for (var i = 0; i < radioObj.length; i++) {
	                    if (radioObj[i].value == ival) {
	                 	   radioObj[i].checked=true;
	                    }
	                }
	            });
	        }else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker"){
	     	   obj.find("[name=" + name + "]").datepicker("setDate", new Date(parseISO8601(ival)));

	        }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
	     	   obj.find("[name=" + name + "]").val(ival);
	        }else {
	            obj.find("[name=" + name + "]").val(ival);
	        }
        }else{
            //兼容联动控件
            if(obj.find("[name=" + name + "]").val() != ival) {
                if(isChange != undefined && isChange == false) {
                    obj.find("[name=" + name + "]").val(ival);
                } else {
                    obj.find("[name=" + name + "]").val(ival).trigger("change");
                }
            }
        }
        var textarea = obj.find("textarea[name=" + name + "]");
        if (textarea.length>0){
        	textarea.html(ival);
        }
    });
};


function parseISO8601(dateStringInRange) {
    var isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,
        date = new Date(NaN), month,
        parts = isoExp.exec(dateStringInRange);

    if(parts) {
        month = +parts[2];
        date.setFullYear(parts[1], month - 1, parts[3]);
        if(month != date.getMonth() + 1) {
            date.setTime(NaN);
        }
    }
    return date;
}


function isEmptyObject(e) {
	if (e === "")
		return !0;
    var t;
    for (t in e)
        return !1;
    return !0

}
function getPinyin(){
	var colLabel=$('#colLabel').val();
	$.post('platform/eform/cbbClient/getPinyin.json', {
		str : colLabel
		}, function(result){
			$('#colName').attr("value",result.content);
		}, 'json');
}
function transArray(arr1) {
	var arr2 = [];
	// 确定新数组有多少行
	var maxlen = 0;
	for (var ii=0;ii<arr1.length;ii++){
		if (arr1[ii].length>maxlen)
			maxlen = arr1[ii].length;
	}
	for (var i = 0; i < maxlen; i++) {
		arr2[i] = [];
	}
	// 遍历原数组
	for (var i = 0; i < arr1.length; i++) {
		for (var j = 0; j < arr1[i].length; j++) {
			if (arr1[i][j])
				arr2[j][i] = arr1[i][j];
		}
	}
	return arr2;
}

/*
function GenNonDuplicateID(randomLength){
	return Number(Math.random().toString().substr(3,randomLength) + Date.now().toString()).toString(36)
};
*/

function GenNonDuplicateID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}

beforeSaveEvent = {
		beforeSaveFunc:null,
	    changeFormDataFunc:null,
		addBeforeSaveEvent:function(func){
			var oldFunc =this.beforeSaveFunc;
			if (typeof this.beforeSaveFunc != 'function'){
				this.beforeSaveFunc = func;
			}else{
				this.beforeSaveFunc = function(formData){
					var oldResult = oldFunc(formData);
					var result = func(formData);
					if(oldResult==false||result==false){
						return false;
					}
				}
			}
		},
		addChangeDataFun:function(func){
			var oldFunc =this.changeFormDataFunc;
			if (typeof this.changeFormDataFunc != 'function'){
				this.changeFormDataFunc = func;
			}else{
				this.changeFormDataFunc = function(formData){
					var oldResult = oldFunc(formData);
					var result = func(formData);
					if(oldResult==false||result==false){
						return false;
					}
				}
			}
		},
		exec:function(formData){
			if (typeof this.beforeSaveFunc == 'function')
				if(this.beforeSaveFunc(formData) == false)
					return false;
			return true;
		},
		changeData:function(formData){
			if (typeof this.changeFormDataFunc == 'function')
				if(this.changeFormDataFunc(formData) == false)
					return false;
			return true;
		}
};

afterSaveEvent = {
		afterSaveFunc:null,
		addAfterSaveEvent:function(func){
			var oldFunc =this.afterSaveFunc;
			if (typeof this.afterSaveFunc != 'function'){
				this.afterSaveFunc = func;
			}else{
				this.afterSaveFunc = function(formData,rs){
					var oldResult = oldFunc(formData,rs);
					var result = func(formData,rs);
					if(oldResult==false||result==false){
						return false;
					}
				}
			}
		},
		exec:function(formData,rs){
			if (typeof this.afterSaveFunc == 'function')
				if(this.afterSaveFunc(formData,rs) == false)
					return false;
			return true;
		}
};

workflowControl = {
		controlFunc:null,
		addcontrolFunc:function(func){
			var oldFunc =this.controlFunc;
			if (typeof this.controlFunc != 'function'){
				this.controlFunc = func;
			}else{
				this.controlFunc = function(tagId, operability){
					var oldResult = oldFunc(tagId, operability);
					var result = func(tagId, operability);
					if(oldResult==false||result==false){
						return false;
					}
				}
			}
		},
		exec:function(tagId, operability){
			if (typeof this.controlFunc == 'function')
				if(this.controlFunc(tagId, operability) == false)
					return false;
			return true;
		}
};


workflowControlForAccess = {
    controlFunc:null,
    addcontrolFunc:function(func){
        var oldFunc =this.controlFunc;
        if (typeof this.controlFunc != 'function'){
            this.controlFunc = func;
        }else{
            this.controlFunc = function(tagId, operability){
                var oldResult = oldFunc(tagId, operability);
                var result = func(tagId, operability);
                if(oldResult==false||result==false){
                    return false;
                }
            }
        }
    },
    exec:function(tagId, operability){
        if (typeof this.controlFunc == 'function')
            if(this.controlFunc(tagId, operability) == false)
                return false;
        return true;
    }
};

workflowControlSubTableButtonForAccess = {
    controlFunc:null,
    addcontrolFunc:function(func){
        var oldFunc =this.controlFunc;
        if (typeof this.controlFunc != 'function'){
            this.controlFunc = func;
        }else{
            this.controlFunc = function(tagId, operability){
                var oldResult = oldFunc(tagId, operability);
                var result = func(tagId, operability);
                if(oldResult==false||result==false){
                    return false;
                }
            }
        }
    },
    exec:function(tagId, operability){
        if (typeof this.controlFunc == 'function')
            if(this.controlFunc(tagId, operability) == false)
                return false;
        return true;
    }
};

workflowControlForRequired = {
    controlFunc:null,
    addcontrolFunc:function(func){
        var oldFunc =this.controlFunc;
        if (typeof this.controlFunc != 'function'){
            this.controlFunc = func;
        }else{
            this.controlFunc = function(tagId, operability,obj){
                var oldResult = oldFunc(tagId, operability,obj);
                var result = func(tagId, operability,obj);
                if(oldResult==false||result==false){
                    return false;
                }
            }
        }
    },
    exec:function(tagId, operability,obj){
        if (typeof this.controlFunc == 'function')
            if(this.controlFunc(tagId, operability,obj) == false)
                return false;
        return true;
    }
};

workflowControlForAttachRequired = {
    controlFunc:null,
    addcontrolFunc:function(func){
        var oldFunc =this.controlFunc;
        if (typeof this.controlFunc != 'function'){
            this.controlFunc = func;
        }else{
            this.controlFunc = function(tagId, operability,obj){
                var oldResult = oldFunc(tagId, operability ,obj);
                var result = func(tagId, operability ,obj);
                if(oldResult==false||result==false){
                    return false;
                }
            }
        }
    },
    exec:function(tagId, operability,obj){
        if (typeof this.controlFunc == 'function')
            if(this.controlFunc(tagId, operability,obj) == false)
                return false;
        return true;
    }
};

function addBeforeSaveEvent(func){
	var oldFunc =beforeSaveFunction;
	if (typeof beforeSaveFunction != 'function'){
		beforeSaveFunction = func;
	}else{
		beforeSaveFunction = function(){
			oldFunc();
			func();
		}
	}
}

function chooseUserPhoto(recentPhotoId){
	if(document.getElementById("comId")==null){
		return false;
	}
	var eformID = document.getElementById("comId").value;
	layer.config({
		extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: true,
		move : true,
		area: ['500px', '200px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['上传', '取消'],
		content: $('#addUserPhotoDialog'),

		yes: function(index, layero){
			upLoadUserPhoto(recentPhotoId);
			document.getElementById("eform_add_photo").value ="";
			layer.close(index);
		},

		btn3: function(index, layero){
			document.getElementById("eform_add_photo").value ="";
			layer.close(index);
		}
	});
}

function chooseCrapPhoto(recentPhotoId,width,height){

	if(document.getElementById("comId")==null){
		return false;
	}

	var eformID = document.getElementById("comId").value;
	var para = 'recentPhotoId='+recentPhotoId+'&comId='+eformID;
	if (width!=null && width!='' && width!=undefined){
		para += '&width='+width+'&height='+height
	}
	layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	layer.open({
		type: 2,
		title: "图片上传",
		skin: 'bs-modal',
		maxmin: false,
		area: ['800px', '560px'],
		btn: ['上传', '取消'],
		content: 'avicit/platform6/eform/formdesign/js/plugins/photo-box/cropImage.jsp?'+para,

		yes: function(index, layero){
			var frm = layero.find('iframe')[0].contentWindow;
			frm.uploadCropImage();
		},

		btn3: function(index, layero){
			document.getElementById("eform_add_photo").value ="";
			layer.close(index);
		}
	});
}

function upLoadUserPhoto(recentPhotoId,fun){

if(document.getElementById("eform_add_photo").value != ''){

	if(checkfiletype('eform_add_photo')){
		$('#uploadForm').attr("action", "platform/eform/plugin/upPhoto?photoId="+recentPhotoId);
        $('#uploadForm').ajaxSubmit({
            type: 'POST',

            success:function(r){
            	if (typeof fun == "function"){
					fun();
				}else {
					document.getElementById(recentPhotoId).src = "platform/eform/plugin/getPhoto?photoId=" + recentPhotoId + "&eformId=" + document.getElementById("comId").value + "&tableId=''" + "&id=''&o=" + Math.random();
				}
            },
            dataType: 'json',
            error : function(xhr, status, err) {
				var error = $.parseJSON(xhr.responseText);
				layer.alert(error.message.split(":")[1]
					,{
						icon: 7,
						area: ['400px', ''], //宽高
						closeBtn: 0,
						title : '提示'
					}
				);

                document.getElementById(recentPhotoId).src="platform/eform/plugin/getPhoto?photoId="+recentPhotoId+"&eformId="+document.getElementById("comId").value+"&tableId=''"+"&id=''&o=" + Math.random();
            }
        });
	}else {
		layer.alert('上传文件的格式不正确!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  title : '提示'
				    }
		         );

		}

	}else{

		layer.alert('请选择要上传的图片文件!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  title : '提示'
				    }
		         );

	}

}

function chooseUserPhotoEasyUI(Id){
	if(document.getElementById("comId")==null){
		return false;
	}
	recentPhotoId = Id;
	$('#addUserPhotoDialog').dialog('open',true);
}

function upLoadUserPhotoEasyUI(){
	var eformID = document.getElementById("comId").value;
	if(document.getElementById("eform_add_photo").value != ''){
		if(checkfiletype('eform_add_photo')){
			$.messager.progress();	// 显示进度条
			$('#uploadForm').form('submit', {
				url: "platform/eform/plugin/upPhoto?photoId="+recentPhotoId,
				success: function(e){
					$.messager.progress('close');	// 如果提交成功则隐藏进度条
					$.messager.alert('提示','图片文件上传成功!','info',function(r){
						$('#addUserPhotoDialog').dialog('close',true);
						document.getElementById(recentPhotoId).src="platform/eform/plugin/getPhoto?photoId="+recentPhotoId+"&eformId="+eformID+"&tableId=''"+"&id=''&o=" + Math.random();
					});
				}
			});

		}else{
			 $.messager.alert('提示','上传文件的格式不正确!','warning');
		}
	}else{
		$.messager.alert('提示','请选择要上传的图片文件!','warning');         
	}	
}
//关闭用户图片上传框
function closeUpLoadUserPhotoEasyUI(){
	 $('#addUserPhotoDialog').dialog('close',true);
}

function checkfiletype(id){
var fileName = document.getElementById(id).value;
//设置文件类型数组
var extArray =[".jpg",".png",".gif",".bmp"];
	//获取文件名称
	while (fileName.indexOf("//") != -1)
	fileName = fileName.slice(fileName.indexOf("//") + 1);
   	//获取文件扩展名
   	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
		//遍历文件类型
   	var count = extArray.length;
		for (;count--;){
 		if (extArray[count] == ext){
   			return true;
 		}
		}

return false;
}


Array.prototype.clone=function(){ var a=[]; for(var i=0,l=this.length;i<l;i++) a.push(this[i]); return a; };

/**
 * 身份证号码验证
 * @param num
 * @returns {boolean}
 */
function isIdCard(num) {
    // if (isNaN(num)) {alert("输入的不是数字！"); return false;}
    var len = num.length, re;
    if (len == 15)
        re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
    else if (len == 18)
        re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
    else {
        // alert("输入的数字位数不对。");
        return false;
    }
    var a = num.match(re);
    if (a != null) {
        if (len == 15) {
            var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
            var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4]
                && D.getDate() == a[5];
        } else {
            var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
            var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4]
                && D.getDate() == a[5];
        }
        if (!B) {
            // alert("输入的身份证号 "+ a[0] +" 里出生日期不对。");
            return false;
        }
    }
    if (!re.test(num)) {
        // alert("身份证最后一位只能是数字和字母。");
        return false;
    }
    return true;
}

function loadScriptTag(url){
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = url;
	document.getElementsByTagName("head")[0].appendChild(script);
}

function loadLinkTag(url){
	var link = document.createElement("link");
	link.type = "text/css";
	link.rel = "stylesheet";
	link.href = url;
	document.getElementsByTagName("head")[0].appendChild(link);
}

Number.prototype.toFixed=function (d) {
    var s=this+"";
    if(!d)d=0;
    if(s.indexOf(".")==-1)s+=".";
    s+=new Array(d+1).join("0");
    if(new RegExp("^(-|\\+)?(\\d+(\\.\\d{0,"+(d+1)+"})?)\\d*$").test(s)){
        var s="0"+RegExp.$2,pm=RegExp.$1,a=RegExp.$3.length,b=true;
        if(a==d+2){
            a=s.match(/\d/g);
            if(parseInt(a[a.length-1])>4){
                for(var i=a.length-2;i>=0;i--){
                    a[i]=parseInt(a[i])+1;
                    if(a[i]==10){
                        a[i]=0;
                        b=i!=1;
                    }else break;
                }
            }
            s=a.join("").replace(new RegExp("(\\d+)(\\d{"+d+"})\\d$"),"$1.$2");

        }if(b)s=s.substr(1);
        return (pm+s).replace(/\.$/,"");
    }return this+"";

};

function getUrlParam(url){
	var urlParam = {};
	if (url.split("?").length>1) {
		var paramArray = url.split("?")[1].split("&");

		for (var i = 0; i < paramArray.length; i++) {
			var arrayValue = paramArray[i].split("=");
			urlParam[arrayValue[0]] = arrayValue[1];
		}
	}
	return urlParam;
}

/**
 * 子表字段jqgird行编辑格式校验
 * @param num
 * @returns {boolean}
 */
subFormatValidate = function(value,name,vl,type){
    if(type=="email"){
        var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
        if(!reg.test(value)){
            return [false, "请输入正确邮箱地址"];
        }else{
            return [true, ""];
        }
    }
    else if(type=="phone"){
        var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
        if(!reg.test(value)){
            return [false, "请输入正确手机号"];
        }else{
            return [true, ""];
        }
    }
    else if(type=="idcard"){
        var len = value.length, re;
        if (len == 15)
            re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
        else if (len == 18)
            re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
        else {
            return [false, "输入的数字位数不对。"];
        }
        var a = value.match(re);
        if (a != null) {
            if (len == 15) {
                var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
                var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4]
                    && D.getDate() == a[5];
            } else {
                var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
                var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4]
                    && D.getDate() == a[5];
            }
            if (!B) {
                return [false, "输入的身份证号 "+ a[0] +" 里出生日期不对。"];
            }
        }
        if (!re.test(value)) {
            return [false, "身份证最后一位只能是数字和字母。"];
        }
		return [true, ""];
    }
    else if(type=="zipcode"){
        reg = /^\d{6}$/;
        if(!reg.test(value)){
            return [false, "请输入正确邮编地址"];
        }else{
            return [true, ""];
        }
    }
}


if (!Array.prototype.forEach) {
	Array.prototype.forEach = function(callback/*, thisArg*/) {
		var T, k;
		if (this == null) {
			throw new TypeError('this is null or not defined');
		}
		// 1. Let O be the result of calling toObject() passing the
		// |this| value as the argument.
		var O = Object(this);
		// 2. Let lenValue be the result of calling the Get() internal
		// method of O with the argument "length".
		// 3. Let len be toUint32(lenValue).
		var len = O.length >>> 0;
		// 4. If isCallable(callback) is false, throw a TypeError exception.
		// See: http://es5.github.com/#x9.11
		if (typeof callback !== 'function') {
			throw new TypeError(callback + ' is not a function');
		}
		// 5. If thisArg was supplied, let T be thisArg; else let
		// T be undefined.
		if (arguments.length > 1) {
			T = arguments[1];
		}
		// 6. Let k be 0.
		k = 0;
		// 7. Repeat while k < len.
		while (k < len) {
			var kValue;

			// a. Let Pk be ToString(k).
			//    This is implicit for LHS operands of the in operator.
			// b. Let kPresent be the result of calling the HasProperty
			//    internal method of O with argument Pk.
			//    This step can be combined with c.
			// c. If kPresent is true, then
			if (k in O) {
				// i. Let kValue be the result of calling the Get internal
				// method of O with argument Pk.
				kValue = O[k];
				// ii. Call the Call internal method of callback with T as
				// the this value and argument list containing kValue, k, and O.
				callback.call(T, kValue, k, O);
			}
			// d. Increase k by 1.
			k++;
		}
		// 8. return undefined.
	};
}