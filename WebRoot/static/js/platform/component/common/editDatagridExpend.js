/**
 * 可编辑表格扩展文件（仅页面应用可编辑表格的时候，应用该扩展）
 */

/**
 * 可编辑表格扩展全局字段
 */
$.extend($.fn.datagrid.options,{
	editingField:undefined,  // 当前单元格字段
	colediting:undefined,   //当前行
	popWindowCount:'0',
	popWindowCallback:undefined,
	insertRowFlag:undefined, //添加标识
	columnArray:[]  //datagrid列字段数组
   
});
/**
 * 可编辑表格扩展全局方法
 */
$.extend($.fn.datagrid.methods, {
	editCell : function(jq, param) { //点击单元格事件
		return jq.each(function() {
			var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
			for ( var i = 0; i < fields.length; i++) {
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (!(fields[i] == param.field || fields[i] == param.field+ "Alias")) {
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
			for ( var i = 0; i < fields.length; i++) {
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	},endEditing :function(gridId) { //是否结束单元格编辑
		if ($(gridId).datagrid("options").colediting == undefined ) {
		  return true;
	    }
		if($(gridId).datagrid('validateRow', $(gridId).datagrid("options").colediting)){
			$(gridId).datagrid('endEdit', $(gridId).datagrid("options").colediting);
			return true;
		}else{
			return false;
		}
		
	}, defaultClickCellEvent : function(target) { //默认点击单元格事件
		var gridId = target.gridId;
		var index = target.index;
		var field = target.field;
		if ($(gridId).datagrid("options").colediting == undefined) { //第一次点击的单元格
			$(gridId).datagrid("options").colediting = index;
			$(gridId).datagrid("options").editingField = field;
		} else{
			$(gridId).datagrid('endEdit', $(gridId).datagrid("options").colediting); //结束当前行的编辑
			$(gridId).datagrid('editCell', {
				index : $(gridId).datagrid("options").colediting,
				field : $(gridId).datagrid("options").editingField.replace("Alias", "")
			});
			$(gridId).datagrid('unselectAll').datagrid('selectRow',$(gridId).datagrid("options").colediting);
			
			var editorAlias = $(gridId).datagrid('getEditor', {
				index : $(gridId).datagrid("options").colediting,
				field : $(gridId).datagrid("options").editingField
			});
			if(editorAlias == undefined){
				return false;
			}
			var editorValue = $(gridId).datagrid('getEditor', {
				index : $(gridId).datagrid("options").colediting,
				field : $(gridId).datagrid("options").editingField.replace("Alias", "")
			});
			if ($(gridId).datagrid("options").colediting == index) {//如果同一行的话，将行号，单元格字段给了colediting（行号），editingField（字段）
				$(gridId).datagrid("options").colediting = index;
				$(gridId).datagrid("options").editingField = field;
			} else {
				$(gridId).datagrid("options").editingField = field;
			}
		}
		if (this.endEditing(gridId)) {  //打开下一个编辑单元格
			$(gridId).datagrid('editCell', {
				index : index,
				field : field.replace("Alias", "")
			});
			var editorAlias = $(gridId).datagrid('getEditor', {
				index : index,
				field : field
			});
			if(editorAlias == undefined){
				return false;
			}
			var editorValue = $(gridId).datagrid('getEditor', {
				index : index,
				field : field.replace("Alias", "")
			});
			this.controlTypeSelect(gridId, editorAlias, editorValue);
			$(gridId).datagrid("options").colediting = index;
		}
	},controlTypeSelect: function(gridId, editorAlias,editorValue) { //打开对应控件对应的编辑器
		if (editorAlias.type == null) {
			return false;
		}
		if (editorAlias.type === "validatebox" || editorAlias.type === "numberbox" || editorAlias.type === "textbox" || editorAlias.type === "textarea") {
			$(editorAlias.target).select(); 
			$(editorAlias.target).focus();
		}else if (editorAlias.type === "datebox" || editorAlias.type === "datetimebox") {	
			$(editorAlias.target).datebox("showPanel");
		}else if (editorAlias.type === "combobox") {
			var fieldOption = $(gridId).datagrid('getColumnOption', $(gridId).datagrid("options").editingField);
			if (fieldOption.editor.options.isPopWindow === true) { //checkbox扩展属性 isPopWindow、lookUpType
				var target = {text:editorAlias,value:editorValue};
				if((fieldOption.editor.options.lookUpType)){
					var exp = this.openPopWindow(gridId, fieldOption.editor.options.lookUpType,target);
				}else{
					var exp = this.openPopWindow(gridId, null,target);
				}
				$(exp).appendTo($(editorAlias.target).combo('panel'));
				$(editorAlias.target).combo('showPanel');
			} else{  //radio,通用代码扩展属性lookUpType，也就是通用代码字符串

                if(fieldOption.editor.options.isLookUpCode=='1'?false:true){
                    Platform6.fn.lookup.getLookupType(fieldOption.editor.options.lookUpType,function(r){
                        if(r!=null && r!="" && r!="null"){
                            $(editorAlias.target).combobox('loadData', r);
                            $(editorAlias.target).combo('showPanel');
                        }
                    },true);
                }else{
                	var r = fieldOption.editor.options.data;
                	$(editorAlias.target).combobox('loadData', r);
                    $(editorAlias.target).combo('showPanel');
                }

			}
		} else if (editorAlias.type === "CommonSelector") {
			editorAlias.target.click();
		} else if(editorAlias.type === "SingleChecboxSelector"){
			editorAlias.target.click();
		}
	}, openPopWindow: function(gridId, lookupCode, target){//打开checkbox组panel
		$(gridId).datagrid('options').popWindowCallback = function callBackComboSetValue(retobj){ //checkbox组值回填
			var fieldOption = $(gridId).datagrid('getColumnOption', $(gridId).datagrid("options").editingField);
			if(fieldOption.editor.options.callback != undefined){
				fieldOption.editor.options.callback(target, retobj);
			}else{
		 		$(target.text.target).combobox('setValue', retobj.text);
		 		$(target.value.target).val(retobj.value);
		 		$(target.text.target).combobox('hidePanel');
		 		target.text.target.parent().find('input.combo-text').focus(); //获取checkbox焦点
			}
		};
		var checkvalues = $(target.value.target).val();
		return '<iframe id="if" src="avicit/platform6/component/common/comboxselect.jsp?gridId='+gridId.replace("#","")+'&lookupCode='+lookupCode+'&checkvalues=' + checkvalues + '" style="border:0;width:98%;height:98%"></iframe>';
	},initTabKeyColumns:function(gridId){ // 获取datagrid所有列字段
		var dgColumn = $(gridId).find('[data-column="true"]'); 
		var columnArray = [];
		$.each(dgColumn, function(i, item) {
			columnArray.push($(item).data('options').split(",")[0].split("'")[1]);
		});
		$(gridId).datagrid("options").columnArray=columnArray;
	},tabKeyUpEvent:function(keyUpObj){ //键盘事件 
		var event = keyUpObj.event;
		var gridId = keyUpObj.gridId;
		if(event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40){
			if ($(gridId).datagrid("options").popWindowCount == 0 && $(gridId).datagrid('validateRow', $(gridId).datagrid("options").colediting)) {//tab键切换，popWindowCount控制选人，选部门，选群组，选岗位，选角色框的数量
				var columnArray = $(gridId).datagrid("options").columnArray;
				var row = $(gridId).datagrid("options").colediting; //当前行
				var lastField = $(gridId).datagrid("options").editingField; //当前字段
				var lastFieldNum = $.inArray(lastField, columnArray); 
				var columnCount = columnArray.length; //总列数
				if(event.keyCode == 9){ //tab键
					var nextColumn = lastFieldNum + 1;
					if(nextColumn > columnCount - 1){//同行内tab切换
						row = row + 1;
						if(row >= $(gridId).datagrid('getRows').length){ //tab切换到最后一行数据的情况，返回第一行第一个字段
							row = 0;
						}
						nextColumn = 0;
					}
				}
				if(event.keyCode == 37){ //左
					var nextColumn = lastFieldNum - 1;
					if(nextColumn < 0){
						nextColumn = columnCount - 1;
					}
				}
				if(event.keyCode == 38){ //上
					row = row - 1;
					var nextColumn = lastFieldNum;
					if(row < 0){ 
						row = $(gridId).datagrid('getRows').length-1;
					}
				}
				if(event.keyCode == 39){ //右
					var nextColumn = lastFieldNum + 1;
					if(nextColumn > columnCount - 1){
						nextColumn = 0;
					}
				}
				if(event.keyCode == 40){ //下
					row = row + 1;
					var nextColumn = lastFieldNum;
					if(row >= $(gridId).datagrid('getRows').length){ //tab切换到最后一行数据的情况，返回第一行第一个字段
						row = 0;
					}
				}
				var nextEditField = columnArray[nextColumn];
				this.defaultClickCellEvent({gridId:gridId, index:row, field:nextEditField});
			}
		}
		
	}, roleConcatOper: function(array){ //多角色回填，array为角色数组
		 var concatNameStr="";  //角色名称
		 var concatIdStr="";   //角色ID
		 for(var i = 0;i < array.length; i++){
			 concatNameStr += array[i]["roleName"];
			 concatIdStr += array[i]["id"];
			 if(i<array.length-1){
				 concatNameStr += ",";
				 concatIdStr += ",";
			 }
		 }
		 return {concatNameStr: concatNameStr, concatIdStr:concatIdStr};
	}
});

$.extend($.fn.validatebox.defaults.rules, {
	maxLength : {
		validator : function(value, param) { //长度验证
			if (param[0] == 0) {
				param[0] = 13;
			}
			return param[0] >= value.replace(/[^\x00-\xff]/g, "**").length; // 计算字符串长度（可同时字母和汉，字母占一个字符，汉字占两个字符）
		},
		message : '请输入最多 {0} 字符.'
	},
	extendsIsNull : {
		validator : function(value) { //非空验证
			return value == null || value != "请选择" || value == "undifined";
		},
		message : '该输入项为必输项.'
	},
	numbervalid : {
		validator : function(value,param) { 
			if(param[0] >= value.length){
				if(param[1]){
					if(/^(([1-9]+\d*)|([1-9]+\d*\.\d{0,3}))$/.test(value)){//0-3位小数的数值型数据验证
						return true;
					}else{
						return false;
					}	
				}else{
					if(/^\d*$/.test(value)){//整型数据验证
						return true;
					}else{
						return false;
					}
				}
				
			}else{
				return false;
			}
		},
		message : '请输入正确的数值格式'
	}
});

//单选“是否”编辑器扩展
$.extend($.fn.datagrid.defaults.editors, {   
    SingleChecboxSelector: {   
        init: function(container, options){ 
		   var singlecheckbox = $('<input class="CommCheckboxSelector" type="checkbox">').appendTo(container);
		   return singlecheckbox;
        }, 
        getValue: function(target){  
        	return  $(target).prop('checked') ? '1' : '0';
        },   
        setValue: function(target, value){
        	if(value == '1'){
        		$(target[0]).attr('checked',true);
        	}else if(value == '0'){
        		$(target[0]).attr('checked',false);
        	}	
        }          
     }
});

//单选“是否”选择状态显示格式化
function formatIsNullState(value,row,index){
	if(value == '1'){//选中
  	 return '<input type="checkbox" checked>';
    }else if(value == '0'){//非选中
  	 return '<input type="checkbox">';
    }
}

