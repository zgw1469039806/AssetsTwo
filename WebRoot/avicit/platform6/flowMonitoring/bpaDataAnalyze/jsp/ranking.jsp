<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String select = "\'"+request.getParameter("select")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>排名分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
</head>
<body>
	<!-- 排名分析功能条 : 流程-->
	<div id="firstContent" class="Content" style="background: white ">
		<div id="throughputFlow" class="throughputFlow" data-label="排名分析:流程">
			<label for="throughputLabel" >
				<div id="flow_div" class="text" style="visibility: visible;">
					<p>
					</p>
				</div>
			</label> <input id="throughput_input" type="hidden"  style="top:3px" name="排名分析:流程"  checked/>
		</div>
		<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
			<div id="proc-echart1_0" title="" style="height:400px;text-align:center"></div>
			<div id="proc-echart1_1" title="" style="height:400px;text-align:centerr"></div>
			<div id="proc-echart1_2" title="" style="height:400px;text-align:center"></div>
		</div>
	</div>
    <!-- 排名分析功能条 : 岗位-->
	<div id="secondContent" class="Content" style=" display:none; background: white ">
		<div id="allJob" class="allJob" data-label="排名分析:岗位">
			<label for="throughputJobsLabel">
				<div id="jobs_div" class="text" style="visibility: visible;">
				</div>
			</label> <input id="throughputJobsLabel_input" type="hidden" style="top:3px" name="排名分析:岗位"  checked/>
		</div>
		<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
			<div id="pos-echart3_0" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart3_1" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart3_2" title="" style="height:400px;text-align:center"></div>
		</div>
	</div>
	<!-- 排名分析功能条 : 组织-->
	<div id="thirdContent" class="Content"  style=" display:none ; background: white">
		<div id="allDepartment" class="throughputDepartment" data-label="排名分析:部门/员工">
			<label for="throughputDepartmentLabel">
				<div id="Department_div" class="text" style="visibility: visible;">
				</div>
			</label> <input id="throughputDepartmentLabel_input" type="hidden" style="top:3px" name="排名分析:组织" checked/>
		</div>
		<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
			<div id="org-echart2_0" title="" style="height:400px;text-align:center"></div>
			<div id="org-echart2_1" title="" style="height:400px;text-align:center"></div>
			<div id="org-echart2_2" title="" style="height:400px;text-align:center"></div>
		</div>
	</div>
</body>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="static/h5/echarts/dist/echarts-all.js" ></script>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include> 
<script type="text/javascript">

// Date传入年-月-日-时-分-秒，月从0开始，日从1开始,以1970年1月1日为基准
var startMillis = null;
var endMillis = null;
var timeSE = null;

var index = <%=select%>;

// 接住父页面的全局变量
var selectedIdsTop = parent._treeNodeId;
var selectedNamesTop = parent._treeNodeName;
var selectedIds = null ;
var selectedNames = null ;
var timeScope = parent.selectedTime;

var drillName = null;  // 记录钻取的名称

// 选择流程id集合
var procArray=[];
// 选择岗位id集合
var positionArray=[];
// 选择人员id集合
var userArray=[];
// 选择部门id集合
var deptArray=[];
var procNames=[];  //  名称集合
var positionNames=[];
var userNames=[];
var deptNames=[];

