<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
        <input type="hidden" id="id" name="id" value="${viewInfo.id}">
        <input type="hidden" id="eformComponentId" name="eformComponentId" value="${viewInfo.eformComponentId}">

<table class="form_commonTable">
                <tr>
                    <th width="15%" style="word-break: break-all; word-warp: break-word;">
                        <label for="viewName">视图名称：</label>
                    </th>
                    <td width="35%">
                        <input class="form-control input-sm" value="${viewInfo.viewName}" type="text" name="viewName" id="viewName" title="视图名称" />
                    </td>
                    <th width="15%" style="word-break: break-all; word-warp: break-word;">
                        <label for="viewCode">编码：</label>
                    </th>
                    <td width="35%">
                        <input title="编码" class="form-control input-sm" value="${viewInfo.viewCode}" type="text" style="width: 99%;" type="text" name="viewCode" id="viewCode" />
                    </td>
                </tr>
                <tr>
                    <th width="15%" style="word-break: break-all; word-warp: break-word;">
                        <label for="viewStyle">样式：</label>
                    </th>
                    <td width="35%">
                        <select id="viewStyle" name="viewStyle" class="form-control">
                            <option value="easyui" <c:if test="${viewInfo.viewStyle == 'easyui'}">selected</c:if>>EasyUI</option>
                            <option value="bootstrap" <c:if test="${viewInfo.viewStyle == 'bootstrap'}">selected</c:if>>Bootstrap</option>
                        </select>
                    </td>
                    <th width="15%" style="word-break: break-all; word-warp: break-word;">
                        <label for="orderBy">排序：</label>
                    </th>
                    <td width="35%">
                        <input class="form-control input-sm" value="${viewInfo.orderBy}" type="text" name="orderBy" id="orderBy" title="排序" />
                    </td>
                </tr>
                <tr>
                    <th width="15%" style="word-break: break-all; word-warp: break-word;">
                        <label for="viewDesc">描述：</label>
                    </th>
                    <td colspan="3">
                        <textarea class="form-control input-sm" rows="3" name="viewDesc" id="viewDesc" title="描述">${viewInfo.viewDesc}</textarea>
                    </td>
                </tr>
            </table>
       
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
        $.validator.addMethod("integer", function (value, element) {
            var tel = /^-?\d+$/g;  //正、负 整数 + 0
            return this.optional(element) || (tel.test(value));
        }, "请输入整数");
        $.validator.addMethod("codeFormat", function (value, element) {
            var tel = /^[a-zA-Z0-9_]{1,}$/;
            return this.optional(element) || (tel.test(value));
        }, "编码格式只能是字母、数字、下划线的组合");

        parent.eformFormView.formValidate($('#editForm'));
        $('#saveForm').bind('click', function () {
            parent.eformFormView.subEdit($("#editForm"),"${viewInfo.viewCode}");
        });
        $('#closeForm').bind('click', function () {
            parent.eformFormView.closeDialog("edit");
        });
    };
</script>
</body>
</html>
