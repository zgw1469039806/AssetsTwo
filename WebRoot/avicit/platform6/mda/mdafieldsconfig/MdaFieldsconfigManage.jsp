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
<!-- ControllerPath = "platform6/mda/mdafieldsconfig/mdaFieldsconfigController/toMdaFieldsconfigManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaFieldsconfig_button_add" permissionDes="添加">
  	<a id="mdaFieldsconfig_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaFieldsconfig_button_edit" permissionDes="编辑">
	<a id="mdaFieldsconfig_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaFieldsconfig_button_delete" permissionDes="删除">
	<a id="mdaFieldsconfig_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaFieldsconfig_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaFieldsconfig_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaFieldsconfigjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																																																																																																				  						   							 								<th width="10%">ITEMID:</th>
										    								 <td width="39%">
	    								 <input title="ITEMID" class="form-control input-sm" type="text" name="itemid" id="itemid" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">FIELDNAME:</th>
										    								 <td width="39%">
	    								 <input title="FIELDNAME" class="form-control input-sm" type="text" name="fieldname" id="fieldname" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">FIELDVALUE:</th>
										    								 <td width="39%">
	    								 <input title="FIELDVALUE" class="form-control input-sm" type="text" name="fieldvalue" id="fieldvalue" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">FIELDTYPE:</th>
										    								 <td width="39%">
	    								 <input title="FIELDTYPE" class="form-control input-sm" type="text" name="fieldtype" id="fieldtype" />
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
<script src="avicit/platform6/mda/mdafieldsconfig/js/MdaFieldsconfig.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaFieldsconfig;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaFieldsconfig.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaFieldsconfig.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																							  																		,{ label: 'ITEMID', name: 'itemid', width: 150}
																													  																		,{ label: 'FIELDNAME', name: 'fieldname', width: 150}
																													  																		,{ label: 'FIELDVALUE', name: 'fieldvalue', width: 150}
																													  																		,{ label: 'FIELDTYPE', name: 'fieldtype', width: 150}
																						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																												  		         searchNames.push("itemid");
    searchTips.push("ITEMID");
		 	 		  							  		         searchNames.push("fieldname");
    searchTips.push("FIELDNAME");
		 	 		  							  		     		  							  		     		  				$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaFieldsconfig= new MdaFieldsconfig('mdaFieldsconfigjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaFieldsconfig_insert').bind('click', function(){
		mdaFieldsconfig.insert();
	});
	//编辑按钮绑定事件
	$('#mdaFieldsconfig_modify').bind('click', function(){
		mdaFieldsconfig.modify();
	});
	//删除按钮绑定事件
	$('#mdaFieldsconfig_del').bind('click', function(){  
		mdaFieldsconfig.del();
	});
	//查询按钮绑定事件
	$('#mdaFieldsconfig_searchPart').bind('click', function(){
		mdaFieldsconfig.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaFieldsconfig_searchAll').bind('click', function(){
		mdaFieldsconfig.openSearchForm(this);
	});
																																																																																																															
});

</script>
</html>