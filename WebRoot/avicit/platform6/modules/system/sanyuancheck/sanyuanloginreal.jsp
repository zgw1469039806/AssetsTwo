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
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <style>
        .labels{
            width:90px;
            text-align: right;
        }
        td{
            padding:5px 0px;
        }
        table{
            width:95%;
            margin: auto;
        }
    </style>
</head>
<body>

<form id="sanyuanlogin" name="sanyuanlogin"  class="form-horizontal">
    <div >
        <p class="lead text-center">该模块受到安全保护，需要系统管理员，安全管理员，安全审计员同时登录!</p>
    </div>
    <table >
        <tr>
            <td class="labels">
                <label for="systemlogin" class=" control-label">系统管理员：</label>
            </td>
            <td class="inputs">
                <input type="text" class="form-control" name="systemlogin" id="systemlogin" >
            </td>
        </tr>
        <tr>
            <td class="labels">
                <label for="systempassword" class=" control-label">密码：</label>
            </td>
            <td class="inputs">
                <input type="password" class="form-control" name="systempassword" id="systempassword" >
            </td>
        </tr>

        <tr>
            <td class="labels">
                <label  for="safemanager"  class="control-label">安全管理员：</label>
            </td>
            <td class="inputs">
                <input type="text" class="form-control" name="safemanager" id="safemanager" >
            </td>
        </tr>
        <tr>
            <td class="labels">
                <label for="safemanagerpassword" class="control-label">密码：</label>
            </td>
            <td class="inputs">
                <input type="password" class="form-control"  name="safemanagerpassword" id="safemanagerpassword" >
            </td>
        </tr>

        <tr>
            <td class="labels">
                <label for="safesheji" class="control-label">安全审计员：</label>
            </td>
            <td class="inputs">
                <input type="text" class="form-control" name="safesheji" id="safesheji">
            </td>
        </tr>

        <tr>
            <td class="labels">
                <label for="safeshejipassword" class="control-label">密码：</label>
            </td>
            <td class="inputs">
                <input type="password" class="form-control" name="safeshejipassword" id="safeshejipassword">
            </td>
        </tr>

        <tr>
            <td class="labels">
                <label for="ofcause" class=" control-label">原因：</label>
            </td>
            <td class="inputs">
                <textarea rows="5" id="ofcause" class="form-control" ></textarea>
            </td>
        </tr>
    </table>

</form>


</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</html>
