<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.sysprofile.SysProfileAPI"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory" %>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
	SysProfileAPI sysProfileAPI = SpringFactory.getBean(SysProfileAPI.class);
	String hideQuickDo = sysProfileAPI.getProfileValueByCodeByAppId("PLATFORM_V6_HIDEQUICKDO", SessionHelper.getApplicationId());
	if(hideQuickDo == null){
		hideQuickDo = "false";
	}
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>待办任务</title>
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

.form-input-task {
    width: 100px;
    position: relative;
    display: inline-block!important;
}

</style>
</head>
<body>

<div id="toolbar_bpmTask" class="toolbar">
	<div class="toolbar-left">
		<% if(!hideQuickDo.equals("true")){ %>
			<a id="bpmTask_button_batchExecute" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
				title="批量办理"> 批量办理</a>
		<% } %>
	</div>
	<div class="toolbar-right">
	   	<div id="queryTypeDiv" class="input-group form-input-task">
	   	    <input type="hidden" name="acceptDateBegin" id="acceptDateBegin">
	   	    <input type="hidden" name="acceptDateEnd" id="acceptDateEnd">
		    <select name="queryType" id="queryType"
				class="easyui-combobox form-control input-sm" onChange="selectSearchType(this)">
					<option value="title">标题</option>
					<option value="priority">紧急程度</option>
					<option value="acceptDate">接收日期</option>
			</select>
		</div>
		<div id="commonSearch" class="input-group form-tool-search">
			<input type="text" name="bpmTask_keyWord"
				id="bpmTask_keyWord" style="width:240px;"
				class="form-control input-sm" placeholder="请输入查询条件"> <label
				id="bpmTask_searchPart"
				class="icon icon-search form-tool-searchicon"></label>

		</div>

		<div class="input-group-btn form-tool-searchbtn">
			<a id="bpmTask_searchAll" href="javascript:void(0)"
				class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
				<span class="caret"></span>
			</a>
		</div>
	</div>
</div>
<table id="bpmTask"></table>
<div id="bpmTaskPager"></div>

</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable" >
			<tr>
				<th width="18%">标题：</th>
				<td width="30%"><input title="标题："
					class="form-control input-sm" type="text" name="taskTitle"
					id="taskTitle" /></td>
				<th width="15%">紧急程度：</th>
				<td width="30%">
					<select name="priority" id="priority" class="easyui-combobox form-control input-sm">
						<option value="">请选择</option>
						<option value="0">一般</option>
						<option value="1">紧急</option>
						<option value="2">特急</option>
					</select>
				</td>

			</tr>
			<tr>
				<th width="15%">申请人：</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="processStarter" name="processStarter">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="receptUserName" name="receptUserName"> <span
							class="input-group-addon" id="userbtn"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="15%">申请部门：</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="processStartDept" name="processStartDept">
							      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptidAlias" name="applyDeptidAlias" >
							      <span
									class="input-group-addon" id="deptbtn"> <i
									class="glyphicon glyphicon-equalizer"></i>
								</span>
								<!--
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="deptbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span> -->
						        </div>
				</td>

			</tr>
			<tr>
				<th width="15%">申请日期</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="processStartTimeBegin" id="processStartTimeBegin" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="15%" align="center" style="text-align:center">至</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="processStartTimeEnd" id="processStartTimeEnd" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="15%">流程状态：</th>
				<td width="30%">
					<select name="businessState" id="businessState" class="easyui-combobox form-control input-sm">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
					</select>
				</td>
				<th></th>
				<td></td>

			</tr>

		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmbusiness/todo/BpmTask.js" type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/progress.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>

