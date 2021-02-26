<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜索统计信息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
    <div data-options=" region:'east',iconCls:'icon-reload',title:'',split:false" style="width:500px;overflow:hidden;">
    <table style="margin-bottom: 10px;margin-left: 28px;">
    	<tr>
    		<th><font style="color: red;font-size: 30px;">TOP 10</font><b style="font-size: 30px;"> - 热词榜</b></th>
    	</tr>
    </table>
   		<div id="main1" style="width: 380px;height:360px;">
		</div>
   		<div id="main2" style="margin-top:30px; width: 380px;height:360px;">
		</div>
   		<div id="main3" style="margin-top:30px; width: 380px;height:360px;">
		</div>
		
		
    </div>   
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdasearchconfig/js/MdaSearchconfig.js" type="text/javascript"></script>
<script type="text/javascript">


</script>
<script src="avicit/platform6/console/dashboard/js/echarts.js" type="text/javascript"></script>
<script type="text/javascript">

var myChart1 = echarts.init(document.getElementById('main1')); 

var myChart2 = echarts.init(document.getElementById('main2')); 
var myChart3 = echarts.init(document.getElementById('main3')); 

option1 = {
		 grid:{
             x:80,
             y:45,
             x2:5,
             y2:20
         },
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['历史访问量','30天访问量', '昨日访问量','7日访问量','今日访问量']
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
            data : ['TOP01','TOP02','TOP03','TOP04','TOP05','TOP06','TOP07','TOP08','TOP09','TOP10']
        }
    ],
    series : [
		{
		    name:'历史访问量',
		    type:'bar',
		    stack: '总量',
		    itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
		    data:[820, 832, 901, 934, 1290, 1330, 1320, 620, 620, 620]
		},{
            name:'30天访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[150, 212, 201, 154, 190, 330, 410, 320, 520, 620]
        }, {
            name:'7日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[220, 182, 191, 234, 290, 330, 310, 620, 620, 620]
        },{
            name:'昨日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[120, 132, 101, 134, 90, 230, 210, 620, 620, 620]
        },
        {
            name:'今日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:[320, 302, 301, 334, 390, 330, 320, 700, 710, 720]
        }
    ]
};
                                                               
option2 = {
		
	    title : {
	        text: '数据源统计',
	        subtext: '来源分析',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        x : 'center',
	        y : 'bottom',
	        data:['网易','新浪','腾讯','搜狐','百度','知网','oracle','mysql']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            magicType : {
	                show: true, 
	                type: ['pie', 'funnel']
	            },
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    series : [
	        {
	            name:'面积模式',
	            type:'pie',
	            radius : [30, 110],
	            center : ['50%', 200],
	            roseType : 'area',
	            x: '50%',               // for funnel
	            max: 40,                // for funnel
	            sort : 'ascending',     // for funnel
	            data:[
	                {value:10, name:'网易'},
	                {value:5, name:'新浪'},
	                {value:15, name:'腾讯'},
	                {value:25, name:'百度'},
	                {value:20, name:'搜狐'},
	                {value:35, name:'oracle'},
	                {value:30, name:'mysql'},
	                {value:40, name:'知网'}
	            ]
	        }
	    ]
	};
option3 = {
	    title : {
	        text: '多雷达图',
	        subtext: '纯属虚构'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        x : 'center',
	        data:['某主食手机','某水果手机']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    polar : [
	        {
	            indicator : [
	                {text : '外观', max  : 100},
	                {text : '拍照', max  : 100},
	                {text : '系统', max  : 100},
	                {text : '性能', max  : 100},
	                {text : '屏幕', max  : 100}
	            ],
	            radius : 80
	        }
	    ],
	    series : [
	        {
	            type: 'radar',
	            tooltip : {
	                trigger: 'item'
	            },
	            polarIndex : 0,
	            data : [
	                {
	                    value : [85, 90, 90, 95, 95],
	                    name : '某主食手机'
	                },
	                {
	                    value : [95, 80, 95, 90, 93],
	                    name : '某水果手机'
	                }
	            ]
	        }
	    ]
	};
setInterval(function () {
    myChart1.setOption(option1, true);
    myChart2.setOption(option2, true);
    myChart3.setOption(option3, true);
},2000);

</script>


</html>