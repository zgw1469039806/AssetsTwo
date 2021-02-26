<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>拷贝规则</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
	#t_sysDefRuleGrid{
		display: none;
	}
	#t_existingRuleGrid{
		display: none;
	}
	#t_businessRuleGrid{
		display: none;
	}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div id="westDiv" data-options="region:'west',split:true,onResize:function(a){$('#westDiv').setGridWidth(a);$(window).trigger('resize');}" style="width:750px">
		<div class="easyui-layout" data-options="fit:true">
			
			<div id="north1" data-options="region:'north',split:true,width:fixwidth(.5),onResize:function(a){$('#sysDefRuleGrid').setGridWidth(a);$(window).trigger('resize');}" style="height:250px;overflow-x:hidden;">
				<div id="tableToolbar1" class="toolbar">
					<div class="toolbar-left">
						<ol class="breadcrumb" style="margin-bottom: 0px; font-size: 13px; background-color: #EFEFEF;font-weight: bolder;padding: 6px 15px;height: 30px;">
							<li style="color: #006CB6;">系统默认规则</li>
						</ol>					
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 250px;">
							<input type="text" id="searchSysDefRule_keyWord" style="width: 250px;"
								class="form-control input-sm" placeholder="请输入规则名称"> <label
								id="searchSysDefRule_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="sysDefRuleGrid"></table>
				<div id="sysDefRulePager"></div>
			</div>
			<div data-options="region:'center',onResize:function(a){$('#businessRuleGrid').setGridWidth(a);$(window).trigger('resize');}">
				<div id="tableToolbar2" class="toolbar">
					<div class="toolbar-left">
						<ol class="breadcrumb" style="margin-bottom: 0px; font-size: 13px; background-color: #EFEFEF;font-weight: bolder;padding: 6px 15px;height: 30px;">
							<li style="color: #006CB6;">其他规则</li>
						</ol>					
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 250px;">
							<input type="text" id="searchBusinessRule_keyWord" style="width: 250px;"
								class="form-control input-sm" placeholder="请输入规则名称或表说明或选择页标识"> <label
								id="searchBusinessRule_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="businessRuleGrid"></table>
				<div id="businessRulePager"></div>
			</div>
		</div>		
	</div>
	<div data-options="region:'center',split:true">
		<div class="toolbar">
			<div class="toolbar-left">
				<ol class="breadcrumb" style="margin-bottom: 4px; font-size: 13px; background-color: #EFEFEF;font-weight: bolder;padding: 6px 15px;height: 30px;">
					<li style="color: #006CB6;">现有规则</li>
				</ol>					
			</div>
		</div>
		<table id="existingRuleGrid"></table>
		<div data-options="region:'south',border:false">
			<div id="toolbar" style="float: right;">
				<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存" id="sysDataPermissionsRule_saveForm" onclick="saveForm();">保存</a>
				<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" onclick="closeForm();">返回</a>
			</div>
		</div>
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	
	<script type="text/javascript">
		function closeForm() {
			parent.sysDataPermissionsMethod.closeCopyDialog();
		}
		function saveForm() {
			//限制保存按钮多次点击
			$('#sysDataPermissionsRule_saveForm').addClass('disabled').unbind("click");
			var existingRuleData = $("#existingRuleGrid").jqGrid("getRowData");
			var dataArray = new Array();
			$.each(existingRuleData,function(index,data){
				if(data.id==""){
					dataArray.push(data);
				}
			});
			parent.sysDataPermissionsMethod.copyRule(JSON.stringify(dataArray),'${methodId}');
		}
		
		function formatBusinessRuleToolValue(cellvalue, options, rowObject) {
			return '<a href="javascript:void(0);" onclick="copyRuleBusiness(\'' + rowObject.id + '\');">复制</a>';
		}
		
		var	newRowIndex = 0;
		var newRowStart = "new_row";
		function copyRuleBusiness(ruleId){
			var existingRuleData = $("#existingRuleGrid").jqGrid("getRowData");
			if(existingRuleData.length < 9){
				var newRowId = newRowStart + newRowIndex;
				var businessRuleData = $("#businessRuleGrid").jqGrid('getRowData', ruleId);
				var parameters = {
					rowID : newRowId,
					initdata : {
						identifier:'',
						ruleName:businessRuleData.ruleName,
						ruleRemarks:businessRuleData.ruleRemarks,
						matchSymbol:businessRuleData.matchSymbol,
						filterCondition:businessRuleData.filterCondition,
						filterConditionSql:businessRuleData.filterConditionSql == "" ? businessRuleData.columnValue : businessRuleData.filterConditionSql,
						copyRuleId:ruleId,
						copyRuleType:'business'
					},
					position : "first",
					useDefValues : true,
					useFormatter : true,
					addRowParams : {
						extraparam : {}
					}
				};
				newRowIndex++;
		 		$("#existingRuleGrid").jqGrid('addRow', parameters);
			}else{
				layer.msg("最多可添加9个规则！");
			}
		}
		
		// 格式化系统默认规则
		function formatSysRuleToolValue(cellvalue, options, rowObject) {
			return '<a href="javascript:void(0);" onclick="copyRuleSys(\'' + rowObject.id + '\');">复制</a>';
		}
		
		function copyRuleSys(ruleId){
			var existingRuleData = $("#existingRuleGrid").jqGrid("getRowData");
			if(existingRuleData.length < 9){
				var newRowId = newRowStart + newRowIndex;
				var businessRuleData = $("#sysDefRuleGrid").jqGrid('getRowData', ruleId);
				var parameters = {
					rowID : newRowId,
					initdata : {
						identifier:'',
						ruleName:businessRuleData.ruleName,
						ruleRemarks:businessRuleData.ruleRemarks,
						matchSymbol:businessRuleData.matchSymbol,
						filterCondition:businessRuleData.filterCondition,
						filterConditionSql:businessRuleData.filterConditionSql,
						copyRuleId:ruleId,
						copyRuleType:'sys'
					},
					position : "first",
					useDefValues : true,
					useFormatter : true,
					addRowParams : {
						extraparam : {}
					}
				};
				newRowIndex++;
		 		$("#existingRuleGrid").jqGrid('addRow', parameters);
			}else{
				layer.msg("最多可添加9个规则！");
			}
		}

		document.ready = function() {
			// 系统默认规则
			initSysDefRuleTable();
			// 自定义规则
			initBusinessRuleTable();
			// 现有规则
			initExistingRuleTable();
		};
		
		// 自定义规则
		function initBusinessRuleTable(){
			var sysDefRuleColModel =  [
					{
						label : 'id',
						name : 'id',
						key : true,
						width : 75,
						hidden : true
					},      
					{
						label : '规则名称',
						name : 'ruleName',
						width : 100,
                        sortable : false
					}, {
						label : '规则描述',
						name : 'ruleRemarks',
						width : 100,
                    	sortable : false
					},{
						label : '所属表说明',
						name : 'tableRemarks',
						width : 100,
                    	sortable : false
					},{
						label : '弹出页唯一标识',
						name : 'selectId',
						width : 60,
                    	sortable : false
					},{
						label : '操作',
						name : 'tools',
						width : 30,
						formatter : formatBusinessRuleToolValue,
                    	sortable : false
					},{
						label : '相邻匹配符',
						name : 'matchSymbol',
						hidden : true
					},{
						label : '过滤条件',
						name : 'filterCondition',
						hidden : true
					},{
						label : '过滤条件SQL',
						name : 'filterConditionSql',
						hidden : true
					},{
						label : '自定义方法',
						name : 'columnValue',
						hidden : true
					}
    		];
   			$("#businessRuleGrid").jqGrid({
   				url: 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getEffectiveBusinessRulesByPage.json',
   		        mtype: 'POST',
   		        datatype: "json",
   		        toolbar: [true,'top'],
   		        colModel: sysDefRuleColModel,
   		        height : $(window).height() - 365,
   		        scrollOffset: 10,
   		        rowNum: 10	,
   		        rowList:[30,20,10],
   		        altRows:true,
   		        userDataOnFooter: true,
   		        pagerpos:'left',
   		        hasColSet:false,//设置显隐属性
   		        styleUI : 'Bootstrap', 
   				viewrecords: true,
   				multiboxonly:true,
   				shrinkToFit : true,
   				responsive:true,
   				pager: $("#businessRulePager")
   		    });
   			
   			$("#searchBusinessRule_searchPart").bind('click', function() {
				var keyWord = $("#searchBusinessRule_keyWord").val();
				$('#businessRuleGrid').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyWord' : keyWord
					}
				}).trigger("reloadGrid");
	
			});
			$("#searchBusinessRule_keyWord").bind('keyup',function(e) {
				if (e.keyCode == 13) {
					var keyWord = $("#searchBusinessRule_keyWord").val();
					$('#businessRuleGrid').jqGrid('setGridParam', {
						datatype : 'json',
						postData : {
							'keyWord' : keyWord
						}
					}).trigger("reloadGrid");
				}
			});
		}
		
		// 现有规则
		function initExistingRuleTable(){
			var existingRuleColModel =  [
				{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				},  
				{
					label : '标识符',
					name : 'identifier',
					width : 50,
                    sortable : false
				},
				{
					label : '规则名称',
					name : 'ruleName',
					width : 70,
                    sortable : false
				},  {
					label : '规则描述',
					name : 'ruleRemarks',
					width : 100,
                    sortable : false
				}, {
					label : '相邻匹配符',
					name : 'matchSymbol',
					width : 70,
                    sortable : false
				}, {
					label : '过滤条件',
					name : 'filterCondition',
					hidden : true
				}, {
					label : '过滤条件SQL/自定义方法',
					name : 'filterConditionSql',
					width : 200,
                    sortable : false
				}, {
					name : 'copyRuleId',
					hidden : true
				}, {
					name : 'copyRuleType',
					hidden : true
				}
   			];
  			$("#existingRuleGrid").jqGrid({
  				url: 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getExistingRulesByPage.json',
  				postData:{methodId:'${methodId}'},
  		        mtype: 'POST',
  		        datatype: "json",
  		        toolbar: [true,'top'],
  		        colModel: existingRuleColModel,
  		        height : $(window).height() - 130,
  		        scrollOffset: 10,
  		        altRows:true,
  		        userDataOnFooter: true,
  		        hasColSet:false,//设置显隐属性
  		        styleUI : 'Bootstrap', 
  				viewrecords: true,
  				multiboxonly:true,
  				shrinkToFit : true,
  				responsive:true
  		    });
		}
		
		// 系统默认规则
		function initSysDefRuleTable(){
			var sysDefRuleColModel =  [
				{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				},{
					label : '规则名称',
					name : 'ruleName',
					width : 100,
                    sortable : false
				},{
					label : '规则描述',
					name : 'ruleRemarks',
					width : 150,
                    sortable : false
				},{
					label : '操作',
					name : 'tools',
					width : 20,
					formatter : formatSysRuleToolValue,
                    sortable : false
				},{
					label : '相邻匹配符',
					name : 'matchSymbol',
					hidden : true
				},{
					label : '过滤条件',
					name : 'filterCondition',
					hidden : true
				},{
					label : '过滤条件SQL',
					name : 'filterConditionSql',
					hidden : true
				}
 			];
			$("#sysDefRuleGrid").jqGrid({
				url: 'platform6/msystem/sysdatapermissions/sysdatapermissionsdefrule/sysDataPermissionsDefRuleController/getEffectiveRulesByPage.json',
		        mtype: 'POST',
		        datatype: "json",
		        toolbar: [true,'top'],
		        colModel: sysDefRuleColModel,
		        height : $('#north1').height()-$("#tableToolbar1").innerHeight()-75,
		        scrollOffset: 10,
		        rowNum: 10	,
		        rowList:[30,20,10],
		        altRows:true,
		        userDataOnFooter: true,
		        pagerpos:'left',
		        hasColSet:false,//设置显隐属性
		        styleUI : 'Bootstrap', 
				viewrecords: true,
				multiboxonly:true,
				shrinkToFit : true,
				responsive:true,
				pager: $("#sysDefRulePager"),
				loadComplete:function(){
					$("#sysDefRulePager_left").find("select").width("40");
				}
		    });
			 
			$("#searchSysDefRule_searchPart").bind('click', function() {
				var keyWord = $("#searchSysDefRule_keyWord").val();
				$('#testCurrencyjqGrid').jqGrid('setGridParam', {
					datatype : 'json',
					postData : {
						'keyWord' : keyWord
					}
				}).trigger("reloadGrid");
	
			});
			$("#searchSysDefRule_keyWord").bind('keyup',function(e) {
				if (e.keyCode == 13) {
					var keyWord = $("#searchSysDefRule_keyWord").val();
					$('#sysDefRuleGrid').jqGrid('setGridParam', {
						datatype : 'json',
						postData : {
							'keyWord' : keyWord
						}
					}).trigger("reloadGrid");
				}
			});
		}
	</script>
</body>
</html>