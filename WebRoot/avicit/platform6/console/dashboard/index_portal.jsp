<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.api.session.dto.SecurityMenu"%>
<%@page import="avicit.platform6.core.spring.CacheSpringFactory"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.sysmenu.impl.SysMenuAPImpl"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<%@page import="java.util.Locale"%>
<% 
String importlibs = "common,tree,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "sinleTree/demosingletree/demoSingletreeController/toDemoSingletreeManage" -->
<title>监控</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">

<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

</head>

<body class="easyui-layout" fit="true">   
    <div data-options="region:'north',title:'',split:false,collapsible:false" style="height:100px;float: center">
    	
    <div style="margin-top: 40px">
   
	<span class="label label-info" >一般信息！</span>
	<span class="label label-warning" >警告！</span>
	<span class="label label-danger"  >危险！</span>
	<hr style=""></hr>
    </div>
	

    </div>   
    <div data-options="region:'south',title:'',split:false" style="height:100px;overflow:hidden;">
   		  <div style="mborder-bottom: 30px">
   
		<hr></hr>
    	</div>
    </div>   
    <div data-options="region:'east',iconCls:'icon-reload',title:'',split:false" style="width:400px;overflow:hidden;">
    	<div id="main2" style="width: 380px;height:360px;">
		</div>
    </div>   
    <div data-options="region:'west',title:'',split:false" style="width:400px;overflow:hidden;">
    	<div id="main" style="width: 380px;height:360px;">
		</div>
    </div>   
    <div data-options="region:'center',title:''" style="padding:0px;overflow:hidden;">
    	<div id="main1" style="width: 550px;height:360px;">
		</div>
    </div>   
</body>  






	

<script src="avicit/platform6/console/dashboard/js/echarts.js" type="text/javascript"></script>
<script type="text/javascript">

var myChart = echarts.init(document.getElementById('main'));
var myChart1 = echarts.init(document.getElementById('main1'));
var myChart2 = echarts.init(document.getElementById('main2')); 
/*
var myChart = echarts.init(document.getElementById('main'));
var myChart1 = echarts.init(document.getElementById('main1'));
var myChart2 = echarts.init(document.getElementById('main2')); 
 var myChart3 = echarts.init(document.getElementById('main3')); 
var myChart4 = echarts.init(document.getElementById('main4')); 
var myChart5 = echarts.init(document.getElementById('main5')); 
var myChart6 = echarts.init(document.getElementById('main6')); 
var myChart7 = echarts.init(document.getElementById('main7')); 
var myChart8 = echarts.init(document.getElementById('main8')); 
 */
option = {
	
	 title : {
        text: 'CPU使用率',
        subtext: '虚拟'
    },
    
    grid:{
                    x:25,
                    y:45,
                    x2:5,
                    y2:20,
                    borderWidth:1
                },
   
     
   
    series : [
        {
            name:'业务指标',
             radius : '95%',
            center: ['50%', '50%'],
            type:'gauge',
            detail : {show : true,
    backgroundColor: 'rgba(0,0,0,0)',
    borderWidth: 0,
    borderColor: '#ccc',
    width: 100,
    height: 40,
    offsetCenter: [0, '40%'],
    formatter: null,
    textStyle: {
        color: 'auto',
        fontSize : 20
    }},
           
            data:[{value: 10, name: 'cpu使用率'}]
        }
    ]
};

option1 = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['流程模块', '电子表单','数据权限','动态表','搜索引擎']
    },
   
    calculable : false,
    xAxis : [
        {
            type : 'value'
        }
    ],
    yAxis : [
        {
            type : 'category',
            data : ['周一','周二','周三','周四','周五','周六','周日']
        }
    ],
    series : [
        {
            name:'流程模块',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[320, 302, 301, 334, 390, 330, 320]
        },
        {
            name:'电子表单',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[120, 132, 101, 134, 90, 230, 210]
        },
        {
            name:'数据权限',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[220, 182, 191, 234, 290, 330, 310]
        },
        {
            name:'动态表',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[150, 212, 201, 154, 190, 330, 410]
        },
        {
            name:'搜索引擎',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[820, 832, 901, 934, 1290, 1330, 1320]
        }
    ]
};
                                                               
option2 = {
    title :{
        text : '网络使用',
        subtext : '纯属虚构'
    },
    
  
    legend: {
        data:['本周', '上周'],
        selectedMode:false
    },
    xAxis : [
        {
            type : 'category',
            data : ['周一','周二','周三','周四','周五','周六','周日']
        }
    ],
    yAxis : [
        {
            type : 'value',
            min : 200,
            max : 450
        }
    ],
    series : [
        {
            name:'本周',
            type:'line',
            data:[400, 374, 251, 300, 420, 400, 440]
        },
        {
            name:'上周',
            type:'line',
            symbol:'none',
            itemStyle:{
                normal:{
                  lineStyle: {
                    width:1,
                    type:'dashed'
                  }
                }
            },
            data:[320, 332, 301, 334, 360, 330, 350]
        },
        {
            name:'上周2',
            type:'bar',
            stack: '1',
            barWidth: 6,
            itemStyle:{
                normal:{
                    color:'rgba(0,0,0,0)'
                },
                emphasis:{
                    color:'rgba(0,0,0,0)'
                }
            },
            data:[320, 332, 251, 300, 360, 330, 350]
        },
        {
            name:'变化',
            type:'bar',
            stack: '1',
            data:[
              80, 42, 
              {value : 50, itemStyle:{ normal:{color:'red'}}},
              {value : 34, itemStyle:{ normal:{color:'red'}}}, 
              60, 70, 90
            ]
        }
    ]
};
                    

setInterval(function () {
    option.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
   myChart.setOption(option, true);
    myChart1.setOption(option1, true);
     myChart2.setOption(option2, true);
   /*  myChart.setOption(option, true);
    myChart1.setOption(option, true);
    myChart2.setOption(option, true);
     myChart3.setOption(option1, true);
    myChart4.setOption(option1, true);
    myChart5.setOption(option1, true);
    myChart6.setOption(option1, true);
    myChart7.setOption(option1, true);
    myChart8.setOption(option1, true); */
    
  
},2000);

</script>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</body>
</html>