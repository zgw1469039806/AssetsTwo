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
		<input type="hidden" name="version"
			   value="<c:out  value='${portalProgramDTO.version}'/>" /> <input
			type="hidden" name="id"
			value="<c:out  value='${portalProgramDTO.id}'/>" />
		<table class="form_commonTable">
			<tr>
				<th width="14%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programName">应用名称:</label></th>
				<td width="35%"><input class="form-control input-sm"
									   type="text" name="programName" id="programName"
									   value="<c:out  value='${portalProgramDTO.programName}'/>" /></td>
				<th width="14%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programCode">应用代码:</label></th>
				<td width="35%"><input class="form-control input-sm"
									   type="text" name="programCode" id="programCode"
									   value="<c:out  value='${portalProgramDTO.programCode}'/>" /></td>
			</tr>
			<tr>
				<th width="14%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programResponsibles">责任人（多选）:</label></th>
				<td width="35%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="programResponsibles"
							   name="programResponsibles"
							   value="<c:out  value='${portalProgramDTO.programResponsibles}'/>">
						<input class="form-control"
							   placeholder='${portalProgramDTO.programResponsiblesAlias}'
							   type="text" id="programResponsiblesAlias"
							   name="programResponsiblesAlias"
							   value="<c:out  value='${portalProgramDTO.programResponsiblesAlias}'/>">
						<span class="input-group-addon"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="14%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programState">应用程序状态:</label></th>
				<td width="35%"><input title="应用程序状态"
									   type="radio" name="programState" id="programState" value="0"
									   <c:if test="${portalProgramDTO.programState == '0' }">checked</c:if>/>&ensp;启用&nbsp;
					<input title="应用程序状态" type="radio"
						   name="programState" id="programState" value="1"
						   <c:if test="${portalProgramDTO.programState == '1' }">checked</c:if>/>&ensp;禁用</td>
			</tr>
			<tr>
				<th width="14%"
					style="word-break: break-all; word-warp: break-word;"><label
						for="programDesc">应用程序描述:</label></th>
				<td width="35%" colspan="3"><textarea rows="7"
													  class="form-control input-sm" type="text" name="programDesc"
													  id="programDesc">${portalProgramDTO.programDesc}</textarea></td>

			</tr>
		</table>
	</form>
	<form id="ImgForm" enctype="multipart/form-data" method="post">
		<table class="form_commonTable">
			<tr>
				<th class="text-right" width="14%"
					style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span>应用图标上传:</th>
				<td>
					<div class="input-group  input-group-sm">
						<input name="programImg" id="programImg" type="file"
							   title="应用程序图标" style="display: none"
							   data-options="validType:'maxLength[200]',required:true"
							   accept="image/*"> <input id="fileSelect"
														class="form-control input-sm" type="text"
														onclick="$('input[id=programImg]').click();"
														value="<c:out  value='${portalProgramDTO.programImg}'/>">
						<span class="input-group-addon"
							  onclick="$('input[id=programImg]').click();"><i
								class="glyphicon glyphicon-folder-open"></i> </span>
					</div>
				</td>
				<th width="10%" class="showNone"></th>
				<td width="39%" class="showNone"></td>
				<th width="14%" class="showImg">图标预览：</th>
				<td width="35%" class="showImg"><div id="img">
					<img id="showImg" alt="image" height="50px"
						 src='platform/avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/operation/getImg/${portalProgramDTO.id}'>
				</div></td>
			</tr>
			<tr>
				<th><label for="attachment">预览图上传</label></th>
				<td colspan="<%=2 * 2 - 1%>">
					<div id="attachment"></div>
				</td>
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
						title="保存" id="portalProgram_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="portalProgram_closeForm">返回</a></td>
			</tr>
		</table>
	</div>
