<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body class="easyui-layout" fit="true">
<div id="panelcenter" data-options="region:'center',onResize:function(a){$('#jqGridgroup').setGridWidth(a);$('#jqGridgroup').setGridHeight(getJgridTableHeight($('#panelcenter')));$(window).trigger('resize');}">
<div id="tableToolbargroup" class="toolbar">
	<div class="toolbar-left">
	  	<a id="consolegroup_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加群组</a>
		<a id="consolegroup_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-save"></i> 保存</a>
		<a id="consolegroup_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		<!--<a id="consolegroup_search" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 查询</a>-->
		
	</div>
	<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysGroup_keyWord"
						id="sysGroup_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysGroup_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
	</div>
</div>
<table id="jqGridgroup"></table>
<div id="jqGridPager1"></div>
</div>
<div id="paneleast" data-options="region:'east',split:true,width:fixwidth(.4),onResize:function(a){$('#jqGrid').setGridWidth(a);$('#jqGrid').setGridHeight(getJgridTableHeight($('#paneleast')));$(window).trigger('resize');}">
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<a id="consoleuser_add" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加用户</a>
		<a id="consoleuser_delete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
	  	<!--<a id="consolegroup_searchAll" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="查询"><i class="icon icon-add"></i>查询</a>-->
	</div>
	<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysGroup_keyWord"
						id="sysUser_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysUser_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
	</div>
</div>

<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</div>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>用户姓名:</th>
				<td><input title="用户姓名" class="form-control input-sm" type="text" name="name" id="name" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="loginName">登录名:</label></th>
				<td width="39%"><input title="登录名" class="form-control input-sm" type="text" name="loginName" id="loginName" /></td>
			</tr>
		</table>
	</form>
</div>


<!-- 高级查询 -->
<div id="searcgrouphDialog" style="overflow: auto;display: none">
	<form id='formgroup' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>角色名称:</th>
				<td><input title="角色名称" class="form-control input-sm" type="text" name="groupName" id="groupName" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="groupCode">角色编码:</label></th>
				<td width="39%"><input title="角色编码" class="form-control input-sm" type="text" name="groupCode" id="groupCode" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/group/js/consoleGroup.js" type="text/javascript"></script> 
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
var consolegroup;
function formatStatus(cellvalue, options, rowObject) {

	if(rowObject.userLocked!="0"){
		return "<img src='avicit/platform6/console/group/images/lock.png' title='锁定'>";
	}
	if(cellvalue=="1"){
		return "<img src='avicit/platform6/console/group/images/state.png' title='有效用户'>";
	}else{
		return "<img src='avicit/platform6/console/group/images/unstate.png' title='无效用户'>";
	}
	
}
function formatConsole(cellvalue, options, rowObject) {
	
	if(cellvalue=="1"){
		return '';
	}else{
		return "<img src='avicit/platform6/console/user/images/status.png' title='是'>";
	}
}

function formatLevel(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return '非涉密人员';
	}else if(cellvalue=="1"){
		return '涉密人员';
	}else{
		return '涉密人员';
	}
	
}

function formatgroupMoif(cellvalue, options, rowObject) {
	if(cellvalue=="0"){
		return '公共使用';
	}else{
		return '私有使用';
	}
	
}

function formatvalidFlag(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return '有效';
	}else{
		return '无效';
	}
	
}
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
	searchMainNames.push("groupName");
 	searchMainTips.push("名称");
	$('#sysGroup_keyWord').attr('placeholder','请输入'+searchMainTips[0]);
	
	var searchUserMainNames = new Array();
	var searchUserMainTips = new Array();
	searchUserMainNames.push("name");
 	searchUserMainTips.push("用户名");
 	searchUserMainNames.push("loginName");
 	searchUserMainTips.push("登录名");
	$('#sysUser_keyWord').attr('placeholder','输入'+searchUserMainTips[0]+'或'+searchUserMainTips[1]);
	
	
	var dataGridUserColModel =  [
       { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '状态', name: 'status',sortable : false, width: 100,align:'center',formatter:formatStatus}
      ,{ label: '用户姓名', name: 'name',sortable : false, width: 200 ,align:'center'}
      ,{ label: '登录名', name: 'loginName',sortable : false, width: 200,align:'center'}
      ,{ label: '密级', name: 'secretLevel',sortable : false, width: 150,align:'center',formatter:formatLevel}
      ,{ label: '后台用户', name: 'consoleType',sortable : false, width: 150 ,align:'center',formatter:formatConsole}
      ,{ label: '部门', name: 'deptName',sortable : false, width: 150 ,align:'center'}
	];
	
	
	var dataGridgroupColModel = [ 
						{
							label : 'id',
							name : 'id',
							width : 75,
							hidden : true
						}, {
							label : '<span class="remind">*</span>'+'群组名称',
							name : 'groupName',
							width : 150,
							editable : true,
							sortable : false
							
						
						}, {
							label : '群组描述',
							name : 'groupDesc',
							width : 150,
							editable : true,
            				sortable : false
							
						},{
							label : '状态',
							name : 'validFlag',
							width : 150,
			                sortable : false,
							editable : true,
							formatter:formatvalidFlag,
							edittype : 'select',
							editoptions:{
							
							value:{1:'有效',0:'无效'},
							
							defaultValue:'1'
							
							}
						},{
							label : '<span class="remind">*</span>'+'排序',
							name : 'orderBy',
							width : 150,
							editable : true,
            				sortable : false
						}
						];
						 
	consolegroup = new ConsoleGroup('jqGrid','jqGridgroup','${url}','searchDialog','form','sysGroup_keyWord','sysUser_keyWord',searchMainNames,searchUserMainNames,dataGridUserColModel,dataGridgroupColModel);
	
	consolegroup.setOnSelect(function(groupId){
	
			consolegroup.loaduserByid(groupId);
			
		}).init();
	//添加按钮绑定事件
		$('#consolegroup_insert').bind('click', function() {
			
			consolegroup.insert();
		});
		//删除按钮绑定事件
		$('#consolegroup_del').bind('click', function() {
			consolegroup.del();
		});
		//保存按钮绑定事件
		$('#consolegroup_save').bind('click', function() {
			$('a#consolegroup_save').attr("disabled","disabled");
			consolegroup.save();
			setTimeout(function(){ $('a#consolegroup_save').removeAttr("disabled"); }, 1000);
		});

		//关键字段查询按钮绑定事件
		$('#sysGroup_searchPart').bind('click', function(){
			consolegroup.searchByKeyWord();
		});
		
		
		//关键字段查询按钮绑定事件
		$('#sysUser_searchPart').bind('click', function(){
			consolegroup.searchUserByKeyWord();
		});
		
		
		//打开高级查询框
		$('#consolegroup_searchAll').bind('click',function(){
			consolegroup.openSearchForm(this);
		});
		//打开高级查询框
		$('#consolegroup_search').bind('click',function(){
			consolegroup.openSearchgroupForm(this);
		});
		
		

		
		
		$('#consoleuser_add').bind('click', function() {
			consolegroup.insertUser();
		});
		
		
		$('#consoleuser_delete').bind('click', function() {
			consolegroup.deleteUser();
		});
	


	
	
   

});



</script>
</html>