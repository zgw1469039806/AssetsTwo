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
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div id="panelcenter" data-options="region:'center',height:fixheight(.5),onResize:function(a){$('#datagridGroup').setGridWidth(a);$('#datagridGroup').setGridHeight(getJgridTableHeight($('#panelcenter')));$(window).trigger('resize');}" style="overflow-x:hidden;overflow-y:hidden; " border="false">
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobHistory_button_add"
				permissionDes="返回">
				<a id="sysJobGroup_add" href="javascript:void(0)" onclick="startGroupJob();"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="返回"><i class="glyphicon glyphicon-play"></i>开始</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobHistory_button_delete"
				permissionDes="清除数据">
				<a id="sysJobGroup_del" href="javascript:void(0)" onclick="stopGroupJob();"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="清除数据"><i class="glyphicon glyphicon-stop"></i> 停止</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysJobHistory_button_do"
				permissionDes="立即执行">
				<a id="sysJobGroup_del" href="javascript:void(0)" onclick="runRightNowGroup();"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="立即执行"><i class="glyphicon glyphicon-play-circle"></i> 立即执行</a>
			</sec:accesscontrollist>
		</div>
	</div>
	<table id="datagridGroup"></table>
</div>
<div id="panelsouth" data-options="region:'south',split:true,height:fixheight(.5),onResize:function(a){$('#sysjob_sub').setGridWidth(a);$('#sysjob_sub').setGridHeight(getJgridTableHeight($('#panelsouth')));$(window).trigger('resize');}">
	<table id="sysjob_sub"></table>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var BeanNameStr; 
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
 * 格式化任务类型
 */
function formatterType(value, row, index){
	var typeName = "";
	if(value == 'spring'){
		typeName = "SpringBean";
	}else if(value == 'clazz'){
		typeName = "Java类";
	}else if(value == 'quartzClazz'){
		typeName = "集成自Job接口的Java类";
	}else if(value == 'sql'){
		typeName = "Sql语句";
	}else if(value == 'sp'){
		typeName = "存储过程";
	}
	return typeName;
}

/**
 * 启动定时任务
 */
function startGroupJob(){
	if(BeanNameStr == null || BeanNameStr =='undefined'){
		layer.alert('请先选择一个任务分组！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	var param = {group: BeanNameStr};
	var jobRows =  $('#sysjob_sub').jqGrid('getRowData');
	if(jobRows.length == 0){
		layer.alert('此任务分组下无任务，无法执行！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	layer.confirm('确认启动该组中尚未启动的所有任务?', {
		icon : 2,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeStartGroupJob',
			data: param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					$("#sysjob_sub").jqGrid('setGridParam', {
						datatype : 'json',
						postData : {}
					}).trigger("reloadGrid");
					parent.sysJob.reLoad();
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
					}else if (r.jobsAllRunning == 'true') {
						layer.alert('当前组中的所有任务都处于运行状态！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.jobsEmpty == 'true') {
						layer.alert('当前组中的没有任何任务！', {
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
 * 停止定时任务
 */
function stopGroupJob(){
	if(BeanNameStr == null || BeanNameStr =='undefined'){
		layer.alert('请先选择一个任务分组！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	var param = {group: BeanNameStr};
	var jobRows =  $('#sysjob_sub').jqGrid('getRowData');
	if(jobRows.length == 0){
		layer.alert('此任务分组下无任务，无法执行！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	layer.confirm('确认停止该组中的所有任务?', {
		icon : 2,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeStopGroupJob',
			data: param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					$("#sysjob_sub").jqGrid('setGridParam', {
						datatype : 'json',
						postData : {}
					}).trigger("reloadGrid");
					parent.sysJob.reLoad();
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
					}else if (r.jobsAllStoped == 'true') {
						layer.alert('当前组中的所有任务都处于停止状态！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.jobsEmpty == 'true') {
						layer.alert('当前组中的没有任何任务！', {
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
function runRightNowGroup(){
	if(BeanNameStr == null || BeanNameStr =='undefined'){
		layer.alert('请先选择一个任务分组！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	var param = {group: BeanNameStr};
	var jobRows =  $('#sysjob_sub').jqGrid('getRowData');
	if(jobRows.length == 0){
		layer.alert('此任务分组下无任务，无法执行！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn: ['关闭'],
		    title:"提示"
		});
		return false;
	}
	layer.confirm('确定要立即执行该组中的所有任务?', {
		icon : 2,
		title : "请确认：",
		area : [ '400px', '' ]
	}, function(index) {
		$.ajax({
			url : 'platform/jobSchedulerController/executeImmediate',
			data: param,
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == 'success') {
					$("#sysjob_sub").jqGrid('setGridParam', {
						datatype : 'json',
						postData : {}
					}).trigger("reloadGrid");
					parent.sysJob.reLoad();
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
					}else if (r.JobExecutorIsNull == 'true') {
						layer.alert('当前组中的所有任务都处于运行状态！', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							btn: ['关闭'],
						    title:"提示"
						});
					}else if (r.jobsEmpty == 'true') {
						layer.alert('当前组中的没有任何任务！', {
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
    
	$(document).ready(function() {
		var datagridGroupColModel = [{
			label : '组',
			name : 'name',
			width : 150,
			hidden:true
		},{
			label : '描述',
			name : 'description',
			width : 150
		}];
		var datagridSysjob_subColModel = [ {
			label : '名称',
			name : 'name',
			width : 150
		},{
			label : '类型',
			name : 'type',
			width : 150,
			formatter:formatterType
		},{
			label : '程序',
			name : 'program',
			width : 200
		},{
			label : '表达式',
			name : 'cron',
			width : 150
		},{
			label : '状态',
			name : 'status',
			width : 150,
			formatter:formatterStatus
		}];
		$("#datagridGroup").jqGrid({
			url : 'console/quartz/operation/loadGroups.json',
			mtype : 'POST',
			datatype : "json",
			colModel : datagridGroupColModel,
			height : $(window).height()- 120 - 17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
			scrollOffset : 10,
			rowNum : 20,
			rowList : [ 200, 100, 50, 30, 20, 10 ],
			altRows : true,
			userDataOnFooter : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiboxonly : true,
			rownumbers:true,
			autowidth : true,
			shrinkToFit : true,
			responsive : true,
			onSelectRow : function(rowid) {
				var data = $(this).jqGrid('getRowData', rowid);
				BeanNameStr= data.name;
				$("#sysjob_sub").jqGrid('setGridParam', {
					datatype : 'json',
					postData : {group:data.name}
				}).trigger("reloadGrid");
			}
		});
		$("#sysjob_sub").jqGrid({
			url : 'console/quartz/operation/loadJobsByGroup.json',
			postData : {
				pid :BeanNameStr
			},
			mtype : 'POST',
			datatype : "json",
			colModel : datagridSysjob_subColModel,
			height : $(window).height()-120-17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
			scrollOffset : 10, //设置垂直滚动条宽度
			rowNum : 20,
			rowList : [ 200, 100, 50, 30, 20, 10 ],
			altRows : true,
			rownumbers:true,
			autowidth : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true, //
			shrinkToFit : true,
			responsive : true//开启自适应
		});
	});
</script>
</html>
