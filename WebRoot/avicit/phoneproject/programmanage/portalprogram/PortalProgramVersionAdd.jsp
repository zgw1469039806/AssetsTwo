<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.commons.utils.ComUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "pdmt/programmanage/portalprogram/PortalProgramController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">              

<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">

	<div data-options="region:'center',split:true,border:false"
		style="overflow: auto; padding-bottom: 35px;border: 1px">
		<form id='form'>
			<input type="hidden" name="id" /> <input type="hidden"
				name="programId" id="programId" value='${id}' />
			<table width="100%" style="padding-top: 10px;border: 1px;">
				<tr>
					<th align="right" width="115px"><span class="remind">*</span>版本名称:</th>
					<td><input title="应用程序版本名称"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 180px;" type="text" name="programVersionName"
						id="programVersionName" /></td>
					<th align="right" ><span class="remind">*</span>打开方式:</th>
					<!-- <td><input title="打开方式(0.model;1.state)"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true" style="width: 180px;"
						type="text" name="programVersionOpenMode"
						id="programVersionOpenMode" /></td>  -->
					<td><select id="cc" name="programVersionOpenMode"
						style="width: 175px;" >
							<option value="0">modal</option>
							<option value="1">state</option>
					</select></td>
				</tr>
				<tr>
					<th align="right"><span class="remind">*</span>入口地址:</th>
					<td colspan='3'><input title="入口地址"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 499px;" type="text" name="programVersionEntrance"
						id="programVersionEntrance" /></td>
				</tr>
				<tr>
					<th align="right"><span class="remind">*</span>网关地址:</th>
					<td colspan='3'><input title="网关地址"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 499px;" type="text" name="programVersionGateWay"
						id="programVersionGateWay" /></td>
				</tr>
				<tr>
					<th align="right"><span class="remind">*</span>是否VPN:</th>
					<td><input title="是否VPN" 
						class="inputbox easyui-validatebox" type="radio"
						name="programVersionVpn" value="0" />是<input
						title="是否VPN" checked="checked" class="inputbox easyui-validatebox" type="radio"
						name="programVersionVpn" value="1" />否</td>
				</tr>
				<tr>
					<th align="right">消息处理:</th>
					<td colspan='3'><input title="入口地址"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]'"
						style="width: 499px;" type="text" name="programVersionMsgHandling"
						id="programVersionMsgHandling" /></td>
				</tr>
				<!-- 
				<tr>

					<th align="right">STATE配置文件:</th>
					<td colspan='3'><input title="STATE配置文件"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]',required:true"
						style="width: 453px;" type="file" name="programVersionManifest"
						id="programVersionManifest" /></td>
				</tr>
				 -->
				<tr>
					<th align="right"><span class="remind">*</span>包名称:</th>
					<td colspan='3'><input title="包名称"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 499px;" type="text" name="programVersionModuleName"
						id="programVersionModuleName" /></td>
				</tr>
				<tr>
					<th align="right">依赖包:</th>
					<td colspan='3'><input title="依赖包（多个地址，用分号分割）"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]'"
						style="width: 499px;" type="text" name="programVersionDependance"
						id="programVersionDependance" /></td>
				</tr>
				<!-- <tr>
					<th align="right"><span class="remind">*</span>版本地址:</th>
					<td colspan='3'><input title="应用程序版本地址"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 499px;" type="text" name="programVersionUrl"
						id="programVersionUrl" /></td>
				</tr> -->
				<tr>
					<!-- <th align="right">版本状态:</th>
					<td><input title="应用程序状态(0 启用；1 禁用)"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2]'" style="width: 180px;"
						type="text" name="programVersionState" id="programVersionState" />
					</td>
					 -->
					<th align="right"><span class="remind">*</span>版本状态:</th>
					<td><input title="应用程序状态" checked="checked"
						class="inputbox easyui-validatebox" type="radio"
						name="programVersionState" id="programState" value="0" />启用 <input
						title="应用程序状态" class="inputbox easyui-validatebox" type="radio"
						name="programVersionState" id="programState" value="1" />禁用</td>
				</tr>
				<tr>
					<th align="right">版本描述:</th>
					<td colspan='3'><textarea title="应用程序版本描述"
							class="inputbox easyui-validatebox"
							data-options="validType:'maxLength[2000]'"
							style="width: 496px; height: 50px" type="text"
							name="programVersionDesc" id="programVersionDesc"></textarea></td>
				</tr>
				<!-- <tr>
				<td></td>
					<td  width="10%" nowrap="nowrap">上传文件</td>
					<td colspan="2" width="90%" align="left"><input type=file
						style='width:90%' id=sysUserSign name=sysUserSign></td>
				</tr>
				<tr>
				<td></td>
					<td><a title="上传" id="upLoadSignButton"
						class="easyui-linkbutton" iconCls="icon-save" plain="false"
						onclick="upLoadUserSign();" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnSignButton"
						class="easyui-linkbutton" iconCls="icon-undo" plain="false"
						onclick="closeUpLoadUserSign();" href="javascript:void(0);">关闭</a></td>
				</tr>
				 -->
				<!-- <th align="right">应用程序版本状态(是否最新版本;):</th>
					<td><input title="应用程序版本状态(是否最新版本;)"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2]'" style="width: 180px;"
						type="text" name="programVersionIsNew" id="programVersionIsNew" />
					</td>
					 -->

				<tr>
				</tr>
			</table>
		</form>
	 	<form id="stateForm" enctype="multipart/form-data" method="post">
	 		<table width="100%" style="padding-top: 10px;">
	 		<tr>

					<!-- <th align="right" width="125px"><span class="remind">*</span>STATE配置文件:</th>
					<td colspan='3'><input title="STATE配置文件"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]',required:true"
						style="width: 499px;" type="file" name="programVersionManifest"
						id="programVersionManifest" /></td> -->
					<th align="right" width="125px"><span id="stateRemind" class="remind" >*</span>STATE配置文件:</th>
					<td colspan='3'><input title="STATE配置文件"
						class="inputbox easyui-validatebox"
						style="width: 499px;" type="file" name="programVersionManifest"
						id="programVersionManifest" /></td>
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
				<jsp:param name="form_id" value="${versionId}" />
				<jsp:param name="form_code" value="portal_program_version" />
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
						<!-- <a title="上传" id="upLoadButton"class="easyui-linkbutton" onclick="openUpLoadDialog();"href="javascript:void(0);">上传</a> -->
						<a title="保存" id="saveButton"class="easyui-linkbutton" onclick="saveForm();"href="javascript:void(0);">保存</a> 
						<a title="返回" id="returnButton"class="easyui-linkbutton" onclick="closeForm();"href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="UpLoadDialog" class="easyui-dialog"
		data-options="iconCls:'icon-add',resizable:true,modal:false,title:'上传文件'"
		style="width: 600px; height: 200px; border: 1px">
		<form
			action="platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/operation/upLoadFile"
			method="post" id="uploadForm" enctype="multipart/form-data"
			style="margin-top: 20px;">
			<table width="100%" border="0">
				<tr>
					<td width="10%" nowrap="nowrap">选择本地文件</td>
					<td width="90%" align="left"><input type=file style='width: 90%' id="loadFile" name="loadFile"></td>
				</tr>
			</table>
			<input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="${versionId}" />

		</form>
		<div id="upLoadPhotoToolbar"
			class="datagrid-toolbar datagrid-toolbar-extend"
			style="display: block;">
			<a title="上传" id="upLoadButton" class="easyui-linkbutton"
				iconCls="icon-save" plain="false" onclick="upLoadFile();"
				href="javascript:void(0);">上传</a> <a title="关闭" id="returnButton"
				class="easyui-linkbutton" iconCls="icon-undo" plain="false"
				onclick="closeUpLoadDialog();" href="javascript:void(0);">关闭</a>

		</div>

	</div>
	<script type="text/javascript">
		var id = '${versionId}';
		var file =null;
		var openMode="0";
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
		function afterUploadEvent() {
			$.messager.show({
				title : '提示',
				msg : '上传成功！'
			});
		}
		//打开上传页面
		function openUpLoadDialog() {
			$('#UpLoadDialog').dialog('open', true);
		}
		//关闭上传页面
		function closeUpLoadDialog() {
			$('#UpLoadDialog').dialog('close');
		}
		function upLoadStateFile() {
			if (document.getElementById("programVersionManifest").value != '') {
				if (checkfiletype('loadFile', [".zip",".rar"])) {
					alert("zip,rar");	
				}
			}
		}
		//检查上传类型
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
		function  upLoadFile() {	
			//alert(document.getElementById("programVersionManifest").value);
			if (document.getElementById("programVersionManifest").value != '') {
				var extArray = [".json"];
				if (checkfiletype('programVersionManifest',extArray)) {
					//$.messager.progress(); // 显示进度条
					$('#stateForm').form('submit',{
						url : 'platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/operation/dealUpLoadFile/'+id,
						success : function(data) {
							var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
							//$.messager.progress('close'); // 如果提交成功则隐藏进度条
							if (json.flag == "success") {
								file = json.file;
							}
						}
					});
				}
			} else {
				$.messager.alert('警告', '请选择要上传state的文件!', 'warning');
			}
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
			$('#stateRemind').hide();
			$('#UpLoadDialog').dialog('close', true);
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
		});
		function closeForm() {
			parent.portalProgramVersion.closeDialog("#insert");
		}
		function saveForm() {
			var file =null;
			var unzipPath = null;
			var stateFile = document.getElementById("programVersionManifest").value;
			if ($('#form').form('validate') == false) {
				return;
			}
			if(openMode == "1" && document.getElementById("programVersionManifest").value == ''){
				$.messager.alert('警告', "请上传state配置文件！", 'warning');
				return;
			}
			if (document.getElementById("programVersionManifest").value != '') {
				var extArray = [".json"];
				if (!checkfiletype('programVersionManifest',extArray)) {
					return;
				}
			}
			//不对state配置文件进行非空校验
			$('#stateForm').form('submit',{
				url : 'platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/operation/dealUpLoadFile/'+id+'/'+openMode,
				success : function(data) {
					var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
					if (json.flag == "success") {
						file = json.file;
						unzipPath =json.unzipPath;
						parent.portalProgramVersion.save(serializeObject($('#form')),"#insert",id,file,unzipPath);
					}else if(json.flag == "failure"){
						$.messager.alert('警告', json.message, 'warning');
						return;
					}
				}
			});
				
			/* if (document.getElementById("programVersionManifest").value != '') {
				var extArray = [".json"];
				if (checkfiletype('programVersionManifest',extArray)) {
					$('#stateForm').form('submit',{
						url : 'platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/operation/dealUpLoadFile/'+id,
						success : function(data) {
							var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
							//$.messager.progress('close'); // 如果提交成功则隐藏进度条
							if (json.flag == "success") {
								file = json.file;
								unzipPath =json.unzipPath;
								parent.portalProgramVersion.save(serializeObject($('#form')),"#insert",id,file,unzipPath);
							}else if(json.flag == "failure"){
								$.messager.alert('警告', json.message, 'warning');
								return;
							}
						}
					});
				}
				
			} else {
				$.messager.alert('警告', '请选择要上传state的文件!', 'warning');
				return ;
			} */
		}
		
	</script>
</body>
</html>