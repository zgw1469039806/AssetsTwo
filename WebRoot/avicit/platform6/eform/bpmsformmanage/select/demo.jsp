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
    <title>选择已发布流程表单demo</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
<h1>我是区域1</h1>
<div id="area1">
    <input type="hidden" id="formId" name="formId">
    <input type="text" id="formName" name="formName" class="form-control" readonly>
</div>
<p>
<h1>我是区域2</h1>
<div id="area2">
    <input type="hidden" id="formId" name="formId">
    <input type="text" id="formName" name="formName" class="form-control" readonly>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
<script type="text/javascript">
    var selectPublishEform1 = new SelectPublishEform("formId", "formName", "area1", "Y", "bpm");
    selectPublishEform1.init(function (data) {
        alert(data.id + "," + data.name);
    });

    var selectPublishEform2 = new SelectPublishEform("formId", "formName", "area2", "Y", "eform");
    selectPublishEform2.init();
</script>
</body>
</html>
