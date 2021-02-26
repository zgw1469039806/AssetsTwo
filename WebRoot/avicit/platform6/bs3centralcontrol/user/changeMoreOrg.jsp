<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <input type="hidden" id="classId" name="classId">
    <form id='addForm'>
        <table class="form_commonTable">
        	<tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="org">组织：</label>
	                </th>
	                <td width="85%">
	                    <select class="form-control input-sm" style="width: 99%;"  id="org" name="org" onchange="changeOrg(this);return false;">
	                       ${org}
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="dept">部门：</label>
	                </th>
	                <td width="85%">
	                     <select class="form-control input-sm" style="width: 99%;"  id="dept" name="dept">
	                       ${dept}
	                    </select>
	                </td>
	            </tr>
        </table>
    	
    </form>
</div>
<input type='hidden' id='currentOrgId' name='currentOrgId' value='${currentOrgId }'>
<input type='hidden' id='currentOrgName' name='currentOrgName' value='${currentOrgName }'>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    $(function(){
    	
    });
    function changeOrg(obj){
    	var selectedOrgId = document.getElementById("org").value;
    	$.ajax({
    		url : 'userChangeMultipleIdentity/getChangeUserLoginDeptListData?orgId=' + selectedOrgId,
    		type : 'get',
    		dataType : 'html',
    		success : function(r) {
    			$("#dept").html(r);
    		}
    	});
    }
    function getOrgId(){
    	return document.getElementById("org").value;
    }
    function getDeptId(){
    	return document.getElementById("dept").value;
    }
    function getCurrentOrgId(){
    	return document.getElementById("currentOrgId").value;
    }
    function getCurrentOrgName(){
    	return document.getElementById("currentOrgName").value;
    }
</script>
</body>
</html>
