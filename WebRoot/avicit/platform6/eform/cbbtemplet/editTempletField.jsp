<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<!-- <input type="hidden" name="sid" value=""/> -->
				<input type="hidden" id="id" name="id" value="${cbbTempletField.id}">
				<input type="hidden" id="sysApplicationId" name="sysApplicationId" value="${appId}">
				<input type="hidden" id="sysId" name="sysId" value="${appId}">
				<input type="hidden" id="secretLevel" name="secretLevel" value="${secretLevel}">
				<input type="hidden" id="templetId" name="templetId" value="${templetId}">
				<fieldset>
				<legend>基本信息</legend>
				<table class="form_commonTable">
					<tr>
						<th width="10%"><span class="remind">*</span>字段中文名称:</th>
						<td width="40%">
							<input id="colLabel"  name="colLabel" class="easyui-validatebox" 
							data-options="required:true,validType:['isBlank','length[0,32]']" value="${cbbTempletField.colLabel}" onblur="getPinyin()">
						</td>
						<th width="10%"><span class="remind">*</span>字段英文名称:</th>
						<td width="40%">
							<input id="colName"  name="colName" class="easyui-validatebox"
							data-options="required:true,validType:['isBlank','length[0,32]','isLegal']" value="${cbbTempletField.colName}" onkeyup="upperCase(this)">
							<br><font color=red>(建议英文数字下划线组合方式)</font>
						</td>
					</tr>
					<tr>
						<th rowspan="2"><span class="remind">*</span>字段类型:</th>
						<td rowspan="2"><select name="colType" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="VARCHAR2" <c:if test="${cbbTempletField.colType eq 'VARCHAR2'}">SELECTED</c:if>>字符串</option>
								<option value="DATE" <c:if test="${cbbTempletField.colType eq 'DATE'}">SELECTED</c:if>>日期时间</option>
								<option value="NUMBER" <c:if test="${cbbTempletField.colType eq 'NUMBER'}">SELECTED</c:if>>数字型</option>
								<option value="BLOB" <c:if test="${cbbTempletField.colType eq 'BLOB'}">SELECTED</c:if>>二进制大对象</option>
								<option value="CLOB" <c:if test="${cbbTempletField.colType eq 'CLOB'}">SELECTED</c:if>>字符大对象</option>
						</select></td>

						<th><span class="remind">*</span>字段长度:</th>
						<td><input name="colLength" class="easyui-validatebox"
							data-options="required:true,validType:['isBlank','length[0,32]']"   value="${cbbTempletField.colLength}">
						</td>
					</tr>
					<tr>
						<th>小数位数:</th>
						<td><input name="attribute02" class="easyui-validatebox"
							value="${cbbTempletField.attribute02}"></td>
					</tr>
					<tr>
						<th><span class="remind">*</span>字段顺序:</th>
						<td><input name="colOrder" class="easyui-validatebox"
							data-options="required:true,validType:['isBlank','length[0,32]']"   value="${cbbTempletField.colOrder}"></td>
						<th><span class="remind">*</span>时间格式:</th>
						<td>
							<select name="attribute03" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="1" <c:if test="${cbbTempletField.attribute03 eq '1'}">SELECTED</c:if>>Y-m-d H:i:s</option>
								<option value="2" <c:if test="${cbbTempletField.attribute03 eq '2'}">SELECTED</c:if>>Y-m-d</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><span class="remind">*</span>元素类型:</th>
						<td><select name="elementType" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" value="${cbbTempletField.elementType}">
								<option value="text" <c:if test="${cbbTempletField.elementType eq 'text'}">SELECTED</c:if>>text</option>
								<option value="textarea" <c:if test="${cbbTempletField.elementType eq 'textarea'}">SELECTED</c:if>>textarea</option>
								<option value="radio" <c:if test="${cbbTempletField.elementType eq 'radio'}">SELECTED</c:if>>radio</option>
								<option value="checkbox" <c:if test="${cbbTempletField.elementType eq 'checkbox'}">SELECTED</c:if>>checkbox</option>
						</select></td>
						<th><span class="remind">*</span>是否显示:</th>
						<td><select name="colIsVisible" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsVisible}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsVisible}">SELECTED</c:if>>否</option>
						</select></td>
					</tr>
					<tr>
						<th><span class="remind">*</span>是否查询字段:</th>
						<td><select name="colIsSearch" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y"  <c:if test="${'Y' eq cbbTempletField.colIsSearch}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsSearch}">SELECTED</c:if>>否</option>
						</select></td>
						<th><span class="remind">*</span>是否必填:</th>
						<td><select name="colIsMust" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsMust}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsMust}">SELECTED</c:if>>否</option>
						</select></td>
					</tr>
					<tr>
						<th>是否列表显示:</th>
						<td><select id="colIsTabVisible" name="colIsTabVisible"
							class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsTabVisible}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsTabVisible}">SELECTED</c:if>>否</option>
						</select></td>
						<th>是否详细显示:</th>
						<td><select name="colIsDetail" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsDetail}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsDetail}">SELECTED</c:if>>否</option>
						</select></td>
					</tr>

					<tr>
						<th>生成规则英文:</th>
						<td><select name="colRuleName" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" value="${cbbTempletField.colRuleName}">
								<option value="" <c:if test="${cbbTempletField.colRuleName eq ''}">SELECTED</c:if>>无</option>
								<option value="user" <c:if test="${cbbTempletField.colRuleName eq 'user'}">SELECTED</c:if>>user</option>
								<option value="dept" <c:if test="${cbbTempletField.colRuleName eq 'dept'}">SELECTED</c:if>>dept</option>
						</select></td>
						<th>生成规则中文:</th>
						<td><input name="colRuleTitle" class="easyui-validatebox"
							required="true" value="${cbbTempletField.colRuleTitle}"></td>
					</tr>

				</table>
			</fieldset>


			<fieldset>
				<legend>扩展信息</legend>
				<table class="form_commonTable">
					<tr>
						<th width="10%">路径:</th>
						<td width="40%">
							<input name="customPath" class="easyui-validatebox" value="${cbbTempletField.customPath}">
						</td>
						<th width="10%">说明:</th>
						<td width="40%">
							<input name="remark" class="easyui-validatebox"  value="${cbbTempletField.remark}">
						</td>
					</tr>
					<tr>
						<th>下拉类型:</th>
						<td><select name="colDropdownType" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"
							 value="${cbbTempletField.colDropdownType}">
								<option value="0" <c:if test="${cbbTempletField.colDropdownType eq '0'}">SELECTED</c:if>>无</option>
								<option value="1" <c:if test="${cbbTempletField.colDropdownType eq '1'}">SELECTED</c:if>>参选</option>
								<option value="2" <c:if test="${cbbTempletField.colDropdownType eq '2'}">SELECTED</c:if>>只选</option>
								<option value="3" <c:if test="${cbbTempletField.colDropdownType eq '3'}">SELECTED</c:if>>选择</option>
						</select></td>
						<th>生成方式:</th>
						<td><select name="colGeneMethod" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" value="${cbbTempletField.colGeneMethod}">
								<option value="0" <c:if test="${cbbTempletField.colGeneMethod eq '0'}">SELECTED</c:if>>空</option>
								<option value="1" <c:if test="${cbbTempletField.colGeneMethod eq '1'}">SELECTED</c:if>>默认值</option>
								<option value="2" <c:if test="${cbbTempletField.colGeneMethod eq '2'}">SELECTED</c:if>>序列</option>
								<option value="3" <c:if test="${cbbTempletField.colGeneMethod eq '3'}">SELECTED</c:if>>顺带</option>
								<option value="4" <c:if test="${cbbTempletField.colGeneMethod eq '4'}">SELECTED</c:if>>组合项</option>
								<option value="5" <c:if test="${cbbTempletField.colGeneMethod eq '5'}">SELECTED</c:if>>统计生成</option>
								<option value="6" <c:if test="${cbbTempletField.colGeneMethod eq '6'}">SELECTED</c:if>>选择</option>
						</select></td>
					</tr>
					<tr>
						<th>生成方式规则:</th>
						<td><input name="colGeneMethodRule" class="easyui-validatebox" value="${cbbTempletField.colGeneMethodRule}"></td>
						<th>显示格式:</th>
						<td><select name="colShowFormat" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" value="${cbbTempletField.colShowFormat}">
								<option value="0" <c:if test="${cbbTempletField.colShowFormat eq '0'}">SELECTED</c:if>>无</option>
								<option value="1" <c:if test="${cbbTempletField.colShowFormat eq '1'}">SELECTED</c:if>>日期</option>
								<option value="2" <c:if test="${cbbTempletField.colShowFormat eq '2'}">SELECTED</c:if>>金额</option>
						</select></td>
					</tr>
					<tr>
						<th>是否可见:</th>
						<td><select name="colIsDisplay" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsDisplay}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsDisplay}">SELECTED</c:if>>否</option>
						</select></td>
						<th>是否编辑字段:</th>
						<td><select name="colIsEdit" class="easyui-combobox"
							data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="Y" <c:if test="${'Y' eq cbbTempletField.colIsEdit}">SELECTED</c:if>>是</option>
							<option value="N" <c:if test="${'N' eq cbbTempletField.colIsEdit}">SELECTED</c:if>>否</option>
						</select></td>
					</tr>
				</table>
			</fieldset>
		</form>
		</div>
		<div data-options="region:'south',border:false" style="height:40px;">	
	<div id="dlg-buttons1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td  align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" onclick="saveForm();" >保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="closeForm();" >返回</a>
				</td>
			</tr>
	</table>
	</div>
</div>
		
	<script type="text/javascript">
	
	$.extend($.fn.validatebox.defaults.rules, {
        isBlank: {
            validator: function (value, param) { return $.trim(value) != '' },
            message: '不能为空，全空格也不行'
        },
        isLegal:{
        	validator: function (value, param) { 
        		var reg =/[@#\$%\^&\*]+/g;
        		return !reg.test(value);
        		},
            message: '含有非法字符！'
        }
 	});
	
	function getPinyin(){
		var colLabel=$('#colLabel').val();
		$.post('platform/eform/cbbClient/getPinyin.json', {
			str : colLabel
			}, function(result){
				$('#colName').attr("value",result.content);
			}, 'json');
	}
	function upperCase(ele){
		var value = $(ele).val();
		$(ele).val(value.toUpperCase());
	}
	function closeForm(){
		parent.templetField.closeDialog("#edit");
	}
	function saveForm(){
		if($('#form').form('validate')){
			parent.templetField.save(serializeObject($('#form')),"#edit");
		}
	}
	</script>
</body>
</html>