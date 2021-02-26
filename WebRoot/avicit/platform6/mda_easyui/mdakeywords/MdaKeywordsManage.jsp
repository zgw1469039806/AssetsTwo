<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "MdaKeywordsEasyUIController/toMdaKeywordsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
  <table style="margin-bottom: 10px;margin-left: 56px;">
    	<tr>
    		<th><font style="color: red;font-size: 30px;">TOP 10</font><b style="font-size: 30px;"> - 热词榜</b></th>
    	</tr>
    </table>
   		<div id="main1" style="margin-left: 28px;width: 380px;height:360px;">
		</div>
   		<!-- <div id="main2" style="margin-top:30px; width: 380px;height:360px;">
		</div> -->
<!--    		<div id="main3" style="margin-top:30px; width: 380px;height:360px;">
		</div>
 -->
<!-- TAB页 今天,昨天,最近7天，最近30天-->

<!-- 关键字TOP10 搜索统计------搜索热度---1.浏览量（每搜一下+1）：2，占比（占总搜索量比重） -->

<!-- 数据源top10---关键字-返回结果--top10--所对应数据分类---------图例 ：《玫瑰图》-->

<!-- 部门top10---关键字-返回结果--top10--所对应数据搜索人所属部门---------图例 ：《玫瑰图》-->

<!-- 统计数据 --- 添加上部门维度---粒度到部门数据-------关键字统计表--与部门挂钩--添加部门ID字段-->

<!-- 统计数据 --- 图例多样化--折线图，柱状图，饼图等-->

</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda_easyui/mdakeywords/js/MdaKeywords.js" type="text/javascript"></script>
<script src="avicit/platform6/console/dashboard/js/echarts.js" type="text/javascript"></script>
<script type="text/javascript">

var myChart1 = echarts.init(document.getElementById('main1')); 

//var myChart2 = echarts.init(document.getElementById('main2')); 
//var myChart3 = echarts.init(document.getElementById('main3')); 

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
        data:['历史访问量','30天访问量','7日访问量','昨日访问量','今日访问量']
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
            data : ["${TOP10['10']}","${TOP10['9']}","${TOP10['8']}","${TOP10['7']}","${TOP10['6']}","${TOP10['5']}","${TOP10['4']}","${TOP10['3']}","${TOP10['2']}","${TOP10['1']}"]
        }
    ],
    series : [
		{
		    name:'历史访问量',
		    type:'bar',
		    stack: '总量',
		    itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
		    data:["${history['10']}", "${history['9']}", "${history['8']}", "${history['7']}", "${history['6']}", "${history['5']}", "${history['4']}", "${history['3']}", "${history['2']}", "${history['1']}"]
		},{
            name:'30天访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:["${day30['10']}", "${day30['9']}", "${day30['8']}", "${day30['7']}", "${day30['6']}", "${day30['5']}", "${day30['4']}", "${day30['3']}", "${day30['2']}", "${day30['1']}"]
        }, {
            name:'7日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:["${day7['10']}", "${day7['9']}", "${day7['8']}", "${day7['7']}", "${day7['6']}", "${day7['5']}", "${day7['4']}", "${day7['3']}", "${day7['2']}", "${day7['1']}"]
        },{
            name:'昨日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:["${yesterday['10']}", "${yesterday['9']}", "${yesterday['8']}", "${yesterday['7']}", "${yesterday['6']}", "${yesterday['5']}", "${yesterday['4']}", "${yesterday['3']}", "${yesterday['2']}", "${yesterday['1']}"]
        },
        {
            name:'今日访问量',
            type:'bar',
            stack: '总量',
            itemStyle : { normal: {label : {show: true, position: 'insideRight'}}},
            data:["${today['10']}", "${today['9']}", "${today['8']}", "${today['7']}", "${today['6']}", "${today['5']}", "${today['4']}", "${today['3']}", "${today['2']}", "${today['1']}"]
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
   // myChart2.setOption(option2, true);
   // myChart3.setOption(option3, true);
},2000);

</script>
<script type="text/javascript">


//======获取TOP10关键词===
function getTOP10KeyWords() {
		$.ajax({
			 url:"MdaKeywordsEasyUIController/operation/top10",
			 type : 'post',
			 success : function(r){
				 if (r == "success"){
					 layer.alert('执行成功！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
					 );
				 }else{
					 layer.alert('执行失败！' ,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0
					    }, function(){
					    	refresh();
				        }
			         );
				 } 
			 }
		 });
   }



</script>
</html>