<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑代码规则</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	$.extend($.fn.validatebox.defaults.rules, {    
	    code: {    
	        validator: function(value){
	        	var b = /^[0-9a-zA-Z_]*$/g;
	        	return b.test(value);  
	        },    
	        message: '请输入字母、数字或下划线。'   
	    }    
	});
	//去除输入的空格
	$('#codingName,#codingCode').bind('input propertychange', function() {
		var newValue = $.trim($(this).val());
		if(newValue != $(this).val()){
			$(this).val(newValue);
		}
	});
	
	$('input[name="segmentName"],input[name="func"]').bind('input propertychange', function() {
		var newValue = $.trim($(this).val());
		if(newValue != $(this).val()){
			$(this).val(newValue);
		}
	}); 
	
	$('textarea[name="sqlExpression"]').change(function(){
		var newValue = $.trim($(this).val());
		if(newValue != $(this).val()){
			$(this).val(newValue);
		}
	});
});

/**
 * 当前码段tab页签的切换时触发
 */
function fushTabByTabIndex(){
	var tab = $('#tabControlList').tabs('getSelected');
	var title = tab.panel('options').title;
	if(title != null && title.indexOf('码段')>=0){
		var segmentIndex = title.substring(2);
		var _segmentType = $('#segmentType_' + segmentIndex).combobox('getValue');
		for(var i = 1; i < parseInt(segmentIndex); i++){
			var segmentType = $('#segmentType_' + i).combobox('getValue');
			var comSegmentId = $('#comSegmentId_' + i).combobox('getValue');
			var relation = $('#segmentRelation'+ i + '_' + segmentIndex);
			//本码段类型是流水码，放开所有依赖项
			if(_segmentType == '3'){
				relation.attr('disabled', false);
			}else{
				//如果不是流水码，根据之前码段类型判断哪些可以依赖
				if(segmentType != '1'){
					if(relation.attr('checked') == 'checked'){
						relation.attr('checked', false);
					}
					relation.attr('disabled', true);
				}else{
					if(comSegmentId != null && comSegmentId != ''){
						relation.attr('disabled', true);
					}else{
						relation.attr('disabled', false);
					}
				}
			}
		}
		setSegmentRelation(segmentIndex);
	}
}

/**
 * 修改码段个数
 */
function doChangeSegmentNumber(newValue,oldValue){
	var tabs = $('#tabControlList').tabs('tabs');
	var tabsLength = tabs.length;
	var segmentNumber = parseInt(newValue);
	if(segmentNumber > tabsLength - 1){
		for(var i = tabsLength; i <= segmentNumber; i++){
			$.ajax({
		        cache: false,
		        type: "POST",
		        url: 'avicit/platform6/centralcontrol/syscodingrule/sysCodingRuleAddContent.jsp?appId=${ruleBase.sysApplicationId}&index=' + i,
		        dataType:"text",
		        async: false,
		        timeout:10000,
		        error: function(request) {
		        	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
		        },
		        success: function(data) {
		        	if(data){
		        		$('#tabControlList').tabs('add',{    
		    			    title:'码段' + i,
		    			    content: data,
		    			    selected: true,
		    			    closable:false
		    			});
					}
		        }
		    });
		}
		
		$('#tabControlList').tabs('select', 0);
		
		//去除输入的空格
		$('input[name="segmentName"],input[name="func"]').bind('input propertychange', function() {
			var newValue = $.trim($(this).val());
			if(newValue != $(this).val()){
				$(this).val(newValue);
			}
		}); 
		
		$('textarea[name="sqlExpression"]').change(function(){
			var newValue = $.trim($(this).val());
			if(newValue != $(this).val()){
				$(this).val(newValue);
			}
		});
	}else if(segmentNumber < tabsLength - 1){
		for(var i = tabsLength - 1; i >=  segmentNumber + 1; i--){
			$('#tabControlList').tabs('close', i);
		}
	}
}

/**
 * 修改码段类型
 */
