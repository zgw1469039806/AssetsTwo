<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
  String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
  <!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/sub/Add/null" -->
  <title>添加</title>
  <base href="<%=ViewUtil.getRequestPath(request)%>">
  <jsp:include
          page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
  </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
<!-- 表单开始 -->
  <form id='form'>
    <input type="hidden" id="itemId_id" name="itemId" value="${id}"/>
  	<table class="form_commonTable">
  		<tr>
  		    <th width="10%"><label for="name">索引库户名:</label></th>
  			<td width="39%">
  			<input id="dbUserName_id" title="用户名:"
                               class="form-control input-sm" type="text" value="${mdaDatabasecrawlconfigDTO.username }"  name="dbUserName"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库密码：</label></th>
  			<td width="39%">
  			<input id="dbUserPWD_id" title="用户名xpath:"
                               class="form-control input-sm" type="text" value="${mdaDatabasecrawlconfigDTO.password }" name="dbUserPWD"  />
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库类型：</label></th>
  			<td width="39%">
	  			<input type="hidden" name="dbType" id="dbType_id"/>
	        	<span class="dbType_class">
	        		<input type="radio" name="Type"  value="mysql"  <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'mysql' }">checked="checked"</c:if>   >mysql
				</span> 
				<span class="dbType_class">&nbsp;&nbsp;&nbsp;
					<input type="radio" name="Type"  value="oracle"  <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'oracle'  }">checked="checked"</c:if> >oracle
				</span>
	          	<span class="dbType_class">&nbsp;&nbsp;&nbsp;
	          		<input type="radio" name="Type" value="sqlserver" <c:if test="${mdaDatabasecrawlconfigDTO.databasetype == 'sqlserver'  }">checked="checked"</c:if>  >sqlserver
	 		   </span>
  			</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库IP地址：</label></th>
  			<td width="39%">
  				<input id="dbServerIP_id" title="密码xpath:"
                               class="form-control input-sm" type="text" value="${mdaDatabasecrawlconfigDTO.databaseip }" name="dbServerIP" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库端口：</label></th>
  			<td width="39%">
  				<input id="dbServerPort_id" title="登录按钮:"
                               class="form-control input-sm" value="${mdaDatabasecrawlconfigDTO.databaseport }" type="text" name="dbServerPort" id="name" />
        	</td>
  		</tr>
  		<tr>
  		 <th width="10%"><label for="name">数据库名称：</label></th>
  			<td width="39%">
  				<input id="dbServerName_id" title="数据库名:"
                               class="form-control input-sm" value="${mdaDatabasecrawlconfigDTO.servername}" type="text" name="dbServerName"  />
  			  <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="下一步" id="test_connection" >测试连接</a>
  			</td>
  		</tr>
  	
  	</table>
  </form>
 <!-- 表单结束 -->
 
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
  <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
    <table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
      <tr>
        <td width="50%" style="padding-right: 4%;" align="right">
          <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="完成" id="mdaCrawlitems_saveForm" >完成</a>
        </td>
      </tr>
    </table>
  </div>
</div>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
  <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript"
        src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js"
        type="text/javascript"></script>
<script type="text/javascript">



</script>
</body>
</html>