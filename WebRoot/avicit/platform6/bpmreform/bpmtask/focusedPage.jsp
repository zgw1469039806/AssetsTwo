<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>关注任务</title>
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
		<sec:accesscontrollist hasPermission="3"
			domainObject="bpmTask_button_del" permissionDes="批量取消">
			<a id="bpmTask_button_del" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
				title="批量取消"> 批量取消</a>
		</sec:accesscontrollist>		
	</div>
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3"
			domainObject="bpmTask_button_clean" permissionDes="清空所有关注">
			<a id="bpmTask_button_clean" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
				title="清空所有关注"  onclick="flowUtils.cleanAll()"> 清空所有关注</a>
		</sec:accesscontrollist>		
	</div>
	<div class="toolbar-right">
		<div id="commonSearch" class="input-group form-tool-search" >
			<input type="text" name="bpmTask_keyWord"
				id="bpmTask_keyWord" style="width:240px;"
				class="form-control input-sm" placeholder="请输入查询标题"> <label
				id="bpmTask_searchPart"
				class="icon icon-search form-tool-searchicon"></label>
		</div>		
	</div>
</div>
<table id="bpmTask"></table>
<div id="bpmTaskPager"></div>

</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmtask/js/BpmTask.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>

<script type="text/javascript">
	var bpmTask;
	
	function getTraceButtons(cellvalue, options, rowObject){
		if(cellvalue!=null && cellvalue!=''){
			cellvalue = cellvalue.trim();
		}
		var html = cellvalue;
		/**
		if('1'==rowObject.priority){
			html = '<span style="color:red;font-size:13px;">急&nbsp;</span>'+cellvalue;
		}else if('2'==rowObject.priority){
			html = '<span style="color:red;font-size:13px;">紧急&nbsp;</span>'+cellvalue;
		}else{
			html = cellvalue;
		}*/
		if(rowObject.task_b_id_ == null){
			return'<a href ='+rowObject.form_ +'>'+html+'</a>'
		}else{
			var processInstance = "'"+rowObject.procinst_+"'";
			var executionId = "'"+rowObject.execution_+"'";
			var dbid = "'"+rowObject.task_dbid_+"'";
			var businessId = "'"+rowObject.task_b_id_+"'";
			var url = "'"+rowObject.form_+"'";
			var title = "'"+rowObject.task_title_+"'";
			var taskType = "'"+rowObject.task_type_+"'";
			return '<a href="javascript:flowUtils.executeTask('+processInstance+','+executionId+','+dbid+','+businessId+','+url+','+title+','+taskType+')">'+html+'</a>';
		}
		
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
	
	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("task_title_");
		searchSubTips.push("标题");
		$('#bpmTask_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var bpmTaskGridColModel = [
			{
				label : 'dbid',
				name : 'task_dbid_',
				key : true,
				hidden : true
			}
			, {
				label : '标题',
				name : 'task_title_',
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
				name : 'create_',
				width : 140,
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
				name : 'curActName',
				align : 'left',
				sortable : true
			}
			, {
				label : '流程状态',
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
				label : '处理人',
				name : 'assignee_name',
				width : 80,
				fixed : true,
				align : 'left',
				sortable : false
			}
			, {
				label : '操作',
				name : '',
				width : 80,
				fixed : true,
				align : 'left',
				formatter:formatterOpt, 
				sortable : false
			}
			
		];

		var url = "bpm/taskPage/searchFocusedTaskByPage";
		bpmTask = new BpmTask('bpmTask', url, "formSub", bpmTaskGridColModel, 'searchDialogSub', '', '', searchSubNames, "bpmTask_keyWord",'','','',true);

	
		$('#bpmTask_button_batchExecuteTask').bind('click', function() {
			bpmTask.batchExecuteTask();
		});
		
		//关键字段查询按钮绑定事件
		$('#bpmTask_searchPart').bind('click', function() {
			bpmTask.searchByKeyWord();
		});
		
		
		/* function formatterOpt(value, options, rowObject) {
			var html = '';
	    	html += '<a href="javascript:void(0)" name="btn-flow-variable-reject" onclick="flowUtils.attTask(\''+rowObject.task_dbid_+'\')">取消关注</a>';
	    	return html;
		}; */
		
		function formatterOpt(value, options, rowObject) {
				var html = '';
		    	html += '<a href="javascript:void(0)" name="btn-flow-variable-reject" onclick="bpmTask.attTask(\''+rowObject.task_dbid_+'\')">取消关注</a>';
		    	return html;
			};
			
		$('#bpmTask_button_del').bind('click', function() {
			bpmTask.del1();
		});

	});
	

</script>
</html>