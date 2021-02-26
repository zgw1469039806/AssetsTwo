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
<!-- ControllerPath = "mdaDatasourceEasyUIController/toMdaDatasourceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
	
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
<!-- 自定义列属性-->
<script
	src="static/js/platform/component/common/userDefinedColumnTools.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mdaDatasource;
	var mdaCrawlitems,insertIndex;
	function refresh(){
	   window.location.reload();
	}
	function openNext(type,tmpID){
		var num = $("#dgmdaCrawlitems").datagrid('getChecked');
		 if(num.length==0){
			 $.messager.alert('提示','请选择一条数据！','info');
		 	 return false;
		 }
		 if(num.length>1){
			 $.messager.alert('提示','只能选择一条数据！','info');
		 	 return false;
		 }
		 var _id = num[0].id;
		 insertIndex = new CommonDialog("insert", "1200", "600", 'platform/mdaDatasourceEasyUIController/setTow/'+tmpID+'/'+type+'/'+_id, "设置", false, true, false);
		 insertIndex.show();
	}
	
	
	function openc(type){
		var num = $("#dgmdaCrawlitems").datagrid('getChecked');
		 if(num.length==0){
			 $.messager.alert('提示','请选择一条数据！','info');
		 	return false;
		 }
		 if(num.length>1){
			 $.messager.alert('提示','只能选择一条数据！','info');
		 	return false;
		 }
		 var _id =  num[0].id;
		 insertIndex = new CommonDialog("insert", "1200", "600", 'platform/mdaDatasourceEasyUIController/setTow/'+type+'/'+_id , "设置", false, true, false);
		 insertIndex.show();
	}
	
	function closWinc(){
		 insertIndex.close();
		 mdaCrawlitems.reLoad();
	}
	function upFun(){
		 var num = $("#dgmdaCrawlitems").datagrid('getChecked');
		 if(num.length==0){
			 $.messager.alert('提示','请选择一条数据！','info');
		 	return false;
		 }
		 if(num.length>1){
			 $.messager.alert('提示','只能选择一条数据！','info');
		 	 return false;
		 }
		 var _id = num[0].id;
		 var _type='web';
		 var _typeValue=num[0].itemtype;
		// alert('=====ssssssss===='+_id);
		 if(_typeValue=='2'){
			 _type='doc';
		 }
		if(_typeValue=='1'){
			_type='db';
		}
		insertIndex = new CommonDialog("insert", "1200", "600", 'platform/mdaDatasourceEasyUIController/set/'+_type+'/'+_id , "设置", false, true, false);
		insertIndex.show();
	}
	
	//开始爬取数据
	 function crawlFlag(crawlflag,crawlItemID,type) {
		 if(crawlflag == 'config'||crawlflag == 'ok'||crawlflag == 'err'){
				//执行中
				$("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_ing.png");
				//不能触发爬取操作
				$.ajax({
					 url:"platform/mdaDatasourceEasyUIController/operation/crawl/"+crawlItemID,
					 type : 'post',
					 success : function(r){
						 if (r == "ok"){
							 $.messager.alert('提示','执行成功！','info',function(){
			 				    	refresh();
			 			        });
							 //爬取成功，重新至于开始爬取，准备下一次爬取
							  $("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_start.png");
							 //刷新当前页面
							// refresh();
						 }else{
							 $.messager.alert('提示','执行失败！','info',function(){
			 				    	refresh();
			 			        });
							 //爬取失败，重新至于开始爬取，准备下一次爬取
							 $("#btn"+crawlItemID).attr("src","static/images/platform/mda/crawl_btn/btn_start.png");
							 //刷新当前页面
							// refresh();
						 } 
					 }
				 });
			}else{
				$.messager.alert('提示','未配置，请先配置采集任务！','info');
			} 
	 }
	
	//停止任务
	 function toStopTask(){
	 	 var num = $("#dgmdaCrawlitems").datagrid('getChecked');
	 	 if(num.length==0){
	 		 $.messager.alert('提示','请选择一条数据！','info');
	 		 return false;
	 	 }
	 	 if(num.length>1){
	 		 $.messager.alert('提示','只能选择一条数据！','info');
	 		 return false;
	 	 }
	 	 var _id = num[0].id;
	 	// alert('=========停止任务==_id==='+_id);
	 	 $.ajax({
	 		 url:"platform/mdaDatasourceEasyUIController/operation/crawl/toStopTask/"+_id ,
	 		 type : 'post',
	 		 success : function(r){
	 			 if (r == "ok"){
	 				 $.messager.alert('提示','停止成功！','info',function(){
	 				    	refresh();
	 			        });
	 			 }else if(r == "err"){
	 				 $.messager.alert('提示','停止失败！','info',function(){
	 				    	refresh();
	 			        });
	 			 }else if(r == "none"){
	 				$.messager.alert('提示','当前任务未运行，无需停止！','info',function(){
 				    	refresh();
 			        });
				 }else{
	 				 $.messager.alert('提示','程序异常！','info',function(){
	 				    	refresh();
	 			        });
	 			 } 
	 		 }
	 	 });
	 }
	
	$(function() {
		mdaDatasource = new MdaDatasource('dgMdaDatasource', 'platform/mdaDatasourceEasyUIController/operation/',
				'searchDialog', 'mdaDatasource');

		mdaDatasource.setOnLoadSuccess(function() {
			mdaCrawlitems = new MdaCrawlitems('dgmdaCrawlitems', 'platform/mdaDatasourceEasyUIController/operation/sub/',
					'searchDialogSub','mdaCrawlitems');
		});
		mdaDatasource.setOnSelectRow(function(rowIndex, rowData, id) {
			mdaCrawlitems.loadByPid(id);
		});

		mdaDatasource.init();
		var useridUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "userid", "useridAlias");
		useridUserCommonSelector.init(); 
		var lastcrawluseridUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "lastcrawluserid", "lastcrawluseridAlias");
		lastcrawluseridUserCommonSelector.init();
		var array = [];

		var searchObject = {
			name : '用户',
			field : 'USERID',
			type : 1,
			dataType : 'user'
		};

		array.push(searchObject);
		var searchObject = {
			name : '数据源名称',
			field : 'NAME',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);
		var searchObject = {
			name : '创建时间',
			field : 'CREATETIME',
			type : 1,
			dataType : 'date'
		};
		array.push(searchObject);
		var searchObject = {
			name : '最后修改时间',
			field : 'LASTMODIFYTIME',
			type : 1,
			dataType : 'date'
		};
		array.push(searchObject);
		var searchObject = {
			name : '状态',
			field : 'STATUS',
			type : 1,
			dictCode : 'MDA_STATUS',
			dataType : 'dict'
		};
		array.push(searchObject);
		selfDefQury.init(array);
		selfDefQury.setQuery(function(param) {
			mdaDatasource.searchDataBySfn(param);
		});
		//停止所有任务
		$('#mdaCrawlitems_stop').bind('click', function() {
			toStopTask();
		});
	});
	function formatDate(value, row, index) {
		return mdaDatasource.format(value);
	}
	function formatDateTime(value, row, index) {
		return mdaDatasource.formatDateTime(value);
	}
	function formatDateForHref(value, row, index) {
		var thisDate = mdaDatasource.format(value);
		return '<a href="javascript:void(0);" onclick="mdaDatasource.detail(\''
				+ row.id + '\');">' + thisDate + '</a>';
	}
	function formatTimeForHref(value, row, index) {
		var thisTime = mdaDatasource.formatDateTime(value);
		return '<a href="javascript:void(0);" onclick="mdaDatasource.detail(\''
				+ row.id + '\');">' + thisTime + '</a>';
	}

	function formatHref(value, row, inde) {
		return '<a href="javascript:void(0);" onclick="mdaDatasource.detail(\''
				+ row.id + '\');">' + value + '</a>';
	}

	function formatstatus(value) {
		return Platform6.fn.lookup.formatLookupType(value,
				mdaDatasource.status);
	}
	function formatitemtype(value) {
		return Platform6.fn.lookup.formatLookupType(value,
				mdaDatasource.itemtype);
	}
	function formatoption(index,type,gridname) {
		  return "<img id='btn"+ type.id +"' onclick='crawlFlag(\"" + type.crawlflag +"\",\"" + type.id +"\",\"" + type.itemtype +"\")'   src='static/images/platform/mda/crawl_btn/btn_start.png'/>";     
		}

	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
