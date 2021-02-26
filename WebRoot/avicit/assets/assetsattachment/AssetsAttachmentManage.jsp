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
<!-- ControllerPath = "assets/assetsattachment/assetsAttachmentController/toAssetsAttachmentManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAttachment_button_add" permissionDes="添加">
  	<a id="assetsAttachment_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAttachment_button_edit" permissionDes="编辑">
	<a id="assetsAttachment_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAttachment_button_delete" permissionDes="删除">
	<a id="assetsAttachment_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
    	<select id="workFlowSelect" class="form-control input-sm workflow-select">
    		<option value="all" selected="selected">全部</option>
    		<option value="start">拟稿中</option>
    		<option value="active">流转中</option>
    		<option value="ended">已完成</option>
    	</select>
	    <div class="input-group form-tool-search">
     		<input type="text" name="assetsAttachment_keyWord" id="assetsAttachment_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="assetsAttachment_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="assetsAttachment_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="assetsAttachmentjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		   <input type="hidden" id="bpmState" name="bpmState" value="all">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																																																																																																																																																																																																																																																																																																																					  						   							 								<th width="10%">附件名称:</th>
										    								 <td width="39%">
	    								 <input title="附件名称" class="form-control input-sm" type="text" name="assetsAttName" id="assetsAttName" />
	    								 </td>
																								 						   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<!-- 业务的js -->
<script src="avicit/assets/assetsattachment/js/AssetsAttachment.js" type="text/javascript"></script>
<script type="text/javascript">
var assetsAttachment;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsAttachment.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="assetsAttachment.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsAttachment.reLoad();
};
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																																																																																  																		,{ label: '附件名称', name: 'assetsAttName', width: 150}
																											<sec:accesscontrollist hasPermission="3" domainObject="assetsAttachment_table_activityalias" permissionDes="流程当前步骤">
				        ,{ label: '流程当前步骤', name: 'activityalias_', width: 150 }
				        </sec:accesscontrollist>
				        <sec:accesscontrollist hasPermission="3" domainObject="assetsAttachment_table_businessstate" permissionDes="流程状态">
				        ,{ label: '流程状态', name: 'businessstate_', width: 150 }
				        </sec:accesscontrollist>
	];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																																																																																					  		         searchNames.push("assetsAttName");
    searchTips.push("附件名称");
		 	 		  				var searchC = searchTips.length==2?'或' + searchTips[1] : "";
	$('#assetsAttachment_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	assetsAttachment = new AssetsAttachment('assetsAttachmentjqGrid','${url}','searchDialog','form','assetsAttachment_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#assetsAttachment_insert').bind('click', function(){
		assetsAttachment.insert();
	});
	//编辑按钮绑定事件
	$('#assetsAttachment_modify').bind('click', function(){
		assetsAttachment.modify();
	});
	//删除按钮绑定事件
	$('#assetsAttachment_del').bind('click', function(){  
		assetsAttachment.del();
	});
	//查询按钮绑定事件
	$('#assetsAttachment_searchPart').bind('click', function(){
		assetsAttachment.searchByKeyWord();
	});
	//打开高级查询框
	$('#assetsAttachment_searchAll').bind('click', function(){
		assetsAttachment.openSearchForm(this,800,400);
	});
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsAttachment.initWorkFlow($(this).val());
	});
																																																																																																															
});

</script>
</html>