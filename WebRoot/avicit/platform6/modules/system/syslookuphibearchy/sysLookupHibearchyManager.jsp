<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多维通用代码</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 返回tab页签高度
 * @returns
 */
function getTabWidth(){
	return parseInt($(window).width()*0.25);
}

/**
 * 选择事件
 */
function doClick(node){
	$("#formHibearchy").form('clear');
	$.ajax({
		url : 'platform/sysLookupHibearchy/getHibearchy',
		data : {id : node.id},
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if(result && result.bean){
				$("#formHibearchy").form('load', result.bean);
			}
		}
	});
}

/**
 * 获取节点属于树的第几层
 */
function getLevel(node){
	var level = 0;
	var _node = node;
	while(_node != null){
		level++;
		_node = $('#sysLookupHibearchyTree').tree('getParent', _node.target);
	}
	return level;
}

/**
 * 获取节点的lookupType值
 */
function getLookupType(id){
	var lookupType = '';
	var node = $('#sysLookupHibearchyTree').tree('find', id);
	if(node){
		lookupType = node.attributes.lookupType;
	}
	return lookupType;
}

/**
 * 增加平级节点
 */
function addHibearchy(){
	var node = $('#sysLookupHibearchyTree').tree('getSelected');
	if (node){
		var parentId = node.attributes.parentId;
		
		if(parentId == "-1"){
			$.messager.alert('提示','根节点不能添加平级节点！','info');
			return false;
		}
		var level = getLevel(node);
		var parentNode = $('#sysLookupHibearchyTree').tree('getParent', node.target);
		doAddHibearchy(parentId, level, parentNode);
	}
}

/**
 * 添加子节点
 */
function addHibearchySub(){
	var node = $('#sysLookupHibearchyTree').tree('getSelected');
	if (node){
		var id = node.id;
		var level = getLevel(node);
		level = level + 1; //子节点加1
		doAddHibearchy(id, level, node);
	}
}

/**
 * 添加节点
 */
