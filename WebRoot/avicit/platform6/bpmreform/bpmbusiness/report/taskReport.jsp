<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>
<title>任务统计报表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

</style>

</head>
<body>
<div id="taskDayReport" style="overflow:hidden;height:315px;text-align:center;align:center"></div>

</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script src="static/h5/echarts/dist/echarts-all.js"
	type="text/javascript"></script>
<script type="text/javascript">
try{

//基于准备好的dom，初始化echarts实例
var taskDayReportChart = echarts.init(document.getElementById('taskDayReport'));
var days = decodeURIComponent(flowUtils.getUrlQuery("days"));

var taskDayReportOption = {
	    title : {
	        text: '个人任务日报',
	        x:'60',
	        y:'10',
	        textAlign:'left'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['接收任务','办理任务','待阅任务','已阅任务'],
	        x:'center',
	        y:'40',
	        textAlign:'left',
	        padding:[0,0,80,80]
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: false},
	            dataView : {show: false, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        },
	        padding:[10,80]
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : []
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'接收任务',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'办理任务',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'待阅任务',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'已阅任务',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        }
	    ]
	};
	



function showView(data){
	taskDayReportOption.xAxis[0]['data']=$.parseJSON(data.days);
	taskDayReportOption.series[0]['data']=$.parseJSON(data.toDoCount);
	taskDayReportOption.series[1]['data']=$.parseJSON(data.completeTaskCount);
	taskDayReportOption.series[2]['data']=$.parseJSON(data.toReadCount);
	taskDayReportOption.series[3]['data']=$.parseJSON(data.completeReadCount);
    // 使用刚指定的配置项和数据显示图表。
    taskDayReportChart.setOption(taskDayReportOption);
}

$(document).ready(function() {
	avicAjax.ajax({
        url: "bpm/report/getTaskCountByDay?days="+days,        
        type: "post",
        dataType: "json",
        success: function (data) {
        	showView(data);
        }
    });
	
});
    
}catch(e){
}
	

</script>
</html>