var userDefineColumnFieldsOptions;//列集合
var userDefinePathName = window.location.pathname;
if(null != userDefinePathName && undefined != userDefinePathName && "" != userDefinePathName){
	userDefinePathName = userDefinePathName.substring(1);
	userDefinePathName = userDefinePathName.substring(userDefinePathName.indexOf("/")+1, userDefinePathName.length);
} else {
	userDefinePathName = "";
}

//扩展属性,注册表格右上角点击事件
$.extend($.fn.datagrid.defaults.view, {
	onAfterRender: function(target){
		var opts = $.data(target, 'datagrid').options;
		if (opts.showFooter){
			var footer = $(target).datagrid('getPanel').find('div.datagrid-footer');
			footer.find('div.datagrid-cell-rownumber,div.datagrid-cell-check').css('visibility', 'hidden');
		}
		addLeftHeaderClickEvent(target.id);
	}
});

/**
 * 打开配置页面
 */
function userDefineColumn(tableId,width,height,title) {
	width = width || "550";
	height = height || "350";
	title = title || "自定义显示列";
	userDefineColumnFieldsOptions = getGridAllColumnFieldsOptions(tableId);
	var url = "avicit/platform6/modules/system/commonpopup/userDefinedColumn.jsp?dialogId=userDefineColumnDialog&tableId=" + tableId;
	var usd = new CommonDialog("userDefineColumnDialog", "550", "350",url, title, true, true, false);
	usd.show();
}

/**
 * 修改table
 */
function editTable(columnArray,tableId){
	var oringinFitColumn = $("#" + tableId).datagrid("options").fitColumns;
	for (var i = 0; i < columnArray.length; i++) {
		var columnField = columnArray[i].columnField;
		var columnShow = columnArray[i].columnShow;
		var columnWidth = columnArray[i].columnWidth;
		var innerOrder = columnArray[i].innerOrder;
		// 显隐
		$("#" + tableId).datagrid("fitColumns", false);
		$("#" + tableId).datagrid("options").fitColumns = false;
		if(columnShow){
			$("#" + tableId).datagrid('showColumn', columnField);
		}else{
			$("#" + tableId).datagrid('hideColumn', columnField);
		}
		// 宽度
		var col =  $("#" + tableId).datagrid("getColumnOption",columnField);
		col.width = parseInt(columnWidth);
		col.boxWidth = parseInt(columnWidth);
		col.auto = undefined;
		col.innerOrder = innerOrder;
		$("#" + tableId).datagrid('fixColumnSize', columnField);
	}
	if(columnArray.length > 0){
		if(oringinFitColumn){
			$("#" + tableId).datagrid("options").fitColumns = true;
			$("#" + tableId).datagrid('fitColumns');
		}
	}
	saveUserdefinedColumnInfo(tableId);
}

/**
 * 页面初始化处理表格信息
 * @param wrapResult
 * @param tableId
 */
function dealWrapResult(wrapResult, tableId) {

	if (wrapResult && (wrapResult.columns || wrapResult.frozenColumns)) {
		$.ajax({
			url : 'platform/SysDatatablesController/getColumnByUserIdAndTableName',
			data : {
				tableName : userDefinePathName + "/" + tableId
			},
			type : 'post',
			dataType : 'json',
			async : false,
			success : function(r) {
				if (r.flag == 'success') {
					var existsCol = false;
					// 非冻结列
					if (null != wrapResult.columns && wrapResult.columns.length > 0) {
						for ( var i = 0; i < wrapResult.columns[0].length; i++) {
							var column = wrapResult.columns[0][i];
							if (column.width && column.field) {
								if (r[column.field]) {
									existsCol = true;
									var columnShow = r[column.field].columnShow;
									var columnWidth = r[column.field].columnWidth;
									column.width = parseInt(columnWidth);
									if (columnShow == 'false') {
										column.hidden = true;
									} else {
										column.hidden = false;
									}
									column.innerOrder = r[column.field].attribute01;

								}
							}
						}
					}
					// 冻结列
					var existsFrozenCol = false;
					if (null != wrapResult.frozenColumns && wrapResult.frozenColumns.length > 0) {
						for ( var i = 0; i < wrapResult.frozenColumns[0].length; i++) {
							var column = wrapResult.frozenColumns[0][i];
							if (column.width && column.field) {
								if (r[column.field]) {
									existsFrozenCol = true;
									var columnShow = r[column.field].columnShow;
									var columnWidth = r[column.field].columnWidth;
									column.width = parseInt(columnWidth);
									if (columnShow == 'false') {
										column.hidden = true;
									} else {
										column.hidden = false;
									}
									column.innerOrder = r[column.field].attribute01;
									// break;
								}
							}
						}
					}
				}
				if (existsCol) {
					var columns = wrapResult.columns[0];
					columns.sort(compare('innerOrder'));

				}
				if (existsFrozenCol) {
					var columns = wrapResult.frozenColumns[0];
					columns.sort(compare('innerOrder'));

				}
			}
		});
	}

}

