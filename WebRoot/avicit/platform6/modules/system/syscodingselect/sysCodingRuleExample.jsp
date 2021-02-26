<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自编代码例子</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/modules/system/syscodingselect/CodingSelect.js"></script>
<script type="text/javascript">
function setCodingId(newvalue, oldvalue){
	$('#coding1').coding('setValue', '');
	$('#coding1').coding('setCodingId', newvalue);
}

function setCodingCode(newvalue, oldvalue){
	$('#coding1').coding('setValue', '');
	$('#coding1').coding('setCodingCode', newvalue);
}

/**
 * 提交后台
 */
function saveCoding(){
	var codingId = $('#coding1').coding('getCodingId');
	var codingValue = $('#coding1').coding('getValue');
	
	//增加非空验证
	if(codingId == ''){
		$.messager.show({title:'提示',msg :'请选择编码规则！'});
		return;
	}
	if(codingValue == ''){
		$.messager.show({title:'提示',msg :'请选择生成码值！'});
		return;
	}
	
	var segmentValueLength = $('#coding1').coding('getLengths');//不同码段的长度
	$.ajax({
        cache: true,
        type: "POST",
        url:'platform/sysCodingSelectController/saveCoding',
        dataType:"json",
        data:{codingId: codingId, codingValue: codingValue,segmentValueLength:segmentValueLength},
        async: false,
        timeout:10000,
        error: function(request) {
        	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
        },
        success: function(result) {
        	if (result.flag == 'success') {
				$.messager.show({title:'提示',msg :'保存成功！'});
        		$('#formSelectCoding').form('reset');
			}else{
				$.messager.show({title:'提示',msg :'保存失败！'});
				$('#formSelectCoding').form('reset');
			}
        }
    });
}

function setReadOnly(flag){
	$('#coding1').coding('readonly', flag);
}

function disable(){
	$('#coding1').coding('disable');
}

function enable(){
	$('#coding1').coding('enable');
}

function doOnChange(newValue, oldValue){
	//alert(newValue + "," + oldValue);
}
function setValue(){
	var value = prompt("请在这里输入值");
	$('#coding1').coding('setValue', value);
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
<form id="formSelectCoding" method="post">
	<table border="0">
		<tr height="30px">
			<td width="300px" align="right">选择编码规则（通过id设置）</td>
			<td width="300px">
				<input id="setCoding" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onChange: setCodingId,valueField:'id',textField:'name',url:'platform/sysCodingSelectController/getCodingRuleListJsonData.json?isDisplaySelect=true'" style="width: 205px"/>
			</td>
		</tr>
		<tr height="30px">
			<td width="300px" align="right">选择编码规则（通过code设置）</td>
			<td width="300px">
				<input id="setCoding" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onChange: setCodingCode,valueField:'code',textField:'name',url:'platform/sysCodingSelectController/getCodingRuleListJsonData.json?isDisplaySelect=true'" style="width: 205px"/>
			</td>
		</tr>
		<tr height="30px">
			<td colspan="2"></td>
		</tr>
		<!-- 编码选择空间提供如下参数：
			codingId:编码规则ID。
			codingCode:编码规则编号。
			showDefaultValue:是否显示默认数据，默认 true。
			disabled:是否不可用， 默认false,
			readonly:是否只读，默认 false,
			hasDownArrow: 是否显示下拉按钮，默认true,
		  -->
		<tr height="30px">
			<td align="right">生成码值</td>
			<td><input type="text" id="coding1" class="easyui-coding" style="width: 200px" data-options="codingCode: '111',onChange:doOnChange" value="12345"></td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td><a class="easyui-linkbutton" iconCls="" plain="false" onclick="saveCoding()" href="javascript:void(0);">提交后台</a></td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="setReadOnly(true)" href="javascript:void(0);">只读</a>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="setReadOnly(false)" href="javascript:void(0);">取消只读</a>
			</td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="enable()" href="javascript:void(0);">启用组件</a>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="disable()" href="javascript:void(0);">禁用组件</a>
			</td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="setValue()" href="javascript:void(0);">赋值</a>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