function doAddHibearchy(parentId, level, parentNode){
	var lookupTypeReadOnly = false;
	if(level > 2){
		lookupTypeReadOnly = true;
	}
	var url = "avicit/platform6/modules/system/syslookuphibearchy/sysLookupHibearchyAdd.jsp?parentId="+ parentId +"&lookupTypeReadOnly="+ lookupTypeReadOnly;
	var usd = new CommonDialog("addHibearchyDialog","680","460",url,"添加",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			var frmId = $('#addHibearchyDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formHibearchy').form('validate');
			if(!r){
				return false;
			}
			
			var dataVo = frm.$('#formHibearchy').serializeArray();
			var dataJson = convertToJson(dataVo);
			dataVo = JSON.stringify(dataJson);

			var param = {
				dataVo: dataVo
			};
			
			$.ajax({
                cache:false,
                type: "POST",
                url:'platform/sysLookupHibearchy/addHibearchy',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						var treeNode = {
							id: result.bean.id,
							text: result.bean.typeValue,
							iconCls: 'icon-dept',
							attributes: {
								parentId: result.bean.parentId, 
								lookupType: result.bean.lookupType
							}
						};
						$('#sysLookupHibearchyTree').tree('append',{
							parent: parentNode.target,
							data: [treeNode]
						});
						usd.close();
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.errors){
							$.messager.show({title:'提示',msg :'保存失败！<br/>' + result.errors});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 编辑
 */
function updateHibearchy(){
	var node = $('#sysLookupHibearchyTree').tree('getSelected');
	if (node){
		var parentId = node.attributes.parentId;
		if(parentId == "-1"){
			$.messager.alert('提示','根节点不能编辑！','info');
			return false;
		}
		
		var level = getLevel(node);
		var id = node.id;
		
		$.ajax({
            cache:false,
            type: "POST",
            url:'platform/sysLookupHibearchy/isHasChirdren',
            dataType:"json",
            data: {id: id},
            async: false,
            timeout:10000,
            error: function(request) {
            	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
            },
            success: function(result) {
            	var lookupTypeReadOnly = false;
            	if (result.isHasChildren == true) {
            		lookupTypeReadOnly = true;
				}else if(level > 2){
					lookupTypeReadOnly = true;
				}
            	
            	doUpdateHibearchy(id, lookupTypeReadOnly, node);
            }
        })
	}
}

/**
 * 执行编辑
 */
function doUpdateHibearchy(id, lookupTypeReadOnly, node){
	var url = "avicit/platform6/modules/system/syslookuphibearchy/sysLookupHibearchyUpdate.jsp?id="+ id +"&lookupTypeReadOnly="+ lookupTypeReadOnly;
	var usd = new CommonDialog("updateHibearchyDialog","680","460",url,"编辑",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		isPrimary: true,
		handler:function(){
			var frmId = $('#updateHibearchyDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formHibearchy').form('validate');
			if(!r){
				return false;
			}
			
			var dataVo = frm.$('#formHibearchy').serializeArray();
			var dataJson = convertToJson(dataVo);
			dataVo = JSON.stringify(dataJson);

			var param = {
				dataVo: dataVo
			};
			
			$.ajax({
                cache:false,
                type: "POST",
                url:'platform/sysLookupHibearchy/updateHibearchy',
                dataType:"json",
                data: param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						$('#sysLookupHibearchyTree').tree('update',{
							target:node.target,
							text: result.bean.typeValue,
							attributes: {
								parentId: result.bean.parentId, 
								lookupType: result.bean.lookupType
							}
						});
						usd.close();
						$("#formHibearchy").form('load', result.bean);
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.errors){
							$.messager.show({title:'提示',msg :'保存失败！<br/>' + result.errors});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialogNew(buttons);
	usd.show();
}

/**
 * 删除
 */
function deleteHibearchy(){
	var node = $('#sysLookupHibearchyTree').tree('getSelected');
	if (node){
		var parentId = node.attributes.parentId;
		if(parentId == "-1"){
			$.messager.alert('提示','根节点不能删除！','info');
			return false;
		}
		$.messager.confirm('确认', '您确认删除吗?', function(r){
			if (r){
				var id = node.id;
					
				$.ajax({
					url : 'platform/sysLookupHibearchy/deleteHibearchy',
					data : {id: id},
					type : 'post',
					dataType : 'json',
					success : function(result) {
						if (result.flag == 'success') {
							$('#sysLookupHibearchyTree').tree('remove', node.target);
							$("#formHibearchy").form('clear');
							$.messager.show({title:'提示',msg :'删除成功！'});
						} else {
							if(result.errors){
								$.messager.show({title:'提示',msg :'删除失败！<br/>' + result.errors});
							}else{
								$.messager.show({title:'提示',msg :'删除失败！'});
							}
						}
					}
				});
			 }
		});
	}
}

</script>
</head>
<body class="easyui-layout">
<div region="west" border="true" data-options="width: getTabWidth()" split="true">
	<ul id="sysLookupHibearchyTree" class="easyui-tree" data-options="
		lines : true,
		method : 'post',
		url:'platform/sysLookupHibearchy/getHibearchyTreeData.json',
		onSelect: doClick
		"></ul>
</div>
<div region="center" border="true" style="padding:0;">
	<div class="easyui-layout" fit="true">
		<div region="north" border="false" style="height: 40px;">
			<div class="datagrid-toolbar">
				<!-- 按钮显示区域 -->
		   		<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_button_saveCriterion" >
		   			<a class="easyui-linkbutton" id="buttonAdd" iconCls="icon-add" plain="true" onclick="addHibearchy();" href="javascript:void(0);">添加平级节点</a>
		   		</sec:accesscontrollist>
		   		<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_button_deleteCriterion" >
		   			<a class="easyui-linkbutton" id="buttonAddSub" iconCls="icon-add" plain="true" onclick="addHibearchySub();" href="javascript:void(0);">添加子节点</a>
		   		</sec:accesscontrollist>
		   		<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_button_saveCriterion" >
		   			<a class="easyui-linkbutton" id="buttonEdit" iconCls="icon-edit" plain="true" onclick="updateHibearchy();" href="javascript:void(0);">编辑</a>
		   		</sec:accesscontrollist>
		   		<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_button_deleteCriterion" >
		   			<a class="easyui-linkbutton" id="buttonDelete" iconCls="icon-no" plain="true" onclick="deleteHibearchy();" href="javascript:void(0);">删除</a>
		   		</sec:accesscontrollist>
			</div>
		</div>
		<div region="center" border="false" style="padding-top: 25px;">
		   <form id="formHibearchy" method="post"> 
				<input id="id" name="id" type="hidden" value=""/>
				<input id="parentId" name="parentId" type="hidden" value=""/>
				<input id="version" name="version" type="hidden" value=""/>
				<table class="form_commonTable">
					<tr>
						<th width="12%">系统代码类型</th>
                    	<td class="input-readonly">
                        	<input id="lookupType" name="lookupType" title="系统代码类型" class="easyui-validatebox" type="text" readonly="readonly"/>
                    	</td>
                    </tr>
                    <tr>
                    	<th>使用级别</th>
                    	<td class="input-readonly">
                        	<input id="systemFlag" name="systemFlag" title="使用级别" class="easyui-combobox" readonly="readonly"
							    data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
							    	url:'platform/sysLookupHibearchy/getLookUpJsonData.json?lookUpCode=PLATFORM_USAGE_MODIFIER'" /> 
                    	</td>
                    </tr>
                    <tr>
                    	<th>有效标识</th>
                    	<td class="input-readonly">
                        	<input id="validFlag" name="validFlag" title="有效标识" class="easyui-combobox" readonly="readonly"
							    data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
									url:'platform/sysLookupHibearchy/getLookUpJsonData.json?lookUpCode=PLATFORM_VALID_FLAG'" /> 
                    	</td>
                    </tr>
                    <tr>
                    	<th>多语言</th>
                    	<td class="input-readonly">
                        	<input id="sysLanguageCode" name="sysLanguageCode" title="有效标识" class="easyui-combobox" readonly="readonly"
							    data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
									url:'platform/sysLookupHibearchy/getSysLanguages.json'" /> 
                    	</td>
                    </tr>
                    <tr>
                    	<th>系统代码名称</th>
                    	<td class="input-readonly">
                        	<input id="typeValue" name="typeValue" title="系统代码名称" class="easyui-validatebox" type="text" value="" readonly="readonly"/>
                    	</td>
                    </tr>
                    <tr>
                    	<th>系统代码值</th>
                    	<td class="input-readonly">
                        	<input id="typeKey" name="typeKey" title="系统代码值" class="easyui-validatebox" type="text" value="" readonly="readonly"/>
                    	</td>
                    </tr>
                    <tr>
                    	<th>排序</th>
                    	<td class="input-readonly">
                        	<input id="orderBy" name="orderBy" title="排序" class="easyui-numberbox" type="text" data-options="min:0,max:1000000" value="" readonly="readonly"/>  
                    	</td>
                    </tr>
                    <tr>
                    	<th>备注</th>
                    	<td class="input-readonly">
                        	<textarea style="height: 50px!important;" id="remark" name="remark" class="easyui-validatebox textareabox input-readonly" title="备注" data-options="validType:'maxByteLength[1000]'" readonly="readonly"></textarea>
                    	</td>
                	</tr>
                </table>	
			</form>
		</div>
	</div>
</div>
</body>
</html>
