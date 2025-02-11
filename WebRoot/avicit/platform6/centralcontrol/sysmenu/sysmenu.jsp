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

 <div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="height:0; overflow:hidden; font-size:0;width:200px">
	 <div id="toolbarTree" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input type="text"  name="searchApp" id="searchApp"></input></td>
	 		</tr>
	 	</table>
 	 </div>
	 <ul id="apps">正在加载应用列表...</ul>
 </div>   
 
 <div data-options="region:'center',split:true" style="height:0;font-size:0;padding:0px;">   
	<div class="easyui-layout" data-options="fit:true">   
		<div data-options="region:'west',split:true,title:'系统菜单',collapsible:false" style="width:250px;padding:0px;">
			 <div id="toolbar" class="datagrid-toolbar">
			 	<table width="100%">
			 		<tr>
			 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
			 		</tr>
			 	</table>
			 </div>
			<ul id="menu">正在加载数据...</ul>
		</div>
		<div data-options="region:'center',split:true,title:'菜单详细信息(电子表单:platform/eform/formlayout/index/&lt;font style=color:red&gt;AAAAA&lt;/font&gt;/&lt;font style=color:red&gt;xxxx&lt;/font&gt;,AAAAA是表英文名称,xxxx是表单版本)'" style="padding:0px;overflow:auto;height:0; font-size:0;">
			<div id="toolbarImportResult" class='datagrid-toolbar'>
				<table>
					<tr>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sysMenu.insert();" href="javascript:void(0);">添加平级菜单</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-add_other" plain="true" onclick="sysMenu.insertsub();" href="javascript:void(0);">添加子菜单</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="sysMenu.modify();" href="javascript:void(0);">编辑</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sysMenu.del();" href="javascript:void(0);">删除</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-tools" plain="true" onclick="sysMenu.openLanguageForm();" href="javascript:void(0);">设置语言</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sysMenu.insertRes();" href="javascript:void(0);">添加资源</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="sysMenu.modifyRes();" href="javascript:void(0);">编辑资源</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="sysMenu.reload();" href="javascript:void(0);">刷新缓存</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-menu-transfer" plain="true" onclick="sysMenu.toMove();" href="javascript:void(0);">移动菜单</a></td>
					</tr>
				</table>
			</div>
			<form id='form'> 
				<table class="table" width="100%" style="padding-top: 4px;">
					<tr>
						<th align="right" width="110px">名称</th>
						<td><input title="名称" class="inputbox" type="text" name="name" id="name" readonly="readonly"/></td>
					</tr >
					<tr>
						<th align="right">代码</th>
						<td><input title="代码" class="inputbox" type="text" name="code" id="code" readonly="readonly"/></td>
					</tr>
					<tr class="res">
						<th align="right" >图标引用地址</th>
						<td><input title="图标引用地址" class="inputbox" type="text" name="image" id="image" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">路径</th>
						<td><input title="路径" class="inputbox" type="text" name="url" id="url" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">排序编号</th>
						<td><input title="排序编号" class="inputbox" type="text" name="orderBy" id="orderBy" readonly="readonly"/></td>
					</tr>
					<tr class="res">
						<th align="right">菜单组</th>
						<td><input title="菜单组" class="inputbox" type="text" name="menuGroupName" id="menuGroupName" readonly="readonly"/></td>
					</tr>
					<tr class="res">
						<th align="right">bootstrap图标</th>
						<td><input title="bootstrap图标" class="inputbox" type="text" name="iconClass" id="iconClass" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">菜单类型</th>
						<td>
							<input style="width: 25px;" title="功能菜单" type="radio" name="type" id="type1" value='1' disabled/><label for="type1">功能菜单</label>
							<input style="width: 25px;" title="门户小页" type="radio" name="type" id="type2" value='2' disabled/><label for="type2">门户小页</label>
						</td>
					</tr>
					<tr class="res">
						<th align="right">菜单状态</th>
						<td><input style="width: 25px;" title="启用" type="radio" name="status" id="status1" value='1' disabled/><label for="status1">启用</label>
							<input style="width: 25px;" title="禁用" type="radio" name="status" id="status2" value='0' disabled/><label for="status2">禁用</label>
						</td>
					</tr>
					<tr class="res">
						<th align="right">是否Robbin</th>
						<td><input style="width: 25px;" title="是" type="radio" name="isRobbin" id="isRobbin1" value='1' disabled/><label for="isRobbin1">是</label>
							<input style="width: 25px;" title="否" type="radio" name="isRobbin" id="isRobbin2" value='0' disabled/><label for="isRobbin2">否</label>
						</td>
					</tr>
					<tr>
						<th align="right">视图</th>
						<td><input title="视图文件路径" class="inputbox" type="text" name="menuView" id="menuView" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">描述</th>
						<td><textarea title='描述' class="inputbox scrollbar" style="height:50px;width:95%;margin-left: 5px;" id="comments" name="comments" readonly="readonly"></textarea></td>
					</tr>
				</table>
				<fieldset class="fieldset res">
					<legend style="margin-left: 30px;">门户小页</legend>
					<table class="table" width="100%">
					<tr>
						<th align="right" width="105px">滚动条</th>
						<td>
							<input style="width: 25px;" title="有" type="radio" name="scroll" id="scroll1" value='1' disabled/><label for="scroll1">有</label>
							<input style="width: 25px;" title="无" type="radio" name="scroll" id="scroll2" value='0' disabled/><label for="scroll2">无</label>
						</td>
					</tr >
					<tr>
						<th align="right">关闭按钮</th>
						<td>
							<input style="width: 25px;" title="有" type="radio" name="isclose" id="closeble1" value='1' disabled/><label for="closeble1">有</label>
							<input style="width: 25px;" title="无" type="radio" name="isclose" id="closeble2" value='0' disabled/><label for="closeble2">无</label>
						</td>
					</tr>
					<tr>
						<th align="right">是否显示标题</th>
						<td>
							<input style="width: 25px;" title="显示" type="radio" name="isshowtitle" id="titleble1" value='1' disabled/><label for="titleble1">显示</label>
							<input style="width: 25px;" title="隐藏" type="radio" name="isshowtitle" id="titleble2" value='0' disabled/><label for="titleble2">隐藏</label>
						</td>
					</tr>
					<!-- <tr>
						<th align="right">是否允许拖拽</th>
						<td>
							<input style="width: 25px;" title="允许" type="radio" name="isdrag" id="dragble1" value='1' disabled/><label for="dragble1">允许</label>
							<input style="width: 25px;" title="不允许" type="radio" name="isdrag" id="dragble2" value='0' disabled/><label for="dragble2">不允许</label>
						</td>
					</tr> -->
					<tr>
						<th align="right">其它链接地址</th>
						<td><input title="其它链接地址 "class="inputbox" type="text" name="moreurl" id="moreurl" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">高度</th>
						<td><input title="高度 "class="inputbox" type="text" name="height" id="height" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">刷新频率</th>
						<td><input title="刷新频率" class="inputbox" type="text" name="refresh" id="refresh" readonly="readonly"/></td>
					</tr>
					<tr>
						<th align="right">样式</th>
						<!-- <td><input title="配置文件代码" class="inputbox" type="text" name="profileOptionCode" id="profileOptionCode"/></td> -->
						<td><textarea title='样式' class="inputbox scrollbar" style="height:50px;width:95%;margin-left: 5px;" id="css" name="css" readonly="readonly"></textarea></td>
					</tr>
				</table>
				</fieldset>
			</form>
		</div>
 </div>
 </div>	
<script src="avicit/platform6/centralcontrol/sysmenu/js/SysMenu.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<script type="text/javascript">
	var sysMenu;
	var sysAppTree;
	$(function(){
		sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE);
		
		sysAppTree.setOnLoadSuccess(function(){
			 sysMenu = new SysMenu('menu','${url}','searchWord','form');
			 sysMenu.setOnSelect(sysMenu.loadMenuById);
		});
		sysAppTree.setOnSelect(function(_sysAppTree,node){
			sysMenu.loadByAppId(node.id);
		});
		sysAppTree.init();
	});
</script>
</body>
</html>