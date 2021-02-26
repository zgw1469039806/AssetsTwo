<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的流程</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<style type="text/css">
.myHidden{
	display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,width:300">
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="tabs" fit="true" style="width: 100%; height: 100%;">
			<div title="我的草稿">
				<div id="draftToolbar" class="datagrid-toolbar myHidden">
					<table style="width: 100%">
						<tr>
							<td>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-remove" plain="true"
										href="javascript:void(0);" id="deleteButton">删除</a>
								</div>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input
											class="easyui-validatebox ext-selector-input keySearchClass"
											title="请输入标题" id="draftKeyInput"> <span
											class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true"
										href="javascript:void(0);" id="draftSearchId">高级查询 <span
										class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table class="myHidden" id="draftGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#draftToolbar',
				idField :'dbId',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbId', halign:'center', checkbox:true"></th>
							<th data-options="field:'executionId', hidden:true"></th>
							<th data-options="field:'processInstance', hidden:true"></th>
							<th data-options="field:'title', halign:'center', formatter:getTraceButtons" width="220">标题</th>
							<th data-options="field:'startDate', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'taskSendUser', align:'center'" width="80">发送人</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的申请">
				<div id="applyToolbar" class="datagrid-toolbar myHidden">
					<table style="width: 100%">
						<tr>
							<td>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input
											class="easyui-validatebox ext-selector-input keySearchClass"
											title="请输入标题" id="applyKeyInput"> <span
											class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true"
										href="javascript:void(0);" id="applySearchId">高级查询 <span
										class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table class="myHidden" id="applyGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#applyToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', hidden:true"></th>
							<th
								data-options="field:'title', halign:'center', formatter:getTraceButtons"
								width="200">标题</th>
							<th
								data-options="field:'startDate', align:'center', formatter:formatTime"
								width="140">申请日期</th>
							<th data-options="field:'activityName', halign:'center'"
								width="140">当前节点</th>
							<th
								data-options="field:'businessState', align:'center', formatter:formatState"
								width="80">状态</th>
							<th data-options="field:'assigneeName', align:'center'"
								width="80">处理人</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的经办">
				<div id="finisheddoToolbar" class="datagrid-toolbar myHidden">
					<table style="width: 100%">
						<tr>
							<td>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input
											class="easyui-validatebox ext-selector-input keySearchClass"
											title="请输入标题" id="finisheddoKeyInput"> <span
											class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true"
										href="javascript:void(0);" id="finisheddoSearchId">高级查询 <span
										class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table class="myHidden" id="finisheddoGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#finisheddoToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', hidden:true"></th>							
							<th
								data-options="field:'title', halign:'center', formatter:getTraceButtons"
								width="200">标题</th>
							<th
								data-options="field:'startDate', align:'center', formatter:formatTime"
								width="140">申请日期</th>
							<th data-options="field:'activityName', halign:'center'"
								width="140">当前节点</th>
							<th
								data-options="field:'businessState', align:'center', formatter:formatState"
								width="80">状态</th>
							<th data-options="field:'assigneeName', align:'center'"
								width="80">处理人</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="draftDialog" style="overflow: auto; display: none">
		<form id="draftSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="title" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="startDateBegin"
						class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="startDateEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="applyDialog" style="overflow: auto; display: none">
		<form id="applySearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="title" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">流程状态:</th>
					<td width="39%"><select class="easyui-combobox"
						style="width: 99%;" name="businessState"
						data-options="editable:false">
							<option value="">请选择</option>
							<option value="start">拟稿中</option>
							<option value="active">流转中</option>
							<option value="ended">已完成</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="startDateBegin"
						class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="startDateEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="finisheddoDialog" style="overflow: auto; display: none">
		<form id="finisheddoSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="title" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">流程状态:</th>
					<td width="39%"><select class="easyui-combobox"
						style="width: 99%;" name="businessState"
						data-options="editable:false">
							<option value="">请选择</option>
							<option value="start">拟稿中</option>
							<option value="active">流转中</option>
							<option value="ended">已完成</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden"
						name="userId" id="finisheddouserId" />
						<div class="">
							<input class="easyui-validatebox" type="text"
								name="receptUserName" id="finisheddoreceptUserName"
								readOnly="readOnly"></input>
						</div></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden"
						name="deptId" id="finisheddodeptId" />
						<div class="">
							<input class="easyui-validatebox" type="text"
								name="applyDeptidAlias" id="finisheddoapplyDeptidAlias"
								readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="startDateBegin"
						class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="startDateEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>				
			</table>
		</form>
	</div>
</body>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmprocess/js/BpmProcessPage.js"></script>
<script type="text/javascript">
	$(function() {
		var draftGrid = new BpmProcessPage(
				"draft",
				"bpm/process/searchHistProcessByPage?type=0",
				"我的草稿", 0, true);
		var applyGrid = new BpmProcessPage(
				"apply",
				"bpm/process/searchHistProcessByPage?type=1",
				"我的申请", 1, true);
		var finisheddoGrid = new BpmProcessPage(
				"finisheddo",
				"bpm/process/searchHistProcessByPage?type=2",
				"我的经办", 2, true);
		var flg = new Array();
		$('#tabs').tabs({
			onSelect : function(title, index) {
				if (!flg[index]) {
					if(index == 0){
						draftGrid.realod();
					}else if(index == 1){
						applyGrid.realod();
					}else if(index == 2){
						finisheddoGrid.realod();
					}flg[index] = true;
				}
			}
		});
		$('#tree').tree({
			url : 'bpm/monitor/getFlowModelTree',
			onSelect : function(node) {
				var queryParams = {
					nodeId : node.id,
					nodeType : node.attributes.nodeType,
					pdId : node.attributes.pdId || ''
				};
				draftGrid.setQueryParams(queryParams);
				applyGrid.setQueryParams(queryParams);
				finisheddoGrid.setQueryParams(queryParams);
				flg[0] = true;
				flg[1] = true;
				flg[2] = true;
				draftGrid.realod();
				applyGrid.realod();
				finisheddoGrid.realod();
				var tab = $('#tabs').tabs('getSelected');
				var index = $('#tabs').tabs('getTabIndex', tab);
				flg[index] = true;
				if(index == 0){
					draftGrid.realod();
				}else if(index == 1){
					applyGrid.realod();
				}else if(index == 2){
					finisheddoGrid.realod();
				}
			},
			onLoadSuccess : function(node) {
				var select = $('#tree').tree("getSelected");
				if (select == null) {
					var root = $('#tree').tree("getRoot");
					$('#tree').tree('select', root.target);
				}
			}
		});  		
		//删除  		
		$("#deleteButton").on("click", function() {			
			var rows = $("#draftGrid").datagrid('getChecked');
			if (rows == null || rows == '' || rows.length < 1) {
				$.messager.alert('提示','请选择要删除的记录！','warning');
				return;
			}
			var entryIds = '';
			var executionIds = '';
			 $.messager.confirm('请确认','您确定要删除当前所选的流程实例？',function(b){
				if(b){
					for (var i = 0; i < rows.length; i++) {
						var rowData = rows[i];
							entryIds = rowData.dbId;
							executionIds = rowData.executionId;														
				 $.ajax({
					 url: "platform/bpm/bpmConsoleAction/deleteProcessEntry",
			         data: "processInstanceId=" + executionIds+"&entryId=" + entryIds,
			         type: "post",
			         dataType: "json",						
					 success: function (backData) {
			            	if (backData != null && backData.success == true) {
			            		$.messager.show({
			            			msg:'删除成功',
			            			timeout:300,
			            			showType:'fade'
			            		});  
			            		 draftGrid.realod();
			            	} else {
			            		$.messager.show({
			            			msg:'操作失败',
			            			timeout:300,
			            			showType:'fade'
			            		});  
			            	}	               
			           }
				 }); 
			   }
			}
		 });			 
	});
		
		$('.keySearchClass').attr('placeholder', '请输入标题');
		$('.combo').bind('click', function() {//解决高级查询控件层级问题
			$('.panel.combo-p').css('z-index', 999999999)
		});
		inputPlaceHolder();
		flowUtils.getBatchHandleInfo();
	});
//打开详情页面	
  	var getTraceButtons = function(cellvalue, row) {
		if (cellvalue == undefined || cellvalue == '') {
			cellvalue = row.procDefName;
			if (cellvalue == undefined || cellvalue == '') {
				cellvalue = "无";
			}
		}
		return '<a href="javascript:void(0)" onClick="flowUtils.detail(\''+row.dbId+'\')">'+cellvalue+'</a>';
	};  
	
	function formatTime(value, row, index) {
		var startdateMi = value;
		if (startdateMi == undefined) {
			return '';
		}
		var newDate = new Date(startdateMi);
		return newDate.format("yyyy-MM-dd hh:mm:ss");
	}

	function formatState(value, row, index) {
		if (value == 'start') {
			return '拟稿中';
		} else if (value == 'active') {
			return '流转中';
		} else if (value == 'ended') {
			return '已完成';
		} else {
			return value;
		}
	}
	//js中的字符串正常显示在HTML页面中 
	function escapeHtml(string) {
		var entityMap = {
			"&" : "&amp;",
			"<": "&lt;",
	        ">" : "&gt;",
			'"' : '&quot;',
			"'" : '&#39;',
			"/" : '&#x2F;'
		};
		return String(string).replace(/[&<>"'\/]/g, function(s) {
			return entityMap[s];
		});
	}

	function bpm_operator_refresh() {
		var select = $('#tree').tree("getSelected");
		$('#tree').tree('select', select.target);
	}
</script>
</html>