// 显示图形--通用显示函数
function seriesFunctionBar(datax, datay){
	var serie = [];
	var item = {
		name: "办理时长",
		type : 'bar',
		barMaxWidth:45,//最大宽度
		data: datay,
		itemStyle: {
			normal: {
				color: function(params) {
					var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB'];
					return colorList[params.dataIndex];
				},
				label: {
					show: true,
					position: 'top',
					textStyle: {
						color: '#615a5a'
					},
					formatter:function(params){
						if(params.value==0){
							return '0.0';
						}else
						{
							return params.value;
						}
					}
				}
			}
		}
	}
	serie.push( item );
	return serie;
}

    $("#throughput_input").change(function() {
		if(document.getElementById("throughput_input").checked){  //值为true或false
			selectedIds = null;
			selectedNames = null;
			refreshAgain();
		}
		else{
			selectedIds = selectedIdsTop;
			selectedNames = selectedNamesTop;
			refreshAgain();
		}
	});
	$("#throughputJobsLabel_input").change(function() {
		if(document.getElementById("throughputJobsLabel_input").checked){ //值为true或false
			selectedIds = null;
			selectedNames = null;
			refreshAgain();
		}
		else{
			selectedIds = selectedIdsTop;
			selectedNames = selectedNamesTop;
			refreshAgain();
		}
	});
	$("#throughputDepartmentLabel_input").change(function() {
		if(document.getElementById("throughputDepartmentLabel_input").checked){  //值为true或false
			selectedIds = null;
			selectedNames = null;
			refreshAgain();
		}
		else{
			selectedIds = selectedIdsTop;
			selectedNames = selectedNamesTop;
			refreshAgain();
		}
	});

