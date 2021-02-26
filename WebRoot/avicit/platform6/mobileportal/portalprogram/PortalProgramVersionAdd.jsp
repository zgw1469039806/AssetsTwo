<%@page language="java" contentType="text/html; charset=utf-8"
		pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
	<!-- ControllerPath = "ims/portal/stat/portalprogram/portalProgramController/operation/sub/Add/null" -->
	<title>添加</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
			page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<form id='form'>
		<input type="hidden" name="id" value='${versionId}'/> <input type="hidden"
																	 name="programId" id="programId" />
		<input class="form-control input-sm"
			   type="hidden" name="programVersionUrl" id="programVersionUrl" />
		<input class="form-control input-sm"
			   type="hidden" name="programVersionIsNew" id="programVersionIsNew" value='0'/>
		<table class="form_commonTable">
			<tr>
				<th width="10%"><label for="programVersionName">版本名称:</label></th>
				<td width="39%" ><input class="form-control input-sm"
										type="text" name="programVersionName" id="programVersionName" />
				</td>
				<th width="10%"><label for="programVersionOpenMode">打开方式:</label></th>
				<td width="39%"><select
						class="form-control" name="programVersionOpenMode"
						id="programVersionOpenMode" title="" isNull="true">
					<option value="0">modal</option>
					<option value="1">state</option>
					<option value="2">api-modal</option>
				</select></td>

			</tr>
			<tr>
				<th width="10%"><label for="programVersionEntrance">入口地址:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionEntrance"
												   id="programVersionEntrance" /></td>
			</tr>
			<tr>
				<th width="10%"><label for="programVersionGateWay">网关地址:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionGateWay"
												   id="programVersionGateWay" /></td>
			</tr>
			<tr>
				<th width="10%"><label for="programVersionVpn">是否VPN:</label></th>
				<td width="39%"><input title="是否VPN"
									   type="radio"
									   name="programVersionVpn" value="0" />&ensp;是&nbsp;<input
						title="是否VPN" checked  type="radio"
						name="programVersionVpn" value="1" />&ensp;否&nbsp;
				</td>
				<th width="10%"><label for="programVersionState">版本状态:</label></th>
				<td width="39%"><input title="应用程序状态" checked type="radio"
									   name="programVersionState" id="programState" value="0" />&ensp;启用&nbsp; <input
						title="应用程序状态" type="radio"
						name="programVersionState" id="programState" value="1" />&ensp;禁用&nbsp; </td>
			</tr>
			<tr>
				<th width="10%"><label for="programVersionMsgHandling">消息处理:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionMsgHandling"
												   id="programVersionMsgHandling" /></td>

			</tr>
			<tr>
				<th width="10%"><label for="programVersionModuleName">包名称:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionModuleName"
												   id="programVersionModuleName" /></td>
			</tr>
			<tr>
				<th width="10%"><label for="programVersionDependance">依赖包:</label></th>
				<td width="39%" colspan="3"><input class="form-control input-sm"
												   type="text" name="programVersionDependance"
												   id="programVersionDependance" /></td>
			</tr>
			<tr>

				<th width="10%"><label for="programVersionDesc">版本描述:</label></th>
				<td width="39%" colspan="3">
						<textarea rows="4"
								  class="form-control input-sm" type="text" name="programVersionDesc" id="programVersionDesc" ></textarea>
				</td>
			</tr>

			<tr>


			</tr>

			<tr>
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
						>
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
						id="portalProgramVersion_closeForm">返回</a>
				</td>
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
    var id = '${versionId}';
    var pid = parent.portalProgramVersion.pid;
    var file =null;
    var openMode="0";
    $('input[id=programVersionManifest]').change(
        function() {
            $('#fileSelect').val(
                $(this).val().substring(
                    $(this).val().lastIndexOf("\\") + 1)); //截取字符串获得文件名
        });
    function closeForm() {
        parent.portalProgramVersion.closeDialog("insert");
    }
    function uploadForm() {
        if(openMode == "1" && document.getElementById("programVersionManifest").value == ''){ //openMode == "1" &&
            layer.alert('请上传state配置文件！', {
                icon : 7,
                title : "警告",
                area : [ '400px', '' ]
            });
            return;
        }
        //附件非空验证
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
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }

        $("#programId").val(parent.portalProgramVersion.pid);
        /* parent.portalProgramVersion.save($('#form'), callback); */
        var file =null;
        var unzipPath = null;
        var stateFile = document.getElementById("programVersionManifest").value;

        if (document.getElementById("programVersionManifest").value != '') {
            var extArray = [".json"];
            if (!checkfiletype('programVersionManifest',extArray)) {
                return;
            }
        }
        //不对state配置文件进行非空校验
        $('#stateForm')
            .ajaxSubmit(
                {
                    url : 'platform/avicit/platform6/mobileportal/portalprogram/controller/NewPortalProgramController/operation/dealUpLoadFile/'+id+'/'+openMode,
                    data : {
                        pid : pid,
                    },
                    success : function(data) {
                        var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
                        if (json.flag == "success") {
                            file = json.file;
                            unzipPath =json.unzipPath;
                            parent.portalProgramVersion.save(serializeObject($('#form')),"insert",id,file,unzipPath);
                            //限制保存按钮多次点击
                            $('#portalProgramVersion_saveForm').addClass('disabled');
                        }else if(json.flag == "failure"){
                            layer.alert(json.message, {
                                icon : 7,
                                title : "警告",
                                area : [ '400px', '' ]
                            });
                            return;
                        }
                    }
                });
    }

    //上传附件
    function callback(id) {
        $("#id").val(id);
        $('#attachment').uploaderExt('doUpload', id);
    }
    //附件上传完后执行
    function afterUploadEvent() {
        saveForm();
    }

    $(document).ready(function() {
        //从上传路径截取地址
        $('#fileSelect').val(
            $('#fileSelect').val().substring(
                $('#fileSelect').val().lastIndexOf("\\") + 1));
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
        //上传按钮绑定事件

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>