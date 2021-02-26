<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>

<title>模块</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="padding:0px 20px">
		<form id='modelForm'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
                <tr>
                    <th width="25%"><label for="modelName"><i class="required">*</i>模块名称</label></th>
                    <td width="75%">
                        <input class="form-control input-sm" type="text" name="modelName" id="modelName" title="模块名称" data-placement="bottom"/>
                    </td>
                </tr>
                <tr>
                    <th width="25%"><label for="modelType"><i class="required">*</i>模块类型</label></th>
                    <td width="75%">
                        <label class="radio-inline">
                            <input class="form-control" type="radio" name="modelType" value="1" id="modelTypeSystem" title="平台" >平台
                        </label>
                        <label class="radio-inline">
                            <input class="form-control" type="radio" name="modelType" value="2" id="modelTypeBusiness" title="业务" checked>业务
                        </label>
                    </td>
                </tr>
			</table>
		</form>
	</div>
</body>
</html>