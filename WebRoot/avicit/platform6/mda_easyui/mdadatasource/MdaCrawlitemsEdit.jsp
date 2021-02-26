<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "mdaDatasourceEasyUIController/operation/sub/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
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
		if (!"${mdaCrawlitemsDTO.createtime}" == "") {
			$('#createtime').datebox(
					'setValue',
					parserColumnTime("${mdaCrawlitemsDTO.createtime}").format(
							"yyyy-MM-dd"));
		}
		if (!"${mdaCrawlitemsDTO.lastmodifytime}" == "") {
			$('#lastmodifytime').datebox(
					'setValue',
					parserColumnTime("${mdaCrawlitemsDTO.lastmodifytime}")
							.format("yyyy-MM-dd"));
		}
		if (!"${mdaCrawlitemsDTO.lasttimecrawl}" == "") {
			$('#lasttimecrawl').datebox(
					'setValue',
					parserColumnTime("${mdaCrawlitemsDTO.lasttimecrawl}")
							.format("yyyy-MM-dd"));
		}
		var lastcrawluseridUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "lastcrawluserid", "lastcrawluseridAlias");
		lastcrawluseridUserCommonSelector.init();
	})
	function closeForm() {
		parent.mdaCrawlitems.closeDialog("#edit");
	};
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
			$('#saveButton').linkbutton('disable').unbind("click");
			parent.mdaCrawlitems.save(serializeObject($('#form')), "#edit");
		}
	};
	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id"
				value='<c:out  value='${mdaCrawlitemsDTO.id}'/>' /> <input
				type="hidden" name="version"
				value='<c:out  value='${mdaCrawlitemsDTO.version}'/>' /> <input
				type="hidden" name="datasrcid"
				value='<c:out  value='${mdaCrawlitemsDTO.datasrcid}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						style="color: red;">*</span>数据源配置项:</th>
					<td width="39%"><input title="NAME"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[32]',required:true" style="width: 99%;"
						type="text" name="name" id="name"
						value='<c:out  value='${mdaCrawlitemsDTO.name}'/>' /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						创建时间:</th>
					<td width="39%"><input title="CREATETIME"
						class="easyui-datebox" editable="false" style="width: 99%;"
						type="text" name="createtime" id="createtime"
						value='<c:out  value='${mdaCrawlitemsDTO.createtime}'/>' /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						最后修改时间:</th>
					<td width="39%"><input title="LASTMODIFYTIME"
						class="easyui-datebox" editable="false" style="width: 99%;"
						type="text" name="lastmodifytime" id="lastmodifytime"
						value='<c:out  value='${mdaCrawlitemsDTO.lastmodifytime}'/>' /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						最后爬取时间:</th>
					<td width="39%"><input title="LASTTIMECRAWL"
						class="easyui-datebox" editable="false" style="width: 99%;"
						type="text" name="lasttimecrawl" id="lasttimecrawl"
						value='<c:out  value='${mdaCrawlitemsDTO.lasttimecrawl}'/>' /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						最后爬取用户:</th>
					<td width="39%"><input title="LASTCRAWLUSERID" class="inputbox" 
						style="width: 99%;" type="hidden" name="lastcrawluserid" id="lastcrawluserid"
						value='${mdaCrawlitemsDTO.lastcrawluserid}' />
						<div class="">
							<input class="easyui-validatebox" type="text" title="LASTCRAWLUSERID" 
								name="lastcrawluseridAlias" id="lastcrawluseridAlias" readOnly="readOnly"
								value='<c:out  value='${mdaCrawlitemsDTO.lastcrawluseridAlias}'/>'></input>
						</div></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						采集类型:</th>
					<td width="39%"><pt6:syslookup name="itemtype" id="itemtype"
							title="itemtype" isNull="true" lookupCode="MDA_ITEMTYPE" defaultValue='${mdaCrawlitemsDTO.itemtype}'
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						分类:</th>
					<td width="39%"><input title="CLASSIFYIDS"
						class="inputbox easyui-validatebox" readonly
						data-options="validType:'maxLength[50]'" style="width: 99%;"
						type="text" name="classifyids" id="classifyids"
						value='<c:out  value='${mdaCrawlitemsDTO.classifyids}'/>' /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">
						状态:</th>
					<td width="39%"><pt6:syslookup name="status" id="status"
							title="zhuangtai" isNull="true" lookupCode="MDA_STATUS" defaultValue='${mdaCrawlitemsDTO.status}'
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
				
			</table>
		</form>

	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>