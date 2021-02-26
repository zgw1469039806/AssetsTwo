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
    <!-- ControllerPath = "assets/device/documentpackage/documentPackageController/operation/Edit/id" -->
    <title>详细</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${documentPackageDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${documentPackageDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdBy">创建人:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdBy" id="createdBy" readonly="readonly"
                           value="<c:out  value='${documentPackageDTO.createdBy}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDept">创建部门:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByDept" id="createdByDept"
                           readonly="readonly" value="<c:out  value='${documentPackageDTO.createdByDept}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="creationDate">创建时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="creationDate" id="creationDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${documentPackageDTO.creationDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="packageName">文档包名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="packageName" id="packageName"
                           readonly="readonly" value="<c:out  value='${documentPackageDTO.packageName}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="packageDescribe">文档包描述:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="packageDescribe" id="packageDescribe"
                           readonly="readonly" value="<c:out  value='${documentPackageDTO.packageDescribe}'/>"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    document.ready = function () {
        parent.documentPackage.formValidate($('#form'));
    };
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });
</script>
</body>
</html>