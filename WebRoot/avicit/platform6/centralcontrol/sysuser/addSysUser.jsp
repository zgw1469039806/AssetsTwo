<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/centralcontrol/sysuser/addhead.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<div id="editSysUserTabs" class="easyui-tabs"
			data-options="fit:true,plain:true,tabPosition:'top',toolPosition:'right'"
			style="padding:0 0 1px">
			<!-- 基本信息选项卡 -->
			<div title="基本信息" data-options="iconCls:'icon-org-user'">
				<form id="formAddBaseInfo" method="post">
				<input type="hidden" name="id" id="id" value="${userId}"/>
					<table class="form_commonTable">
						<tr>
							<th width="15%" ><span class="remind">*</span>用户编号:</th>
							<td width="35%">
								<input title="用户编号" class="easyui-validatebox" type="text"
									name="no" id="no" data-options="required:true"
									onblur="checkUserCode(this,'');"
									onfocus="checkInUserCode(this);" />
							</td>
							<td width="25%" valign="top" style="padding-bottom: 6px;"
								rowspan="6">
								<div style="margin-left:20px;">
									<img title='上传个人头像文件' id="sysUserHeadPhotoImg"
										src="static/images/platform/sysuser/userPhoto.gif"
										width="110px" height="120px" name="sysUserHeadPhotoImg"
										style="cursor:pointer;" onclick="chooseUserPhoto();" />
								</div>
							</td>
							<td valign="top" style="padding-bottom: 6px;"
								rowspan="6">
								<div style="margin-left:10px;">
									<img name="sysUserSignPhotoImg"
										src="static/images/platform/sysuser/userSign.gif" width="110"
										height="120" title="上传个人签名图片文件" id="sysUserSignPhotoImg"
										style="cursor: pointer;" onclick="chooseUserSign();" />
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="remind">*</span>登录名:</th>
							<td>
								<input title="登录名" class="easyui-validatebox" type="text"
									name="loginName" id="loginName" data-options="required:true"
									onblur="checkLoginName(this,'');"
									onfocus="checkInLoginName(this);" />
							</td>
						</tr>
						<tr>
							<th><span class="remind">*</span>用户姓名:</th>
							<td>
								<input title="用户姓名" class="easyui-validatebox" type="text"
									name="name" id="name" data-options="required:true" />
							</td>
						</tr>
						<tr>
							<th>英文名:</th>
							<td><input title="英文名"
								class="easyui-validatebox" type="text" name="nameEn" id="nameEn" />
							</td>
						</tr>
						<tr>
							<th ><span class="remind">*</span>所在部门:</th>
							<td >
								 <input class="easyui-validatebox" type="hidden" name="deptId" id="deptId" value="${deptId}"/>
		                        <div class=""><input class="easyui-validatebox" name="deptIdAlias" id="deptIdAlias" readOnly="readOnly"></input>
		                        </div>
							</td>
						</tr>
						<tr>
							<th>密级:</th>
							<td><span
								style="width: 170px; height: 20px;"> <select
									class="easyui-combobox"
									data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
									name="secretLevel" id="secretLevel" <c:if test="${isNotSaveManager}">readonly='readonly'</c:if>>
										<c:forEach items="${secret}" var="secret">
											<option value="${secret.lookupCode}"
												<c:if test="${secret.lookupCode eq defsecretLevel}">SELECTED</c:if>>${secret.lookupName}</option>
										</c:forEach>
								</select></td>
						</tr>
					</table>
					<table class="form_commonTable">
						<tr>
							<th width="15%" >岗位名称:</th>
							<td width="35%">
								<input type="hidden" name="positionId" id="positionId" value="${defpositionId}" />
		                        <div class=""><input class="easyui-validatebox" name="positionName" id="positionName" readOnly="readOnly" value="${defpositionName}"></input>
		                        </div>
							</td>
							<th width="15%" ><span class="remind">*</span>是否主管:</th>
							<td><c:forEach items="${isManager}" var="isManager">
									<input type="radio" id="isManager${isManager.lookupCode}"
										name="isManager" value="${isManager.lookupCode}"
										<c:if test="${isManager.lookupCode eq  defisManager}">checked="true"</c:if> />
									<span><label for="isManager${isManager.lookupCode}">${isManager.lookupName}:</span>
								</c:forEach></td>

						</tr>
						<tr>
							<th>角色名称:</th>
							<td >
								<input type="hidden" name="ruleId" id="ruleId" value="${defruleId}" />
		                        <div class=""><input class="easyui-validatebox" name="ruleName" id="ruleName" readOnly="readOnly" value="${defruleName}"></input>
		                        </div>
							</td>
							<th><span class="remind">*</span>类型:</th>
							<td>
								<c:forEach items="${uType}" var="type">
									<input type="radio" id="type${type.lookupCode}" name="type" value="${type.lookupCode}" <c:if test="${type.lookupCode eq  defType}">checked="true"</c:if>/><span><label for="type${type.lookupCode}">${type.lookupName}</label></span>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th ><span class="remind">*</span>语言:</th>
							<td ><select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="languageCode" id="languageCode">
									<c:forEach items="${language}" var="language">
										<option value="${language.languageCode}"
											<c:if test="${language.languageCode eq deflanguageCode}">SELECTED</c:if>>${language.languageName}</option>
									</c:forEach>
							</select></td>
							<th>性别:</th>
							<td><c:forEach items="${sex}" var="sex">
									<input type="radio" id="sex${sex.lookupCode}" name="sex"
										value="${sex.lookupCode}"
										<c:if test="${sex.lookupCode eq defsex}">checked="true"</c:if> />
									<span><label for="sex${sex.lookupCode}">${sex.lookupName}:</span>
								</c:forEach></td>
						</tr>
						<tr>
							<th >职称:</th>
							<td>
								<pt6:syslookup name="title" isNull="false" lookupCode="PLATFORM_USER_TITLE" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup>
							</td>
							<th>状态</th>
							<td><c:forEach items="${status}" var="status">
									<input type="radio" id="status${status.lookupCode}"
										name="status" value="${status.lookupCode}"
										<c:if test="${status.lookupCode eq  defstatus}">checked="true"</c:if> />
									<span><label for="status${status.lookupCode}">${status.lookupName}:</span>
								</c:forEach></td>
						</tr>
						<tr>
							<th >民族:</th>
							<td><select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="nation" id="nation" title="民族">
									<c:forEach items="${nation}" var="nation">
										<option value="${nation.lookupCode}">${nation.lookupName}</option>
									</c:forEach>
							</select></td>
							<th>籍贯:</th>
							<td>
								<input title='籍贯' class="easyui-validatebox" type="text" name="birthAddress" id="birthAddress" value="${sysUser.birthAddress}"/>
							</td>
												
						</tr>
						<tr>
							<th>政治面貌:</th>
							<td><select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="polity" id="polity" title="政治面貌">
									<c:forEach items="${political}" var="political">
										<option value="${political.lookupCode}">${political.lookupName}</option>
									</c:forEach>
							</select></td>
							<th>工作日期:</th>
							<td><input title="工作日期"
								class="easyui-datebox easyui-validatebox"
								validType="past" type="text"
								name="workDate" id="workDate" /></td>
						</tr>
						<tr>
							<th>学历:</th>
							<td><select
								class="easyui-combobox"
								data-options="{panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="degree" id="degree" title="学历">
									<c:forEach items="${degree}" var="degree">
										<option value="${degree.lookupCode}">${degree.lookupName}</option>
									</c:forEach>
							</select></td>
							<th>生日:</th>
							<td><input title="生日"
								class="easyui-datebox easyui-validatebox"
								validType="past" type="text"
								name="birthday" id="birthday" /></td>
						</tr>
						<tr>
							<th>毕业院校:</th>
							<td>
								<!-- <input title="毕业院校" class="inputbox" type="text" name="education" id="education" /> -->
								<input class="easyui-validatebox" type="text" name="education" id="education"/>
							</td>
							<th>手机:</th>
							<td><input title="手机" class="easyui-numberbox" type="text"
								name="mobile" id="mobile" /></td>
						</tr>
						<tr>
							<th >办公电话:</th>
							<td><input title="办公电话"
								class="easyui-validatebox" type="text" name="officeTel"
								id="officeTel" /></td>
							<th>传真:</th>
							<td><input title="传真" class="easyui-validatebox" type="text"
								name="fax" id="fax" /></td>
						</tr>
						<tr>
							<th >邮箱地址:</th>
							<td>
								<input class="easyui-validatebox" data-options="validType:'email'" type="text" name="email" id="email" /></td>
							<th>工作地点:</th>
							<td><input title="工作地点" class="easyui-validatebox" type="text"
								name="workSpace" id="workSpace" /></td>
						</tr>
						<tr>
							<th >房间号:</th>
							<td><input title="房间号"
								class="easyui-validatebox" type="text" name="roomNo" id="roomNo" /></td>
							<th>家庭住址:</th>
							<td><input title="家庭住址" class="easyui-validatebox" type="text"
								name="homeAddress" id="homeAddress" /></td>
						</tr>
						<tr>
							<th >家庭邮编:</th>
							<td><input title="家庭邮编"
								class="easyui-validatebox" type="text" name="homeZip" id="homeZip" /></td>
							<th>家庭电话:</th>
							<td><input class="easyui-validatebox" type="text" name="homeTel"
								id="homeTel" /></td>
						</tr>
						<tr>
							<th >排序编号:</th>
							<td><input title="排序编号"
								class="easyui-numberbox" type="text" name="orderBy" id="orderBy" />
							</td>
							<th >集团编码:</th>
							<td><input title="集团编码" class="easyui-validatebox"
								type="text" name="unitCode" id="unitCode"
								onblur="checkUnitCode(this,'');"
								onfocus="checkInUnitCode(this);" /></td>
						</tr>
						<tr>
							<th valign="top">描述:</th>
							<td colspan="3"
								style="_padding-left:16px;"><textarea
									class="textareabox"
									style="height:50px;width:391px;_width:397px;" rows="4"
									id="remark" name="remark">${sysUser.remark}</textarea></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                        <a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
                        <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
	<!-- 底部控制按钮 
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
		<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>
				<td width="60%" align="right"><a title="保存" id="saveButton"
					class="easyui-linkbutton" iconCls="" plain="false"
					onclick="saveForm();" href="javascript:void(0);">保存</a> <a
					title="保存" id="saveAndNewButton" class="easyui-linkbutton"
					iconCls="" plain="false" onclick="saveAddForm();"
					href="javascript:void(0);">保存并继续</a> <a title="返回"
					id="returnButton" class="easyui-linkbutton" iconCls=""
					plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>


				</td>
			</tr>
		</table>
	</div>
	-->
	<!--上传用户头像对话框  -->
	<div id="addUserPhotoDialog" class="easyui-dialog"
		data-options="iconCls:'icon-add',resizable:true,modal:false,title:'上传头像'"
		style="width: 600px;height:200px;">
		<form action="platform/cc/sysuserphoto/upload/headerphoto" method="post"
			id="uploadForm" enctype="multipart/form-data"
			style="margin-top: 20px;">
			<table width="100%" border="0">
				<tr>
					<td width="10%" nowrap="nowrap">选择本地头像文件</td>
					<td width="90%" align="left"><input type=file
						style='width:90%' id=sysUserPhoto name=sysUserPhoto></td>
				</tr>
			</table>
			<input type=hidden id="headerPhoto_sysUserId"
				name="headerPhoto_sysUserId" value="${userId}" />
		</form>
		<div id="upLoadPhotoToolbar"
			class="datagrid-toolbar datagrid-toolbar-extend"
			style="height:auto;display: block;">
			<table class="tableForm" width='100%'>
				<tr>
					<td ><a title="上传" id="upLoadButton"
						class="easyui-linkbutton" iconCls="icon-save" plain="false"
						onclick="upLoadUserPhoto();" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnButton" class="easyui-linkbutton"
						iconCls="icon-undo" plain="false"
						onclick="closeUpLoadUserPhoto();" href="javascript:void(0);">关闭</a></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- 上传签名文件对话框 -->
	<div id="addUserSignDialog" class="easyui-dialog"
		data-options="iconCls:'icon-add',resizable:true,modal:false,title:'上传签名'"
		style="width: 600px;height:200px;">
		<form action="platform/cc/sysuserphoto/upload/signphoto" method="post"
			id="uploadPersionSignForm" enctype="multipart/form-data"
			style="margin-top: 20px;">
			<table width="100%" border="0">
				<tr>
					<td width="10%" nowrap="nowrap">选择本地签名文件</td>
					<td width="90%" align="left"><input type=file
						style='width:90%' id=sysUserSign name=sysUserSign></td>
				</tr>
			</table>
			<input type=hidden id="signPhoto_sysUserId"
				name="signPhoto_sysUserId" value="${userId}" />
		</form>
		<div id="upLoadSignToolbar"
			class="datagrid-toolbar datagrid-toolbar-extend"
			style="height:auto;display: block;">
			<table class="tableForm" width='100%'>
				<tr>
					<td><a title="上传" id="upLoadSignButton"
						class="easyui-linkbutton" iconCls="icon-save" plain="false"
						onclick="upLoadUserSign();" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnSignButton"
						class="easyui-linkbutton" iconCls="icon-undo" plain="false"
						onclick="closeUpLoadUserSign();" href="javascript:void(0);">关闭</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		var sysUserId;
		var isNotSafeManager = '${isNotSaveManager}';
		$(function() {
			var deptIdDeptCommonSelector = new CommonSelector("dept", "deptSelectCommonDialog", "deptId", "deptIdAlias",'','',null,1,'','部门',600,400);
	        deptIdDeptCommonSelector.init(null,null,1);
	        deptIdDeptCommonSelector.isRequired();
	        if (isNotSafeManager != "true"){
		        var positDeptCommonSelector = new CommonSelector("position", "positSelectCommonDialog", "positionId", "positionName",'','',null,1,'','岗位',500,400);
		        positDeptCommonSelector.init(null,null,1);
		        positDeptCommonSelector.isRequired();
		        var roleCommonSelector = new CommonSelector("role", "roleSelectCommonDialog", "ruleId", "ruleName",'','',null,1,'','角色',500,400);
		        roleCommonSelector.init(null,null,1);
		        roleCommonSelector.isRequired();
		        $("#positionId").val("-1000");
	        	$("#ruleId").val("-1000");
	        }else if (isNotSafeManager == "true"){
	        	$("#positionId").val("-1000");
	        	$("#positionName").val("安全管理员需分配岗位");
	        	$("#positionName").addClass("disabled");
	        	$("#ruleId").val("-1000");
	        	$("#ruleName").val("安全管理员需分配角色");
	        	$("#ruleName").addClass("disabled");
	        }
			
			$('#addUserPhotoDialog').dialog('close', true);
			$('#addUserSignDialog').dialog('close', true);
			sysUserId = '${userId}';
			if(parent){
				if(parent.queryType ==="dept"){
					$('#deptId').val(parent.queryId);
					$('#deptIdAlias').val(parent.queryName);
				}
			}
			setTimeout(loadJs, 200);
		});
		function loadJs() {

			var doc = document;
			var scriptElement = doc.createElement('script');

			scriptElement.src = "avicit/platform6/centralcontrol/sysuser/js/addjs/addJs.js";
			doc.getElementsByTagName('head')[0].appendChild(scriptElement);

			scriptElement = doc.createElement('script');
			scriptElement.src = "avicit/platform6/centralcontrol/sysuser/js/addEditUtil.js";
			doc.getElementsByTagName('head')[0].appendChild(scriptElement);

			scriptElement = doc.createElement('script');
			scriptElement.src = "static/js/platform/component/common/json2.js";
			doc.getElementsByTagName('head')[0].appendChild(scriptElement);

			scriptElement = doc.createElement('script');
			scriptElement.src = "static/js/platform/component/common/exteasyui.js";
			doc.getElementsByTagName('head')[0].appendChild(scriptElement);
		}
	</script>
</body>
</html>