<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<%
	String basePath = ViewUtil.getRequestPath(request);//request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	String processInstanceId = request.getParameter("processInstanceId");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程跟踪</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
</head>
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
	var mxBasePath = _basePath + "static/js/platform/designer/";
	var _picturePath = _basePath + "static/js/platform/bpm/client/picture/";
	var _processInstanceId = "<%=processInstanceId %>";
</script>
<script src="<%=basePath%>static/js/platform/component/common/mxClient.js"></script>
<script src="<%=basePath%>static/js/platform/designer/mxApplication.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/ComUtils.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/MyAction.js"></script>
<!-- 元素 -->
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyBase.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyTransition.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyStart.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyEnd.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyTask.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJava.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MySql.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyWs.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyState.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyFork.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJoin.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyExclusive.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MySubprocess.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyForeach.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJms.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyCustom.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyText.js"></script>

<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var processInstanceId = '<%=processInstanceId%>';
$(function(){
	$(window).resize(function(){
		$('#tsp').datagrid('resize');//信息列表 datagrid
		$('.easyui-panel').panel('resize');//搜索栏 panel
		});
	$('#track').tabs({
		fit: true,
	    onSelect:function(title,index){
	       if(index == 0){
	       }
		   if(index == 1){
				createLS();
			}
			if(index == 2){
	    	   createSP();
			}
	    }   
	});
	
	//调整dataGrid自适应
 	$(window).resize(function() {
		$('#track').tabs({
			 width : $("#track").parent().width(),
			 height : "auto"
		}).tabs('resize');
	});
	$(".tabs-header").css("z-index", "9999");
});

function createSP(){
	$('#tsp').datagrid({
		url: 'platform/bpm/clientbpmdisplayaction/getcharactertrack.json?processInstanceId='+processInstanceId,
		width: $(document).width() - 20,
		fit: true,
	    nowrap: false,
	    striped: true,
	    autoRowHeight:false,
		height: 'auto',
		remoteSort : false,
		sortName: 'intoTime',  //排序字段,当表格初始化时候的排序字段
		sortOrder: 'asc',    //定义排序顺序
		fitColumns: true,
		pagination:true,
		pageSize: dataOptions.pageSize,
		pageList: dataOptions.pageList,
		rownumbers:true,
		columns:[[
			{field:'currentActiveLabel',title:'当前节点',width:50,align:'left',sortable:true},
			{field:'assigneeName',title:'接收人',width:40,align:'left',sortable:true},
			//{field:'assigneeDeptName',title:'接收人部门',width:60,align:'left',sortable:true},
			{field:'operateUserName',title:'处理人',width:40,align:'left',sortable:true},
			{field:'iTime',title:'到达时间',width:80,align:'center',sortable:true},
			{field:'oTime',title:'打开时间',width:80,align:'center',sortable:true},
			{field:'eTime',title:'完成时间',width:80,align:'center',sortable:true},
			{field:'opType',title:'处理类型',width:80,align:'center',sortable:true},
			{field:'compelManner',title:'强制表态',width:80,align:'center',sortable:true,formatter:formatCompel},
			{field:'message',title:'意见',width:100,align:'left',sortable:true},
			{field:'intoTime',hidden:true}
		]]
	});
}
function formatCompel(value,row,index){
	if(value){
		if(value == "yes"){
			return "同意";
		}else if(value == "no"){
			return "不同意";
		}
	}
	return "未表态";
}
function createLS(){
	$('#tls').datagrid({
		url: 'platform/bpm/clientbpmdisplayaction/gethistoryactivity.json?processInstanceId='+processInstanceId,
		width: '100%',
		height: 'auto',
		fit: true,
	    nowrap: false,
	    striped: true,
		autoRowHeight: false,
		fitColumns: true,
		remoteSort : false,
		pagination:true,
		pageSize: dataOptions.pageSize,
		pageList: dataOptions.pageList,
		rownumbers:true,
		columns:[[
			//{field:'type',title:'节点类型',width:30,align:'center',sortable:true},
			{field:'alias',title:'节点名称',width:60,align:'center',sortable:true},
			//{field:'transitionName',title:'流转名称',width:60,align:'center',sortable:true},
			{field:'sTime',title:'开始时间',width:80,align:'center',sortable:true},
			{field:'eTime',title:'结束时间',width:80,align:'center',sortable:true},
			{field:'consumeTime',title:'耗时',width:80,align:'center',sortable:true}
		]]
		
	});
}

</script>
<body class="easyui-layout" fit="true">
<div id="track">
	<div title="图形跟踪" style="padding:2px;width:auto">
		<div style="position:absolute;left:0px;top:0px;width:100%;height:100%;overflow:auto;">
			<div id="buts" style="position:absolute;left:10px;top:35px;z-index:2">
			<!-- 暂时屏蔽吧，好像还有问题 -->
				<a id="playBut" class="easyui-linkbutton" plain="false" href="javascript:void(0);">播放动画</a>
				<a id="stopBut" class="easyui-linkbutton" plain="false" href="javascript:void(0);">停止动画</a>
			</div>
			<div id="graph" style="position:absolute;left:0px;top:60px;">
				<div id="mi" style="position:absolute;left:0px;top:0px;width:8px;height:8px;background-color:red;display:none;border-radius:4px;border:solid red 1px;"></div>
				<div id="bo" style="position:absolute;left:0px;top:0px;width:65px;height:60px;display:none;border:solid red 2px;"></div>
			</div>
		</div>
	</div>
	<div title="历史流转" style="padding:2px;width:auto"><table id="tls"></table></div>
	<div title="意见审批" style="padding:2px;width:auto"><table id="tsp"></table></div>
</div>
</body>
</html>