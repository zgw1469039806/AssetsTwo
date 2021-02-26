<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
    <title>流程发起</title>
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
    <div class="process_title clearfix">
        <a class="${viewTab == "0" ? "act" : ""}">常用流程</a>
        <a class="${viewTab == "1" ? "act" : ""}">全部流程</a>
        <div class="process_search">
            <input id="search" type="text" placeholder="请输入流程模板名称" />
            <i class="icon iconfont icon-search_" title="搜索"></i>
        </div>
    </div>
    <div class="process_inner">
        <div class="common_box ${viewTab == "0" ? "on" : ""}">
            <div class="common_inner">
                <ul class="clearfix">

                </ul>
                <div class="common_box_blank" style="display: none">
     					<img style="width:100px" src="static/images/platform/eform/no-data.png"/>
               	 		<p>未查询到可用数据</p>
               	 		<%--<a href="####">查看全部</a>--%>
               	 </div>

                <!-- <div class="common_box_blank" style="display: none">
     					<img style="width:100px" src="static/images/platform/eform/no-data.png"/>
               	 		<p>暂无数据</p>
               	 		<a href="####">立即收藏</a>
               	 </div>-->
            </div>
        </div>
        <div class="all_box ${viewTab == "1" ? "on" : ""}">
            <c:forEach items="${result}" var="catalog">
                <div class="process_list_box on">
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
                                        <a href="javascript:void(0)" onclick="openDetail('${processInfo.pdId }')"
                                           class="pr_tit_txt"
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
                                           onclick="flowUtils.openOnDialog('platform/bpm/business/start?defineId=${processInfo.pdId }','${processInfo.pdName }')"></i>
                                        <i class="star icon iconfont icon-star" title="收藏/取消收藏"
                                           onclick="doFav('${processInfo.pdId }', undefined, this)"></i>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
            <div class="common_box_blank" style="display: none">
                <img style="width:100px" src="static/images/platform/eform/no-data.png"/>
                <p>未查询到可用数据</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/js/common.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/js/view.js"></script>
<script type="text/javascript">
    function bpm_view_star_refresh() {
        reloadCard();
    }
</script>
</body>

</html>
