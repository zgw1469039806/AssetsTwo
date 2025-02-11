<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.quartz.dto.Job"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>添加任务</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/extend/easyui.subwindow.js" type="text/javascript"></script>
<script type="text/javascript">
/**
 * 返回排除日期宽度
 * @returns
 */
function getCalendarWidth(){
	return parseInt($(window).width()*0.5);
}

/**
 * 返回排除日期高度
 * @returns
 */
function getHeight(){
	return parseInt(($(window).height()-180)*0.5);
}

/**
 * 添加定时任务
 */
function addJob(){
	$('#addJobButton').linkbutton('disable');
	
	//form验证
	var r = $('#formJob').form('validate');
	if(!r){
		$('#addJobButton').linkbutton('enable');
		return false;
	}
	
	//获取基本信息
	var job =  $('#formJob').serializeArray();
	var jobJson = convertToJson(job);
	job = JSON.stringify(jobJson);
	
	//参数列表验证
	accept();
	var variables = $('#datagridVariables').datagrid('getRows');
	for(var i = 0; i < variables.length; i++){
		var name = $.trim(variables[i].name);
		var dataType = variables[i].dataType;
		var value = $.trim(variables[i].value);
		
		if (name == "" || dataType == "" || value == "") {
			$.messager.alert('提示','参数名称、类型和值不能为空，请检查。','info');
            $('#addJobButton').linkbutton('enable');
            return false;
		}
		
		if(value.byteLength() > 100){
			$.messager.alert('提示','参数值超过长度！','info');
			$('#addJobButton').linkbutton('enable');
			return false;
		}

		if (dataType == "Long" || dataType == "Integer") {
			if (isNaN(value) || String(parseInt(value)).length != value.length) {
	            $.messager.alert('提示','参数类型指定为整型或长整型，参数值不匹配，请检查。','info');
	            $('#addJobButton').linkbutton('enable');
	            return false;
	        } 
		}else if(dataType == "Float"){
			if (isNaN(value) || String(parseFloat(value)).length != value.length) {
                $.messager.alert('提示','参数类型指定为浮点型，参数值不匹配，请检查。','info');
	            $('#addJobButton').linkbutton('enable');
	            return false;
            } 
		}else if(dataType == "Date"){
			if (isDate(value) == false) {
                $.messager.alert('提示','参数类型指定为日期类型，参数值不匹配，请检查。日期格式为yyyyMMdd。','info');
	            $('#addJobButton').linkbutton('enable');
	            return false;
            } 
		}
	}
	
	//获取排除日历ID
	var calendarChecked = $('#datagridCalendar').datagrid('getChecked');
	var idArray = new Array();
	for (var i = 0; i < calendarChecked.length; i++){
		idArray[i] = calendarChecked[i].id;
	}
	
	//组合成参数
	var param = {
		job: job,
		jobCalendarIds: idArray.join(','),
		variables: JSON.stringify(variables)
	};
	
	$.ajax({
		url : 'platform/jobMaintainController/addJob',
		data : param,
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == 'success') {
				parent.successAddJob();
			} else {
				$('#addJobButton').linkbutton('enable');
				if(result.error){
					$.messager.show({title:'提示',msg :'添加定时任务失败！' + result.error});
				}else{
					$.messager.show({title:'提示',msg :'添加定时任务失败！'});
				}
			}
		}
	});
}

/**
 * 是否指定的日期格式,yyyyMMdd
 */
function isDate(dateString){
    if(dateString == ""){
    	return false;
    }
    var pattern = /^[1-9]\d{3}((0[1-9]{1})|(1[0-2]{1}))((0[1-9]{1})|([1-2]{1}\d{1})|(3[0-1]{1}))$/;
    if(!pattern.test(dateString)){
        return false;
    }
    return true;
 } 

/**
 * 返回
 */
function doCancel(){
	parent.closeDialog();
}

/**
 * 改变任务类型时
 */
function onChangeType(newValue, oldValue){
	setTypeRemark(newValue);
	if(newValue == 'spring'){
		var usd = new CommonDialog("selectBeanDialog","550","300","avicit/platform6/modules/system/quartz/selectBean.jsp","选择Bean和函数",true,true,false);
		usd.show();
		
		/**
		 * 关闭页面
		 */
		closeSelectBeanDialog = function(result) {
			$('#program').val(result);
			usd.close();
		};
	}
}

/**
 * 设置类型说明
 */
function setTypeRemark(type){
	var typeRemark = "";
	if(type == 'spring'){
		typeRemark = "注册在Spring中的Bean#方法名,例如springBeanId#methodName";
	}else if(type == 'clazz'){
		typeRemark = "类的全路径#方法,例如com.demo.test.Test#sayHello";
	}else if(type == 'quartzClazz'){
		typeRemark = "类的全路径并且该类继承自org.quart.Job接口,例如com.demo.test.Test";
	}else if(type == 'sql'){
		typeRemark = "SQL语句";
	}else if(type == 'sp'){
		typeRemark = "存储过程名称";
	}
	$('#typeRemark').val(typeRemark);
}

