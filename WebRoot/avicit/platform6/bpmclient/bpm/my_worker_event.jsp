<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>      
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String userId = (String)session.getAttribute("userId");
	String skinColor = (String)request.getSession().getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
	if(skinColor == null){
		skinColor = "default";
	}
%>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="static/css/platform/themes/<%=skinColor %>/todo/todo.css" >
<script src="static/js/platform/component/common/browserSupportedTest.js"></script>
<script src="static/js/platform/component/boxover.js" type="text/javascript"></script>
<script type="text/javascript">
function restSetTabTitle(title,index){
	var tab = $('#myWorker').tabs('getTab',index);
	$('#myWorker').tabs('update', {
		tab: tab,
		options: {
			title: title
		}
	});
}
/**
 * 打开表单，执行task
 */
function executeTask(entryId,executionId,taskId,formId,url,title){
	if(url == null || url == ''){
		return ;
	}
	
	$.ajax({
		type : "POST",
		data : {processInstanceId: entryId},
		url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel", 
		dataType : "json",
		success : function(r) {
			var b = r.result;
			if(b){
				var proxyPage = "N"; //是否做页面代理
				if(url!=null&&url.indexOf("proxyPage=Y")!=-1){//是否做页面代理
					proxyPage = "Y";
				}
				
				if (proxyPage != "Y") { //不明确指定用代理页面的，则通通跳转到自己页面
			       if (url.indexOf("?") > 0) {
				    url += "&entryId=" + entryId;
				   }else{
				   	 url += "?entryId=" + entryId;
				   }
			        url += "&id=" + formId;
					url += "&executionId=" + executionId;
					url += "&taskId=" + taskId;
			       	try{
			       		if(typeof(eval(top.addTab))=="function"){
			       			top.addTab(title,encodeURI(url),"static/images/platform/index/images/icons.gif","taskTodo"," -0px -120px");
			       		}else{
			       			window.open(url);
			       		} 
			       	}catch(e){}
					return; 
				 }
				//以下都是采用代理页面的avicit/platform6/bpmclient/bpm/ProcessApprove.jsp
			    var redirectPath = "";
			    redirectPath += "?id=" + formId;
			    redirectPath += "&entryId=" + entryId;
			    redirectPath += "&executionId=" + executionId;
				redirectPath += "&taskId=" + taskId;
			    if (url.indexOf("?") > 0) {
			        url += "&entryId=" + entryId;
					url += "&id=" + formId;
					url += "&executionId=" + executionId;
					url += "&taskId=" + taskId;
			    }
			    else {
			        url += "?entryId=" + entryId;
					url += "&id=" + formId;
					url += "&executionId=" + executionId;
					url += "&taskId=" + taskId;
			    }
			    redirectPath += "&url=" + encodeURIComponent(url);
				try{
			   		if(typeof(eval(top.addTab))=="function"){
			   			redirectPath = "avicit/platform6/bpmclient/bpm/ProcessApprove.jsp"+redirectPath;
			   			top.addTab(title,redirectPath,"static/images/platform/index/images/icons.gif","taskTodo"," -0px -120px");
			   		}else{
			   			redirectPath = "ProcessApprove.jsp"+redirectPath;
			   			window.open(redirectPath);
			   		} 
			   	}catch(e){}
				return ;
			}else{
				$.messager.alert('提示','人员密级不符合要求，无法打开！');
			}
		}
	});
}
function trackBpm(processInstanceId){
	var url = getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessTrack.jsp";
	if(!myBrowserSupported.isBrowserSupported()){
		url = getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessTrack_bak.jsp";
	}
	url += "?processInstanceId="+processInstanceId;
	window.open(encodeURI(url),"流程图","scrollbars=no,status=yes,resizable=no,top=0,left=0,width=700,height=400");
}
var userId = '<%=userId%>';
$(function() {
	//待办事项
	$('#myWorkEventList').datagrid({
		url : 'bpm/clientbpmdisplayaction/getAllTaskByUserIdForMyWorkerEvent?userId=' + userId,
		height : 'auto',
		fitColumns : true,
		singleSelect : false,
		rownumbers : true,
		onLoadSuccess : function(data){
			var title = '待办事项(' + data.total + '项)';
			restSetTabTitle(title,0);
		},
		columns : [[
			{
				field : 'dbid',
				hidden : true
			},
			{
				field : 'title',
				title : '标题',
				width : 50,
				formatter : function(value, row, index) {
					return "<a href=\"javascript:window.executeTask('" + row.processInstance + "','" + row.executionId + "','" + row.dbid +  "','" + row.businessId + "','" + row.formResourceName + "','" + row.taskTitle + "')\" title=\"header=[<img border='0' src='static/images/platform/bpm/images/file1.gif'/>(" + row.taskName + ")" + row.taskTitle + "] cssheader=[dvhdr] cssbody=[dvbdy] body=[<table width='100%' border='0'><tr><td width='80%'>" + row.processDefName + "</td><td rowspan='3'><img border=0 src='static/images/platform/bpm/images/public.process.big.gif' /></td></tr><tr><td>" + row.taskSendUser + "(" + row.taskSendDept + ")</td></tr><tr><td>" + row.cTime +"</td></tr><tr><td colspan='2'>&nbsp;</td></tr></table>]\"><img border='0' src='static/images/platform/bpm/images/file.gif'/>(" + row.taskName + ")" + row.taskTitle + "</a>";
				}
			},
			{
				field : 'cTime',
				title : '日期',
				width : 30,
				align : 'center',
			},
			{
				field : 'taskSendUser',
				title : '发送人',
				width : 30
			},
			{
				field : 'priority',
				title : '优先级',
				width : 20,
				align : 'center',
				formatter:function(value,rec){
  					if(value == "2"){
  						return '<img align="center" src="static/images/platform/bpm/client/images/highest.gif"/>';
  					}else if(value == "1"){
  						return '<img align="center" src="static/images/platform/bpm/client/images/high.gif"/>';
  					}else{
  						return '<img align="center" src="static/images/platform/bpm/client/images/normal.gif"/>';
  					}
				}
			},{
				field : 'taskType',
				title : '类型',
				width : 20,
				align : 'center',
				formatter:function(value,rec){
  					if(value == "1"){
  						return '阅办';
  					}else {
  						return '待办';
  					}
				}
			}] ]
		});
	//已办事项
	$('#myWorkEventedList').datagrid({
			title : '',
			url : 'bpm/clientbpmdisplayaction/getfinishtodo.json?userId=' + userId + '&taskFinished=1&rows=200',
			height : 'auto',
			fitColumns : true,
			singleSelect : false,
			rownumbers : true,
			rownumbers:true,//行号
			onLoadSuccess : function(data){
				var title = '已办事项(' + data.total + '项)';
				restSetTabTitle(title,1);
			},
			columns : [[
				{
					field : 'dbid',
					hidden : true
				},
				{
					field : 'title',
					title : '标题',
					width : 30,
					formatter : function(value,row,index){
						return "<a href=\"javascript:window.trackBpm('" + row.processInstance + "')\" >(" + row.taskName + ")" + row.taskTitle + "</a>";
					}
				},
				{
					field : 'cTime',
					title : '日期',
					width : 30,
					align : 'center',
				},
				{
					field : 'taskSendUser',
					title : '发送人',
					width : 20,
					align : 'center'
				},
				{
					field : 'eTime',
					title : '结束时间',
					width : 20,
					align : 'center'
				}] ]
			});
});
</script>
<style type="text/css">
	.datagrid-header .datagrid-cell span{
		font-weight : 100;
	}
	.panel-body{
		padding-top : 0px;
		padding-left : 0px;
	}
	.dvhdr {
		width:200px;
		font-size: 14px;
		background:#E7E7E7;
		border:1px solid #D0D0D0;
		font-weight:bold;
		padding:3px;
		height:auto;
		vertical-align:middle;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	.dvbdy {
		width:300;
		background:#FFFFFF;
		border-left:1px solid #D0D0D0;
		border-right:1px solid #D0D0D0;
		border-bottom:1px solid #D0D0D0;
		padding:3px;
		color:#000ff;
	}
</style>
</head>
<body>
<div id="myWorker" class="easyui-tabs" style="width:700px;height:250px;">
		<div title="待办事项(0项)" style="padding:0px;">
			<div id="myWorkEventList"></div>
		</div>
		<div title="已办事项(0项)" style="padding:0px;">
			<div id="myWorkEventedList"></div>
		</div>
</div>
</body>
</html>
