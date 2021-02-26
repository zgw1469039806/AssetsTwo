<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.quartz.dto.Job"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_add" permissionDes="添加">
	  	  <a id="sysJob_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_edit" permissionDes="编辑">
		  <a id="sysJob_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_delete" permissionDes="删除">
		  <a id="sysJob_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_delete" permissionDes="调度">
			<div class="btn-group">
			   <button type="button" class="btn btn-primary form-tool-btn btn-sm dropdown-hover" data-toggle="dropdown">调度 <span class="caret"></span></button>
			   <ul class="dropdown-menu" role="menu">
			      <li><a href='javascript:;' onclick="startJob();">开始</a></li>
			      <li role="separator" class="divider"></li>
			      <li><a href='javascript:;' onclick="stopJob();">停止</a></li>
			      <li role="separator" class="divider"></li>
			      <li><a href='javascript:;' onclick="runRightNow();">立即执行</a></li>
			   </ul>
			</div>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_showHistory" permissionDes="显示历史">
		  <a id="showHistoryButton" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="显示历史"> 显示历史</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_showCalendar" permissionDes="配置日历">
		  <a id="showCalendarButton" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="配置日历" > 配置日历</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysJob_button_group" permissionDes="组任务查看">
		  <a id="groupButton" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="组任务查看"> 组任务查看</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="sysJob_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>
<table id="sysJobjqGrid"></table>
<div id="sysJobjqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>名称:</th>
				<td colspan="3"><input title="名称" class="form-control input-sm" type="text" name="name" id="name" /></td>
			</tr>
			<tr>
			    <th>任务分组:</th>
				<td>
					 <select title="状态" class="form-control input-sm" id="group" name="group">
				      <option value="">请选择</option>
				     </select>
				</td>
				<th>状态:</th>
				<td>
				  <select title="状态" class="form-control input-sm" id="status" name="status">
				      <option value="">请选择</option>
				      <option value="C">启动中</option>
				      <option value="R">运行中</option>
				      <option value="D">暂停中</option>
				      <option value="S">已暂停</option>
				  </select>
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/quartz/SysJob.js" type="text/javascript"></script> 
<script type="text/javascript">
/**
 * 格式化任务分组
 */
function formatterGroup(cellvalue, options, rowObject){
	var groupName = "";
	if(cellvalue == '<%=Job.DEFAULT_GROUP %>'){
		groupName = "默认组";
	}else if(cellvalue == '<%=Job.DEFAULT_SYSTEM_JOB_GROUP %>'){
		groupName = "系统后台自动任务";
	}
	return groupName;
}
/**
 * 格式化任务类型
 */
function formatterType(cellvalue, options, rowObject){
	var typeName = "";
	if(cellvalue == 'spring'){
		typeName = "SpringBean";
	}else if(cellvalue == 'clazz'){
		typeName = "Java类";
	}else if(cellvalue == 'quartzClazz'){
		typeName = "集成自Job接口的Java类";
	}else if(cellvalue == 'sql'){
		typeName = "Sql语句";
	}else if(cellvalue == 'sp'){
		typeName = "存储过程";
	}else if(cellvalue === 'rest'){
		typeName = "Rest服务";
	}
	return typeName;
}
/**
 * 格式化状态
 */
function formatterStatus(cellvalue, options, rowObject){
	var statusName = "";
	if(cellvalue == 'C'){
		statusName = "启动中";
	}else if(cellvalue == 'R'){
		statusName = "运行中";
	}else if(cellvalue == 'D'){
		statusName = "暂停中";
	}else if(cellvalue == 'S'){
		statusName = "已暂停";
	}
	return statusName;
}
/**
 * 格式化最后一次执行状态
 */
