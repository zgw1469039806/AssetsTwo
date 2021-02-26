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
<div id="panelcenter" data-options="region:'center',onResize:function(a){$('#jqGridposition').setGridWidth(a);;$('#jqGridposition').setGridHeight(getJgridTableHeight($('#panelcenter')));$(window).trigger('resize');}">
<div id="tableToolbarPosition" class="toolbar">
	<div class="toolbar-left">
	  	<a id="consolePosition_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
		<a id="consolePosition_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
		<a id="consolePosition_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		<a id="exportPosition" href="javascript:void(0)"class="btn btn-primary form-tool-btn btn-sm" role="button" title="岗位导入"><i class="icon icon-daoru"></i> 导入</a>
		
		<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-daochu"></i> 导出<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<!-- role = "presentation"表示陈述 -->
					<li role="presentation"><a href="javascript:void(0);" onclick="exportClientData();">导出-当前页</a></li>
					<li role="separator" class="divider"></li>
					<li role="presentation"><a href="javascript:void(0);" onclick="exportServerData();">导出-所有页</a></li>
				</ul>
		</div>
	</div>
	<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysPosition_keyWord"
						id="sysPosition_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysPosition_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
	</div>
</div>
<table id="jqGridposition"></table>
<div id="jqGridPager1"></div>
</div>
<div id="paneleast" data-options="region:'east',split:true,width:fixwidth(.4),onResize:function(a){$('#jqGrid').setGridWidth(a);$('#jqGrid').setGridHeight(getJgridTableHeight($('#paneleast')));$(window).trigger('resize');}">
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
	  	<!--<a id="consolePosition_searchAll" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="icon icon-add"></i>查询</a>-->
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
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/position/js/consolePosition.js" type="text/javascript"></script> 
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
var consolePosition;
function formatStatus(cellvalue, options, rowObject) {

	if(rowObject.userLocked!="0"){
		return "<img src='avicit/platform6/console/user/images/state1.png' title='锁定'>";
	}
	if(cellvalue=="1"){
		return "<img src='avicit/platform6/console/user/images/state.png' title='有效用户'>";
	}else{
		return "<img src='avicit/platform6/console/user/images/unstate.png' title='无效用户'>";
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
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
	searchMainNames.push("positionName");
 	searchMainTips.push("名称");
 	searchMainNames.push("positionCode");
 	searchMainTips.push("编码");
	$('#sysPosition_keyWord').attr('placeholder','请输入'+searchMainTips[0]+'或'+searchMainTips[1]);
	
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
	
	
	var dataGridPositionColModel = [ 
						{
							label : 'id',
							name : 'id',
							width : 75,
							hidden : true
						}, {
							label : '<span class="remind">*</span>'+'岗位名称',
							name : 'positionName',
							width : 150,
            				sortable : false,
							editable : true
							
						
						}, {
							label : '<span class="remind">*</span>'+'岗位编码',
							name : 'positionCode',
							width : 150,
            				sortable : false,
							editable : true
							
						}, {
							label : '岗位描述',
							name : 'positionDesc',
							width : 150,
            				sortable : false,
							editable : true
							
						},{
							label : '<span class="remind">*</span>'+'排序',
							name : 'orderBy',
							width : 150,
            				sortable : false,
							editable : true
						}
						];
						 
	consolePosition = new ConsolePosition('jqGrid','jqGridposition','${url}','searchDialog','form','sysPosition_keyWord','sysUser_keyWord',searchMainNames,searchUserMainNames,dataGridUserColModel,dataGridPositionColModel);
	
	consolePosition.setOnSelect(function(positionId){
	
			consolePosition.loaduserByid(positionId);
			
		}).init();
	//添加按钮绑定事件
		$('#consolePosition_insert').bind('click', function() {
			
			consolePosition.insert();
		});
		//删除按钮绑定事件
		$('#consolePosition_del').bind('click', function() {
			consolePosition.del();
		});
		//保存按钮绑定事件
		$('#consolePosition_save').bind('click', function() {
			$('a#consolePosition_save').attr("disabled","disabled");
			consolePosition.save();
			setTimeout(function(){ $('a#consolePosition_save').removeAttr("disabled"); }, 1000);
		});

		//打开高级查询框
		$('#consolePosition_searchAll').bind('click',function(){
			consolePosition.openSearchForm(this);
		});

		$('#exportPosition').bind('click', function() {
			consolePosition.importposition();
		});
	
		//关键字段查询按钮绑定事件
		$('#sysPosition_searchPart').bind('click', function(){
			consolePosition.searchByKeyWord();
		});
			//关键字段查询按钮绑定事件
		$('#sysUser_searchPart').bind('click', function(){
			consolePosition.searchUserByKeyWord();
		});
	
	
   

});



</script>
</html>