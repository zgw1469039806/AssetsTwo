<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/programmanage/portalskin/portalskin/PortalSkinController/operation/sub/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:auto;padding-bottom:35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${portalSkinVersionDTO.id}'/>
			<input type="hidden" name="skinId" value='${portalSkinVersionDTO.skinId}'/>
				<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right" width="110px"><span class="remind">*</span>皮肤版本:</th>
					<td><input title="皮肤版本名称"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true" style="width: 180px;"
						type="text" name="skinVersionName" id="skinVersionName"
						value='${portalSkinVersionDTO.skinVersionName}' /></td>
					<th align="right"><span class="remind">*</span>打开方式:</th>
					<td>
							<select id="cc"  name="skinVersionOpenMode" style="width:170px;">   
							    <option value="0">modal</option>   
							    <option value="1">state</option> 
							</select>  
					</td>
				</tr>
				<!-- 
				<tr>
					<th align="right"><span class="remind">*</span>皮肤入口地址:</th>
					<td colspan='3'><input title="入口地址" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true" style="width: 499px;"
						type="text" name="skinVersionEntrance"
						id="skinVersionEntrance"
						value='${portalSkinVersionDTO.skinVersionEntrance}' /></td>
						
				</tr>
				<tr>
					<th align="right"><span class="remind">*</span>包名称:</th>
					<td colspan='3'><input title="包名称" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true" style="width: 499px;"
						type="text" name="skinVersionModuleName"
						id="skinVersionModuleName"
						value='${portalSkinVersionDTO.skinVersionModuleName}' /></td>
				</tr>
				<tr>
					<th align="right">依赖包:</th>
					<td colspan='3'><input title="依赖包（多个地址，用分号分割）"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]'" style="width: 499px;"
						type="text" name="skinVersionDependance"
						id="skinVersionDependance"
						value='${portalSkinVersionDTO.skinVersionDependance}' /></td>
				</tr>
				 -->
				<tr>
					<th align="right"><span class="remind">*</span>版本状态:</th> 
					<td><input title="应用程序状态" checked="checked" class="inputbox easyui-validatebox"  
						type="radio" name="skinVersionState" id="skinState" value="0"/>启用
					<input title="应用程序状态" class="inputbox easyui-validatebox"
						type="radio" name="skinVersionState" id="skinState" value="1"/>禁用</td>	
				</tr>
				<tr>
					<th align="right">版本描述:</th>
					<td colspan='3'><textarea title="应用程序版本描述"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]'" style="width: 496px;height:50px"
						type="text" name="skinVersionDesc" id="skinVersionDesc"
						>${portalSkinVersionDTO.skinVersionDesc}</textarea> </td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
			 	<form id="stateForm" enctype="multipart/form-data" method="post">
	 		<table width="100%" style="padding-top: 10px;">
	 		<tr>

					<th align="right" width="110px"><span id="stateRemind" class="remind" >*</span>STATE配置文件:</th>
					<td colspan='3'><input title="STATE配置文件"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]'"
						style="width: 499px;" type="file" name="skinVersionManifest"
						id="skinVersionManifest" /></td>
				</tr>
			</table>
	 	</form>
		<fieldset class="attachment_box">
			<legend>附件</legend>
			<div class="formExtendBase">
			<jsp:include
				page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
				<jsp:param name="file_size_limit" value="5000MB" />
				<jsp:param name="file_types" value="*.zip" />
				<jsp:param name="file_upload_limit" value="1" />
				<jsp:param name="save_type" value="false" />
				<jsp:param name="form_id" value="${portalSkinVersionDTO.id}" />
				<jsp:param name="form_code" value="portal_skin_version" />
				<jsp:param name="allowAdd" value="true" />
				<jsp:param name="allowDel" value="true" />
				<jsp:param name="cleanOnExit" value="true" />
				<jsp:param name="hiddenUploadBtn" value="true" />
				<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
			</jsp:include>
			</div>
		</fieldset>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a title="上传" id="upLoad"class="easyui-linkbutton" onclick="upLoad();"href="javascript:void(0);">上传</a>
						<a title="保存" id="saveButton" class="easyui-linkbutton" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>	
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	var id = '${portalSkinVersionDTO.id}';
	var openMode="0";
	//打开上传页面
	function upLoad(){
		var flag=upload(id);
		if (!flag) {
			//$.messager.show({
			//	title : '提示',
			//	msg : '保存成功！'
			//});
			//console.log(flag);
		}
	}
	function openUpLoadDialog(){
		$('#UpLoadDialog').dialog('open',true);
	}
	//关闭上传页面
	function closeUpLoadDialog(){
		$('#UpLoadDialog').dialog('close');
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
		$.messager.alert('错误', '只能上传下列类型的文件: ' + extArray.join(" "),
				'error');
		return false;
	}
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
			$('#UpLoadDialog').dialog('close', true);
			$('#stateRemind').hide();
	        $("#cc").change(function(e){
	        	var ev = e||window.event;
                var target = ev.target||ev.srcElement;
                openMode = target.value;
                if(target.value == "1"){
                	$('#stateRemind').show();
                }else{
                	$('#stateRemind').hide();
                }
	        });
	        $("#cc").val("${portalSkinVersionDTO.skinVersionOpenMode}");
	        $("#cc").change();
		});
		function closeForm() {
			parent.portalSkinVersion.closeDialog("#edit");
		};
		function saveForm() {
			var file="1";
			//上传了json文件
			if ($('#form').form('validate') == false) {
				return;
			}
			if(openMode == "1" && document.getElementById("skinVersionManifest").value == ''){
				$.messager.alert('警告', "请上传state配置文件！", 'warning');
				return;
			}
			if (document.getElementById("skinVersionManifest").value != '') {
				var extArray = [".json"];
				if (!checkfiletype('skinVersionManifest',extArray)) {
					return;
				}
			}
			//if (document.getElementById("skinVersionManifest").value != '') {
				//var extArray = [".json"];
				//if (checkfiletype('skinVersionManifest',extArray)) {
					id +="deleteFile";
					//$.messager.progress(); // 显示进度条
					$('#stateForm').form('submit',{
						async: false,
						url : 'phoneproject/programmanage/portalskin/portalskin/PortalSkinController/operation/dealUpLoadFile/'+id,
						success : function(data) {
							var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
							//$.messager.progress('close'); // 如果提交成功则隐藏进度条
							if (json.flag == "success") {								
								file =  json.file;								
								unzipPath =json.unzipPath;
								parent.portalSkinVersion.save(serializeObject($('#form')),"#edit",'${portalSkinVersionDTO.id}',file,unzipPath);					
							}else if(json.flag == "failure"){
								$.messager.alert('警告', json.message, 'warning');
								id = id.substring(0,id.length-10);
								return;
							}
						}
					});
					
				//}else{
				//	file="1";//文件错误
				//}
				
			// }else{
				//file="2";//没有上传json文件
				//parent.portalProgramVersion.save(serializeObject($('#form')),"#edit",id,file);
				//$.messager.alert('警告', '请选择要上传state的文件!', 'warning');
				//return ;
			//}
		};
	</script>
</body>
</html>