function compare(property) {
	return function(a, b) {
		var value1 = a[property];
		var value2 = b[property];
		if (typeof (value1) == 'undefined') {
			value1 = 0;
		}
		if (typeof (value2) == 'undefined') {
			value2 = 0;
		}
		return parseInt(value1) - parseInt(value2);

	};
}
/**
 * 保存用户自定义表单信息到数据库
 * @param tabldId
 */
function saveUserdefinedColumnInfo(tableId) {
	userDefineColumnFieldsOptions = getGridAllColumnFieldsOptions(tableId);
	var columnArray = new Array();
	if (null != userDefineColumnFieldsOptions && userDefineColumnFieldsOptions.length > 0) {
		for ( var i = 0; i < userDefineColumnFieldsOptions.length; i++) {
			var columnOptions = userDefineColumnFieldsOptions[i];
			if (columnOptions.field != 'ID' && columnOptions.field != 'id' && columnOptions.field != 'VERSION' && columnOptions.field != 'version') {
				var field = columnOptions.field;
				var title = columnOptions.title;
				var width = columnOptions.width;
				var innerOrder = columnOptions.innerOrder;
				var hidden = false;
				if (columnOptions.hidden) {
					hidden = columnOptions.hidden;
				}
				if (title && field) {
					var column = {
						columnField : field,
						columnShow : !hidden,
						columnWidth : width,
						columnLabel : title,
						attribute01 : innerOrder
					};
					columnArray.push(column);
				}
			}
		}
	}

	if (columnArray.length == 0) {
		$.messager.alert("操作提示", "未找到表格的配置信息。");
		return false;
	}
	var columnArrayJson = JSON.stringify(columnArray);
	$.ajax({
		url : 'platform/SysDatatablesController/saveOrEditDtoToRedis',
		data : {
			tableName : userDefinePathName + "/" + tableId,
			columns : columnArrayJson
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				/*
				 * $.messager.show({ title : '提示', msg : '自定义表格信息保存成功！' });
				 */
				$.messager.confirm('请确认', '要刷新页面才能看到效果，现在刷新页面吗？', function(c) {
					if (c) {
						window.location.reload();
					}
				});
			} else {
				$.messager.show({
					title : '提示',
					msg : '自定义表格信息保存失败！'
				});
			}
		}
	});
}

/**
 * 保存用户自定义表单信息到数据库
 * @param tabldId
 */
function deleteUserdefinedColumnInfo(tableId) {
	$.messager.confirm('请确认','确定要删除当前表格的配置信息吗?',function(b){
		 if(b){
			 $.ajax({
			        url: 'platform/SysDatatablesController/deleteDtoToRedis',
			        data: {
			        	tableName : userDefinePathName + '/' + tableId
			        },
			        type: 'post',
			        dataType: 'json',
			        success: function(r) {
			            if (r.flag == "success") {
			            	 $.messager.confirm('请确认','要刷新页面才能看到效果，现在刷新页面吗？',function(c){
			    				 if(c){
			    					 window.location.reload();
			    				 }
			    			});
			            } else {
			            	 $.messager.show({
								 title : '提示',
								 msg : r.error
							 });
			            }
			        }
			 });
		 }
	});
}

