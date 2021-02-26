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
	<hr>
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
			<%-- <tr>
				<th>表数据预览：</th>
				<td>
					${solrJsonData.DBShow}
				</td>
			</tr> --%>
			<tr>
				<th>JSON：</th>
				<td>
				<input id="DBShow_id" type="hidden" value="${solrJsonData.DBShow}">
				 	<textarea readonly="readonly"  rows="18"  cols="60" style="color: black;" id="textarea2" ><c:if test="${!empty htmlJsonData}">${htmlJsonData}</c:if></textarea>
				</td>
			</tr>
		</table>
		

<hr>
</c:if>
		
		
		
		
		
		
		
	<%-- 
	         <json:object>
	         	 <json:property name="id" value="${solrJsonData.id}"/> 
       	 		 <json:property name="TITLE" value="${solrJsonData.TITLE[0]}"/>
	         	 <json:property name="CRAWLEDATE" value="${solrJsonData.CRAWLEDATE[0]}"/> 
	         	 <json:property name="URL" value="${solrJsonData.URL[0]}"/> 
	        </json:object>  
	        ${solrJsonData} --%>
	        
       
         
	<%-- 
		<json:object>  
	  <json:property name="itemCount" value="${cart.itemCount}"/>  
	  <json:property name="subtotal" value="${cart.subtotal}"/>  
	  <json:array name="items" var="item" items="${cart.lineItems}">  
	    <json:object>  
	      <json:property name="title" value="${item.title}"/>  
	      <json:property name="description" value="${item.description}"/>  
	      <json:property name="imageUrl" value="${item.imageUrl"/>  
	      <json:property name="price" value="${item.price}"/>  
	      <json:property name="qty" value="${item.qty}"/>  
	    </json:object>  
	  </json:array>  
	</json:object>  
	 --%>
	
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaCollections.closeDialog();
		}
			
	//表数据预览
	function showDBTable(){
		var htmldata = $('#DBShow_id').val();
		if(htmldata!= null){
			//自定页
			layer.open({
			  type: 1,
			  title: '表数据预览',
			  area: ['90%', '25%'],
			  skin: 'layui-layer-demo', //样式类名
			  closeBtn: 1, //不显示关闭按钮
			  anim: 2,
			  shadeClose: true, //开启遮罩关闭
			//  content: '内容'
			  content: htmldata
			});
		}
		/* layer.open({
		    type: 2,
		    area: ['50%', '74%'],
		    title: '设置',
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        maxmin: false, //开启最大化最小化按钮
		    content: 'sss' 
		});  */
		
	} 
			
			
			
			
			
			
	</script>
</body>
</html>