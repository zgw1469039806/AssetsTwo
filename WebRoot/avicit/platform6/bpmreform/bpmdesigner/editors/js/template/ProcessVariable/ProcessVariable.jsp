<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body class=" easyui-layout" fit="true">
	<table id="jqGrid"></table>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script>
	$(function() {
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		var parentId = decodeURIComponent(flowUtils.getUrlQuery("id"));
		var parentObj = parent.$("#"+parentId).data("data-object");
		var process = parentObj.process;
		var multiple = parentObj.multiple;
		var dataVal = parent.$("#"+parentId).val();
		var dataGridColModel = [ {
			label : '变量名称',
			name : 'alias',
			key :true,
			width : 150
		}, {
			label : '变量',
			name : 'name',
			width : 150
		},
		 {
			label : '初始值',
			name : 'initExpr',
			width : 150
		},
		 {
			label : '变量类型',
			name : 'type',
			width : 150
		},
		 {
			label : '描述',
			name : 'desc',
			width : 150
		}
		];
		
		var jq = $('#jqGrid').jqGrid({
			//url : url,
			//mtype : 'POST',
			datatype : "local",
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			autowidth : true,
			responsive : true,//开启自适应  
			multiboxonly : false,
			multiselect : multiple,
			onSelectAll : multiple,
			gridComplete : function() {
				/*  if (dataVal) {
					var pos = dataVal.split(';');
					for ( var o = 0; o < pos.length; o++) {
						var id = pos[o];
						$(this).jqGrid("setSelection", id);
					}
				}  */
			}
		});
		parentObj.jqGrid = jq;
		if(process) {
		/* 	{"alias":"123","name":"123","initExpr":"1432","type":"string","desc":"4324"} */
			var i = 1;
			 parent.$("#"+process.id +" table[name='table-flow-variable']").find("input[name='dataValue']").each(function(){
				 jq.addRowData(i,JSON.parse($(this).val()));
				 i++;
			});
			 var globalformid = parent.$('#' + process.id).find('#guan_lian_biao_dan').val();
			 getFormFields(globalformid,jq,i);
			 if (dataVal) {
					var rowDataArr = parentObj.jqGrid.getRowData();
					var pos = dataVal.split(';');
					for ( var o = 0; o < pos.length; o++) {
						var alias = pos[o];
                        alias = alias.replace('#\{', '').replace('\}', '');
						for (var j = 0 ; j < rowDataArr.length; j++) {
							if (rowDataArr[j].alias == alias) {
								parentObj.jqGrid.setSelection(j+1);
							}
							 
						}
					} 
				} 
		}
	});

	function getFormFields(globalformid,jq,j){

		avicAjax.ajax({
            url: "bpm/designer/getProcessFormFieldsForVar",
            data:{
            	globalformid:globalformid,
            	isVar:'1'
            },
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.fields == '') {
                    
                } else {
                    var formFields = JSON.parse(backData.fields);
                    for (var i = 0; i < formFields.length; i++) {
                        var varType = "";
                        if('VARCHAR2'==formFields[i].colType || 'VARCHAR'==formFields[i].colType
                                || 'LVARCHAR'==formFields[i].colType
                                || 'CLOB'==formFields[i].colType || 'LONGTEXT'==formFields[i].colType
                                || 'TEXT'==formFields[i].colType){
                        	varType = "string";
                        }else if('NUMBER'==formFields[i].colType || 'DECIMAL'==formFields[i].colType){
                        	varType = "double";
                        }else if('DATE'==formFields[i].colType || 'TIMESTAMP'==formFields[i].colType
                                || 'DATETIME'==formFields[i].colType || 'DATETIME2'==formFields[i].colType){
                        	varType = "date";
                        }else if('BLOB'==formFields[i].colType || 'BYTE'==formFields[i].colType
                                || 'LONGBLOB'==formFields[i].colType){
                        	varType = "byte[]";
                        }
                    	var dataRow = {
                    			alias:formFields[i].colLabel,
            					name:formFields[i].colName,
            					type: varType,
            					initExpr:formFields[i].defaultValue,
            					desc:formFields[i].remark};
                    	jq.addRowData(j,dataRow);
                    	j++;
                    }
                }
            }
		});
	}
	
</script>
</body>
</html>
