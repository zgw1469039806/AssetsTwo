<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";
String indexId = "\'"+request.getParameter("indexId")+"\'";
String indexNext = "\'"+request.getParameter("indexNext")+"\'";
String selectId = "\'"+request.getParameter("selectId")+"\'";
String nodeName = "\'"+request.getParameter("nodeName")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程节点钻取分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
div#customText {
    font-size:  14px;
    padding-left: 14px;
    padding-top: 6px;
}
</style>
</head>
<body>
	<div id="customText" class="text" style="visibility: visible;">
		<p>
			<span id="span_id" style="text-align: center;display:block;"></span>
		</p>
	</div>
	<div id="drillSelect" style="text-align:right">
		<input id="dateSelect" type="radio" value="dateRadio" name="drill_group" style="vertical-align:middle; margin-top:-5px;margin-bottom:-1px;" checked />
		<label style="visibility:visible;font-size:13px;margin:2px">按日分布 </label>
		<input id="monthSelect" type="radio" value="monthRadio" name="drill_group" style="vertical-align:middle; margin-top:-5px;margin-bottom:-1px;" />
		<label style="visibility:visible;font-size:13px;margin:2px">按月分布 </label>
		<input id="quarterSelect" type="radio" value="quarterRadio" name="drill_group" style="vertical-align:middle; margin-top:-5px;margin-bottom:-1px;" />
		<label style="visibility:visible;font-size:13px;margin:2px">按季度分布 </label>
		<input id="yearSelect" type="radio" value="yearRadio" name="drill_group" style="vertical-align:middle; margin-top:-5px;margin-bottom:-1px;"/>
		<label style="visibility:visible;font-size:13px;margin:2px">按年分布 </label>
	</div>
	<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
		<div id="echartOnly" title="" style="height:335px;text-align:center"></div>
	</div>
