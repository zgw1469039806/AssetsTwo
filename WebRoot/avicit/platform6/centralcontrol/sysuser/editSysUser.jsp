<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/centralcontrol/sysuser/addhead.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<div id="editSysUserTabs" class="easyui-tabs" data-options="fit:true,plain:true,tabPosition:'top',toolPosition:'right'" style="padding:0 0 1px">
			<!-- 基本信息选项卡 -->
			<div title="基本信息" data-options="iconCls:'icon-org-user'">
				<form id="formEditBaseInfo" method="post">
				<input type="hidden" name="id" id="id" value='<c:out value='${sysUser.id}'/>' />
					<table  class="form_commonTable">
						<tr>
							<th width="15%" ><span class="remind">*</span>用户编号:</th>
							<td width="35%">
								<input title="用户编号" class="easyui-validatebox" type="text" name="no" id="no" value='<c:out value='${sysUser.no}'/>' data-options="required:true" onblur="checkUserCode(this,'${userId}');" onfocus="checkInUserCode(this);"/>
							</td>
							<td width="25%" valign="top" style="padding-bottom: 6px;"
								rowspan="6">
								<div style="margin-left:20px;"> 
									<img title='上传个人头像文件' id="sysUserHeadPhotoImg" width="110px" height="120px" name="sysUserHeadPhotoImg" style="cursor:pointer;" onclick="chooseUserPhoto();"/>
								</div>
							</td>
							<td valign="top" style="padding-bottom: 6px;" rowspan="6">
								<div style="margin-left:10px;">
									<img name="sysUserSignPhotoImg" width="110" height="120" title="上传个人签名图片文件" id="sysUserSignPhotoImg" style="cursor: pointer;" onclick="chooseUserSign();"/>
								</div>
							</td>
						</tr>
						<tr>
							<th>登录名:</th>
							<td>
								<input title="登录名" class="easyui-validatebox disabled pt6-disabled" type="text" value='<c:out value='${sysUser.loginName}'/>' name="loginName" id="loginName" data-options="required:true" onblur="checkLoginName(this,'${userId}');" onfocus="checkInLoginName(this);"/>
							</td>
						</tr>
						<tr>
							<th><span class="remind">*</span>用户姓名:</th>
							<td>
								<input title="用户姓名" class="easyui-validatebox" type="text" value='<c:out value='${sysUser.name}'/>' name="name" id="name" data-options="required:true"/>
							</td>
						</tr>
						<tr>
							<th>英文名:</th>
							<td>
								<input title="英文名" class="easyui-validatebox" type="text" value='<c:out value='${sysUser.nameEn}'/>' name="nameEn" id="nameEn"/>
							</td>
						</tr>
						<tr>
							<th ><span class="remind">*</span>所在部门:</th>
							<td>
								<input type="hidden" name="deptId" id="deptId" value="${sysUser.deptId}"/>
								<div class=""><input class="easyui-validatebox" value="${sysUser.deptName}" name="deptIdAlias" id="deptIdAlias" readOnly="readOnly"></input></div>
							</td>
						</tr>
						<tr>
							<th>密级:</th>
							<td>
								<span
								style="width: 170px; height: 20px;">
									<select
									class="easyui-combobox"
									data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
									name="secretLevel" id="secretLevel" <c:if test="${isNotSaveManager}">readonly='readonly'</c:if>>
										<c:forEach items="${secret}" var="secret"> 
											<option value="${secret.lookupCode}" <c:if test="${secret.lookupCode eq defsecretLevel}">SELECTED</c:if>>${secret.lookupName}</option>
										</c:forEach> 
								  	</select>
								</span>  	
							</td>
						</tr>
					</table>
					<table class="form_commonTable">
						<tr>
							<th width="15%" >岗位名称:</th>
							<td width="35%">
								<input type="hidden" name="positionId" id="positionId" value="${sysUser.positionId}"/>
								<div class=""><input class="easyui-validatebox" name="positionName" id="positionName" readOnly="readOnly" value="${sysUser.positionName}"></input>
		                        </div>
							</td>
							<th width="15%" ><span class="remind">*</span>是否主管:</th>
							<td>
								<c:forEach items="${isManager}" var="isManager">
									<input type="radio" id="isManager${isManager.lookupCode}" name="isManager" value="${isManager.lookupCode}" <c:if test="${isManager.lookupCode eq  defisManager}">checked="true"</c:if>/><span><label for="isManager${isManager.lookupCode}">${isManager.lookupName}</label></span>
								</c:forEach>
							</td>
							
						</tr>
						<tr>
							<th >角色名称:</th>
							<td >
								<input type="hidden" name="ruleId" id="ruleId" value="${sysUser.ruleId}" />
		                        <div class=""><input class="easyui-validatebox" name="ruleName" id="ruleName" readOnly="readOnly" value="${sysUser.ruleName}"></input>
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
							<td>
								<select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="languageCode" id="languageCode">
									<c:forEach items="${language}" var="language">
										<option value="${language.languageCode}" <c:if test="${language.languageCode eq deflanguageCode}">SELECTED</c:if>>${language.languageName}</option>
									</c:forEach> 
							  	</select>
							</td>
							<th>性别:</th>
							<td>
								<c:forEach items="${sex}" var="sex">
									<input type="radio" id="sex${sex.lookupCode}" name="sex" value="${sex.lookupCode}" <c:if test="${sex.lookupCode eq defsex}">checked="true"</c:if>/><span><label for="sex${sex.lookupCode}">${sex.lookupName}</label></span>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th >职称:</th>
							<td>
							  	<pt6:syslookup name="title" lookupCode="PLATFORM_USER_TITLE" defaultValue='${sysUser.title}' dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								</pt6:syslookup>
							</td>
							<th>状态</th>
							<td>
								<c:forEach items="${status}" var="status">
									<input type="radio" id="status${status.lookupCode}" name="status" value="${status.lookupCode}" <c:if test="${status.lookupCode eq  defstatus}">checked="true"</c:if>/><span><label for="status${status.lookupCode}">${status.lookupName}</label></span>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th >民族:</th>
							<td>
								<select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="nation" id="nation" title="民族">
									<c:forEach items="${nation}" var="nation">
										<option value="${nation.lookupCode}" <c:if test="${nation.lookupCode eq defnation}">selected</c:if>>${nation.lookupName}</option>
									</c:forEach> 
							  	</select>
							</td>
							<th>籍贯:</th>
							<td>
							  	<input title="籍贯" class="easyui-validatebox" type="text" name="birthAddress" id="birthAddress" value='<c:out value='${sysUser.birthAddress}'/>'"/>
							</td>
						</tr>
						<tr>
							<th>政治面貌:</th>
							<td>
							  <select
								class="easyui-combobox"
								data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="polity" id="polity" title="政治面貌">
									<c:forEach items="${political}" var="political">
										<option value="${political.lookupCode}" <c:if test="${political.lookupCode eq defpolitical}">selected</c:if>>${political.lookupName}</option>
									</c:forEach> 
							  	</select>
							</td>
							<th>工作日期:</th>
							<td>
							  	<input title="工作日期" class="easyui-datebox easyui-validatebox" validType="past"  type="text" name="workDate" id="workDate"/>
							</td>
						</tr>
						<tr>
							<th>学历:</th>
							<td>
							  	<select
								class="easyui-combobox"
								data-options="{panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}"
								name="degree" id="degree" title="学历">
									<c:forEach items="${degree}" var="degree">
										<option value="${degree.lookupCode}" <c:if test="${degree.lookupCode eq defdegree}">selected</c:if>>${degree.lookupName}</option>
									</c:forEach> 
							  	</select>
							</td>
							<th>生日:</th>
							<td>
							  	<input title="生日" class="easyui-datebox easyui-validatebox" validType="past" type="text" name="birthday" id="birthday"/>
							</td>
						</tr>
						<tr>
							<th>毕业院校:</th>
							<td>
							  	<input title="毕业院校" class="easyui-validatebox" type="text" name="education" id="education" value='<c:out value='${sysUser.education}'/>'/>
							</td>
							<th>手机:</th>
							<td>
							  	<input title="手机" class="easyui-numberbox" type="text" name="mobile" id="mobile" value='<c:out value='${sysUser.mobile}'/>'/>
							</td>
						</tr>
						<tr>
							<th >办公电话:</th>
							<td>
								<input title="办公电话" class="easyui-validatebox" type="text" name="officeTel" id="officeTel" value='<c:out value='${sysUser.officeTel}'/>'/>
							</td>
							<th>传真:</th>
							<td>
							  	<input title="传真" class="easyui-validatebox" type="text" name="fax" id="fax" value='<c:out value='${sysUser.fax}'/>'/>
							</td>
						</tr>
						<tr>
							<th >邮箱地址:</th>
							<td>
							  	<input value='<c:out value='${sysUser.email}'/>'" class="easyui-validatebox" data-options="validType:'email'" type="text" name="email" id="email"/>
							</td>
							<th>工作地点:</th>
							<td>
							  	<input title="工作地点" class="easyui-validatebox" type="text" name="workSpace" id="workSpace" value='<c:out value='${sysUser.workSpace}'/>'/>
							</td>
						</tr>
						<tr>
							<th >房间号:</th>
							<td>
							  	<input title="房间号" class="easyui-validatebox" type="text" name="roomNo" id="roomNo" value='<c:out value='${sysUser.roomNo}'/>'/>
							</td>
							<th>家庭住址:</th>
							<td>
							  	<input title="家庭住址" class="easyui-validatebox" type="text" name="homeAddress" id="homeAddress" value='<c:out value='${sysUser.homeAddress}'/>'/>
							</td>
						</tr>
						<tr>
							<th >家庭邮编:</th>
							<td>
								  	<input title="家庭邮编" class="easyui-validatebox" type="text" name="homeZip" id="homeZip" value='<c:out value='${sysUser.homeZip}'/>'/>
							</td>
							<th>家庭电话:</th>
							<td>
								<input value='<c:out value='${sysUser.homeTel}'/>' class="easyui-validatebox" type="text" name="homeTel" id="homeTel"/>
							</td>
						</tr>
						<tr>
							<th >排序编号:</th>
							<td>
								  	<input title="排序编号" class="easyui-numberbox"  type="text" name="orderBy" id="orderBy" value='<c:out value='${sysUser.orderBy}'/>'/>
							</td>
							<th >集团编码:</th>
							<td>
							  	<input title="集团编码" class="easyui-validatebox" value='<c:out value='${sysUser.unitCode}'/>' type="text" name="unitCode" id="unitCode" onblur="checkUnitCode(this,'${userId}');" onfocus="checkInUnitCode(this);"/>
							</td>
						</tr>
						<tr>
							<th valign="top">描述:</th>
							<td colspan="3"
								style="_padding-left:16px;"><textarea
									class="textareabox"
									style="height:50px;width:391px;_width:397px;" rows="4"
									id="remark" name="remark"><c:out value='${sysUser.remark}'/></textarea></td>
						</tr>
						
						
					</table>
				</form>
			</div>
			<!-- 兼职部门选项卡 -->
			<div title="兼职部门列表" data-options="iconCls:'icon-org-map'" style="overflow:hidden;padding:2px;">
					<div id="divDept" style="height:326px;">
					<div id="toolbarMapDeptPosition" >
						<table>
							<tr>
								<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addMapDept();" href="javascript:void(0);">添加</a></td>
								<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteMapDept('${userId}');" href="javascript:void(0);">删除</a></td>
								<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveMapDept('${userId}');" href="javascript:void(0);">保存</a></td>
								<!-- <td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="closeForm();" href="javascript:void(0);">返回</a></td> -->
							</tr>
						</table>
					</div>
						<table id="dgMapDept"
								data-options="
									rownumbers: true,
									animate: true,
									collapsible: false,
									fitColumns: true,
									autoRowHeight: false,
									checkOnSelect:false,
									selectOnCheck:true,
									url: 'platform/cc/sysuser/getMapDept.json',
									method: 'post',
									fit : true,
									striped : false,
									idField :'id',
									toolbar:'#toolbarMapDeptPosition'
								">
								<thead>
									<tr>
										<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
										<th data-options="field:'deptId',hidden:true" >deptid</th>
										<th data-options="field:'deptName', halign:'center',align:'center',styler:styler" width="220"><font color="red">* </font>部门名称</th>
										<th data-options="field:'positionId', halign:'center',align:'center',hidden:true">岗位id</th>
										<th data-options="field:'positionName', halign:'center',align:'center',styler:styler" width="220"><font color="red">* </font>岗位名称</th>
										<th data-options="field:'validFlag', halign:'center',align:'center',formatter:formateValidFlag" editor="{type:'text'}" width="220">部门有效标识</th>
										<th data-options="field:'isChiefDept', halign:'center',align:'center',formatter:formateChiefDept" editor="{type:'text'}" width="120">主部门</th>
										<th data-options="field:'isManager', halign:'center',align:'center',formatter:formateManeger" editor="{type:'text'}" width="120">是否主管</th>
									</tr>
								</thead>
						</table>
					</div>	
			</div>
			<!-- 角色列表 -->
			<div title="角色列表" data-options="iconCls:'icon-org-role'" style="overflow:hidden;padding:2px;">
				<div id='divRole' style="height:326px;">
					<div id="toolbarMapUserRole" >
						<table >
							<tr>
								<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" <c:if test="${isNotSaveManager}">disabled="true"</c:if> onclick="addMapRole();" href="javascript:void(0);">添加</a></td>
								<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" <c:if test="${isNotSaveManager}">disabled="true"</c:if> onclick="deleteMapUserRole('${userId}');" href="javascript:void(0);">删除</a></td>
								<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" <c:if test="${isNotSaveManager}">disabled="true"</c:if> onclick="saveMapUserRole('${userId}');" href="javascript:void(0);">保存</a></td>
								<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
							</tr>
						</table>
					</div> 
					<table id="dgMapUserRole"
							data-options="
								rownumbers: true,
								animate: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								checkOnSelect:true,
								selectOnCheck:true,
								url: 'platform/cc/sysuser/getMapUserRole.json',
								method: 'post',
								fit : true,
								striped : false,
								idField :'id',
								frozenColumns:[[
                                  {field:'ck',checkbox:true}
			                    ]],
								toolbar:'#toolbarMapUserRole'
							" >
							<thead>
								<tr>
									<th data-options="field:'id',halign:'center',hidden:true" width="220">id</th>
									<th data-options="field:'sysRoleId',halign:'center',hidden:true" editor="{type:'text'}" width="220">id</th>
									<th data-options="field:'roleName',halign:'center',align:'center'"  width="220" editor="{type:'CommonSelector',options:{selectType:'role',width:220,dataGridId:'dgMapUserRole',dialogShowField:'roleName',roleId:'sysRoleId',roleName:'roleName',selectCount:1,dialogWidth:'600',dialogHeight:'400',callBackFun:'callBackRole'}}">角色名称</th>
									<th data-options="field:'roleType',halign:'center',align:'center',formatter:formateRoleType" editor="{type:'text'}" width="220">角色类型</th>
									<th data-options="field:'validFlag',halign:'center',align:'center',formatter:formateRoleFlag" editor="{type:'text'}" width="120">有效标识</th>
								</tr>
							</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部控制按钮 -->
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
	<!--上传用户头像对话框  -->
	<div id="addUserPhotoDialog" class="easyui-dialog" data-options="iconCls:'icon-add',resizable:true,modal:false,title:'上传头像'" style="width: 600px;height:200px;">
		<form action="" method="post" id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
			<table width="100%" border="0">
			 <tr>
			 	<td width="10%" align="right" nowrap="nowrap">选择本地头像文件</td>
			   	<td width="90%" align="left"><input type=file style='width:90%' id=sysUserPhoto name=sysUserPhoto></td>
			  </tr>
			 </table>
			 <input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="111"/>
		</form>
		<div id="upLoadPhotoToolbar" class="datagrid-toolbar datagrid-toolbar-extend" style="height:auto;display: block;">
			<table class="tableForm"  width='100%'>
				<tr>	
					<td align="right"><a title="上传" id="upLoadButton"  class="easyui-linkbutton" iconCls="icon-save" plain="false" onclick="upLoadUserPhoto('${userId}');" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnButton"  class="easyui-linkbutton" iconCls="icon-undo" plain="false" onclick="closeUpLoadUserPhoto();" href="javascript:void(0);">关闭</a></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- 上传签名文件对话框 -->
	<div id="addUserSignDialog" class="easyui-dialog" data-options="iconCls:'icon-add',resizable:true,modal:false,title:'上传签名'" style="width: 600px;height:200px;">
		<form action="platform/cc/sysuserphoto/upload/signphoto" method="post" id="uploadPersionSignForm" enctype="multipart/form-data" style="margin-top: 20px;">
			<table width="100%" border="0">
			 <tr>
			 	<td width="10%" align="right" nowrap="nowrap">选择本地签名文件</td>
			   	<td width="90%" align="left"><input type=file style='width:90%' id=sysUserSign name=sysUserSign></td>
			  </tr>
			 </table>
			 <input type=hidden id="signPhoto_sysUserId" name="signPhoto_sysUserId" value="${userId}"/>
		</form>
		<div id="upLoadSignToolbar" class="datagrid-toolbar datagrid-toolbar-extend" style="height:auto;display: block;">
			<table class="tableForm"  width='100%'>
				<tr>	
					<td align="right"><a title="上传" id="upLoadSignButton" class="easyui-linkbutton" iconCls="icon-save" plain="false" onclick="upLoadUserSign('${userId}');" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnSignButton"  class="easyui-linkbutton" iconCls="icon-undo" plain="false" onclick="closeUpLoadUserSign();" href="javascript:void(0);">关闭</a></td>
				</tr>
			</table>
		</div>
	</div>
