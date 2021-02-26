<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
	<head>
		<title>编辑页面示例</title>
		<base href="<%=ViewUtil.getRequestPath(request)%>">
		<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js"></script>
		<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
		<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>

	</head>
	<%
		//此处生成业务对象ID
		//String id = ComUtil.getId();
		String id = "8a58ab2a485e5c9d01485e5f29fd0003";
		//8a58ab2a485e5c9d01485e5f29fd0003
		//8a58ab2a485e5c9d01485e5f29fd0002
	%>
	<script>
	function afterUploadEvent(files){
		alert("上传成功！");
		location.href = "<%=ViewUtil.getRequestPath(request)%>"+"avicit/platform6/modules/system/swfupload/swfEdit.jsp"
		//上传后事件
	}

	function aaa (fileid,td){
        td.innerHTML = '<input id="'+fileid+'_aaa" name="'+fileid+'_aaa" type="hidden"/><input id="'+fileid+'Name_aaa" name="'+fileid+'Name_aaa" type="text"/>'
        var positDeptCommonSelector = new CommonSelector("user", "positSelectCommonDialog", fileid+"_aaa", fileid+"Name_aaa",'','',null,1,'','用户',500,400);
        positDeptCommonSelector.init(null,null,1);
	}
	function bbb(fileid,td) {
        td.innerHTML = "sss";
    }
	</script>
	<body scroll="no">
		<form action="" >
			<!-- 在业务表单中把ID做为隐藏域传到后台，后台不能再重新生成ID,否则业务数据和附件对不上号 -->
			<input type="hidden" name="id" value="<%= id %>" />
		</form>
		<!-- 
			参数说明:
			file_size_limit:附件大小限制，可以带单位，合法的单位有:B、KB、MB、GB，如果省略单位，则默认为KB。该属性为0时，表示不限制文件的大小。
			file_types:允许上传的文件类型，当有多个类型时使用分号隔开，比如：*.jpg;*.png ,允许所有类型时请使用 *.*
			file_upload_limit:上传附件的数量限制，0表示不限制。
			save_type:  true:保存到数据库,false表示保存到硬盘,selfDefined表示由用户自己处理,fastdfs表示由FastDFS进行处理
			form_id:业务表ID,新增页面需要通过ConUtil.getId()先生成好ID！
			form_code:业务表的表名
			form_field(可选):用于联合展示其它form_id下的附件,多个form_id用逗号隔开
			allowAdd:是否有上传附件权限，false-无  true-有
			allowDel:是否有删除已存附件权限，false-无  true-有
			cleanOnExit:新增页面设置为true，不保存数据（以页面中saveSuccess标志判断）直接退出时，会清除附件；编辑页面可设置为false,退出时不会清空附件
			hiddenUploadBtn:是否隐藏附件上传按钮
			file_category(可选):附件分类通用代码，大小写敏感,可以为空。一般不需要
			secret_level（可选）:附件密级通用代码，大小写敏感,可以为空。此字段会和用户密级进行比较，只能上传或查看低于用户密级的附件。
			collapsed:默认是否折叠。 true-是 false-否
			file_style:显示的样式。table：表格样式；span：块状样式。默认table。
		-->
		<jsp:include page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
			<jsp:param name="file_size_limit" value="5000MB" />
			<jsp:param name="file_types" value="*.*" />
			<jsp:param name="file_upload_limit" value="10" />
			<jsp:param name="save_type" value="true" /> 
			<jsp:param name="form_id" value="<%= id %>" />
			<jsp:param name="form_code" value="pm_project" />
			<jsp:param name="form_field" value="8a58ab2a485e5c9d01485e5f29fd0001,8a58ab2a485e5c9d01485e5f29fd0001" />
			<jsp:param name="allowAdd" value="true" />
			<jsp:param name="allowDel" value="true" />
			<jsp:param name="encryption" value="true" />
			<jsp:param name="cleanOnExit" value="true" />
			<jsp:param name="hiddenUploadBtn" value="false" />
			<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
			<jsp:param name="file_category" value="PLATFORM_FILE_SECRET_LEVEL" />
			<jsp:param name="collapsed" value="false" />
			<jsp:param name="file_style" value="table" />
			<jsp:param name="self_function" value="aaa:你好,bbb:什么" />
		</jsp:include>
	</body>
</html>