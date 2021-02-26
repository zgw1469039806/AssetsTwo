<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/toAssetsFurnitureProcManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="panelnorth"
		data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsFurnitureProc').setGridWidth(a);$('#assetsFurnitureProc').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_assetsFurnitureProc" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_assetsFurnitureProc_button_add"
					permissionDes="添加">
					<a id="assetsFurnitureProc_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_assetsFurnitureProc_button_edit"
					permissionDes="编辑">
					<a id="assetsFurnitureProc_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm"
						style="display: none;" role="button" title="编辑"><i
						class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_assetsFurnitureProc_button_delete"
					permissionDes="删除">
					<a id="assetsFurnitureProc_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm"
						style="display: none;" role="button" title="删除"><i
						class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<select id="workFlowSelect"
					class="form-control input-sm workflow-select">
					<option value="all" selected="selected">全部</option>
					<option value="start">拟稿中</option>
					<option value="active">流转中</option>
					<option value="ended">已完成</option>
				</select>
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="assetsFurnitureProc_keyWord"
						id="assetsFurnitureProc_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="assetsFurnitureProc_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="assetsFurnitureProc_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button">高级查询 <span
						class="caret"></span></a>
				</div>
			</div>
		</div>
		<table id="assetsFurnitureProc"></table>
		<div id="assetsFurnitureProcPager"></div>
	</div>
	<div id="centerpanel"
		data-options="region:'center',split:true,onResize:function(a){$('#assetsFurnitureProcRel').setGridWidth(a); $('#assetsFurnitureProcRel').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
		<div id="toolbar_assetsFurnitureProcRel" class="toolbar">
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="assetsFurnitureProcRel_keyWord"
						id="assetsFurnitureProcRel_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="assetsFurnitureProcRel_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="assetsFurnitureProcRel_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button">高级查询 <span
						class="caret"></span></a>
				</div>
			</div>
		</div>
		<table id="assetsFurnitureProcRel"></table>
		<div id="assetsFurnitureProcRelPager"></div>
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<input type="hidden" id="bpmState" name="bpmState" value="all">
		<table class="form_commonTable">
			<tr>
				<th width="10%">申购单号:</th>
				<td width="39%"><input title="申购单号"
					class="form-control input-sm" type="text" name="furNo" id="furNo" />
				</td>
				<th width="10%">申请人部门:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="createdByDept" name="createdByDept">
						<input class="form-control" placeholder="请选择部门" type="text"
							id="createdByDeptAlias" name="createdByDeptAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">申请人电话:</th>
				<td width="39%"><input title="申请人电话"
					class="form-control input-sm" type="text" name="createdByTel"
					id="createdByTel" /></td>
				<th width="10%">申购原因:</th>
				<td width="39%"><textarea class="form-control input-sm"
						rows="3" title="申购原因" name="applyReason" id="applyReason"></textarea>
				</td>
			</tr>
			<tr>
				<th width="10%">预计到货时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="arrivalDateBegin" id="arrivalDateBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">预计到货时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="arrivalDateEnd" id="arrivalDateEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">单据总金额:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="formPrice"
							id="formPrice" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
							data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
							data-precision="3"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<table class="form_commonTable">
			<tr>
				<th width="10%">申请人部门:</th>
				<td width="39%"><input title="申请人部门"
					class="form-control input-sm" type="text" name="createdByDept"
					id="createdByDept" /></td>
				<th width="10%">申请人电话:</th>
				<td width="39%"><input title="申请人电话"
					class="form-control input-sm" type="text" name="createdByTel"
					id="createdByTel" /></td>
			</tr>
			<tr>
				<th width="10%">家具名称:</th>
				<td width="39%"><input title="家具名称"
					class="form-control input-sm" type="text" name="furnitureName"
					id="furnitureName" /></td>
				<th width="10%">规格:</th>
				<td width="39%"><input title="规格" class="form-control input-sm"
					type="text" name="furnitureSpec" id="furnitureSpec" /></td>
			</tr>
			<tr>
				<th width="10%">申购数量:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="applyNum"
							id="applyNum" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
							data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
							data-precision="0"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th width="10%">预算单价:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="unitPrice"
							id="unitPrice" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
							data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
							data-precision="3"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">预算总价:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="totalPrice"
							id="totalPrice" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
							data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
							data-precision="3"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script
	src="avicit/assets/furniture/assetsfurnitureproc/js/AssetsFurnitureProc.js"
	type="text/javascript"></script>
<script
	src="avicit/assets/furniture/assetsfurnitureproc/js/AssetsFurnitureProcRel.js"
	type="text/javascript"></script>
