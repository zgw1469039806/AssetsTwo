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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "ims/portal/stat/portalskin/portalSkinController/operation/Add/null" -->
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
			<input type="hidden" name="id"  value = '${versionId}'/> <input
				class="form-control input-sm" type="hidden" name="skinResponsibles"
				id="skinResponsibles" />
			<table class="form_commonTable">
				<tr>
					<th width="14%"><label for="skinName">皮肤名称:</label></th>
					<td width="35%"><input class="form-control input-sm"
						type="text" name="skinName" id="skinName" /></td>
					<th width="14%"><label for="skinCode">皮肤代码:</label></th>
					<td width="35%"><input class="form-control input-sm"
						type="text" name="skinCode" id="skinCode" /></td>
				</tr>
				<tr>
					<th width="14%"><label for="skinState">皮肤状态:</label></th>
					<td width="35%">
							<input title="应用程序状态" checked type="radio"
						name="skinState" id="skinState" value="0" />&ensp;启用&nbsp; <input
						title="应用程序状态"type="radio"
						name="skinState" id="skinState" value="1" />&ensp;禁用</td>
				</tr>
				<tr>
					<th width="14%"><label for="skinDesc">皮肤描述:</label></th>
					<td width="35%" colspan="3"><textarea rows="7"
							class="form-control input-sm" type="text" name="skinDesc"
							id="skinDesc"></textarea></td>

				</tr>
				
			</table>
		</form>
		<form id="imgForm" enctype="multipart/form-data" method="post">
	 		<table class="form_commonTable">
				<tr>
					<th class="text-right"  width="14%"><span class="remind">*</span>皮肤图标上传:</th>
					<td width="35%">
					<div class="input-group  input-group-sm">
					<input name="skinImg" id="skinImg"  type="file" title="皮肤图标" style="display:none" data-options="validType:'maxLength[200]',required:true" accept="image/*">  
    				
      		 	<input id="fileSelect" class="form-control input-sm" type="text" onclick="$('input[id=skinImg]').click();">  
    				<span class="input-group-addon" onclick="$('input[id=skinImg]').click();" > <i
								class="glyphicon glyphicon-folder-open" ></i>
							</span>
							</div>
						</td>
						<th width="14%" class="showNone"></th>
						<td width="35%" class="showNone"></td>
						<th width="14%" class="showImg">图标预览：</th>
						<td width="35%" class="showImg"><div id="img">
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
						title="保存" id="portalSkin_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="portalSkin_closeForm">返回</a></td>
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
	$('input[id=skinImg]').change(
			function() {
				$('#fileSelect').val(
						$(this).val().substring(
								$(this).val().lastIndexOf("\\") + 1)); //截取字符串获得文件名
				imagePreview(skinImg);      //图片预览
				if($('#fileSelect').val() != ""){
                	$('.showImg').show();
                	$('.showNone').hide();
                }else{
                	$('.showImg').hide();
                	$('.showNone').show();
                }

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
								.getElementById("img").firstChild;
						var img = document.createElement("img");
						//img.classList.add("obj");
						img.file = file;
						img.style.height = "50px";
						preview.parentNode.replaceChild(img,
								preview);
						var reader = new FileReader();
						reader.onload = (function(aImg) {
							return function(e) {
								aImg.src = e.target.result;
							};
						})(img);
						reader.readAsDataURL(file);
					}
				}; 
			});
	
	//上传附件
	function callback(id) {
		$("#id").val(id);
		$('#attachment').uploaderExt('doUpload', id);
	}
	//附件上传完后执行
	function afterUploadEvent() {
		saveForm();
	}
		function closeForm() {
			parent.portalSkin.closeDialog("insert");
		}

		$(document).ready(function() {
			$('.showImg').hide();
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

			parent.portalSkin.formValidate($('#form'));
			//保存按钮绑定事件
			$('#portalSkin_saveForm').bind('click', function() {
				callback(form.id.value);
			});
			//返回按钮绑定事件
			$('#portalSkin_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				saveType:'MobileDisk',
				secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
                tableName : 'portal_skin',
				fileNumLimit: 9,
				afterUpload : afterUploadEvent,
				accept : { title: 'Images',
				       extensions: 'jpg,jpeg,png',
				       mimeTypes: 'image/jpg,image/jpeg,image/png'}
			});
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
		$(function() {
		});
		
		

		/* //检查图片上传类型
		function checkfiletype(id) {
			var fileName = document.getElementById(id).value;
			//设置文件类型数组
			var extArray = [ ".jpg", ".png", ".gif", ".bmp" ];
			//获取文件名称
			while (fileName.indexOf("//") != -1)
				fileName = fileName.slice(fileName.indexOf("//") + 1);
			//获取文件扩展名
			var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
			//遍历文件类型
			var count = extArray.length;
			for (; count--;) {
				if (extArray[count] == ext) {
					return true;
				}
			}

			return false;
		} */

		
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			var id = "skinImg";
			var file = null;
			if (document.getElementById("skinImg").value != '') {
				var extArray = [ ".jpg", ".png", ".gif", ".bmp" ];
				if (checkfiletype('skinImg', extArray)) {
					$("#imgForm")
							.ajaxSubmit(
									{
										url : "platform/avicit/platform6/mobileportal/portalskin/controller/NewPortalSkinController/operation/dealUpLoadFile/"
												+ id,
										success : function(data) {
											var json = eval("(" + data + ")"); // data的值是json字符串，这行把字符串转成object
											//$.messager.progress('close'); // 如果提交成功则隐藏进度条
											if (json.flag == "success") {
												file = json.file;
												parent.portalSkin.save(serializeObject($('#form')),"insert", file);
											} else {
												layer.alert('保存数据出问题 ', {
													icon : 7,
													title : "警告",
													area : [ '400px', '' ]
												});
												return;
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
	</script>
</body>
</html>