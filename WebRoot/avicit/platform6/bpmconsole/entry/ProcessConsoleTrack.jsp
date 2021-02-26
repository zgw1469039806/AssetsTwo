<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<%
	String processInstanceId = request.getParameter("processInstanceId");//流程实例id
	String states = request.getParameter("state");//流程状态
	String id = request.getParameter("id");//流程执行id
	String pdid = request.getParameter("pdid");//流程定义id
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程跟踪</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/bpm/client/js/ToolBar.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/ButtonProcessing.js" type="text/javascript"></script>
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
	var mxBasePath = _basePath + "static/js/platform/designer/";
	var _picturePath = _basePath + "static/js/platform/bpm/client/picture/";
	var _processInstanceId = "<%=processInstanceId%>";
</script>
<script src="<%=basePath%>static/js/platform/component/common/mxClient.js"></script>
<script src="<%=basePath%>static/js/platform/designer/mxApplication.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/ComUtils.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/MyAction.js"></script>
<!-- 元素 -->
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyBase.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyTransition.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyStart.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyEnd.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyTask.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJava.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MySql.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyWs.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyState.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyFork.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJoin.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyExclusive.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MySubprocess.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyForeach.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyJms.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyCustom.js"></script>
<script src="<%=basePath%>static/js/platform/bpm/client/picture/excells/MyText.js"></script>

</head>

