<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<%
	String pdId = request.getParameter("pdId");
	String startDateBegin = request.getParameter("startDateBegin");
	String startDateEnd = request.getParameter("startDateEnd");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程实例信息</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/browserSupportedTest.js"></script>
</head>

<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';

$(function(){
	loadProcessEntry();
});

function loadProcessEntry(){
	var dataGridHeight = $(".easyui-layout").height();
	$('#processentrylist').datagrid({
		url: 'platform/bpm/processAnalysisAction/getProcessInstanceListByPage.json?pdId=<%=pdId%>&state=ended&startDateBegin=<%=startDateBegin%>&startDateEnd=<%=startDateEnd%>',
		width: '100%',
	    nowrap: false,
	    striped: true,
	    autoRowHeight:false,
	    singleSelect:false,
	    checkOnSelect:false,
	    remoteSort : false,
		height: dataGridHeight,
		fitColumns: true,
		sortName: 'duration',  //排序字段,当表格初始化时候的排序字段
		sortOrder: 'desc',    //定义排序顺序
		pagination:true,
		pageSize:20,
		rownumbers:true,
		queryParams:{"":""},
		loadMsg:' 处理中，请稍候…',
		columns:[[
			{field:'id',hidden:true},
			{field:'businessName',title:'业务目录',width:50,align:'left'},
			{field:'entryid',title:'流程实例ID',width:30,align:'left',sortable:true,
				formatter:function(value,rec){
  					var processInstance = "'"+rec.entryid+"'";
  					var state = "'"+rec.state+"'";
  					var id =  "'"+rec.id+"'";
  					return '<a href="javascript:window.trackBpm('+processInstance+')">'+value+'</a>';
  				}},
			{field:'entryname',title:'流程实例名称',width:50,align:'left',sortable:true},
			{field:'definename',title:'流程定义名称',width:60,align:'left',sortable:true},
			{field:'userid',title:'创建者',width:25,align:'left',sortable:true},
			{field:'deptid',title:'创建部门',width:50,align:'left',sortable:true},
			{field:'startdate',title:'启动时间',width:50,align:'left',sortable:true,
  				formatter:function(value,rec){
  					var startdateMi=rec.startdate;
  					if(startdateMi==undefined){
  						return;
  					}
  					var newDate=new Date(startdateMi);
  					return newDate.Format("yyyy-MM-dd hh:mm:ss");   
				}},
			{field:'enddate',title:'结束时间',width:50,align:'left',editor:'text',
  				formatter:function(value,rec){
  					var endateMi=rec.enddate;
  					if(endateMi==undefined){
  						return;
  					}
  					var newDate=new Date(endateMi);
  					return newDate.Format("yyyy-MM-dd hh:mm:ss");   
				}},
		    {field:'duration',title:'耗时(分钟)',width:40,align:'left',sortable:true}
		]]
	});
	//设置分页控件   
	var p = $('#processentrylist').datagrid('getPager');
	$(p).pagination({
	    pageSize: 20,//每页显示的记录条数，默认为10
	    pageList: [5,10,15,20,25,30],//可以设置每页记录条数的列表
	    beforePageText: '第',//页数文本框前显示的汉字
	    afterPageText: '页    共 {pages} 页',
	    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	});
}
function trackBpm(processInstanceId){
	var url = getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessTrack.jsp";
	if(!myBrowserSupported.isBrowserSupported()){
		url = getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessTrack_bak.jsp";
	}
	url += "?processInstanceId="+processInstanceId;
	window.open(encodeURI(url),"流程图","scrollbars=no,status=yes,resizable=no,top=0,left=0,width=700,height=400");
	//var usd = new UserSelectDialog("trackdialog","500","400",encodeURI(url) ,"流程跟踪窗口");
	//usd.show();
}


</script>
<body class="easyui-layout" fit="true">
<div region="center" border="false" style="overflow: hidden;">
<table id="processentrylist"></table>
</div>
</body>
</html>