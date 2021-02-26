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
<title>流程统计报表</title>
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
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
try{

//基于准备好的dom，初始化echarts实例
var taskDayReportChart = echarts.init(document.getElementById('taskDayReport'));
var days = decodeURIComponent(flowUtils.getUrlQuery("days"));

var taskDayReportOption = {
		 noDataLoadingOption: {
             text: '无数据',
             effect: 'bubble',
             effectOption: {
                 effect: {
                     n: 0
                 }
             }
         },
	    title : {
	        text: '个人已办流程统计',
	        x:'60',
	        y:'10',
	        textAlign:'left'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	   
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: false},
	            dataView : {show: false, readOnly: false},
	            magicType : {show: true, type: ['bar','line']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        },
	        padding:[10,80]
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : true,
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
	            name:'已办流程',
	            type:'bar',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        }
	    ]
	};
	



function showView(data){
	taskDayReportOption.xAxis[0]['data']=$.parseJSON(data.procDefName);
	taskDayReportOption.series[0]['data']=$.parseJSON(data.count);
	
    // 使用刚指定的配置项和数据显示图表。
    taskDayReportChart.setOption(taskDayReportOption);
}

$(document).ready(function() {
	avicAjax.ajax({
        url: "bpm/report/getFinishedProcessCountByDay?days="+days,        
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