<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileconfig/mobilefilepathconfig/MobileFilePathConfigController/MobileFilePathConfigInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background:#ffffff;height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarMobileFilePathConfig" class="datagrid-toolbar">
		 	<table>
		 		<tr>
		 		
		 				 		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileFilePathConfig_button_add" permissionDes="添加">
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="mobileFilePathConfig.insert();" href="javascript:void(0);">添加</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileFilePathConfig_button_edit" permissionDes="编辑">
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="mobileFilePathConfig.modify();" href="javascript:void(0);">编辑</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileFilePathConfig_button_delete" permissionDes="删除">
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="mobileFilePathConfig.del();" href="javascript:void(0);">删除</a></td>
				</sec:accesscontrollist>
								<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileFilePathConfig_button_query" permissionDes="查询">	
					<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="mobileFilePathConfig.openSearchForm();" href="javascript:void(0);">查询</a></td>
				</sec:accesscontrollist>	
				<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="selfDefQury.show();" href="javascript:void(0);">高级查询</a></td>	
				</tr>
		 	</table>
	 	</div>
		<table id="dgMobileFilePathConfig"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileFilePathConfig',
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
					<th data-options="field:'filePathName', halign:'center'"
						width="220">应用配置</th>
					<th data-options="field:'filePath', halign:'center'" width="220">文件路径</th>
					<th data-options="field:'description', halign:'center'" width="220">描述</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 904px;height:340px;display:none;">
		<form id="mobileFilePathConfig">
    		<table class="form_commonTable">
					<tr>
																																										<th width="10%">FILE_PATH_NAME:</th>
										    								 <td width="40%"><input class="easyui-validatebox"  style="width: 151px;" type="text" name="filePathName"/></td>
																																																																																																																																</tr>
    				</table>
    				</form>
    	 <div id="searchBtns" class="datagrid-toolbar foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                        <a class="easyui-linkbutton primary-btn" iconCls="" plain="false" onclick="mobileFilePathConfig.searchData();" href="javascript:void(0);">查询</a>
                        <a class="easyui-linkbutton" iconCls="" plain="false" onclick="mobileFilePathConfig.clearData();" href="javascript:void(0);">清空</a>
                        <a class="easyui-linkbutton" iconCls="" plain="false" onclick="mobileFilePathConfig.hideSearchForm();" href="javascript:void(0);">返回</a>
                    </td>
                </tr>
            </table>
        </div>
  </div>
	<script src=" avicit/platform6/mobile/msecure/mobileconfig/mobilefilepathconfig/js/MobileFilePathConfig.js" type="text/javascript"></script>
	<script type="text/javascript">
		var mobileFilePathConfig;
		$(function(){
			mobileFilePathConfig= new MobileFilePathConfig('dgMobileFilePathConfig','${url}','searchDialog','mobileFilePathConfig');
																																																																																																									/////
			var array=[];
    			                                                                                                                                         
                              var searchObject = 
                                {
                                    name:'FILE_PATH_NAME',
                                    field:'FILE_PATH_NAME',
                                    type:1,
                                    dataType:'string'};
                                     array.push(searchObject);
                                                                                                                                                                                                                                                                                                                                                                                                        ///
              
            
            selfDefQury.init(array);
            selfDefQury.setQuery(function(param){
                mobileFilePathConfig.searchDataBySfn(param);
            });
		});
		function formateDate(value,row,index){
			return mobileFilePathConfig.formate(value);
		}
		function formateDateTime(value,row,index){
			return mobileFilePathConfig.formateTime(value);
		}
		//mobileFilePathConfig.detail(\''+row.id+'\')
		function formateHref(value,row,inde){
			return '<a href="javascript:void(0);" onclick="mobileFilePathConfig.detail(\''+row.id+'\');">'+value+'</a>';
		}
		                                                                                                                                                                                                                          	</script>
</body>
</html>