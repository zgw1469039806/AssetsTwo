<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代码规则码值管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 初始化数据
 */
$(function(){
	$('input[name="searchNameOrValue"]').each(function(){
		var id = $(this).attr('id');
		var segmentIndex = id.replace("searchNameOrValue", "");
		$(this).on('keyup',function(e){
			if(e.keyCode == 13){
				doSearch(segmentIndex);
			}
		});
	});
});

/**
 * 当前码段tab页签的切换时触发
 */
function fushTabByTabIndex(title, index){
	if(title != null ){
		loadData(index + 1);
	}
}

/**
 * 初始化表格列和装载数据
 */
function loadData(segmentIndex){
	//判断表格是否已经初始化，已经初始化了不在执行
	var isLoaded = $("#datagrid" + segmentIndex).hasClass('easyui-datagrid'); 
	if(isLoaded){
		return;
	}
	
	var baseId = $('#baseId').val();
	var searchParam = {
		baseId: baseId,
		segmentIndex: segmentIndex
	};

	$.ajax({
        cache: false,
        type: "POST",
        url:'platform/sysCodingRuleController/getSegmentValuesTableData.json',
        data : searchParam,
        dataType:"json",
        async: false,
        timeout:10000,
        error: function(request) {
        	
        },
        success: function(data) {
        	//根据类型得到码值的标题
        	var segmentType = data.segmentType;
        	if(segmentType == '3'){
        		var columnArray = new Array();
				
				if(data.columnTitleList.length > 0){
					for(var i = 0; i < data.columnTitleList.length; i++){
						var columnField = data.columnFieldList[i];
						var columnTitle = data.columnTitleList[i];
						var week = {field: columnField, title: columnTitle, align:'center', width:100};
						columnArray.push(week);
					}
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30, rowspan: 2},
						          {title: '依赖值', align:'center', colspan: data.columnTitleList.length},
						          {field:'segmentValue',title: '最大流水号', align:'center', width:100, rowspan: 2}],
						         columnArray]
					});
				}else{
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30},
						         {field:'segmentValue',title: '最大流水号', align:'center', width:100}]]
					});
				}
        	}else{
        		var columnArray = new Array();
				
				if(data.columnTitleList.length > 0){
					for(var i = 0; i < data.columnTitleList.length; i++){
						var columnField = data.columnFieldList[i];
						var columnTitle = data.columnTitleList[i];
						var week = {field: columnField, title: columnTitle, align:'center', width:100};
						columnArray.push(week);
					}
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30, rowspan: 2},
						          {title: '依赖值', align:'center', colspan: data.columnTitleList.length},
						          {field:'segmentName',title: '码名称', align:'center', width:100, rowspan: 2},
						          {field:'segmentValue',title: '码值', align:'center', width:100, rowspan: 2},
						          {field:'orderBy',title: '排序', align:'center', width:100, rowspan: 2}],
						         columnArray]
					});
				}else{
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30},
						          {field:'segmentName',title: '码名称', align:'center', width:100},
						          {field:'segmentValue',title: '码值', align:'center', width:100},
						          {field:'orderBy',title: '排序', align:'center', width:100}]]
					});
				}
        	}
        }
    });
}

/**
 * 刷新表格
 */
function reloadDatagrid(segmentIndex, searchNameOrValue, isClearSelections){
	var baseId = $('#baseId').val();
	var searchParam = {
		baseId: baseId,
		segmentIndex: segmentIndex,
		searchNameOrValue: searchNameOrValue
	};
	$('#datagrid' + segmentIndex).datagrid('options').url = 'platform/sysCodingRuleController/getSegmentValuesTableData.json';
	$('#datagrid' + segmentIndex).datagrid('options').queryParams = searchParam;
	$('#datagrid' + segmentIndex).datagrid('reload');
	if(isClearSelections){
		$('#datagrid' + segmentIndex).datagrid('uncheckAll');
		$('#datagrid' + segmentIndex).datagrid('unselectAll');
		$('#datagrid' + segmentIndex).datagrid('clearSelections');
	}
}

/**
 * 查询
 */
function doSearch(segmentIndex){
	var searchNameOrValue = $('#searchNameOrValue' + segmentIndex).val();
	reloadDatagrid(segmentIndex, searchNameOrValue, true);
}

/**
 * 增加规则码值
 */
