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
<!-- ControllerPath = "platform6/bpmreform/bpmdesigner/bpmbuttonext/bpmButtonExtController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			 <input
				type="hidden" name="id"
				value="<c:out  value='${bpmButtonExt.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="code">编码:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="code" id="code"
						value="<c:out  value='${bpmButtonExt.code}'/>"
						<c:if test="${bpmButtonExt.isPlatform eq 1}">disabled</c:if>/></td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="dName">默认名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="dName" id="dName"
						value="<c:out  value='${bpmButtonExt.dName}'/>"
						<c:if test="${bpmButtonExt.isPlatform eq 1}">disabled</c:if>/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="name">自定义名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="name" id="name"
						value="<c:out  value='${bpmButtonExt.name}'/>" /></td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="order">排序:</label>
					</th>
					<td width="39%">
						<div class="input-group input-group-sm spinner"
							data-trigger="spinner">
							<input class="form-control" type="text" name="order"
								id="order"
								value="<c:out  value='${bpmButtonExt.order}'/>"
								data-min="-<%=Math.pow(10,11)-Math.pow(10,-0)%>"
								data-max="<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-step="1"
								data-precision="0"> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
									class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
									class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="jsfunction">js方法名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="jsfunction" id="jsfunction"
						value="<c:out  value='${bpmButtonExt.jsfunction}'/>"
						<c:if test="${bpmButtonExt.isPlatform eq 1}">disabled</c:if>/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isGlobal">是否全局按钮:</label>
					</th>
					<td width="39%">
						<select id="isGlobal" name="isGlobal" class="form-control input-sm" title=""
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isGlobal}'/>"
							<c:if test="${bpmButtonExt.isPlatform eq 1}">disabled</c:if>>
						  <option value="1" <c:if test="${bpmButtonExt.isGlobal eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isGlobal eq 0}">selected</c:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isPlatform">是否平台按钮:</label>
					</th>
					<td width="39%">
						<select id="isPlatform" name="isPlatform" class="form-control input-sm" title=""
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isPlatform}'/>" disabled>
						  <option value="0" <c:if test="${bpmButtonExt.isPlatform eq 0}">selected</c:if>>否</option>
						  <option value="1" <c:if test="${bpmButtonExt.isPlatform eq 1}">selected</c:if>>是</option>
						</select>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isDesign">是否在流程设计器中配置:</label>
					</th>
					<td width="39%">
						<select id="isDesign" name="isDesign" class="form-control input-sm"
						title="" data-options="" style="" value="<c:out  value='${bpmButtonExt.isDesign}'/>"
						<c:if test="${bpmButtonExt.isPlatform eq 1}">disabled</c:if>>
						  <option value="1" <c:if test="${bpmButtonExt.isDesign eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isDesign eq 0}">selected</c:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<%--<th width="10%"><label for="isCommonly">是否常用按钮:</label></th>
					<td width="39%">
						<select id="isCommonly" name="isCommonly" class="form-control input-sm" title=""
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isCommonly}'/>">
						  <option value="1" <c:if test="${bpmButtonExt.isCommonly eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isCommonly eq 0}">selected</c:if>>否</option>
						</select>
					</td>--%>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="icon">图标样式:</label>
					</th>
					<td width="39%">
						<div id="iconselect" class="input-group input-group-sm avicselect">
							<input class="form-control input-sm"
								   type="text" name="icon" id="icon"
								   value="<c:out  value='${bpmButtonExt.icon}'/>"
							/>
							<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>
						</div>
						</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="desc">描述:</label>
					</th>
					<td colspan="3">
						<textarea class="form-control input-sm" rows="3" title="" name="desc" id="desc"><c:out  value='${bpmButtonExt.desc}'/></textarea>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="bpmButtonExt_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="bpmButtonExt_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		function closeForm() {
			parent.bpmButtonExt.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			//限制保存按钮多次点击
			$('#bpmButtonExt_saveForm').addClass('disabled').unbind("click");
			parent.bpmButtonExt.save($('#form'), "eidt");
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
				beforeShow : function(selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						$(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
					}
				}
			});

			parent.bpmButtonExt.formValidate($('#form'));
			var isPlatform = $("#isPlatform").val();
			if(isPlatform=='0'){
				var $jsfunction = $("#jsfunction");
				$jsfunction.rules("add",{required:true});
				var $tagLabel = $('label[for="jsfunction"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}
			//保存按钮绑定事件
			$('#bpmButtonExt_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#bpmButtonExt_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);

			var code = $("#code").val();
			if(code.endWith("_mesh")){
				$("#isCommonly").attr("disabled","disabled");
				$("#order").attr("disabled","disabled");
			}
		});

		var lay_select_icon;

		function setIconInfo(data) {
			$("#icon").val(data.icon);
			layer.close(lay_select_icon);
		}

		$(function () {

			//添加验证规则
			jQuery.validator.addMethod("lowerCase", function(value, element){
				if(value){
					return /^[a-z_]+$/.test(value);
				} else {
					return true;
				}
			}, "只能输入小写英文、下划线");

			$("#iconselect").on("click", function() {
				var contentWidth = 620;
				var top = $("#icon").offset().top + $("#icon").outerHeight(true);
				var left = $("#icon").offset().left + $("#icon").outerWidth() - contentWidth;
				var width = $("#icon").innerWidth();

				var selectIconIndex="static/h5/selectIcon/index.html";

				lay_select_icon = layer.open({
					type: 2,
					shift: 5,
					title: false,
					scrollbar: false,
					move: false,
					area: [contentWidth + 'px', '250px'],
					offset: [top + 'px', left + 'px'],
					closeBtn: 0,
					shadeClose: true,
					content: selectIconIndex,
					success: function(layero, index) {
						var serachLabel = $('<div class="serachLabel"><span>请选择</span><span class="caret"></span></div>').appendTo(layero);
						serachLabel.on('click', function() {
							layer.close(index);
						});
						serachLabel.css('width', width + 'px');
					}
				});
			});
		});

		 String.prototype.endWith=function(endStr){
		      var d=this.length-endStr.length;
		      return (d>=0&&this.lastIndexOf(endStr)==d)
		    }
	</script>
</body>
</html>
