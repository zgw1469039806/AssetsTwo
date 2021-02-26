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
<!-- ControllerPath = "phoneproject/programmanage/portalprogram/PortalProgramController/operation/Add/null" -->
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
		style="overflow: auto; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" />
			<table  width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span class="remind">*</span>应用名称:</th>
					<td><input title="应用程序名称" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 170px;" type="text" name="programName"
						id="programName" /></td>
					<th align="right"><span class="remind">*</span>应用代码:</th>
					<td><input title="应用程序代码" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true,validType:'programCode'"
						style="width: 170px;" type="text" name="programCode"
						id="programCode" /></td>
				</tr>
				<!-- <tr>
					<th align="right"><span class="remind">*</span>应用图标地址:</th>
					<td colspan="3"><input title="应用程序图标"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 469px;" type="text" name="programImg"
						id="programImg" /></td>

				</tr> -->
				<tr>
					 <th align="right"><span class="remind">*</span>责任人（多选）:</th>  
					<!-- <th ><span class="remind">*</span>角色名称:</th> -->
					 <td colspan="3"><input title="责任人（多选）" class="inputbox easyui-validatebox" readonly="readonly"
						data-options="validType:'maxLength[2000]',required:true" onclick="insertUser()"
						style="width: 470px;" type="text" name="programResponsibleShow" id="programResponsibleShow" 
						/> 
						<input title="责任人（多选）" class="inputbox easyui-validatebox" readonly="readonly" type="hidden"
						data-options="validType:'maxLength[2000]',required:true" onclick="insertUser()"
						style="width: 469px;" type="text" name="programResponsibles"
						id="programResponsibles" /> 
					</td> 
					<td>
					
					<!-- <input type="button" onclick="insertUser()" value="选人"> -->
					<input type="hidden" id="userId" >
					<input type="hidden" id="userName">
					</td>
				</tr>
				<tr>
					<th align="right"><span class="remind">*</span>应用程序状态:</th>
					<td><input title="应用程序状态" checked="checked"
						class="inputbox easyui-validatebox" type="radio"
						name="programState" id="programState" value="0" />启用 <input
						title="应用程序状态" class="inputbox easyui-validatebox" type="radio"
						name="programState" id="programState" value="1" />禁用</td>
				</tr>
				<tr>
					<th align="right">应用程序描述:</th>
					<td colspan="3"><textarea class="textareabox" title="应用程序描述"
							class="inputbox easyui-validatebox"
							data-options="validType:'maxLength[2000]'"
							style="width: 466px; height: 150px" name="programDesc"
							id="programDesc"></textarea></td>

				</tr>
				
			</table>
		</form>
		<form id="ImgForm" enctype="multipart/form-data" method="post">
	 		<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right" width="117px"><span class="remind">*</span>应用图标上传:</th>
					<td colspan="3"><input title="应用程序图标"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]',required:true"
						style="width: 470px;" type="file" name="programImg"
						id="programImg" /></td>

				</tr>
			</table>
	 	</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right">
						
						<a title="保存" id="saveButton" class="easyui-linkbutton" onclick="saveForm();" href="javascript:void(0);">保存</a> 
						<a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
						</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	var doc = document;
		var users =[];
		var userAndId = [];
		//选择用户
		function insertUser(){
			var comSelector = new CommonSelector("user","userSelectCommonDialog","userId","userName",null,null,null,false,null,null,600,400);
			comSelector.init(false,'selectUserCallBack','n');
		}
	
		function selectUserCallBack(data){
			var l=data.length;
			if(l>0){
				for(;l--;){
					users.push(data[l].userName);
					userAndId.push(data[l].userId);
					//userAndId.push(data[l].userName);
					doc.getElementById('programResponsibleShow').value=users;
					doc.getElementById('programResponsibles').value=userAndId;
				}
				
			}
		};
		/* $.extend(
			$.fn.validatebox.defaults.rules,
				{
					programCode : {
						validator : function(value, param) {
							$.ajax({
								type : 'post',//请求类型：post或者get
								url : 'platform/pdmt/programmanage/portalprogram/PortalProgramController/operation/validate/'
										+ value,//请求的方法get_name
								data : {},//参数
								success : function(msg) {
									if (msg.flag == "success") {
										flag = true;
									} else if (msg.flag == "failure") {
										flag = false;
									}
								}
							});
						
							return flag;
						},
						message : '应用代码已被占用'
					}
				}); */
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
		});
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
		function closeForm() {
			parent.portalProgram.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			//parent.portalProgram.save(serializeObject($('#form')), "#insert");
			var id = "programImg";
			var file =null;
			//var unzipPath = null;
			if ($('#form').form('validate') == false) {
				return;
			}
			if (document.getElementById("programImg").value != '') {
				var extArray = [".jpg",".png",".gif",".bmp"];
				if (checkfiletype('programImg',extArray)) {
					$('#ImgForm').form('submit',{
						url : 'platform/phoneproject/programmanage/portalprogram/PortalProgramManageController/operation/dealUpLoadFile/'+id+'/'+'0',
						success : function(data) {
							var json = eval("("+data+")"); // data的值是json字符串，这行把字符串转成object
							//$.messager.progress('close'); // 如果提交成功则隐藏进度条
							if (json.flag == "success") {
								file = json.file;
								parent.portalProgram.save(serializeObject($('#form')), "#insert",file);
							}
						}
					});
				}
				
			} else {
				$.messager.alert('警告', '请选择要上传的图片!', 'warning');
				return ;
			}
		}
	</script>
</body>
</html>