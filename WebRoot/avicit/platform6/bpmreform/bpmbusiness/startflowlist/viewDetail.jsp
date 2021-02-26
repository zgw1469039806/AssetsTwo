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
    <title>流程模板详情</title>
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
        <h4>${result.name}</h4>
    </div>
    <div class="process_inner">
        <div class="process_details clearfix">
            <div class="process_details_left">
                <div class="process_icon ${color}">
                    <i class="icon iconfont icon-share"></i>
                </div>
            </div>
            <div class="process_details_right">
                <p>模板名称：<span>${result.name}</span></p>
                <p>模板版本：<span>V${result.version}</span></p>
                <p>模板类型：<span><c:choose><c:when
                        test="${result.isUflow != null && result.isUflow == '2' }">自由流程</c:when><c:otherwise>固定流程</c:otherwise></c:choose></span>
                </p>
                <p>模板管理：<span>${(result.owner != null && result.owner != "") ? result.owner : "暂无"}</span></p>
                <p>发布时间：<span>${result.deploymentTimeString}</span></p>
                <p>模板描述：<span>${(result.desc != null && result.desc != "") ? result.desc : "暂无"}</span></p>
                <div class="process_btn" onclick="flowUtils.openOnDialog('platform/bpm/business/start?defineId=${result.dbid }','${result.name }')">
                    <a class="initiate">
                        <i class="icon iconfont icon-faqi"></i><span>发起流程</span>
                    </a>
                </div>
                <div class="process_btn" onclick="doFav('${result.dbid }', undefined, this, setStarIcon)">
                    <a class="initiate">
                        <i class="icon iconfont ${star == "false" ? "icon-star" : "icon-star-fill"}"></i><span>${star == "false" ? "添加收藏" : "取消收藏"}</span>
                    </a>
                </div>
            </div>
        </div>
        <div class="process_pagt_list_box">
            <div class="process_img_tit">流程图示</div>
            <div class="base" id="graph"></div>
        </div>
        <div class="process_pagt_list_box" style="display: none">
            <div class="process_img_tit">使用说明</div>
            <div class="explanation">
                <p>
                </p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/js/common.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/js/viewDetail.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/picture/FlowPic.js"></script>
<script type="text/javascript">
    var deploymentId = "${result.deploymentId}";
</script>
</body>

</html>
