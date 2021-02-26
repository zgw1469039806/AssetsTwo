<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<%
	String importlibs = "common,form,table";
	String recentPhotoId = request.getParameter("recentPhotoId");
	String comId = request.getParameter("comId");
	String previewWidth = request.getParameter("width");
	String previewHeight = request.getParameter("height");
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
	<link rel="stylesheet" type="text/css" href="static/css/platform/eform/jquery.Jcrop.css"/>
	<style>
		/* Apply these styles only when #preview-pane has
       been placed within the Jcrop widget */
		.jcrop-holder #preview-pane {
			display: block;
			position: absolute;
			z-index: 2000;
			right: -340px;
			padding: 6px;
			border: 1px rgba(0,0,0,.4) solid;
			background-color: white;

			-webkit-border-radius: 6px;
			-moz-border-radius: 6px;
			border-radius: 6px;

			-webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
			-moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
			box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
		}

		/* The Javascript code will set the aspect ratio of the crop
           area based on the size of the thumbnail preview,
           specified here */
		#preview-pane .preview-container {
			width: 250px;
			height: 170px;
			overflow: hidden;
		}
		.imagearea {
			margin: 20px;
			display: none;
		}
	</style>
</head>
<body class="easyui-layout" fit="true">
	<div id="addUserPhotoDialog" style="overflow: auto;height:100%">
		<form action="" method="post"
			  id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
			<table width="100%" border="0">
				<tbody>
				<tr>
					<td width="10%" nowrap>选择本地图片文件</td>
					<td width="90%" align="left"><input type="file" accept="image/*"  style="width:90%" id="eform_add_photo" name="eform_add_photo"></td>
				</tr>
				</tbody>
			</table>
			<input type="hidden" id="photo_eformId" name="photo_eformId" value="<%=comId%>">
			<input type="hidden" id="x" name="x">
			<input type="hidden" id="y" name="y">
			<input type="hidden" id="width" name="width">
			<input type="hidden" id="height" name="height">

		</form>
		<div class="imagearea">
	<img id="JcropImage" />

	<div id="preview-pane">
		<div class="preview-container">
			<img class="jcrop-preview" id="JcropPreviewImage"/>
		</div>
	</div>
		</div>

</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/eform/jquery.Jcrop.js" ></script>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script src="static/js/platform/eform/common.js" ></script>

<script>
	var width;  // 裁剪框的宽度
	var height; // 裁剪框的高度
	var x;      // 裁剪框的起点x
	var y;      // 裁剪框的起点y
	var jcrop_api;
	var previewWidth = "<%=previewWidth%>";
	var previewHeight = "<%=previewHeight%>";
	if ((previewWidth/previewHeight)>1){
		previewHeight = 250*(previewHeight/previewWidth);
		previewWidth = 250;
	}else{
		previewWidth = 250*(previewWidth/previewHeight);
		previewHeight = 250;
	}
	$('#preview-pane .preview-container').css('height',previewHeight);
	$('#preview-pane .preview-container').css('width',previewWidth);
	var xsize = $('#preview-pane .preview-container').width();  // 获取预览窗格相关信息
	var ysize = $('#preview-pane .preview-container').height();
	var $pimg = $('#preview-pane .preview-container img');
	var $preview = $('#preview-pane');
	var boundx;
	var boundy;
	var recentPhotoId = "<%=recentPhotoId%>";
	var previewphotoId = recentPhotoId+"_eformpreview";
	var eformId = "<%=comId%>";


	function initImageArea(){
		var imgURL = "platform/eform/plugin/getPhoto?photoId="+previewphotoId+"&eformId="+eformId+"&tableId=''"+"&id=''&o=" + Math.random();

		if (jcrop_api) {
			jcrop_api.destroy();
		}
		$('#JcropImage').css('height', '');
		$('#JcropImage').css('width', '');

		$('#JcropImage').attr('src', imgURL);
		$('#JcropPreviewImage').attr('src', imgURL);
		setTimeout(function(){
			$('#JcropImage').Jcrop({
				setSelect: [ 0, 0, 2000, 2000 ],
				allowResize: true,
				allowSelect: false,
				onChange : updatePreview,
				onSelect : updatePreview,
				aspectRatio : xsize / ysize,
				boxWidth: 400,
				boxHeight: 400
			}, function() {
				// 使用API来获得真实的图像大小
				var bounds = this.getBounds();
				boundx = bounds[0];
				boundy = bounds[1];
				jcrop_api = this;
				// 预览进入jcrop容器css定位
				$preview.appendTo(jcrop_api.ui.holder);
				updatePreview();
			});
		},200);

	}
	$('#eform_add_photo').change(function(event) {
		$("#x").val("");
		$("#y").val("");
		$("#width").val("");
		$("#height").val("");
		upLoadUserPhoto(previewphotoId,function(){
			initImageArea();
			$(".imagearea").show();
		});
	});

	function uploadCropImage(){
		upLoadUserPhoto(recentPhotoId,function () {
			window.parent.document.getElementById(recentPhotoId).src = "platform/eform/plugin/getPhoto?photoId="+recentPhotoId+"&eformId="+eformId+"&tableId=''"+"&id=''&o=" + Math.random();
			document.getElementById("eform_add_photo").value ="";
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		});

	}


	function updatePreview(c) {
		var jcropImage = $('#JcropImage').attr('src');
		var jcropPreviewImage = $('#JcropPreviewImage').attr('src');
		if (jcropImage != jcropPreviewImage) {
			$('#JcropPreviewImage').attr('src', jcropImage);
			$('#JcropPreviewImage').css('width', xsize);
			$('#JcropPreviewImage').css('height', '');
		}

		if (c != undefined){
			if (parseInt(c.w) > 0) {
				var rx = xsize / c.w;
				var ry = ysize / c.h;
				$pimg.css({
					width : Math.round(rx * boundx) + 'px',
					height : Math.round(ry * boundy) + 'px',
					marginLeft : '-' + Math.round(rx * c.x) + 'px',
					marginTop : '-' + Math.round(ry * c.y) + 'px'
				});
			}
			x = Math.round(c.x);
			y = Math.round(c.y);
			width = Math.round(c.w);
			height = Math.round(c.h);
			$("#x").val(x);
			$("#y").val(y);
			$("#width").val(width);
			$("#height").val(height);
		}
	};
</script>
</html>