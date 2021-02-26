<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<!-- <link href="static/fixie/css/24px/style.css" rel="stylesheet"
	type="text/css"> -->
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<style type="text/css">
select {
height: 28px;
	}
	
	.aaa {
    float: left;
    margin-left: 10px;
    margin-right: 10px;
}

optgroup {
font-family:'微软雅黑';font-style:normal ;
}

</style>
</head>
<body class="easyui-layout" fit="true">
				<div id="draftToolbar" class="datagrid-toolbar">
					<table style="width: 100%">
						<tr>
							<td>
							    <div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										href="javascript:void(0);" id="addButton">发送</a>
								</div>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-remove" plain="true"
										href="javascript:void(0);" id="deleteButton">删除</a>
								</div>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-ok" plain="true"
										href="javascript:void(0);" id="readButton">标记已读</a>
								</div>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-undo" plain="true"
										href="javascript:void(0);" id="unreadButton">标记未读</a>
								</div>
								<table  width="100%">
								     	<tr>
									     	<td>
									     		<select id="selectSearch" style=" height: 24px;">
					   		                            <optgroup label="我的接收">
					                                    <option value="all">全部</option>
							                            <option value="unread" selected="selected">未读</option>		  
							                            <option value="read">已读</option>
					                           		    </optgroup>
							                            <option value="" disabled>——————</option>
							  	                        <option value="send">我的发送</option>
			                      		 		</select>
									     	</td>
									     	<td style="position:relative">
									     		<input
													class="easyui-validatebox ext-selector-input keySearchClass"
													title="请输入标题" id="keyWord">
													<span id="searchPart" style="right: 14px;*right:27px;top: 4px;" class="ext-input-right-icon ext-icon search" style="">
														<label for="headSubmit" class="icon white icon-search head-search" style="">
														</label>
													</span>
									     	</td>
									     	<td>
									     		<a class="easyui-linkbutton" plain="true"
												href="javascript:void(0);" id="draftSearchId" style="">高级查询 <span
												class="caret"></span></a> <span class="ext-icon changyong"></span>
											</td>
								     	</tr>
								     </table>
							</td>
						</tr>
					</table>
				</div>
				<table id="draftGrid"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#draftToolbar',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'id', halign:'center', checkbox:true" width="75"></th>
							<th data-options="field:'broadcastFlag', hidden:true" width="50"></th>
							<th data-options="field:'recvOrSend', hidden:true" width="50"></th>
							<th data-options="field:'title', halign:'center', formatter:formatValue" width="150">标题</th>
							<th data-options="field:'content', formatter:formatContentValue" width="150">内容</th>
							<th data-options="field:'sourceName', align:'center'" width="150">来源</th>
							<th data-options="field:'sendUserAlias', align:'center'" width="150">发送人</th>
							<th data-options="field:'sendDeptidAlias', align:'center'" width="150">发送人部门</th>
							<th data-options="field:'sendDate', align:'center'" width="150">发送日期</th>
							<th data-options="field:'recvUserAlias', align:'center', formatter:formatRecvValue" width="150">接收人</th>
							<th data-options="field:'recvDate', align:'center'" width="150">接收日期</th>
							<th data-options="field:'isReaded', align:'center' ,formatter:formatReadValue" width="100">是否已读</th>
							
						</tr>
					</thead>
				</table>
	<div id="draftDialog" style="overflow: auto; display: none">
		<form id="draftSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
				<th width="10%">标题:</th>
				<td width="39%"><input title="标题"
					class="easyui-validatebox" type="text" name="title" id="title" />
				</td>
				<th width="10%">内容:</th>
				<td width="39%"><textarea class="textareabox"
						rows="3" title="内容" name="content" id="content"></textarea>
				</td>
			</tr>
			</tr>
				<tr>
				<th width="10%">发送人:</th>
				<td width="39%">
					<span class="combo datebox" style="width: 173px; height: 20px;">
						<input type="hidden" id="sendUser" name="sendUser">
						<input type="text" class="combo-text validatebox-text validatebox-invalid" placeholder="请选择用户"  title="请选择用户" id="sendUserAlias" name="sendUserAlias" style="cursor: pointer; width: 155px; height: 20px; line-height: 20px;">
						<span>
							<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from" id="sendUserAlias" name="sendUserAlias"></span>
						</span>
					</span>
				</td>
				<th width="10%">发送人部门:</th>
				<td width="39%">
					<span class="combo datebox" style="width: 173px; height: 20px;">
						<input type="hidden" id="sendDeptid" name="sendDeptid">
						<input type="text" class="combo-text validatebox-text validatebox-invalid" placeholder="请选择部门"  title="请选择部门" id="sendDeptidAlias" name="sendDeptidAlias" style="cursor: pointer; width: 155px; height: 20px; line-height: 20px;">
						<span>
							<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from" id="sendDeptidAlias" name="sendDeptidAlias"></span>
						</span>
					</span>
				</td>
			</tr>
			<tr>
			<th width="10%">发送日期(开始):</th>
				<td width="39%">
						<input class="easyui-datetimebox" type="text" data-options="required:true"
						editable="false"
							name="sendDateBegin" id="sendDateBegin" /> 
				</td>
				<th width="10%">发送日期(结束):</th>
				<td width="39%">
						<input class="easyui-datetimebox" type="text" data-options="required:true"
						editable="false"
							name="sendDateEnd" id="sendDateEnd" /> 
				</td>
			</tr>
				<tr>
				<th width="10%">我的接收</th>
				<td width="39%">
				<pt6:JigsawRadio class="radio-inline"  title="发送接收"> <input name="msgTypes" title="全部" type="radio" value="0">全部</label>
				<pt6:JigsawRadio class="radio-inline"  title="发送接收"> <input name="msgTypes" title="未读" type="radio" value="1">未读</label>
				<pt6:JigsawRadio class="radio-inline"  title="发送接收"> <input name="msgTypes" title="已读" type="radio" value="2">已读</label>
				</td>
				<th width="10%">我的发送</th>
				<td width="39%">
				<label class="radio-inline"  title="我的发送"> <input name="msgTypes" title="我的发送" type="radio" value="3"></label>
					</td>

			</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript"
	src="avicit/platform6/portalie/js/SysMsgIe6.js"></script>
