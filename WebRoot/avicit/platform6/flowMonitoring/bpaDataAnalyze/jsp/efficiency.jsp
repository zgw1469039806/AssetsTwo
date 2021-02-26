<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	String select = "\'" + request.getParameter("select") + "\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>效率分析</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
</head>
<body>
	<!-- 效率分析功能条 : 流程-->
	<div id="firstContent" class="Content">
	<div id="throughputFlow" class="throughputFlow" data-label="吞吐量分析:流程">
		<label for="throughputLabel">
			<div id="flow_div" class="text" style="visibility: visible;">
				<p>
					<span>流程</span>
				</p>
			</div>
		</label> <input id="throughput_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析流程"  checked/>
	</div>

	<div id="throughputNode" class="throughputNode" data-label="吞吐量分析 :节点">
		<label for="throughputNodeLabel">
			<div id="node_div" class="text" style="visibility: visible;">
				<p>
					<span>节点
						<input id="throughputNodeLabel_input" type="checkbox" value="checkbox" style="top:3px" name="吞吐量分析流程" />
					</span>
				</p>
			</div>
		</label> 
	</div>
	<div  class="myContainer" style="overflow-y: auto;background-color: #FFFFFF;">
		<div id="proc-echart1_0" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart1_1" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart2_1" title="" style="height:400px;text-align:center;display:none"></div>
		<div id="proc-echart1_2" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart1_3" title="" style="height:400px;text-align:center"></div>
		<div id="proc-echart2_3" title="" style="height:400px;text-align:center;display:none"></div>
	</div>
	</div>
	<!-- 效率分析功能条 : 岗位-->
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
			<div id="pos-echart1_0" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart1_1" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart1_2" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart1_3" title="" style="height:400px;text-align:center"></div>
			<div id="pos-echart2_0" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="pos-echart2_1" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="pos-echart2_2" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="pos-echart2_3" title="" style="height:400px;text-align:center;display:none"></div>
		</div>
	</div>
	<!-- 效率分析功能条 : 组织-->
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
			<div id="org-echart1_0" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="org-echart1_1" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="org-echart1_2" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="org-echart1_3" title="" style="height:400px;text-align:center;display:none"></div>
			<div id="org-echart2_0" title="" style="height:400px;text-align:center"></div>
			<div id="org-echart2_1" title="" style="height:400px;text-align:center"></div>
			<div id="org-echart2_2" title="" style="height:400px;text-align:center"></div>
			<div id="org-echart2_3" title="" style="height:400px;text-align:center"></div>
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
var selectedIds = parent._treeNodeId;
var selectedNames = parent._treeNodeName;
var timeScope = parent.selectedTime;

var drillName = null;  // 记录钻取的名称

// 传递流程节点选择变量
var activityIds = [];
var activityNames = [];

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