function doChangeSegmentType(index, newValue, oldValue){
	fushTabByTabIndex();
	if(newValue == '1'){
		//控制显隐
		$('#tdComSegment_' + index).css('display','');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdFunc_' + index).css('display','none');
		$('#tdSQL_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLengthRemind_'+ index).hide();
		//根据通用代码判断
		var comSegmentId = $('#comSegmentId_' + index).combobox('getValue');
		doChangeComSegment(index, comSegmentId, '');
		//函数和sql不必填
		$('#func_'+ index).validatebox({ required: false});
		$('#sqlExpression_'+ index).validatebox({ required: false});
	}else if(newValue == '3'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','');
		$('#tdCount_' + index).css('display','none');
		$('#tdFunc_' + index).css('display','none');
		$('#tdSQL_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, true);
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLength_' + index).parent().removeClass('input-readonly');
		//码段长度可以修改
		$('#segmentLength_' + index).attr("readonly", false);
		$('#segmentLengthRemind_'+ index).hide();
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
		//函数和sql不必填
		$('#func_'+ index).validatebox({ required: false});
		$('#sqlExpression_'+ index).validatebox({ required: false});
	}else if(newValue == '4'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','none');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','');
		$('#tdFunc_' + index).css('display','none');
		$('#tdSQL_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		setFormatRequired(index, true);
 		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLength_'+ index).numberbox('clear');
		$('#segmentLength_' + index).attr("readonly", true);
		$('#segmentLength_' + index).parent().addClass('input-readonly');
		$('#segmentLengthRemind_'+ index).hide();
		setFormatRequired(index, true);
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
		//函数和sql不必填
		$('#func_'+ index).validatebox({ required: false});
		$('#sqlExpression_'+ index).validatebox({ required: false});
	}else if(newValue == '5'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','none');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdFunc_' + index).css('display','none');
		$('#tdSQL_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: true});
 		$('#segmentLength_' + index).attr("readonly", false);
 		$('#segmentLength_' + index).parent().removeClass('input-readonly');
 		$('#segmentLengthRemind_'+ index).show();
		setFormatRequired(index, false);
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
		//函数和sql不必填
		$('#func_'+ index).validatebox({ required: false});
		$('#sqlExpression_'+ index).validatebox({ required: false});
	}else if(newValue == '6'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','none');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdFunc_' + index).css('display','');
		$('#tdSQL_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLength_'+ index).numberbox('clear');
		$('#segmentLength_' + index).attr("readonly", true);
		$('#segmentLength_' + index).parent().addClass('input-readonly');
		$('#segmentLengthRemind_'+ index).hide();
		setFormatRequired(index, false);
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
		//函数必填
		$('#func_'+ index).validatebox({ required: true});
		//sql不必填
		$('#sqlExpression_'+ index).validatebox({ required: false});
	}else if(newValue == '7'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','none');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdFunc_' + index).css('display','none');
		$('#tdSQL_' + index).css('display','');
		//设置字段是否必填
		setSerialRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLength_'+ index).numberbox('clear');
		$('#segmentLength_' + index).attr("readonly", true);
		$('#segmentLength_' + index).parent().addClass('input-readonly');
		$('#segmentLengthRemind_'+ index).hide();
		setFormatRequired(index, false);
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
		//函数不必填
		$('#func_'+ index).validatebox({ required: false});
		//sql必填
		$('#sqlExpression_'+ index).validatebox({ required: true});
	}
}

/**
 * 设置流水字段是否必填
 */
function setSerialRequired(index, isRequired){
	var maxValue = 1000000;
	var segmentLength = $('#segmentLength_' + index).numberbox('getValue');
	if(segmentLength != null && segmentLength != '' && segmentLength > 0){
		maxValue = Math.pow(10, segmentLength)-1;
	}
	$('#serialNumberStart_' + index).numberbox({    
		required: isRequired,
		min:0,
		max:maxValue
	});
	$('#serialNumberEnd_' + index).numberbox({    
		required: isRequired,
		min:0,
		max:maxValue
	});
	$('#serialStep_' + index).numberbox({    
		required: isRequired,
		min:1,
		max:1000000
	});
}

/**
 * 设置计算码格式化字段是否必填
 */
function setFormatRequired(index, isRequired){
	$('#format_' + index).combobox({    
 		required: isRequired,
 		value: ''
 	});
}

/**
 * 重新设置本码段之后的码段是否可选依赖本码段
 * @param index
 * @param isDisabled 是否不可用
 */
function setRelationDisabled(index, isDisabled){
	index = parseInt(index);
	var tabs = $('#tabControlList').tabs('tabs');
	var tabsLength = tabs.length;
	if(isDisabled == true){
		for(var i = index + 1; i <= tabsLength; i++){
			var relation = $('#segmentRelation'+ index + '_' + i);
			if(relation.attr('checked') == 'checked'){
				relation.attr('checked', false);
				setSegmentRelation(i);
			}
			relation.attr('disabled', true);
		}
	}else{
		for(var i = index + 1; i <= tabsLength; i++){
			var relation = $('#segmentRelation'+ index + '_' + i);
			if(relation.length > 0){
				relation.attr('disabled', false);
			} 
		}
	}
}

/**
 * 修改分类码值关联
 */