/**
 * 格式化状态
 */
function formatterDataType(value, row, index){      
	var dataType = "";
	if(value == 'String'){
		dataType = "字符串";
	}else if(value == 'Integer'){
		dataType = "整型";
	}else if(value == 'Long'){
		dataType = "长整型";
	}else if(value == 'Float'){
		dataType = "浮点型";
	}else if(value == 'Date'){
		dataType = "日期类型";
	}
	return dataType;
}

/**
 * 选择日历，刷新其下的排除日期
 */
function onSelectCalendar(rowIndex, rowData){
	$('#datagridCalendarDate').datagrid('options').url = 'platform/jobCalendarController/loadJobCalendarDates.json';
	$('#datagridCalendarDate').datagrid('load',{
		jobCalenderId: rowData.id
	});
}

/**
 * 打开表达式页面
 */
function openSelectCron(){
	var usd = new CommonDialog("selectBeanDialog","660","520","avicit/platform6/modules/system/quartz/cronGenerator.jsp","选择执行时间",true,true,false);
	usd.show();
	
	/**
	 * 获取表达式(名称固定)
	 */
	getCronExpr = function(cronExpr) {
		return $('#cron').subwindow('getValue');
	};
	
	/**
	 * 成功后调用
	 */
	doSelectCronSuccess = function(cronExpr) {
		$('#cron').subwindow('setValue', cronExpr);
		usd.close();
	};
	
	/**
	 * 关闭页面
	 */
	 closeDialog = function(result) {
		usd.close();
	};
}

/**
 * ******************编辑单元格开始******************
 */
 
//当前编辑index
var editIndex = undefined;

/**
 * 是否正在编辑单元格，正在编辑的单元格修改并结束编辑
 * @returns {Boolean}
 */
function endEditing(){
	if (editIndex == undefined){
		return true;
	}
	if ($('#datagridVariables').datagrid('validateRow', editIndex)){
		$('#datagridVariables').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}

/**
 * 点击编辑单元格
 * @param index
 * @returns {Boolean}
 */
function onClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			$('#datagridVariables').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#datagridVariables').datagrid('selectRow', editIndex);
		}
	}
}

/**
 *增加一行
 */