<script
	src="avicit/platform6/mda_easyui/mdadatasource/js/MdaDatasource.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mda_easyui/mdadatasource/js/MdaCrawlitems.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center'"
		style="background: #ffffff; height: 0;">
		<div id="toolbarMdaDatasource" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaDatasource_button_add"
						permissionDes="主表添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mdaDatasource.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaDatasource_button_edit"
						permissionDes="主表编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mdaDatasource.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaDatasource_button_delete"
						permissionDes="主表删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mdaDatasource.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaDatasource_button_query"
						permissionDes="主表查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mdaDatasource.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<%-- <sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaDatasource_button_seniorquery"
						permissionDes="高级查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="selfDefQury.show();"
							href="javascript:void(0);">高级查询</a></td>
					</sec:accesscontrollist> --%>
				</tr>
			</table>
		</div>
		<table id="dgMdaDatasource"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMdaDatasource',
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
					<th data-options="field:'name', halign:'center'" width="220">数据源名称</th>
					<th data-options="field:'useridAlias',align:'center'" width="220">用户</th>
					<th
						data-options="field:'createtime', halign:'center',formatter:formatDate"
						width="220">创建时间</th>
					<th
						data-options="field:'lastUpdateDate', halign:'center',formatter:formatDate"
						width="220">最后修改时间</th>
					<th
						data-options="field:'status', halign:'center',formatter:formatstatus"
						width="220">状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'east',split:true"
		style="width: 750px; background: #f5fafe;">

		<div id="toolbarmdaCrawlitems" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_add"
						permissionDes="子表添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mdaCrawlitems.insert(mdaDatasource.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_edit"
						permissionDes="子表编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mdaCrawlitems.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_delete"
						permissionDes="子表删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mdaCrawlitems.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_query"
						permissionDes="字表查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mdaCrawlitems.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_set"
						permissionDes="配置">
						<td><a class="easyui-linkbutton"
							plain="true" onclick="mdaCrawlitems.set();"
							href="javascript:void(0);">配置</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaCrawlitems_button_stop"
						permissionDes="停止任务">
						<td><a class="easyui-linkbutton"
							plain="true" id="mdaCrawlitems_stop"
							href="javascript:void(0);">停止任务</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmdaCrawlitems' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmdaCrawlitems',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:true,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">ID</th>
					<th data-options="field:'name', halign:'center'" width="220">数据源配置名称</th>
					<th
						data-options="field:'createtime', halign:'center',formatter:formatDate"
						width="220">创建时间</th>
					<th
						data-options="field:'lastUpdateDate', halign:'center',formatter:formatDate"
						width="220">最后修改时间</th>
					<th
						data-options="field:'lasttimecrawl', halign:'center',formatter:formatDate"
						width="220">最后采集时间</th>
					<th data-options="field:'lastcrawluserid', halign:'center'"
						width="220">最后采集用户</th>
					<th data-options="field:'itemtype', halign:'center',formatter:formatitemtype" width="220">采集类型</th>
					<th data-options="field:'classifyids', halign:'center'" width="220">分类</th>
					<th data-options="field:'status', halign:'center',formatter:formatstatus" width="220">状态</th>
					<th data-options="field:'crawlflag', halign:'center',formatter:formatoption" width="220">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mdaDatasource">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">用户:</th>
					<td width="39%"><input title="USERID" class="inputbox"
						style="width: 99%;" type="hidden" name="userid" id="userid" />
						<div class="">
							<input class="easyui-validatebox" type="text" title="USERID"
								name="useridAlias" id="useridAlias"
								readOnly="readOnly" style="width: 99%;"></input>
						</div></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">数据源名称:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="name" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(从):</th>
					<td width="39%"><input name="createtimeBegin"
						id="createtimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(至):</th>
					<td width="39%"><input name="createtimeEnd" id="createtimeEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">最后修改时间(从):</th>
					<td width="39%"><input name="lastmodifytimeBegin"
						id="lastmodifytimeBegin" class="easyui-datebox" editable="false" />
					</td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">最后修改时间(至):</th>
					<td width="39%"><input name="lastmodifytimeEnd"
						id="lastmodifytimeEnd" class="easyui-datebox" editable="false" />
					</td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">状态:</th>
					<td width="39%"><pt6:syslookup name="status" id="status"
							title="STATUS" isNull="true" lookupCode="MDA_STATUS"
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera"
			style="padding-bottom: 6px;">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mdaDatasource.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaDatasource.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaDatasource.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	
	<div id="searchDialogSub"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtnsSub'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mdaCrawlitems">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">最后采集用户:</th>
					<td width="39%"><input title="LASTCRAWLUSERID" class="inputbox"
						type="hidden" name="lastcrawluserid" id="lastcrawluserid" />
						<div class="">
							<input class="easyui-validatebox" type="text" title="LASTCRAWLUSERID"
								name="lastcrawluseridAlias" id="lastcrawluseridAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">数据源配置名称:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="name" /></td>
					
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(从):</th>
					<td width="39%"><input name="createtimeBegin"
						id="createtimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(至):</th>
					<td width="39%"><input name="createtimeEnd" id="createtimeEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">最后修改时间(从):</th>
					<td width="39%"><input name="lastmodifytimeBegin"
						id="lastmodifytimeBegin" class="easyui-datebox" editable="false" />
					</td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">最后修改时间(至):</th>
					<td width="39%"><input name="lastmodifytimeEnd"
						id="lastmodifytimeEnd" class="easyui-datebox" editable="false" />
					</td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						采集类型:</th>
					<td width="39%"><pt6:syslookup name="itemtype" id="itemtype"
							title="itemtype" isNull="true" lookupCode="MDA_ITEMTYPE"
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">状态:</th>
					<td width="39%"><pt6:syslookup name="status" id="status"
							title="STATUS" isNull="true" lookupCode="MDA_STATUS"
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						分类:</th>
					<td width="39%"><input title="CLASSIFYIDS"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[50]'" style="width: 99%;"
						type="text" name="classifyids" id="classifyids" /></td>
				</tr>
			</table>
		</form>
		<div id="searchBtnsSub" class="datagrid-toolbar foot-formopera"
			style="padding-bottom: 6px;">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mdaCrawlitems.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaCrawlitems.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaCrawlitems.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>