function refreshAgain(){

	// 处理选项
	if(!selectedIds || selectedIds=="null") {
		procArray = []; positionArray = []; userArray = []; deptArray = [];
	}
	else{
		var tempIds = selectedIds.split(",");
		procArray = tempIds; positionArray = tempIds; userArray = tempIds; deptArray = tempIds;
	}
	// procArray.push('8a58cd43646d6b6501646d6e9fd300c3-1');
	if(!selectedNames || selectedNames=="null") {
		procNames=[]; positionNames=[]; userNames=[]; deptNames=[];
	}  // 名称
	else{
		var tempNames = selectedNames.split(",");
		procNames = tempNames; positionNames = tempNames; userNames = tempNames; deptNames = tempNames;
	}
	// procNames.push('关联父流程1');

	// 前后台需要Date转换，以1970-01-01为准传递毫秒数,方便后台
	if(!timeScope || timeScope=="null"){}
	else{
		timeSE = timeScope.split(",");
		if(!timeSE[0] || timeSE[0]=="null"){}
		else{
			startMillis = parseInt(timeSE[0]);
			endMillis = parseInt(timeSE[1]);
		}
	}

	// 1 #firstContent 基于流程的排名分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getWaitForTaskCountByProc", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.waitForTaskCountKey);
			var dataY = $.parseJSON(data.waitForTaskCountVal);
			var dataID = $.parseJSON(data.waitForTaskCountID);
			if(procNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(procNames[i]==dataX[j] && procArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(procArray[i]); dataX.push(procNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程待办积压最多排名', 
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				// calculable : true,
				toolbox: {
                    show : true,
                    feature : {
                    	 myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '流程待办积压最多排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/processBacklog.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'待办数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
					    name : '待办数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_0"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '流程维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=11" + "&selectId=" + selectId
				});
			});
		}
	});//==========================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getMaxTimeByProc", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.maxTimeKey);
			var dataY = $.parseJSON(data.maxTimeVal);
			var dataID = $.parseJSON(data.maxTimeID);
			if(procNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(procNames[i]==dataX[j] && procArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(procArray[i]); dataX.push(procNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程办理时间排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	 myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '流程办理时间排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/processTime.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'办理时长:h',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '办理时长',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0.0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_1"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '流程维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=12" + "&selectId=" + selectId
				});
			});
		}
	});//========================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getTaskCountByProc", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.taskCountByProcKey);
			var dataY = $.parseJSON(data.taskCountByProcVal);
			var dataID = $.parseJSON(data.taskCountByProcID);
			if(procNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(procNames[i]==dataX[j] && procArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(procArray[i]); dataX.push(procNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程办结数量排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '流程办结数量排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/processThroughput.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name: '吞吐数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '实例数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
                        //type : 'line',
                        //symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			};
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_2"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '流程维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=13" + "&selectId=" + selectId
				});
			});
		}
	});//=======================================================================================
	// 2 #secondContent 基于组织的排名分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getWaitForTaskCountByDept",
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.waitForTaskByDeptKey);
			var dataY = $.parseJSON(data.waitForTaskByDeptVal);
			var dataID = $.parseJSON(data.waitForTaskByDeptID);
			if(deptNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(deptNames[i]==dataX[j] && deptArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(deptArray[i]); dataX.push(deptNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'部门待办积压排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '部门待办积压排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/orgBacklog.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'待办数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '待办数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_0"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '部门维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=31" + "&selectId=" + selectId
				});
			});
		}
	});//=======================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getAvgTaskTimeByDept", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.avgTaskTimeKey);
			var dataY = $.parseJSON(data.avgTaskTimeVal);
			var dataID = $.parseJSON(data.avgTaskTimeID);
			if(deptNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(deptNames[i]==dataX[j] && deptArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(deptArray[i]); dataX.push(deptNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'任务平均办理时间最长部门排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '任务平均办理时间最长部门排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/orgTime.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					//data : ['任务平均办理时长(单位:h)']
                    data : dataX
				} ,
				yAxis : {
					name:'办理时长:h',
					min : 0,
					type : 'value'
				},
				series : seriesFunctionBar(dataX,dataY)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_1"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.seriesIndex];
				drillName = param.seriesName;
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '部门维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=32" + "&selectId=" + selectId
				});
			});
		}
	});//====================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getTaskCountByDept", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.taskCountByDeptKey);
			var dataY = $.parseJSON(data.taskCountByDeptVal);
			var dataID = $.parseJSON(data.taskCountByDeptID);
			if(deptNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(deptNames[i]==dataX[j] && deptArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(deptArray[i]); dataX.push(deptNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'办理任务最多的部门排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '办理任务最多的部门排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/orgTask.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'任务数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '任务数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			};
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_2"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '部门维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=33" + "&selectId=" + selectId
				});
			});
		}
	});//=============================================================================================
	// 3 #thirdContent 基于岗位的排名分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getWaitForTaskCountByPos", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.waitForTaskByPosKey);
			var dataY = $.parseJSON(data.waitForTaskByPosVal);
			var dataID = $.parseJSON(data.waitForTaskByPosID);
			if(positionNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(positionNames[i]==dataX[j] && positionArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(positionArray[i]); dataX.push(positionNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'岗位待办积压最多排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '岗位待办积压最多排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/positionBacklog.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'待办数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '待办数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart3_0"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '岗位维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=21" + "&selectId=" + selectId
				});
			});
		}
	});//==========================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getAvgTaskTimeByPos", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.avgTaskTimeByPosKey);
			var dataY = $.parseJSON(data.avgTaskTimeByPosVal);
			var dataID = $.parseJSON(data.avgTaskTimeByPosID);
			if(positionNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(positionNames[i]==dataX[j] && positionArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(positionArray[i]); dataX.push(positionNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'岗位任务平均办理时间最长排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '岗位任务平均办理时间最长排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/positionTime.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					//data : ['任务平均办理时长(单位:h)']
                    data : dataX
				} ,
				yAxis : {
					name: '办理时长:h',
					min : 0,
					type : 'value'
				},
				series : seriesFunctionBar(dataX,dataY)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart3_1"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.seriesIndex];
				drillName = param.seriesName;
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '岗位维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=22" + "&selectId=" + selectId
				});
			});
		}
	});//===============================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getTaskCountByPos",
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.taskCountByPosKey);
			var dataY = $.parseJSON(data.taskCountByPosVal);
			var dataID = $.parseJSON(data.taskCountByPosID);
			if(positionNames.length==0 && dataX.length==0){
				dataX = ["暂无数据"]; dataY = ["暂无数据"];
			}
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(positionNames[i]==dataX[j] && positionArray[i]==dataID[j]){ break; }
				}  //  用于判断没有返回指定的值时，设为0
				if(j==dataID.length) { dataID.push(positionArray[i]); dataX.push(positionNames[i]); dataY.push(0); }
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'岗位参与任务办结数量排名' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
				toolbox: {
                    show : true,
                    feature : {
                    	myTool1:{//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字    
			                   show:true,//是否显示
			                   readOnly: false,
			                   title:'图标详情', //鼠标移动上去显示的文字    
			                   icon:'avicit/platform6/flowMonitoring/bpaDataAnalyze/css/question.png', //图标  
			                   onclick:function() {//点击事件,这里的option1是chart的option信息    
			                	   layer.open({
			                		   type: 2,
			                		   skin: 'layui-layer-rim', //加上边框
			                		   title : '岗位参与任务办结数量排名',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/rankingHtml/positionThroughput.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,80]
                },
				grid : {
					top : 40,    //距离容器上边界40像素
					bottom: 30,   //距离容器下边界30像素
					borderWidth : 5,
					borderColor : "#FFFFFF"
				},
				xAxis : {
					axisLabel : {
						interval:0,  
						rotate : 0,
						textStyle:{ fontSize:12 }  // 让字体变大
					},
					// type : 'category',// 坐标轴类型，横轴默认为类目型'category'，纵轴默认为数值型'value'
					data : dataX
				} ,
				yAxis : {
					name:'吞吐数量',
					min : 0,
					type : 'value'
				},
				series : [
					{
                        name : '任务数量',
                        type : 'bar',
                        barMaxWidth:45,//最大宽度
						//type : 'line',
						//symbolSize: 5,   // 设置标记大小
						itemStyle: {     // 给不同柱子上不同颜色
							normal: {
								// 随机颜色显示（默认不应随机）
								// color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								color: function(params) { 
									var colorList = ['#C33531', '#B74AE5','#0AAF9F','#EE9201','#29AAE3','#4A235A','#C39BD3','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#E89589','#16A085','#EFE42A','#64BD3D','#4A235A','#3498DB']; 
									return colorList[params.dataIndex];
								},
								label: {
									show: true,
									position: 'top',
									textStyle: {
										color: '#615a5a'
									},
									formatter:function(params){
										if(params.value==0){
											return '0';
										}else
										{
											return params.value;
										}
									}
								}
							}
						},
						data : dataY
					}
				]
			};
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart3_2"));
			myChart.setOption(optionProc,true);
			myChart.on('click', function(param) {   //  为图标点击事件添加响应
				// 判断选中
				var selectId = dataID[param.dataIndex];
				drillName = dataX[param.dataIndex];
				// 弹出弹窗
				layer.open({
					type: 2,
					skin: 'layui-layer-rim', //加上边框
					title : '岗位维度钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/rankingDrill.jsp?indexId=" + index + "&indexNext=23" + "&selectId=" + selectId
				});
			});
		}
	});//=============================显示完毕======================================================
}

