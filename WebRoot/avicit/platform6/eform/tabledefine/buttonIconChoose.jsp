<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>

<!DOCTYPE html>
<html>
<head>
<%
	String id = request.getParameter("id");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>

<script>
	var id = "<%=id%>";
	function chooseIcon(iconName){
		parent.document.getElementById(id).value = iconName;
		parent.dlg_close_only('buttonIcon');
	}
</script>
</head>
<body class="easyui-layout" style="overflow:auto;" fit="true">
	<!-- BEGIN ICON -->
	<table style="width:100%">
		<tr>
			<td class="list-unstyled">
				<div>
					<i class="icon-search"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-search')">icon-search</a>
				</div>
			</td>
			<td>
				<div>
					<i class="icon-menures"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-menures')">icon-menures</a>
				</div>
			</td>
			<td>
				<div>
					<i class="icon-add"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-add')">icon-add</a>
				</div>
			</td>
		</tr>
		<tr>
				<td><div>
					<i class="icon-add_other"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-add_other')">icon-add_other</a>
				</div></td>

				<td><div>
					<i class="icon-edit"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-edit')">icon-edit</a>
				</div></td>

				<td><div>
					<i class="icon-remove"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-remove')">icon-remove</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-save"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-save')">icon-save</a>
				</div></td>

				<td><div>
					<i class="icon-cut"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-cut')">icon-cut</a>
				</div></td>

				<td><div>
					<i class="icon-ok"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-ok')">icon-ok</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-upload"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-upload')">icon-upload</a>
				</div></td>

				<td><div>
					<i class="icon-time"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-time')">icon-time</a>
				</div></td>

				<td><div>
					<i class="icon-reload"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-reload')">icon-reload</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-print"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-print')">icon-print</a>
				</div></td>

				<td><div>
					<i class="icon-help"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-help')">icon-help</a>
				</div></td>

				<td><div>
					<i class="icon-undo"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-undo')">icon-undo</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-redo"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-redo')">icon-redo</a>
				</div></td>

				<td><div>
					<i class="icon-back"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-back')">icon-back</a>
				</div></td>

				<td><div>
					<i class="icon-sum"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-sum')">icon-sum</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-tip"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-tip')">icon-tip</a>
				</div></td>
				<td><div>
					<i class="icon-filter"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-filter')">icon-filter</a>
				</div></td>

				<td><div>
					<i class="icon-submit"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-submit')">icon-submit</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-download"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-download')">icon-download</a>
				</div></td>

				<td><div>
					<i class="icon-mini-add"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-mini-add')">icon-mini-add</a>
				</div></td>

				<td><div>
					<i class="icon-mini-edit"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-mini-edit')">icon-mini-edit</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-mini-refresh"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-mini-refresh')">icon-mini-refresh</a>
				</div></td>

				<td><div>
					<i class="icon-all-file"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-all-file')">icon-all-file</a>
				</div></td>

				<td><div>
					<i class="icon-my-file"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-my-file')">icon-my-file</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-org-user"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-org-user')">icon-org-user</a>
				</div></td>

				<td><div>
					<i class="icon-org-map"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-org-map')">icon-org-map</a>
				</div></td>

				<td><div>
					<i class="icon-org-role"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-org-role')">icon-org-role</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-org-dept"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-org-dept')">icon-org-dept</a>
				</div></td>

				<td><div>
					<i class="icon-close-all"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-close-all')">icon-close-all</a>
				</div></td>

				<td><div>
					<i class="icon-close-other"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-close-other')">icon-close-other</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-tools"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-tools')">icon-tools</a>
				</div></td>

				<td><div>
					<i class="icon-valid"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-valid')">icon-valid</a>
				</div></td>

				<td><div>
					<i class="icon-invalid"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-invalid')">icon-invalid</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-import"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-import')">icon-import</a>
				</div></td>

				<td><div>
					<i class="icon-excelimport"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-excelimport')">icon-excelimport</a>
				</div></td>
				<td><div>
					<i class="icon-export"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-export')">icon-export</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-setting"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-setting')">icon-setting</a>
				</div></td>

				<td><div>
					<i class="icon-mulwindow"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-mulwindow')">icon-mulwindow</a>
				</div></td>

				<td><div>
					<i class="icon-locked"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-locked')">icon-locked</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-folder"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-folder')">icon-folder</a>
				</div></td>

				<td><div>
					<i class="icon-file"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-file')">icon-file</a>
				</div></td>

				<td><div>
					<i class="icon-trash"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-trash')">icon-trash</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-run"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-run')">icon-run</a>
				</div></td>

				<td><div>
					<i class="icon-design"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-design')">icon-design</a>
				</div></td>

				<td><div>
					<i class="icon-template"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-template')">icon-template</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-lookup"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-lookup')">icon-lookup</a>
				</div></td>

				<td><div>
					<i class="icon-refresh"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-refresh')">icon-refresh</a>
				</div></td>

				<td><div>
					<i class="icon-enlarge"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-enlarge')">icon-enlarge</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-narrow"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-narrow')">icon-narrow</a>
				</div></td>

				<td><div>
					<i class="icon-before"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-before')">icon-before</a>
				</div></td>

				<td><div>
					<i class="icon-after"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-after')">icon-after</a>
				</div></td>
</tr>
<tr>
				<td><div>
					<i class="icon-previous"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-previous')">icon-previous</a>
				</div></td>

				<td><div>
					<i class="icon-next"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-next')">icon-next</a>
				</div></td>

				<td><div>
					<i class="icon-img"></i>
					<a href="javascript:;" onclick="chooseIcon('icon-img')">icon-img</a>
				</div></td>
		</tr>
	</table>
	<!-- END ICON -->
</body>