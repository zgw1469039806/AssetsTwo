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
<title>概览</title>
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
<div id="curProcInsts" style="height:400px;text-align:center;align:center;overflow:hidden;"></div>
<div id="monthProcInsts" style="height:400px;text-align:center;overflow:hidden;"></div>

</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script src="static/h5/echarts/dist/echarts-all.js"
	type="text/javascript"></script>
<script type="text/javascript">
//基于准备好的dom，初始化echarts实例
var curProcInstsChart = echarts.init(document.getElementById('curProcInsts'));
var monthProcInstsChart = echarts.init(document.getElementById('monthProcInsts'));

var curProcInstsOption = {
		title : {
	        text: '流程实例状态统计',
	        subtext: '截止当前',
	        x:'60',
	        y:'5',
	        textAlign:'left'
	    },
	    
	    tooltip : {
	        trigger: 'axis'
	    },
	    grid : {
	        top : 40,    //距离容器上边界40像素
	        bottom: 30   //距离容器下边界30像素
	    },
	    legend: {
	        data:['活动的实例','结束的实例','异常的实例','挂起的实例'],
	        x:'center',
	        y:'40',
	        padding:[0,0,80,80]
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: false},
	            dataView : {show: false, readOnly: false},
	            magicType : {show: false, type: ['pie', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        },
	        padding:[5,80]
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : ['流程实例数量']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'活动的实例',
	            type:'bar',
	            data:[0],
	            barWidth:80
	        },
	        {
	            name:'结束的实例',
	            type:'bar',
	            data:[0],
	            barWidth:80
	        },
	        {
	            name:'异常的实例',
	            type:'bar',
	            data:[0],
	            barWidth:80
	        },
	        {
	            name:'挂起的实例',
	            type:'bar',
	            data:[0],
	            barWidth:80
	        }
	    ]
	};
var monthProcInstsOption = {
	    title : {
	        text: '月度流程实例报表',
	        x:'60',
	        y:'10',
	        textAlign:'left'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['起草的实例数','办结的实例数'],
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
	            magicType : {show: true, type: ['line', 'bar', 'stack']},
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
	            data : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'起草的实例数',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'办结的实例数',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        }
	    ]
	};
	



function showView(data){
	var arrStartProcessMonthCount = $.parseJSON(data.startProcessMonthCount);
	var arrEndProcessMonthCount = $.parseJSON(data.endProcessMonthCount);
	monthProcInstsOption.series[0]['data']=arrStartProcessMonthCount;
	monthProcInstsOption.series[1]['data']=arrEndProcessMonthCount;
    
	curProcInstsOption.series[0]['data'][0]=data.activeCount;
	curProcInstsOption.series[1]['data'][0]=data.endedCount;
	curProcInstsOption.series[2]['data'][0]=data.exceptionCount;
	curProcInstsOption.series[3]['data'][0]=data.suspendedCount;
    // 使用刚指定的配置项和数据显示图表。
    monthProcInstsChart.setOption(monthProcInstsOption,true);
    curProcInstsChart.setOption(curProcInstsOption,true);
}

$(document).ready(function() {
	
	avicAjax.ajax({
        url: "bpm/monitor/getProcInstCount",        
        type: "post",
        dataType: "json",
        success: function (data) {
        	showView(data);
        }
    });
	
});
    
function bpm_operator_refresh(){
	avicAjax.ajax({
        url: "bpm/monitor/getProcInstCount",        
        type: "post",
        dataType: "json",
        success: function (data) {
        	showView(data);
        }
    });
}
	

</script>
</html>