</div>
<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript"
		src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
    var oldFileUrl;
    $('input[id=programImg]')
        .change(
            function() {
                $('#fileSelect').val(
                    $(this).val()
                        .substring(
                            $(this).val().lastIndexOf(
                                "\\") + 1)); //截取字符串获得文件名
                if ($('#fileSelect').val() != "") {
                    $('.showImg').show();
                    $('.showNone').hide();
                } else {
                    $('.showImg').hide();
                    $('.showNone').show();
                }

                imagePreview(programImg); //图片预览

                function imagePreview(input) {
                    var files = input.files;

                    for (var i = 0; i < files.length; i++) {//预览新添加的图片
                        var file = files[i];
                        var imageType = /^image\//;
                        if (!imageType.test(file.type)) {
                            alert("请选择图片类型上传");
                            continue;
                        }
                        var preview = document
                            .getElementById("img");
                        var showImg = document
                            .getElementById("showImg");
                        var img = document.createElement("img");
                        img.setAttribute("id", "showImg");
                        img.classList.add("obj");
                        img.file = file;
                        img.style.height = "50px";
                        preview.replaceChild(img,
                            showImg);
                        var reader = new FileReader();
                        reader.onload = (function(aImg) {
                            return function(e) {
                                aImg.src = e.target.result;
                            };
                        })(img);
                        reader.readAsDataURL(file);
                    }
                }
                ;

            });
    function checkfiletype(id, extArray) {
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
    function closeForm() {
        parent.portalProgram.closeDialog("edit");
    }
    /* function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#portalProgram_saveForm').addClass('disabled');
        parent.portalProgram.save($('#form'), "eidt");
    } */
    function callback(id) {
        debugger;
        $('#attachment').uploaderExt('doUpload', id);
    }
    //附件上传完后执行
    function afterUploadEvent() {
        saveForm();
    }
    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }

        //附件非空验证
        /* if(document.getElementById("attachment").children[1].firstChild.children.length == 0){
            layer.alert('请上传附件！', {
                icon : 7,
                title : "警告",
                area : [ '400px', '' ]
            });
            return;
        } */
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //parent.portalProgram.save(serializeObject($('#form')), "#edit");
        var file = null;
        var id = "programImg" + "${portalProgramDTO.id}";//传入id，后台判断后进行图片保存
        //var unzipPath = null;
        if (document.getElementById("programImg").value != '') {
            var extArray = [ ".jpg", ".png", ".gif", ".bmp" ];
            if (checkfiletype('programImg', extArray)) {
                $('#ImgForm')
                    .ajaxSubmit(
                        {
                            url : 'platform/avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/operation/dealUpLoadFile/'
                            + id + '/' + '0',
                            success : function(data) {
                                var json = eval("(" + data + ")"); // data的值是json字符串，这行把字符串转成object
                                //$.messager.progress('close'); // 如果提交成功则隐藏进度条
                                if (json.flag == "success") {
                                    file = json.file;
                                    parent.portalProgram
                                        .save(
                                            serializeObject($('#form')),
                                            "#edit", file);
                                }

                            }
                        });

            }

        } else if ($('#fileSelect').val() != '') {
            var fileUrl = oldFileUrl;
            var extArray = [ ".jpg", ".png", ".gif", ".bmp" ];
            if (checkfiletype('fileSelect', extArray)) {
                $('#ImgForm')
                    .ajaxSubmit(
                        {
                            url : 'platform/avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/operation/dealUpLoadFile/'
                            + id + '/' + '0',
                            data : {
                                fileSelect : fileUrl,
                            },
                            success : function(data) {
                                var json = eval("(" + data + ")"); // data的值是json字符串，这行把字符串转成object
                                //$.messager.progress('close'); // 如果提交成功则隐藏进度条
                                if (json.flag == "success") {
                                    file = json.file;
                                    parent.portalProgram
                                        .save(
                                            serializeObject($('#form')),
                                            "#edit", file);

                                    //限制保存按钮多次点击
                                    $('#portalProgram_saveForm')
                                        .addClass('disabled');
                                }
                            }
                        });
            }

        } else {
            layer.alert('请选择要上传的图片! ', {
                icon : 7,
                title : "警告",
                area : [ '400px', '' ]
            });
            return;

        }
    }

    document.ready = function() {
        //从上传路径截取地址
        oldFileUrl = $('#fileSelect').val();
        $('#fileSelect').val(
            $('#fileSelect').val().substring(
                $('#fileSelect').val().lastIndexOf("\\") + 1));
        if ($('#fileSelect').val() != "") {
            $('.showImg').show();
            $('.showNone').hide();
        } else {
            $('.showImg').hide();
            $('.showNone').show();
        }
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine : true,//单行显示时分秒
            closeText : '确定',//关闭按钮文案
            showButtonPanel : true,//是否展示功能按钮面板
            showSecond : false,//是否可以选择秒，默认否
        });

        parent.portalProgram.formValidate($('#form'));
        //保存按钮绑定事件
        $('#portalProgram_saveForm').bind('click', function() {
            callback(form.id.value);
        });
        //返回按钮绑定事件
        $('#portalProgram_closeForm').bind('click', function() {
            closeForm();
        });

        $('#programResponsiblesAlias').on('focus', function(e) {
            new H5CommonSelect({
                type : 'userSelect',
                idFiled : 'programResponsibles',
                textFiled : 'programResponsiblesAlias',
                selectModel : 'multi',
                viewScope : 'currentOrg'
            });
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId : '${portalProgramDTO.id}',
            saveType:'MobileDisk',
            secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload : afterUploadEvent,
            tableName : 'portal_program',
            fileNumLimit: 9,
            accept : { title: 'Images',
                extensions: 'jpg,jpeg,png',
                mimeTypes: 'image/jpg,image/jpeg,image/png'}
        });
    };
</script>
</body>
</html>