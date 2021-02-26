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
<!-- ControllerPath = "avicit/platform6/mobileportal/portalimage/controller/NewPortalImageController/toPortalImageManage" -->
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
				domainObject="formdialog_portalImage_button_add" permissionDes="添加">
				<a id="portalImage_insert" href="javascript:;"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_portalImage_button_edit" permissionDes="编辑">
				<a id="portalImage_modify" href="javascript:;"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_portalImage_button_delete"
				permissionDes="删除">
				<a id="portalImage_del" href="javascript:;"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
								   domainObject="formdialog_portalImage_button_alterPath"
								   permissionDes="替换地址">
				<a id="portalImage_alterPath" href="javascript:;"
				   class="btn btn-primary form-tool-btn btn-sm" role="button"
				   title="替换地址"><i class="glyphicon glyphicon-retweet"></i> 替换地址</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="portalImage_keyWord"
					id="portalImage_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="portalImage_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="portalImage_searchAll" href="javascript:;"
					class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="portalImagejqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">图片名称:</th>
				<td width="39%"><input title="图片名称"
					class="form-control input-sm" type="text" name="imageName"
					id="imageName" /></td>
				<th width="10%">图片路径:</th>
				<td width="39%"><input title="图片路径"
					class="form-control input-sm" type="text" name="imagePath"
					id="imagePath" /></td>
			</tr>
			<tr>
				<th width="10%">显示顺序:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input title="" type="text" class="form-control" name="imageOrder"
							id="imageOrder" data-min="0" data-max="999999999999"
							data-step="1" data-precision="0"> <span
							class="input-group-addon"> <a href="javascript:;"
							class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/mobileportal/portalimage/js/PortalImage.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var portalImage;

	$(document)
			.ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '图片名称',
							name : 'imageName',
							width : 150
						}, {
							label : '图片路径',
							name : 'imagePath',
							width : 150
						}, {
							label : '显示顺序',
							name : 'imageOrder',
							width : 150
						} ];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("imageName");
						searchTips.push("图片名称");
						searchNames.push("imagePath");
						searchTips.push("图片路径");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#portalImage_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);
						portalImage = new PortalImage('portalImagejqGrid',
								'${url}', 'searchDialog', 'form',
								'portalImage_keyWord', searchNames,
								dataGridColModel);
						//添加按钮绑定事件
						$('#portalImage_insert').bind('click', function() {
							portalImage.insert();
						});
						//编辑按钮绑定事件
						$('#portalImage_modify').bind('click', function() {
							portalImage.modify();
						});
						//删除按钮绑定事件
						$('#portalImage_del').bind('click', function() {
							portalImage.del();
						});
                        //替换地址按钮绑定事件
                        $('#portalImage_alterPath').bind('click', function() {
                            portalImage.toAlterPath();
                        });
						//查询按钮绑定事件
						$('#portalImage_searchPart').bind('click', function() {
							portalImage.searchByKeyWord();
						});
						//查询框回车事件
						$('#portalImage_keyWord').bind('keyup', function(e) {
							if (e.keyCode == 13) {
								portalImage.searchByKeyWord();
							}
						});
						//打开高级查询框
						$('#portalImage_searchAll').bind('click', function() {
							portalImage.openSearchForm(this);
						});
					});
</script>
</html>