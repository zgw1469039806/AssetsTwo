<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加自编代码规则</title>
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
		        url:'avicit/platform6/modules/system/syscodingrule/sysCodingRuleAddContent.jsp?index=' + i,
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
		    			    closable: false
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
		//码段长度可以修改
		$('#segmentLength_' + index).attr("readonly", false);
		$('#segmentLength_' + index).parent().removeClass('input-readonly');
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
  * 选择了通用码段
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
	<div id="tabControlList" class="easyui-tabs" data-options="onSelect: fushTabByTabIndex" tabPosition="top" fit="true" border="false" style="padding:0px;">
		<!-- 基本设置显示区域 -->
		<div title="基本设置">
		   <form id="formRuleBase" method="post" style="padding: 15px 25px 0 0;"> 
				<table class="form_commonTable">
					<tr>
						<th width="15%"><span class="remind">*</span>规则名称</th>
						<td colspan="3"><input id="codingName" name="codingName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" /></td>
					</tr>
					<tr>
						<th><span class="remind">*</span>规则编号</th>
						<td width="35%"><input id="codingCode" name="codingCode" class="easyui-validatebox" required="true" data-options="validType:['code','length[0,30]']" /></td>
						<th width="15%"><span class="remind">*</span>码段个数</th>
						<td><input id="segmentNumber" name="segmentNumber" class="easyui-numberbox" required="true" data-options="min:1,max:10,onChange: doChangeSegmentNumber"/></td>
					</tr>
					<tr>
						<th>说明</th>
						<td colspan="3">
							<textarea class="easyui-validatebox textareabox" id="ruleRemark" name="ruleRemark" data-options="required:false,validType:'length[0,2000]'"  style="height:65px!important;"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