function setSegmentRelation(index){
	var segmentRelation = '';
	for(var i = 1; i < index; i++){
		var relation = $('#segmentRelation'+ i + '_' + index);
		if(relation.attr('checked') == 'checked'){
			if(segmentRelation == ''){
				segmentRelation += relation.val();
			}else{
				segmentRelation += '@@' + relation.val();
			}
		}
	}
	$('#segmentRelation_' + index).val(segmentRelation);
}

/**
 * 码段长度变化时修改
 */
function doChangeSegmentLength(index, newValue, oldValue){
	if(newValue != null && newValue != ''){
		$('#serialNumberStart_' + index).numberbox({max:(Math.pow(10,newValue)-1)});
		$('#serialNumberEnd_' + index).numberbox({max:(Math.pow(10,newValue)-1)});
		$('#serialStep_' + index).numberbox({max:(Math.pow(10,newValue)-1)});
	} else {
		$('#serialNumberStart_' + index).numberbox({max:1000000});
		$('#serialNumberEnd_' + index).numberbox({max:1000000});
		$('#serialStep_' + index).numberbox({max:1000000});
	}
}

/**
 * 格式化流水码值
 */
function doFarmatterSerialNumber(index, value){
	var returnValue = '';
	if(value != null && value != ''){
		returnValue = value + '';
		var segmentLength = $('#segmentLength_' + index).numberbox('getValue');
		if(segmentLength != null && segmentLength != '' && segmentLength > 0){
			if (value.length < segmentLength){
				for(var i = value.length; i < segmentLength; i++){
					returnValue = '0' + returnValue;
				}
			}
		}
	}
	
	return returnValue;
 }
 
/**
 * 修改通用码段
 */
function doChangeComSegment(index, newValue, oldValue){
	 if(newValue != null && newValue != ''){
		 //不显示分类码值关联
		 $('#tdSegmentRelation_' + index).css('display','none');
		 //编码长度只读
		 $('#segmentLength_' + index).attr("readonly", true);
		 $('#segmentLength_' + index).parent().addClass('input-readonly');
		 //设置分类码值关联可选
		 setRelationDisabled(index, true);
		//删除码段长度
		 $('#segmentLength_' + index).numberbox('clear');
	 }else{
		 //显示分类码值关联
		 $('#tdSegmentRelation_' + index).css('display','');
		 //去除编码长度只读
		 $('#segmentLength_' + index).attr("readonly", false);
		 $('#segmentLength_' + index).parent().removeClass('input-readonly');
		 //设置分类码值关联可选
		 setRelationDisabled(index, false);
	 }
}

