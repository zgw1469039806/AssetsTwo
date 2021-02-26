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
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>维度钻取分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
div#customText {
    font-size:  16px;
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
		<input id="dateSelect" type="radio" value="dateRadio" name="drill_group" style="vertical-align:middle; margin-top:-5px;margin-bottom:-1px;"  />
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
	var selectName = parent.drillName;   // 要钻取的名称

	var selectIds=[]; selectIds.push(selectId);  // ID值
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

	$(document).ready(function() {  //  初始化页面
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
						if(params.value==0){ return '0'; }else { return params.value; }
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
						if(params.value==0){ return '0'; }else { return params.value; }
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
						if(params.value==0){ return '0'; }else { return params.value; }
					}
				}
			}
			}
		}
		serie.push( item );
		return serie;
	}
	// 针对不同维度选择进行判断
	function initStat(scope){
		var xnScope=[]; var ynScope=[];  //  坐标轴数据

		if(index=='0' && indexNext=='1'){  // 流程维度第一张图钻取
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 办结数量钻取分析";
			//  完成数据初始化,只初始化一次
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getInstCountByProcA", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.instCountByProcVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
				yAxis : { name: '流程办结数量', min : 0, type : 'value' },
				series : [
					{
						name: '实例数量', type : 'bar', barMaxWidth:45,  //最大宽度
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
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
            //window.onresize = myChart.resize;
		}else if(index=='0' && indexNext=='2'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 任务办结数量钻取分析";
			//  完成数据初始化,只初始化一次
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getTaskCountByProcA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.taskCountByProcVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '流程任务维度钻取详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='3'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 到达部门钻取分析";
			//  完成数据初始化,只初始化一次
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getToDeptCountByProcA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.toDeptCountByProcVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '流程到达部门覆盖率详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='4'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 到达岗位钻取分析";
			//  完成数据初始化,只初始化一次
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getToPosCountByProcA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.toPosCountByProcVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '流程到达岗位覆盖率详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='1'){
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 流程办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getInstCountByPosA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.instCountByPosVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
				yAxis : { name: '流程办结数量', min : 0, type : 'value' },
				series : [
					{
						name: '实例数量', type : 'bar', barMaxWidth:45,  //最大宽度
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
                    title : '流程办结数量详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='2'){
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 任务办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getTaskCountByPosA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.taskCountByPosVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='1'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 流程办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getInstCountByDeptA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.instCountByDeptVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
				yAxis : { name: '流程办结数量', min : 0, type : 'value' },
				series : [
					{
						name: '实例数量', type : 'bar', barMaxWidth:45,  //最大宽度
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
                    title : '详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='2'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 任务办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getTaskCountByDeptA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.taskCountByDeptVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='1' && indexNext=='101') || (index=='2' && indexNext=='101')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 流程办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getInstCountByUserA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.instCountByUserVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
				yAxis : { name: '流程办结数量', min : 0, type : 'value' },
				series : [
					{
						name: '实例数量', type : 'bar', barMaxWidth:45,  //最大宽度
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
                    title : '详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='1' && indexNext=='102') || (index=='2' && indexNext=='102')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 任务办结数量钻取分析";
			if( ynDateData.length==0 || ynMonthData.length==0 || ynQuarterData.length==0 || ynYearData.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getTaskCountByUserA",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY = $.parseJSON(data.taskCountByUserVal);
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
                /*legend: {
                    orient: 'horizontal',
                    x: '70%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },*/
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
                    title : '详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}  //  以下为效率图钻取部分===========================================================================
		else if(index=='0' && indexNext=='111'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForProcS",
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForProcVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForProcVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForProcVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
				yAxis : { name: '完成数量', min : 0, type : 'value' },
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
                    title : '合理完成及超时完成数量详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='112'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 任务合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForTaskS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
				yAxis : { name: '完成数量', min : 0, type : 'value' },
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
                    title : '流程任务合理完成及超时完成数量详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='113'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForProcS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForProcVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForProcVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForProcVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '任务完成钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='0' && indexNext=='114'){
			document.getElementById("span_id").innerHTML="流程 " + selectName + " : 任务完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForTaskS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({procIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForTaskVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForTaskVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForTaskVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '任务完成用时钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='111'){
		    //debugger;
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 流程合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForProcByPosS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByPosVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByPosVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByPosVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '流程合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='112'){
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 任务合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByPosS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '任务合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='113'){
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 流程完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForProcByPosS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForProcByPosVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForProcByPosVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForProcByPosVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '流程任务完成钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='1' && indexNext=='114'){
			document.getElementById("span_id").innerHTML="岗位 " + selectName + " : 任务完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForTaskByPosS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({posIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForTaskByPosVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForTaskByPosVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForTaskByPosVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '任务完成用时钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='111'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 流程合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForProcByDeptS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '流程合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='112'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 任务合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByDeptS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '任务合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='113'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 流程完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForProcByDeptS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForProcByDeptVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForProcByDeptVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForProcByDeptVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '流程完成用时钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if(index=='2' && indexNext=='114'){
			document.getElementById("span_id").innerHTML="部门 " + selectName + " : 任务完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForTaskByDeptS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({deptIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForTaskByDeptVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForTaskByDeptVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForTaskByDeptVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '任务完成用时钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='2' && indexNext=='121') || (index=='1' && indexNext=='121')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 流程合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForProcByOrgS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '流程合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='2' && indexNext=='122') || (index=='1' && indexNext=='122')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 任务合理完成及超时完成数量分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByOrgS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal1);
							var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal2);
							var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
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
                    title : '任务合理完成及超时完成数量分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='2' && indexNext=='123') || (index=='1' && indexNext=='123')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 流程完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForProcByOrgS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForProcByOrgVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForProcByOrgVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForProcByOrgVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '流程完成钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}else if((index=='2' && indexNext=='124') || (index=='1' && indexNext=='124')){
			document.getElementById("span_id").innerHTML="员工 " + selectName + " : 任务完成用时钻取分析";
			if( ynDateData1.length==0 || ynMonthData1.length==0 || ynQuarterData1.length==0 || ynYearData1.length==0 ){
				for(var i=0; i<timeScope.length-1;i++){
					avicAjax.ajax({
						url: "bpa/flowmonitoring/getEffAnalyzeForTaskByOrgS", 
						type: "post",
						async: false,
						cache: false,
						data:JSON.stringify({usrIds:selectIds,startTime:timeScope[i],endTime:timeScope[i+1]}),
						contentType : 'application/json',
						dataType: "json",
						success: function (data) {
							var dataY1 = $.parseJSON(data.effAnalyzeForTaskByOrgVal1);
							var dataY2 = $.parseJSON(data.effAnalyzeForTaskByOrgVal2);
							var dataY3 = $.parseJSON(data.effAnalyzeForTaskByOrgVal3);
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
                legend: {
                    orient: 'horizontal',
                    x: '73%' ,
                    y: 5,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
                    title : '任务完成用时钻取分析详情图',
                    area: ['75%', '80%'], //宽高
                    content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/detailDrill.jsp?ids=" + selectIds + "&startTime=" + timeScope[param.dataIndex] + "&endTime=" + timeScope[param.dataIndex+1]+"&index="+index+"&indexNext="+indexNext
                });
                if(curDrill != null) {
                    layer.full(curDrill);
                }
            });
		}

	}
</script>
</html>