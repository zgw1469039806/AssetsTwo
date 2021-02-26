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
			<input type="hidden" id="id" name="id" value=""/> 
			<input type="hidden" id="sysApplicationId" name="sysApplicationId" value="${appId}"/>
			<input type="hidden" id="sysId" name="sysId" value="${appId}"/> 
			<input type="hidden" id="secretLevel" name="secretLevel" value="${secretLevel}"/>
			<input type="hidden" id="templetId" name="templetId" value="${templetId}"/>
			<fieldset>
		<legend>基本信息</legend>
		<table class="form_commonTable">
		<tr>
		<th width="10%">
		<span class="remind">*</span>
		字段中文名称:</th>
		<td width="40%"><input id="colLabel"   name="colLabel"  class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]']"   onblur="getPinyin()"></td>
		<th width="10%">
		<span class="remind">*</span>
		字段英文名称:</th>
		<td width="40%"><input id="colName"  name="colName"  class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]','isLegal']" ><br><font color=red>(建议英文数字下划线组合方式)</font></td>
		</tr>
		<tr>
		<th  rowspan="2">
		<span class="remind">*</span>
		字段类型: </th>
		<td  rowspan="2"><select name="colType" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="VARCHAR2">字符串</option>
								<option value="DATE">日期时间</option>
								<option value="NUMBER">数字型</option>
								<option value="BLOB">二进制大对象</option>
								<option value="CLOB">字符大对象</option>
				</select>
		</td>
		
		<th width="10%">
		<span class="remind">*</span>
		字段长度: </th>
		<td width="40%"><input name="colLength"  class="easyui-validatebox"   value=50  data-options="required:true,validType:['isBlank','length[0,32]']" ></td>
		</tr>
		<tr>
		<th width="10%">
		小数位数: </th>
		<td width="40%"><input name="attribute02"  class="easyui-validatebox"   value=0  ></td>
		</tr>
		<tr>
		<th width="10%">
		<span class="remind">*</span>
		字段顺序: </th>
		<td width="40%"><input name="colOrder"  class="easyui-validatebox"   value=0   data-options="required:true,validType:['isBlank','length[0,32]']" ></td>
		<th width="10%">
		时间格式: </th>
		<td width="40%"><select name="attribute03" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"  >
								<option value="1" >Y-m-d H:i:s</option>
								<option value="2">Y-m-d</option> 
				</select></td>
		</tr>
		
		
		<tr>
		<th width="10%">
		<span class="remind">*</span>
		元素类型: </th>
		<td width="40%"><select name="elementType" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="text">text</option>
								<option value="textarea">textarea</option>
								<option value="radio">radio</option>
								<option value="checkbox">checkbox</option>
				</select>
		</td>
		<th width="10%">
		是否显示: </th>
		<td width="40%"><select name="colIsVisible" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"  >
								<option value="Y" >是</option>
								<option value="N">否</option> 
				</select></td>
		</tr>
		<tr>
		<th width="10%">
		是否查询字段: </th>
		<td width="40%"><select name="colIsSearch" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   selected="selected">是</option>
								<option value="N">否</option>
				</select></td>
		<th width="10%">
		是否必填: </th>
		<td width="40%"><select name="colIsMust" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"  selected="selected">是</option>
								<option value="N">否</option>
				</select></td>
		</tr>
		<tr>
		<th width="10%">
		是否列表显示: </th>
		<td width="40%"><select id="colIsTabVisible"  name="colIsTabVisible" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		<th width="10%">
		是否详细显示: </th>
		<td width="40%"><select name="colIsDetail" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		</tr>
			
			<tr>
				<th width="10%">
				生成规则英文:</th>
				<td width="40%"><select name="colRuleName" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="">无</option>
								<option value="user">user</option>
								<option value="dept">dept</option>
				</select>
				</td>
				<th width="10%">
				生成规则中文:</th>
				<td width="40%"><input name="colRuleTitle"  class="easyui-validatebox"  ></td>
			</tr>
			
			</table>
			</fieldset>
			
			<fieldset>
			<legend>扩展信息</legend>
			<table class="form_commonTable">
			<tr>
				<th width="10%">
				路径:</th>
				<td width="40%"><input name="customPath"  class="easyui-validatebox" ></td>
				<th width="10%">
				说明: </th>
				<td width="40%"><input name="remark"  class="easyui-validatebox" ></td>
			</tr>
			<tr>
				<th width="10%">
				下拉类型: </th>
				<td width="40%"><select name="colDropdownType" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"   value="'Y'">
								<option value="0">无</option>
								<option value="1">参选</option>
								<option value="2">只选</option>
								<option value="3">选择</option>
				</select>
				</td>
				<th width="10%">
				生成方式: </th>
				<td width="40%"><select name="colGeneMethod" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="0"   >空</option>
								<option value="1">默认值</option>
								<option value="2">序列</option>
								<option value="3">顺带</option>
								<option value="4">组合项</option>
								<option value="5">统计生成</option>
								<option value="6">选择</option>
				</select>
				</td>
			</tr>
			<tr>
				<th width="10%">
				生成方式规则:</th>
				<td width="40%"><input name="colGeneMethodRule"  class="easyui-validatebox" ></td>
				<th width="10%">
				显示格式: </th>
				<td width="40%"><select name="colShowFormat" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="0"   >无</option>
								<option value="1">日期</option>
								<option value="2">金额</option>
				</select></td>
			</tr>
			<tr>
			<th width="10%">
			是否可见: </th>
			<td width="40%"><select name="colIsDisplay" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y">是</option>
								<option value="N">否</option>
				</select></td>
			<th width="10%">
			是否编辑字段: </th>
		    <td width="40%"><select name="colIsEdit" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   >是</option>
								<option value="N">否</option>
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
				<td align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveForm();" >保存</a>
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
		parent.templetField.closeDialog("#insert");
	}
	function saveForm(){
		if($('#form').form('validate')){
			parent.templetField.save(serializeObject($('#form')),"#insert");
		}
	}
	</script>
</body>
</html>