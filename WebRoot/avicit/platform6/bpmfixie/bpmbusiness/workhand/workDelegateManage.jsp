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
</head>
<body>
		<div id="tabs" fit="true" style="width: 100%; height: 100%;">
			<div title="我的委托">
				<div id="entrustToolbar" class="datagrid-toolbar">
					<table style="width: 100%">
						<tr>
							<td>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										href="javascript:void(0);" id="addButton">新建委托</a>
									<a class="easyui-linkbutton" iconCls="icon-edit" plain="true"
										href="javascript:void(0);" id="fetchButton">拿回已移交的待办</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table id="entrustGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#entrustToolbar',
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
							<th data-options="field:'id', hidden:true" width="75"></th>
							<th data-options="field:'workOwnerName', halign:'center',formatter:formatDetail" width="150">委托人</th>
							<th data-options="field:'receptUserName', align:'center'" width="200">受托人</th>
							<th data-options="field:'receptDeptName', align:'center'" width="200">受托人部门</th>
							<th data-options="field:'attribute01', align:'center',formatter:way" width="100">委托方式</th>
							<th data-options="field:'handReason', align:'center'" width="150">移交原因</th>
							<th data-options="field:'handDate', align:'center',formatter:formatterDate" width="150">创建时间</th>
							<th data-options="field:'handEffectiveDate', align:'center',formatter:formatterDate" width="150">开始时间</th>
							<th data-options="field:'backDate', align:'center',formatter:formatterDate" width="150">结束时间</th>
							<th data-options="field:'validFlag', align:'center',formatter:formatterValidFlag" width="150">当前状态</th>
							<th data-options="field:'caozuo', align:'center',formatter:act" width="100">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的受托">
				<table id="trusteeGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#trusteeToolbar',
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
							<th data-options="field:'id', hidden:true" width="75"></th>
							<th data-options="field:'workOwnerName', halign:'center',formatter:formatDetail" width="150">委托人</th>
							<th data-options="field:'receptUserName', align:'center'" width="200">受托人</th>
							<th data-options="field:'receptDeptName', align:'center'" width="200">受托人部门</th>
							<th data-options="field:'handReason', align:'center'" width="150">移交原因</th>
							<th data-options="field:'handDate', align:'center',formatter:formatterDate" width="150">创建时间</th>
							<th data-options="field:'handEffectiveDate', align:'center',formatter:formatterDate" width="150">开始时间</th>
							<th data-options="field:'backDate', align:'center',formatter:formatterDate" width="150">结束时间</th>
							<th data-options="field:'validFlag', align:'center',formatter:formatterValidFlag" width="150">当前状态</th>
							<th data-options="field:'caozuo', align:'center',formatter:formatterOpt" width="100">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
</body>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmfixie/bpmbusiness/workhand/js/WorkHand.js"></script>
<script type="text/javascript">
	var entrustGrid;
	var trusteeGrid;
	$(function() {
		entrustGrid = new WorkHand(
				"entrust",
				"platform/bpm/clientbpmWorkHandAction/getSysWorkHandListByPage",
				"我的委托", 0);
		trusteeGrid = new WorkHand(
				"trustee",
				"platform/bpm/clientbpmWorkHandAction/getSysWorkHandListByPage?queryType=2",
				"我的受托", 1);
		var flg = new Array();
		$('#tabs').tabs({
			onSelect : function(title, index) {
				if (!flg[index]) {
					if(index == 0){
						entrustGrid.realod1();
					}else if(index == 1){
						trusteeGrid.realod1();
					}flg[index] = true;
				}
			}
		});  				
	});
	function formatDetail(cellvalue, options, rowObject){
		return '<a  href="javascript:void(0)" '
		+'  title="委托详情" onClick="entrustGrid.workHandDetail(\''+options.id+'\')">'+cellvalue+'</a>';
	};	 
	function way(value, options, rowObject) {
		if (value == '0') {
			return "系统";
		} else {
			return "自定义";
		}
	}
	
	function formatterValidFlag(cellvalue, options, rowObject) {
    	var validString = "";
    	if(cellvalue == "1"){
    		var beginDate = options.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr>nowDateStr){
    			validString = "未开始";
    		}else{
    			validString = "委托中";
    		}
  	  }else if(cellvalue == "0"){
  	      validString = "无效";
  	  }else if(cellvalue == "2"){
  	      validString = "已完成";
  	 }
  	 return validString;
   };

	function formatterDate(value, row, index) {
		var startdateMi = value;
		if (startdateMi == undefined) {
			return '';
		}
		var newDate = new Date(startdateMi);
		return newDate.format("yyyy-MM-dd");
	};
	
	function act(value, options, rowObject) {
		var html = '<a href="javascript:void(0)" name="btn-flow-variable-delete" onclick="entrustGrid.deleteData(\''+options.id+'\')">删除</a>';
		if(options.validFlag == "1"){
    		var beginDate = options.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr<=nowDateStr){
    			html += ' | <a href="javascript:void(0)" name="btn-flow-variable-delete" onclick="entrustGrid.completeData(\''+options.id+'\')">完成</a>';
    		}
   	 }
   	 return html;
	};
	
	function formatterOpt(value, options, rowObject) {
		var html = '';
    	if(options.validFlag == '1'){
    		var beginDate = options.handEffectiveDate;
    		var beginDateStr = (new Date(beginDate)).format("yyyy-MM-dd");
    		var nowDate = new Date();
    		var nowDateStr = nowDate.format("yyyy-MM-dd");
    		if(beginDateStr>nowDateStr){
    			html += '<a href="javascript:void(0)" name="btn-flow-variable-reject" onclick="trusteeGrid.rejectWorkhand(\''+options.id+'\')">驳回</a>';
    		}
    	}    
    	return html;
	};
	//新建委托按钮绑定事件
	$("#addButton").on("click", function() {	
		entrustGrid.insert();
	});
	//拿回已移交的待办按钮绑定事件
	$("#fetchButton").on("click", function() {	
		entrustGrid.fetch();
	});
	function bpm_operator_refresh() {
		var select = $('#tree').tree("getSelected");
		$('#tree').tree('select', select.target);
	}
</script>
</html>