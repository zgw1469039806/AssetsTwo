<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.table tr input{
	width: 95%;
	margin-left: 5px;
}
.table tr th{
	font-size: 12px;
	font-family: "Microsoft YaHei";
	color: #444;
	line-height:20px;
}
.table label{
	font-size: 12px;
	font-family: "Microsoft YaHei";
	color: #444;
	line-height:20px;
}
.fieldset{
	font-size: 12px;
	font-family: "Microsoft YaHei";
	color: #444;
	line-height:20px;
	width: 95%;
}
</style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true">
	 <div id="toolbar" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
	 		</tr>
	 	</table>
	 </div>
	<ul id="menu1">正在加载数据...</ul>
</div>
<div data-options="region:'south',border:false" style="height:40px;">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
           <table class="tableForm" border="0" cellspacing="1" width='100%'>
               <tr>
                   <td align="right">
                       <a title="确定" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveMove();" href="javascript:void(0);">确定</a>
                       <a title="取消" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">取消</a>
                   </td>
               </tr>
           </table>
       </div>
</div>
<script src="avicit/platform6/modules/system/sysmenu/js/SysMenu.js" type="text/javascript"></script>
<script type="text/javascript">
	var node;
	$(function(){
		var m = new SysMenu('menu1','${url}','searchWord','form');
		if(parent&&parent.sysMenu){
			m.setOnLoadSuccess(function(self){
				parent.sysMenu.filterMenu(self);
			});
		}
		m.setOnSelect(function(s,n){
			node=n;
		});
		
	});
	function closeForm(){
		parent.sysMenu.closeDialog("#moveMenu");
	};
	function saveMove(){
		if(!node){
			alert("请选择一个菜单!");
			return false;
		}
		parent.sysMenu.saveToNode(node);
	};
</script>
</body>
</html>