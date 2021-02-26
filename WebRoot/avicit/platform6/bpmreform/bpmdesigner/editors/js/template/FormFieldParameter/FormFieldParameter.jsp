<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
</head>
<body  fit="true" >
	<div class="toolbar">
		<div class="toolbar-right">
				<table class="form_commonTable">
					<tr>
						<th width="20%">父流程存储模型：</th>
						<td width="25%">
						<input type="hidden" id="parentProcessDataSourceId" name="parentProcessDataSourceId" value="">
						<input title="父流程存储模型："
							class="form-control input-sm" type="text" name="parentProcessDataSourceName"
							id="parentProcessDataSourceName" readonly/></td>
						<th width="20%">子流程存储模型：</th>
						<td width="25%">
						<input type="hidden" id="subProcessDataSourceId" name="subProcessDataSourceId" value="">
						<input title="子流程存储模型："
							class="form-control input-sm" type="text" name="subProcessDataSourceName"
							id="subProcessDataSourceName" readonly/></td>
						<th><a id="bpmProcinst_button_serarch" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button" onClick="reload()"
						title="重新加载"> 重新加载</a></th>
					</tr>
				</table>
		</div>
	</div>
<div style="width:100%;height:100%;">
	<ul id="myTab" class="nav nav-tabs" style="width:100%;height:100%;">
		<li class="active"><a  href="#parentToSub" data-toggle="tab" id="tab1" >
			主传子参数</a></li>
		<li <c:if test="${param.hiddenVarParameter == '1'}">style="display:none"</c:if>><a  href="#subToParent" data-toggle="tab" id="tab2" >子传主参数</a></li>
		
	</ul>
	<div id="myTabContent" class="tab-content" style="width:98%;height:100%; border: 0;">
		<div class="tab-pane fade in active" id="parentToSub" style="width:100%;height:100%; border: 0;">
			<%--<div id="mainProcess" style="height:100%;">
				<h3>主流程主表字段和子流程主表字段映射</h3>--%>
				<table id="jqGrid1"></table>
			<%--</div>--%>

			<div id="subTablesConfig">
				<h3>主流程子表字段和子流程子表字段映射</h3>
				<div id="mainProcessSubTables" style="height: 400px!important;width: 100%;"></div>
			</div>
			<div id="accordion">
			  <h3>高级</h3>
			  <div id="varParameterIn" >
			  <div style="height:200px;">
			  	<div class="form-group" >
	                <div class="toolbar">
		                <div class="toolbar-right">
	                    	<button class="btn btn-default form-tool-btn btn-sm form-buttion-fix" style="align:right;" name="buttonAddParameterIn" >添加</button>
	                	</div>
	                </div>
	            </div>
	            <div >
	                <table class=" table table-hover table-bordered table-fix" name="table-flow-ParameterIn" id="table-flow-ParameterIn">
	                    <thead>
	                    <tr>
	                        <td style="width: 40%">主流程输出参数</td>
	                        <td style="width: 40%">子流程接收参数</td>
	                        <td>操作</td>
	                    </tr>
	                    </thead>
	                    <tbody>
	                    </tbody>
	                </table>
	            </div>
	          </div>
			  </div>
			</div>
		</div>
		<div class="tab-pane fade" id="subToParent" style="width:100%;height:100%; border: 0;">
			<table id="jqGrid2" style="width:100%;"></table>
			<div id="accordion1">
			  <h3>高级</h3>
			  <div id="varParameterOut" >
			  <div style="height:200px;">
			  	<div class="form-group" >
	                <!-- <div class="col-xs-3   col-xs-offset-8 " > -->
	                <div class="toolbar">
		                <div class="toolbar-right">
		                    <button class="btn btn-default form-tool-btn btn-sm form-buttion-fix" name="buttonAddParameterOut" >添加</button>
		                </div>
	                </div>
	            </div>
	            <div >
	                <table class=" table table-hover table-bordered table-fix" name="table-flow-ParameterOut" id="table-flow-ParameterOut">
	                    <thead>
	                    <tr>
	                        <td style="width: 40%">子流程输出参数</td>
                            <td style="width: 40%">主流程接收参数</td>
	                        <td>操作</td>
	                    </tr>
	                    </thead>
	                    <tbody>
	                    </tbody>
	                </table>
	            </div>
	          </div>
			  </div>
			</div>
		</div>
	</div>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ParameterInAndOut/ParameterInAndOut.js"></script>