<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var processInstanceId = '<%=processInstanceId%>';
var states = '<%=states%>';
var executionId = '<%=id%>';
var pdid = '<%=pdid%>';
	//定义全局变量,给更换版本传数据
	var myobj;
	var selectedTaskName;
	$(function() {
		//jquery 注册按钮事件
		isButtonEvents('1;4;5;6');
		//显示按钮
		isButtonDisplay();
		$('#track').tabs({
			fit : true,
			onSelect : function(title, index) {
				if (index == 0) {
				}
				if (index == 1) {
					createLS();
				}
				if (index == 2) {
					createSP();
				}
			}
		});

		$(".tabs-header").css("z-index", "9999");
	});

	//创建工作项信息表格
	function createSP() {
		$('#gzxxx').datagrid({
			toolbar : [ {
				text : '完         成',
				iconCls : 'icon-ok',
				handler : function() {
					var num = checkIsEndOrDel();
					if (num == 1) {
						return;
					}
					var tempFlag = isOpreate();
					if (tempFlag) {
						finishTask(tempFlag, processInstanceId);
					}
				}
			}, '-', {
				text : '转          办',
				iconCls : 'icon-redo',
				handler : function() {
					var tempFlag = isOpreate();
					if (tempFlag) {
						if (states == 'ended' || states == 'suspended') {
							$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
						} else {
							if (tempFlag) {
								var data = $('#gzxxx').datagrid('getSelected');
								dosupersede(processInstanceId, executionId, tempFlag, '', selectedTaskName, data.assignee_);
							}
						}
					}
				}
			}, '-', {
				text : '转          发',
				iconCls : 'icon-back',
				handler : function() {
					var tempFlag = isOpreate();
					if (tempFlag) {
						if (states == 'ended' || states == 'suspended') {
							$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
						} else {
							if (tempFlag) {
								var data = $('#gzxxx').datagrid('getSelected');
								dotransmit(processInstanceId, executionId, tempFlag, '', '', data.assignee_);
							}
						}
					}
				}
			}, '-', {
				text : '添加读者',
				iconCls : 'icon-undo',
				handler : function() {
					var tempFlag = isReaderRight();
					doglobalreader(processInstanceId, executionId, tempFlag, '', '');
				}
			}, '-', {
				text : '增          发',
				iconCls : 'icon-add',
				handler : function() {
					var tempFlag = isOpreate();
					if (tempFlag) {
						if (states == 'ended' || states == 'suspended') {
							$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
						} else {
							if (tempFlag) {
								doadduser(processInstanceId, executionId, tempFlag, '', '');
							}
						}
					}
				}
			}, '-', {
				text : '删           除',
				iconCls : 'icon-no',
				handler : function() {
					var num = checkIsEndOrDel();
					if (num == 1) {
						return;
					}
					var tempFlag = deleteTask();
					if (tempFlag) {
						$.messager.confirm("操作提示", "您确认要删除吗?", function(data) {
							if (data) {
								easyuiMask();
								ajaxRequest("POST", "userIds=" + tempFlag + "&executionId=" + executionId + "&processInstanceId=" + processInstanceId, "platform/bpm/bpmConsoleAction/doDeleteProcessTask", "json", "backFinishedTodo");
							}
						});
					}
				}
			} ],
			url : 'platform/bpm/bpmConsoleAction/getProcessEntryTodoList.json?processInstanceId=' + processInstanceId,
			width : '100%',
			nowrap : false,
			striped : true,
			autoRowHeight : false,
			singleSelect : true,
			checkOnSelect : true,
			height : 400,
			remoteSort : false,
			sortName : 'create_', //排序字段,当表格初始化时候的排序字段
			sortOrder : 'desc', //定义排序顺序
			fitColumns : true,
			pagination : true,
			rownumbers : true,
			loadMsg : ' 处理中，请稍候…',
			columns : [ [ {
				field : 'op',
				title : '操作',
				width : 25,
				align : 'left',
				checkbox : true
			}, {
				field : 'dbid_',
				title : '工作项ID',
				width : 25,
				align : 'left',
				sortable : true
			}, {
				field : 'task_title_',
				title : '工作项名称',
				width : 35,
				align : 'left',
				sortable : true
			}, {
				field : 'state_',
				title : '状态',
				width : 25,
				align : 'left',
				sortable : true
			}, {
				field : 'process_def_name_',
				title : '所属流程实例',
				width : 45,
				align : 'left',
				sortable : true
			}, {
				field : 'assignee_',
				title : '参与者ID',
				width : 45,
				align : 'left',
				sortable : true
			}, {
				field : 'assigneeName',
				title : '参与者名称',
				width : 35,
				align : 'left',
				sortable : true
			}, {
				field : 'assigneeDeptName',
				title : '参与者部门',
				width : 35,
				align : 'left',
				sortable : true
			}, {
				field : 'open_',
				title : '打开时间',
				width : 40,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var openDate = rec.open_;
					if (openDate == undefined) {
						return;
					}
					var newDate = new Date(openDate);
					return newDate.Format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				field : 'end_',
				title : '完成时间',
				width : 40,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var tempDate = rec.end_;
					if (tempDate == undefined) {
						return;
					}
					var endDate = new Date(tempDate);
					return endDate.Format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				field : 'create_',
				hidden : true
			} ] ]
		});
		//设置分页控件
		var p = $('#gzxxx').datagrid('getPager');
		$(p).pagination({
			pageSize : 10,//每页显示的记录条数，默认为10
			pageList : [ 5, 10, 15, 20 ],//可以设置每页记录条数的列表
			beforePageText : '第',//页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}

	//创建活动实例信息表格
	function createLS() {
		$('#hdslxx').datagrid({
			url : 'platform/bpm/bpmConsoleAction/getProcessEntryActList.json?processInstanceId=' + processInstanceId,
			toolbar : [
			/**
			{
			id:'qdlz',
			text:'驱动流转',
			iconCls:'icon-redo',
			handler:function(){
				alert(states);
			}
			},'-',
			 */
			/*{
				id : 'thsyb',
				text : '退回上一步',
				iconCls : 'icon-redo',
				handler : function() {
					if (states == 'ended' || states == 'suspended') {
						$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
					} else {
						doretreattodraft(processInstanceId, executionId, '', '', '');
					}
				}
			}, '-', */
			{
				id : 'thfgr',
				text : '退回发稿人',
				iconCls : 'icon-back',
				handler : function() {
					if (states == 'ended' || states == 'suspended') {
						$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
					} else {
						doretreattodraft(processInstanceId, executionId, '', '', '');
					}
				}
			}, '-', {
				id : 'lctz',
				text : '流程跳转',
				iconCls : 'icon-undo',
				handler : function() {
					if (states == 'ended' || states == 'suspended') {
						$.messager.alert("操作提示", "结束和挂起的流程不能操作！", "info");
					} else {
						doglobaljump(processInstanceId, executionId, '', '', '');
					}
				}
			} ],
			width : '100%',
			height : 400,
			nowrap : false,
			striped : true,
			singleSelect : true,
			checkOnSelect : true,
			autoRowHeight : false,
			fitColumns : true,
			remoteSort : false,
			sortName : 'start_', //排序字段,当表格初始化时候的排序字段
			sortOrder : 'desc', //定义排序顺序
			loadMsg : ' 处理中，请稍候…',
			pagination : true,
			rownumbers : true,
			columns : [ [ {
				field : 'dbid_',
				title : '活动实例ID',
				width : 30,
				align : 'center',
				sortable : true
			}, {
				field : 'alias_',
				title : '活动实例名称',
				width : 60,
				align : 'center',
				sortable : true
			}, {
				field : 'type_',
				title : '节点类型',
				width : 30,
				align : 'center',
				sortable : true
			}, {
				field : 'hproci_',
				title : '流程实例ID',
				width : 60,
				align : 'center',
				sortable : true
			}, {
				field : 'start_',
				title : '开始时间',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var openDate = rec.start_;
					if (openDate == undefined) {
						return;
					}
					var newDate = new Date(openDate);
					return newDate.Format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				field : 'end_',
				title : '结束时间',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var tempDate = rec.end_;
					if (tempDate == undefined) {
						return;
					}
					var endDate = new Date(tempDate);
					return endDate.Format("yyyy-MM-dd hh:mm:ss");
				}
			} ] ]
		});
		//设置分页控件
		var p = $('#hdslxx').datagrid('getPager');
		$(p).pagination({
			pageSize : 10,//每页显示的记录条数，默认为10
			pageList : [ 5, 10, 15, 20 ],//可以设置每页记录条数的列表
			beforePageText : '第',//页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}

	function isButtonEvents(flag) {
		var temp = flag.split(";");
		for (var i = 0; i < temp.length; i++) {
			switch (temp[i]) {
			case '1':
				$('#btn1').bind('click', function() {
					var url = getPath2() + "/avicit/platform6/bpmconsole/entry/ProcessVariable.jsp?processInstanceId=" + processInstanceId;
					var usd = new UserSelectDialog("lcslblck", "650", "450", encodeURI(url), "流程实例变量窗口");
					usd.show();
				});
				break;
			case '2':
				$('#btn2').bind('click', function() {
					$.messager.confirm("操作提示", "您确认要挂起该流程实例吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest("POST", "processInstanceId=" + processInstanceId, "platform/bpm/bpmConsoleAction/supProcessEntry", "json", "backFinished");
						}
					});
				});
				break;
			case '3':
				$('#btn3').bind('click', function() {
					$.messager.confirm("操作提示", "您确认要恢复该流程实例吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest("POST", "processInstanceId=" + processInstanceId, "platform/bpm/bpmConsoleAction/recoverProcessEntry", "json", "backFinished");
						}
					});
				});
				break;
			case '4':
				$('#btn4').bind('click', function() {
					$.messager.confirm("操作提示", "您确认要结束该流程实例吗?", function(data) {
						if (data) {
							easyuiMask();
							//ajaxRequest("POST", "processInstanceId=" + executionId, "platform/bpm/bpmConsoleAction/endProcessEntry", "json", "backFinished");
							ajaxRequest("POST", "executionId=" + executionId, "platform/bpm/clientbpmoperateaction/doend", "json", "backFinished");
						}
					});
				});
				break;
			case '5':
				$('#btn5').bind('click', function() {
					$.messager.confirm("操作提示", "您确认要删除该流程实例吗?", function(data) {
						if (data) {
							easyuiMask();
							ajaxRequest("POST", "processInstanceId=" + executionId + "&entryId=" + processInstanceId, "platform/bpm/bpmConsoleAction/deleteProcessEntry", "json", "backFinished");
						}
					});
				});
				break;
			case '6':
				$('#btn6').bind('click', function() {
					checkIsChangeVersion();
				});
				break;
			}
		}
	}

	function isButtonDisplay() {
		if (states == 'suspended') {
			$('#btn2').linkbutton('disable');
			$('#btn2').unbind();
			$('#btn3').linkbutton('enable');
			isButtonEvents('3');
		} else if (states == 'ended') {
			$('#btn1').linkbutton('disable');
			$('#btn1').unbind();
			$('#btn2').linkbutton('disable');
			$('#btn2').unbind();
			$('#btn3').linkbutton('disable');
			$('#btn3').unbind();
			$('#btn4').linkbutton('disable');
			$('#btn4').unbind();
			$('#btn6').linkbutton('disable');
			$('#btn6').unbind();
		} else {
			$('#btn3').linkbutton('disable');
			$('#btn3').unbind();
			$('#btn2').linkbutton('enable');
			isButtonEvents('2');
		}
	}

	function backFinished(obj) {
		easyuiUnMask();
		/* if (obj != null && obj.success == true) {
			states = obj.istate;
			$.messager.show({
				title : '提示',
				msg : "操作成功！"
			});
			isButtonDisplay();
		} else {
			$.messager.show({
				title : '提示',
				msg : "操作失败！"
			});
		} */
		states = "ended";
		$.messager.show({
			title : '提示',
			msg : "操作成功！"
		});
		isButtonDisplay();
	}

	function isOpreate() {
		var data = $('#gzxxx').datagrid('getSelected');
		if (data == null) {
			$.messager.alert("操作提示", "请您选择一条记录！", "info");
			return;
		}
		var taskId = data.dbid_;
		var todoType = data.task_type_;
		selectedTaskName = data.task_name_;
		//var todoState = data.task_state_;
		var processState = data.state_;
		//var todoFinished = data.task_finished_;
		if (processState != 'completed' && todoType == 0) {
			return taskId;
		} else {
			$.messager.alert("操作提示", "不能选择已经完成的或者待阅工作项!", "info");
			return false;
		}
	}
	function checkIsEndOrDel() {
		//先判断是否能完成或者删除
		var data = $('#gzxxx').datagrid('getRows');
		var counts = 0;
		for (var i = 0; i < data.length; i++) {
			var todoType = data[i].task_type_;
			var processState = data[i].state_;
			if (processState != 'completed' && todoType == 0) {
				counts++;
			}
		}
		if (counts == 1) {
			$.messager.alert("操作提示", "只剩最后一条未完成记录，不能操作此项", "info");
		}
		return counts;
	}
	function deleteTask() {
		//看是否能提交
		var data = $('#gzxxx').datagrid('getSelected');
		if (data == null) {
			$.messager.alert("操作提示", "请您选择一条记录！", "info");
			return;
		}
		var userid = data.assignee_;
		var todoType = data.task_type_;
		var processState = data.state_;
		if ((processState == null || processState == '') && todoType == 0) {
			return userid;
		} else {
			$.messager.alert("操作提示", "该工作项不能删除!", "info");
			return false;
		}
		return;
	}
	function isReaderRight() {
		var data = $('#gzxxx').datagrid('getSelected');
		if (data == null) {
			$.messager.alert("操作提示", "请您选择一条记录！", "info");
			return;
		}
		var taskId = data.dbid_;
		return taskId;
	}
	//结束工作项任务
	function finishTask(id, processInstanceId) {
		$.messager.confirm("操作提示", "是否要完成?", function(data) {
			if (data) {
				easyuiMask();
				ajaxRequest("POST", "dbid=" + id + "&entryId=" + processInstanceId, "platform/bpm/clientbpmdisplayaction/adminFinishtodo", "json", "backFinishedTodo");
			}
		});
	}
	//工作项任务完成后，回调函数
	function backFinishedTodo(obj) {
		easyuiUnMask();
		if (obj != null && (obj.mes == true || obj.success == true)) {
			$.messager.show({
				title : '提示',
				msg : "操作成功！"
			});
			$('#gzxxx').datagrid('reload');
		} else {
			$.messager.show({
				title : '提示',
				msg : "操作失败！"
			});
		}
	}

	//验证是否能更换版本
	function checkIsChangeVersion() {
		easyuiMask();
		ajaxRequest("POST", "pdid=" + pdid, "platform/bpm/bpmConsoleAction/checkProcessVersion", "json", "backChecked");
	}
	function backChecked(obj) {
		easyuiUnMask();
		if (obj != null && obj.success == true) {
			myobj = obj.rows;
			var url = getPath2() + "/avicit/platform6/bpmconsole/entry/ChangeProcessVersionList.jsp";
			var usd = new UserSelectDialog("qdlcghbb", "600", "400", encodeURI(url), "流程更换版本选择");
			usd.show();
		} else {
			$.messager.alert("操作提示", "现有流程只有一个版本，不能更换版本！", "info");
		}
	}
</script>
<body>

	<div class="easyui-tabs" id="track">
		<div title="流程实例图" style="padding:10px;width:auto">
			<div style="position:absolute;left:0px;top:0px;width:100%;height:100%;overflow:auto;">
				<div id="buts" style="position:absolute;left:10px;top:35px;z-index:2">
					<a id="btn1" class="easyui-linkbutton" plain="false" href="javascript:void(0);">流程变量</a>
					<a id="btn2" class="easyui-linkbutton" plain="false" href="javascript:void(0);">挂起</a>
					<a id="btn3" class="easyui-linkbutton" plain="false" href="javascript:void(0);">恢复</a>
					<a id="btn4" class="easyui-linkbutton" plain="false" href="javascript:void(0);">终止</a>
					<a id="btn5" class="easyui-linkbutton" plain="false" href="javascript:void(0);">删除</a>
					<a id="btn6" class="easyui-linkbutton" plain="false" href="javascript:void(0);">更换版本</a>
					<!-- 暂时屏蔽吧，好像还有问题 -->
					<a id="playBut" class="easyui-linkbutton" plain="false" href="javascript:void(0);">播放动画</a>
					<a id="stopBut" class="easyui-linkbutton" plain="false" href="javascript:void(0);">停止动画</a>
				</div>
				<div id="graph" style="position:absolute;left:0px;top:60px;">
					<div id="mi" style="position:absolute;left:0px;top:0px;width:8px;height:8px;background-color:red;display:none;border-radius:4px;border:solid red 1px;"></div>
					<div id="bo" style="position:absolute;left:0px;top:0px;width:65px;height:60px;display:none;border:solid red 2px;"></div>
				</div>
			</div>
		</div>
		<div title="活动实例信息" style="padding:10px;width:auto">
			<table id="hdslxx"></table>
		</div>
		<div title="工作项信息" style="padding:10px;width:auto">
			<table id="gzxxx"></table>
		</div>
	</div>
</body>
</html>
