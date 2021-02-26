<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>

</head>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">
		<form id="fm" method="post" novalidate>
		<table class="form_commonTable">
		<tr>
		<th width="10%">
		<span class="remind">*</span>
		字段中文名称:</th>
		<td width="40%"><input id="colLabel"    name="colLabel" class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]']"   onblur="getPinyin('${created}')"  <c:if test="${attribute06== '1'}">readonly</c:if>  ></td>
		<th width="10%">
		<span class="remind">*</span>
		字段英文名称:</th>
		<td width="40%">
		<c:choose>
		<c:when test="${created== 'Y'}">  
					<input id="colName"   readonly   name="colName" class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]','isLegal']"  <c:if test="${attribute06== '1'}">readonly</c:if>  ><br><font color=red>(建议英文数字下划线组合方式)</font>
		</c:when>
		<c:otherwise> 
		 			<input id="colName"    name="colName" class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]','isLegal']"   <c:if test="${attribute06== '1'}">readonly</c:if>  ><br><font color=red>(建议英文数字下划线组合方式)</font>
		</c:otherwise>
		</c:choose>
		</td>
		</tr>
		<tr>
		<th  rowspan="2">
		<span class="remind">*</span>
		字段类型: </th>
		<td  rowspan="2">
				<select name="colType" id="colType" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"  >
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
		<td width="40%"><input name="colLength"   class="easyui-validatebox"   value=50  data-options="required:true,validType:['isBlank','length[0,32]']"  <c:if test="${attribute06== '1'}">readonly</c:if>  ></td>
		</tr>
		<tr>
		<th width="10%">
		小数位数: </th>
		<td width="40%"><input name="attribute02"   class="easyui-validatebox"   value=0    <c:if test="${attribute06== '1'}">readonly</c:if>  ></td>
		</tr>
		
		<tr>
		<th width="10%">
		<span class="remind">*</span>
		字段顺序: </th>
		<td width="40%"><input name="colOrder"  class="easyui-validatebox"   value=0   data-options="required:true,validType:['isBlank','length[0,32]']"   <c:if test="${attribute06== '1'}">readonly</c:if>  ></td>
		<th width="10%">
		时间格式: </th>
		<td width="40%"><select name="attribute03"   id="attribute03"   class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"  >
								<option value="1" >Y-m-d H:i:s</option>
								<option value="2">Y-m-d</option> 
				</select></td>
		</tr>
		
		<tr>
		<th width="10%">
				绑定选择控件:</th>
				<td width="40%"><select name="colRuleName" id="colRuleName" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="">无</option>
								<option value="user">选人员</option>
								<option value="dept">选部门</option>
								<option value="custom">自定义</option>
				</select>
				</td>
		<th width="10%">
		<span class="remind">*</span>
		元素类型: </th>
		<td width="40%"><select name="elementType" id="elementType" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="text">text</option>
								<option value="textarea">textarea</option>
								<option value="radio">radio</option>
								<option value="checkbox">checkbox</option>
								<option value="image">image</option>
				</select>
		</td>
		
		</tr>
		<tr id="commonselectcount" style="display:none">
			<th width="10%">
			是否单选: </th>
			<td width="40%">
				<select name="colCommonselectCount" id="colCommonselectCount" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="1">是</option>
								<option value="-1">否</option>
				</select>
			</td>
		</tr>
		<tr>		
				<th width="10%">
				自定义服务:</th>
				<td width="40%"><input name="colRuleTitle"  class="easyui-validatebox"  ></td>
				
				<th width="10%">
				自定义路径:</th>
				<td width="40%"><input name="customPath"  class="easyui-validatebox"  ></td>
		</tr>
		<tr>
		<th width="10%">
		是否查询字段: </th>
		<td width="40%"><select name="colIsSearch" id="colIsSearch"  class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   selected="selected">是</option>
								<option value="N">否</option>
				</select></td>
		<th width="10%">
		是否必填: </th>
		<td width="40%"><select name="colIsMust" id="colIsMust" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
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
		<td width="40%"><select name="colIsDetail"  id="colIsDetail"  class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		</tr>
			
		<tr>
			    <th width="10%">
				    是否只读: </th>
			    <td width="40%"><select name="colDropdownType"  id="colDropdownType"  class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="N">否</option>
								<option value="Y" >是</option>
				</select></td>
			
				<th width="10%">
					是否显示: </th>
				<td width="40%"><select name="colIsVisible" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"  >
								<option value="Y" >是</option>
								<option value="N">否</option> 
				</select></td>
		</tr>
			
			<tr>
				<th width="10%">
				验证规则:</th>
				<td width="40%">
				<pt6:syslookup name="colValidateType" isNull="true" lookupCode="PLATFORM_EFORM_VALIDATE" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup>
				</td>
				<th width="10%">
				是否唯一:</th>
				<td width="40%">
				<select name="colIsUnique"  id="colIsUnique"  class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="N"   selected="selected">否</option>
								<option value="Y">是</option>
				</select>
				</td>
			</tr>
			<tr>
				<th width="10%">自动编码服务:</th>
				<td width="40%"><input name="colAutocode"  class="easyui-validatebox"  <c:if test="${attribute06== '1'}">readonly</c:if>  ></td>
				<th width="10%">
				是否移动端显示:</th>
				<td width="40%">
				<select name="colIsMobile" id="colIsMobile" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="N"   selected="selected">否</option>
								<option value="Y">是</option>
				</select>
				</td>
			</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">	
	<div id="dlg-buttons1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td  align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" onclick="saveCol()" >保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('update')" >返回</a>
				</td>
			</tr>
	</table>
	</div>