/**
 * 获取表格所有的列:冻结列和未冻结列 
 */
function getGridAllColumnFieldsOptions(tableId) {
	var allColumnArray = new Array();

	// 复合表头
	var allColsOption = $("#" + tableId).datagrid("options").columns;
	if (null != allColsOption && allColsOption.length > 0) {
		for (var i = 0; i < allColsOption.length; i++) {
			var allArrays = allColsOption[i];
			for (var j = 0; j < allArrays.length; j++) {
				var colsOptionObj = allArrays[j];
				if (colsOptionObj.field) {
					allColumnArray.push(colsOptionObj);
				}
			}
		}
	}
	// 冻结列
	var allFrozenColsOption = $("#" + tableId).datagrid("options").frozenColumns;
	if (null != allFrozenColsOption && allFrozenColsOption.length > 0) {
		for ( var i = 0; i < allFrozenColsOption.length; i++) {
			var allArrays = allFrozenColsOption[i];
			for ( var j = 0; j < allArrays.length; j++) {
				var colsOptionObj = allArrays[j];
				if (colsOptionObj.field) {
					allColumnArray.push(colsOptionObj);
				}
			}
		}
	}
	return allColumnArray;
}

/**
 * 增加列的点击事件
 */
function addLeftHeaderClickEvent(tableId) {
	// 弹出的dialogId
	var divId = "column_dialog_" + tableId;
	var obj = document.getElementById(divId);
	var jianTouHtml = '<span class="m-btn-downarrow"></span>';
	$("#" + tableId).parent().find("div.datagrid-header-rownumber").html("");
	$("#" + tableId).parent().find("div.datagrid-header-rownumber").html('<div id="hide_"'+divId+'" onclick=\'showUserdefineColumnDialog("' + tableId + '");\' style="width:auto;height:auto">' + jianTouHtml + '</div>');
	if (!obj) {
		var toolDivHtml = '<div id="' + divId + '" class="easyui-dialog" title="" style="width:140px;height:auto;display:none;">'
						+ '		<span id="config2_'	+ tableId + '" class="easyui-linkbutton l-btn l-btn-plain" onclick=\'deleteUserdefinedColumnInfo("'	+ tableId + '");\' iconcls="icon-export" href="javascript:void(0);" style="width:auto" >'
						+ '			<div class="l-btn-left" style="border-bottom:1px solid #ddd;line-height:28px;height:28px;">'
						+ '				<span class="icon-remove" style="float:left;margin-top:4px;margin-left:3px;"></span>'
						+ '				<span class="l-btn-text" style="cursor: pointer;">删除当前显示状态</span>'
						+ '			</div>'
						+ '		</span>'
						+ '		<span id="config3_'	+ tableId + '" class="easyui-linkbutton l-btn l-btn-plain" onclick=\'openColumnConfigPage("' + tableId + '");\' iconcls="icon-export" href="javascript:void(0);" style="width:auto" >'
						+ '			<div class="l-btn-left" style="border-bottom:1px solid #ddd;line-height:28px;height:28px;">'
						+ '				<span class="icon-add" style="float:left;margin-top:4px;margin-left:3px;"></span>'
						+ '				<span class="l-btn-text" style="cursor: pointer;">显示属性设置窗口</span>'
						+ '			</div>'
						+ '		</span>'
						+ '		<span id="config4_'	+ tableId + '" class="easyui-linkbutton l-btn l-btn-plain" onclick=\'exportExcelServerData("' + tableId	+ '");\' iconcls="icon-export" href="javascript:void(0);" style="width:auto" >'
						+ '			<div class="l-btn-left" style="border-bottom:1px solid #ddd;line-height:28px;height:28px;">'
						+ '				<span class="icon-export" style="float:left;margin-top:4px;margin-left:3px;"></span>'
						+ '				<span class="l-btn-text" style="cursor: pointer;">导出到Excel</span>'
						+ '			</div>' 
						+ '		</span>' 
						+ '</div>';
		$("#" + tableId).append(toolDivHtml);
	}

	$("#column_dialog_" + tableId).on('mouseleave', { key : tableId }, function(event) {
		var tableKey = event.data.key;
		$("#column_dialog_" + tableKey).dialog('close');
	});
}

