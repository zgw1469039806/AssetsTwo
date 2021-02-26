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
<title>吞吐量</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
 <jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
</head>
<body>
	<!-- 吞吐量分析功能条 : 流程-->
  <div id="firstContent" class="Content">
	<div id="throughputFlow" class="throughputFlow" data-label="吞吐量分析:流程">
		<label for="throughputLabel" >
			<div id="flow_div" class="text" style="visibility: visible;">
				<p>
					<span>流程</span>
				</p>
			</div>
		</label> <input id="throughput_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析流程" checked/>
	</div>

	<div id="throughputNode" class="throughputNode" data-label="吞吐量分析 :节点">
		<label for="throughputNodeLabel">
			<div id="node_div" class="text" style="visibility: visible;">
				<p>
					<span>节点</span>
				</p>
			</div>
		</label> <input id="throughputNodeLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析流程" />
	</div>
	<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
		<div id="proc-echart1_0" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart1_1" title="" style="height:400px;text-align:centerr"></div>
		<div id="proc-echart1_2" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart1_3" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart2_1" title="" style="height:400px;text-align:center;display:none"></div>
		<div id="proc-echart2_2" title="" style="height:400px;text-align:center;display:none"></div>
		<div id="proc-echart2_3" title="" style="height:400px;text-align:center;display:none"></div>
	</div>
	</div>
	<!-- 吞吐量分析功能条 : 岗位-->
	<div id="secondContent" class="Content" style=" display:none ">
			<div id="throughputJobs" class="throughputJobs" data-label="吞吐量分析:岗位">
				<label for="throughputJobsLabel">
					<div id="jobs_div" class="text" style="visibility: visible;">
						<p>
							<span>岗位</span>
						</p>
					</div>
				</label> <input id="throughputJobsLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析岗位"  checked/>
			</div>

			<div id="throughputEmployees" class="throughputEmployees" data-label="吞吐量分析：节点">
				<label for="throughputEmployeesLabel">
					<div id="Employees_div" class="text" style="visibility: visible;">
						<p>
							<span>员工</span>
						</p>
					</div>
				</label> <input id="throughputEmployeesLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析岗位" />
			</div>
			<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
				<div id="pos-echart2_0" title="" style="height:400px;text-align:center"></div>
				<div id="pos-echart3_0" title="" style="height:400px;text-align:center;display:none"></div>
				<div id="pos-echart2_1" title="" style="height:400px;text-align:center"></div>
				<div id="pos-echart3_1" title="" style="height:400px;text-align:center;display:none"></div>
			</div>
	</div>
	<!-- 吞吐量分析功能条 : 组织-->
	<div id="thirdContent" class="Content"  style=" display:none ">

			<div id="throughputDepartment" class="throughputDepartment" data-label="吞吐量分析:部门">
				<label for="throughputDepartmentLabel">
					<div id="Department_div" class="text" style="visibility: visible;">
						<p>
							<span>部门</span>
						</p>
					</div>
				</label> <input id="throughputDepartmentLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析组织" checked/>
			</div>

			<div id="throughputJob" class="throughputJob" data-label="吞吐量分析:节点">
				<label for="throughputJobLabel">
					<div id="Job_div" class="text" style="visibility: visible;">
						<p>
							<span>员工</span>
						</p>
					</div>
				</label> <input id="throughputJobLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析组织" />
			</div>
			<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
				<div id="org-echart3_0" title="" style="height:400px;text-align:center;display:none"></div>
				<div id="org-echart3_1" title="" style="height:400px;text-align:center"></div>
				<div id="org-echart3_2" title="" style="height:400px;text-align:center;display:none"></div>
				<div id="org-echart3_3" title="" style="height:400px;text-align:center"></div>
			</div>
	</div>
</body>
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
var selectedIds = parent._treeNodeId;
var selectedNames = parent._treeNodeName;
var timeScope = parent.selectedTime;

var drillName = null;  // 记录钻取的名称

// 传递流程节点选择变量
var activityIds = [];
var activityNames = [];
var procActfullNames = [];

// 选择流程id集合
var procArray=[];
// 选择岗位id集合
var positionArray=[];
// 选择人员id集合
var userArray=[];
// 选择部门id集合
var deptArray=[];

