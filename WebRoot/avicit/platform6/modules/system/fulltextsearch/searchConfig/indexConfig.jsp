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
<!-- ControllerPath = "test/demo/syssearchindex/sysSearchIndexController/toSysSearchIndexManage" -->
<title>管理</title>
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
				domainObject="formdialog_sysSearchIndex_button_add"
				permissionDes="添加">
				<a id="sysSearchIndex_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 新增</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysSearchIndex_button_save"
				permissionDes="保存">
				<a id="sysSearchIndex_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysSearchIndex_button_del"
				permissionDes="删除">
				<a id="sysSearchIndex_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
	</div>
	<table id="sysSearchIndexjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/modules/system/fulltextsearch/js/SearchIndex.js"
	type="text/javascript"></script>
<script type="text/javascript">
	//后台获取的通用代码数据
	var sysSearchIndex;
	$(document).ready(
			function() {
				var dataGridColModel = [ {
					label : 'attribute01',
					name : 'attribute01',
					width : 75,
					hidden : true
				},{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '名称',
					name : 'name',
					width : 150,
					editable : true,
					edittype:'select',
					editoptions:{value:getAllCol("${param.infoId}")}
				}, {
					label : '标题',
					name : 'title',
					width : 150,
					editable : false,
					align: "center",
					formatter:"checkbox",
					formatoptions:{disabled:false}, 
					editoptions: {value : "Y:N"}
				}, {
					label : '有效',
					name : 'valid',
					width : 150,
					editable : false,
					align: "center",
					formatter:"checkbox",
					formatoptions:{disabled:false}, 
					editoptions: {value : "Y:N"}
				}, {
					label : '高亮显示',
					name : 'hglight',
					width : 150,
					editable : false,
					align: "center",
					formatter:"checkbox",
					formatoptions:{disabled:false}, 
					editoptions: {value : "Y:N"}
				}, {
					label : '参与密级',
					name : 'secret',
					width : 150,
					editable : false,
					align: "center",
					formatter:"checkbox",
					formatoptions:{disabled:false}, 
					editoptions: {value : "Y:N"}
				} ];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("name");
				searchTips.push("NAME");
				searchNames.push("title");
				searchTips.push("TITLE");
				var searchC = searchTips.length == 2 ? '或'
						+ searchTips[1] : "";
				$('#sysSearchIndex_keyWord').attr('placeholder',
						'请输入' + searchTips[0] + searchC);
				sysSearchIndex = new SysSearchIndex(
						'sysSearchIndexjqGrid', 'searchindex/searchIndexController/operation/',
						'searchDialog', 'form',
						'sysSearchIndex_keyWord', searchNames,
						dataGridColModel,"${param.infoId}");
				//添加按钮绑定事件
				$('#sysSearchIndex_insert').bind('click', function() {
					sysSearchIndex.insert('${param.infoId}');
				});
				//删除按钮绑定事件
				$('#sysSearchIndex_del').bind('click', function() {
					sysSearchIndex.del();
				});
				//保存按钮绑定事件
				$('#sysSearchIndex_save').bind('click', function() {
					sysSearchIndex.save();
				});
				//查询按钮绑定事件
				$('#sysSearchIndex_searchPart').bind('click',
						function() {
							sysSearchIndex.searchByKeyWord();
						});
				//打开高级查询框
				$('#sysSearchIndex_searchAll').bind('click',
						function() {
							sysSearchIndex.openSearchForm(this);
						});
				//回车键查询
				$('#sysSearchIndex_keyWord').on('keydown', function(e) {
					if (e.keyCode == 13) {
						sysSearchIndex.searchByKeyWord();
					}
				});

			});
</script>
</html>