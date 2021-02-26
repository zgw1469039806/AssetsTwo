<%--
  Created by IntelliJ IDEA.
  User: xb
  Date: 2017/5/25
  Time: 9:50
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common";
%>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择数据源demo</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<div>
	<td>输入：</td>
    <input type="hidden" id="formId" name="formId">
    <input type="text" id="formName" name="formName" class="form-control" readonly>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
<script type="text/javascript">
    var selectCreatedDbTable = new SelectCreatedDbTable("formId", "formName");
    selectCreatedDbTable.init();
</script>
</body>
</html>