/**
 * 弹出右上角自定义表格的div选项
 * @param tableId
 */
function showUserdefineColumnDialog (tableId){
	var top = $("#" + tableId).parent().find("div.datagrid-header-rownumber").offset().top;
	var left = $("#" + tableId).parent().find("div.datagrid-header-rownumber").offset().left;
	$("#column_dialog_" + tableId).css("display", "block").dialog({
		top : top + 20,
		left : left
	});
	$("#column_dialog_" + tableId).dialog('open');
	
	$(document).unbind("#hide_column_dialog_"+tableId).bind("mousedown", function(e){
		var m = $(e.target).closest($(".l-btn-left"), $("#column_dialog_" + tableId));
		if (m.length){return;}
		if ($("#column_dialog_" + tableId).is(':visible')){
			$("#column_dialog_" + tableId).dialog('close');
		}
	});
}

//打开配置页面
function openColumnConfigPage(tableId){
	$("#column_dialog_" + tableId).dialog("close");
	userDefineColumn(tableId, null, null, null);
}


/**
 * 模拟ajax导出
 * 无弹出框,post提交无参数限制
 * @param iframeId
 * @param formId
 * @param headData
 * @returns {exportUser}
 */
exportDataGridData = function(iframeId, formId, headData, actionUrl) {

    var iframeName = "_iframe_" + iframeId;
    var formName = "_form_" + formId;

    if (typeof(headData) == 'undefined' || null == headData) {
        alert("导出头部不能为空！");
        return;
    }

    //设置是否显示遮罩Iframe
    if (typeof(iframeId) == 'undefined' || iframeId == null) {
        alert("iframeId不能为空！");
        return;
    }

    //设置是否显示遮罩Iframe
    if (typeof(formId) == 'undefined' || formId == null) {
        alert("formId不能为空！");
        return;
    }

    this.createDom = function() {
        //先销毁对象，再创建
        if (jQuery("#" + iframeName).length > 0) {
            jQuery("#" + iframeName).remove();
        }

        //先销毁对象，再创建
        if (jQuery("#" + formName).length > 0) {
            jQuery("#" + formName).remove();
        }

        if (jQuery("#" + iframeName).length == 0) {
            var exportIframe = document.createElement("iframe");
            exportIframe.id = iframeName;
            exportIframe.name = iframeName;
            exportIframe.style.display = 'none';
            document.body.appendChild(exportIframe);

            //创建form 
            var exportForm = document.createElement("form");
            exportForm.method = 'post';
            exportForm.action = actionUrl;
            exportForm.name = formName;
            exportForm.id = formName;
            exportForm.target = iframeName;
            document.body.appendChild(exportForm);

            for (var key in headData) {
                var headInput = document.createElement("input");
                headInput.setAttribute("name", key);
                headInput.setAttribute("type", "hidden");
                if (typeof(headData[key]) == 'string') {
                    headInput.setAttribute("value", headData[key]);
                } else {
                    var jsonStr = JSON.stringify(headData[key]);
                    headInput.setAttribute("value", jsonStr);
                }
                exportForm.appendChild(headInput);
            }
        }
    };

    this.excuteExport = function() {
        document.getElementById(formName).submit();
    };
    
    this.createDom();
};

/**
 * 导出服务器端口:前台封装导出的表头，可以传递不进行导出的列参数：unContainFields
 */
