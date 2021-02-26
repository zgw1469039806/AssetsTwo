<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "test/eformviewinfo/eformViewInfoController/operation/Add/null" -->
	<title>编辑</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="editFormView" role="form">
			<ul class="nav nav-tabs" style="margin:20px 20px 0px 20px">
				<li class="active"><a href="#viewInfo" data-toggle="tab" id="viewInfoTab">基本信息</a></li>
				<li><a href="#viewList" data-toggle="tab" id="viewListTab">列表</a></li>
				<li><a href="#viewTool" data-toggle="tab" id="viewToolTab">工具条</a></li>
			</ul>
		
			<div id="myTabContent" class="tab-content" style="margin:20px 40px">
				<!-- 基本信息 -->
				<div class="tab-pane fade in active" id="viewInfo">
						<br>
						<input type="hidden" name="id" id="viewInfoId" value="${viewInfo.id}"/>
						<input type="hidden" name="datagridInfoId" id="datagridInfoId" value="${datagridInfo.id}"/>
						<input type="hidden" name="orderCol" id="orderColHidden" value="${datagridInfo.orderCol}"/>
						<input type="hidden" name="eformComponentId" id="eformComponentId" value="${viewInfo.eformComponentId}"/>
						<table class="form_commonTable">
							<tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
									<label for="viewName">视图名称</label>
								</th>
								<td width="80%">
									<input class="form-control input-sm" type="text" name="viewName" id="viewName" title="视图名称" value="${viewInfo.viewName}"/>
								</td>
							</tr>
							<tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
									<label for="viewDesc">描述</label>
								</th>
								<td width="80%">
									<textarea class="form-control input-sm" rows="3" name="viewDesc" id="viewDesc" title="描述">${viewInfo.viewDesc}</textarea>
								</td>
							</tr>
							<tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
				                    <label for="viewStyle">样式</label>
				                </th>
				                <td width="80%">
									<label class="radio-inline">
										<input type="radio" name="viewStyle" value="1" id="viewStyleleBootstrap" title="Bootstrap" <c:if test="${viewInfo.viewStyle == '1'}">checked</c:if>>Bootstrap
									</label>
									<label class="radio-inline">
										<input type="radio" name="viewStyle" value="0" id="viewStyleleEasyUI" title="EasyUI" <c:if test="${viewInfo.viewStyle == '0'}">checked</c:if>>EasyUI
									</label>
				                </td>
				             </tr>
							 <tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
									<label for="tableId">排序</label>
								</th>
								<td width="80%">
									<input class="form-control input-sm" type="text" name="orderBy" id="orderBy" title="排序" value="${viewInfo.orderBy}"/>
								</td>
							</tr>
							<tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
									<label for="tableId">存储模型</label>
								</th>
								<td width="80%">
									<input type="hidden" id="tableId" name="tableId">
									<input class="form-control input-sm" type="text" name="tableName" id="tableName" title="存储模型" value="${viewInfo.tableName}"/>
								</td>
							</tr>
							<tr>
								<th width="6%" style="word-break: break-all; word-warp: break-word;">
									<label for="viewWhere">Where过滤</label>
								</th>
								<td width="80%">
									<textarea class="form-control input-sm" rows="3" name="viewWhere" id="viewWhere" title="Where过滤">${viewInfo.viewWhere}</textarea>
									<label>如果你具备数据库SQL语言能力,你可以修改上面的SQL Where语句! 注意:Where子句不包含Where关键字，可限制用户查询范围内的数据。这些参与过滤的字段应该被定义在所查询的元数据中，表达式的值可以是常量，也可以使用平台内置的rule表达式变量.</label>
								</td>
							</tr>
						</table>
				</div>
				
				<!-- 列表 -->
				<div class="tab-pane fade" id="viewList">
					<br>
					<div class="panel panel-default" >
						<div class="panel-heading">
							<h3 class="panel-title">表格属性</h3>
						</div>
					    <div class="panel-body">
					        <table class="form_commonTable">
					        	<tr>
					        		<th width="6%" style="word-break: break-all; word-warp: break-word;">
					        			<label for="pagination">允许分页</label>
					        		</th>
					        		<td width="5%">
					        			<input type="checkbox" value="Y" name="pagination" id="pagination" title="允许分页" <c:if test="${datagridInfo.pagination == 'Y'}">checked</c:if>/>
					        		</td>
					        		<th width="10%" style="word-break: break-all; word-warp: break-word;">
					        			<label for="selection">显示复选框</label>
					        		</th>
					        		<td width="5%">
					        			<input class="input-sm" type="checkbox" value="Y" name="selection" id="selection" title="显示复选框" <c:if test="${datagridInfo.selection == 'Y'}">checked</c:if>/>
					        		</td>
					        	</tr>
					        	<tr>
					        		<th width="6%" style="word-break: break-all; word-warp: break-word;">
					        			<label for="gridHeader">显示表头</label>
					        		</th>
					        		<td width="5%">
					        			<input class="input-sm" type="checkbox" value="Y" name="gridHeader" id="gridHeader" title="显示表头" <c:if test="${datagridInfo.gridHeader == 'Y'}">checked</c:if>/>
					        		</td>
					        		<th width="10%" style="word-break: break-all; word-warp: break-word;">
					        			<label for="orderCol">默认排序字段</label>
					        		</th>
					        		<td width="10%">
					        			<select class="form-control input-sm" id="orderCol" name="orderCol" title="默认排序字段">
					        			</select>
					        		</td>
					        		<th width="6%" style="word-break: break-all; word-warp: break-word;">
					        			<label for="orderSort">排序方式</label>
					        		</th>
					        		<td width="10%">
					        			<select class="form-control input-sm" id="orderSort" name="orderSort" title="排序方式">
					        				<option value="1" ${datagridInfo.orderSort == 1 ? selected : ""}>升序</option>
					        				<option value="2" ${datagridInfo.orderSort == 2 ? selected : ""}>降序</option>
					        			</select>
					        		</td>
					        	</tr>
					        </table>
					    </div>
					</div>
					<br>
					<table id="jqGridColumnInfo"/></table>
				</div>
				
				<!-- 工具条 -->
				<div class="tab-pane fade" id="viewTool" style="margin:20px 40px">
					<div class="panel panel-default" >
						<div class="panel-heading">
							<h3 class="panel-title">按钮设置</h3>
						</div>
					    <div class="panel-body">
							<div class="toolbar" id="custumButtonToolbar">
								<div class="toolbar-left">
									<a id="jqGridCustomButtonAdd" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-xm"
									role="button" title="添加"><i class="icon icon-add"></i>添加</a>
									<a id="jqGridCustomButtonDelete" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-xm"
                   					role="button" title="删除"><i class="icon icon-delete"></i>删除</a>
								</div>
							</div>
					        <table id="jqGridCustomButton"></table>
					    </div>
					</div>

					<div class="panel panel-default" >
						<div class="panel-heading">
							<h3 class="panel-title">基本查询</h3>
						</div>
					    <div class="panel-body">
							<div class="toolbar" id="basicSearchToolbar">
					        <table id="jqGridBasicSearch"></table>
					    </div>
					</div>

					<div class="panel panel-default" >
						<div class="panel-heading">
							<h3 class="panel-title">高级查询</h3>
						</div>
					    <div class="panel-body">
							<div class="toolbar" id="advenceSearchToolbar">
								<div class="toolbar-left">
									<a id="jqGridAdvenceSearchAdd" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-xm"
									role="button" title="添加"><i class="icon icon-add"></i>添加</a>
									<a id="jqGridAdvenceSearchDelete" href="javascript:void(0);" class="btn btn-default form-tool-btn btn-xm"
                   					role="button" title="删除"><i class="icon icon-delete"></i>删除</a>
								</div>
							</div>
					        <table id="jqGridAdvenceSearch"></table>
					    </div>
					</div>

				</div>
			</div>
			
		</form>
	</div>
	
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="eformViewInfo_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="eformViewInfo_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/eform/bpmsformmanage/js/EformFormViewDetail.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/EformFormView.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
	<script src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
	<script type="text/javascript">
		var eformFormViewDetail;
		var selectCreatedDbTable;
		
		$(document).ready(function () {
				eformFormViewDetail = new EformFormViewDetail();

		        $("#eformComponentId").val(parent.eformComponent.selectedEformComponentId);

				//初始化
				selectCreatedDbTable = new SelectCreatedDbTable("tableId","tableName");
				selectCreatedDbTable.init();
		        
				/*****************************基本信息*************************************/
		        eformFormViewDetail.formValidate($('#editFormView'));
		        //绑定确认按钮单机事件
		        $('#eformViewInfo_saveForm').bind('click', function () {
		            eformFormViewDetail.subEdit($("#editFormView"), $("#jqGridColumnInfo"), $("#jqGridCustomButton"), $("#jqGridBasicSearch"), $("#jqGridAdvenceSearch"));
		        });

				//绑定返回按钮单机事件
		        $('#eformViewInfo_closeForm').bind('click', function () {
		            eformFormViewDetail.closeDialog();
		        });
		        
				/*****************************列属性*************************************/
		        //实例jqgrid
		        eformFormViewDetail.instanceJqGridColumnInfo($("#jqGridColumnInfo"));
				eformFormViewDetail.initTableColumeSelect("tableId", "viewInfoId","orderCol","orderColHidden","edit");
				//eformFormViewDetail.loadColumnData("tableId","viewInfoId" ,$("#jqGridColumnInfo"),"edit");

		        //绑定事件
		        $("#tableId").on("change",function(){
					eformFormViewDetail.initTableColumeSelect("tableId","viewInfoId", "orderCol","orderColHidden","edit");
					//eformFormViewDetail.loadColumnData("tableId","viewInfoId" ,$("#jqGridColumnInfo"),"edit");
		        });

				/*****************************按钮*************************************/
				//实例按钮jqgrid
				eformFormViewDetail.instanceJqGridCustomButton("viewInfoId", $("#jqGridCustomButton"), "edit", "custumButtonToolbar");
				//绑定按钮事件
		        $("#jqGridCustomButtonAdd").on("click", function(){
					eformFormViewDetail.addOperation($("#jqGridCustomButton"), eformFormViewDetail.customButtonRequireField);
		        });
				$("#jqGridCustomButtonDelete").on("click", function(){
					eformFormViewDetail.deleteOperation($("#jqGridCustomButton"),
														"platform/eform/eformViewInfoController/deleteCustomButtonList",
														"edit","customButton");
		        });

				/*****************************基本查询*************************************/
				//绑定按钮事件
		        // $("#jqGridBasicSearchAdd").on("click", function(){
				// 	eformFormViewDetail.addOperation($("#jqGridBasicSearch"), eformFormViewDetail.basicSearchRequireField);
		        // });
				// $("#jqGridBasicSearchDelete").on("click", function(){
				// 	eformFormViewDetail.deleteOperation($("#jqGridBasicSearch"), //DATAGRID对象
				// 										"platform/eform/eformViewInfoController/deleteSearchList", 
				// 										"edit","");
		        // });

				/*****************************高级查询*************************************/
				//绑定按钮事件
		        $("#jqGridAdvenceSearchAdd").on("click", function(){
					eformFormViewDetail.addOperation($("#jqGridAdvenceSearch"), eformFormViewDetail.advenceSearchRequireField);
		        });
				$("#jqGridAdvenceSearchDelete").on("click", function(){
					eformFormViewDetail.deleteOperation($("#jqGridAdvenceSearch"),
														"platform/eform/eformViewInfoController/deleteSearchList",
														"edit","");
		        });

		}); 
	

	</script>
</body>
</html>