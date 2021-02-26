<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,table,form";
	String currentOrgId = SessionHelper.getCurrentOrgIdentity(request);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组织模型</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<style type="text/css">
	.fmt_opt{
		min-width: 8px;

	}
	.jqgrow td a {
		color:#fff;
	}
	
	
.icon-edit {
    background: rgba(0, 0, 0, 0) url('avicit/platform6/console/org/images/iconselectors.gif') no-repeat scroll -200px 0;
}

</style>
<script type="text/javascript">

	document.body.onload = function(){
	 	if (navigator.userAgent.indexOf('MSIE') >= 0) {
            if (CollectGarbage) {
                CollectGarbage(); //IE 特有 释放内存
            }
        }

	}
	if (!Array.prototype.indexOf) {
	    Array.prototype.indexOf = function(elt /*, from*/ ) {
	        var len = this.length >>> 0;
	        var from = Number(arguments[1]) || 0;
	        from = (from < 0) ?
	            Math.ceil(from) :
	            Math.floor(from);
	        if (from < 0)
	            from += len;
	        for (; from < len; from++) {
	            if (from in this &&
	                this[from] === elt)
	                return from;
	        }
	        return -1;
	    };
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true" style="width: 300px;border-top-style: hidden;">
		<div class="row" style="margin: 5px;">
			<div class="input-group  input-group-sm">
				<input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
				<span class="input-group-btn">
					<button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
				</span>
			</div>
            <div  id='mdiv' style="overflow:auto;">
				<ul id="orgtree" class="ztree" style="height: 100%"></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
		<div id="tableToolbar" class="toolbar">
			<div class="toolbar-left">
			
				<div class="dropdown">
					<a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-add"></i> 添加<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
						<li role="presentation">
							<a id="orgInsert" href="javascript:void(0)"  title="添加组织">添加组织</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation">
							<a id="deptInsert" href="javascript:void(0)"  title="添加部门">添加部门</a>
						</li>
					</ul>
				</div>
				
				<a id="Edit" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				<!--
				<a id="orgInsert" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="添加组织"><i class="icon icon-add"></i> 添加组织</a>
				<a id="orgEdit" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="编辑组织"><i class="icon icon-edit"></i> 编辑组织</a>
				<a id="deptInsert" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="添加部门"><i class="icon icon-add"></i> 添加部门</a>
				<a id="deptEdit" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="编辑部门"><i class="icon icon-edit"></i> 编辑部门</a>
				-->
				<!-- <a id="statConfig" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="有无效设置"><i class="icon icon-setting"></i> 有无效设置</a>
				<a id="initPinYin" href="javascript:void(0)"
				class="btn btn-primary form-tool-btn btn-sm" role="button"
				title="初始化部门拼音"><i class="icon icon-setting"></i> 初始化部门拼音</a> -->
				<a id="del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
				<div class="dropdown">
					<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-setting"></i> 工具<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					   <li role="presentation">
							<a id="statConfig" href="javascript:void(0)"  title="有无效设置">有无效设置</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation">
							<a id="exportOrg" href="javascript:void(0)"  title="导入组织">导入组织</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation">
							<a id="exportDept" href="javascript:void(0)"  title="导入部门">导入部门</a>
						</li>
						<li role="separator" class="divider"></li>
						<li role="presentation">
							<a id="initPinYin" href="javascript:void(0)"  title="初始化部门拼音">初始化部门拼音</a>
						</li>
						<li role="presentation">
							<a id="initDeptIndexTreeNo" href="javascript:void(0)"  title="初始化部门索引">初始化部门索引</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<table id="jqGrid"></table>
	</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/org/js/OrgTree.js" ></script>
<script type="text/javascript" src="avicit/platform6/console/org/js/OrgList.js" ></script> 
<script  type="text/javascript">

    var curOrgId = '<%= currentOrgId%>';
    $('#mdiv').height(document.documentElement.clientHeight-46);
var orgList;
var orgtree;
var i=0;
function formatValue(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);" onclick="demoSingle.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
};
function formatStatus(cellvalue, options, rowObject) {

	
	if(cellvalue=="1"){
		//return "<img src='avicit/platform6/console/org/images/status.png' title='有效'>";
		return "<img src='avicit/platform6/console/user/images/state.png' title='有效'>";
	}else{
		//return "<img src='avicit/platform6/console/org/images/unstatus.png' title='无效'>";
		return "<img src='avicit/platform6/console/user/images/unstate.png' title='无效'>";
	}
	
}
var fmtShow=function(cellvalue){
	return menuList.MenuShow[cellvalue];
};

var formatName=function(cellvalue, options, rowObject){
	 if(rowObject.type=="org"){ 
		 return "<i class=\"station iconfont icon-station\">  </i> "+ rowObject.name;
	 }else{
		 return "<i class=\"organize iconfont icon-organize\">  </i> "+ rowObject.name;
	 }
}
var unformatName = function(cellvalue, options, cell){
    return cellvalue.replace(/(^\s*)|(\s*$)/g, "");
}

$(function(){
	var searchNames = [];
	searchNames.push("menuName");//用户可自定义查询条件，修改参数。

	var dataGridColModel =  [
	{ label: 'id', name: 'id', key: true, hidden:true },
	{ label: 'type', name: 'type',hidden:true },
	{ label: '状态', name: 'validFlag', width: 80,sortable:false,align:'center',formatter:formatStatus},
	{ label: '编码', name: 'code', width: 80,sortable:false,align:'center' },
	{ label: '名称', name: 'name', width: 150,sortable:false ,align:'left',formatter:formatName,unformat:unformatName},
	{ label: '传真', name: 'fax', width: 150,sortable:false,align:'center'},
	{ label: '邮箱', name: 'email', width: 150,sortable:false,align:'center'},
	{ label: '办公地点', name: 'place', width: 150,sortable:false,align:'center'}
	];
	orgList = new OrgList('jqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
    
	
	orgtree = new OrgTree('orgtree','${url}','form','txt','searchbtn');
	    orgtree.init();

	});
	$('#orgInsert').bind('click', function() {
		orgList.insertOrg();
	});
	$('#deptInsert').bind('click', function() {
		orgList.insertDept();
	});
	$('#Edit').bind('click', function() {
		orgList.showEdit();
	});
	$('#del').bind('click', function() {
		orgList.del();
	});
	
	$('#statConfig').bind('click', function() {
		orgList.setValidFlag();
	});
	
	$('#exportOrg').bind('click', function() {
		orgList.importorg();
	});
	
	
	$('#exportDept').bind('click', function() {
		orgList.importdept();
	});
	$('#initPinYin').bind('click', function() {
		initPinYin();
	});
	$('#initDeptIndexTreeNo').bind('click', function() {
		initDeptIndexTreeNo();
	});


	
// 	if (navigator.userAgent.indexOf('MSIE') >= 0) {
//         if (CollectGarbage) {
//             CollectGarbage(); //IE 特有 释放内存
//         }
//     }

	
	
	
</script>
</html>