$(document).ready(function() {

	 $('#firstContent').find('input[type=checkbox]').bind('click', function(){  
	        $('#firstContent').find('input[type=checkbox]').not(this).attr("checked", false);  
	    });  
	 $('#secondContent').find('input[type=checkbox]').bind('click', function(){  
	        $('#secondContent').find('input[type=checkbox]').not(this).attr("checked", false);  
	    });
	 $('#thirdContent').find('input[type=checkbox]').bind('click', function(){  
	        $('#thirdContent').find('input[type=checkbox]').not(this).attr("checked", false);  
	    });
	var res = window.parent.parentRes;
	if (res == 0) {
		$("#firstContent").show();
		$("#secondContent").hide();
		$("#thirdContent").hide();
	} else if (res == 1) {
		$("#secondContent").show();
		$("#firstContent").hide();
		$("#thirdContent").hide();
	} else if (res == 2){
		$("#thirdContent").show();
		$("#firstContent").hide();
		$("#secondContent").hide();
	}

	if(!selectedIdsTop || selectedIdsTop=="null") {
		if(res == 0){
			$("#throughput_input").attr("checked", true).trigger("change");
		}else if(res == 1){
			$("#throughputJobsLabel_input").attr("checked", true).trigger("change");
		}else if(res == 2){
			$("#throughputDepartmentLabel_input").attr("checked", true).trigger("change");
		}
	}else{
		if(res == 0){
			$("#throughput_input").attr("checked", false).trigger("change");
		}else if(res == 1){
			$("#throughputJobsLabel_input").attr("checked", false).trigger("change");
		}else if(res == 2){
			$("#throughputDepartmentLabel_input").attr("checked", false).trigger("change");
		}
	}

});
</script>
</html>