function formatterLastState(cellvalue, options, rowObject){
	var lastStateName = "";
	if(cellvalue == 'S'){
		lastStateName = "成功";
	}else if(cellvalue == 'F'){
		lastStateName = "失败";
	}
	return lastStateName;
}
var sysJob;
$(document).ready(function () {
	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_group" permissionDes="任务分组">
 	  ,{ label: '任务分组', name: 'group', width: 150,formatter:formatterGroup}
 	  </sec:accesscontrollist>
  	  <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_name" permissionDes="名称">
      ,{ label: '名称', name: 'name', width: 150 }
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_type" permissionDes="任务类型">
      ,{ label: '任务类型', name: 'type', width: 150,formatter:formatterType }
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_status" permissionDes="状态">
      ,{ label: '状态', name: 'status', width: 150,formatter:formatterStatus}
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_last_state" permissionDes="最后一次执行状态">
      ,{ label: '最后一次执行状态', name: 'lastState', width: 150,formatter:formatterLastState }
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_program" permissionDes="程序">
      ,{ label: '程序', name: 'program', width: 150 }
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_cron" permissionDes="表达式">
      ,{ label: '表达式', name: 'cron', width: 150 }
      </sec:accesscontrollist>
      <sec:accesscontrollist hasPermission="3" domainObject="sysJob_table_description" permissionDes="描述">
      ,{ label: '描述', name: 'description', width: 150 }
      </sec:accesscontrollist>
	];
	sysJob = new SysJob('sysJobjqGrid', '${url}',
			'searchDialog', 'form', 'keyWord',
			dataGridColModel);
	$.ajax({  
        url: "console/quartz/operation/loadGroups.json",  
        dataType: "json",  
        success: function (data) {  
            $.each(data, function (index, units) {  
                $("#group").append("<option value="+units.name+">" + units.description + "</option>");  
            });  
        },  

        error: function (XMLHttpRequest, textStatus, errorThrown) {  
       	 layer.alert(errorThrown, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn: ['关闭'],
				    title:"提示"
		 });
        }  
    });  
	//添加按钮绑定事件
	$('#sysJob_insert').bind('click', function(){
		sysJob.insert();
	});
	
	/* $('#sysJob_export').bind('click', function(){
		$("#jqGrid").jqGrid("exportToExcel",{
			includeLabels : true,
			includeGroupHeader : true,
			includeFooter: true,
			fileName : "jqGridExportAAA.xlsx",
			maxlength : 40 // maxlength for visible string data 
		})
	}); */
	//编辑按钮绑定事件
	$('#sysJob_modify').bind('click', function(){
		sysJob.modify();
	});
	//删除按钮绑定事件
	$('#sysJob_del').bind('click', function(){  
		sysJob.del();
	});
	//配置日历 
	$('#showCalendarButton').bind('click',function(){
		var confIndex = layer.open({
			type : 2,
			area : [ '100%', '100%' ],
			title : '配置日历',
			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
			maxmin : false, //开启最大化最小化按钮
			content : 'platform/canledarzhuzi/sysjobcalendar/sysJobCalendarController/toSysJobCalendarManage'
		});
		/**
		 * 关闭页面
		 */
		closeCalendarDialog = function() {
			layer.close(confIndex);
		};
	});
	//显示历史
	$("#showHistoryButton").bind('click',function(){
		var selected = $('#sysJobjqGrid').jqGrid('getGridParam', 'selarrrow');
		if(selected.length > 1 || selected.length <= 0){
			layer.alert('请选择一条任务！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
			    title:"提示"
			});
			return false;
		}
		var jobId = selected[0];
		var histIndex = layer.open({
			type : 2,
			area : [ '100%', '100%' ],
			title : '显示历史',
			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
			maxmin : false, //开启最大化最小化按钮
			content : 'sysJobHistoryController/toSysJobHistoryManage?jobId='+jobId
		});
		/**
		 * 关闭页面
		 */
		closeHistoryDialog = function(result) {
			layer.close(histIndex);
		};
	});
	//组任务查看
	$("#groupButton").bind('click',function(){
		sysJob.showGroup();
	});
	//打开高级查询框
	$('#sysJob_searchAll').bind('click', function() {
		sysJob.openSearchForm(this);
	});
});

function closeForm(){
	parent.sysJobCalendarDate.closeDialog("insert");
}
/**
 * 启动定时任务
 */
function startJob(){
	var selected = $('#sysJobjqGrid').jqGrid('getGridParam', 'selarrrow');
	if(selected.length <= 0 || selected.length > 1){
		layer.alert('请先指定一条要开始的任务！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
		    title:"提示"
		});
		return false;
	}
	var id = selected[0];
	var param = {id: id};
	layer.confirm('确认要开始这一任务吗?', {
		icon : 3,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeStartJob',
			data: param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					//$("#datagrid1").datagrid('reload');
					sysJob.reLoad();
					//layer.msg('操作成功！');
                    layer.msg('操作成功！', {icon : 1 ,title: "提示",area: ['400px', '']});
				} else {
					if (r.idError == 'true') {
						layer.alert('必须指定调度的任务编号！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.jobRunning == 'true') {
						layer.alert('当前任务已处于开始状态！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else{
						layer.alert('操作失败！', {
							icon : 2,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}
				}
			}
		});
		layer.close(index);
	});
}

/**
 * 停止定时任务
 */
function stopJob(){
	var selected = $('#sysJobjqGrid').jqGrid('getGridParam', 'selarrrow');
	if(selected.length <= 0 || selected.length > 1){
		layer.alert('请先指定一条要停止的任务！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
		    title:"提示"
		});
		return false;
	}
	var id = selected[0];
	var param = {id: id};
	layer.confirm('确认要停止这一任务吗?', {
		icon : 2,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeStopJob',
			data : param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					sysJob.reLoad();
					layer.msg('操作成功！');
				} else {
					if (r.idError == 'true') {
						layer.alert('必须指定调度的任务编号！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.jobStoped == 'true') {
						layer.alert('当前任务已处于停止状态！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else{
						layer.alert('操作失败！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}
				}
			}
		});
		layer.close(index);
	});
}

/**
 * 立即执行定时任务
 */
function runRightNow(){
	var selected = $('#sysJobjqGrid').jqGrid('getGridParam', 'selarrrow');
	if(selected.length <= 0 || selected.length > 1){
		layer.alert('请先指定一条要立即执行的任务！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
		    title:"提示"
		});
		return false;
	}
	var id = selected[0];
	var param = {id: id};
	layer.confirm('确认要立即执行这一任务吗?', {
		icon : 3,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeRunRightNow',
			data : param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					//$("#datagrid1").datagrid('reload');
					sysJob.reLoad();
					layer.msg('操作成功！');
				} else {
					if (r.idError == 'true') {
						layer.alert('必须指定调度的任务编号！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.JobExecutorIsNull == 'true') {
						layer.alert('必须配置JobExecutor！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else{
						layer.alert('操作失败！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}
				}
			}
		});
		layer.close(index);
	});
}
</script>
</html>