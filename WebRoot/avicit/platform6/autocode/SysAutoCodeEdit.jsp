<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "train/form/sysautocode/sysAutoCodeController/operation/Edit/id" -->
<title>编辑编码</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="codeForm" style="margin:20px 20px">
			<input type="hidden" name="version" value="${code.version}" /> 
			<input type="hidden" id="codeId" name="id" value="${code.id}" />
			<div class="panel panel-default panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">基本信息</h3>
				</div>
				<div class="panel-body">
					<table class="form_commonTable" style="margin-bottom:10px">
						<tr>
							<th width="8%" style="white-space:nowrap;">
								<label for="code">编码代码</label>
							</th>
							<td width="14%">
								<input class="form-control input-sm" type="text" name="code" id="code" value="${code.code}" title="编码代码" readonly/>
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="name">编码名称</label>
							</th>
							<td width="14%">
								<input class="form-control input-sm" type="text" name="name" id="name" value="${code.name}" title="编码名称"/>
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="tableName">绑定表</label>
							</th>
							<td width="14%">
								<input type="hidden" id="tableId" name="tableId">
								<input type="text" id="tableName" name="tableName" class="form-control" readonly
									   value="${code.tableName}">
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="columnName">绑定字段</label>
								</th>
							<td width="14%">
								<input type="hidden" id="columnId" name="columnId">
								<input type="text" id="columnName" name="columnName" class="form-control" readonly
									   value="${code.columnName}">
							</td>
							<td width="12%"></td>
						</tr>
					</table>
				</div>
			</div>
		</form>
		<form id="codeSegmentForm" style="margin:20px 20px">
			<div class="panel panel-default panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">编码规则</h3>
				</div>
				<table class="table-striped form_commonTable" style="position:relative;width: 97%;margin:0 20px;" id="segmentTable" >
					<c:forEach items="${segmentList}" var="segment" varStatus="status">
						<tr id="segmentTr_${status.index + 1}" style="position:relative;height: 50px;">
							<th width="5%" style="white-space:nowrap;">
								<label for="segmentType">码段类型</label>
							</th>
							<td width="12%">
								<select class="form-control input-sm segmentType" id="segmentType_${status.index + 1}" name="segmentType" title="码段类型">
									<option value="1" <c:if test="${segment.segmentType == '1'}">selected</c:if>>分类码</option>
									<option value="2" <c:if test="${segment.segmentType == '2'}">selected</c:if>>流水码</option>
									<option value="3" <c:if test="${segment.segmentType == '3'}">selected</c:if>>日期码</option>
									<option value="4" <c:if test="${segment.segmentType == '4'}">selected</c:if>>输入码</option>
									<option value="5" <c:if test="${segment.segmentType == '5'}">selected</c:if>>固定值</option>
									<option value="6" <c:if test="${segment.segmentType == '6'}">selected</c:if>>函数值</option>
									<option value="7" <c:if test="${segment.segmentType == '7'}">selected</c:if>>SQL语句</option>
									<option value="8" <c:if test="${segment.segmentType == '8'}">selected</c:if>>Rest服务</option>

								</select>
							</td>
							<th width="5%" style="white-space:nowrap;">
								<i class="required">*</i>
								<label for="segmentValue">通用编码</label>
							</th>
							<td width="16%">
								<div id="vlookupCode_1" class="input-group input-group-sm avicselect">
                                    <input class="form-control input-sm" type="text" id="segmentCode_${status.index + 1}" name="segmentCode" title="通用编码" value="${segment.segmentCode}"/>
									<input type="hidden" name="segmentValue" id="segmentValue_${status.index + 1}" value="${segment.segmentValue}">
									<input type="hidden" name="vlookupCodeTypeId" id="vlookupCodeTypeId_${status.index + 1}" value="${segment.lookupCodeTypeId}">
									<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
								</div>

							</td>
							<%--插入一列，存放起始值--%>
							<th width="5%" style="white-space:nowrap;">
									<%--<label for="valueStart">起始值</label>--%>
							</th>

							<td width="5%" >
									<%--<input class="form-control input-sm valueStart" type="text" id="valueStart_1" name="valueStart"/>--%>
							</td>
							<th width="5%" style="white-space:nowrap;">
								<label for="autoCodeEditFlag">可编辑</label>
							</th>
							<td width="10%">
								<select class="form-control input-sm autoCodeEditFlag" id="autoCodeEditFlag_${status.index + 1}" name="autoCodeEditFlag" title="可编辑">
									<option value="1" <c:if test="${segment.autoCodeEditFlag == '1'}">selected</c:if>>可</option>
									<option value="2" <c:if test="${segment.autoCodeEditFlag == '2'}">selected</c:if>>否</option>
									<option value="3" <c:if test="${segment.autoCodeEditFlag == '3'}">selected</c:if>>不可见</option>
								</select>
							</td>
							<th width="5%" style="white-space:nowrap;">
								<label for="autoIncreaseFlag">关联流水码</label>
							</th>
							<td width="8%" style="white-space:nowrap;">
								<select class="form-control input-sm autoIncreaseFlag" id="autoIncreaseFlag_${status.index + 1}" name="autoIncreaseFlag" title="关联流水码">
									<option value="Y" <c:if test="${segment.autoIncreaseFlag == 'Y'}">selected</c:if>>是</option>
									<option value="N" <c:if test="${segment.autoIncreaseFlag == 'N'}">selected</c:if>>否</option>
								</select>
							</td>
							<td width="13%" style="white-space:nowrap;padding-left:1%">
								<input type="hidden" id="segmentOrder_${status.index + 1}"  name="segmentOrder" value="${segment.segmentOrder}"/>
								<input type="hidden" id="segmentId_${status.index + 1}" name="id" value="${segment.id}" />
								<input type="hidden" id="sysAutoCodeId_${status.index + 1}" name="sysAutoCodeId" value="${segment.sysAutoCodeId}" />
								<a id="segmentAdd_${status.index + 1}" href="javascript:void(0)"  class="btn btn-sm form-tool-btn segmentAdd" style="min-width: 30px;padding:0 5px;" role="button" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
								<a id="segmentDel_${status.index + 1}" href="javascript:void(0)"  class="btn btn-sm form-tool-btn segmentDel" style="min-width: 30px;padding:0 5px;" role="button" title="删除"><span class="glyphicon glyphicon-minus"></span></a>
								<a id="segmentUp_${status.index + 1}" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentUp" style="min-width: 30px;padding:0 5px;" role="button" title="上移"><span class="glyphicon glyphicon-arrow-up"></span></a>
								<a id="segmentDown_${status.index + 1}" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentDown" style="min-width: 30px;padding:0 5px;" role="button" title="下移"><span class="glyphicon glyphicon-arrow-down"></span></a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 50px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="height: 50px;">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 97%; margin:0px 20px">
				<tr>
					<td  style="padding-left: 0%;height: 38px;" align="left"  >
						<div id="previewContent" style="display: none"></div>
					</td>
					<td style="height: 38px; width:20%;white-space:nowrap;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="预览" id="sysAutoCode_preview">预览</a> 
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysAutoCode_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"id="sysAutoCode_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/autocode/js/SysAutoCode.js" type="text/javascript"></script>
	<script src="avicit/platform6/autocode/table/select.js" type="text/javascript"></script>
	<style type="text/css">
		.error{
			background:#FFF7FA;
			border:1px solid #CE7979;
			color:#F00;
		}
	</style>
	<script type="text/javascript">
	var trHtml;
	
		$(document).ready(function () {
			trHtml = $("#segmentTr_1").html();
			parent.sysAutoCode._oldSegmentDivHeight = $("#codeSegmentForm").find(".panel").height();
            parent.sysAutoCode._validateSegmentResult = true;
			parent.sysAutoCode._validateSegmentFormResult = true;

            //绑定事通用代码下拉
            $("#segmentCode_1,#vlookupCode_1>span").off("click").on("click", function (event) {
                new LookupTypeSelect({type:'lookupSelect', idFiled:$('#segmentValue_1'),textFiled:$('#segmentCode_1')});
            });

			//添加验证规则：字母数字下划线
			jQuery.validator.addMethod("alnum", function(value, element){
				return this.optional(element) ||/^[a-zA-Z0-9_]+$/.test(value);
			}, "只能输入英文,数字,下划线");

            //添加验证规则：绑定表和绑定字段如果填写一个，则必须填写另一个
            jQuery.validator.addMethod("together", function(value, element){
                var returnVal = true;
                if($("#columnName").val()!="" && $("#tableName").val()=="")
                    returnVal = false;
                return returnVal;
            }, "必须同时填写绑定表和绑定字段");

            jQuery.validator.addMethod("together2", function(value, element){
                var returnVal = true;
                if($("#tableName").val()!="" && $("#columnName").val()=="")
                    returnVal = false;
                return returnVal;
            }, "必须同时填写绑定表和绑定字段");
			
			parent.sysAutoCode.formValidate($('#codeForm'),"update");
			//保存按钮绑定事件
			$('#sysAutoCode_saveForm').bind('click', function(){
				var isValidate = $("#codeForm").validate();
				if (!isValidate.checkForm()) {
					isValidate.showErrors();
					return false;
				}

				//明细校验
				parent.sysAutoCode.validateSegmentForm($('#codeSegmentForm'));
				if(parent.sysAutoCode._validateSegmentResult && parent.sysAutoCode._validateSegmentFormResult){
						parent.sysAutoCode.update($('#codeForm'),$('#codeSegmentForm'),window.name);
				}
			}); 

			//返回按钮绑定事件
			$('#sysAutoCode_closeForm').bind('click', function(){
				parent.sysAutoCode.closeDialog(window.name);
			});

			//预览按钮绑定事件
			$('#sysAutoCode_preview').on('click', function(){
				parent.sysAutoCode.validateSegmentForm($('#codeSegmentForm'));
				if(parent.sysAutoCode._validateSegmentResult && parent.sysAutoCode._validateSegmentFormResult){
						parent.sysAutoCode.preview($('#codeSegmentForm'), $('#previewContent'));
				}
			});

			//邦定添加按钮
			$(".segmentAdd").on("click", function (event) {
				parent.sysAutoCode.addTr(event, trHtml, $("#codeSegmentForm"));
			});

			//邦定删除按钮
			$(".segmentDel").on("click", function (event) {
				parent.sysAutoCode.delTr(event);
			});

			//邦定向上按钮
			$(".segmentUp").on("click", function (event) {
				parent.sysAutoCode.upTr(event);
			});

			//邦定向下按钮
			$(".segmentDown").on("click", function (event) {
				parent.sysAutoCode.downTr(event);
			});

			//邦定编码类型字段onchange事件
			$(".segmentType").on("change", function (event, initFlag) {
				parent.sysAutoCode.layoutSetting(event,initFlag,$("#codeSegmentForm"));
			});
            $(".segmentType").trigger("change",true);


		});

		var selectTable = new SelectTable("tableId", "tableName");
		selectTable.init(function (data) {
			var tableId = data.id;
			var tableName = data.name;

			if (tableId != "" && tableName != "") {
				$("#columnId").val("");
				$("#columnName").val("");

				var selectTableColumn = new SelectTableColumn("columnId", "columnName", tableName);
				selectTableColumn.init(function (data) {
					//alert(data.name);
				});
			}
		});

		if ("${code.tableName}" != "" && "${code.columnName}" != "") {
			var selectTableColumn = new SelectTableColumn("columnId", "columnName", "${code.tableName}");
			selectTableColumn.init(function (data) {
				//alert(data.name);
			});
		}
	</script>
</body>
</html>