<script type="text/javascript" src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script>
    var url1 = "platform/bpm/designer/getMainProcessFormFields";
    var url2 = "platform/bpm/designer/getSubProcessFormFields";
    var mainProcessFields;
    var subProcessFields;
    var parentObj;
    var formInFields = [];
    var formOutFields = [];
    var varParameterIn;
    var varParameterOut;
    var selectCreatedDbTable1;
    var selectCreatedDbTable2;
    var hiddenVarParameter;
    
	$(function() {
		/*$( "#mainProcess" ).accordion({
			collapsible: true,
			active: true
		});*/
		$( "#accordion" ).accordion({
  			collapsible: true,
  			active: false
		});
		$( "#accordion1" ).accordion({
  			collapsible: true,
  			active: false
		});
		$( "#subTablesConfig" ).accordion({
			collapsible: true,
			active: false
		});




		selectCreatedDbTable1 = new SelectCreatedDbTable("parentProcessDataSourceId","parentProcessDataSourceName", "");
        selectCreatedDbTable1.init();
        selectCreatedDbTable2 = new SelectCreatedDbTable("subProcessDataSourceId","subProcessDataSourceName", "");
        selectCreatedDbTable2.init();
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		var parentId = decodeURIComponent(flowUtils.getUrlQuery("dataDomId1"));
		
		parentObj = parent.$("#"+parentId).data("data-object");
		var mainProcessFormId = parentObj.mainProcessFormId;
		var subProcessKey = parentObj.subProcessKey;
		hiddenVarParameter = decodeURIComponent(flowUtils.getUrlQuery("hiddenVarParameter"));
		if('1'==hiddenVarParameter){
			$("#accordion").hide();
			$("#accordion1").hide();
		}else{
			$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	            // 获取已激活的标签页的名称
	            var activeTab = $(e.target).text();
	            if(activeTab=='子传主参数'){
	                $("#varParameterOut").height(200);
	             }
	        });
			varParameterIn = new ParameterInAndOut({parentId:parentObj.id,id:'varParameterIn', buttonId:"buttonAddParameterIn", tableId:"table-flow-ParameterIn",type:"parameter-in", callback:function(data){
			}});
			parentObj.varParameterIn = varParameterIn;
			varParameterIn.initDataFromParent();
			varParameterOut = new ParameterInAndOut({parentId:parentObj.id,id:'varParameterOut', buttonId:"buttonAddParameterOut", tableId:"table-flow-ParameterOut",type:"parameter-Out", callback:function(data){
			    }});
			parentObj.varParameterOut = varParameterOut;
			varParameterOut.initDataFromParent();
		}
		
		
		
		getProcessFormFields(mainProcessFormId,subProcessKey,"","");


	});

	function reload(){
		var parentProcessDataSourceId = $("#parentProcessDataSourceId").val();
		var subProcessDataSourceId = $("#subProcessDataSourceId").val();
		if(parentProcessDataSourceId=='' || subProcessDataSourceId==''){
			layer.alert('请选择父流程存储模型和子流程存储模型', {
				icon : 7,
				area : [ '400px', '' ],
				closeBtn : 0
			});
			return;
		}
		getProcessFormFields('','',parentProcessDataSourceId,subProcessDataSourceId);
	}

	function getProcessFormFields(mainProcessFormId,subProcessKey,parentProcessDataSourceId,subProcessDataSourceId){
		avicAjax.ajax({
            url: "platform/bpm/designer/getProcessFormFields",
            data: "mainProcessFormId=" + mainProcessFormId+"&subProcessKey="+subProcessKey
            +"&parentProcessDataSourceId="+parentProcessDataSourceId+"&subProcessDataSourceId="+subProcessDataSourceId,
            type: "post",
            dataType: "json",
            success: function (backData) {

                if(backData.result=='0'){
                	layer.msg(backData.msg);
                }
           		var mainProcessFieldsStr = backData.mainProcessFields;
           		if(mainProcessFieldsStr!='' && mainProcessFieldsStr!=null){
           			mainProcessFields = JSON.parse(mainProcessFieldsStr);
                }
           		
           		var subProcessFieldsStr = backData.subProcessFields;
           		if(subProcessFieldsStr!='' && subProcessFieldsStr!=null){
           			subProcessFields = JSON.parse(subProcessFieldsStr);
                }

           		parentObj.mainProcessTableName = backData.mainProcessTableName;
           		//$("#parentTableName").val(backData.mainProcessTableName);
           		parentObj.subProcessTableName = backData.subProcessTableName;
           		//$("#subTableName").val(backData.subProcessTableName);
           		parentObj.mainProcessTableModify = backData.mainProcessTableModify;
           		parentObj.subProcessTableModify = backData.subProcessTableModify;
           		parentObj.mainProcessIsOrgIdentity = backData.mainProcessIsOrgIdentity;
           		parentObj.subProcessIsOrgIdentity = backData.subProcessIsOrgIdentity;
           		if(parentProcessDataSourceId!=null && parentProcessDataSourceId!=''){
           			initTab1(parentObj,true);

           			if('1'!=hiddenVarParameter){
           				initTab2(parentObj,true);
                   	}
                    loadSubTable(parentObj,backData);
               	}else{
               		$("#parentProcessDataSourceId").val(backData.parentProcessDataSourceId);
               		$("#parentProcessDataSourceName").val(backData.mainProcessTableComments);
               		$("#subProcessDataSourceId").val(backData.subProcessDataSourceId);
               		$("#subProcessDataSourceName").val(backData.subProcessTableComments);
               		initTab1(parentObj,false);
					$("#jqGrid1").setGridHeight(260);
               		if('1'!=hiddenVarParameter){
               			initTab2(parentObj,false);
               		}
                    loadSubTable(parentObj,backData);
                }
           		
            }
        });
	}

	function loadSubTable(parentObj,backData){
        var isConfigSubTab = backData.isConfigSubTab;
        if("1"==isConfigSubTab){
            $("#subTablesConfig").show();
            var mainProcessSubTableColsMap = backData.mainProcessSubTableColsMap;
            var mainProcessSubTableModifyMap = backData.mainProcessSubTableModifyMap;
            var mainProcessSubTableFkColNameMap = backData.mainProcessSubTableFkColNameMap;
            var mainProcessSubTableIsOrgIdentityMap = backData.mainProcessSubTableIsOrgIdentityMap;
            var subProcessSubTableColsMap = backData.subProcessSubTableColsMap;
			var subProcessSubTableFkColNameMap = backData.subProcessSubTableFkColNameMap;
            for(var subTableName in mainProcessSubTableColsMap){
                parentObj.subTableNameArr.push(subTableName);
                var subTabCols = mainProcessSubTableColsMap[subTableName];
                var subTableModify = mainProcessSubTableModifyMap[subTableName];
                var subTableIsOrgIdentity = mainProcessSubTableIsOrgIdentityMap[subTableName];
                var subTableFkColName = mainProcessSubTableFkColNameMap[subTableName];
                var $subTable = $("<table></table>");
                $subTable.attr("id",subTableName);
                $subTable.attr("class","subTable");
                var $subTableTitle = $("<lable><lable/>");
                $subTableTitle.append("主流程子表："+subTableName);
                $("#mainProcessSubTables").append($subTableTitle);
                $("#mainProcessSubTables").append($subTable);
                initSubTab(subTableName,subTabCols,subTableModify,subTableIsOrgIdentity,subTableFkColName,subProcessSubTableColsMap,subProcessSubTableFkColNameMap,parentObj,false);
                $("#mainProcessSubTables").height('auto');
                $("#"+subTableName).setGridWidth($("#mainProcessSubTables").width()-5);
                /*$( "#subTablesConfig" ).accordion({
                    collapsible: true,
                    active: false
                });*/
            }

        }else{
            $("#subTablesConfig").hide();
            parentObj.subTableNameArr = new Array();
            parentObj.subJqGrids = new Array();
            parentObj.subTableLastrowArr = new Array();
            parentObj.subTableLastcellArr = new Array();
        }
    }
	
	function formatSubField(cellvalue, options, rowObject) {
		var str = "";
		for(i=0;i<subProcessFields.length;i++){
			if(cellvalue==subProcessFields[i].colName){
				str = subProcessFields[i].colComments;
				break;
			}
		}
		if(str==""){
			str="请选择";
		}
		return str;
	}

	function formatMainField(cellvalue, options, rowObject) {
		var str = "";
		for(i=0;i<mainProcessFields.length;i++){
			if(cellvalue==mainProcessFields[i].colName){
				str = mainProcessFields[i].colComments;
				break;
			}
		}
		if(str==""){
			str="请选择";
		}
		return str;
	}

	function getSubProcessFields(){
		var str = ":;"; 
		if(subProcessFields!=null && subProcessFields!=undefined && subProcessFields!=''){
			for(i=0;i<subProcessFields.length;i++){
				if(i!=subProcessFields.length-1){
					str+=subProcessFields[i].colName+":"+subProcessFields[i].colName+"("+subProcessFields[i].colComments+");";
	            }else{
	                str+=subProcessFields[i].colName+":"+subProcessFields[i].colName+"("+subProcessFields[i].colComments+")";
	            }
			}
		}
		
		return str;
	}

	function getSubProcessSubTableFields(subProcessSubTableMap){
		var str = ":;";
		for(var subTableName in subProcessSubTableMap) {
			var subProcessFields = subProcessSubTableMap[subTableName];
			if(subProcessFields!=null && subProcessFields!=undefined && subProcessFields!=''){
				for(var i=0;i<subProcessFields.length;i++){
					if(i!=subProcessFields.length-1){
						str+=subTableName+"@@"+subProcessFields[i].colName+":"+subProcessFields[i].colName+"("+subProcessFields[i].colComments+");";
					}else{
						str+=subTableName+"@@"+subProcessFields[i].colName+":"+subProcessFields[i].colName+"("+subProcessFields[i].colComments+")";
					}
				}
			}
		}


		return str;
	}

	function getMainProcessFields(){
		var str = ":;"; 
		if(mainProcessFields!=null && mainProcessFields!=undefined && mainProcessFields!=''){
			for(i=0;i<mainProcessFields.length;i++){
				if(i!=mainProcessFields.length-1){
					str+=mainProcessFields[i].colName+":"+mainProcessFields[i].colName+"("+mainProcessFields[i].colComments+");";
	            }else{
	                str+=mainProcessFields[i].colName+":"+mainProcessFields[i].colName+"("+mainProcessFields[i].colComments+")";
	            }
			}
		}
		
		return str;
	}

	function setGridToColId(tableId,value,rowId,subProcessSubTableMap,subProcessSubTableFkColNameMap){
		var valueArr = value.split("@@");
		var checkedTable = valueArr[0];
		var checkedValue = valueArr[1];
		var fields = subProcessSubTableMap[checkedTable];
		var fkColName = subProcessSubTableFkColNameMap[checkedTable];

		$("#"+tableId).jqGrid('setCell',rowId,'toColId',checkedValue);
		var colType = "";
		if(fields!=null && fields!=undefined && fields!=''){
			for(var i=0;i<fields.length;i++){
				if(checkedValue==fields[i].colName){
					colType = fields[i].colType;
					break;
				}
			}
		}
		$("#"+tableId).jqGrid('setCell',rowId,'toColType',colType);
		$("#"+tableId).jqGrid('setCell',rowId,'subFormTable',checkedTable);
		$("#"+tableId).jqGrid('setCell',rowId,'toFkColName',fkColName);

	}

	function setGrid1ToColId(value,rowId){
		$("#jqGrid1").jqGrid('setCell',rowId,'toColId',value);
		var colType = "";
		if(subProcessFields!=null && subProcessFields!=undefined && subProcessFields!=''){
			for(i=0;i<subProcessFields.length;i++){
				if(value==subProcessFields[i].colName){
					colType = subProcessFields[i].colType;
					break;
				}
			}
		}
		$("#jqGrid1").jqGrid('setCell',rowId,'toColType',colType);
	}

	function setGrid2ToColId(value,rowId){
		$("#jqGrid2").jqGrid('setCell',rowId,'toColId',value);
		var colType = "";
		if(mainProcessFields!=null && mainProcessFields!=undefined && mainProcessFields!=''){
			for(i=0;i<mainProcessFields.length;i++){
				if(value==mainProcessFields[i].colName){
					colType = mainProcessFields[i].colType;
					break;
				}
			}
		}
		$("#jqGrid2").jqGrid('setCell',rowId,'toColType',colType);
		
	}

	function getFormInDataByFormCol(formCol,formInFields){
		var formInField = null;
		for(i=0;i<formInFields.length;i++){
			if(formCol == formInFields[i].formCol){
				formInField = formInFields[i];
				break;
			}
		}
		if(formInField!=null){
	        var isExistCol = getIsExistCol(formInField.subFormCol,subProcessFields);
	        if(!isExistCol){
				return null;
			 }
	    }
		return formInField;
	}

	function getSubTableFieldByFormCol(formCol,selectedFields,subProcessSubTableMap){
		var formInField = null;
		for(var i=0;i<selectedFields.length;i++){
			if(formCol == selectedFields[i].formCol){
				formInField = selectedFields[i];
				break;
			}
		}
		if(formInField!=null){
			var subProcessFields = subProcessSubTableMap[formInField.subFormTable];
			var isExistCol = getIsExistCol(formInField.subFormCol,subProcessFields);
			if(!isExistCol){
				return null;
			}
		}
		return formInField;
	}

	function getFormOutDataBySubFormCol(subFormCol,formOutFields){
		var formOutField = null;
		for(i=0;i<formOutFields.length;i++){
			if(subFormCol == formOutFields[i].subFormCol){
				formOutField = formOutFields[i];
				break;
			}
		}
        if(formOutField!=null){
        	var isExistCol = getIsExistCol(formOutField.formCol,mainProcessFields);
        	if(!isExistCol){
				return null;
             }
        }
		
		return formOutField;
	}

	function getIsExistCol(colName,formFields){
		var isExistCol = false;
		for(i=0;i<formFields.length;i++){
			if(colName==formFields[i].colName){
				isExistCol = true;
				break;
			}
		}
		return isExistCol;
	}

	function initSubTabData(jq,tableCols,subProcessSubTableMap,tableId,isOrgIdentity,tableModify,fkColName){
		jq.clearGridData();
		var formInDataStr = parent.$("#"+parentObj.dataDomId1).val();
		var selectedFields = [];
		if(formInDataStr!=null && formInDataStr!=''){
			var tempFields = JSON.parse(formInDataStr);
			var tempLength = tempFields.length;
			for(var tempIndex =0;tempIndex<tempLength;tempIndex++){
				var tempField = tempFields[tempIndex];
				if("1"==tempField.isSubTable && tempField.formTable==tableId){
					selectedFields.push(tempField);
				}
			}
		}
		var i = 1;
		if(tableCols!=null && tableCols!=undefined && tableCols!=''){
			for(var j=0;j<tableCols.length;j++){
				var toColName = "";
				var toColId = "";
				var toColType = "";
				var subFormTable = "";
				var toFkColName = "";
				var formInField = getSubTableFieldByFormCol(tableCols[j].colName,selectedFields,subProcessSubTableMap);
				if(formInField!=null){
					//toColName = formInField.subFormCol+'('+formInField.colComments+')';
					toColName = formInField.colComments;
					toColId = formInField.subFormCol;
					toColType = formInField.colType;
					subFormTable = formInField.subFormTable;
					toFkColName = formInField.toFkColName;
				}
				var colComments = tableCols[j].colName+'('+tableCols[j].colComments+')';
				var dataRow = {
					formTable:tableId,
					tableModify:tableModify,
					isOrgIdentity:isOrgIdentity,
					fkColName:fkColName,
					colName:tableCols[j].colName,
					colComments:colComments,
					chuancan: "<span class='glyphicon glyphicon-arrow-right'/>",
					toColName:toColName,
					toColId:toColId,
					toColType:toColType,
					toFkColName:toFkColName,
					subFormTable:subFormTable};
				jq.addRowData(i,dataRow);
				i++;
			}
		}
	}

	function initTab1Data(jq){
		jq.clearGridData();
		var formInDataStr = parent.$("#"+parentObj.dataDomId1).val();
		var tempInFields;
		formInFields = [];
		if(formInDataStr!=null && formInDataStr!=''){
			tempInFields = JSON.parse(formInDataStr);
			for(var i=0;i<tempInFields.length;i++){
				var tempField = tempInFields[i];
				if("1"==tempField.isSubTable){
					continue;
				}else{
					formInFields.push(tempField);
				}
			}
		}		
		var i = 1;
		if(mainProcessFields!=null && mainProcessFields!=undefined && mainProcessFields!=''){
			for(j=0;j<mainProcessFields.length;j++){
				var toColName = "";
				var toColId = "";
				var toColType = "";
				var formInField = getFormInDataByFormCol(mainProcessFields[j].colName,formInFields);
				if(formInField!=null){
					//toColName = formInField.subFormCol+'('+formInField.colComments+')';
					toColName = formInField.colComments;
					toColId = formInField.subFormCol;
					toColType = formInField.colType;
				}
				var colComments = mainProcessFields[j].colName+'('+mainProcessFields[j].colComments+')';
				var dataRow = {
					colName:mainProcessFields[j].colName,
					colComments:colComments,
					chuancan: "<span class='glyphicon glyphicon-arrow-right'/>",
					toColName:toColName,
					toColId:toColId,
					toColType:toColType};
				jq.addRowData(i,dataRow);
				i++;
			}
		}	
	}

	function initTab2Data(jq){
		jq.clearGridData();
		var formOutDataStr = parent.$("#"+parentObj.dataDomId2).val();
		if(formOutDataStr!=null && formOutDataStr!=''){
			formOutFields = JSON.parse(formOutDataStr);
		}	

		var i = 1;
		if(subProcessFields!=null && subProcessFields!=undefined && subProcessFields!=''){
			for(j=0;j<subProcessFields.length;j++){
				var toColName = "";
				var toColId = "";
				var toColType = "";
				var formOutField = getFormOutDataBySubFormCol(subProcessFields[j].colName,formOutFields);
				if(formOutField!=null){
					//toColName = formOutField.formCol+'('+formOutField.colComments+')';
					toColName = formOutField.colComments;
					toColId = formOutField.formCol;
					toColType = formOutField.colType;
				}
				var dataRow = {
					colName:subProcessFields[j].colName,
					colComments:subProcessFields[j].colName+'('+subProcessFields[j].colComments+')',
					chuancan: "<span class='glyphicon glyphicon-arrow-right'/>",
					toColName:toColName,
					toColId:toColId,
					toColType:toColType};
				jq.addRowData(i,dataRow);
				i++;
			}
		}
	}

	function initTab1(parentObj,isReload){
		var dataGridColModel = [ 
		{
			name : 'colName',
			hidden:true
		},
		{
			label : '主流程表字段',
			name : 'colComments',
			width : 150
		}, {
			label : '传参',
			name : 'chuancan',
			width : 50,
			align:'center'
		},
		 {
			label : '子流程表字段',
			name : 'toColName',
			width : 150,
			editable : true,
			edittype : 'select',
			//formatter:formatSubField,
		    editoptions: { value: getSubProcessFields(),
		    	          dataEvents:[{type:'change',
							fn:function(e){
								   var rowId=$(this).parent().parent().attr("id");
								   var value = $(this).val();
								   setGrid1ToColId(value,rowId);									
							}}
		    		      ]}
		},
		{
			name : 'toColId',
			hidden:true
		},
		{
			name : 'toColType',
			hidden:true
		}
		];

		var param = {
				//url : url1,
				//mtype : 'POST',
				datatype : "local",
				colModel : dataGridColModel,
				width : '100%',
				height : '400px',
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
				multiselect : false,
				onSelectAll : false,
				cellEdit:true,
				cellsubmit: 'clientArray',
				beforeEditCell:function(rowid,cellname,v,iRow,iCol){
					  parentObj.grid1Lastrow = iRow;
					  parentObj.grid1Lastcell = iCol;
					},
				gridComplete : function() {
					/*  if (dataVal) {
						var pos = dataVal.split(';');
						for ( var o = 0; o < pos.length; o++) {
							var id = pos[o];
							$(this).jqGrid1("setSelection", id);
						}
					}  */
				}
			};
		
		var jq = $('#jqGrid1').jqGrid(param);
		if(isReload){
			$('#jqGrid1').jqGrid('setGridParam',param).trigger("reloadGrid");
		}
		parentObj.jqGird1 = jq;
		initTab1Data(jq);		
	}

	function initSubTab(tableId,subTableCols,tableModify,isOrgIdentity,fkColName,subProcessSubTableMap,subProcessSubTableFkColNameMap,parentObj,isReload){
		var dataGridColModel = [
			{
				name : 'formTable',
				hidden : true
			},
			{
				name : 'tableModify',
				hidden : true
			},
			{
				name : 'isOrgIdentity',
				hidden : true
			},
			{
				name : 'fkColName',
				hidden : true
			},
			{
				name : 'colName',
				hidden:true
			},
			{
				label : '主流程子表字段',
				name : 'colComments',
				width : 150
			}, {
				label : '传参',
				name : 'chuancan',
				width : 50,
				align:'center'
			},
			{
				label : '子流程子表字段',
				name : 'toColName',
				width : 150,
				editable : true,
				edittype : 'select',
				//formatter:formatSubField,
				editoptions: { value: getSubProcessSubTableFields(subProcessSubTableMap),
					dataEvents:[{type:'change',
						fn:function(e){
							var rowId=$(this).parent().parent().attr("id");
							var value = $(this).val();
							setGridToColId(tableId,value,rowId,subProcessSubTableMap,subProcessSubTableFkColNameMap);
						}}
					]}
			},
			{
				name : 'toColId',
				hidden:true
			},
			{
				name : 'toColType',
				hidden:true
			},
			{
				name : 'subFormTable',
				hidden:true
			},
			{
				name : 'toFkColName',
				hidden:true
			}
		];

		var param = {
			//url : url1,
			//mtype : 'POST',
			datatype : "local",
			colModel : dataGridColModel,
			width : '100%',
			height : '400px',
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
			multiselect : false,
			onSelectAll : false,
			cellEdit:true,
			cellsubmit: 'clientArray',
			beforeEditCell:function(rowid,cellname,v,iRow,iCol){
				parentObj.subTableLastrowArr[tableId] = iRow;
				parentObj.subTableLastcellArr[tableId] = iCol;
			},
			gridComplete : function() {
				/*  if (dataVal) {
                    var pos = dataVal.split(';');
                    for ( var o = 0; o < pos.length; o++) {
                        var id = pos[o];
                        $(this).jqGrid1("setSelection", id);
                    }
                }  */
			}
		};

		var jq = $('#'+tableId).jqGrid(param);
		if(isReload){
			$('#'+tableId).jqGrid('setGridParam',param).trigger("reloadGrid");
		}
		//parentObj.jqGird1 = jq;
		parentObj.subJqGrids[tableId]=jq;
		initSubTabData(jq,subTableCols,subProcessSubTableMap,tableId,isOrgIdentity,tableModify,fkColName);
	}

	

	function initTab2(parentObj,isReload){
		var dataGridColModel = [ 
		{
			label : '子流程字段',
			name : 'colName',
			hidden : true
		},	
		{
			label : '子流程表字段',
			name : 'colComments',
			//width : 150
		}, {
			label : '传参',
			name : 'chuancan',
			width : 50,
			align:'center'
		},
		 {
			label : '主流程表字段',
			name : 'toColName',
			//width : 150,
			editable : true,
			edittype : 'select',
			//formatter:formatSubField,
		    editoptions: {  value: getMainProcessFields(),
					    	dataEvents:[{type:'change',
								fn:function(e){
									   var rowId=$(this).parent().parent().attr("id");
									   var value = $(this).val();
									   setGrid2ToColId(value,rowId);									
								}}
			    		      ]
			    }
			
		},
		{
			name : 'toColId',
			hidden : true
		},
		{
			name : 'toColType',
			hidden:true
		}
		];

		var param = {
				//url : url1,
				//mtype : 'POST',
				datatype : "local",
				colModel : dataGridColModel,
				height : ($(window).height() - 200)/2,
				scrollOffset : 20, //设置垂直滚动条宽度
				altRows : true,
				userDataOnFooter : true,
				loadonce : true,
				viewrecords : true,
				styleUI : 'Bootstrap',
				viewrecords : true,
				width:800,
				//autowidth : true,
				responsive : true,//开启自适应  
				multiboxonly : false,
				multiselect : false,
				onSelectAll : false,
				cellEdit:true,
				cellsubmit: 'clientArray',
				beforeEditCell:function(rowid,cellname,v,iRow,iCol){
					  parentObj.grid2Lastrow = iRow;
					  parentObj.grid2Lastcell = iCol;
					},
				gridComplete : function() {
					
				}
			};
		
		var jq = $('#jqGrid2').jqGrid(param);
		if(isReload){
			$('#jqGrid2').jqGrid('setGridParam',param).trigger("reloadGrid");
		}
		parentObj.jqGird2 = jq;
		initTab2Data(jq);
	}
	
</script>
</body>
</html>
