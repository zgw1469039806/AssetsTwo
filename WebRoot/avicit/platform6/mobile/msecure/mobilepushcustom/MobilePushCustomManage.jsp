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
<!-- ControllerPath = "platform6/msecure/mobilepushcustom/MobilePushCustomController/MobilePushCustomInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
<script
	src=" avicit/platform6/mobile/msecure/mobilepushcustom/js/MobilePushCustom.js"
	type="text/javascript"></script>
<script type="text/javascript">
		var mobilePushCustom;
		var mobileApp=[];
		$(function(){
			mobilePushCustom= new MobilePushCustom('dgMobilePushCustom','${url}','searchDialog','mobilePushCustom');		
			$.ajax({
				url: 'platform/platform6/msecure/mobileapp/MobileAppController/getMobileApps.json',
				type :'get',
				async:false,
				dataType :'json',
				success : function(r){
					if(r){
						mobileApp =r;
					}
				}
			});
			var array=[];
    			                                                                                                                                         
                              var searchObject = 
                                {
                                    name:'APPID',
                                    field:'APPID',
                                    type:1,
                                    dataType:'string'};
                                     array.push(searchObject);
                                                                                                                                                                                             
                              var searchObject = 
                                {
                                    name:'TARGET_TYPE',
                                    field:'TARGET_TYPE',
                                    type:1,
                                    dataType:'string'};
                                     array.push(searchObject);
                                                                                                                                                                                                                                                                                                                                                                    ///
              
            
            selfDefQury.init(array);
            selfDefQury.setQuery(function(param){
                mobilePushCustom.searchDataBySfn(param);
            });
		});
		function formateDate(value,row,index){
			return mobilePushCustom.formate(value);
		}
		function formateDateTime(value,row,index){
			return mobilePushCustom.formateTime(value);
		}
		//mobilePushCustom.detail(\''+row.id+'\')
		function formateHref(value,row,inde){
			return '<a href="javascript:void(0);" onclick="mobilePushCustom.detail(\''+row.id+'\');">'+value+'</a>';
		}
		function formatMobileApp(value){
			if(value ==null ||value == '') return '';
			var l=mobileApp.mobileAppDTOList.length;
			for(;l--;){
				if(mobileApp.mobileAppDTOList[l].id == value){
					return mobileApp.mobileAppDTOList[l].appName;
				}
			}
		}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'"
		style="background:#ffffff;height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarMobilePushCustom" class="datagrid-toolbar">
			<table>
				<tr>

					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobilePushCustom_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mobilePushCustom.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobilePushCustom_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobilePushCustom.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobilePushCustom_button_push"
						permissionDes="推送">
						<td><a class="easyui-linkbutton" iconCls="icon-tools"
							plain="true" onclick="mobilePushCustom.push();"
							href="javascript:void(0);">推送</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobilePushCustom_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobilePushCustom.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobilePushCustom_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mobilePushCustom.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
						plain="true" onclick="selfDefQury.show();"
						href="javascript:void(0);">高级查询</a></td>
				</tr>
			</table>
		</div>
		<table id="dgMobilePushCustom"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobilePushCustom',
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
					<th data-options="field:'appid', halign:'center',formatter:formatMobileApp" width="220">对应设备</th>
					<th data-options="field:'targetType', halign:'center'" width="220">推送目标</th>
					<th data-options="field:'content', halign:'center'" width="220">推送内容</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px;height:340px;display:none;">
		<form id="mobilePushCustom">
			<table class="form_commonTable">
				<tr>
					<th width="10%">对应设备:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="appid" /></td>
					<th width="10%">推送目标:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="targetType" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mobilePushCustom.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobilePushCustom.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false"
						onclick="mobilePushCustom.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>