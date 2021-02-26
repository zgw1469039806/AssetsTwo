<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String importlibs = "common,table,form";	
%>
<%
String datatime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String datetime = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdacollections/mdaCollectionsController/operation/Add/null" -->
<title>索引库数据详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">

		<div data-options="region:'west',split:true" style="width:300px;padding:0px;overflow:auto;">
			<a style="margin:5px;float:right; " href="javascript:cleanSolrCore('${mdaCollectionsDTO.collectionName}');" class="btn btn-primary form-tool-btn btn-sm" role="button" title="清空索引库">清空索引库</a>
		</div>
	<div data-options="region:'center',split:true,border:false">
	
			<div class="row" style="width:350px;left:30%; margin:0 0 0 0; position:absolute; top:40%;" >
						<select style="float:left;width: 80px; height: 30px; min-height: 30px;" name="dbUpdateType">
					          <option value="1">索引库01</option>
					          <option value="2">索引库02</option>
					          <option value="2">索引库03</option>
					          <option value="2">索引库04</option>
				        </select>
					<div class="input-group  input-group-sm">
				      <input  class="form-control" placeholder="请输入关键字。。。" type="text" id="txt" name="txt">
				      <span class="input-group-btn">
				        <button id="searchbtn" class="btn btn-default ztree-search" type="button"><span class="glyphicon glyphicon-search"><font style="margin:5px;" >搜索一下</font></font></font></span></button>
				      </span>
				    </div>
			</div>
	
	
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaCollections.closeDialog();
		}
			
			
		//清空索引库
		function cleanSolrCore(solrcoreName) {
			alert('==============='+solrcoreName);
				$.ajax({
					 url:"platform6/mda/mdacollections/mdaCollectionsController/operation/solr/clean"+solrcoreName,
					 type : 'post',
					 success : function(r){
						 if (r == "success"){
							 layer.alert('执行成功！' ,{
								  icon: 7,
								  area: ['400px', ''], //宽高
								  closeBtn: 0
							    }, function(){
							    	refresh();
						        }
							 );
						 }else{
							 layer.alert('执行失败！' ,{
								  icon: 7,
								  area: ['400px', ''], //宽高
								  closeBtn: 0
							    }, function(){
							    	refresh();
						        }
					         );
						 } 
					 }
				 });
		   }
				
			
			
			
			
		
	</script>
</body>
</html>