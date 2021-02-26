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
<!-- ControllerPath = "phoneproject/programmanage/portalprogram/PortalProgramManageController/PortalProgramInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div  style="background:#ffffff;height:50%">
		<div id="toolbarPortalProgram" class="datagrid-toolbar">
		 	<table>
		 		<tr>
		 	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_add" permissionDes="添加">	
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="portalProgram.insert();" href="javascript:void(0);">添加</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_edit" permissionDes="编辑">			
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="portalProgram.modify();" href="javascript:void(0);">编辑</a></td>
			</sec:accesscontrollist>	
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_delete" permissionDes="删除">					
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="portalProgram.del(null);" href="javascript:void(0);">删除</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_using" permissionDes="启用">					
					<td><a class="easyui-linkbutton" plain="true" onclick="portalProgram.change('_0');" href="javascript:void(0);">启用</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_forbidden" permissionDes="禁用">					
					<td><a class="easyui-linkbutton" plain="true" onclick="portalProgram.change('_1');" href="javascript:void(0);">禁用</a></td>
			</sec:accesscontrollist>
			<!-- 
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_query" permissionDes="查询">				
					<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="portalProgram.openSearchForm();" href="javascript:void(0);">查询</a></td>
			</sec:accesscontrollist>	
			 -->				
				</tr>
		 	</table>
	 	</div>
	 	<table id="dgPortalProgram"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarPortalProgram',
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
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">主键</th>
					<th data-options="field:'programName', halign:'center'" width="220">应用名称</th>
					<th data-options="field:'programCode', halign:'center'" width="220">应用代码</th>
					<th data-options="field:'programImg', halign:'center'" width="220">应用图标地址</th>
					<th data-options="field:'programResponsibles', halign:'center'" width="220">责任人</th>
					<!-- <th data-options="field:'programDesc', halign:'center'" width="220">应用程序描述</th> -->
					<th data-options="field:'programState', halign:'center'">应用程序状态</th>
					<th data-options=" field:'attribute01',halign:'center',formatter:formateCaoZuo">操作</th>
				</tr>
			</thead>
			
		</table>
	</div>
	<div style="height:50%;background:#f5fafe;">
	<div id="toolbarportalProgramVersion" class="datagrid-toolbar">
	 	<table>
	 		<tr>
	 		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgramVersion_button_add" permissionDes="添加">
				<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="portalProgramVersion.insert(portalProgram.getSelectID());" href="javascript:void(0);">添加</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgramVersion_button_edit" permissionDes="编辑">		
				<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="portalProgramVersion.modify();" href="javascript:void(0);">编辑</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgramVersion_button_delete" permissionDes="删除">		
				<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="portalProgramVersion.del();" href="javascript:void(0);">删除</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_using" permissionDes="启用">					
					<td><a class="easyui-linkbutton" plain="true" onclick="portalProgramVersion.change('_0');" href="javascript:void(0);">启用</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalProgram_button_forbidden" permissionDes="禁用">					
					<td><a class="easyui-linkbutton" plain="true" onclick="portalProgramVersion.change('_1');" href="javascript:void(0);">禁用</a></td>
			</sec:accesscontrollist>		
			</tr>
	 	</table>
 	</div>
	<table id='dgportalProgramVersion' class="easyui-datagrid"
   	 		data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarportalProgramVersion',
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
				<th data-options="field:'id', halign:'center',checkbox:true" width="220">主键</th>
				<th data-options="field:'programVersionName', halign:'center'" width="220">版本名称</th>
				<!--  <th data-options="field:'programId', halign:'center'" width="220">应用程序表外键</th>-->
				<th data-options="field:'programVersionEntrance', halign:'center'" width="220">入口地址</th>
				<th data-options="field:'programVersionGateWay', halign:'center'" width="220">网关地址</th>
				<th data-options="field:'programVersionVpn', halign:'center'" width="50">VPN</th>
				<th data-options="field:'programVersionMsgHandling', halign:'center'" width="220">消息处理</th>
				<th data-options="field:'programVersionOpenMode', halign:'center'" width="220">打开方式</th><!-- (0.model;1.state) -->
				<th data-options="field:'programVersionManifest', halign:'center'" width="220">STATE配置文件</th>
				<th data-options="field:'programVersionModuleName', halign:'center'" width="220">包名称</th>
				<th data-options="field:'programVersionDependance', halign:'center'" width="220">依赖包</th><!-- （多个地址，用分号分割） -->
				<th data-options="field:'programVersionUrl', halign:'center'" width="220">版本地址</th>
				<!-- <th data-options="field:'programVersionDesc', halign:'center'" width="220">版本描述</th>  -->
				<th data-options="field:'programVersionIsNew', halign:'center'" width="220">是否最新版本</th>
				<th data-options="field:'programVersionState', halign:'center'" width="220">版本状态</th><!-- (0 启用；1 禁用) -->
				<th data-options=" field:'attribute01',halign:'center',formatter:formateVersionCaoZuo">操作</th>
				<!-- <th data-options="field:'programVersionIsNew', halign:'center'" width="220">应用程序版本状态(是否最新版本;)</th>-->
			</tr>   
	    </thead>   
	</table>  
</div>	
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="overflow:auto;padding-bottom:35px;">
		<form id="portalProgram">
    		<table style="padding-top: 10px;width: 600px; margin: 0 auto;">
					<tr>
																													</tr>
    </table>
    </form>
    <!-- 
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalProgram.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalProgram.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalProgram.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
     -->
  </div>
	<script src=" avicit/phoneproject/programmanage/portalprogram/js/PortalProgram.js" type="text/javascript"></script>
	<script src=" avicit/phoneproject/programmanage/portalprogram/js/PortalProgramVersion.js" type="text/javascript"></script>
	<script type="text/javascript">
		var portalProgram;
		var portalProgramVersion;
		$(function(){
			portalProgram= new PortalProgram('dgPortalProgram','${url}','searchDialog','portalProgram');
	
			portalProgram.setOnLoadSuccess(function(){
				portalProgramVersion = new PortalProgramVersion('dgportalProgramVersion','${surl}');
			});
			portalProgram.setOnSelectRow(function(rowIndex, rowData,id){
				portalProgramVersion.loadByPid(id);
			});
			
			portalProgram.init();			
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									
		});
		
		function formateDate(value,row,index){
			return portalProgram.formate(value);
		}
		function formateDateTime(value,row,index){
			return portalProgram.formateTime(value);
		}
		//portalProgram.detail(\''+row.id+'\')
		function formateHref(value,row,inde){
			return '<a href="javascript:void(0);" onclick="portalProgram.detail(\''+row.id+'\');">'+value+'</a>';
		}
		function formateCaoZuo(value,row,inde){
			return  '<a href="javascript:void(0);" onclick="portalProgram.del(\''+row.id+'\',\''+row.programState+'\' );">'+value+'</a>';
		}   
		function formateVersionCaoZuo(value,row,inde){
			return  '<a href="javascript:void(0);" onclick="portalProgramVersion.del(\''+row.id+'\',\''+row.programVersionState+'\' );">'+value+'</a>';
		}  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
	</script>
</body>
</html>