function append(){
    if (endEditing()){
        $('#datagridVariables').datagrid('appendRow',{});
        editIndex = $('#datagridVariables').datagrid('getRows').length-1;
        $('#datagridVariables').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

/**
 * 删除一行
 */
function removeit(){
    if (editIndex == undefined){
    	return;
    }
    $('#datagridVariables').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
    editIndex = undefined;
}

/**
 * 接受改变的值
 */
function accept(){
    if (endEditing()){
        $('#datagridVariables').datagrid('acceptChanges');
    }
}
/**
 * ******************编辑单元格结束******************
 */

/**
 * 删除参数
 */
function removeVariables(){
	 removeit();
	 
	 var rows = $('#datagridVariables').datagrid('getRows');
	 if(rows.length == 0){
		 $.messager.alert('提示','参数列表为空，没有可删除的数据！','warning');
	 }else{
		 var selected = $('#datagridVariables').datagrid('getSelected');
		 if(selected == null){
			 onClickRow(0);
		 }
	 }
}
</script>
</head>
<body class="easyui-layout" fit="true">
	<!-- 属性 -->
	<div data-options="region:'north'" split="false" border="false" style="height: 215px;">
		<form id="formJob" fit="true">
			<input type="hidden" name="status" value="S">
			<table class="form_commonTable">
				<tr>
					<th width="10%"><span class="remind">*</span>任务分组</th>
                	<td width="40%">
                    	<input id="group" name="group" title="任务分组" class="easyui-combobox" type="text" value="<%=Job.DEFAULT_GROUP %>"
						    data-options="required:true,editable:false,panelHeight:'auto',valueField:'name',textField:'description',
						    url:'platform/jobMaintainController/loadGroups.json'" />
                	</td>
                	<th width="10%"><span class="remind">*</span>任务名称</th>
                	<td>
                    	<input id="name" name="name" title="任务名称" class="easyui-validatebox" type="text" data-options="required:true,validType:'maxByteLength[50]'" />
                	</td>
                </tr>
                <tr>
                	<th><span class="remind">*</span>任务类型</th>
                	<td>
                    	<input id="type" name="type" title="任务类型" class="easyui-combobox" 
						    data-options="required:true,editable:false,panelHeight:'auto',
							onChange:onChangeType,valueField:'label',textField:'value',
							data: [{label: 'spring',value: 'SpringBean'},
							       {label: 'clazz',value: 'Java类'},
							       {label: 'quartzClazz',value: 'Quartz Job'},
							       {label: 'sql',value: 'Sql语句'},
							       {label: 'sp',value: '存储过程'}]" /> 
                	</td>
                	<th><span class="remind">*</span>表达式</th>
                	<td>
                    	<input id="cron" name="cron" title="表达式" class="easyui-subwindow" type="text" data-options="required:true,editable:false,onClick:openSelectCron" value="0/5 0/6 * ? * *" />
                	</td>
                </tr>
                <tr>
                	<th>类型说明</th>
                	<td colspan="3" class="input-readonly">
                    	<input id="typeRemark" name="" title="类型说明" class="easyui-validatebox" type="text" data-options="required:false" value="" readonly="readonly"/>
                	</td>
                </tr>
                <tr>
                	<th><span class="remind">*</span>执行程序</th>
                	<td colspan="3">
                    	<input id="program" name="program" title="执行程序" class="easyui-validatebox" type="text" data-options="required:true,validType:'maxByteLength[1000]'" value="" />
                	</td>
                </tr>
                <tr>
                	<th>描述</th>
                	<td colspan="3">
                    	<input id="description" name="description" title="描述" class="easyui-validatebox" type="text" data-options="required:false,validType:'maxByteLength[200]'" value="" />
                	</td>
                </tr>
            </table>
		</form>
	</div>
	<!-- 参数列表 -->
	<div data-options="region:'center'" split="false" collapsible="false" border="false" >
		<div class="easyui-tabs" fit="true">
			<div title="参数列表">
				<table id="datagridVariables" class="easyui-datagrid" 
					data-options="
						fit: true,
						border:false,
						rownumbers: true,
						animate: true,
						collapsible: false,
						fitColumns: true,
						autoRowHeight: false,
						singleSelect: true,
						toolbar:'#toolbarParam',
						onClickRow: onClickRow
					">
					<thead>
						<tr>
							<th data-options="field:'name', halign:'center', align:'left',editor:{type:'validatebox'}" width="100">参数名称</th>
							<th data-options="field:'dataType', halign:'center', align:'left',formatter:formatterDataType,
			                        editor:{
			                            type:'combobox',
			                            options:{
			                                editable:false,
			                                panelHeight:'auto',
			                                valueField:'label',
			                                textField:'value',
			                                data: [{label: 'String',value: '字符串'},
									               {label: 'Integer',value: '整型'},
									               {label: 'Long',value: '长整型'},
									               {label: 'Float',value: '浮点型'},
									               {label: 'Date',value: '日期类型'}]
			                            }
			                        }" width="100">数据类型</th>
							<th data-options="field:'value', halign:'center', align:'left',editor:{type:'validatebox'}" width="100">参数值</th>
						</tr>
					</thead>
				</table>
				<div id="toolbarParam" class="datagrid-toolbar" style="height:auto;display: block;padding:0 0 0 10px;">
					<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="append();" href="javascript:void(0);">增加</a>
					<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeVariables();" href="javascript:void(0);">删除</a>
				</div>
			</div>
			<div title="排除日期">
				<div class="easyui-layout" fit="true">
					<!-- 日历名称 -->
					<div data-options="region:'center',split:true" style="border-left: 0;border-bottom: 0;border-top: 0;">
						<table id="datagridCalendar" class="easyui-datagrid" 
							data-options="
								fit: true,
								border:false,
								rownumbers: true,
								animate: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								singleSelect: false,
								idField: 'id',
								method: 'post',
								url: 'platform/jobCalendarController/loadJobCalendars.json',
								onSelect: onSelectCalendar
							">
							<thead>
								<tr>
									<th data-options="field:'checkbox', checkbox: true, halign:'center', align:'center'" width="30"></th>
									<th data-options="field:'name', halign:'center', align:'left'" width="100">日历名称</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- 日历描述 -->
					<div data-options="region:'east',split:true,width: getCalendarWidth()" style="border-right: 0;border-bottom: 0;border-top: 0;">
						<table id="datagridCalendarDate" class="easyui-datagrid" 
							data-options="
								fit: true,
								border:false,
								rownumbers: true,
								animate: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								singleSelect: true,
								method: 'post'
							">
							<thead>
								<tr>
									<th data-options="field:'excludedDate', halign:'center', align:'left',formatter:formatColumnDate" width="100">排除的日期</th>
									<th data-options="field:'description', halign:'center', align:'left'" width="100">描述</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<!-- 按钮  -->
	<div data-options="region:'south'" split="false" style="height:40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
              	<tr>
                  	<td align="right">
                  		<a title="保存" id="saveButton"  class="easyui-linkbutton primary-btn" plain="false" onclick="addJob();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton"  class="easyui-linkbutton" plain="false" onclick="doCancel();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>