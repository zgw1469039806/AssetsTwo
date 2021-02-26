<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="" name="111"/>
</jsp:include>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="" name="111"/>
</jsp:include>
<script src="avicit/platform6/autocode/js/AutoCode.js" ></script>

<script type="text/javascript">
$.ajax({
	 url:'platform/eform/bpmsClient/layoutpreview.json',
	 data : {tableContent: parent.showContent},
	 type : 'post',
	 dataType : 'json',
	 success : function(r){
		if(r){
			$("#ssdf").html(r.layout);
		}
	 }
});



</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<div id="ssdf"></div>
</div>

<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<script type="text/javascript">
    document.ready = function () {
        $('#closeForm').bind('click', function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });
    };
</script>
</body>
</html>
