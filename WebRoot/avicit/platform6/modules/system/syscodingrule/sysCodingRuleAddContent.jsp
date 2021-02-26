<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form id="formRuleSegment_${param.index}" method="post" style="padding: 15px 25px 0 0;">
	<table id="tableRuleSegment_${param.index}" class="form_commonTable">
		<tr>
			<th width="15%"><span class="remind">*</span>码段名称</th>
			<td width="37%" colspan="3"><input id="segmentName_${param.index}" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" /></td>
			<th width="12%"><span class="remind">*</span>码段类型</th>
			<td colspan="3"><input id="segmentType_${param.index}" name="segmentType" class="easyui-combobox" required="true" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeSegmentType(${param.index},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getSegmentType.json'" /></td>
		</tr>
		<tr>
			<th><span id="segmentLengthRemind_${param.index}" class="remind" style="display: none;">*</span>码段长度</th>
			<td colspan="3"><input id="segmentLength_${param.index}" name="segmentLength" class="easyui-numberbox"  data-options="min:1,max:99,onChange:function(newValue,oldValue){doChangeSegmentLength(${param.index},newValue,oldValue)}" /></td>
			<th>前缀</th>
			<td width="15%"><input id="segmentPrefixion_${param.index}" name="segmentPrefixion" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" /></td>
			<th width="6%">后缀</th>
			<td style="_padding-right: 2px;"><input id="segmentSuffix_${param.index}" name="segmentSuffix" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'"  /></td>
		</tr>
		<c:if test="${param.index != '1'}">
		<tr id="tdSegmentRelation_${param.index}" style="display: none">
			<th>依赖码段<input type="hidden" id="segmentRelation_${param.index}" name="segmentRelation" /></th>
			<td colspan="7">
				<c:forEach var="theIndex" begin="1" end="${param.index - 1}" step="1"> 
					<span class="block-box"><input type="checkbox" class="checkbox" id="segmentRelation${theIndex }_${param.index}" onclick="setSegmentRelation(${param.index})" value="${theIndex }" /><span class="checkbox-text">码段${theIndex }</span></span>
				</c:forEach>
			</td>
		</tr>
		</c:if>
		<tr id="tdComSegment_${param.index}" style="display: none">
			<th>通用编码</th>
			<td colspan="3"><input id="comSegmentId_${param.index}" name="comSegmentId" class="easyui-combobox" required="false" data-options="editable:false,panelHeight:100,onChange: function(newValue,oldValue){doChangeComSegment(${param.index},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/sysCodingComSegmentController/getComSegmentData.json?isDisplaySelect=true'" /></td>
			<th></th>
			<td colspan="3"></td>
		</tr>
		<tr id="tdSerialNumber_${param.index}" style="display: none">
			<th><span class="remind">*</span>流水范围</th>
			<td width="15%"><input id="serialNumberStart_${param.index}" name="serialNumberStart" class="easyui-numberbox" data-options="required:false,min:0,max:1000000,formatter: function(value){return doFarmatterSerialNumber(${param.index}, value)},onChange:function(newValue,oldValue){doChangeSerialStart(${param.index},newValue,oldValue)}"/></td>
			<td align="right" style="width: 25px">--</td>
			<td width="15%"><input id="serialNumberEnd_${param.index}" name="serialNumberEnd" class="easyui-numberbox" data-options="required:false,min:0,max:1000000,formatter: function(value){return doFarmatterSerialNumber(${param.index}, value)},onChange:function(newValue,oldValue){doChangeSerialEnd(${param.index},newValue,oldValue)}"/></td>
			<th><span class="remind">*</span>流水步长</th>
			<td><input id="serialStep_${param.index}" name="serialStep" class="easyui-numberbox" data-options="required:false,min:1,max:1000000" /></td>
			<th colspan="2">
				<span class="block-box">
					<input type="checkbox" class="checkbox" id="isInputSerial_${param.index}" name="isInputSerial" value="Y" />
					<span title="选中可以输入流水号，否则不可以输入" class="checkbox-text">是否可输入流水号</span>
				</span>
			</th>
		</tr>
		<tr id="tdCount_${param.index}" style="display: none">
			<th><span class="remind">*</span>格式化</th>
			<td colspan="3">
				<input id="format_${param.index}" name="format" class="easyui-combobox" data-options="editable:false,panelHeight: 100,valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getCountFormatDate.json'" />
			</td>
			<th colspan="4" style="padding-left: 50px">
				<span class="block-box">
					<input type="checkbox" class="checkbox" id="isCurrentTime_${param.index}" name="isCurrentTime" value="Y" />
					<span title="选中获取服务器默认时间，否则自己选择时间" class="checkbox-text">是否默认当前时间</span>
				</span>
			</th>
		</tr>
		<tr id="tdFunc_${param.index}" style="display: none">
			<th><span class="remind">*</span>函数全路径</th>
			<td colspan="7" title="输入函数全路径，包括调用方法">
				<input id="func_${param.index}" name="func" class="easyui-validatebox" data-options="required:false,validType:'length[0,200]'" />
			</td>
		</tr>
		<tr id="tdSQL_${param.index}" style="display: none">
			<th><span class="remind">*</span>SQL语句</th>
			<td colspan="7" title="输入SQL语句">
				<textarea class="easyui-validatebox textareabox" id="sqlExpression_${param.index}" name="sqlExpression" data-options="required:false,validType:'length[0,2000]'" style="height:60px!important;"></textarea>
			</td>
		</tr>
	</table>
</form>