var procNames=[];
var positionNames=[];
var userNames=[];
var deptNames=[];

var tempProcArray = [];  // 在选择流程节点时，记录选中的流程ID，是procArray的子集

$(document).ready(function() {

	if(!selectedIds || selectedIds=="null") {}
	else{
		var tempIds = selectedIds.split(",");
		procArray = tempIds
		positionArray = tempIds;
		userArray = tempIds;
		deptArray = tempIds;
	}
	// procArray.push('8a58cd43646d6b6501646d6e9fd300c3-1');

	if(!selectedNames || selectedNames=="null") {}  // 名称
	else{
		var tempNames = selectedNames.split(",");
		procNames = tempNames;
		positionNames = tempNames;
		userNames = tempNames;
		deptNames = tempNames;
	}
	// procNames.push('关联父流程1');
	
	$("#throughputNodeLabel_input").on("click", function() {	
	var addIndex = layer.open({
						type : 2,
						area : [ '35%', '85%' ],
						title : '节点设置',
						maxmin : false, //开启最大化最小化按钮
						content : 'avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/node.jsp',
						btn : [ '确定', '关闭' ],
						yes : function(index) {
							var _activityIds = window["layui-layer-iframe"
						    + index].callbackdatanode1();
							var _activityNames = window["layui-layer-iframe"
							+ index].callbackdatanode2();
							var _fullNames = window["layui-layer-iframe"
							+ index].callbackdatanode3();
							var tempProcId = window["layui-layer-iframe"
							+ index].callbackdatanode4();
							if(!_activityIds || _activityIds=="null") {}
							else{
								var tempIds = _activityIds.split(",");
								activityIds = tempIds;
							}
							if(!_fullNames || _fullNames=="null") {
								tempProcArray = procArray;
								activityNames=[];
								procActfullNames=[];

							}  // 名称
							else{
								var tempNames = _activityNames.split(",");
								activityNames = tempNames;
								tempNames = _fullNames.split(",");
								procActfullNames = tempNames;
								tempProcArray=tempProcId;
							}
							$("#proc-echart1_1").hide();
							$("#proc-echart1_2").hide();
							$("#proc-echart1_3").hide();
							$("#proc-echart2_1").show();
							$("#proc-echart2_2").show();
							$("#proc-echart2_3").show();
							layer.close(index);
							initActivityStat();
						},
						btn2 : function(index){
							layer.close(index);
							$('#throughput_input').click();
						},
						cancel : function(index) {
							layer.close(index);
							$('#throughput_input').click();
						}
					});
				});
	$("#throughputEmployeesLabel_input").on("click", function() {	
		var addIndex = layer.open({
							type : 2,
							area : [ '35%', '85%' ],
							title : '员工设置',
							maxmin : false, //开启最大化最小化按钮
							content : 'avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/jobs.jsp',
							btn : [ '确定', '关闭' ],
							yes : function(index) {
								var _userNodeIds = window["layui-layer-iframe"
								+ index].callbackdatajobs1();
								var _userNodeNames = window["layui-layer-iframe"
								+ index].callbackdatajobs2();
								userArray = []; userNames = [];
								if(!_userNodeIds || _userNodeIds=="null") {}
								else{
									var tempIds = _userNodeIds.split(",");
									userArray = tempIds;
								}
								if(!_userNodeNames || _userNodeNames=="null") {}  // 名称
								else{
									var tempNames = _userNodeNames.split(",");
									userNames = tempNames;
								}
								$("#pos-echart2_0").hide();
								$("#pos-echart2_1").hide();
								$("#pos-echart3_0").show();
								$("#pos-echart3_1").show();
								layer.close(index);
								initUserStat();
							},
							btn2 : function(index){
								layer.close(index);
								$('#throughputJobsLabel_input').click();
							},
							cancel : function(index) {
								layer.close(index);
								$('#throughputJobsLabel_input').click();
							}
						});
					});
	$("#throughputJobLabel_input").on("click", function() {	
		var addIndex = layer.open({
							type : 2,
							area : [ '35%', '85%' ],
							title : '员工设置',
							maxmin : false, //开启最大化最小化按钮
							content : 'avicit/platform6/flowMonitoring/bpaDataAnalyze/jsp/jobs.jsp',
							btn : [ '确定', '关闭' ],
							yes : function(index) {
								var _userNodeIds = window["layui-layer-iframe"
								+ index].callbackdatajobs1();
								var _userNodeNames = window["layui-layer-iframe"
								+ index].callbackdatajobs2();
								userArray = []; userNames = [];
								if(!_userNodeIds || _userNodeIds=="null") {}
								else{
									var tempIds = _userNodeIds.split(",");
									userArray = tempIds;
								}
								if(!_userNodeNames || _userNodeNames=="null") {}  // 名称
								else{
									var tempNames = _userNodeNames.split(",");
									userNames = tempNames;
								}
								$("#org-echart3_1").hide();
								$("#org-echart3_3").hide();
								$("#org-echart3_0").show();
								$("#org-echart3_2").show();
								layer.close(index);
								initUserStat();
							},
							btn2 : function(index){
								layer.close(index);
								$('#throughputDepartmentLabel_input').click();
							},
							cancel : function(index) {
								layer.close(index);
								$('#throughputDepartmentLabel_input').click();
							}
						});
					});
		$('#firstContent').find('input[type=checkbox]').bind(
				'click',
				function() {
					$('#firstContent').find('input[type=checkbox]')
							.not(this).attr("checked", false);
				});
		$('#secondContent').find('input[type=checkbox]').bind(
				'click',
				function() {
					$('#secondContent').find('input[type=checkbox]')
							.not(this).attr("checked", false);
				});
		$('#thirdContent').find('input[type=checkbox]').bind(
				'click',
				function() {
					$('#thirdContent').find('input[type=checkbox]')
							.not(this).attr("checked", false);
				});
		if (index == 0) {
			$("#firstContent").show();
			$("#secondContent").hide();
			$("#thirdContent").hide();
		} else if (index == 1) {
			$("#secondContent").show();
			$("#firstContent").hide();
			$("#thirdContent").hide();
		} else if (index == 2) {
			$("#thirdContent").show();
			$("#firstContent").hide();
			$("#secondContent").hide();
		}

		$("#throughput_input").on("click", function() {	
			$("#proc-echart1_1").show();
			$("#proc-echart1_2").show();
			$("#proc-echart1_3").show();
			$("#proc-echart2_1").hide();
			$("#proc-echart2_2").hide();
			$("#proc-echart2_3").hide();
		});

		$("#throughputJobsLabel_input").on("click", function() {	
			$("#pos-echart2_0").show();
			$("#pos-echart2_1").show();
			$("#pos-echart3_0").hide();
			$("#pos-echart3_1").hide();
		});

		$("#throughputDepartmentLabel_input").on("click", function() {	
			$("#org-echart3_1").show();
			$("#org-echart3_3").show();
			$("#org-echart3_0").hide();
			$("#org-echart3_2").hide();
		});

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
		
		// #firstContent 1 基于流程的吞吐量
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getInstCountByProcA", 
			type: "post",
			data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.instCountByProcKey);
				var dataY = $.parseJSON(data.instCountByProcVal);
				var dataID = $.parseJSON(data.instCountByProcID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<procNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(procArray[i]==dataID[j] && procNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(procNames.length){
					dataX=procNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程办结数量分析',
						x:'center',
						y:'top',
						textAlign:'center' },
					tooltip: { show: true , trigger: 'axis'},
					// calculable : true,
					toolbox: {
						show : true,
						//echarts自定义工具
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
				                		   title : '流程办结数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processThroughput.jsp'
				                	   })
				                   }    
				            },
							mark : {show: false},
							dataView : {
								show: false,
								readOnly: false,
							},
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
						name: '流程办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '实例数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				myChart.setOption(optionProc,true);     //  在dom上绘制echarts图表
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					// alert(param.name + "," + param.data + "," + param.dataIndex); // 获取全部的参数
					// 判断选中
					var selectId = null;
					if(procArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = procArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=1" + "&selectId=" + selectId
					});
                    layer.full(curDrill);
				});
			}
		});//===========================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getTaskCountByProcA", 
			type: "post",
			data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.taskCountByProcKey);
				var dataY = $.parseJSON(data.taskCountByProcVal);
				var dataID = $.parseJSON(data.taskCountByProcID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<procNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(procArray[i]==dataID[j] && procNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(procNames.length){
					dataX=procNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程任务数量分析',
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
				                		   title : '流程任务数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processTaskThroughput.jsp'
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
						name: '任务办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '任务数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("proc-echart1_1"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(procArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = procArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=2" + "&selectId=" + selectId
					});
                    layer.full(curDrill);
				});
			}
		});//=======================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getToDeptCountByProcA", 
			type: "post",
			data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.toDeptCountByProcKey);
				var dataY = $.parseJSON(data.toDeptCountByProcVal);
				var dataID = $.parseJSON(data.toDeptCountByProcID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var arr=[];
				if (dataX) {
					for(var i=0;i<dataX.length;i++){
						arr.push({
							name : dataX[i],
							value : parseInt(dataY[i])
						});
					}   
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程到达部门覆盖率分析', 
						x:'center',
						y:'top',
						textAlign:'center' 
					},
					legend: {
						orient: 'vertical',
						x: '80%' ,
						y: 50,
						padding: 10,
						data: dataX
					},
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
				                		   title : '流程到达部门覆盖率详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processArrivalDepartment.jsp'
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
					tooltip : {
						trigger: 'item',
						textStyle : {
						fontSize : '12',
							color:'white'
						}
					},
					itemStyle:{},
					series : [
						{
							name: '参与部门数量',
							type : 'pie',
							startAngle: 0,
							radius : '70%',
							center: ['50%', '50%'],
							itemStyle: {
								normal: {
									label: {
										show: true,
										position: 'top',
										formatter: '{b}\n{d}%'
									}
								}
							},
							data : arr
						}
					]
				};
				// 显示图形
				var myChart = echarts.init(document.getElementById("proc-echart1_2"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = dataID[param.dataIndex];
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=3" + "&selectId=" + selectId
					});
					if(curDrill != null){
					    layer.full(curDrill);
					}
				});
			}
		});//=======================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getToPosCountByProcA", 
			type: "post",
			data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.toPosCountByProcKey);
				var dataY = $.parseJSON(data.toPosCountByProcVal);
				var dataID = $.parseJSON(data.toPosCountByProcID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var arr=[];
				if (dataX) {
					for(var i=0;i<dataX.length;i++){
						arr.push({
							name : dataX[i],
							value : parseInt(dataY[i])
						});
					}   
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程到达岗位覆盖率分析', 
						x:'center',
						y:'top',
						textAlign:'center' 
					},
					legend: {
						orient: 'vertical',
						x: '80%' ,
						y: 50,
						padding: 10,
						data: dataX
					},
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
				                		   title : '流程到达岗位覆盖率详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processArrivalJobs.jsp'
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
					tooltip : {
						trigger: 'item',
						textStyle : {
						fontSize : '12',
							color:'white'
						}
					},
					itemStyle:{},
					series : [
						{
							name: '参与岗位数量',
							type : 'pie',
							startAngle: 0,
							radius : '70%',
							center: ['50%', '50%'],
							itemStyle: {
								normal: {
									label: {
										show: true,
										position: 'top',
										formatter: '{b}\n{d}%'
									}
								}
							},
							data : arr
						}
					]
				};
				// 显示图形
				var myChart = echarts.init(document.getElementById("proc-echart1_3"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = dataID[param.dataIndex];
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=4" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//======================================================================================================
		// #secondContent 2 基于岗位的吞吐量
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getInstCountByPosA",
			type: "post",
			data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.instCountByPosKey);
				var dataY = $.parseJSON(data.instCountByPosVal);
				var dataID = $.parseJSON(data.instCountByPosID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<positionNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(positionNames.length){
					dataX=positionNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'岗位办结流程数量分析',
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
				                		   title : '岗位办结流程数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/jobCompletionProcess.jsp'
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
						name: '流程办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '实例数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("pos-echart2_0"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(positionArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = positionArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '岗位维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=1" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=====================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getTaskCountByPosA",
			type: "post",
			data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.taskCountByPosKey);
				var dataY = $.parseJSON(data.taskCountByPosVal);
				var dataID = $.parseJSON(data.taskCountByPosID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<positionNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(positionNames.length){
					dataX=positionNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'岗位办结任务数量分析',
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
				                		   title : '岗位办结任务数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/TaskCountByPosA.jsp'
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
						name: '任务办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '任务数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("pos-echart2_1"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(positionArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = positionArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '岗位维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=2" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//======================================================================================================
		// #thirdContent 3 基于组织的吞吐量
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getInstCountByDeptA",
			type: "post",
			data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.instCountByDeptKey);
				var dataY = $.parseJSON(data.instCountByDeptVal);
				var dataID = $.parseJSON(data.instCountByDeptID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<deptNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(deptNames.length){
					dataX=deptNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'部门办结流程数量分析',
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
				                		   title : '部门办结流程数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/InstCountByDeptA.jsp'
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
						name: '流程办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '实例数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("org-echart3_1"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(deptArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = deptArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '部门维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=1" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=======================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getTaskCountByDeptA",
			type: "post",
			data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.taskCountByDeptKey);
				var dataY = $.parseJSON(data.taskCountByDeptVal);
				var dataID = $.parseJSON(data.taskCountByDeptID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<deptNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(deptNames.length){
					dataX=deptNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'部门办结任务数量分析',
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
				                		   title : '部门办结任务数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/departmentCompletesTask.jsp'
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
						name: '任务办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '任务数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("org-echart3_3"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(deptArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = deptArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '部门维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=2" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=======================================================================================================
	});

	function throughput(res) {
	if (res == 0) {
		$("#firstContent").show();
		$("#secondContent").hide();
		$("#thirdContent").hide();
	} else if (res == 1) {
		$("#secondContent").show();
		$("#firstContent").hide();
		$("#thirdContent").hide();
	} else if (res == 2) {
		$("#thirdContent").show();
		$("#firstContent").hide();
		$("#secondContent").hide();
	}
	}

	// 针对用户节点选择绘制统计图
	function initUserStat(){
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getInstCountByUserA",
			type: "post",
			data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.instCountByUserKey);
				var dataY = $.parseJSON(data.instCountByUserVal);
				var dataID = $.parseJSON(data.instCountByUserID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<userNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(userArray[i]==dataID[j] && userNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(userNames.length){
					dataX=userNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'用户办结流程数量分析',
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
				                	  var curDrill= layer.open({
				                		   type: 2,
				                		   skin: 'layui-layer-rim', //加上边框
				                		   title : '用户办结流程数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/userProcess.jsp'
				                	   })
                                       if(curDrill != null){
                                           layer.full(curDrill);
                                       }
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
						name: '流程办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '实例数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart1 = echarts.init(document.getElementById("pos-echart3_0"));
				myChart1.setOption(optionProc,true);
				var myChart2 = echarts.init(document.getElementById("org-echart3_0"));
				myChart2.setOption(optionProc,true);
				myChart1.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(userArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = userArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '用户维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=101" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
				myChart2.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(userArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = userArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '用户维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=101" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//======================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getTaskCountByUserA",
			type: "post",
			data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.taskCountByUserKey);
				var dataY = $.parseJSON(data.taskCountByUserVal);
				var dataID = $.parseJSON(data.taskCountByUserID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				for(var i=0; i<userNames.length; i++){
					var j=0;
					for(j=0; j<dataID.length; j++){
						if(userArray[i]==dataID[j] && userNames[i]==dataX[j])
						{ dataYY.push(dataY[j]); break; }
					}
					if(j==dataID.length) { dataYY.push(0); }
				}
				if(userNames.length){
					dataX=userNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'用户办结任务数量分析',
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
				                		   title : '用户办结任务数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/userTasks.jsp'
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
						name: '任务办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '任务数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart1 = echarts.init(document.getElementById("pos-echart3_1"));
				myChart1.setOption(optionProc,true);
				var myChart2 = echarts.init(document.getElementById("org-echart3_2"));
				myChart2.setOption(optionProc,true);
				myChart1.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(userArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = userArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '用户维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=102" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
				myChart2.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(userArray.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = userArray[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '用户维度钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=102" + "&selectId=" + selectId
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=====================================================================================================
	}

	// 针对流程选择节点的统计图
	function initActivityStat(){
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getTaskCountByActivityA", 
			type: "post",
			data:JSON.stringify({procIds:tempProcArray,activityNames:activityNames,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.taskCountByActivityKey);
				var dataY = $.parseJSON(data.taskCountByActivityVal);
				var dataID = $.parseJSON(data.taskCountByActivityID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				var tempFlowID=[];   //  用于记录添加的flowID
				for(var i=0; i<procActfullNames.length; i++){
					var j=0;
					for(j=0; j<dataX.length; j++){
						if(procActfullNames[i]==dataX[j])
						{
							var k=0;
							for(k=0; k<tempFlowID.length; k++){
								if(procActfullNames[k]==dataX[j] && dataID[j]==tempFlowID[k]){ break; }
							}
							if(k==tempFlowID.length){
								tempFlowID.push(dataID[j]);
								dataYY.push(dataY[j]); 
								break;
							}
						}
					}
					if(j==dataID.length) {  tempFlowID.push(null);  dataYY.push(0); }
				}
				if(procActfullNames.length){
					dataX=procActfullNames;
					dataY=dataYY;
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程指定节点任务数量分析',
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
				                		   title : '流程指定节点任务数量详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processNodeTask.jsp'
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
						name: '任务办结数量',
						min : 0,
						type : 'value'
					},
					series : [
						{
							name: '任务数量',
							type : 'bar',
							// barWidth : 42,   // 固定宽度
							barMaxWidth:45,//最大宽度
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
				var myChart = echarts.init(document.getElementById("proc-echart2_1"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(procActfullNames.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = tempFlowID[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 节点名称
					var nodeName = param.name.split(":");
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程节点钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/nodeDrill.jsp?indexId=" + index + "&indexNext=102" + "&selectId=" + selectId + "&nodeName=" + nodeName[1]
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=====================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getToDeptCountByActivityA", 
			type: "post",
			data:JSON.stringify({procIds:tempProcArray,activityNames:activityNames,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.toDeptCountByActivityKey);
				var dataY = $.parseJSON(data.toDeptCountByActivityVal);
				var dataID = $.parseJSON(data.toDeptCountByActivityID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				var tempFlowID=[];   //  用于记录添加的flowID
				for(var i=0; i<procActfullNames.length; i++){
					var j=0;
					for(j=0; j<dataX.length; j++){
						if(procActfullNames[i]==dataX[j])
						{
							var k=0;
							for(k=0; k<tempFlowID.length; k++){
								if(procActfullNames[k]==dataX[j] && dataID[j]==tempFlowID[k]){ break; }
							}
							if(k==tempFlowID.length){
								tempFlowID.push(dataID[j]);
								dataYY.push(dataY[j]); 
								break;
							}
						}
					}
					if(j==dataID.length) {  tempFlowID.push(null);  dataYY.push(0); }
				}
				if(procActfullNames.length){
					dataX=procActfullNames;
					dataY=dataYY;
				}
				var arr=[];
				if (dataX) {
					for(var i=0;i<dataX.length;i++){
						arr.push({
							name : dataX[i],
							value : parseInt(dataY[i])
						});
					}   
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程指定节点到达部门覆盖率分析', 
						x:'center',
						y:'top',
						textAlign:'center' 
					},
					legend: {
						orient: 'vertical',
						x: '80%' ,
						y: 50,
						padding: 10,
						data: dataX
					},
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
				                		   title : '流程指定节点到达部门覆盖率详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processNodeDepartment.jsp'
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
					tooltip : {
						trigger: 'item',
						textStyle : {
						fontSize : '12',
							color:'white'
						}
					},
					itemStyle:{},
					series : [
						{
							name: '参与部门数量',
							type : 'pie',
							startAngle: 0,
							radius : '70%',
							center: ['50%', '50%'],
							itemStyle: {
								normal: {
									label: {
										show: true,
										position: 'top',
										formatter: '{b}\n{d}%'
									}
								}
							},
							data : arr
						}
					]
				};
				// 显示图形
				var myChart = echarts.init(document.getElementById("proc-echart2_2"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(procActfullNames.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = tempFlowID[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 节点名称
					var nodeName = param.name.split(":");
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', //加上边框
						title : '流程节点钻取图',
						area: ['75%', '80%'], //宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/nodeDrill.jsp?indexId=" + index + "&indexNext=103" + "&selectId=" + selectId + "&nodeName=" + nodeName[1]
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//======================================================================================================
		avicAjax.ajax({
			url: "bpa/flowmonitoring/getToPosCountByActivityA", 
			type: "post",
			data:JSON.stringify({procIds:tempProcArray,activityNames:activityNames,startTime:startMillis,endTime:endMillis}),
			contentType : 'application/json',
			dataType: "json",
			success: function (data) {
				var dataX = $.parseJSON(data.toPosCountByActivityKey);
				var dataY = $.parseJSON(data.toPosCountByActivityVal);
				var dataID = $.parseJSON(data.toPosCountByActivityID);
				if(dataX.length==0){
					dataX = ["暂无数据"];
					dataY = ["暂无数据"];
				}
				var dataYY=[];    //  用于判断没有返回指定的值时，设为0
				var tempFlowID=[];   //  用于记录添加的flowID
				for(var i=0; i<procActfullNames.length; i++){
					var j=0;
					for(j=0; j<dataX.length; j++){
						if(procActfullNames[i]==dataX[j])
						{
							var k=0;
							for(k=0; k<tempFlowID.length; k++){
								if(procActfullNames[k]==dataX[j] && dataID[j]==tempFlowID[k]){ break; }
							}
							if(k==tempFlowID.length){
								tempFlowID.push(dataID[j]);
								dataYY.push(dataY[j]); 
								break;
							}
						}
					}
					if(j==dataID.length) {  tempFlowID.push(null);  dataYY.push(0); }
				}
				if(procActfullNames.length){
					dataX=procActfullNames;
					dataY=dataYY;
				}
				var arr=[];
				if (dataX) {
					for(var i=0;i<dataX.length;i++){
						arr.push({
							name : dataX[i],
							value : parseInt(dataY[i])
						});
					}   
				}
				// 绘制统计分析图
				optionProc = {
					title : { text:'流程指定节点到达岗位覆盖率分析', 
						x:'center',
						y:'top',
						textAlign:'center' 
					},
					legend: {
						orient: 'vertical',
						x: '80%' ,
						y: 50,
						padding: 10,
						data: dataX
					},
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
				                		   title : '流程指定节点到达岗位覆盖率详情分析',
				                		   area: ['80%', '80%'], //宽高
				                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/html/processNodePosition.jsp'
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
					tooltip : {
						trigger: 'item',
						textStyle : {
						fontSize : '12',
							color:'white'
						}
					},
					itemStyle:{},
					series : [
						{
							name: '参与岗位数量',
							type : 'pie',
							startAngle: 0,
							radius : '70%',
							center: ['50%', '50%'],
							itemStyle: {
								normal: {
									label: {
										show: true,
										position: 'top',
										formatter: '{b}\n{d}%'
									}
								}
							},
							data : arr
						}
					]
				};
				// 显示图形
				var myChart = echarts.init(document.getElementById("proc-echart2_3"));
				myChart.setOption(optionProc,true);
				myChart.on('click', function(param) {   //  为图标点击事件添加响应
					var selectId = null;
					if(procActfullNames.length==0){ selectId = dataID[param.dataIndex]; }
					else{ selectId = tempFlowID[param.dataIndex]; }
					drillName = dataX[param.dataIndex];
					// 节点名称
					var nodeName = param.name.split(":");
					// 弹出弹窗
					var curDrill = layer.open({
						type: 2,
						skin: 'layui-layer-rim', // 加上边框
						title : '流程节点钻取图',
						area: ['75%', '80%'], // 宽高
						content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/nodeDrill.jsp?indexId=" + index + "&indexNext=104" + "&selectId=" + selectId + "&nodeName=" + nodeName[1]
					});
                    if(curDrill != null){
                        layer.full(curDrill);
                    }
				});
			}
		});//=======================================================================================================
	}
</script>
</html>