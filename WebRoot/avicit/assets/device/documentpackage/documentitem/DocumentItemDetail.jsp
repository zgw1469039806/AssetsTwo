<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "assets/device/documentpackage/documentPackageController/operation/Edit/id" -->
	<title>详细</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<!-- 切换卡 样式 -->
	<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">

	<!-----------------------------------------NTKO需要引入的js------------------------------------------->
	<script type="text/javascript" charset="utf-8" src="officecontrol/ntkobackground.min.js"></script>
	<script type="text/javascript" src="static/js/platform/component/commonword/Ntkoocx.js"></script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<div class="yyui_tab" style="width:100%; position:absolute;">
			<ul>
				<li class="yyui_tab_title_this">文档正文</li>
				<li class="yyui_tab_title">文档详情</li>
			</ul>
			<div class="yyui_tab_content_this" style="overflow-y:scroll; width:100%;">
				<iframe style="width:1500px; height:800px;" src="assets/utils/attachViewerController/getFileType?fileId=${documentItemDTO.documentUrl}"></iframe>
			</div>
			<div class="yyui_tab_content" style="overflow-y:scroll; width:100%;">
				<div data-options="region:'center',split:true,border:false" style="background-color:#F0F0F0;">
					<input type="hidden" name="id" value="<c:out value='${documentPackageDTO.id}'/>"/>
					<table class="form_commonTable">
						<tr>
							<th width="10%">
								<label for="packageName">文档包名称:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="packageName" id="packageName" value="<c:out value='${documentPackageDTO.createdBy}'/>" readonly/>
							</td>

							<th width="10%">
								<label for="creationDate">创建时间:</label></th>
							<td width="15%">
								<div class="input-group input-group-sm">
									<input class="form-control date-picker" type="text" name="creationDate" id="creationDate" readonly
										   value="<fmt:formatDate pattern="yyyy-MM-dd" value='${documentPackageDTO.creationDate}'/>"/>
									<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</td>

							<th width="10%">
								<label for="createdBy">创建人:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="createdBy" id="createdBy" readonly value="<c:out  value='${documentPackageDTO.createdByAlias}'/>"/>
							</td>

							<th width="10%">
								<label for="createdByDept">创建部门:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="createdByDept" id="createdByDept" readonly value="<c:out  value='${documentPackageDTO.createdByDeptAlias}'/>"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="packageDescribe">文档包描述:</label></th>
							<td width="90%" colspan="7">
								<textarea class="form-control input-sm" rows="3" name="packageDescribe" id="packageDescribe"><c:out value='${documentPackageDTO.packageDescribe}'/></textarea>
							</td>
						</tr>
					</table>

					<div style="border:solid 1px; margin:40px;">
						<input type="hidden" name="documentUrl" id="documentUrl" />
						<table class="form_commonTable">
							<tr>
								<th width="10%"><label for="documentName">文档名称:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="documentName" id="documentName" value="<c:out value='${documentItemDTO.documentName}'/>" readonly/>
								</td>

								<th width="10%"><label for="documentType">文档类型:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="documentType" id="documentType" value="<c:out value='${documentItemDTO.documentType}'/>" readonly/>
								</td>

								<th width="10%"><label for="documentCategory">文档分类:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="documentCategory" id="documentCategory" value="<c:out value='${documentItemDTO.documentCategory}'/>" readonly/>
								</td>

								<th width="10%"><label for="lifeStage">生命阶段:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="lifeStage" id="lifeStage" value="<c:out value='${documentItemDTO.lifeStage}'/>" readonly/>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="documentAuthorAlias">作者:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="documentAuthor" name="documentAuthor" value="<c:out value='${documentItemDTO.documentAuthor}'/>">
										<input class="form-control" placeholder="请选择用户" type="text" id="documentAuthorAlias" name="documentAuthorAlias" value="<c:out value='${documentItemDTO.documentAuthorAlias}'/>" readonly>
										<span class="input-group-addon">
						<i class="glyphicon glyphicon-user"></i>
					</span>
									</div>
								</td>

								<th width="10%"><label for="authorDeptAlias">作者所在部门:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="authorDept" name="authorDept" value="<c:out value='${documentItemDTO.authorDept}'/>">
										<input class="form-control" placeholder="请选择部门" type="text" id="authorDeptAlias" name="authorDeptAlias" value="<c:out value='${documentItemDTO.authorDeptAlias}'/>" readonly>
										<span class="input-group-addon">
						<i class="glyphicon glyphicon-equalizer"></i>
					</span>
									</div>
								</td>

								<th width="10%"><label for="keyWord">关键字:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="keyWord" id="keyWord" value="<c:out value='${documentItemDTO.keyWord}'/>" readonly/>
								</td>

								<th width="10%"><label for="currentVersion">文档版本:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="currentVersion" id="currentVersion" value="<c:out value='${documentItemDTO.currentVersion}'/>" readonly/>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="lastVersion">更新前版本:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="lastVersion" id="lastVersion" value="<c:out value='${documentItemDTO.lastVersion}'/>" readonly/>
								</td>

								<th width="10%"><label for="documentState">文档状态:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="documentState" id="documentState" value="<c:out value='${documentItemDTO.documentState}'/>" readonly/>
								</td>

								<th width="10%"><label for="languageCategory">语言类别:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="languageCategory" id="languageCategory" value="<c:out value='${documentItemDTO.languageCategory}'/>" readonly/>
								</td>

								<th width="10%"><label for="secretLevel">文档密级:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="secretLevel" id="secretLevel" value="<c:out value='${documentItemDTO.secretLevel}'/>" readonly/>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="documentAbstract">文档摘要:</label></th>
								<td width="40%" colspan="3">
									<textarea class="form-control input-sm" rows="3" name="documentAbstract" id="documentAbstract"><c:out value='${documentItemDTO.documentAbstract}'/></textarea>
								</td>

								<th width="10%"><label for="documentDescribe">文档描述:</label></th>
								<td width="40%"  colspan="3">
									<textarea class="form-control input-sm" rows="3" name="documentDescribe" id="documentDescribe"><c:out value='${documentItemDTO.documentDescribe}'/></textarea>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="personLiableAlias">责任人:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="personLiable" name="personLiable" value="<c:out value='${documentItemDTO.personLiable}'/>">
										<input class="form-control" placeholder="请选择用户" type="text" id="personLiableAlias" name="personLiableAlias" value="<c:out value='${documentItemDTO.personLiableAlias}'/>" readonly>
										<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									</div>
								</td>

								<th width="10%"><label for="participantsAlias">参与人:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="participants" name="participants" value="<c:out value='${documentItemDTO.participants}'/>">
										<input class="form-control" placeholder="请选择用户" type="text" id="participantsAlias" name="participantsAlias" value="<c:out value='${documentItemDTO.participantsAlias}'/>" readonly>
										<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									</div>
								</td>

								<th width="10%"><label for="documentUpdateByAlias">更新人:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="documentUpdateBy" name="documentUpdateBy" value="<c:out value='${documentItemDTO.documentUpdateBy}'/>">
										<input class="form-control" placeholder="请选择用户" type="text" id="documentUpdateByAlias" name="documentUpdateByAlias" value="<c:out value='${documentItemDTO.documentUpdateByAlias}'/>" readonly>
										<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									</div>
								</td>

								<th width="10%"><label for="documentUpdateDate">最近更新时间:</label></th>
								<td width="15%">
									<div class="input-group input-group-sm">
										<input class="form-control date-picker" type="text" name="documentUpdateDate" id="documentUpdateDate" value="<c:out value='${documentItemDTO.documentUpdateDate}'/>" readonly/>
										<span class="input-group-addon">
						<i class="glyphicon glyphicon-calendar"></i>
					</span>
									</div>
								</td>
							</tr>
							<tr>
								<th width="10%"><label for="belongProject">所属项目:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="belongProject" id="belongProject" value="<c:out value='${documentItemDTO.belongProject}'/>" readonly/>
								</td>

								<th width="10%"><label for="warehouseCatelog">文档仓库目录:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="warehouseCatelog" id="warehouseCatelog" value="<c:out value='${documentItemDTO.warehouseCatelog}'/>" readonly/>
								</td>

								<th width="10%"><label for="knowScopeAlias">知悉范围:</label></th>
								<td width="15%">
									<div class="input-group  input-group-sm">
										<input type="hidden" id="knowScope" name="knowScope">
										<input class="form-control" placeholder="请选择群组" type="text" id="knowScopeAlias" name="knowScopeAlias" value="<c:out value='${documentItemDTO.knowScopeAlias}'/> readonly">
										<span class="input-group-addon"><i class="glyphicon glyphicon-equalizer"></i></span>
									</div>
								</td>

								<th width="10%"><label for="documentLabel">文档标签:</label></th>
								<td width="15%">
									<input class="form-control input-sm" type="text" name="documentLabel" id="documentLabel" value="<c:out value='${documentItemDTO.documentLabel}'/>" readonly/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<!-- 切换卡的js -->
	<script src="avicit/platform6/switch_card/yyui.js"></script>

	<script type="text/javascript">
		document.ready = function () {
			parent.documentPackage.formValidate($('#form'));
		};

		//form控件禁用
		setFormDisabled();

		$(document).keydown(function (event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>