function exportExcelServerData(tableId) {
		$.messager.confirm('确认', '是否确认导出Excel文件?', function(r) {
		if (r) {
			// 封装参数
			userDefineColumnFieldsOptions = getGridAllColumnFieldsOptions(tableId);
			var columnArray = new Array();
			var colFormatter = [];// 用来记录列的自定义函数，以便用formmater得到显示的数据，而不是原始数据
		    if (null != userDefineColumnFieldsOptions && userDefineColumnFieldsOptions.length > 0) {
		        for (var i = 0; i < userDefineColumnFieldsOptions.length; i++) {
		            var columnOptions = userDefineColumnFieldsOptions[i];
	                var hidden = false;
	                var field = columnOptions.field;
	                if (columnOptions.hidden) {
	                    hidden = columnOptions.hidden;
	                }
	                if(hidden || field == 'id' || field == 'ID'){
	                	columnArray.push(field);
	                }
	                // 获取formmater信息
	                var cOpts =  $("#"+tableId).datagrid("getColumnOption", field);
					colFormatter[i] = cOpts.formatter;
		        }
		    }
			var dataGridFields = JSON.stringify(userDefineColumnFieldsOptions);
			var rows = $('#' + tableId).datagrid('getRows');
			var newRows=[]; 
			// 转换formmater后的值
			// --begin
			var rowsLength = rows.length;
			var _tempDiv = $("<div/>");
			for (var k = 0; k < rowsLength; k++) {
				var row=rows[k];
				var tempRow ={};
				 for (var mm = 0; mm < userDefineColumnFieldsOptions.length; mm++) {
                    if (userDefineColumnFieldsOptions[mm] != '') {
                        var fieldId=userDefineColumnFieldsOptions[mm].field;
                        var value = row[fieldId];
                        var newValue=colFormatter[mm] ? colFormatter[mm](value, row, k) : value; 
                        if (undefined==newValue){
                        	newValue="";
                        }else{
                            if (typeof(newValue) == 'string'&&newValue.indexOf("href") > 0){
                            	newValue=value;
                            }
                        }
                        newValue= _tempDiv.html(newValue).text();// 特殊字符转义防止<>$&等符号被转义
                        tempRow[fieldId]=newValue;
                    }
                 } 
                 newRows.push(tempRow);  
			}
			// 转换formmater后的值
			// --end
			
			var datas = JSON.stringify(newRows);
			
			// 获得用户自定义导出信息
			var allColsOptions = $("#" + tableId).datagrid("options");
			var exportExcelConfig = allColsOptions.exportExcelConfig;
			var exportExcelConfigJson = "";
			if(undefined != exportExcelConfig && null != exportExcelConfig){
				exportExcelConfigJson = JSON.stringify(exportExcelConfig);
			}
			
			//未包含列：使用逗号分隔开
			var exportExcelUncontainFields = allColsOptions.exportExcelUncontainFields;
			
			if(undefined != exportExcelUncontainFields && null != exportExcelUncontainFields){
				var exportExcelUncontainFieldsArray = exportExcelUncontainFields.split(',');
				for(var k = 0; k<exportExcelUncontainFieldsArray.length; k++){
					columnArray.push(exportExcelUncontainFieldsArray[k]);
				}
			}
			
			var unContainFields = "";
			if(columnArray.length > 0){
				unContainFields = columnArray.join(',');
			}
			expSearchParams = {
				dataGridFields : dataGridFields,// 表头信息集合
				datas : datas,// 数据集
				unContainFields : unContainFields,//不导出的列
				sheetName : 'sheet1',// 如果该参数为空，默认为导出的Excel文件名
				fileName : '导出excel' + getTodayStr(),// 导出的Excel文件名
				exportExcelConfig : exportExcelConfigJson // 用户配置的导出Excel信息
			};
			var url = "platform/excelExportController/exportExcelClientData";
			var ep = new exportDataGridData("xlsExport", "xlsExport",expSearchParams, url);
			ep.excuteExport();
		}
	});
}


/**
 * 获取当天的日期串
 * 
 * @returns {String}
 */
function getTodayStr() {
    var date = new Date();
    var myyear = date.getFullYear();
    var mymonth = date.getMonth() + 1;
    var myweekday = date.getDate();
    if (mymonth < 10) {
        mymonth = "0" + mymonth;
    }
    if (myweekday < 10) {
        myweekday = "0" + myweekday;
    }
    return (myyear + "-" + mymonth + "-" + myweekday);
}