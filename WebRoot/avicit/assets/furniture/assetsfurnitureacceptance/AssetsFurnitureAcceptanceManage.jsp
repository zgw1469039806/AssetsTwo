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
<!-- ControllerPath = "assets/furniture/assetsfurnitureacceptance/assetsFurnitureAcceptanceController/toAssetsFurnitureAcceptanceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="panelnorth" data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsFurnitureAcceptance').setGridWidth(a);$('#assetsFurnitureAcceptance').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_assetsFurnitureAcceptance" class="toolbar">
			<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAcceptance_button_add" permissionDes="添加">
		  	<a id="assetsFurnitureAcceptance_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAcceptance_button_edit" permissionDes="编辑">
			<a id="assetsFurnitureAcceptance_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFurnitureAcceptance_button_delete" permissionDes="删除">
			<a id="assetsFurnitureAcceptance_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
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
			    <div class="input-group form-tool-search" style="width:125px">
		     		<input type="text" name="assetsFurnitureAcceptance_keyWord" id="assetsFurnitureAcceptance_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="assetsFurnitureAcceptance_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="assetsFurnitureAcceptance_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>	
		<table id="assetsFurnitureAcceptance"></table>
		<div id="assetsFurnitureAcceptancePager"></div>
    </div>
    <div id="centerpanel" data-options="region:'center',split:true,onResize:function(a){$('#assetsFurAcceptanceRel').setGridWidth(a); $('#assetsFurAcceptanceRel').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
	    <div id="toolbar_assetsFurAcceptanceRel" class="toolbar">
		    <div class="toolbar-right">
			    <div class="input-group form-tool-search" style="width:125px">
		     		<input type="text" name="assetsFurAcceptanceRel_keyWord" id="assetsFurAcceptanceRel_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="assetsFurAcceptanceRel_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="assetsFurAcceptanceRel_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>	
		<table id="assetsFurAcceptanceRel"></table>
		<div id="assetsFurAcceptanceRelPager"></div>
    </div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form">
	       <input type="hidden" id="bpmState" name="bpmState" value="all">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																							  						   							 								<th width="10%">验收单号:</th>
										    								 <td width="39%">
	    								 <input title="验收单号" class="form-control input-sm" type="text" name="acceptanceNo" id="acceptanceNo" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">申购单号:</th>
										    								 <td width="39%">
	    								 <input title="申购单号" class="form-control input-sm" type="text" name="furNo" id="furNo" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																																		  						   							 								<th width="10%">采购员:</th>
																			<td width="39%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="buyer" name="buyer">
										      <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" name="buyerAlias" >
										      <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																								 						   						   						   																							  						   							 								<th width="10%">申请人:</th>
																			<td width="39%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="createdByPersion" name="createdByPersion">
										      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias" name="createdByPersionAlias" >
										      <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">申请人部门:</th>
																			 <td width="39%">
										<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" >
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
										</td>
																								 						   						   						   																																																																														  						   							 								<th width="10%">申购原因:</th>
										    								 <td width="39%">
	    								 <input title="申购原因" class="form-control input-sm" type="text" name="applyReason" id="applyReason" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">合同号:</th>
										    								 <td width="39%">
	    								 <input title="合同号" class="form-control input-sm" type="text" name="contractNum" id="contractNum" />
	    								 </td>
																								 						   						   						   																							  						   							 									<th width="10%">预计到货时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="arrivalDateBegin" id="arrivalDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">预计到货时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="arrivalDateEnd" id="arrivalDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 									<th width="10%">实际到货时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="actuallyDateBegin" id="actuallyDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">实际到货时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="actuallyDateEnd" id="actuallyDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 								<th width="10%">单据总金额:</th>
																			<td width="39%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="formPrice" id="formPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   						   						   																																																																																																																																																																																																																																										 </tr>
    	</table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
    	   <table class="form_commonTable">
			    <tr>
																						  						  						   							 							 						   						   						   						 					   					 												  					   					 											 											 											 											 											 											 												  						  						   							 								<th width="10%">家具名称:</th>
										    								 <td width="39%">
	    								 <input title="家具名称" class="form-control input-sm" type="text" name="furnitureName" id="furnitureName" />
	    								 </td>
																								 						   						   						   						 					   					 												  						  						   							 								<th width="10%">家具分类:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="furnitureCategory" id="furnitureCategory" title="家具分类" isNull="true" lookupCode="FURNITURE_CATEGORY" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   						   						   						 					   					 												  						  						   							 								<th width="10%">生产厂家:</th>
										    								 <td width="39%">
	    								 <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId" />
	    								 </td>
																								 						   						   						   						 					   					 												  						  						   							 								<th width="10%">质保期(单位：天):</th>
																			<td width="39%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="guaranteePeriod" id="guaranteePeriod"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   						   						   						 					   					 												  						  						   							 									<th width="10%">质保截止日期(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="guaranteeDateBegin" id="guaranteeDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">质保截止日期(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="guaranteeDateEnd" id="guaranteeDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   						 					   					 												  						  						   							 								<th width="10%">规格:</th>
										    								 <td width="39%">
	    								 <input title="规格" class="form-control input-sm" type="text" name="furnitureSpec" id="furnitureSpec" />
	    								 </td>
																								 						   						   						   						 					   					 												  						  						   							 								<th width="10%">安装地点ID:</th>
										    								 <td width="39%">
	    								 <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   						 					   					 												  						  						   							 								<th width="10%">验收数量:</th>
																			<td width="39%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="checkNum" id="checkNum"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   						   						   						 					   					 												  						  						   							 								<th width="10%">采购单价:</th>
																			<td width="39%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   						   						   						 					   					 												  						  						   							 								<th width="10%">采购总价:</th>
																			<td width="39%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="totalPrice" id="totalPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
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
<script src="avicit/assets/furniture/assetsfurnitureacceptance/js/AssetsFurnitureAcceptance.js" type="text/javascript"></script>
<script src="avicit/assets/furniture/assetsfurnitureacceptance/js/AssetsFurAcceptanceRel.js" type="text/javascript"></script>
<script type="text/javascript">
var assetsFurnitureAcceptance;
var assetsFurAcceptanceRel;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsFurnitureAcceptance.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="assetsFurnitureAcceptance.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsFurnitureAcceptance.reLoad();
};
		
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
						  		  							  		      	 searchMainNames.push("acceptanceNo");
 	 searchMainTips.push("验收单号");
		 	 		  							  		      	 searchMainNames.push("furNo");
 	 searchMainTips.push("申购单号");
		 	 		  										  		  							  		  							  		  																						  		     		  							  		     		  							  							  							  																																																																var searchMainC = searchMainTips.length==2?'或' + searchMainTips[1] : "";
	$('#assetsFurnitureAcceptance_keyWord').attr('placeholder','请输入' + searchMainTips[0] + searchMainC);
	$('#assetsFurnitureAcceptance_keyWord').attr('title','请输入' + searchMainTips[0] + searchMainC);
	var searchSubNames = new Array();
	var searchSubTips = new Array();
						  		  							  		  																									  		         searchSubNames.push("furnitureName");
    searchSubTips.push("家具名称");
		 	 		  							  		  							  		         searchSubNames.push("manufacturerId");
    searchSubTips.push("生产厂家");
		 	 		  							  							  							  		     		  							  		     		  							  							  							  																																																																var searchSubC = searchSubTips.length==2?'或' + searchSubTips[1] : "";
	$('#assetsFurAcceptanceRel_keyWord').attr('placeholder','请输入' + searchSubTips[0] + searchSubC);
	$('#assetsFurAcceptanceRel_keyWord').attr('title','请输入' + searchSubTips[0] + searchSubC);
	var assetsFurnitureAcceptanceGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																		  																	,{ label: '验收单号', name: 'acceptanceNo', width: 150,formatter:formatValue}
																												  																		,{ label: '申购单号', name: 'furNo', width: 150}
																																  																		,{ label: '采购员', name: 'buyerAlias', width: 150}
																													  																		,{ label: '申请人', name: 'createdByPersionAlias', width: 150}
																													  																		,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150}
																																												  																		,{ label: '申购原因', name: 'applyReason', width: 150}
																													  																		,{ label: '合同号', name: 'contractNum', width: 150}
																													  																		,{ label: '预计到货时间', name: 'arrivalDate', width: 150,formatter:format}
																													  																		,{ label: '实际到货时间', name: 'actuallyDate', width: 150,formatter:format}
																													  																		,{ label: '单据总金额', name: 'formPrice', width: 150}
																																																																																		                ,{ label: '流程当前步骤', name: 'activityalias_',width: 150 } 
	                ,{ label: '流程状态',name: 'businessstate_', width: 150}
	];
	var assetsFurAcceptanceRelGridColModel =  [
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																																																	,{ label: '家具名称', name: 'furnitureName', width: 150}
																																					              	                        ,{ label: '家具分类', name: 'furnitureCategoryName', width: 150}
									        																																				,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																																															,{ label: '质保期(单位：天)', name: 'guaranteePeriod', width: 150}
																																															,{ label: '质保截止日期', name: 'guaranteeDate', width: 150,formatter:format}
																																															,{ label: '规格', name: 'furnitureSpec', width: 150}
																																															,{ label: '安装地点ID', name: 'positionId', width: 150}
																																															,{ label: '验收数量', name: 'checkNum', width: 150}
																																															,{ label: '采购单价', name: 'unitPrice', width: 150}
																																															,{ label: '采购总价', name: 'totalPrice', width: 150}
																																																																																		];
	
	assetsFurnitureAcceptance= new AssetsFurnitureAcceptance('assetsFurnitureAcceptance','${url}','form',assetsFurnitureAcceptanceGridColModel,'searchDialog',
	 function(pid){
			assetsFurAcceptanceRel = new AssetsFurAcceptanceRel('assetsFurAcceptanceRel','${surl}', "formSub", assetsFurAcceptanceRelGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsFurAcceptanceRel_keyWord");
		},
	 function(pid){
			assetsFurAcceptanceRel.reLoad(pid);
		},
		searchMainNames,
		"assetsFurnitureAcceptance_keyWord");
	//主表操作
	//添加按钮绑定事件
	$('#assetsFurnitureAcceptance_insert').bind('click', function(){
		assetsFurnitureAcceptance.insert();
	});
	//编辑按钮绑定事件
	$('#assetsFurnitureAcceptance_modify').bind('click', function(){
		assetsFurnitureAcceptance.modify();
	});
	//删除按钮绑定事件
	$('#assetsFurnitureAcceptance_del').bind('click', function(){  
		assetsFurnitureAcceptance.del();
	});
	//打开高级查询框
	$('#assetsFurnitureAcceptance_searchAll').bind('click', function(){
		assetsFurnitureAcceptance.openSearchForm(this,$('#assetsFurnitureAcceptance'));
	});
	//关键字段查询按钮绑定事件
	$('#assetsFurnitureAcceptance_searchPart').bind('click', function(){
		assetsFurnitureAcceptance.searchByKeyWord();
	});
	
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsFurnitureAcceptance.initWorkFlow($(this).val());
	});
	//子表操作
	//打开高级查询
	$('#assetsFurAcceptanceRel_searchAll').bind('click', function(){
		assetsFurAcceptanceRel.openSearchForm(this,$('#assetsFurAcceptanceRel'));
	});
	//关键字段查询按钮绑定事件
	$('#assetsFurAcceptanceRel_searchPart').bind('click', function(){
		assetsFurAcceptanceRel.searchByKeyWord();
	});
    
																																																																				$('#buyerAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'buyer',textFiled:'buyerAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#createdByPersionAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'createdByPersion',textFiled:'createdByPersionAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
			    																																																																																																																																																																																	
																																																																																																																																																																																																																																																																																																													
});

</script>
</html>