<script type="text/javascript">
var assetsFurnitureProc;
var assetsFurnitureProcRel;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsFurnitureProc.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="assetsFurnitureProc.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsFurnitureProc.reLoad();
};
		
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
						  		  							  		      	 searchMainNames.push("furNo");
 	 searchMainTips.push("申购单号");
		 	 		  										  		  							  		      	 searchMainNames.push("createdByTel");
 	 searchMainTips.push("申请人电话");
		 	 		  																						  		     		  							  							  																																																																var searchMainC = searchMainTips.length==2?'或' + searchMainTips[1] : "";
	$('#assetsFurnitureProc_keyWord').attr('placeholder','请输入' + searchMainTips[0] + searchMainC);
	$('#assetsFurnitureProc_keyWord').attr('title','请输入' + searchMainTips[0] + searchMainC);
	var searchSubNames = new Array();
	var searchSubTips = new Array();
						  		  							  		  										  		         searchSubNames.push("createdByDept");
    searchSubTips.push("申请人部门");
		 	 		  							  		         searchSubNames.push("createdByTel");
    searchSubTips.push("申请人电话");
		 	 		  																						  		     		  							  		     		  							  							  							  																																																																var searchSubC = searchSubTips.length==2?'或' + searchSubTips[1] : "";
	$('#assetsFurnitureProcRel_keyWord').attr('placeholder','请输入' + searchSubTips[0] + searchSubC);
	$('#assetsFurnitureProcRel_keyWord').attr('title','请输入' + searchSubTips[0] + searchSubC);
	var assetsFurnitureProcGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																		  																	,{ label: '申购单号', name: 'furNo', width: 150,formatter:formatValue}
																															  																		,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150}
																													  																		,{ label: '申请人电话', name: 'createdByTel', width: 150}
																																												  																		,{ label: '申购原因', name: 'applyReason', width: 150}
																													  																		,{ label: '预计到货时间', name: 'arrivalDate', width: 150,formatter:format}
																													  																		,{ label: '单据总金额', name: 'formPrice', width: 150}
																																																																																		                ,{ label: '流程当前步骤', name: 'activityalias_',width: 150 } 
	                ,{ label: '流程状态',name: 'businessstate_', width: 150}
	];
	var assetsFurnitureProcRelGridColModel =  [
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																															,{ label: '家具名称', name: 'furnitureName', width: 150}
																																															,{ label: '规格', name: 'furnitureSpec', width: 150}
																																															,{ label: '申购数量', name: 'applyNum', width: 150}
																																															,{ label: '预算单价', name: 'unitPrice', width: 150}
																																															,{ label: '预算总价', name: 'totalPrice', width: 150}
																																																																																		];
	
	assetsFurnitureProc= new AssetsFurnitureProc('assetsFurnitureProc','${url}','form',assetsFurnitureProcGridColModel,'searchDialog',
	 function(pid){
			assetsFurnitureProcRel = new AssetsFurnitureProcRel('assetsFurnitureProcRel','${surl}', "formSub", assetsFurnitureProcRelGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsFurnitureProcRel_keyWord");
		},
	 function(pid){
			assetsFurnitureProcRel.reLoad(pid);
		},
		searchMainNames,
		"assetsFurnitureProc_keyWord");
	//主表操作
	//添加按钮绑定事件
	$('#assetsFurnitureProc_insert').bind('click', function(){
		assetsFurnitureProc.insert();
	});
	//编辑按钮绑定事件
	$('#assetsFurnitureProc_modify').bind('click', function(){
		assetsFurnitureProc.modify();
	});
	//删除按钮绑定事件
	$('#assetsFurnitureProc_del').bind('click', function(){  
		assetsFurnitureProc.del();
	});
	//打开高级查询框
	$('#assetsFurnitureProc_searchAll').bind('click', function(){
		assetsFurnitureProc.openSearchForm(this,$('#assetsFurnitureProc'));
	});
	//关键字段查询按钮绑定事件
	$('#assetsFurnitureProc_searchPart').bind('click', function(){
		assetsFurnitureProc.searchByKeyWord();
	});
	
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsFurnitureProc.initWorkFlow($(this).val());
	});
	//子表操作
	//打开高级查询
	$('#assetsFurnitureProcRel_searchAll').bind('click', function(){
		assetsFurnitureProcRel.openSearchForm(this,$('#assetsFurnitureProcRel'));
	});
	//关键字段查询按钮绑定事件
	$('#assetsFurnitureProcRel_searchPart').bind('click', function(){
		assetsFurnitureProcRel.searchByKeyWord();
	});
    
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
			    																																																																																																																																																														
																																																																																																																																																																																																																																																				
});

</script>
</html>