/**
 * 开始码段变化时修改
 */
 function doChangeSerialStart(index, newValue, oldValue){
	 if(newValue != null && newValue != ''){
		 $('#serialNumberEnd_' + index).numberbox({min:parseInt(newValue, 10)});
	 } else {
		 $('#serialNumberEnd_' + index).numberbox({min:0});
	 }
 }

 /**
  * 结束码段变化时修改
  */
  function doChangeSerialEnd(index, newValue, oldValue){
 	 if(newValue != null && newValue != ''){
 		 $('#serialNumberStart_' + index).numberbox({max:parseInt(newValue, 10)});
 	 } else {
 		 $('#serialNumberStart_' + index).numberbox({max:1000000});
 	 }
  }
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<div id="tabControlList" class="easyui-tabs" data-options="onSelect: fushTabByTabIndex" tabPosition="top" fit="true" border="false" style="padding:0px;" >
		<!-- 基本设置显示区域 -->
		<div title="基本设置">
		   <form id="formRuleBase" method="post" style="padding: 15px 25px 0 0;">
		   		<input id="id" name="id" type="hidden" value="${ruleBase.id}"/>
		   		<input id="version" name="version" type="hidden" value="${ruleBase.version}"/>
				<table class="form_commonTable">
					<tr>
						<th width="15%"><span class="remind">*</span>规则名称</th>
						<td colspan="3" ><input id="codingName" name="codingName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" value="${ruleBase.codingName}" /></td>
					</tr>
					<tr>
						<th><span class="remind">*</span>规则编号</th>
						<td width="35%"><input id="codingCode" name="codingCode" class="easyui-validatebox" required="true" data-options="validType:['code','length[0,30]']" value="${ruleBase.codingCode}" /></td>
						<th width="15%"><span class="remind">*</span>码段个数</th>
						<td><input id="segmentNumber" name="segmentNumber" class="easyui-numberbox" required="true" data-options="min:1,max:10,onChange: doChangeSegmentNumber" value="${ruleBase.segmentNumber}"></td>
					</tr>
					<tr>
						<th>说明</th>
						<td colspan="3">
							<textarea class="easyui-validatebox textareabox" id="ruleRemark" name="ruleRemark" data-options="required:false,validType:'length[0,2000]'"  style="height:65px!important;">${ruleBase.ruleRemark }</textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 编码规则设置显示区域 -->
		<c:forEach items="${segmentList}"  var="segment" varStatus="segmentStatus">
			<div title="码段${segment.segmentIndex}">
				<form id="formRuleSegment_${segment.segmentIndex}" method="post" style="padding: 15px 25px 0 0;">
					<input id="id" name="id" type="hidden" value="${segment.id}"/>
					<input id="version" name="version" type="hidden" value="${segment.version}"/>
					<table id="tableRuleSegment_${segment.segmentIndex}" class="form_commonTable">
						<tr>
							<th width="15%"><span class="remind">*</span>码段名称</th>
							<td width="37%" colspan="3"><input id="segmentName_${segment.segmentIndex}" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'"  value="${segment.segmentName}"/></td>
							<th width="12%"><span class="remind">*</span>码段类型</th>
							<td colspan="3"><input id="segmentType_${segment.segmentIndex}" name="segmentType" class="easyui-combobox" required="true" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeSegmentType(${segment.segmentIndex},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/cc/sysCodingRule/getSegmentType.json'" value="${segment.segmentType}"/></td>
						</tr>
						<tr>
							<th><span id="segmentLengthRemind_${segment.segmentIndex}" class="remind" <c:if test="${segment.segmentType != '5'}">style="display: none;"</c:if>>*</span>码段长度</th>
							<td colspan="3" <c:if test="${segment.segmentType == '4' || segment.segmentType == '6' || segment.segmentType == '7' || (segment.segmentType == '1' && segment.comSegmentId != null)}">class="input-readonly"</c:if>>
								<input id="segmentLength_${segment.segmentIndex}" name="segmentLength" class="easyui-numberbox" <c:if test="${segment.segmentType == '4' || segment.segmentType == '6' || segment.segmentType == '7' || (segment.segmentType == '1' && segment.comSegmentId != null)}">readonly="true"</c:if> data-options="required:<c:choose><c:when test="${segment.segmentType == '5'}">true</c:when><c:otherwise>false</c:otherwise></c:choose>,min:1,max:99,onChange:function(newValue,oldValue){doChangeSegmentLength(${segment.segmentIndex},newValue,oldValue)}" value="${segment.segmentLength}"/>
							</td>
							<th>前缀</th>
							<td width="15%"><input id="segmentPrefixion_${segment.segmentIndex}" name="segmentPrefixion" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" value="${segment.segmentPrefixion}"/></td>
							<th width="6%">后缀</th>
							<td style="_padding-right: 2px;"><input id="segmentSuffix_${segment.segmentIndex}" name="segmentSuffix" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" value="${segment.segmentSuffix}"/></td>
						</tr>
						<c:if test="${segment.segmentIndex != '1'}">
						<tr id="tdSegmentRelation_${segment.segmentIndex}" <c:if test="${segment.segmentType == '4' || segment.segmentType == '5' || (segment.segmentType == '1' && segment.comSegmentId != null) || (segment.segmentType == '2' && segment.comSegmentId != null)}">style="display: none"</c:if>>
							<th>依赖码段<input type="hidden" id="segmentRelation_${segment.segmentIndex}" name="segmentRelation" value="${segment.segmentRelation}"/></th>
							<td colspan="7">
								<c:forEach var="theIndex" begin="1" end="${segment.segmentIndex - 1}" step="1"> 
									<span class="block-box"><input type="checkbox" class="checkbox" <c:forTokens var="num" items="${segment.segmentRelation}" delims="@@"><c:if test="${theIndex == num}">checked="checked"</c:if></c:forTokens> id="segmentRelation${theIndex }_${segment.segmentIndex}" onclick="setSegmentRelation(${segment.segmentIndex})" value="${theIndex }" /><span class="checkbox-text">码段${theIndex }</span></span>
								</c:forEach>
							</td>										
						</tr>
						</c:if>
						<tr id="tdComSegment_${segment.segmentIndex}" <c:if test="${segment.segmentType != '1' && segment.segmentType != '2'}">style="display: none"</c:if>>
							<th>通用编码</th>
							<td colspan="3"><input id="comSegmentId_${segment.segmentIndex}" name="comSegmentId" class="easyui-combobox" value="${segment.comSegmentId}" required="false" data-options="editable:false,panelHeight:100,onChange: function(newValue,oldValue){doChangeComSegment(${segment.segmentIndex},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/cc/sysCodingComSegment/getComSegmentData.json?appId=${ruleBase.sysApplicationId}&isDisplaySelect=true'" /></td>
							<th></th>
							<td colspan="3"></td>
						</tr>
						<tr id="tdSerialNumber_${segment.segmentIndex}" <c:if test="${segment.segmentType != '3'}">style="display: none"</c:if>>
							<th><span class="remind">*</span>流水范围</th>
							<td width="15%"><input id="serialNumberStart_${segment.segmentIndex}" name="serialNumberStart" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:0<c:if test="${segment.segmentLength != null}">,max:<c:forEach begin="1" end="${segment.segmentLength}">9</c:forEach></c:if>,formatter: function(value){return doFarmatterSerialNumber(${segment.segmentIndex}, value)},onChange:function(newValue,oldValue){doChangeSerialStart(${segment.segmentIndex},newValue,oldValue)}" value="${segment.serialNumberStart}"/></td>
							<td align="right" style="width: 25px">--</td>
							<td width="15%"><input id="serialNumberEnd_${segment.segmentIndex}" name="serialNumberEnd" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:0<c:if test="${segment.segmentLength != null}">,max:<c:forEach begin="1" end="${segment.segmentLength}">9</c:forEach></c:if>,formatter: function(value){return doFarmatterSerialNumber(${segment.segmentIndex}, value)},onChange:function(newValue,oldValue){doChangeSerialEnd(${segment.segmentIndex},newValue,oldValue)}" value="${segment.serialNumberEnd}"/></td>
							<th><span class="remind">*</span>流水步长</th>
							<td><input id="serialStep_${segment.segmentIndex}" name="serialStep" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:1<c:if test="${segment.segmentLength != null}">,max:<c:forEach begin="1" end="${segment.segmentLength}">9</c:forEach></c:if>" value="${segment.serialStep}"/></td>
							<th colspan="2">
								<span class="block-box">
									<input type="checkbox" class="checkbox" id="isInputSerial_${segment.segmentIndex}" name="isInputSerial" value="Y" <c:if test="${segment.segmentType == '3' && segment.isInputSerial == 'Y'}">checked="checked"</c:if>/>
									<span title="选中可以输入流水号，否则不可以输入" class="checkbox-text">是否可输入流水号</span>
								</span>
							</th>
						</tr>
						<tr id="tdCount_${segment.segmentIndex}" <c:if test="${segment.segmentType != '4'}">style="display: none"</c:if>>
							<th><span class="remind">*</span>格式化</th>
							<td colspan="3">
								<input id="format_${segment.segmentIndex}" name="format" class="easyui-combobox" data-options="editable:false,panelHeight:100,valueField:'code',textField:'name',url:'platform/cc/sysCodingRule/getCountFormatDate.json'" value="${segment.format}"/>
							</td>
							<th colspan="4" style="padding-left: 50px">
								<span class="block-box">
									<input type="checkbox" class="checkbox" id="isCurrentTime_${segment.segmentIndex}" name="isCurrentTime" value="Y" <c:if test="${segment.segmentType == '4' && segment.isCurrentTime == 'Y'}">checked="checked"</c:if>/>
									<span title="选中获取服务器默认时间，否则自己选择时间" class="checkbox-text">是否默认当前时间</span>
								</span>
							</th>
						</tr>
						<tr id="tdFunc_${segment.segmentIndex}" <c:if test="${segment.segmentType != '6'}">style="display: none"</c:if>>
							<th><span class="remind">*</span>函数全路径</th>
							<td colspan="7" title="输入函数全路径，包括调用方法">
								<input id="func_${segment.segmentIndex}" name="func" class="easyui-validatebox" data-options="<c:if test="${segment.segmentType != '6'}">required:false</c:if><c:if test="${segment.segmentType == '6'}">required:true</c:if>,validType:'length[0,200]'" value="${segment.func}" />
							</td>
						</tr>
						<tr id="tdSQL_${segment.segmentIndex}" <c:if test="${segment.segmentType != '7'}">style="display: none"</c:if>>
							<th><span class="remind">*</span>SQL语句</th>
							<td colspan="7" title="输入SQL语句">
								<textarea id="sqlExpression_${segment.segmentIndex}" name="sqlExpression" class="easyui-validatebox textareabox" data-options="<c:if test="${segment.segmentType != '7'}">required:false</c:if><c:if test="${segment.segmentType == '7'}">required:true</c:if>,validType:'length[0,2000]'" style="height:60px!important;">${segment.sqlExpression}</textarea>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>
