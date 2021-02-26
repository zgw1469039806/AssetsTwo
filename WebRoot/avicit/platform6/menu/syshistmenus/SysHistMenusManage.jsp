<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/menu/syshistmenus/sysHistMenusController/toSysHistMenusManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysHistMenus_button_add" permissionDes="添加">
  	<a id="sysHistMenus_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysHistMenus_button_del" permissionDes="删除">
	<a id="sysHistMenus_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysHistMenus_button_save" permissionDes="保存">
	<a id="sysHistMenus_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="sysHistMenus_keyWord" id="sysHistMenus_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="sysHistMenus_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="sysHistMenus_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="sysHistMenusjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																																																																																																																																																																																																																																																																																																																					  						   							 								<th width="10%">菜单节点ID:</th>
										    								 <td width="39%">
	    								 <input title="菜单节点ID" class="form-control input-sm" type="text" name="menuId" id="menuId" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">菜单名称:</th>
										    								 <td width="39%">
	    								 <input title="菜单名称" class="form-control input-sm" type="text" name="menuName" id="menuName" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">菜单编码:</th>
										    								 <td width="39%">
	    								 <input title="菜单编码" class="form-control input-sm" type="text" name="menuCode" id="menuCode" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">菜单链接:</th>
										    								 <td width="39%">
	    								 <input title="菜单链接" class="form-control input-sm" type="text" name="menuUrl" id="menuUrl" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 									<th width="10%">查看时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="viewTimeBegin" id="viewTimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">查看时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="viewTimeEnd" id="viewTimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/menu/syshistmenus/js/SysHistMenus.js" type="text/javascript"></script>
<script type="text/javascript">
//后台获取的通用代码数据
			 		     																													     			     			     			     			     var sysHistMenus;
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																																																																																   				   													,{ label: '菜单节点ID', name: 'menuId', width: 150,editable:true}
																													   				   													,{ label: '菜单名称', name: 'menuName', width: 150,editable:true}
																													   				   													,{ label: '菜单编码', name: 'menuCode', width: 150,editable:true}
																													   				   													,{ label: '菜单链接', name: 'menuUrl', width: 150,editable:true}
																													   				   													,{ label: '查看时间', name: 'viewTime', width: 150,editable:true, edittype:'custom',editoptions:{custom_element:dateElem,custom_value:dateValue}}
																						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																																																																																					  		         searchNames.push("menuId");
    searchTips.push("菜单节点ID");
		 	 		  							  		         searchNames.push("menuName");
    searchTips.push("菜单名称");
		 	 		  							  		     		  							  		     		  							  				var searchC = searchTips.length==2?'或' + searchTips[1] : "";
	$('#sysHistMenus_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	sysHistMenus= new SysHistMenus('sysHistMenusjqGrid','${url}','searchDialog','form','sysHistMenus_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#sysHistMenus_insert').bind('click', function(){
		sysHistMenus.insert();
	});
	//删除按钮绑定事件
	$('#sysHistMenus_del').bind('click', function(){
		sysHistMenus.del();
	});
	//保存按钮绑定事件
	$('#sysHistMenus_save').bind('click', function(){  
		sysHistMenus.save();
	});
	//查询按钮绑定事件
	$('#sysHistMenus_searchPart').bind('click', function(){
		sysHistMenus.searchByKeyWord();
	});
	//打开高级查询框
	$('#sysHistMenus_searchAll').bind('click', function(){
		sysHistMenus.openSearchForm(this);
	});
	//回车键查询
	$('#sysHistMenus_keyWord').on('keydown',function(e){
		if(e.keyCode == 13){
			sysHistMenus.searchByKeyWord();
		}
	});
																																																																																																																																																																																											
});
</script>
</html>