<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "ims/portal/stat/portalprogram/portalProgramController/operation/Edit/id" -->
	<title>编辑</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
			page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<form id='form'>
		<input type="hidden" name="id"
			   value="<c:out  value='${portalProgramVersionDTO.id}'/>" /> <input
			type="hidden" name="version"
			value="<c:out  value='${portalProgramVersionDTO.version}'/>" /> <input
			type="hidden" name="programId"
			value="<c:out  value='${portalProgramVersionDTO.programId}'/>" />
		<input
				type="hidden" name="programVersionUrl" id="programVersionUrl"
				value="<c:out  value='${portalProgramVersionDTO.programVersionUrl}'/>" />
		<table class="form_commonTable">
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionName">版本名称:</label></th>
				<td width="39%"><input class="form-control input-sm"
									   type="text" name="programVersionName" id="programVersionName"
									   value="<c:out  value='${portalProgramVersionDTO.programVersionName}'/>" />
				</td>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionOpenMode">打开方式:</label></th>
				<td width="39%"><select
						class="form-control input-sm" name="programVersionOpenMode"
						id="programVersionOpenMode" title="" isNull="true">
					<option value="0" <c:if test="${portalProgramVersionDTO.programVersionOpenMode == '0' }">selected</c:if>>modal</option>
					<option value="1" <c:if test="${portalProgramVersionDTO.programVersionOpenMode == '1' }">selected</c:if>>state</option>
					<option value="2" <c:if test="${portalProgramVersionDTO.programVersionOpenMode == '2' }">selected</c:if>>api-modal</option>
				</select>
				</td>
			</tr>
			<tr>

				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionEntrance">入口地址:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionEntrance"
												   id="programVersionEntrance"
												   value="<c:out  value='${portalProgramVersionDTO.programVersionEntrance}'/>" />
				</td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionGateWay">网关地址:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionGateWay"
												   id="programVersionGateWay"
												   value="<c:out  value='${portalProgramVersionDTO.programVersionGateWay}'/>" />
				</td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionVpn">是否VPN:</label></th>
				<td width="39%"><input title="是否VPN"
									   type="radio"
									   name="programVersionVpn" value="0" <c:if test="${portalProgramVersionDTO.programVersionVpn == '0' }">checked</c:if>/>&ensp;是&nbsp;<input
						title="是否VPN"  type="radio"
						name="programVersionVpn" value="1" <c:if test="${portalProgramVersionDTO.programVersionVpn == '1' }">checked</c:if>/>&ensp;否&nbsp;</td>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionState">版本状态:</label></th>
				<td width="39%"><input title="应用程序状态" checked type="radio"
									   name="programVersionState" id="programState" value="0" <c:if test="${portalProgramVersionDTO.programVersionState == '0' }">checked</c:if>/>&ensp;启用&nbsp; <input
						title="应用程序状态" type="radio"
						name="programVersionState" id="programState" value="1" <c:if test="${portalProgramVersionDTO.programVersionState == '1' }">checked</c:if>/>&ensp;禁用&nbsp; </td>
				</td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionIsNew">是否最新版:</label></th>
				<td width="39%"><input title="是否最新版"
									   type="radio"
									   name="programVersionIsNew" value="0" <c:if test="${portalProgramVersionDTO.programVersionIsNew == '0' }">checked</c:if>/>&ensp;是&nbsp;<input
						title="是否最新版"  type="radio"
						name="programVersionIsNew" value="1" <c:if test="${portalProgramVersionDTO.programVersionIsNew == '1' }">checked</c:if>/>&ensp;否&nbsp;</td>
				<th width="10%"></th>
				<td width="39%"></td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionMsgHandling">消息处理:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionMsgHandling"
												   id="programVersionMsgHandling"
												   value="<c:out  value='${portalProgramVersionDTO.programVersionMsgHandling}'/>" />
				</td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionModuleName">包名称:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionModuleName"
												   id="programVersionModuleName"
												   value="<c:out  value='${portalProgramVersionDTO.programVersionModuleName}'/>" />
				</td>
			</tr>
			<tr>

				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionDependance">依赖包:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionDependance"
												   id="programVersionDependance"
												   value="<c:out  value='${portalProgramVersionDTO.programVersionDependance}'/>" />
				</td>
			</tr>
			<tr>
				<th width="10%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programVersionDesc">版本描述:</label></th>
				<td width="39%" colspan="3"><textarea rows="4" class="form-control input-sm" type="text"  name="programVersionDesc"
													  id="programVersionDesc" >${portalProgramVersionDTO.programVersionDesc}</textarea></td>
			</tr>


			<tr>
				<th><label for="attachment">附件</label></th>
				<td colspan="<%=2 * 2 - 1%>">
					<div id="attachment"></div>
				</td>
			</tr>
		</table>
	</form>
	</form>
	<form id="stateForm" enctype="multipart/form-data" method="post">
		<table class="form_commonTable">
			<tr>
				<th class="text-right"  width="10%"><span id="stateRemind" class="remind" >*</span>STATE配置文件:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input name="programVersionManifest"
							   id="programVersionManifest"  type="file" title="STATE配置文件" style="display:none" data-options="validType:'maxLength[200]',required:true">

						<input id="fileSelect" class="form-control input-sm" type="text" onclick="$('input[id=programVersionManifest]').click();"
							   value="<c:out  value='${portalProgramVersionDTO.programVersionManifest}'/>">
						<span class="input-group-addon" onclick="$('input[id=programVersionManifest]').click();" > <i
								class="glyphicon glyphicon-folder-open" ></i>
							</span>
					</div>
				</td>
				<th width="10%"></th>
				<td width="39%"></td>
			</tr>
		</table>
	</form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
	<div id="toolbar"
		 class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm"
			   style="border: 0; cellspacing: 1; width: 100%">
			<tr>
				<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="portalProgramVersion_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="portalProgramVersion_closeForm">返回</a></td>
			</tr>
		</table>
	</div>