<script type="text/javascript">
	var tabs;
	var dgMapDept;
	var dgMapUserRole;
	var editIndex = undefined;
	var editIndexRole=undefined;
	var roleValFlag;
	var roleType;
	var isNotSafeManager = '${isNotSaveManager}';
	$(function(){
		var deptIdDeptCommonSelector = new CommonSelector("dept", "deptSelectCommonDialog", "deptId", "deptIdAlias",'','',null,1,'','部门',600,400);
        deptIdDeptCommonSelector.init(null,null,1);
        
        if (isNotSafeManager != "true"){
	        var positDeptCommonSelector = new CommonSelector("position", "positSelectCommonDialog", "positionId", "positionName",'','',null,1,'','岗位',500,400);
	        positDeptCommonSelector.init(null,null,1);
	        
	        var roleCommonSelector = new CommonSelector("role", "roleSelectCommonDialog", "ruleId", "ruleName",'','',null,1,'','角色',500,400);
	        roleCommonSelector.init(null,null,1);
        }else if (isNotSafeManager == "true"){
        	$("#positionName").addClass("disabled");
        	$("#ruleName").addClass("disabled");
        }
        if (!$("#positionId").val().trim()){
        	$("#positionId").val(" ");
        }
        if (!$("#ruleId").val().trim()){
        	$("#ruleId").val(" ");
        }
        
		if(!"${sysUser['birthday']}"==""){
			$('#birthday').datebox('setValue', parserColumnTime("${sysUser['birthday']}").format("yyyy-MM-dd"));
		}
		if(!"${sysUser['workDate']}"==""){
			$('#workDate').datebox('setValue', parserColumnTime("${sysUser['workDate']}").format("yyyy-MM-dd"));
		}
		$('#addUserPhotoDialog').dialog('close',true);
		$('#addUserSignDialog').dialog('close',true);
		//sysUserId = '${userId}';
		setTimeout(loadJs, 200);
	});
	function loadJs(){
		 tabs =$('#editSysUserTabs').tabs({
		    	onSelect : function(title,index){
		    		changeTabs(title,index,'${userId}');
		    	}
		    });
		var doc = document;
	    var scriptElement = doc.createElement('script');
	    scriptElement.src="avicit/platform6/centralcontrol/sysuser/js/editjs/editJs.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="avicit/platform6/centralcontrol/sysuser/js/addEditUtil.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="static/js/platform/component/common/exteasyui.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="static/js/platform/component/commonselection/CommonSelectorDialog.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="static/js/platform/component/commonselection/commonSelectionUtil.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="static/js/platform/component/commonselection/easyui_editor_ex.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    scriptElement = doc.createElement('script');
	    scriptElement.src="static/js/platform/component/common/json2.js";
	    doc.getElementsByTagName('head')[0].appendChild(scriptElement);
	    $("#sysUserHeadPhotoImg").attr("src","platform/cc/sysuserphoto/upload/headerphoto?sysUserId=${userId}");
	    $("#sysUserSignPhotoImg").attr("src","platform/cc/sysuserphoto/upload/signphoto?sysUserId=${userId}");
	}
</script>
</body>
</html>