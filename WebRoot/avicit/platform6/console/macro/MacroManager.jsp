<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义宏</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>

	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_macro_button_add"
				permissionDes="添加">
				<a id="macro_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_macro_button_edit"
				permissionDes="编辑">
				<a id="macro_edit" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-trash-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_macro_button_del"
				permissionDes="删除">
				<a id="macro_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			 <div class="input-group form-tool-search">
				<input type="text" name="search_keyWord"
					id="search_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="宏名称/宏表达式"> <label
					id="search_icon"
					class="icon icon-search form-tool-searchicon"></label>
			</div> 
		</div>
	</div>
	<table id="macroList"></table>
	<div id="jqGridPager"></div>

</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/macro/js/Macro.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var macro;
	$(document).ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 10,
							hidden : true
						}, {
							label : '宏名称',
							name : 'macroName',
							width : 25,
						},{
							label : '宏表达式',
							name : 'macroExp',
							width : 40,
							//editable : true,
						},{
							label : '宏类型',
							name : 'macroType',
							width : 20,
						},{
							label : '实现类',
							name : 'macroImpl',
							width : 70,
						},{
							label : '宏描述',
							name : 'macroDesc',
							width : 70,
						}
						];
						var searchMainNames = new Array();
						searchMainNames.push("macroName");
						
						macro = new Macro('macroList', '${url}','search_keyWord',dataGridColModel,searchMainNames);
						//添加按钮绑定事件
						$('#macro_insert').bind('click', function() {
							macro.insert();
						});
						//编辑按钮绑定事件
						$('#macro_edit').bind('click', function() {
							macro.modify();
						});
						//删除按钮绑定事件
						$('#macro_del').bind('click', function() {
							macro.del();
						});
						//查询按钮绑定事件
						$('#search_icon').bind('click',
								function() {
									macro.searchByKeyWord();
								});
						 
						 //回车键查询
						$('#search_keyWord').on('keydown', function(e) {
							if (e.keyCode == 13) {
								macro.searchByKeyWord();
							}
						}) ; 
					});
</script>
</html>