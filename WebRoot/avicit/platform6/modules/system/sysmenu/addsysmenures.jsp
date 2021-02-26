<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加资源</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.fieldset{
	color: #444;
	line-height:20px;
	width: 95%;
	display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' class='form'> 
		<input type="hidden" name='id' id='id' value=''/>
		<input type="hidden" name='tlId' id='tlId' value=''/>
		<table class="form_commonTable">
			<tr>
				<th width="20%"><span class="remind">*</span>资源名称:</th>
                <td width="80%">
                    <input title="菜单名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" type="text" name="name" id="name" />
                </td>
			</tr>
			<!-- <tr>
				<th width="20%"><span class="remind">*</span>菜单代码:</th>
                <td width="80%">
                    <input title="菜单代码" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" type="text" name="code" id="code" />
                </td>
			</tr> -->
			<!-- <tr>
				<th width="20%">图标引用地址:</th>
                <td width="80%">
                    <input title="图标引用地址" class="easyui-validatebox" data-options="width:546,editable:false,panelHeight:'auto'" type="text" name="image" id="image" />
                </td>
			</tr> -->
			<tr>
				<th width="20%">资源路径:</th>
                <td width="80%">
                    <input title="菜单路径" class="easyui-validatebox" type="text" name="url" id="url" />
                </td>
			</tr>
			<tr>
				<th width="20%">排序编号:</th>
                <td width="80%">
                    <input title="排序编号" class="easyui-numberbox" data-options="min:0,precision:0" type="text" name="orderBy" id="orderBy" />
                </td>
			</tr>
			<%-- <tr>
				<th>菜单组:</th>
                <td>
                    <pt6:syslookup name="menuGroup" isNull="false" lookupCode="PLATFORM_MENU_GROUP" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup>
                </td>
			</tr>
			<tr>
				<th>菜单类型:</th>
				<td>
					<span class="block-box"><input type="radio" title="功能菜单" class="radiobox" name="type" id="type1" value="1" checked/><span class="radiobox-text"><label for="type1">功能菜单</label></span></span>
					<span class="block-box"><input type="radio" title="门户小页" class="radiobox" name="type" id="type2" value="2" /><span class="radiobox-text"><label for="type2">门户小页</label></span></span>
				</td>
			</tr> --%>
			<tr>
				<th>资源状态:</th>
				<td>
					<span class="block-box"><input type="radio" title="启用" class="radiobox" name="status" id="status1" value="1" checked/><span class="radiobox-text"><label for="status1">启用</label></span></span>
					<span class="block-box"><input type="radio" title="禁用" class="radiobox" name="status" id="status2" value="0" /><span class="radiobox-text"><label for="status1">禁用</label></span></span>
				</td>
			</tr>
			<!-- <tr>
				<th>是否Robbin:</th>
				<td>
					<span class="block-box"><input type="radio" title="是" class="radiobox" name="isRobbin" id="isRobbin1" value="1" checked/><span class="radiobox-text"><label for="status1">是</label></span></span>
					<span class="block-box"><input type="radio" title="否" class="radiobox" name="isRobbin" id="isRobbin2" value="0" /><span class="radiobox-text"><label for="status1">否</label></span></span>
				</td>
			</tr> -->
			<tr>
				<th>资源视图:</th>
				<td>
					<input title="菜单视图文件路径" class="easyui-validatebox" type="text" name="menuView" id="menuView" />
				</td>
			</tr>
			<tr>
				<th>资源描述:</th>
				<td>
					<textarea title='菜单描述' class="textareabox" rows="3" cols="1" name="comments" id="comments" ></textarea>
				</td>
			</tr>
		</table>
	</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
    	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                       <a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
                       <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
                   </td>
                </tr>
            </table>
        </div>
    </div>
	<script type="text/javascript">
		
		function closeForm(){
			parent.sysMenu.closeDialog("#insertRes");
		}
		function saveForm(){
			var name =$('#name').val();
			if(name.length ===  0){
				alert("资源名称不能为空！");
				return;
			}
			if(name.length >50){
				alert("资源名称不能超过50个字！");
				return;
			}
			var order =$('#orderBy').val();
			if(order>65535){
				alert("排序号不能超过65535");
				$('#orderBy').numberbox('setValue', 5000);
				return;
			}
			parent.sysMenu.save(serializeObject($('#form')),'${url}','#insertRes','${id}');
		}
	</script>
</body>
</html>