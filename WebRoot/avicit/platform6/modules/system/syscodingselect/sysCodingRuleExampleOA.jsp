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
<script src="avicit/platform6/modules/system/syscodingselect/CodingSelect.oa.js"></script>
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
	
	var r = $('#formSelectCoding').form('validate');
	if(!r){
		$.messager.show({title:'提示',msg :'编码规则输入有错，请重新输入！'});
		return false;
	}
	
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
			}else{
				$.messager.show({title:'提示',msg :'保存失败！'});
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
function show1(){
	$('#coding1').coding('span').show();
}
function hide1(){
	$('#coding1').coding('span').hide();
}
function getSegmentNumber(){
	alert($('#coding1').coding('getSegmentNumber'));
}
function getSegmentsValue(){
	var segmentNumber = $('#coding1').coding('getSegmentNumber');
	for(var i = 0; i < segmentNumber; i++){
		var segment = $('#coding1').coding('getCodingSegment', i);
		if(segment.hasClass('easyui-combobox')){
			alert(segment.combobox('getValue'));
		}else if(segment.hasClass('easyui-numberbox')){
			alert(segment.numberbox('getValue'));
		}else if(segment.hasClass('easyui-datebox')){
			alert(segment.datebox('getValue'));
		}else if(segment.hasClass('easyui-datetimebox')){
			alert(segment.datetimebox('getValue'));
		}else{
			alert(segment.text());
		}
	}
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
			codingName:编码名称。 (设置了codingId就不用设置codingName)
			disabled:是否不可用， 默认false,
			readonly:是否只读，默认 false,
			hasDownArrow: 是否显示下拉按钮，默认true,
		  -->
		<tr height="30px">
			<td align="right">生成码值</td>
			<td><input type="text" id="coding1" name="testCoding" class="easyui-coding" style="width: 200px" data-options="codingCode: 'TEST_CODING_CODE1'" value=""></td>
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
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="show1()" href="javascript:void(0);">显示</a>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="hide1()" href="javascript:void(0);">隐藏</a>
			</td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="getSegmentNumber()" href="javascript:void(0);">显示码段个数</a>
				<a class="easyui-linkbutton" iconCls="" plain="false" onclick="getSegmentsValue()" href="javascript:void(0);">显示每个码段的值</a>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
