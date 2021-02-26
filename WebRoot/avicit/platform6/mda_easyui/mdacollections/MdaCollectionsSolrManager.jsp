<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<%-- <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include> --%>
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
</head>
<style type="text/css">
	tr{
		height:20px;
	}
</style>
<body class="easyui-layout" fit="true" style="overflow-x: hidden;">



	<div data-options="region:'center',split:true,border:false">
		<c:if test="${solrJsonData.crawlTYPE == 'DOC'}">
			<!-- ================文档类型===========详情页===============================-->
				<table  style="margin-left:30px;">
					<tr >
						<th>文章标题：</th>
						<td>
						${solrJsonData.TITLE}
						</td>
					</tr>
					<tr>
						<th>文章作者：</th>
						<td>${solrJsonData.AUTHOR}</td>
					</tr>
					<tr>
						<th>所属数据源：</th>
						<td>${solrJsonData.solrDataSourceName}</td>
					</tr>
					<tr>
						<th>分类：</th>
						<td>${solrJsonData.solrDataClassify}</td>
					</tr>
					<tr>
						<th>所属采集任务：</th>
						<td>${solrJsonData.solrDataTaskName}</td>
					</tr>
					<tr>
						<th>采集任务创建者：</th>
						<td>${solrJsonData.solrDataCrawlUser}</td>
					</tr>
					<tr>
						<th>采集时间：</th>
						<td>${solrJsonData.CRAWLEDATE}</td>
					</tr>
					<tr>
						<th>自定义url：</th>
						<td>${solrJsonData.URL}</td>
					</tr>
					<tr>
						<th>内容：</th>
						<td>
						 	<textarea  rows="3"  cols="60" style="color: #BEBEBE;" id="textarea2" ><c:if test="${!empty solrJsonData.CONTENT}">${solrJsonData.CONTENT}</c:if></textarea>
						</td>
					</tr>
					<tr>
						<th>JSON：</th>
						<td>
						 	<textarea readonly="readonly" rows="20"  cols="60" style="color: black;" id="textarea2" ><c:if test="${!empty htmlJsonData}">${htmlJsonData}</c:if></textarea>
						</td>
					</tr>
					
				</table>
		</c:if>
		<c:if test="${solrJsonData.crawlTYPE == 'DB'}">
		<!-- ================数据库类型===========详情页===============================-->
				<table  style="margin-left:30px;">
					<tr >
						<th>源数据库名称：</th>
						<td>
						${solrJsonData.serverName}
						</td>
					</tr>
					<tr >
						<th>现存数据库名称：</th>
						<td>
						${solrJsonData.DBName}
						</td>
					</tr>
					<tr>
						<th>现存数据表名：</th>
						<td>${solrJsonData.DBTableName}&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:showDBTable();" >表数据预览</a></td>
					</tr>
					<tr>
						<th>所属数据源：</th>
						<td>${solrJsonData.solrDataSourceName}</td>
					</tr>
					<tr>
						<th>分类：</th>
						<td>${solrJsonData.solrDataClassify}</td>
					</tr>
					<tr>
						<th>所属采集任务：</th>
						<td>${solrJsonData.solrDataTaskName}</td>
					</tr>
					<tr>
						<th>采集任务创建者：</th>
						<td>${solrJsonData.solrDataCrawlUser}</td>
					</tr>
					<tr>
						<th>采集时间：</th>
						<td>${solrJsonData.CRAWLEDATE}</td>
					</tr>
					<tr>
						<th>自定义url：</th>
						<td>${solrJsonData.URL}</td>
					</tr>
					<tr>
						<th>JSON：</th>
						<td>
						<input id="DBShow_id" type="hidden" value="${solrJsonData.DBShow}">
						 	<textarea readonly="readonly"  rows="18"  cols="60" style="color: black;" id="textarea2" ><c:if test="${!empty htmlJsonData}">${htmlJsonData}</c:if></textarea>
						</td>
					</tr>
				</table>
		</c:if>
	<script type="text/javascript">
		function closeForm(){
			parent.mdaCollections.closeDialog();
		}
			
		//表数据预览
		function showDBTable(){
			var htmldata = $('#DBShow_id').val();
			if(htmldata!= null){
				//自定页
				this.nData = new CommonDialog("DBDetail", "2000", "120", htmldata, "表数据预览", false, true, false);
				this.nData.show();
			}	
		} 
	</script>
</body>
</html>