</body>
<script type="text/javascript" src="static/h5/echarts/dist/echarts-all.js" ></script>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	var index = <%=indexId%>;   //  index用于表示流程维度，节点维度，部门维度，人员维度，岗位维度等
	var indexNext = <%=indexNext%>;   //  indexNext表示同一维度下的图索引
    var selectId = <%=selectId%>;  //  记录选中的Id
    var nodeName = <%=nodeName%>;  //  记录选中的Id
	var selectName = parent.drillName;   // 要钻取的全名

	var selectIds=[]; selectIds.push(selectId);
	var nodeNames=[]; nodeNames.push(nodeName);
	var curDate=null;  //  获取当前时间
	// 确定时间范围数组
	var timeScope=[];

	// 1 用于吞吐量分析
	// 用于记录每月天数和对应数据
	var xnDateScope=[];  var ynDateData=[];
	// 用来记录月份数和对应数据
	var xnMonthScope=[]; var ynMonthData=[];
	// 季度记录
	var xnQuarterScope=[]; var ynQuarterData=[];
	// 年记录
	var xnYearScope=[];; var ynYearData=[];

	// 2 效率分析，保留xnScope
	var ynDateData1=[]; var ynDateData2=[]; var ynDateData3=[]; 
	var ynMonthData1=[]; var ynMonthData2=[]; var ynMonthData3=[];
	var ynQuarterData1=[]; var ynQuarterData2=[]; var ynQuarterData3=[];
	var ynYearData1=[]; var ynYearData2=[]; var ynYearData3=[];

	$(function(){
		$(":radio").click(function(){
			a = curDate.getFullYear();  //   获取年月日的值
			b = curDate.getMonth();
			c = curDate.getDate();

			if($(this).val()=="dateRadio"){  //  按日分布
				timeScope=[]; xnDateScope=[];
				var totalDay = new Date(a,b+1,0);
				totalDay = totalDay.getDate();
				var i=1;
				for(var i=1;i<=totalDay;i++){
					var tempTime = new Date(a,b,i,0,0,0);
					var nTime =  tempTime.getTime();
					timeScope.push(nTime);
					xnDateScope.push(i+'日');
				}
				var tempTime = new Date(a,b,i,23,59,59);
				nTime = tempTime.getTime();
				timeScope.push(nTime);
			}else if($(this).val()=="monthRadio"){  //  按月分布
				timeScope=[]; xnMonthScope=[];
				var i=0;
				for(var i=0;i<12;i++){
					var tempTime = new Date(a,i,1,0,0,0);
					var nTime =  tempTime.getTime();
					timeScope.push(nTime);
					xnMonthScope.push(i+1+'月');
				}
				var tempTime = new Date(a,11,31,23,59,59);
				var nTime = tempTime.getTime();
				timeScope.push(nTime);
			}else if($(this).val()=="quarterRadio"){  //  按季度分布
				timeScope=[]; xnQuarterScope=[];
				var i=0;
				for(var i=0;i<4;i++){
					var tempTime = new Date(a,3*i,1,0,0,0);
					var nTime = tempTime.getTime();
					timeScope.push(nTime);
					xnQuarterScope.push('第'+(i+1)+'季度');
				}
				var tempTime = new Date(a,11,31,23,59,59);
				var nTime =  tempTime.getTime();
				timeScope.push(nTime);
			}else if($(this).val()=="yearRadio"){  //  按年分布(先按当前年度计算)
				timeScope=[]; xnYearScope=[];
				var tempTime = new Date(a,0,1,0,0,0);
				var nTime =  tempTime.getTime();
				timeScope.push(nTime);
				tempTime = new Date(a,11,31,23,59,59);
				nTime =  tempTime.getTime();
				timeScope.push(nTime);
				xnYearScope.push(a+'年');
			}
			
			// 切换至绘图函数
			initStat($(this).val());
		});
	});

	// 数据处理函数
	function seriesForKPI2Bar(datay1, datay2 ,datay3){
		var serie = [];
		var item = {
			name: '合理完成数量', type : 'bar',
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay1,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#EE9201',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){  // 在顶上显示数据
						if(params.value==0){ return '0'; }else { return params.value; }
					}
				}
			}
			}
		}
		serie.push( item );
		item = {
			name: '警告范围内数量', type : 'bar',
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay2,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#B74AE5',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){ return '0'; }else { return params.value; }
					}
				}
			}
			}
		}
		serie.push( item );
		item = {
			name: '警告范围外数量', type : 'bar',
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay3,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#C39BD3',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){ return '0'; }else { return params.value; }
					}
				}
			}
			}
		}
		serie.push( item );
		return serie;
	}
	// 效率分析用
	function seriesForEff2Bar(datay1, datay2 ,datay3){
		var serie = [];
		var item = {
			name: '最大用时:h', type : 'bar',
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay1,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#EE9201',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){ return '0'; }else { return params.value.toFixed(1); }
					}
				}
			}
			}
		}
		serie.push( item );
		item = {
			name: '最小用时:h', type : 'bar',
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay2,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#B74AE5',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){ return '0'; }else { return params.value.toFixed(1); }
					}
				}
			}
			}
		}
		serie.push( item );
		item = {
			name: '平均用时:h', type : 'bar',
			// yAxisIndex: 1,  // 决定左轴还是右轴
			// barWidth : 42,   // 固定宽度
			barMaxWidth:48,//最大宽度
			data: datay3,
			barGap:'2%',  // 设定柱子间隔
			itemStyle: {
			normal: {
				color: '#C39BD3',
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){ return '0'; }else { return params.value.toFixed(1); }
					}
				}
			}
			}
		}
		serie.push( item );
		return serie;
	}

	$(document).ready(function(){  //  初始化页面
		// 获取服务器的当前时间值
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getServerCurrentDate", 
			type: "post",
			async: false,
			cache: false,
			dataType: "json",
			success : function(ret) {
				curDate = new Date(ret);
			},
			error : function() {
				curDate = new Date();
				layer.msg('无法获取服务器时间,取网页时间');
			},
		});
	    // 点击“按日统计”按钮
		$("#dateSelect").click();
	});

	// 针对不同维度选择进行判断
	function initStat(scope){
		var xnScope=[]; var ynScope=[];  //  坐标轴数据

		if(index=='0' && indexNext=='102'){  // 流程节点第二张图钻取
			document.getElementById("span_id").innerHTML="节点 " + selectName + " : 任务吞吐量钻取分析";

			//  完成数据初始化,只初始化一次
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getTaskCountByActivityA", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,activityNames:nodeNames,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.taskCountByActivityVal);
							// 判断没有返回指定的值时，设为0
							if(scope=="dateRadio"){ 
								if(dataY.length==0){ ynDateData.push(0); }else{ ynDateData.push(dataY[0]); }
							}else if(scope=="monthRadio"){
								if(dataY.length==0){ ynMonthData.push(0); }else{ ynMonthData.push(dataY[0]); }
							}else if(scope=="quarterRadio"){
								if(dataY.length==0){ ynQuarterData.push(0); }else{ ynQuarterData.push(dataY[0]); }
							}else if(scope=="yearRadio"){
								if(dataY.length==0){ ynYearData.push(0); }else{ ynYearData.push(dataY[0]); }
							}
						}
					});
				}
			}
			
			// 开始绘制
			if(scope=="dateRadio"){ xnScope = xnDateScope; ynScope = ynDateData; }
			else if(scope=="monthRadio"){ xnScope = xnMonthScope; ynScope = ynMonthData; }
			else if(scope=="quarterRadio"){ xnScope = xnQuarterScope; ynScope = ynQuarterData; }
			else if(scope=="yearRadio"){ xnScope = xnYearScope; ynScope = ynYearData; }
			var optionProc = {
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
					show : true, feature : { restore : {show: true} }, padding:[15,2]
				},
				grid : {
					x:45, y:27, x2:27, y2:20, borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						textStyle:{ fontSize:11 }  // 让字体变大
					},
					splitLine:{ show:false },
					data : xnScope
				} ,
				yAxis : { name: '任务办结数量', min : 0, type : 'value' },
				series : [
					{
						name: '任务数量', type : 'bar', barMaxWidth:45,  //最大宽度
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									textStyle: { color: '#615a5a' },
									formatter:function(params){
										if(params.value==0){ return '0'; }else{ return params.value; }
									}
								}
							}
						},
						data : ynScope
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("echartOnly"));
			myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表===============================
            myChart.on('click', function(param) {   //  为图标点击事件添加响应
                // alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
                // 弹出弹窗
                var curDrill = layer.open({
                    type: 2,
                    skin: 'layui-layer-rim', //加上边框
                    title : '流程维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds +"&activityNames=" + nodeNames + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='103'){
			document.getElementById("span_id").innerHTML="节点 " + selectName + " : 到达部门钻取分析";
			
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getToDeptCountByActivityA", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,activityNames:nodeNames,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.toDeptCountByActivityVal);
							// 判断没有返回指定的值时，设为0
							if(scope=="dateRadio"){ 
								if(dataY.length==0){ ynDateData.push(0); }else{ ynDateData.push(dataY[0]); }
							}else if(scope=="monthRadio"){
								if(dataY.length==0){ ynMonthData.push(0); }else{ ynMonthData.push(dataY[0]); }
							}else if(scope=="quarterRadio"){
								if(dataY.length==0){ ynQuarterData.push(0); }else{ ynQuarterData.push(dataY[0]); }
							}else if(scope=="yearRadio"){
								if(dataY.length==0){ ynYearData.push(0); }else{ ynYearData.push(dataY[0]); }
							}
						}
					});
				}
			}
			
			// 开始绘制
			if(scope=="dateRadio"){ xnScope = xnDateScope; ynScope = ynDateData; }
			else if(scope=="monthRadio"){ xnScope = xnMonthScope; ynScope = ynMonthData; }
			else if(scope=="quarterRadio"){ xnScope = xnQuarterScope; ynScope = ynQuarterData; }
			else if(scope=="yearRadio"){ xnScope = xnYearScope; ynScope = ynYearData; }
			var optionProc = {
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
					show : true, feature : { restore : {show: true} }, padding:[15,2]
				},
				grid : {
					x:45, y:27, x2:27, y2:20, borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						textStyle:{ fontSize:11 }  // 让字体变大
					},
					splitLine:{ show:false },
					data : xnScope
				} ,
				yAxis : { name: '参与部门数量', min : 0, type : 'value' },
				series : [
					{
						name: '部门数量', type : 'bar', barMaxWidth:45,  //最大宽度
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									textStyle: { color: '#615a5a' },
									formatter:function(params){
										if(params.value==0){ return '0'; }else{ return params.value; }
									}
								}
							}
						},
						data : ynScope
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("echartOnly"));
			myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表===============================
            myChart.on('click', function(param) {   //  为图标点击事件添加响应
                // alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
                // 弹出弹窗
                var curDrill = layer.open({
                    type: 2,
                    skin: 'layui-layer-rim', //加上边框
                    title : '流程维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds +"&activityNames=" + nodeNames + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='104'){
			document.getElementById("span_id").innerHTML="节点 " + selectName + " : 到达岗位钻取分析";

			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getToPosCountByActivityA", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,activityNames:nodeNames,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.toPosCountByActivityVal);
							// 判断没有返回指定的值时，设为0
							if(scope=="dateRadio"){ 
								if(dataY.length==0){ ynDateData.push(0); }else{ ynDateData.push(dataY[0]); }
							}else if(scope=="monthRadio"){
								if(dataY.length==0){ ynMonthData.push(0); }else{ ynMonthData.push(dataY[0]); }
							}else if(scope=="quarterRadio"){
								if(dataY.length==0){ ynQuarterData.push(0); }else{ ynQuarterData.push(dataY[0]); }
							}else if(scope=="yearRadio"){
								if(dataY.length==0){ ynYearData.push(0); }else{ ynYearData.push(dataY[0]); }
							}
						}
					});
				}
			}
			
			// 开始绘制
			if(scope=="dateRadio"){ xnScope = xnDateScope; ynScope = ynDateData; }
			else if(scope=="monthRadio"){ xnScope = xnMonthScope; ynScope = ynMonthData; }
			else if(scope=="quarterRadio"){ xnScope = xnQuarterScope; ynScope = ynQuarterData; }
			else if(scope=="yearRadio"){ xnScope = xnYearScope; ynScope = ynYearData; }
			var optionProc = {
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
					show : true, feature : { restore : {show: true} }, padding:[15,2]
				},
				grid : {
					x:45, y:27, x2:27, y2:20, borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						textStyle:{ fontSize:11 }  // 让字体变大
					},
					splitLine:{ show:false },
					data : xnScope
				} ,
				yAxis : { name: '参与岗位数量', min : 0, type : 'value' },
				series : [
					{
						name: '岗位数量', type : 'bar', barMaxWidth:45,  //最大宽度
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									textStyle: { color: '#615a5a' },
									formatter:function(params){
										if(params.value==0){ return '0'; }else{ return params.value; }
									}
								}
							}
						},
						data : ynScope
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("echartOnly"));
			myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表===============================
            myChart.on('click', function(param) {   //  为图标点击事件添加响应
                // alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
                // 弹出弹窗
                var curDrill = layer.open({
                    type: 2,
                    skin: 'layui-layer-rim', //加上边框
                    title : '流程维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds +"&activityNames=" + nodeNames + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='122'){
			document.getElementById("span_id").innerHTML="节点 " + selectName + " : 任务KPI绩效钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForActivityS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,activityNames:nodeNames,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForActivityVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForActivityVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForActivityVal3);
							// 判断没有返回指定的值时，设为0
							if(scope=="dateRadio"){
								if(dataY1.length==0){ ynDateData1.push(0); ynDateData2.push(0); ynDateData3.push(0); }
								else{ ynDateData1.push(dataY1[0]); ynDateData2.push(dataY2[0]); ynDateData3.push(dataY3[0]); }
							}else if(scope=="monthRadio"){
								if(dataY2.length==0){ ynMonthData1.push(0); ynMonthData2.push(0); ynMonthData3.push(0);}
								else{ ynMonthData1.push(dataY1[0]); ynMonthData2.push(dataY2[0]); ynMonthData3.push(dataY3[0]); }
							}else if(scope=="quarterRadio"){
								if(dataY3.length==0){ ynQuarterData1.push(0); ynQuarterData2.push(0); ynQuarterData3.push(0); }
								else{ ynQuarterData1.push(dataY1[0]); ynQuarterData2.push(dataY2[0]); ynQuarterData3.push(dataY3[0]); }
							}else if(scope=="yearRadio"){
								if(dataY1.length==0){ ynYearData1.push(0); ynYearData2.push(0); ynYearData3.push(0); }
								else{ ynYearData1.push(dataY1[0]); ynYearData2.push(dataY2[0]); ynYearData3.push(dataY3[0]); }
							}
						}
					});
				}
			}
			
			// 开始绘制
			if(scope=="dateRadio"){ xnScope = xnDateScope; ynScope = seriesForKPI2Bar(ynDateData1,ynDateData2,ynDateData3); }
			else if(scope=="monthRadio"){ xnScope = xnMonthScope; ynScope = seriesForKPI2Bar(ynMonthData1,ynMonthData2,ynMonthData3); }
			else if(scope=="quarterRadio"){ xnScope = xnQuarterScope; ynScope = seriesForKPI2Bar(ynQuarterData1,ynQuarterData2,ynQuarterData3); }
			else if(scope=="yearRadio"){ xnScope = xnYearScope; ynScope = seriesForKPI2Bar(ynYearData1,ynYearData2,ynYearData3); }
			var optionProc = {
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
					show : true, feature : { restore : {show: true} }, padding:[15,2]
				},
				grid : {
					x:45, y:27, x2:27, y2:20, borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						textStyle:{ fontSize:11 }  // 让字体变大
					},
					splitLine:{ show:false },
					data : xnScope
				},
				yAxis : { name:'完成数量', min : 0, type : 'value' },
				series : ynScope
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("echartOnly"));
			myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表===============================
            myChart.on('click', function(param) {   //  为图标点击事件添加响应
                // alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
                // 弹出弹窗
                var curDrill = layer.open({
                    type: 2,
                    skin: 'layui-layer-rim', //加上边框
                    title : '流程维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds +"&activityNames=" + nodeNames + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='124'){
			document.getElementById("span_id").innerHTML="节点 " + selectName + " : 任务效率钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForActivityS",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,activityNames:nodeNames,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForActivityVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForActivityVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForActivityVal3);
							// 判断没有返回指定的值时，设为0
							if(scope=="dateRadio"){
								if(dataY1.length==0){ ynDateData1.push(0); ynDateData2.push(0); ynDateData3.push(0); }
								else{ ynDateData1.push(dataY1[0]); ynDateData2.push(dataY2[0]); ynDateData3.push(dataY3[0]); }
							}else if(scope=="monthRadio"){
								if(dataY2.length==0){ ynMonthData1.push(0); ynMonthData2.push(0); ynMonthData3.push(0);}
								else{ ynMonthData1.push(dataY1[0]); ynMonthData2.push(dataY2[0]); ynMonthData3.push(dataY3[0]); }
							}else if(scope=="quarterRadio"){
								if(dataY3.length==0){ ynQuarterData1.push(0); ynQuarterData2.push(0); ynQuarterData3.push(0); }
								else{ ynQuarterData1.push(dataY1[0]); ynQuarterData2.push(dataY2[0]); ynQuarterData3.push(dataY3[0]); }
							}else if(scope=="yearRadio"){
								if(dataY1.length==0){ ynYearData1.push(0); ynYearData2.push(0); ynYearData3.push(0); }
								else{ ynYearData1.push(dataY1[0]); ynYearData2.push(dataY2[0]); ynYearData3.push(dataY3[0]); }
							}
						}
					});
				}
			}
			
			// 开始绘制
			if(scope=="dateRadio"){ xnScope = xnDateScope; ynScope = seriesForEff2Bar(ynDateData1,ynDateData2,ynDateData3); }
			else if(scope=="monthRadio"){ xnScope = xnMonthScope; ynScope = seriesForEff2Bar(ynMonthData1,ynMonthData2,ynMonthData3); }
			else if(scope=="quarterRadio"){ xnScope = xnQuarterScope; ynScope = seriesForEff2Bar(ynQuarterData1,ynQuarterData2,ynQuarterData3); }
			else if(scope=="yearRadio"){ xnScope = xnYearScope; ynScope = seriesForEff2Bar(ynYearData1,ynYearData2,ynYearData3); }
			var optionProc = {
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
					show : true, feature : { restore : {show: true} }, padding:[15,2]
				},
				grid : {
					x:45, y:27, x2:27, y2:20, borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						textStyle:{ fontSize:11 }  // 让字体变大
					},
					splitLine:{ show:false },
					data : xnScope
				},
				yAxis : { name:'完成用时:h', min : 0, type : 'value' },
				series : ynScope
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("echartOnly"));
			myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表===============================
            myChart.on('click', function(param) {   //  为图标点击事件添加响应
                // alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
                // 弹出弹窗
                var curDrill = layer.open({
                    type: 2,
                    skin: 'layui-layer-rim', //加上边框
                    title : '流程维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds +"&activityNames=" + nodeNames + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}
	}
</script>
</html>