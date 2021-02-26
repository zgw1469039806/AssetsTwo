<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>国际化语言管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script type="text/javascript">
	//----------------------------------------------------------------------
	//<summary>
	//限制只能输入字母
	//</summary>
	//----------------------------------------------------------------------
	$.fn.onlyAlpha = function () {
	 $(this).keypress(function (event) {
	     var eventObj = event || e;
	     var keyCode = eventObj.keyCode || eventObj.which;
	     if ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
	         return true;
	     else
	         return false;
	 }).focus(function () {
	     this.style.imeMode = 'disabled';
	 }).bind("paste", function () {
	     var clipboard = window.clipboardData.getData("Text");
	     if (/^[a-zA-Z]+$/.test(clipboard))
	         return true;
	     else
	         return false;
	 });
	};

	function add(){
		$("#key").attr("readonly",false); 
		$("#key").val("");
		<c:forEach items="${lang}" var="e" varStatus="s">	$("#${loc[s.count-1]}").val(""); </c:forEach>
		$('#editor').dialog("open","true");
	};
	
	function modify(){
		var rows = $("#dgsysinternationalManage").datagrid('getChecked');
		if(rows.length !== 1){
			alert("请选择一条数据编辑！");
			return false;
		}
		$("#key").attr("readonly",true); 
		$("#key").val(rows[0].key);
		<c:forEach items="${lang}" var="e" varStatus="s">	$("#${loc[s.count-1]}").val(rows[0].${loc[s.count-1]}); </c:forEach>
		$('#editor').dialog("open","true");
	};
	function save(){
		if (!$('#form').form('validate')) {
			return;
		}
		var submitdata = {
				key:$("#key").val(),
				values:[
					<c:forEach items="${lang}" var="e" varStatus="s">
					$("#${loc[s.count-1]}").val(),
					</c:forEach>
					""
				],
				locals:[
				   <c:forEach items="${lang}" var="e" varStatus="s">
					"${loc[s.count-1]}",
					</c:forEach>
					""
				]
		};
		var model =  $("#cc").val();
		$.ajax({
			 url:"sysInternationalController/operation/save?model=" + model,
			 data :{data:JSON.stringify(submitdata)},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 $("#dgsysinternationalManage").datagrid('load',{'model':model});
					 $("#dgsysinternationalManage").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
					 $('#editor').dialog('close');
					 $.messager.show({
						 title : '提示',
						 msg : '保存成功！'
					 });
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.error
					});
				 } 
			 }
		 });
	};
	
	$(function(){
		$("#key").onlyAlpha();
		$('#cc').combobox('select', '${model}');
		$("#cc").combobox({
			onChange: function (n,o) {
				location="<%=ViewUtil.getRequestPath(request)%>/sysInternationalController/initPage?model=" + n;
			}
		});
	});

</script>
</head>
<body class="easyui-layout" fit="true">
<c:choose>
   <c:when test='${state eq "1"}'>
    <div data-options="region:'north'" style="padding:10px;">
		<font color="red"><b>提示：</b>
		<br>1:当您编辑多语言数据，提交服务器以后，系统会在一分钟之内自动刷新缓存，
		<br>2:多语言编辑只会对运行文件（WEB-INF\classes\i18n\model_XX_XX.properties）进行修改。如果您是WAR包部署方式请及时备份资源文件，修改WAR包对应的资源文件，以免修改的数据丢失。
		<br>3:在您进行系统开发时，如果存在多语言的用户需求，平台建议按组件粒度将多语言文件配置进来 。</font>
	</div>
	<div data-options="region:'center'" style="background:#ffffff;">
		<div id="sysinternational" class="datagrid-toolbar">
		 	<table>
		 		<tr>
		 		<td>
		 		<label>请选择语言文件：</label>
					<select id="cc" class="easyui-combobox" name="state" style="width:200px;"  data-options="required:true,width:150">
					<c:forEach items="${models}" var="e">
						<c:choose>
						   <c:when test="${model eq e}">
						    <option selected="selected" value="${e}">${e}</option>
						   </c:when>
						   <c:otherwise>
						     <option value="${e}">${e}</option>
						   </c:otherwise>
						</c:choose>
			        </c:forEach>
					</select>
				</td>
		 		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysinternationalManage_button_add" permissionDes="添加">
					<td><a class="easyui-linkbutton"  iconCls="icon-add" plain="true" onclick="add()" href="javascript:void(0);">添加</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysinternationalManage_button_edit" permissionDes="编辑">
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="modify();" href="javascript:void(0);">编辑</a></td>
				</sec:accesscontrollist>
				</tr>
		 	</table>
	 	</div>
	 	<table id="dgsysinternationalManage" class="easyui-datagrid" data-options="
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#sysinternational',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
            pagination: false,
			url:'sysInternationalController/list.json?model=${model}'">
			<thead>
				<tr>
					<th data-options="field:'key', halign:'center'" sortable="true" width="220">多语言键值</th>
					<c:forEach items="${lang}" var="e" varStatus="s">
						<th data-options="field:'${loc[s.count-1]}', halign:'center'" sortable="true" width="220">${e}</th>
			        </c:forEach>					
				</tr>
			</thead>
		</table>
		<div id="editor"   title="多语言编辑器" class="easyui-dialog" data-options="iconCls:'icon-edit',closed:true,resizable:true,modal:false,buttons:'#bt'" style="width: 500px;height:200px;">
			<div easyui-layoutfit="true">
				<div data-options="region:'center'" style="background:#ffffff;">
				<form id='form' method="post">
					<center>
			    		<table style="padding: 10px;">
			    			<tr>
			    				<td><font color="red"><b>* </b></font>多语言键值：</sfn></td>
			    				<td>
									<div class=""><input class="easyui-validatebox"  name="key"  required="true" id="key" style="width:350px;" ></input></div>
			    				</td>
			    			</tr>
			    			<c:forEach items="${lang}" var="e" varStatus="s">
				    			<tr>
				    				<td><font color="red"><b>* </b></font>${e}：</td>
				    				<td>
										<div class=""><input class="easyui-validatebox"  name="${loc[s.count-1]}" required="true"  id="${loc[s.count-1]}" style="width:350px;" ></input></div>
				    				</td>
				    			</tr>
					        </c:forEach>
			    		</table>
			    	</center>
			    	</form>
		    	</div>
		    	<div id="bt">
		    		<center>
		    		<a class="easyui-linkbutton" iconCls="" plain="false" onclick="save();" href="javascript:void(0);">保存</a>
		    		<a class="easyui-linkbutton" iconCls="" plain="false" onclick="$('#editor').dialog('close');" href="javascript:void(0);">返回</a>
		    		</center>
		    	</div>
	    	</div>
	  </div>
	</div>
   </c:when>
   <c:otherwise>
        <div data-options="region:'center'" style="padding:10px;">
		<font color="red"><b>提示：</b><br>${msg}</font>
	</div>
   </c:otherwise>
</c:choose>
</body>
</html>