<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>edittree</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {
		maxLength : {
			validator : function(value, param) {
				if (param[0] == 0) {
					param[0] = 13;
				}
				return param[0] >= value.replace(/[^\x00-\xff]/g, "**").length; //计算字符串长度（可同时字母和汉，字母占一个字符，汉字占两个字符）
			},
			message : '请输入最多 {0} 字符.'
		},
		extendsIsNull : {
			validator : function(value) {
				return value != "请选择";
			},
			message : '该输入项为必输项.'
		}
	});
	$(function() {

	});
	function closeForm() {
		parent.mdaClassify.closeDialog("#insert");
	}
	function saveForm() {
		var textareaElement = $('#form').find("textarea");
		var hasvalidate = true;
		if (textareaElement.length > 0) {
			$
					.each(
							textareaElement,
							function(i, item) {
								var dataSize = $(item).data('size');
								var textareaValue = $(item).val();
								if (textareaValue != null
										&& textareaValue != ""
										&& textareaValue.replace(
												/[^\x00-\xff]/g, "**").length > dataSize) {
									$.messager.alert('提示', '文本域输入数据长度超过预设长度'
											+ dataSize, 'info', function() {
										document.getElementById(item.id)
												.focus();
									});
									hasvalidate = false;
									return;
								}
							});
		}
		var tdLabel = $('#form').find('[data-isnull="false"]');
		var textareaId = "";
		$.each(tdLabel, function(i, item) {
			var dataIsNull = $(item).data('isnull');
			var hasChecked = false;
			$(item).find("input").each(function(i, obj) {
				if ($(obj).is(':checked')) {
					hasChecked = true;
				}
			});

			$(item).find("textarea").each(function(i, obj) {
				if ($(obj).val().length > 0) {
					hasChecked = true;
				} else {
					textareaId = obj.id;
				}
			});

			if (!hasChecked) {
				$.messager.alert('提示', '请输入必填项', 'info', function() {
					if (textareaId != "") {
						document.getElementById(textareaId).focus();
					}
				});
				hasvalidate = false;
				return false;
			}
		});
		//checkbox字段长度验证
		var checkboxElement = $('#form').find('[data-type="checkbox"]');
		$.each(checkboxElement, function(i, item) {
			var datasize = $(item).data('length');
			var hasLength = true;
			var lgth = 0;
			$(item).find("input[type=checkbox]").each(function(i, obj) {
				if ($(obj).is(':checked')) {
					lgth = lgth + 1;
				}
				if (2 * lgth - 1 > datasize) {
					hasLength = false;
				}
			});
			if (!hasLength) {
				$.messager.alert('提示', '多选输入数据长度超过预设长度' + datasize, 'info');
				hasvalidate = false;
				return;
			}
		});
		if ($('#form').form('validate') == false) {
			return;
		}
		if (hasvalidate) {
			$('#saveButton').linkbutton('disable').unbind("click");
			parent.mdaClassify.save(serializeObject($('#form')), '${url}',
					'#insert', '${id}');
		}
	}

	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>


					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span> NAME:</th>
					<td width="39%"><input title="NAME" class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[32]'"
						style="width: 99%;" type="text" name="name" id="name" /></td>



					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						STATUS:</th>
					<td width="39%"><pt6:syslookup name="status" id="status"
							title="STATUS" isNull="true" lookupCode="PLATFORM_VALID_FLAG"
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
				<tr>



					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">TIME:</th>
					<td width="39%"><input title="TIME" class="easyui-datebox"
						editable="false" style="width: 99%;" type="text" name="time"
						id="time" /></td>



					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						CLASS_INDEX_TREE_NO:</th>
					<td width="39%"><input title="CLASS_INDEX_TREE_NO"
						class="easyui-validatebox"
						data-options="validType:'maxLength[255]'" style="width: 99%;"
						type="text" name="classIndexTreeNo" id="classIndexTreeNo" /></td>
				</tr>
				<tr>


				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="60%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" plain="false"
						onclick="saveForm();" href="javascript:void(0);">保存</a> <a
						title="返回" id="returnButton" class="easyui-linkbutton"
						plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>