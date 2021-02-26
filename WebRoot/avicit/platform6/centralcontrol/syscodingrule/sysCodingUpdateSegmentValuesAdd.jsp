<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加码值</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	//去除输入的空格
	$('#segmentName,#segmentValue').bind('input propertychange', function() {
		var newValue = $.trim($(this).val());
		if(newValue != $(this).val()){
			$(this).val(newValue);
		}
	}); 
});

/**
 * 修改依赖码值
 */
function doChangeSegmentValue(newValue, oldValue, index, segmentIndex){
	var _index = index + 1;
	if($('#segmentValue' + _index).length > 0){
		while($('#segmentValue' + _index).length > 0){
			$('#segmentValue' + _index).combobox('setValue','');
			$('#segmentValue' + _index).combobox('reload');
			_index++;
		}
	}else{
		setDependValues(index);
	}
}

/**
 * 加载码值数据前修改参数
 */
function doBeforeLoad(param, index, segmentIndex){
	var baseId = $('#baseId').val();
	param.baseId = baseId;
	param.segmentIndex = segmentIndex;

	for(var i = 0; i < index; i++){
		var value = $('#segmentValue' + i).combobox('getValue');
		if(value == null || value == ''){
			return false;
		}
		var _segmentIndex = $('#segmentValue' + i).attr("segmentIndex");
		param['segmentValue' + _segmentIndex] = value;
	}
	
	return true;
}

/**
 * 修改分类码值关联
 */
function setDependValues(index){
	var dependValues = '';
	for(var i = 0; i <= index; i++){
		if($('#segmentValue'+ i).length > 0){
			var segmentValue = $('#segmentValue'+ i).combobox('getValue');
			if(dependValues == ''){
				dependValues += segmentValue;
			}else{
				dependValues += '@@' + segmentValue;
			}
		}
	}
	$('#dependValues').val(dependValues);
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
   <form id="formSegmentValue" fit="true" style="padding: 5px 15px 40px 0;">
		<input id="baseId" name="baseId" type="hidden" value="${segment.baseId}"/>
		<input id="segmentIndex" name="segmentIndex" type="hidden" value="${segment.segmentIndex}"/>
		<input id="dependValues" name="dependValues" type="hidden" value=""/>
		<table class="form_commonTable">
			<c:if test="${segment.segmentRelation != null && segment.segmentRelation != ''}">
				<c:forTokens var="num" items="${segment.segmentRelation}" delims="@@" varStatus="numStatus">
					<c:if test="${numStatus.last }"><c:set value="${numStatus.count }" var="segmentCount"></c:set></c:if>
				</c:forTokens>
				<c:forTokens var="num" items="${segment.segmentRelation}" delims="@@" varStatus="numStatus">
					<tr>
						<th width="100px"><span class="remind">*</span>码段${num}(依赖)</th>
						<td>
							<input id="segmentValue${numStatus.index}" segmentIndex="${num}" class="easyui-combobox" required="true"
								data-options="
									url:'platform/cc/sysCodingRule/getSegmentValuesData.json',
									editable:false,
									panelHeight:100,
									onChange:function(newValue, oldValue){ doChangeSegmentValue(newValue, oldValue, ${numStatus.index}, ${num});},
									onBeforeLoad: function(param){ return doBeforeLoad(param, ${numStatus.index}, ${num});},
									valueField:'code',
									textField:'name'" />
						</td>	
					</tr>
				</c:forTokens>
			</c:if>
			<tr>
				<th <c:if test="${segment.segmentRelation == null || segment.segmentRelation == ''}">width="70px"</c:if>><span class="remind">*</span>码名称</th>
				<td><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[1,100]'" /></td>
			</tr>
			<tr>
				<th><span class="remind">*</span>码值</th>
				<td>
					<c:choose>
						<c:when test="${segment.segmentLength gt 0}">
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" data-options="invalidMessage:'码值的长度必须为${segment.segmentLength }位',validType:'length[${segment.segmentLength },${segment.segmentLength }]'" />
						</c:when>
						<c:otherwise>
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" data-options="invalidMessage:'码段长度不能大于50',validType:'length[1,50]'"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th><span class="remind">*</span>排序</th>
				<td><input id="orderBy" name="orderBy" class="easyui-numberbox" required="true" data-options="min:1,max:10000" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
