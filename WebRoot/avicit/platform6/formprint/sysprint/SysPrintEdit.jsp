<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "sysprint/sysPrintController/operation/Edit/id" -->
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <%--<input type="hidden" name="version" value="<c:out  value='${sysPrintDTO.version}'/>"/>--%>
        <input type="hidden" name="id" value="<c:out  value='${sysPrint.id}'/>"/>
        <input type="hidden" id="resourceId" name="resourceId" value="<c:out  value='${sysPrint.resourceId}'/>"/>
        <input type="hidden" id="printType" name="printType" value="<c:out  value='${sysPrint.printType}'/>"/>
        <input type="hidden" id="sysApplicationId" name="sysApplicationId" value="<c:out  value='${sysPrint.sysApplicationId}'/>"/>
        <table class="form_commonTable">
            <tr>

                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="printTempName">模板名称：</label>
                </th>
                <td width="35%">
                    <input title="模板名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="printTempName" id="printTempName" value="<c:out  value='${sysPrint.printTempName}'/>"/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="printTempCode">模板编码：</label>
                </th>
                <td width="35%">
                    <input title="模板编码" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="printTempCode" id="printTempCode" value="<c:out  value='${sysPrint.printTempCode}'/>"/>
                </td>

            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="remark">描述：</label>
                </th>
                <td colspan="3" width="85%">
                    <textarea title="描述" rows="3" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                              name="remark" id="remark">${sysPrint.remark}</textarea>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="resourceId">存储模型ID（用于关联非电子表单）或者电子表单ID:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="resourceId" id="resourceId"--%>
                           <%--value="<c:out  value='${sysPrint.resourceId}'/>"/>--%>
                <%--</td>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="sysApplicationId">应用ID:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="sysApplicationId" id="sysApplicationId"--%>
                           <%--value="<c:out  value='${sysPrint.sysApplicationId}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="printTempName">打印模板名称:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="printTempName" id="printTempName"--%>
                           <%--value="<c:out  value='${sysPrint.printTempName}'/>"/>--%>
                <%--</td>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="printTempCode">打印模板编号:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="printTempCode" id="printTempCode"--%>
                           <%--value="<c:out  value='${sysPrint.printTempCode}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="remark">描述:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="remark" id="remark"--%>
                           <%--value="<c:out  value='${sysPrint.remark}'/>"/>--%>
                <%--</td>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="formContent">打印模板设计器源码:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="formContent" id="formContent"--%>
                           <%--value="<c:out  value='${sysPrint.formContent}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="tableJs">外部引用js:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="tableJs" id="tableJs"--%>
                           <%--value="<c:out  value='${sysPrint.tableJs}'/>"/>--%>
                <%--</td>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="tableCss">外部引用css:</label></th>--%>
                <%--<td width="39%">--%>
                    <%--<input class="form-control input-sm" type="text" name="tableCss" id="tableCss"--%>
                           <%--value="<c:out  value='${sysPrint.tableCss}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>

        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="sysPrint_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="sysPrint_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    function closeForm() {
        parent.sysPrint.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#sysPrint_saveForm').addClass('disabled').unbind("click");
        parent.sysPrint.save($('#form'), "eidt");
    }

    $(document).ready(function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.sysPrint.formValidate($('#form'));
        //保存按钮绑定事件
        $('#sysPrint_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#sysPrint_closeForm').bind('click', function () {
            closeForm();
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>