</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;
var colRuleName="";
$(function(){
	
	var results=$.parseJSON('${result}');
	$('#fm').form('load', results);
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

	colRuleName = results.colRuleName;
	if (colRuleName == "user" || colRuleName == "dept"){
		$("#commonselectcount").show();
	}
	
	$('#colRuleName').combobox({
		onSelect: function(record){
			$("#colCommonselectCount").val("");
			if (record.value === "user" || record.value === "dept" ){
				$("#commonselectcount").show();
			}else{
				$("#commonselectcount").hide();
			}
		}
	});
	
	var elementType = results.elementType;
	
	if (elementType === "image"){
		$("#colType").combobox("select", "BLOB");
		$('#colType').combobox('disable');
		$("#colIsMust").combobox("setValue", "N");
		$('#colIsMust').combobox('disable');
	}else{
		$('#colType').combobox('enable');
		$('#colIsMust').combobox('enable');
	}

	if('Y'=='${created}'){
		$("#colType").combobox('disable');
	}
	if('1'=='${attribute06}'){
		
		$("#colType").combobox('disable');
		$("#attribute03").combobox('disable');
		$("#elementType").combobox('disable');
		$("#colIsVisible").combobox('disable');
		$("#colIsSearch").combobox('disable');
		$("#colIsMust").combobox('disable');
		$("#colIsDetail").combobox('disable');
		$("#colDropdownType").combobox('disable');
		$("#colRuleName").combobox('disable');
		$("#colIsUnique").combobox('disable');
		
	}
	
});

function getPinyin(created){
	if('N'==created){
		var colLabel=$('#colLabel').val();
		$.post('platform/eform/cbbClient/getPinyin.json', {
			str : colLabel
			}, function(result){
				$('#colName').attr("value",result.content);
			}, 'json');
	}
}

function saveCol() {
	url = 'platform/eform/cbbClient/editcolumn.json?id=${id}';
	$('input[name="colType"]').attr("disabled",false);
	$('input[name="elementType"]').attr("disabled",false);
	$('input[name="colIsMust"]').attr("disabled",false);
	if (!$("#colRuleName").combo('getValue')){
		$("#colRuleName").combo('setValue',colRuleName);
	}
	if($('#fm').form('validate')){
	$.post(url, {
		str : JSON.stringify(serializeObject($('#fm')))
		}, function(result){
			
			if (result.success==false) {
				parent.alertSuccess('错误',result.msg);
			} else {
				if(result.id=='Y'){
					parent.reloadByRowId();
					//parent.reloaddg();
				}else{
					parent.reloadByRowId();
				}
				parent.dlg_close('update');
			}
			
		}, 'json');
	}
}



</script>



</body>
</html>