function addSegmentValue(segmentIndex){
	var baseId = $('#baseId').val();
	var usd = new CommonDialog("addSegmentValueDialog","450","265","platform/sysCodingRuleController/toAddSegmentValueJsp?baseId="+ baseId +"&segmentIndex=" + segmentIndex,"添加码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#addSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				$(this).linkbutton('enable');
				return false;
			}
			
			var dataValue = frm.$('#formSegmentValue').serializeArray();
			var dataValueJson = convertToJson(dataValue);
			dataValue = JSON.stringify(dataValueJson);
			
			var param = {
				dataValue: dataValue
			};
			
			$.ajax({
                cache: false,
                type: "POST",
                url:'platform/sysCodingRuleController/addSegmentValue',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						usd.close();
						$('#searchNameOrValue' + segmentIndex).val('');
						reloadDatagrid(segmentIndex, '', true);
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'此规则已经发布，不能编辑码值'});
						}else if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码名称重复'});
						}else if(result.isExistsValue == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码值重复'});
						}else if(result.error != null && result.error != ''){
							$.messager.show({title:'提示',msg :'保存失败！' + result.error});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
						$('#formSubimt').linkbutton('enable');
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 更新规则码值
 */
function updateSegmentValue(segmentIndex){
	var checked = $('#datagrid' + segmentIndex).datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	
	var baseId = $('#baseId').val();
	var usd = new CommonDialog("updateSegmentValueDialog","450","265","platform/sysCodingRuleController/toUpdateSegmentValueJsp?id="+ id +"&baseId="+ baseId +"&segmentIndex=" + segmentIndex,"编辑码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#updateSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				$(this).linkbutton('enable');
				return false;
			}
			
			var dataValue = frm.$('#formSegmentValue').serializeArray();
			var dataValueJson = convertToJson(dataValue);
			dataValue = JSON.stringify(dataValueJson);
			
			var param = {
				dataValue: dataValue
			};
			
			$.ajax({
                cache: false,
                type: "POST",
                url:'platform/sysCodingRuleController/updateSegmentValue',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						usd.close();
						reloadDatagrid(segmentIndex, $('#searchNameOrValue' + segmentIndex).val(), false);
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！此规则已经发布，不能编辑码值'});
						}else if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码名称重复'});
						}else if(result.isExistsValue == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码值重复'});
						}else if(result.error != null && result.error != ''){
							$.messager.show({title:'提示',msg :'保存失败！' + result.error});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
						$('#formSubimt').linkbutton('enable');
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 删除规则码值
 */
function deleteSegmentValue(segmentIndex){
	var checked = $('#datagrid' + segmentIndex).datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	
	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var baseId = $('#baseId').val();
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		baseId: baseId,
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingRuleController/deleteSegmentValue',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						reloadDatagrid(segmentIndex, $('#searchNameOrValue' + segmentIndex).val(), true);
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'删除失败！此规则已经发布，不能删除码值'});
						}else if(result.error != null && result.error != ''){
							$.messager.show({title:'提示',msg :'删除失败！' + result.error});
						}else {
							$.messager.show({title:'提示',msg :'删除失败！'});
						}
					}
				}
			});
        }
    });	
}
</script>
</head>
<body class="easyui-layout" >
<iframe id="loadFileIframe" style="display: none"></iframe>
<input type="hidden" id="baseId" name="baseId" value="${ruleBase.id }">
<div region="center" border="false">
<div id="tabRuleSegmentValues" data-options="onSelect: fushTabByTabIndex" class="easyui-tabs" tabPosition="top" fit="true" border="false" style="padding:0px;" >
	<c:forEach items="${segmentList}"  var="segment" varStatus="segmentStatus">
		<div title="${segment.segmentName}">
			<table id="datagrid${segment.segmentIndex}" 
				data-options="
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					method: 'post',
					idField: 'id',
					<c:if test="${ruleBase.status == '1' && segment.segmentType == '1' && segment.comSegmentId == null}">toolbar:'#toolbar${segment.segmentIndex}',</c:if>
					singleSelect: false,
					checkOnSelect: true,
					selectOnCheck: true
				">
			</table>
			<c:if test="${ruleBase.status == '1' && segment.segmentType == '1' && segment.comSegmentId == null}">
			<div id="toolbar${segment.segmentIndex}" class="datagrid-toolbar" style="height:auto;">
				<div style="padding:0 0 0 5px;">
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_addButton" >
						<a id="addButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_updateButton" >
						<a id="updateButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-edit"  plain="true" onclick="updateSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_deleteButton" >
						<a id="deleteButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_addButton" >
						<span style="word-wrap: break-word;margin-left: 15px;">
							<span>码名称/码值</span>
							<input class="easyui-validatebox" id="searchNameOrValue${segment.segmentIndex}" name="searchNameOrValue" style="width: 150px" value=""/>
							<a id="searchButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="doSearch(${segment.segmentIndex});" href="javascript:void(0);">查询</a>
						</span>
					</sec:accesscontrollist>
				</div>
			</div>
			</c:if>
		</div>
	</c:forEach>
</div>
</div>
</body>
</html>
