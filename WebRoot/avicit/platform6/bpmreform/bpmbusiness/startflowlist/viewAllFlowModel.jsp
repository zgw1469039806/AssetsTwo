<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--流程权限-发起子流程--%>
    <title>发起子流程</title>
    <link rel="stylesheet" type="text/css"
          href="avicit/platform6/bpmreform/bpmbusiness/startflowlist/css/process_style.css">
    <link rel="stylesheet" type="text/css"
          href="avicit/platform6/bpmreform/bpmbusiness/startflowlist/iconfont/iconfont.css">
    <script type="text/javascript">
        var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
</head>
<body>
<div class="process_body">
    <div class="process_inner" style="top: 0px;">
        <div class="all_box on">
            <c:forEach items="${result}" var="catalog">
                <div class="process_list_box">
                    <div class="process_list_title">
                        <i class="pr_tit_left "></i>
                        <h4>${catalog.catalogName }</h4>
                        <i class="icon iconfont icon-jiantou-xia" title="展开/收起"></i>
                    </div>
                    <ul class="clearfix">
                        <c:forEach items="${catalog.children}" var="processInfo" varStatus="status">
                            <li class="process_list" id="process_${processInfo.pdId }" _text="${processInfo.pdName }">
                                <div class="pre_box clearfix">
                                    <div class="pre_left">
                                        <i class="icon iconfont icon-share ${colorArr[status.index % colorArr.size()]}"></i>
                                        <a class="pr_tit_txt"
                                                <c:choose>
                                                    <c:when test="${showVersion == null || showVersion == undefined || showVersion == '1'}">
                                                        title="${processInfo.pdName } V${processInfo.pdVersion }(${processInfo.flowTypeName })"
                                                    </c:when>
                                                    <c:otherwise>
                                                        title="${processInfo.pdName }"
                                                    </c:otherwise>
                                                </c:choose>)
                                        >${processInfo.pdName }
                                            <c:if test="${showVersion == null || showVersion == undefined || showVersion == '1'}">
                                                <span class="pr_version">V${processInfo.pdVersion }</span>
                                                <span class="pr_type">
                                                    (${processInfo.flowTypeName })
                                                </span>
                                            </c:if>
                                        </a>
                                    </div>
                                    <div class="pre_right">
                                        <i class="icon iconfont icon-faqi" title="发起流程"
                                           onclick="clickFlowModel('${processInfo.deploymentId }')"></i>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/js/common.js"></script>
<script type="text/javascript">
    function clickFlowModel(deploymentId) {
        parent._bpm_BpmStartsubflow.executeUserInfo(deploymentId);
    }
</script>
</body>

</html>
