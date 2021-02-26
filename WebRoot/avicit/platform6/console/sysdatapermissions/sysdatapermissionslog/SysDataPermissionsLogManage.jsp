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

<meta http-equiv="X-UA-Compatible" content="chrome=1">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsLog_button_delete" permissionDes="删除">
			<a id="sysDataPermissionsLog_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsLog_button_clear" permissionDes="清空">
			<a id="sysDataPermissionsLog_clear" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="清空"><i class="fa fa-bitbucket"></i> 清空</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsLog_button_refresh" permissionDes="刷新">
			<a id="sysDataPermissionsLog_refresh" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
		</sec:accesscontrollist>
		<div style="float: right;width: 330px;">    
			<div style="width: 160px;height: 30px;float: left;">
				<div style="background-color: rgb(253, 233, 92);width: 50px;height: 29px;float: left;"></div><div style="padding-top: 6px;float: right;">SQL执行时间 >= 1s</div>
			</div>
			<div style="width: 160px;height: 30px;float: right;">
				<div style="background-color: rgb(239, 88, 88);width: 50px;height: 29px;float: left;"></div><div style="padding-top: 6px;float: right;">SQL执行时出现异常</div>
			</div>
		</div>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="sysDataPermissionsLog_keyWord" id="sysDataPermissionsLog_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="sysDataPermissionsLog_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="sysDataPermissionsLog_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="sysDataPermissionsLogjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			<tr>
				<th width="18%">执行人:</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="executor" name="executor">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="executorAlias" name="executorAlias">
						<span class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="18%">mapper名称:</th>
				<td width="30%"><input title="mapper名称"
					class="form-control input-sm" type="text" name="mapperName"
					id="mapperName" /></td>
			</tr>
			<tr>
				<th width="18%">执行时间(从):</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control time-picker" type="text"
							name="executionTimeBegin" id="executionTimeBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			
				<th width="18%">执行时间(至):</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control time-picker" type="text"
							name="executionTimeEnd" id="executionTimeEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="18%">SQL耗时时间(ms) >= </th>
				<td width="30%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text"
							   name="timeConsuming" id="timeConsuming" data-min="0"
							   data-max="<%=Math.pow(10, 12) - Math.pow(10, -0)%>"
							   data-step="1" data-precision="0"> <span
							   class="input-group-addon"> <a href="javascript:;"
							class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th width="18%">是否产生异常:</th>
				<td width="30%">
					<select id="exceptionMsg" name="exceptionMsg" class="form-control input-sm" title="是否产生异常">
						<option value="" selected="selected"></option>
						<option value="1">否</option>
						<option value="2">是</option>
					</select>
				</td>
			</tr>
		</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionslog/js/SysDataPermissionsLog.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script type="text/javascript">
	var sysDataPermissionsLog;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysDataPermissionsLog.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysDataPermissionsLog.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	function formatErrorValue(cellvalue, options, rowObject) {
		if(null != cellvalue && cellvalue != ""){
			return '<a href="javascript:void(0);" onclick="sysDataPermissionsLog.errorDetail(\''+ rowObject.id + '\');">' + cellvalue + '</a>';
		} else {
			return "";
		}
	}
	function formatColumnTime(cellvalue, options, rowObject) {
		return new Date(cellvalue).format("yyyy-MM-dd hh:mm")
	}

	$(document).ready(function() {
		var dataGridColModel = [ {
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '执行人',
			name : 'executor',
			width : 100,
			sortable : false
		}, {
			label : '执行时间',
			name : 'executionTime',
			width : 80,
			sortable : false,
			formatter : formatColumnTime
		}, {
			label : 'mapper名称',
			name : 'mapperName',
			width : 80,
			sortable : false
		}, {
			label : '执行方法',
			name : 'method',
			width : 80,
			sortable : false
		},{
			label : '表名/弹出页标识',
			name : 'tableName',
			width : 80,
			sortable : false
		}, {
			label : '数据权限控制前SQL',
			name : 'beforeSql',
			width : 100,
			sortable : false,
			formatter : formatValue
		}, {
			label : '数据权限控制后SQL',
			name : 'afterSql',
			width : 100,
			sortable : false,
			formatter : formatValue
		}, {
			label : '控制后SQL执行耗时时间（ms）',
			name : 'timeConsuming',
			width : 130
		},{
			label : '异常信息',
			name : 'exceptionMsg',
			width : 100,
			sortable : false,
			formatter : formatErrorValue
		}];
		var searchNames = new Array();
		var searchTips = new Array();
		searchNames.push("mapperName");
		searchTips.push("mapper名称");
		
		var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
		$('#sysDataPermissionsLog_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
		sysDataPermissionsLog = new SysDataPermissionsLog('sysDataPermissionsLogjqGrid', '${url}', 'searchDialog', 'form', 'sysDataPermissionsLog_keyWord', searchNames, dataGridColModel);
		
		//删除按钮绑定事件
		$('#sysDataPermissionsLog_del').bind('click', function() {
			sysDataPermissionsLog.del();
		});
		//查询按钮绑定事件
		$('#sysDataPermissionsLog_searchPart').bind('click', function() {
			sysDataPermissionsLog.searchByKeyWord();
		});
		//打开高级查询框
		$('#sysDataPermissionsLog_searchAll').bind('click', function() {
			sysDataPermissionsLog.openSearchForm(this);
		});
		//清空
		$('#sysDataPermissionsLog_clear').bind('click', function() {
			sysDataPermissionsLog.clear();
		});
		//刷新
		$('#sysDataPermissionsLog_refresh').bind('click', function() {
			sysDataPermissionsLog.reLoad();
		});
		// 选人
		$('#executorAlias').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'executor',
				textFiled : 'executorAlias'
			});
			this.blur();
			nullInput(e);
		});
	});
</script>

<script type="text/javascript">
	function isIE() {
	 	if (!!window.ActiveXObject || "ActiveXObject" in window){
			return true;
	 	} else {
			return false;
	 	}
	}
	if(isIE()){
		$("body").width("99%");
	}
</script>
</html>