</div>
<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
    $('#stateRemind').hide();      //默认不显示module前面的星号
    var id = '${portalProgramVersionDTO.id}';
    var pid = '${portalProgramVersionDTO.programId}';
    var file="1";
    var openMode='${portalProgramVersionDTO.programVersionOpenMode}';
    $('input[id=programVersionManifest]').change(
        function() {
            $('#fileSelect').val(
                $(this).val().substring(
                    $(this).val().lastIndexOf("\\") + 1)); //截取字符串获得文件名
        });
    function closeForm() {
        parent.portalProgramVersion.closeDialog("edit");
    }

    function uploadForm() {

        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }

        if(openMode == "1" && document.getElementById("programVersionManifest").value == ''){
            layer.alert('请上传新state配置文件！', {
                icon : 7,
                title : "警告",
                area : [ '400px', '' ]
            });
            return;
        }
        if (document.getElementById("programVersionManifest").value != '') {
            var extArray = [".json"];
            if (!checkfiletype('programVersionManifest',extArray)) {
                return;
            }
        }
        //福建非空验证
        if(document.getElementById("attachment").children[1].firstChild.children.length == 0){
            layer.alert('请上传附件！', {
                icon : 7,
                title : "警告",
                area : [ '400px', '' ]
            });
            return;
        }
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        callback(form.id.value);
    }
    function checkfiletype(id,extArray) {
        var fileName = document.getElementById(id).value;
        //设置文件类型数组
        //var extArray = [ ".zip" ];
        //获取文件名称
        while (fileName.indexOf("//") != -1)
            fileName = fileName.slice(fileName.indexOf("//") + 1);
        //获取文件扩展名
        var ext = fileName.slice(fileName.lastIndexOf(".")).toLowerCase();
        //遍历文件类型
        var count = extArray.length;
        for (; count--;) {
            if (extArray[count] == ext) {
                return true;
            }
        }
        layer.alert('只能上传下列类型的文件: ' + extArray.join(" "), {
            icon : 2,
            title : "错误",
            area : [ '400px', '' ]
        });
        return false;
    }

    $(function() {
        $("#programVersionOpenMode").change(function(e){
            var ev = e||window.event;
            var target = ev.target||ev.srcElement;
            openMode = target.value;
            if(target.value == "1"){
                $('#stateRemind').show();
            }else{
                $('#stateRemind').hide();
            }
        });
    });

    function saveForm() {


        /* //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }*/
        $("#programId").val(parent.portalProgramVersion.pid);

        id +="deleteFile";
        //$.messager.progress(); // 显示进度条
        $('#stateForm')
            .ajaxSubmit({
                async: false,
                url : 'platform/avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/operation/dealUpLoadFile/'+id+'/'+openMode,
                data : {
                    pid : pid,
                },
                success : function(data) {
                    var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
                    //$.messager.progress('close'); // 如果提交成功则隐藏进度条
                    if (json.flag == "success") {
                        file =  json.file;
                        unzipPath =json.unzipPath;
                        parent.portalProgramVersion.save(serializeObject($('#form')),"#edit",'${portalProgramVersionDTO.id}',file,unzipPath);
                        //限制保存按钮多次点击
                        $('#portalProgramVersion_saveForm').addClass('disabled');
                    }else if(json.flag == "failure"){
                        layer.alert(json.message, {
                            icon : 7,
                            title : "警告",
                            area : [ '400px', '' ]
                        });
                        id = id.substring(0,id.length-10);
                        return;
                    }
                }
            });
    }

    $(function() {
        $("#programVersionOpenMode").change(function(e){
            var ev = e||window.event;
            var target = ev.target||ev.srcElement;
            openMode = target.value;
            if(target.value == "1"){
                $('#stateRemind').show();
            }else{
                $('#stateRemind').hide();
            }
        });
    });

    //上传附件
    function callback(id) {
        $("#id").val(id);
        $('#attachment').uploaderExt('doUpload', id);
    }
    //附件上传完后执行
    function afterUploadEvent() {
        //parent.portalProgramVersion.closeDialog('edit');
        saveForm();
    }
    document.ready = function() {


        //从上传路径截取地址
        $('#fileSelect').val(
            $('#fileSelect').val().substring(
                $('#fileSelect').val().lastIndexOf("\\") + 1));

        //打开方式判断
        if($('#programVersionOpenMode').val() != "1"){
            $('#stateRemind').hide();
        }
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine : true,//单行显示时分秒
            closeText : '确定',//关闭按钮文案
            showButtonPanel : true,//是否展示功能按钮面板
            showSecond : false,//是否可以选择秒，默认否
            beforeShow : function(selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId : '${portalProgramVersionDTO.id}',
            saveType:'MobileDisk',
            secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
            fileSizeLimit: '5000MB',
            tableName : 'portal_program_version',
            fileNumLimit: 1,
            afterUpload : afterUploadEvent,
            accept : {title: 'Zip', extensions: 'Zip',mimeTypes: 'zip/*'}
        });
        parent.portalProgramVersion.formValidate($('#form'));
        //保存按钮绑定事件
        $('#portalProgramVersion_saveForm').bind('click', function() {
            uploadForm();
        });
        //返回按钮绑定事件
        $('#portalProgramVersion_closeForm').bind('click', function() {
            closeForm();
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    };
</script>
</body>
</html>