<script src='avicit/platform6/portal/message/js/moment.min.js'></script>
<script type="text/javascript">
var SysMsgIe6;
function formatValue(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);" onclick="SysMsgIe6.detail(\''+ options.id +'\');">'+cellvalue+'</a>';
}
function formatDateForHref(cellvalue, options, rowObject) {
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="SysMsgIe6.detail(\''
			+ rowObject.id + '\');">' + thisDate + '</a>';
}
function formatContentValue(cellvalue, options, rowObject) {
	return '<a id="'+rowObject.id+'_content" onMouseOver="SysMsgIe6.contentTips(\''
	+ rowObject.id + '_content\',\''+cellvalue+'\');" onMouseOut="SysMsgIe6.closeContentTips();" >' + cellvalue + '</a>';			
}

function formatRecvValue(cellvalue, options, rowObject) {

	return '<a id="'+rowObject.id+'_recv" onMouseOver="SysMsgIe6.recvTips(\''
	+ rowObject.id + '_recv\',\''+cellvalue+'\');" onMouseOut="SysMsgIe6.closeRecvTips();" >' + cellvalue + '</a>';			
}

function formatReadValue(cellvalue, options, rowObject) {
    if(cellvalue == "是"){
		return '消息已读';
	}else{
		return '消息未读';	
	}
}
	$(document).ready(
	     function() {
		var searchNames = new Array();
		var searchTips = new Array();
		searchNames.push("title");
		searchTips.push("标题");
		searchNames.push("content");
		searchTips.push("内容");
		$('#keyWord').attr('placeholder',
		'请输入' + searchTips[0] + '或' + searchTips[1]);
		SysMsgIe6 = new SysMsgIe6(
				"draft",
				"msystem/sysmsg/sysMsgController/operation/getSysMsgsByPage", 'keyWord', searchNames,'selectSearch','draftDialog');	
	//删除  		
	$("#deleteButton").on("click", function() {	
			var rows = $("#draftGrid").datagrid('getChecked');
			var ids = [];
			var datas = [];
			if (rows == null || rows == '' || rows.length < 1) {
				$.messager.alert('提示','请选择要删除的记录！','warning');
				return;
			}
			$.messager.confirm('请确认','您确定要删除当前所选的消息？',function(b){
				if(b){
					for (var i = 0; i < rows.length; i++) {
						var rowData = rows[i];
						var sys_msg= {
								id:rowData.id,
								broadcastFlag:rowData.broadcastFlag					
						};
						datas.push(sys_msg);	
					 }
				 $.ajax({
					 url: "msystem/sysmsg/sysMsgController/operation/delete",
					 data:	{
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
			         success : function(r){
						 if (r.flag == "success") {
							 $.messager.show({
			            			msg:'删除成功',
			            			timeout:300,
			            			showType:'fade'
			            		});
							 $("#draftGrid").datagrid("reload");
						}else{
							$.messager.show({
		            			msg:'操作失败',
		            			timeout:300,
		            			showType:'fade'
		            		});
						}
					 }        
				 }); 
			  
			}
		 });			 
	});
	$('.keySearchClass').attr('placeholder', '请输入标题或内容');
	$('.combo').bind('click', function() {//解决高级查询控件层级问题
		$('.panel.combo-p').css('z-index', 999999999)
	});
	inputPlaceHolder();
	//添加按钮绑定事件
	$("#addButton").on("click", function() {	
	    SysMsgIe6.add("addButton");
	});
	//已读按钮
	$("#readButton").on("click", function() {	
		    var rows = $("#draftGrid").datagrid('getChecked');
			var ids = [];
			var datas = [];
			if (rows == null || rows == '' || rows.length < 1) {
				$.messager.alert('提示','请选择要标记的记录！','warning');
				return;
			}
			$.messager.confirm('请确认','确定要标记已读吗?',function(b){
				if(b){
					for (var i = 0; i < rows.length; i++) {
						var rowData = rows[i];
						var sys_msg= {
								id:rowData.id,
								broadcastFlag:rowData.broadcastFlag					
						};
						datas.push(sys_msg);	
					 }
				 $.ajax({
					 url: "msystem/sysmsg/sysMsgController/operation/doread",
					 data:	{
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
			         success : function(r){
						 if (r.flag == "success") {
							 $.messager.show({
			            			msg:'标记已读成功',
			            			timeout:300,
			            			showType:'fade'
			            		});
							 $("#draftGrid").datagrid("reload").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						}else{
							$.messager.show({
		            			msg:'操作失败',
		            			timeout:300,
		            			showType:'fade'
		            		});
						}
					 }        
				 }); 
			  
			}
		 });			 
	});
	//未读按钮
	$("#unreadButton").on("click", function() {	
		    var rows = $("#draftGrid").datagrid('getChecked');
			var ids = [];
			var datas = [];
			if (rows == null || rows == '' || rows.length < 1) {
				$.messager.alert('提示','请选择要标记的记录！','warning');
				return;
			}
			$.messager.confirm('请确认','确定要标记未读吗?',function(b){
				if(b){
					for (var i = 0; i < rows.length; i++) {
						var rowData = rows[i];
						var sys_msg= {
								id:rowData.id,
								broadcastFlag:rowData.broadcastFlag					
						};
						datas.push(sys_msg);	
					 }
				 $.ajax({
					 url: "msystem/sysmsg/sysMsgController/operation/dounread",
					 data:	{
						 datas:JSON.stringify(datas)
					 },
					 type : 'post',
					 dataType : 'json',
			         success : function(r){
						 if (r.flag == "success") {
							 $.messager.show({
			            			msg:'标记未读成功',
			            			timeout:300,
			            			showType:'fade'
			            		});
							 $("#draftGrid").datagrid("reload").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						}else{
							$.messager.show({
		            			msg:'操作失败',
		            			timeout:300,
		            			showType:'fade'
		            		});
						}
					 }        
				 }); 
			  
			}
		 });			 
	});
	//查询按钮绑定事件
	$('#searchPart').bind('click', function() {
		SysMsgIe6.searchByKeyWord();
	});
	/* //打开高级查询框
	$('#draftSearchId').bind('click', function() {
		SysMsgIe6.openSearchForm(this);
	}); */
	//列表，分享下拉框，用于过滤数据
	$('#selectSearch').bind('change', function() {
		SysMsgIe6.selectSearchChange("selectSearch");
		// 			alert("选中改变");

	});
	//选人
	$("#sendUserAlias").on('focus', function(e) {
		new EasyuiCommonSelect({type : 'userSelect',
			                    idFiled : 'sendUser',
			                    textFiled : 'sendUserAlias'
			                   }
		);
		this.blur();
	});
	//选部门
	$("#sendDeptidAlias").on('focus', function(e) {
		new EasyuiCommonSelect({type : 'deptSelect',
			                    idFiled : 'sendDeptid',
			                    textFiled : 'sendDeptidAlias'
			                   }
		);
		this.blur();
	});

});

</script>
</html>