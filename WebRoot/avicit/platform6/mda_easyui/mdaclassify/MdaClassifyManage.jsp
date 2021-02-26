<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "train/demo/mdaclassify/mdaClassifyController/toMdaClassifyManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/mda_easyui/mdaclassify/js/MdaClassify.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mdaClassify;
	$(function() {
		mdaClassify = new MdaClassify('tree', '${url}', 'form','searchWord');
		mdaClassify.setOnLoadSuccess(function() {
		});
		mdaClassify.setOnSelect(function(_tree, node) {
		});
		mdaClassify.init();
	});
	function saveForm() {
		var textareaElement = $('#form').find("textarea");
		var hasvalidate = true;
		if (textareaElement.length > 0) {
			$.each(
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
			mdaClassify.save(serializeObject($('#form')), '${url}',
					'#insert', $("#parentId").val());
		}
	}
	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'west',split:true,title:''"
		style="width: 250px; padding: 0px;">
		<div id="toolbar" class="datagrid-toolbar">
			<table width="100%">
				<tr>
					<td width="100%"><input type="text" name="searchWord"
						id="searchWord"></input></td>
				</tr>
			</table>
		</div>
		<ul id="tree">正在加载数据...
		</ul>
	</div>
	<div data-options="region:'center',split:true,title:'操作'"
		style="padding: 0px; overflow: auto;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height: 40px;">
				<div id="toolbarImportResult" class='datagrid-toolbar'>
					<table>
						<tr>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_mdaClassify_save_"
								permissionDes="保存">
								<td><a class="easyui-linkbutton" iconCls="icon-save"
									plain="true" onclick="saveForm();"
									href="javascript:void(0);">保存</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_mdaClassify_insert_"
								permissionDes="添加平级节点">
								<td><a class="easyui-linkbutton" iconCls="icon-add"
									plain="true" onclick="mdaClassify.insert();"
									href="javascript:void(0);">添加平级节点</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_mdaClassify_insertsub_"
								permissionDes="添加子节点">
								<td><a class="easyui-linkbutton" iconCls="icon-add_other"
									plain="true" onclick="mdaClassify.insertSub();"
									href="javascript:void(0);">添加子节点</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_mdaClassify_del_" permissionDes="删除">
								<td><a class="easyui-linkbutton" iconCls="icon-remove"
									plain="true" onclick="mdaClassify.del();"
									href="javascript:void(0);">删除</a></td>
							</sec:accesscontrollist>
						</tr>
					</table>
				</div>
			</div>
			<div data-options="region:'center',split:true">
				<form id='form'>
					<input type="hidden" name="id" id="id" />
					<input type="hidden" name="version" id="version" /> 
					<input type="hidden" name="parentId" id="parentId" />
					<table class="form_commonTable" width="100%">
						<tr>
							<th width="10%"><span class="remind">*</span><label for="name">名称:</label></th>
							<td width="39%"><input class="easyui-validatebox"
								type="text" name="name" id="name" 
								data-options="validType:'maxLength[32]',required:true" /></td>
							<th width="10%"><label for="status">状态:</label></th>
							<td width="39%"><pt6:syslookup name="status" id="status"
							title="STATUS" isNull="true" lookupCode="MDA_STATUS" defaultValue=""
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
						<tr>
							<th width="10%"><label for="time">时间:</label></th>
							<td width="39%">
								<div class="input-group input-group-sm">
									<input class="easyui-datebox" type="text" name="time"
										id="time" /><span class="input-group-addon"><i
										class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>