<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<HTML>
<head>
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' enctype="multipart/form-data">
			<input type="hidden" name="version" value='<c:out  value='${consoleUser.version}'/>' /> 
			<input type="hidden" name="id" value='<c:out  value='${consoleUser.id}'/>'/>
			<input type="hidden" name="attribute10" value='<c:out  value='${consoleUser.ruleId}'/>'/>
			<input type="file" name="userHeadUpload" id="userHeadUpload"  style="display:none;">
			
			
			<table class="form_commonTable">
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="no">用户编号:</label></th>
					<td width="39%"><input title="用户编号" class="form-control input-sm" type="text" name="no" id="no" value='<c:out  value='${consoleUser.no}'/>'/></td>
					<td width="50%" valign="top" style="padding-bottom: 6px;"
								rowspan="6">
								<div style="margin-left:100px;">
									<img title='上传个人头像文件' id="sysUserHeadPhotoImg"
										src="avicit/platform6/console/user/images/touxiang.png"
										width="130px" height="140px" name="sysUserHeadPhotoImg"
										style="cursor:pointer;" onclick="chooseUserPhoto();" />
								</div>
							</td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="loginName">登录名:</label></th>
					<td width="39%"><input title="登录名" class="form-control input-sm" type="text" name="loginName" id="loginName" value='<c:out  value='${consoleUser.loginName}'/>' /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="name">用户姓名:</label></th>
					<td width="39%"><input title="用户姓名" class="form-control input-sm" type="text" name="name" id="name" value='<c:out  value='${consoleUser.name}'/>'/></td>
					
				</tr>
				<tr>
				
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="title">职称:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="title" id="title" title="" isNull="true" lookupCode="PLATFORM_USER_TITLE" defaultValue='${consoleUser.title}'/>
					</td>
					
					
					
				</tr>
				
			</table>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="applyDeptidAlias">选部门:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="deptId" name="deptId" value='<c:out  value='${consoleUser.deptId}'/>'>
							      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptidAlias" name="applyDeptidAlias" value='<c:out  value='${consoleUser.deptName}'/>'>
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="deptbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
							</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="secretLevel">密级:</label></th>
					<td width="35%"  colspan="3">
						<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="PLATFORM_USER_SECRET_LEVEL" defaultValue='${consoleUser.secretLevel}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="applyPositionidAlias">选择岗位:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="positionId" name="positionId" value='${consoleUser.positionId}'>
							      <input class="form-control" placeholder="请选择岗位" type="text" id="applyPositionidAlias" name="applyPositionidAlias" value='<c:out  value='${consoleUser.positionName}'/>' >
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="positionbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
							</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="email">邮箱地址:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="email" id="email" value='<c:out  value='${consoleUser.email}'/>'/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="applyRoleidAlias">选角色:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ruleId" name="ruleId" value='${consoleUser.ruleId}'>
							      <input class="form-control" placeholder="请选择角色" type="text" id="applyRoleidAlias" name="applyRoleidAlias" value='<c:out  value='${consoleUser.ruleName}'/>' >
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="rolebtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
							</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="userType">类型:</label></th>
					<td width="39%"  colspan="3">
						<pt6:h5radio css_class="radio-inline"  name="type" title="" canUse="0" lookupCode="USER_TYPE" defaultValue='${consoleUser.type}'/>
					</td>
					
				</tr>
				<tr>
				
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="languageCode">语言:</label></th>
							<td width="39%">
							
							
						<select id="languageCode" name="languageCode" class="form-control input-sm" title="" data-options="">
						
						
						<c:forEach items="${language}" var="language">
										<option value="${language.languageCode}"
											<c:if test="${language.languageCode eq deflanguageCode}">SELECTED</c:if>>${language.languageName}</option>
						</c:forEach>
						
						</select>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sex">性别:</label></th>
					<td width="39%"  colspan="3">
						<pt6:h5radio css_class="radio-inline"  name="sex" title="" canUse="0" lookupCode="PLATFORM_SEX" defaultValue='${consoleUser.sex}'/>
					</td>
					
				</tr>
				<tr>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="unitCode">集团编码:</label></th>
					<td width="39%"><input title="集团编码" class="form-control input-sm" type="text" name="unitCode" id="unitCode" value='<c:out  value='${consoleUser.unitCode}'/>'/></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="status">状态:</label></th>
					
					<td width="39%" >
						<pt6:h5radio css_class="radio-inline"  name="status" title="" canUse="0" lookupCode="PLATFORM_USER_STATUS" defaultValue='${consoleUser.status}'/>
					</td>
					
					
				</tr>
				<tr>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="orderBy">排序编号:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="orderBy" id="orderBy" value='<c:out  value='${consoleUser.orderBy}'/>'/></td>
					
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="consoleType">前后台:</label></th>
					<td width="39%" >
						<pt6:h5radio css_class="radio-inline"  name="consoleType" title="" canUse="0" lookupCode="PLATFORM_CONSOLE" defaultValue='${consoleUser.consoleType}'/>
					</td>
					
				</tr>
				
			</table>
			<div id="accordion">
				<h3>扩展信息</h3>
					<div>
				<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="polity">政治面貌:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="polity" id="polity" title="" isNull="true" lookupCode="PLATFORM_POLITICAL" defaultValue='${consoleUser.polity}'/>
					</td>
					<td width="50%" valign="top" style="padding-bottom: 6px;"
								rowspan="6">
								<div style="margin-left:100px;">
									<img name="sysUserSignPhotoImg"
										src="avicit/platform6/console/user/images/qianming.png" width="130px"
										height="140px" title="上传个人签名图片文件" id="sysUserSignPhotoImg"
										style="cursor: pointer;" onclick="chooseUserSign();" />
								</div>
					</td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workDate">工作日期:</label></th>
					<td width="39%">
						<div class="input-group input-group-sm">
		                	<input class="form-control date-picker" type="text" name="workDate" id="workDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${consoleUser.workDate}"/>' /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="degree">学历:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="degree" id="degree" title="" isNull="true" lookupCode="PLATFORM_DEGREE" defaultValue='${consoleUser.degree}'/>
					</td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="birthday">生日:</label></th>
					<td width="39%">
						<div class="input-group input-group-sm">
		                	<input class="form-control date-picker" type="text" name="birthday" id="birthday" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${consoleUser.birthday}"/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	</div>
					</td>
					
				</tr>
				
			</table>
			<table class="form_commonTable">
				
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="education">毕业学校:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="education" id="education" value='<c:out  value='${consoleUser.education}'/>'/></td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="nation">民族:</label></th>
					<td width="39%" >
						<pt6:h5select css_class="form-control input-sm" name="nation" id="nation" title="" isNull="true" lookupCode="PLATFORM_FOLK" defaultValue='${consoleUser.nation}'/>
					</td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="officeTel">办公电话:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="officeTel" id="officeTel" value='<c:out  value='${consoleUser.officeTel}'/>'/></td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="fax">传真:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="fax" id="fax" value='<c:out  value='${consoleUser.fax}'/>'/></td>
					
					
				</tr>
				<tr>
					
					
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="isChiefDept">是否主管:</label></th>
						<td width="39%">
						<label class="radio-inline"> <input name="isManager" title="启用" type="radio" value="1" <c:if test="${consoleUser.isManager eq 1}">checked</c:if>>是</label>
						<label class="radio-inline"> <input name="isManager" title="禁用" type="radio" value="0" <c:if test="${consoleUser.isManager eq 0}">checked</c:if>>否</label>
						</td>
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workSpace">工作地点:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="workSpace" id="workSpace" value='<c:out  value='${consoleUser.workSpace}'/>'/></td>
					
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="roomNo">房间号:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="roomNo" id="roomNo" value='<c:out  value='${consoleUser.roomNo}'/>'/></td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="homeAddress">家庭住址:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="homeAddress" id="homeAddress" value='<c:out  value='${consoleUser.homeAddress}'/>'/></td>
					
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="homeZip">家庭邮编:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="homeZip" id="homeZip" value='<c:out  value='${consoleUser.homeZip}'/>'/></td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="homeTel">家庭电话:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="homeTel" id="homeTel" value='<c:out  value='${consoleUser.homeTel}'/>'/></td>
					
					
				</tr>
				<tr>
						
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="mobile">手机:</label></th>
					<td width="39%"><input title="" class="form-control input-sm" type="text" name="mobile" id="mobile" value='<c:out  value='${consoleUser.mobile}'/>'/></td>
					
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="nameEn">英文名:</label></th>
					<td width="39%"><input title="英文名" class="form-control input-sm" type="text" name="nameEn" id="nameEn" value='<c:out  value='${consoleUser.nameEn}'/>'/></td>
					
				</tr>
				
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="remark">其他:</label></th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3" title="" name="remark" id="remark" >${consoleUser.remark}</textarea></td>
				</tr>
			</table>
				</div>
	
			</div>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="consoleUser_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="consoleUser_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!--上传头像和签名-->
	<div id="addUserPhotoDialog" style="overflow: auto;display: none">
		<form action="platform/console/userupload/headerphoto" method="post"
			id="uploadForm" enctype="multipart/form-data"
			style="margin-top: 20px;">
			<table width="100%" border="0">
				<tr>
					<td width="10%"  nowrap="nowrap">选择本地头像文件</td>
					<td width="90%" align="left"><input type=file
						style='width:90%' id=sysUserPhoto name=sysUserPhoto></td>
				</tr>
			</table>
			<input type=hidden id="headerPhoto_sysUserId"
				name="headerPhoto_sysUserId" value="${userId}" />
		</form>
	</div>
	
	<!-- 上传签名文件对话框 -->
	<div id="addUserSignDialog" style="overflow: auto;display: none">
		<form action="platform/console/userupload/signphoto" method="post"
			id="uploadSign" enctype="multipart/form-data"
			style="margin-top: 20px;">
			<table width="100%" border="0">
				<tr>
					<td width="10%"  nowrap="nowrap">选择本地签名文件</td>
					<td width="90%" align="left"><input type=file
						style='width:90%' id=sysUserSign name=sysUserSign></td>
				</tr>
			</table>
			<input type=hidden id="headerSgin_sysUserId"
				name="headerSgin_sysUserId" value="${userId}" />
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script type="text/javascript">
	
	var isNotSafeManager = '${isNotSaveManager}';
	
	var isAdmin ='${isAdmin}';
	var viewScopeType='';
				if(isAdmin=="true"){
					viewScopeType = '';
				}else{
					viewScopeType = 'currentOrg';
				}
	var issanyuan = '${issanyuan}';
		$( function() {
			
    		$( "#accordion" ).accordion({
    		
      			collapsible: true,
      			active: false
      			
    		});
    		
    		$("#applyDeptidAlias").attr("readonly","readonly");//设为不可用
    		
    		$("#applyPositionidAlias").attr("readonly","readonly");//设为不可用
    		
    		$("#applyRoleidAlias").attr("readonly","readonly");//设为不可用
    		
    		if(issanyuan == "true"){
    		
    			$("input").each(function(i){
    		
    				if (isNotSafeManager == "true"){
    			
    			 		if(this.id=='applyRoleidAlias'){
    			 			this.disabled = 'disabled';
    			 		}
    				 }else{
    				 
    				 	if(this.id=='applyRoleidAlias'){
    			 			
    			 		}else if(this.name=='birthday'){
    			 			
    			 			this.disabled = 'disabled';
    			 			
    			 			$(this).removeClass("date-picker");
    			 		}else if(this.id=='workDate'){
    			 			this.disabled = 'disabled';
    			 			
    			 			$(this).removeClass("date-picker");
    			 		}else{
    			 			this.disabled = 'disabled';
    			 		}
    				 }
   				
 				});
 				
 				$("textarea").each(function(i){
    		
    				if (isNotSafeManager != "true"){
    					this.disabled = 'disabled';
    				 }
   				
 				});
 				
 			$("select").each(function(i){
 			
 				if (isNotSafeManager == "true"){
    			 	if(this.id=='secretLevel'){
    			 		this.disabled = 'disabled';
    			 	}
    			 	
    			}else{
    				if(this.id=='secretLevel'){
    			 		
    			 	}else{
    			 		this.disabled = 'disabled';
    			 	}
    			}
 			});
 			$("button").each(function(i){
 				 if (isNotSafeManager == "true"){
    			 	if(this.id=='rolebtn'){
    			 		this.disabled = 'disabled';
    			 	}
    			 }else{
    			 	if(this.id=='rolebtn'){
    			 		
    			 	}else{
    			 		this.disabled = 'disabled';
    			 	}
    			 }
   				
 			});
    		}
    		
    		//------加载用户头像和页签
    		
    		$("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId=${userId}");
	    	$("#sysUserSignPhotoImg").attr("src","platform/console/userupload/signphoto?sysUserId=${userId}");
    		
    		var uploadUserPhono = {   
            type: 'POST',  
           
            success:function(r){
            	document.getElementById("sysUserHeadPhotoImg").src="platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
            },    
            dataType: 'json',  
            error : function(xhr, status, err) {              
               document.getElementById("sysUserHeadPhotoImg").src="platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
            }  
        };   
        
        var uploadUserSign = {   
            type: 'POST',  
           
            success:function(r){
            	document.getElementById("sysUserSignPhotoImg").src="platform/console/userupload/signphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
            },    
            dataType: 'json',  
            error : function(xhr, status, err) {              
                document.getElementById("sysUserSignPhotoImg").src="platform/console/userupload/signphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
            }  
        };  
        
        
        $("#uploadForm").submit(function(){   
            $(this).ajaxSubmit(uploadUserPhono);   
            return false;   
        });  
        
        $("#uploadSign").submit(function(){   
            $(this).ajaxSubmit(uploadUserSign);   
            return false;   
        }); 
  		} );
  		
  		
		function closeForm(){
			parent.consoleUser.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
				$("#consoleUser_saveForm").removeClass("disabled");
	            isValidate.showErrors();
	            return false;
	        }
			  parent.consoleUser.save($('#form'),"edit");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			jQuery.validator.addMethod("alnum", function(value, element){
			return this.optional(element) ||/^[a-zA-Z]+$/.test(value);
			}, "只能包括英文字母");
			jQuery.validator.addMethod("isZipCode", function(value, element) {    
    		var tel = /^[0-9]{6}$/;
   			 return this.optional(element) || (tel.test(value));  
		}, "请正确填写您的邮政编码");  
			
						//检测手机号是否正确  
		jQuery.validator.addMethod("isMobile", function(value, element) {  
    		var length = value.length;  
    		var regPhone = /^0?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;  
   			 return this.optional(element) || ( length == 11 && regPhone.test( value ) );    
		}, "请正确填写您的手机号码");  
				jQuery.validator.addMethod("integer", function (value, element) {

    var tel = /^-?\d+$/g;  //正、负 整数 + 0

    return this.optional(element) || (tetoccSysUserManagel.test(value));

}, "请输入整数");

			jQuery.validator.addMethod("orderBy", function (value, element) {
				var pattern = /^[0-9]+([.]\d{1,2})?$/;
				return this.optional(element) || (pattern.test(value));
			}, "请输入最多两位小数点的实数");

            jQuery.validator.addMethod("phone", function(value, element) {
                var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
                return this.optional(element) || (tel.test(value));
            }, "请正确填写您的电话号码，可接受格式为'区号-号码'");

            jQuery.validator.addMethod("tel", function(value, element) {
                var tel = /^(0?\d{2,3}\-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
                return this.optional(element) || (tel.test(value));
            }, "请正确填写您的传真号码，可接受格式为'区号-号码'");

			parent.consoleUser.formValidate($('#form'));
			//保存按钮绑定事件
			$('#consoleUser_saveForm').bind('click', function(){
                $(this).addClass("disabled");
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#consoleUser_closeForm').bind('click', function(){
				closeForm();
			});
			$('#applyDeptidAlias').on('keydown',function(e){
				if(e.keyCode != '13'){
					e.returnValue=false;
					return false;
				}
				new H5CommonSelect({type:'deptSelect', idFiled:'applyDeptid',textFiled:'applyDeptidAlias'});
			});
		    $('#deptbtn').on('click',function(){
		    	new H5CommonSelect({type:'deptSelect', idFiled:'deptId',viewScope:viewScopeType,textFiled:'applyDeptidAlias'});
			});
			$('#rolebtn').on('click',function(){
		    	new H5CommonSelect({type:'roleSelect', idFiled:'ruleId',appSelectType:true, viewScope:viewScopeType,textFiled:'applyRoleidAlias'});
			});
			 $('#positionbtn').on('click',function(){
		    	new H5CommonSelect({type:'positionSelect', idFiled:'positionId',viewScope:viewScopeType,textFiled:'applyPositionidAlias'});
			});
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
		
			//打开用户头像选择
	function chooseUserPhoto(){

		layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
	
		layer.open({
			type: 1,
			shift: 5,
			title: false,
		scrollbar: false,
		move : true,
		area: ['500px', '200px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['上传', '取消'],
		content: $('#addUserPhotoDialog'),
		
		yes: function(index, layero){
			upLoadUserPhoto();
			layer.close(index);
		},
		
		btn3: function(index, layero){
			layer.close(index);
		}
	});
	
	
}


function chooseUserSign(){

		layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
	
		layer.open({
			type: 1,
			shift: 5,
			title: false,
		scrollbar: false,
		move : true,
		area: ['500px', '200px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['上传', '取消'],
		content: $('#addUserSignDialog'),
		
		yes: function(index, layero){
			upLoadUserSign();
			layer.close(index);
		},
		
		btn3: function(index, layero){
			layer.close(index);
		}
	});
	
	
}
//打开用户签名选择
function chooseUserSign(){

	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
	
		layer.open({
			type: 1,
			shift: 5,
			title: false,
		scrollbar: false,
		move : true,
		area: ['500px', '200px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['上传', '取消'],
		content: $('#addUserSignDialog'),
		
		yes: function(index, layero){
			upLoadUserSign();
			layer.close(index);
		},
		
		btn3: function(index, layero){
			layer.close(index);
		}
	});
	
	
}



function upLoadUserPhoto(){
	
	if(document.getElementById("sysUserPhoto").value != ''){
		
		if(checkfiletype('sysUserPhoto')){
			$('#uploadForm').submit();
		}else {
		layer.alert('上传文件的格式不正确!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );

		}
			
	}else{
	
		layer.alert('请选择要上传的头像文件!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );

	}	
	
}
//上传签名
function upLoadUserSign(){

	if(document.getElementById("sysUserSign").value != ''){
		if(checkfiletype('sysUserSign')){
			$('#uploadSign').submit();

		}else {
		layer.alert('上传文件的格式不正确!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );

		}
	} else {
		layer.alert('请选择要上传的签名文件!'
		 			,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
				    }
		         );

	}
}
function checkfiletype(id){
    var fileName = document.getElementById(id).value;
    //设置文件类型数组
    var extArray =[".jpg",".png",".gif",".bmp"];
   	//获取文件名称
   	while (fileName.indexOf("//") != -1)
    	fileName = fileName.slice(fileName.indexOf("//") + 1);
       	//获取文件扩展名
       	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
   		//遍历文件类型
       	var count = extArray.length;
   		for (;count--;){
     		if (extArray[count] == ext){ 
       			return true;
     		}
   		}  
   		
   return false;  
}
	</script>
</body>
</html>