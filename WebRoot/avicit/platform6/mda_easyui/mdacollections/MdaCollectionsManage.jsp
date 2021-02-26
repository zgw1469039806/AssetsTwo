<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/mda/mdatask/mdaTaskEasyUIController/toMdaCollectionsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js" type="text/javascript"></script>
<script src="avicit/platform6/mda_easyui/mdacollections/js/MdaCollections.js" type="text/javascript"></script>
<script type="text/javascript">
	var mdaCollections;
	$(function() {
		var searchNames = new Array();
		var searchTips = new Array();
		searchNames.push("keyWord");
		/* searchTips.push("任务名称");
		searchTips.push("采集项"); */

		mdaCollections = new MdaCollections('mdaCollectionsDataGrid', '${url}',
				'searchDialog', 'form', 'keyWord', searchNames,
				dataGridColModel);
		var dataGridColModel = [
				{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				},
				{
					label : '标题',
					name : 'title',
					width : 150
				},
				{
					label : '摘要',
					name : 'content',
					width : 150
				},
				{
					label : '数据源',
					name : 'solrDataSourceName',
					width : 150
				},
				{
					label : '分类',
					name : 'solrDataClassify',
					width : 150
				},
				{
					label : '创建时间',
					name : 'crawledate',
					width : 150
				},
				{
					label : 'URL',
					name : 'url',
					width : 150
				},
				{
					label : '操作',
					name : '',
					width : 100
				} ];
		selfDefQury.init(dataGridColModel);
	});
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'"
		style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;">
		<div id="tableToolbar" class="datagrid-toolbar">
			<table>
				<tr>
				    <td><input  class="form-control" placeholder="请输入关键字。。。" type="text" 
				     	name="keyWord" id="keyWord"></td>
				     	<td><a id="mdaCollections_searchPart" href="javascript:void(0)" 
						class="easyui-linkbutton" plain="true">搜索一下</a></td>
					<sec:accesscontrollist hasPermission="3"  
						domainObject="formdialog_mdaCollections_button_edit" permissionDes="清空索引库">
						<td><a  id="mdaCollections_delall" href="javascript:void(0)" 
						class="easyui-linkbutton" iconCls="icon-remove" plain="true" title="清空索引库">清空索引库</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"  
						domainObject="formdialog_mdaCollections_button_add" permissionDes="加载中间数据">
						<td><a id="mdaCollections_addjsondata" href="javascript:void(0)" 
						class="easyui-linkbutton" iconCls="icon-add" plain="true" title="加载中间数据">加载中间数据</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCollections_button_delete" permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="mdaCollections_del" 
						href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="mdaCollectionsDataGrid"
			data-options="
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#tableToolbar',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					pagination:true,
					pageSize:dataOptions.pageSize,
					pageList:dataOptions.pageList,
					striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">ID</th>
					<th data-options="field:'title', halign:'center'" width="120">标题</th>
					<th data-options="field:'content', halign:'center'" width="120">摘要</th>
					<th data-options="field:'solrDataSourceName', halign:'center'" width="120">数据源</th>
					<th data-options="field:'solrDataClassify', halign:'center'" width="120">分类</th>
					<th data-options="field:'crawledate', halign:'center'" width="120">创建时间</th>
					<th data-options="field:'url', halign:'center' ,formatter:formateURL" width="120">URL</th>
					<th data-options="field:'_operate', halign:'center' ,formatter:formatDetail" width="120">操作</th>
				</tr>
			</thead>
		</table>
		<!-- <div id="jqGridPager"></div> -->
	</div>
</body>

<script type="text/javascript">
	var mdaCollections; 
	function formateURL(cellvalue,row, index) {
		return "<a  href='javascript:void(0);' onclick='doJump4URL(\"" + cellvalue +"\")'  title='"+cellvalue+"'>"+cellvalue+"</a>";
	}
	function formatDetail(cellvalue,row, index) {
		  return "<a  href='javascript:void(0);' onclick='solrconfigFlag(\"" + row.id +"\")' class='easyui-linkbutton' title='查看详情'>查看详情</a>";     
		}
	//清空索引库
	function cleanSolrCore() {
		//alert('==============='+solrcoreName);
			$.ajax({
				 url:"platform6/mda/mdacollections/mdaCollectionsEasyUIController/operation/solr/clean",
				 type : 'post',
				 success : function(r){
					 if (r == "success"){
						$.messager.show({
							 title : '提示',
							 msg : '执行成功！'
						});
						setTimeout('refresh()',500);
					 }else{
						$.messager.show({
							 title : '提示',
							 msg : '执行成功！'
						});
						setTimeout('refresh()',500);
					 } 
				 }
			 });
	   }
	//进入索引数据管理按钮绑定事件
	function solrconfigFlag(solrcoreID) {
		//======================toSolrCoreManage/'+solrcoreID+"."（这个点很重要，不要去掉）
		var solrUrl = 'platform6/mda/mdacollections/mdaCollectionsEasyUIController/toSolrCoreManage/'+solrcoreID+".";
		mdaCollections.solrDetail(solrUrl);
	}	
	//进入索引数据管理按钮绑定事件
	function doJump4URL(URL) {
		mdaCollections.doJump4URL(URL);
	}
	function refresh(){
		   window.location.reload();
		}

	$(document).ready(
			function() {
				
				//添加按钮绑定事件
				$('#mdaCollections_insert').bind('click', function(){
					mdaCollections.insert();
				});
				//============加载Json中间文件==========
				$('#mdaCollections_addjsondata').bind('click', function(){
					var addjsonurl ='platform6/mda/mdacollections/mdaCollectionsEasyUIController/toMdaCollectionsManage/addJsondata';
					mdaCollections.addjsondata(addjsonurl);
				});
				//清空索引库
				$('#mdaCollections_delall').bind('click', function(){
					$.messager.confirm('请确认','您确定要清空索引库？',function(b){
						 if(b){
							 cleanSolrCore();}
						 });
				//	mdaCollections.modify();
				});
				//删除按钮绑定事件
				$('#mdaCollections_del').bind('click', function(){  
					mdaCollections.del();
				});
				//查询按钮绑定事件
				$('#mdaCollections_searchPart').bind('click', function(){
					mdaCollections.searchByKeyWord();
				});

			});
</script>
</html>