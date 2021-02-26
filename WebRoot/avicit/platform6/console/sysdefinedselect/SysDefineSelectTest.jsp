<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
    String code_ = request.getParameter("code_");
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>			
     <table class="form_commonTable">
		<tr>
		  <th width="10%">
				<label for="code_">自定义选择框:</label>
			  </th>
		  <td width="39%">
		  		<div id="test6" class="input-group input-group-sm avicselect" >
                    <input type="hidden" name="key" id="key">
                    <input type="text" class="form-control">
                    <span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-calendar"></i></span>
                    <div class="avicselect-list"> </div>
                </div>
		   </td>
		    <th width="10%">
				
			  </th>
		  <td width="39%">
		  		
		   </td>
		 </tr>
		 
	</table>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script>
		$(function() {
			//取编码为'<%=code_%>'的列表;
			 $('#test6').avicselect({
		 		height:'200px',
		 		code:'<%=code_%>',
		        dataBind:{'KEY':'key'},
	            //,afterSelect: function(data){ //回填
	            //	alert(data);
	            //}
				//,
	            //beferOpenPream:function(){return {pjcode:'101'}}//带参数查询
			});
			
		});
	</script>
	</body>

</html>
