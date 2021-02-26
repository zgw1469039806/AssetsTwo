<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "train/form/sysautocode/sysAutoCodeController/operation/Add/null" -->
<title>新增编码</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="codeForm" style="margin:20px 20px">
			<input type="hidden" name="id" />
			<div class="panel panel-default panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">基本信息</h3>
				</div>
				<div class="panel-body">
					<table class="form_commonTable" style="margin-bottom:10px">
						<tr style="height: 50px">
							<th width="8%" style="white-space:nowrap;">
								<label for="code">编码代码</label>
							</th>
							<td width="14%">
								<input class="form-control input-sm" type="text" name="code" id="code" title="编码代码"/>
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="name">编码名称</label>
							</th>
							<td width="14%">
								<input class="form-control input-sm" type="text" name="name" id="name" title="编码名称"/>
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="tableName">绑定表</label>
							</th>
							<td width="14%">
								<input type="hidden" id="tableId" name="tableId">
								<input type="text" id="tableName" name="tableName" class="form-control" readonly>
							</td>
							<th width="8%" style="white-space:nowrap;">
								<label for="columnName">绑定字段</label>
							</th>
							<td width="14%">
								<input type="hidden" id="columnId" name="columnId">
								<input type="text" id="columnName" name="columnName" class="form-control" readonly>
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
				<table class="table-striped form_commonTable" style="position:relative;width: 97%;margin:0 20px;" id="segmentTable">
						<tr id="segmentTr_1" style="position:relative;height: 50px;">
							<th width="5%" style="white-space:nowrap;">
								<label for="segmentType">码段类型</label>
							</th>
							<td width="12%">
								<select class="form-control input-sm segmentType" id="segmentType_1" name="segmentType" title="码段类型">
									<option value="1">分类码</option>
									<option value="2">流水码</option>
									<option value="3">日期码</option>
									<option value="4">输入码</option>
									<option value="5">固定值</option>
									<option value="6">函数值</option>
									<option value="7">SQL语句</option>
									<option value="8">Rest服务</option>
								</select>
							</td>
							<th width="5%" style="white-space:nowrap;">
								<i class="required">*</i>
								<label for="segmentValue">通用编码</label>
							</th>
							<td width="16%">
								<div id="vlookupCode_1" class="input-group input-group-sm avicselect">
									<input class="form-control input-sm" type="text" id="segmentCode_1" name="segmentCode" title="通用编码"/>
									<input type="hidden" name="segmentValue" id="segmentValue_1">
									<input type="hidden" name="vlookupCodeTypeId" id="vlookupCodeTypeId_1">
            						<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
								</div>
							</td>
							<%--插入起始值项--%>
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
								<select class="form-control input-sm autoCodeEditFlag" id="autoCodeEditFlag_1" name="autoCodeEditFlag" title="可编辑">
									<option value="1">可</option>
									<option value="2">否</option>
									<option value="3">不可见</option>
								</select>
							</td>
							<th width="5%" style="white-space:nowrap;">
								<label for="autoIncreaseFlag">关联流水码</label>
							</th>
							<td width="8%">
								<select class="form-control input-sm autoIncreaseFlag" id="autoIncreaseFlag_1" name="autoIncreaseFlag" title="关联流水码">
									<option value="Y">是</option>
									<option value="N">否</option>
								</select>
							</td>
							<td width="13%" style="white-space:nowrap;padding-left:1%">
								<input type="hidden" name="segmentOrder" id="segmentOrder_1" value="1"/>
								<a id="segmentAdd_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentAdd" style="min-width: 30px;padding:0 5px;" role="button" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
								<a id="segmentDel_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentDel" style="min-width: 30px;padding:0 5px;" role="button" title="删除"><span class="glyphicon glyphicon-minus"></span></a>
								<a id="segmentUp_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentUp" style="min-width: 30px;padding:0 5px;" role="button" title="上移"><span class="glyphicon glyphicon-arrow-up"></span></a>
								<a id="segmentDown_1" href="javascript:void(0)" class="btn btn-sm form-tool-btn segmentDown" style="min-width: 30px;padding:0 5px;" role="button" title="下移"><span class="glyphicon glyphicon-arrow-down"></span></a>
							</td>
						</tr>
				</table>
			</div>
		</form>

	</div>
	<div data-options="region:'south',border:false" style="height: 50px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="height: 50px;">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 97%; margin:0px 20px">
				<tr>
					<td  style="padding-left: 0%;height: 38px;" align="left">
						<div id="previewContent" style="display: none"></div>
					</td>
					<td style="height: 38px; width:20%;white-space:nowrap;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="预览" id="sysAutoCode_preview">预览</a>
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="保存" id="sysAutoCode_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysAutoCode_closeForm">返回</a>
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
			$("#codeSegmentForm").find(".panel").height($(window).height() - $("#codeForm").outerHeight(true) - 70);
			parent.sysAutoCode._oldSegmentDivHeight = $("#codeSegmentForm").find(".panel").height();

            //绑定事通用代码下拉
            $("#segmentCode_1,#vlookupCode_1>span").off("click").on("click", function (event) {
                new LookupTypeSelect({type:'lookupSelect',idField:$("#vlookupCodeTypeId_1"),codeField:$('#segmentValue_1'),textField:$('#segmentCode_1'), callBack: function(rowdata){
                        $("#segmentCode_1").val(rowdata.lookupTypeName);
                        $("#segmentValue_1").val(rowdata.lookupType);
                        $("#vlookupCodeTypeId_1").val(rowdata.id);
                    }
                });
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

			parent.sysAutoCode.formValidate($('#codeForm'),"add");

			//保存按钮绑定事件
			$('#sysAutoCode_saveForm').on('click', function(){
				var isValidate = $("#codeForm").validate();
				if (!isValidate.checkForm()) {
					isValidate.showErrors();
					return false;
				}

				//明细校验
				parent.sysAutoCode.validateSegmentForm($('#codeSegmentForm'));
				if(parent.sysAutoCode._validateSegmentResult && parent.sysAutoCode._validateSegmentFormResult){
					parent.sysAutoCode.save($('#codeForm'),$('#codeSegmentForm'),window.name);
				}
			});

			//返回按钮绑定事件
			$('#sysAutoCode_closeForm').on('click', function(){
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
			$(".segmentType").on("change", function (event,initFlag) {
				parent.sysAutoCode.layoutSetting(event,initFlag,$("#codeSegmentForm"));
			});

			//邦定编码字段onchange事件
			$(".segmentValue").on("change", function (event) {
				parent.sysAutoCode.validateSegmentValue(event);
			});

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
	</script>
</body>
</html>