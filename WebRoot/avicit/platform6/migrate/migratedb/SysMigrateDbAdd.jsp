<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "train/form/sysmigratedb/sysMigrateDbController/operation/Add/null" -->
<title>添加数据库</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<style type="text/css">
		.sysdatapermissionTips1,.sysdatapermissionTips2,.sysdatapermissionTips3,.sysdatapermissionTips4,.sysdatapermissionTips5,.sysdatapermissionTips6{
			float: left;
			width: 16px;
			height: 16px;
			background-image: url(avicit/platform6/console/sysdatapermissions/plugins/img/tips.png);
			margin-right: 3px;
			margin-top: 1px;
		}
	</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' style="margin:0px 15%;">
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
					<th width="20%" style="white-space:nowrap;"><label for="dbType">数据库类型</label></th>
					<td width="80%">
						<select class="form-control input-sm" id="dbType" name="dbType" title="数据库类型" data-placement="right">
							<option value="ORACLE">ORACLE</option>
							<option value="MYSQL">MYSQL</option>
							<option value="SQLSERVER">SQLSERVER</option>
							<option value="DM DBMS">DM DBMS</option>
							<option value="KingbaseES">KingbaseES</option>
							<option value="OSCAR">OSCAR</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="15%" style="word-break: break-all; word-warp: break-word;">
						<%--<label for="dbName"><div class="sysdatapermissionTips5"></div>数据库名称</label>--%>
						<label for="dbName"><div class="sysdatapermissionTips6"></div>数据库名</label>
					</th>
					<td width="80%">
						<input class="form-control input-sm" type="text" name="dbName" id="dbName" title="数据库名称" data-placement="right"/>
					</td>
				</tr>

				<tr>
					<th width="20%" style="white-space:nowrap;">
                        <label for="dbIp">数据库地址</label>
					</th>
					<td width="80%">
						<input class="form-control input-sm" type="text" name="dbIp" id="dbIp" title="数据库地址" data-placement="right"/>
					</td>
				</tr>
				<tr>
					<th width="20%" style="white-space:nowrap;">
						<label for="dbPort">数据库端口</label>
					</th>
					<td width="80%">
						<input class="form-control input-sm" type="text" name="dbPort" id="dbPort" title="数据库端口" data-placement="right"/>
					</td>
				</tr>
				<tr>
					<th width="20%" style="white-space:nowrap;">
						<label for="dbUser">用户名</label>
					</th>
					<td width="80%">
						<input class="form-control input-sm" type="text" name="dbUser" id="dbUser" title="用户名" data-placement="right"/>
					</td>
				</tr>
				<tr>
					<th width="20%" style="white-space:nowrap;">
						<label for="dbPass">密码</label>
					</th>
					<td width="80%">
						<input class="form-control input-sm" type="password" name="dbPass" id="dbPass" title="密码" data-placement="right" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<th width="20%" style="white-space:nowrap;">
						<label for="dbUsage">数据库用途</label>
					</th>
					<td width="80%">
						<label class="radio-inline">
							<input class="form-control" type="radio" name="dbUsage" value="1" id="dbUsageTargetDb" title="目标数据库" checked>目标数据库
						</label>
						<label class="radio-inline">
							<input class="form-control" type="radio" name="dbUsage" value="2" id="dbUsageSourceDb" title="源数据库">源数据库
						</label>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 50px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="height: 50px;">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 97%; margin:0px 20px">
				<tr>
					<td style="height: 38px; width:20%;white-space:nowrap;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="连接测试" id="SysMigrateDb_testConnect">连接测试</a>
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="保存" id="SysMigrateDb_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="SysMigrateDb_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MethodCommon.js?v=<%=System.currentTimeMillis()%>"></script>
	<style type="text/css">
		.form_commonTable td{
			padding: 10px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function () {
            // IP地址验证
            jQuery.validator.addMethod("ip", function(value, element) {
                return this.optional(element) || /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/.test(value);
            }, "请填写正确的IP地址。");

            // 数据库名称验证,如果是达梦数据库，则不需要数据库名称
            jQuery.validator.addMethod("dbName", function(value, element) {
                return this.optional(element) || /^[a-zA-Z0-9_#\$-]+$/.test(value);
            }, "请输入英文，数字或'_'，'#'，'$'");

            parent.sysMigrateDb.formValidate($("#form"));

            //测试按钮绑定事件
            $('#SysMigrateDb_testConnect').on('click', function(){
                var isValidate = $("#form").validate();
                if (!isValidate.checkForm()) {
                    isValidate.showErrors();
                    return false;
                }
                parent.sysMigrateDb.testDbConnect($("#form"));

            });

            //保存按钮绑定事件
            $('#SysMigrateDb_saveForm').on('click', function(){
                var isValidate = $("#form").validate();
                if (!isValidate.checkForm()) {
                    isValidate.showErrors();
                    return false;
                }

                if(!parent.sysMigrateDb.validateDBSource($("#form")) && !parent.sysMigrateDb.validateDB($("#form"))) {
                    parent.sysMigrateDb.save($("#form"), window.name);
                }

            });

            //返回按钮绑定事件
            $('#SysMigrateDb_closeForm').on('click', function(){
                parent.sysMigrateDb.closeDialog(window.name);
            });
		});
	</script>
</body>
</html>