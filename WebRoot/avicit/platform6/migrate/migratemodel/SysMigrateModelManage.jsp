<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "train/form/sysmigratemodel/sysMigrateModelController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="avicit/platform6/migrate/migratemodel/css/style.css">
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true" style="width:273px; border-color: #eee;">
        <form id='modelForm'>
            <div class="add-model-right" style="text-align: left;">
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateModel_button_add" permissionDes="添加">
                    <a id="addModel" href="javascript:void(0)" class="btn btn-sm form-tool-btn typeb" style="margin: 0px;padding: 0px" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
                </sec:accesscontrollist>
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateModel_button_edit" permissionDes="编辑">
                    <a id="editModel" href="javascript:void(0)" class="btn form-tool-btn btn-sm" style="margin: 0px;padding: 0px" role="button" title="编辑"><i class="icon icon-edit"></i> 编辑</a>
                </sec:accesscontrollist>
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateModel_button_delete" permissionDes="删除">
                    <a id="delModel" href="javascript:void(0)" class="btn form-tool-btn btn-sm" style="margin: 0px;padding: 0px" role="button" title="删除"><i class="icon icon-delete"> 删除</i></a>
                </sec:accesscontrollist>
            </div>
            <!-- 模块列表 -->
            <div style="overflow-x:hidden;">
                <ul id="modelList" class="model-list">
                </ul>
            </div>
        </form>
	</div>
	<div data-options="region:'center',split:true,border:false">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',split:true,border:false">
                <form id='modelDetailForm'>
                    <table class="table table-striped form_commonTable">
                        <thead>
                            <tr style="height: 42px;">
                                <th width="5%" style="white-space:nowrap;">No.</th>
                                <th width="33%" style="white-space:nowrap;"><i class="required">*</i>SQL脚本</th>
                                <th width="25%" style="white-space:nowrap;"><i class="required">*</i>时间字段</th>
                                <th width="12%" style="white-space:nowrap;"><i class="required">*</i>执行类型</th>
                                <th width="15%" style="white-space:nowrap;">操作</th>
                            </tr>
                        </thead>
                        <tbody id="modelDetailTableBody">
                        <tbody>
                    </table>
                </form>
            </div>
            <div data-options="region:'south',border:false" style="height: 60px; border-top: 5px solid #eee">
                <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
                    <table class="tableForm" style="border: 0; cellspacing: 1; width: 97%; margin:0px 20px">
                        <tr>
                            <td style="height: 38px; width:20%;white-space:nowrap;" align="right">
                                <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysMigrateModel_saveForm">保存</a>
                                <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysMigrateModel_closeForm">返回</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/></jsp:include>
	<style type="text/css">

	</style>
    <script src="avicit/platform6/migrate/migratemodel/js/SysMigrateModel.js" type="text/javascript"></script>
	<script type="text/javascript">
        var sysMigrateModel

		$(document).ready(function () {
            sysMigrateModel = new SysMigrateModel("modelList","modelDetailForm","modelDetailTableBody");

                //保存按钮绑定事件
            $('#sysMigrateModel_saveForm').on('click', function(){
                sysMigrateModel.saveData();
            });

			//返回按钮绑定事件
			$('#sysMigrateModel_closeForm').on('click', function(){
                sysMigrateModel.closeDialog(window.name);
			});

            //添加模块按钮绑定事件
            $('#addModel').on('click', function(){
                sysMigrateModel.addModel($('#modelList'));
            });

            //修改模块按钮绑定事件
            $('#editModel').on('click', function(){
                sysMigrateModel.editModel($('#modelList'));
            });

            //删除模块按钮绑定事件
            $('#delModel').on('click', function(){
                sysMigrateModel.delModel($('#modelList'));
            });

		});
	</script>
</body>
</html>