<script type="text/javascript">
	var bpmTask;

	function selectSearchType(obj){
		var selectVal = obj.options[obj.selectedIndex].value;
		if('title'==selectVal){
			$("#commonSearch").html('<input type="text" name="bpmTask_keyWord"  id="bpmTask_keyWord" class="form-control input-sm" placeholder="请输入标题" onkeydown="if(event.keyCode==13){queryByKeyWord();}"> <label id="bpmTask_searchPart" class="icon icon-search form-tool-searchicon" onClick="queryByKeyWord()"></label>');
		}else if('priority'==selectVal){
			$("#commonSearch").html('<select name="priority" id="priority" class="easyui-combobox form-control input-sm" style="width:150px;" onChange="queryByPriority(this)"><option value="0">一般</option><option value="1">紧急</option><option value="2">特急</option></select>');
		}else if('acceptDate'==selectVal){
			var htmlAcceptDate = '<div class="dropdown">'
		        +'<a id="queryAcceptDateName" class="btn btn-primary form-tool-btn btn-sm form-control" role="button" style="text-align:center;align:center;width:120px;"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">时间不限 <span class="caret"></span></a>'
		        +'<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:center;align:center;"width:120px;">'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByAcceptDate(\'\')">时间不限</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByAcceptDate(\'today\')">今天</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByAcceptDate(\'threeDay\')">近三天</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByAcceptDate(\'oneWeek\')">近一周</a></li>'
		        +'  <li role="presentation"><a href="javascript:void(0)" onClick="queryByAcceptDate(\'oneMonth\')">近一月</a></li>'
		        +'  <li role="presentation" class="divider"></li>'
		        +'  <li role="presentation" ><a href="javascript:void(0)" data-stopPropagation="true">自定义</a></li>'
		        +'  <li data-stopPropagation="true" role="presentation" style="align:center;font-size:12px;">'
		        +'	&nbsp;从&nbsp;<input data-stopPropagation="true" class="date-picker" style="width:100px;font-size:12px;" type="text" '
				+'	name="customDateBegin" id="customDateBegin" onClick="onSelectCustomDate()"/>'
		        +'  </li>'
		        +'	<li data-stopPropagation="true" role="presentation" style="align:center;font-size:12px;">'
		        +'	&nbsp;至&nbsp;<input  class="date-picker" style="width:100px;font-size:12px;" type="text"'
				+'	name="customDateEnd" id="customDateEnd" onClick="onSelectCustomDate()"/>'
		        +'  </li>'
				+'  <li  role="presentation"><a href="javascript:void(0)" onClick="queryByCustomDate()">确定</a></li>'
		        +'</ul>'
		        +'</div>';
			$("#commonSearch").html(htmlAcceptDate);
			 $("ul.dropdown-menu").on("click", "[data-stopPropagation]", function(e) {
			        e.stopPropagation();
			    });
			$('.date-picker').datepicker({
				beforeShow : function() {
					setTimeout(function() {
						$('#ui-datepicker-div').css("z-index", 99999999);
					}, 100);
				},
				endDate : new Date(),
				onClose:function(){
					$("#queryAcceptDateName").removeClass("av-hold");
				}
			});
		}
	}

	function onSelectCustomDate(){
		$("#queryAcceptDateName").removeClass("av-hold");
		$("#queryAcceptDateName").addClass("av-hold");
	}

	function queryByKeyWord(){
		bpmTask.searchByKeyWord();
	}


	function queryByAcceptDate(selectDay){
		$("#queryAcceptDateName").removeClass("av-hold");
		var strFormat = "yyyy-MM-dd";
		var curDate=new Date()
		var strCurDate = curDate.format(strFormat);
		var strDateBegin;
		//var strDateEnd = strCurDate+" 23:59:59";
		var strDateEnd = strCurDate;
		var selectDayName;
		//今天
		if(selectDay=='today'){
			//strDateBegin = strCurDate+" 00:00:00";
			strDateBegin = strCurDate;
			selectDayName = "今天";
		}else if(selectDay=='threeDay'){//近三天
			var beginDate = curDate.addDay(-2);
			//strDateBegin = beginDate.format(strFormat)+" 00:00:00";
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近三天";

		}else if (selectDay=='oneWeek'){//近一周
			var beginDate = curDate.addDay(-6);
			//strDateBegin = beginDate.format(strFormat)+" 00:00:00";
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近一周";

		}else if(selectDay=='oneMonth'){//近一月
			var beginDate = curDate.addMonth(-1).addDay(1);
			//strDateBegin = beginDate.format(strFormat)+" 00:00:00";
			strDateBegin = beginDate.format(strFormat);
			selectDayName = "近一月";
		}else if(selectDay==''){
			selectDayName = "时间不限";
			strDateBegin = "";
			strDateEnd = "";
		}
		$("#queryAcceptDateName").html(selectDayName+' <span class="caret"></span>');
		bpmTask.searchByAcceptDate(strDateBegin,strDateEnd);
	}

	function queryByCustomDate(){
		$("#queryAcceptDateName").removeClass("av-hold");
		var customDateBegin;
		var customDateEnd;
		if($("#customDateBegin").val()=='' && $("#customDateEnd").val()=='' ){
			layer.alert('请选择日期！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
				}
			);
			$("#queryAcceptDateName").addClass("av-hold");
			return;
		}

		if($("#customDateBegin").val()!=''){
			//customDateBegin = $("#customDateBegin").val()+" 00:00:00";
			customDateBegin = $("#customDateBegin").val();
		}
		if($("#customDateEnd").val()!=''){
			//customDateEnd = $("#customDateEnd").val()+" 23:59:59";
			customDateEnd = $("#customDateEnd").val();
		}

		if($("#customDateBegin").val()!='' && $("#customDateEnd").val()!=''
				&& $("#customDateEnd").val()<$("#customDateBegin").val()){
			$("#queryAcceptDateName").addClass("av-hold");
			layer.alert('开始日期不能大于结束日期！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0
				}
			);
			return;
		}
		$("#queryAcceptDateName").html("自定义"+' <span class="caret"></span>');
		bpmTask.searchByAcceptDate(customDateBegin,customDateEnd);
	}

	function queryByPriority(obj){
		var selectVal = obj.options[obj.selectedIndex].value;
		bpmTask.searchByPriority(selectVal);

	}

	function getTraceButtons(cellvalue, options, rowObject){
		if(cellvalue!=null && cellvalue!=''){
			cellvalue = cellvalue.trim();
		}
		var createTimeStr = "";
		var endTimeStr = "";
		var preActName = "";
		var nextActName = "";
		if(rowObject.createTime!=null){
			var createTime = new Date(rowObject.createTime);
			createTimeStr = createTime.format("yyyy-MM-dd hh:mm:ss")
		}
		if(rowObject.endTime!=null){
			var endTime = new Date(rowObject.endTime);
			endTimeStr = endTime.format("yyyy-MM-dd hh:mm:ss");
		}
		if(rowObject.preActName!='' && rowObject.preActName != null){
			preActName = rowObject.preActName;
		}else{
			preActName = "开始";
		}


		if(rowObject.nextActName!='' && rowObject.nextActName!=null){
			nextActName = rowObject.nextActName;
		}else{
			nextActName = "结束";
		}
		var taskTitle = rowObject.taskTitle;
		if(taskTitle!=null){
			//taskTitle = escapeHtml(taskTitle);
		}

		var _dataContent = "<table width='240px' border='0' style='font-size:12px;' align='center'>"
			+"<tr><td width='40%' height='25'><lable>标题:</lable></td><td>"+taskTitle+"</td></tr>"
			+"<tr><td width='40%' height='25' >发送人:</td><td>"+rowObject.taskSendUser+"</td></tr>"
			+"<tr><td width='40%' height='25'>接收时间:</td><td>"+createTimeStr+"</td></tr>"
			+"<tr><td width='40%' height='25'>当前节点:</td><td>"+rowObject.curActName+"</td></tr>"
			+"<tr><td width='40%' height='25'>上一节点:</td><td>"+preActName+"</td></tr>"
			+"<tr><td width='40%' height='25'>下一节点:</td><td>"+nextActName+"</td></tr>"
			//+"<tr><td width='40%' height='25'>处理时间:</td><td>"+endTimeStr+"</td><td></td></tr>"
			//+"<tr style='border-top:#E5E5E5 solid 1px;'><td width='40%' height='25' colspan='3'>"+sketchMap+"</td></tr>"
			+"</table>";
		var html = cellvalue;
		if(cellvalue=='' || cellvalue=='null'){
			html = rowObject.curActName;
		}
		if(rowObject.sendType && rowObject.sendType.startsWith("doretreatto")){
			html = "退回：" + html;
		}
		html = decodeURIComponent(html).replaceAll("&#39;","'")
				.replaceAll("&quot;","\"")
				.replaceAll("&amp;","&")
				.replaceAll("&lt;","<")
				.replaceAll("&gt;",">");;
		/**
		if('1'==rowObject.priority){
			html = '<span style="color:red;font-size:13px;">急&nbsp;</span>'+cellvalue;
		}else if('2'==rowObject.priority){
			html = '<span style="color:red;font-size:13px;">紧急&nbsp;</span>'+cellvalue;
		}else{
			html = '<span >'+cellvalue+'</span>';
		}*/

		var processInstance = "'"+rowObject.processInstance+"'";
		var executionId = "'"+rowObject.executionId+"'";
		var dbid = "'"+rowObject.dbid+"'";
		var businessId = "'"+rowObject.businessId+"'";
		var url = "'"+rowObject.formResourceName+"'";
		var title = "'"+encodeURIComponent(encodeURIComponent(taskTitle))+"'";
		var taskType = "'"+rowObject.taskType+"'";
		return '<a data-toggle="popover" data-container="body" data-placement="right" data-content="'+_dataContent+'" href="javascript:flowUtils.executeTask('+processInstance+','+executionId+','+dbid+','+businessId+','+url+','+title+','+taskType+')">'+html+'</a>';
	}
	//js中的字符串正常显示在HTML页面中
	function escapeHtml(string) {
		var entityMap = {
			"&": "&amp;",
			"<": "&lt;",
			">": "&gt;",
			'"': '&quot;',
			"'": '&#39;',
			"/": '&#x2F;'
		};
		return String(string).replace(/[&<>"'\/]/g, function (s){
			return entityMap[s];
		});
	}


	function formatTaskOpt(cellvalue, options, rowObject){
		var processInstance = "'"+rowObject.processInstance+"'";
		var executionId = "'"+rowObject.executionId+"'";
		var dbid = "'"+rowObject.dbid+"'";
		var businessId = "'"+rowObject.businessId+"'";
		var url = "'"+rowObject.formResourceName+"'";
		var taskTitle = rowObject.taskTitle;
		if(taskTitle!=null){
			//处理特殊符号<>"'/
			taskTitle = encodeURIComponent(encodeURIComponent(taskTitle));
		}
		taskTitle = "'"+taskTitle+"'";
		var taskType = "'"+rowObject.taskType+"'";
		var taskName = "'"+rowObject.taskName+"'";
		return '<a href="javascript:flowUtils.quickDoTask('+processInstance+','+executionId+','+dbid+','+businessId+','+url+','+taskTitle+','+taskType+','+taskName+')">'+'办理'+'</a>';
	}

	function formatPriority(cellvalue, options, rowObject){
		var html = "";
		if('1'==cellvalue){
			html = '<span style="color:red;font-size:13px;">急&nbsp;</span>';
		}else if('2'==cellvalue){
			html = '<span style="color:red;font-size:13px;">紧急&nbsp;</span>';
		}else{
			html = '<span style="color:red;font-size:13px;">一般&nbsp;</span>';
		}
		return html;

	}

	function bpm_operator_refresh(){
		bpmTask.reLoad();
	}

	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("taskTitle");
		searchSubTips.push("标题");
		$('#bpmTask_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var bpmTaskGridColModel = [
			{
				label : 'dbid',
				name : 'dbid',
				key : true,
				hidden : true
			},
			{
				label : 'businessId',
				name : 'businessId',
				hidden : true
			},
			{
				label : 'formResourceName',
				name : 'formResourceName',
				hidden : true
			},
			{
				label : 'taskName',
				name : 'taskName',
				hidden : true
			},
			{
				label : 'hisActInstId',
				name : 'hisActInstId',
				hidden : true
			},
			{
				label : 'executionId',
				name : 'executionId',
				hidden : true
			},
			{
				label : 'processInstance',
				name : 'processInstance',
				hidden : true
			}
			, {
				label : '标题',
				name : 'taskTitle',
				align : 'left',
				sortable : false,
				formatter : getTraceButtons
			}, {
				label : '紧急程度',
				name : 'priority',
				width : 80,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : formatPriority
			}
			, {
				label : '申请日期',
				name : 'processStartTime',
				width : 120,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var startdateMi = value;
					if (startdateMi == undefined) {
						return '';
					}
					var newDate = new Date(startdateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}
			,{
				label : '接收时间',
				name : 'createTime',
				width : 120,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : function(value, rec) {
					var startdateMi = value;
					if (startdateMi == undefined) {
						return '';
					}
					var newDate = new Date(startdateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}
			,{
				label : '当前节点',
				name : 'activityalias_',
				align : 'left',
				sortable : true
			},{
				label : '应完时间',
				name : 'reasonableFinishTime',
                width : 100,
                fixed : true,
				align : 'center',
				sortable : false,
                formatter : function(value, rec) {
                    var startdateMi = value;
                    if (startdateMi == undefined) {
                        return '';
                    }
                    var newDate = new Date(startdateMi);
                    return newDate.format("yyyy-MM-dd hh:mm:ss");
                }
			}
			, {
				label : '状态',
				name : 'businessState',
				width : 60,
				fixed : true,
				align : 'center',
				sortable : true,
				formatter : function(cellvalue, options, rowObject) {
					if (cellvalue == 'start') {
						return '拟稿中';
					} else if (cellvalue == 'active') {
						return '流转中';
					} else if (cellvalue == 'ended') {
						return '已完成';
					}else{
						return cellvalue;
					}

				}
			}
			, {
				label : '发送人',
				name : 'taskSendUser',
				width : 80,
				fixed : true,
				align : 'left',
				sortable : false
			}
<% if(!hideQuickDo.equals("true")) { %>
            ,  {
                label : '操作',
                name : 'opt',
                width : 60,
                fixed : true,
                align : 'center',
                sortable : false,
                formatter : formatTaskOpt
            }
<% } %>
		];

		var url = "bpm/todo/portal/querywaittodo?taskType=0&taskFinished=0";
		bpmTask = new BpmTask('bpmTask', url, "formSub", bpmTaskGridColModel, 'searchDialogSub', '',
				'', searchSubNames, "bpmTask_keyWord",'','tab1','我的待办',true);


		$('#bpmTask_button_batchExecute').bind('click', function() {
			bpmTask.batchExecuteTask();
		});

		//打开高级查询
		$('#bpmTask_searchAll').bind('click', function() {
			bpmTask.openSearchForm(this, $('#bpmTask'));
		});
		//关键字段查询按钮绑定事件
		$('#bpmTask_searchPart').bind('click', function() {
			bpmTask.searchByKeyWord();
		});

		$('#receptUserName').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'processStarter',
				textFiled : 'receptUserName',
				viewScope : 'currentOrg'
			});
		});

		$('#applyDeptidAlias').on('focus',function(){
	    	new H5CommonSelect({type:'deptSelect', idFiled:'processStartDept',textFiled:'applyDeptidAlias',viewScope : 'currentOrg'});
		});

		flowUtils.getBatchHandleInfo();

	});


</script>
</html>
