/**
 * 
 */
CustomDialog = function(colName,url){
	this._colName = colName;
	this._url = url;
}

CustomDialog.prototype.init = function(){
	var _self = this;
	var input = $("[name='"+this._colName+"Name']").addClass("easyui-validatebox validatebox-text selector-div-input");
	var hiddenInput = $("[name='"+this._colName+"']")
	var div = $('<div/>').addClass("selector-div selector-div-bg");
	//div.append('<input class="easyui-validatebox validatebox-text selector-div-input" name="'+this._colName+'Cname" id="'+this._colName+'Cname" readonly="readOnly">');
	input.wrap(div);
	var img = $('<span/>').addClass("input-right-icon");
	if (hiddenInput.attr("disabled") != "disabled"){
		img.click(function(){
			openCustomDialog(_self._colName,_self._url);
		});
	}
	input.after(img);
	//$("[name='"+colName+"']").after(div);
}

CustomDialog.prototype.initAutoCode = function(){
	var _self = this;
	var input = $("[name='"+this._colName+"']").addClass("easyui-validatebox validatebox-text selector-div-input");
	var div = $('<div/>').addClass("selector-div selector-div-bg");
	input.wrap(div);
	var img = $('<span/>').addClass("input-right-icon");
	if (input.attr("disabled") != "disabled"){
		img.click(function(){
			autoCode(_self._colName,_self._url);
		});
	}
	input.after(img);
}

function autoCode(colName,url){
	if (url){
		$.messager.confirm('请确认', '是否自动生成编码？', function(b) {
			if(b){
				 $.ajax({
					 url:"platform/eform/cbbCRUDClient/getAutoCode",
					 data:	{url:url},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 $("[name='"+colName+"']").val(r.code);
					 }
				 });
			}
		});
	}else{
		$.messager.alert('提示',"请先配置自动编码服务!",'warning');
		return;
	}
}

function openCustomDialog(colName,url,callBack,ynMax,width,height){
	var diaId = colName+"_dialog";
	var backValue = $("#"+colName).val();
	if (backValue){
		url = url + "?backValue=" + backValue;
	}
	var isMaximized = true;
    if(ynMax == "max"){
    	isMaximized = true;
    }else if(ynMax == "setting"){
    	isMaximized = false;
    }
	var dialog = new CommonDialog(diaId,width,height,url,"选择页","","","","",isMaximized);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		handler:function(){
			 var frmId = $('#'+diaId+' iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 var jsonData = {};
			 if (typeof(frm.commitData) === 'function'){
				 jsonData = frm.commitData();
				 if(typeof(callBack) === 'function'){
	                 callBack(jsonData);
	              }
				 if (jsonData){
					 if (jsonData.hasOwnProperty("name") && jsonData.hasOwnProperty("value")){
						 $("#"+colName).val(jsonData.value);
						 $("#"+colName+"Name").val(jsonData.name);
					 }else{
						 $.messager.alert('提示',"弹出页返回参数错误！",'error');
						 return;
					 }
				 }else{
					 $.messager.alert('提示',"弹出页返回值为null！",'error');
					 return;
				 }
			 }else{
				 $.messager.alert('提示',"提交方法名称错误！",'error');
				 return;
			 }
			 dialog.close();
		}
	}];
	dialog.createButtonsInDialog(buttons);
	dialog.show();
}

function openCustomDialogLayer(colName,url,callBack,ynMax,width,height){
    var backValue = $("#"+colName).val();
    if (backValue){
        url = url + "?backValue=" + backValue;
    }

    var ar = ['50%', '50%'];
    if(ynMax == "max"){
    	ar = ['100%', '100%'];
    }else if(ynMax == "setting"){
    	ar = [width,height];
    }
    selectDialog = top.layer.open({
        type: 2,
        title: '选择页',
        skin: 'bs-modal',
        area: ar,
        maxmin: false,
        content: url,
        btn: ['确定','取消'],
        yes: function(index, layero){
            var frm = layero.find('iframe')[0].contentWindow;
            var jsonData = {};
            if (typeof(frm.commitData) === 'function'){
                jsonData = frm.commitData();
                if(typeof(callBack) === 'function'){
                    callBack(jsonData);
                }
                if (jsonData){
                    if (jsonData.hasOwnProperty("name") && jsonData.hasOwnProperty("value")){
                        $("#"+colName).val(jsonData.value);
                        $("#"+colName+"Name").val(jsonData.name);
                    }else{
                    	top.layer.alert('弹出页返回参数错误！' , {
        					icon: 2,
        					area: ['400px', ''],
        					closeBtn: 0
        				});
                        return;
                    }
                }else{
                	top.layer.alert('弹出页返回值为null！' , {
    					icon: 2,
    					area: ['400px', ''],
    					closeBtn: 0
    				});
                    return;
                }
            }else{
            	top.layer.alert('提交方法名称错误！' , {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
                return;
            }

            top.layer.close(index);
        },
        no: function(index, layero){
        	layero.close(index);
        }
    });
}


function getCustomNameByValue(value){
	if (value){
		$.ajax({
			url : 'platform/cc/sysuser/toSaveUser/1',
			data : {
				value : value
			},
			type : 'post',
			dataType : 'json',
			success : function(result) {
				if (result.flag == "success") {
					return result.value;
				}else {
					return "";
				}
			}
		});
	}else{
		return "";
	}
}