// 显示图形--通用数据函数
// KPI分析用
function seriesForKPI2Bar(datay1, datay2 ,datay3){
	var serie = [];
	var item = {
		name: '合理完成数量',
		type : 'bar',
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay1,
		barGap:'7%',  // 设定柱子间隔
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
					if(params.value==0){
						return '0';
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
	item = {
		name: '警告范围内数量',
		type : 'bar',
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay2,
		barGap:'7%',  // 设定柱子间隔
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
					if(params.value==0){
						return '0';
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
	item = {
		name: '警告范围外数量',
		type : 'bar',
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay3,
		barGap:'7%',  // 设定柱子间隔
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
					if(params.value==0){
						return '0';
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
// 效率分析用
function seriesForEff2Bar(datay1, datay2 ,datay3){
	var serie = [];
	var item = {
		name: '最大用时:h',
		type : 'bar',
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay1,
		barGap:'7%',  // 设定柱子间隔
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
	item = {
		name: '最小用时:h',
		type : 'bar',
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay2,
		barGap:'7%',  // 设定柱子间隔
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
	item = {
		name: '平均用时:h',
		type : 'bar',
		// yAxisIndex: 1,  // 决定左轴还是右轴
		// barWidth : 42,   // 固定宽度
		barMaxWidth:48,//最大宽度
		data: datay3,
		barGap:'7%',  // 设定柱子间隔
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

$(document).ready(function() {
	if(!selectedIds || selectedIds=="null") {}
	else{
		var tempIds = selectedIds.split(",");
		procArray = tempIds;
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
								$("#proc-echart2_1").show();
								$("#proc-echart1_3").hide();
								$("#proc-echart2_3").show();
								layer.close(index);
								initActivityStat();
							},
							btn2 : function(index){
								$('#throughput_input').click();
							},
							cancel : function(index) {
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
								$("#pos-echart1_0").hide();
								$("#pos-echart1_1").hide();
								$("#pos-echart1_2").hide();
								$("#pos-echart1_3").hide();
								$("#pos-echart2_0").show();
								$("#pos-echart2_1").show();
								$("#pos-echart2_2").show();
								$("#pos-echart2_3").show();
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
								$("#org-echart2_0").hide();
								$("#org-echart2_1").hide();
								$("#org-echart2_2").hide();
								$("#org-echart2_3").hide();
								$("#org-echart1_0").show();
								$("#org-echart1_1").show();
								$("#org-echart1_2").show();
								$("#org-echart1_3").show();
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
	// 切换回默认CheckBox时
	$("#throughput_input").on("click", function() {
		$("#proc-echart1_1").show();
		$("#proc-echart2_1").hide();
		$("#proc-echart1_3").show();
		$("#proc-echart2_3").hide();
	});
	$("#throughputJobsLabel_input").on("click", function() {
		$("#pos-echart1_0").show();
		$("#pos-echart1_1").show();
		$("#pos-echart1_2").show();
		$("#pos-echart1_3").show();
		$("#pos-echart2_0").hide();
		$("#pos-echart2_1").hide();
		$("#pos-echart2_2").hide();
		$("#pos-echart2_3").hide();
	});
	$("#throughputDepartmentLabel_input").on("click", function() {
		$("#org-echart2_0").show();
		$("#org-echart2_1").show();
		$("#org-echart2_2").show();
		$("#org-echart2_3").show();
		$("#org-echart1_0").hide();
		$("#org-echart1_1").hide();
		$("#org-echart1_2").hide();
		$("#org-echart1_3").hide();
	});
	
	// 1 #firstContent 基于流程的绩效分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForProcS", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForProcKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForProcVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForProcVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForProcVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForProcID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(procArray[i]==dataID[j] && procNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procNames.length){
				dataX=procNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程合理完成及超时完成数量分析',
				    x:'center',
                    y:'top',
                    textAlign:'center' },
                legend: {
                    orient: 'horizontal',
                    x: '60%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },
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
			                		   title : '流程合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/processKPI.jsp'
			                	   })
			                   }    
			            },
                        mark : {show: false},
                        dataView : {show: false, readOnly: false},
                        /*magicType : {show: true, type: ['line', 'bar']},*/
                        restore : {show: true}//,
                        /*saveAsImage : {show: true}*/
                    },
                    padding:[5,100]
                },
				grid : {
					top : 100,    //距离容器上边界40像素
					bottom: 20,   //距离容器下边界30像素
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_0"));
			myChart.setOption(optionProc,true);
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=111" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForTaskS", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForTaskKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForTaskID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(procArray[i]==dataID[j] && procNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procNames.length){
				dataX=procNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'任务合理完成及超时完成数量分析' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
                legend: {
                    orient: 'horizontal',
                    x: '60%' ,
                    y: 20,
                    padding: 10,
                    data: ['合理完成数量','警告范围内数量','警告范围外数量']
                },
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
			                		   title : '任务合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/taskKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=112" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//========================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForProcS", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForProcKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForProcVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForProcVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForProcVal3);
			var dataID = $.parseJSON(data.effAnalyzeForProcID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(procArray[i]==dataID[j] && procNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procNames.length){
				dataX=procNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程完成用时分析' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
                legend: {
                    orient: 'horizontal',
                    x: '60%' ,
                    y: 20,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
			                		   title : '流程完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/processEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				/* yAxis : [{
					name:'时间:h',
					min : 0,
					type : 'value'
				},{
					name:'平均用时:h',
					min : 0,
					type : 'value'
				}], */
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_2"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=113" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//========================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForTaskS", 
		type: "post",
		data:JSON.stringify({procIds:procArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForTaskKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForTaskVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForTaskVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForTaskVal3);
			var dataID = $.parseJSON(data.effAnalyzeForTaskID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<procNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(procArray[i]==dataID[j] && procNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procNames.length){
				dataX=procNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'任务完成用时分析' ,
				    x:'center',
                    y:'top',
                    textAlign:'center' },
				tooltip: { show: true , trigger: 'axis'},
                legend: {
                    orient: 'horizontal',
                    x: '60%' ,
                    y: 20,
                    padding: 10,
                    data: ['最大用时:h','最小用时:h','平均用时:h']
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
			                		   title : '任务完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/taskEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("proc-echart1_3"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=114" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	// 2 #secondContent 基于岗位的绩效分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForProcByPosS", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForProcByPosKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByPosVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByPosVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByPosVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForProcByPosID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(positionNames.length){
				dataX=positionNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于岗位的流程合理完成及超时完成数量分析',
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
			                		   title : '基于岗位的合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/positionProcessKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart1_0"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=111" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByPosS", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForTaskByPosKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByPosVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForTaskByPosID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(positionNames.length){
				dataX=positionNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于岗位的任务合理完成及超时完成数量分析' ,
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
			                		   title : '基于岗位的任务合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/taskProcessKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart1_1"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=112" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForProcByPosS", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForProcByPosKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForProcByPosVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForProcByPosVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForProcByPosVal3);
			var dataID = $.parseJSON(data.effAnalyzeForProcByPosID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(positionNames.length){
				dataX=positionNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于岗位的流程完成用时分析' ,
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
			                		   title : '基于岗位的流程完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/postProcessEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart1_2"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=113" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=====================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForTaskByPosS", 
		type: "post",
		data:JSON.stringify({posIds:positionArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForTaskByPosKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForTaskByPosVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForTaskByPosVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForTaskByPosVal3);
			var dataID = $.parseJSON(data.effAnalyzeForTaskByPosID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<positionNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(positionArray[i]==dataID[j] && positionNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(positionNames.length){
				dataX=positionNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于岗位的任务完成用时分析' ,
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
			                		   title : '基于岗位的任务完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/postTaskEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("pos-echart1_3"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=114" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	// 4 #add 基于部门的绩效分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForProcByDeptS", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForProcByDeptKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByDeptVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForProcByDeptID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(deptNames.length){
				dataX=deptNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于部门的流程合理完成及超时完成数量分析' ,
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
			                		   title : '基于部门的流程合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/orgProcessKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_0"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=111" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByDeptS", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForTaskByDeptKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByDeptVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForTaskByDeptID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(deptNames.length){
				dataX=deptNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于部门的任务合理完成及超时完成数量分析',
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
			                		   title : '基于部门的任务合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/orgTaskKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_1"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=112" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//========================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForProcByDeptS", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForProcByDeptKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForProcByDeptVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForProcByDeptVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForProcByDeptVal3);
			var dataID = $.parseJSON(data.effAnalyzeForProcByDeptID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(deptNames.length){
				dataX=deptNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于部门的流程完成用时分析' ,
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
			                		   title : '基于部门的流程完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/orgProcessEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_2"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=113" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForTaskByDeptS", 
		type: "post",
		data:JSON.stringify({deptIds:deptArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForTaskByDeptKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForTaskByDeptVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForTaskByDeptVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForTaskByDeptVal3);
			var dataID = $.parseJSON(data.effAnalyzeForTaskByDeptID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<deptNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(deptArray[i]==dataID[j] && deptNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(deptNames.length){
				dataX=deptNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于部门的任务完成用时分析' ,
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
			                		   title : '基于部门的任务完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/orgTaskEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart = echarts.init(document.getElementById("org-echart2_3"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=114" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
});


// 针对用户节点选择绘制统计图
function initUserStat(){
		// 3 #thirdContent 基于员工的绩效分析
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForProcByOrgS", 
		type: "post",
		data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForProcByOrgKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForProcByOrgVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForProcByOrgID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<userNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(userArray[i]==dataID[j] && userNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(userNames.length){
				dataX=userNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于用户的流程合理完成及超时完成数量分析' ,
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
			                		   title : '基于用户的流程合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/userProcessKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart1 = echarts.init(document.getElementById("org-echart1_0"));
			myChart1.setOption(optionProc,true);
			var myChart2 = echarts.init(document.getElementById("pos-echart2_0"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=121" + "&selectId=" + selectId
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=121" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//======================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForTaskByOrgS", 
		type: "post",
		data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForTaskByOrgKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForTaskByOrgVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForTaskByOrgID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<userNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(userArray[i]==dataID[j] && userNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(userNames.length){
				dataX=userNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于用户的任务合理完成及超时完成数量分析',
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
			                		   title : '基于用户的任务合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/userTaskKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart1 = echarts.init(document.getElementById("org-echart1_1"));
			myChart1.setOption(optionProc,true);
			var myChart2 = echarts.init(document.getElementById("pos-echart2_1"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=122" + "&selectId=" + selectId
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=122" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=====================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForProcByOrgS", 
		type: "post",
		data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForProcByOrgKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForProcByOrgVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForProcByOrgVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForProcByOrgVal3);
			var dataID = $.parseJSON(data.effAnalyzeForProcByOrgID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<userNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(userArray[i]==dataID[j] && userNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(userNames.length){
				dataX=userNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于用户的流程完成用时分析' ,
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
			                		   title : '基于用户的流程完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/userProcessEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart1 = echarts.init(document.getElementById("org-echart1_2"));
			myChart1.setOption(optionProc,true);
			var myChart2 = echarts.init(document.getElementById("pos-echart2_2"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=123" + "&selectId=" + selectId
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=123" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//====================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForTaskByOrgS", 
		type: "post",
		data:JSON.stringify({usrIds:userArray,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForTaskByOrgKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForTaskByOrgVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForTaskByOrgVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForTaskByOrgVal3);
			var dataID = $.parseJSON(data.effAnalyzeForTaskByOrgID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			for(var i=0; i<userNames.length; i++){
				var j=0;
				for(j=0; j<dataID.length; j++){
					if(userArray[i]==dataID[j] && userNames[i]==dataX[j]){
						dataYY1.push(dataY1[j]);
						dataYY2.push(dataY2[j]);
						dataYY3.push(dataY3[j]);
						break;
					}
				}
				if(j==dataID.length) { dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(userNames.length){
				dataX=userNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'基于用户的任务完成用时分析' ,
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
			                		   title : '基于用户的任务完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/userTaskEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
			}; 
			// 显示图形
			var myChart1 = echarts.init(document.getElementById("org-echart1_3"));
			myChart1.setOption(optionProc,true);
			var myChart2 = echarts.init(document.getElementById("pos-echart2_3"));
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=124" + "&selectId=" + selectId
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/commonDrill.jsp?indexId=" + index + "&indexNext=124" + "&selectId=" + selectId
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//========================================================================================================================
	}

	// 针对流程选择节点的统计图
	function initActivityStat(){
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getKPIAnalyzeForActivityS", 
		type: "post",
		data:JSON.stringify({procIds:tempProcArray,activityNames:activityNames,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.kPIAnalyzeForActivityKey);
			var dataY1 = $.parseJSON(data.kPIAnalyzeForActivityVal1);
			var dataY2 = $.parseJSON(data.kPIAnalyzeForActivityVal2);
			var dataY3 = $.parseJSON(data.kPIAnalyzeForActivityVal3);
			var dataID = $.parseJSON(data.kPIAnalyzeForActivityID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			var tempFlowID=[];   //  用于记录添加的flowID
			for(var i=0; i<procActfullNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(procActfullNames[i]==dataX[j]){
						var k=0;
						for(k=0; k<tempFlowID.length; k++){
							if(procActfullNames[k]==dataX[j] && dataID[j]==tempFlowID[k]){ break; }
						}
						if(k==tempFlowID.length){
							tempFlowID.push(dataID[j]);
							dataYY1.push(dataY1[j]);
							dataYY2.push(dataY2[j]);
							dataYY3.push(dataY3[j]);
							break;
						}
					}
				}
				if(j==dataID.length) { tempFlowID.push(null); dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procActfullNames.length){
				dataX=procActfullNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程指定节点任务合理完成及超时完成数量分析' ,
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
			                		   title : '指定流程节点任务合理完成及超时完成数量详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/nodesTaskKPI.jsp'
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
					name:'完成数量',
					min : 0,
					type : 'value'
				},
				series : seriesForKPI2Bar(dataY1,dataY2,dataY3)
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
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/nodeDrill.jsp?indexId=" + index + "&indexNext=122" + "&selectId=" + selectId + "&nodeName=" + nodeName[1]
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=====================================================================================================================
	avicAjax.ajax({
		url: "bpa/flowmonitoring/getEffAnalyzeForActivityS",
		type: "post",
		data:JSON.stringify({procIds:tempProcArray,activityNames:activityNames,startTime:startMillis,endTime:endMillis}),
		contentType : 'application/json',
		dataType: "json",
		success: function (data) {
			var dataX = $.parseJSON(data.effAnalyzeForActivityKey);
			var dataY1 = $.parseJSON(data.effAnalyzeForActivityVal1);
			var dataY2 = $.parseJSON(data.effAnalyzeForActivityVal2);
			var dataY3 = $.parseJSON(data.effAnalyzeForActivityVal3);
			var dataID = $.parseJSON(data.effAnalyzeForActivityID);
			if(dataX.length==0){
				dataX = ["暂无数据"]; dataY1 = ["暂无数据"]; dataY2 = ["暂无数据"]; dataY3 = ["暂无数据"];
			}
			var dataYY1=[];    //  用于判断没有返回指定的值时，设为0
			var dataYY2=[];
			var dataYY3=[];
			var tempFlowID=[];   //  用于记录添加的flowID
			for(var i=0; i<procActfullNames.length; i++){
				var j=0;
				for(j=0; j<dataX.length; j++){
					if(procActfullNames[i]==dataX[j]){
						var k=0;
						for(k=0; k<tempFlowID.length; k++){
							if(procActfullNames[k]==dataX[j] && dataID[j]==tempFlowID[k]){ break; }
						}
						if(k==tempFlowID.length){
							tempFlowID.push(dataID[j]);
							dataYY1.push(dataY1[j]);
							dataYY2.push(dataY2[j]);
							dataYY3.push(dataY3[j]);
							break;
						}
					}
				}
				if(j==dataID.length) { tempFlowID.push(null); dataYY1.push(0);dataYY2.push(0);dataYY3.push(0); }
			}
			if(procActfullNames.length){
				dataX=procActfullNames; dataY1=dataYY1; dataY2=dataYY2; dataY3=dataYY3;
			}
			// 绘制统计分析图
			optionProc = {
				title : { text:'流程指定节点任务完成用时分析' ,
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
			                		   skin: 'layui-layer-rim', //加上边e框
			                		   title : '指定流程节点任务完成用时详情分析',
			                		   area: ['80%', '80%'], //宽高
			                		   content: 'avicit/platform6/flowMonitoring/bpaDataAnalyze/efficHtml/nodesTaskEfficiency.jsp'
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
				yAxis : {  // 向左轴看齐
					name:'完成用时:h',
					min : 0,
					type : 'value'
				} ,
				series : seriesForEff2Bar(dataY1,dataY2,dataY3)
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
					skin: 'layui-layer-rim', //加上边框
					title : '流程节点钻取图',
					area: ['75%', '80%'], //宽高
					content: "avicit/platform6/flowMonitoring/bpaDataAnalyze/drillGraph/nodeDrill.jsp?indexId=" + index + "&indexNext=124" + "&selectId=" + selectId + "&nodeName=" + nodeName[1]
				});
                if(curDrill != null){
                    layer.full(curDrill);
                }
			});
		}
	});//=======================================================================================================================
	}

</script>
</html>