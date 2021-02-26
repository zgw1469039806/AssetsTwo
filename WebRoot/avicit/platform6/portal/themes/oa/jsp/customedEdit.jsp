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
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
<style type="text/css">
	a{
		color : #555;
	}

	.img-delete {
		 position: absolute;
		 top: 0px;
		 right: 0px;
		 dispaly: inline-block;
		 z-index: 2;
		 font-size: 15px;
		width: 20px;
		height: 20px;
		background-color: #ffffff;
		text-align: center;
		opacity:0.7
	 }
	.img-delete:hover{
		cursor: pointer;
		opacity:0.9;
	}
</style>
<script type="text/javascript">
	var uid='${uid}';
</script>
</head>
<body class="easyui-layout" fit="true">
	<div style="margin:10px 20px">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#userSetting" aria-controls="userSetting" role="tab" data-toggle="tab" style="font-size: 14px">个人信息</a></li>
			<!-- <li role="presentation"><a href="#modifyPassword" aria-controls="modifyPassword" role="tab" data-toggle="tab" style="font-size: 14px">修改密码</a></li> -->
			<li role="presentation"><a href="#personGroup" aria-controls="personGroup" role="tab" data-toggle="tab" style="font-size: 14px">个人群组</a></li>
			<li role="presentation"><a href="#approvalOption" aria-controls="approvalOption" role="tab" data-toggle="tab" style="font-size: 14px">常用意见</a></li>
		</ul>
		<div class="tab-content">
			<%--个人信息--%>
			<div role="tabpanel" class="tab-pane active" id="userSetting">
				<div data-options="region:'center',split:true,border:false">
					<form id='form' enctype="multipart/form-data" style="margin-top: 20px">
						<input type="hidden" name="version" value='<c:out  value='${consoleUser.version}'/>' />
						<input type="hidden" name="id" value='<c:out  value='${consoleUser.id}'/>'/>
						<input type="hidden" name="deptId" value='<c:out  value='${consoleUser.deptId}'/>'/>
						<input type="hidden" name="positionId" value='<c:out  value='${consoleUser.positionId}'/>'/>
						<%--<input type="file" name="userHeadUpload" id="userHeadUpload"  style="display:none;">--%>
						<table class="form_commonTable">
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="nameEn">英文名:</label></th>
								<td width="39%"><input title="英文名" class="form-control input-sm" type="text" name="nameEn" id="nameEn" value='<c:out  value='${consoleUser.nameEn}'/>'/></td>
								<td width="49%" valign="top" style="padding-bottom: 6px;" rowspan="6">
											<div style="margin-left:100px; position: relative; width: 130px; height: 180px;">
												<span class="img-delete" title="删除头像" id="deleteUpdate">x</span>
												<img title='上传个人头像文件' id="sysUserHeadPhotoImg" src="avicit/platform6/console/user/images/touxiang.png"
													width="130px" height="180px" name="sysUserHeadPhotoImg" style="cursor:pointer;vertical-align:top" onclick="chooseUserPhoto();" />

											</div>
								</td>

							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sex">性别:</label></th>
								<td width="39%">
									<pt6:h5radio css_class="radio-inline"  name="sex" title="" canUse="0" lookupCode="PLATFORM_SEX" defaultValue='${consoleUser.sex}'/>
								</td>
							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="email">邮箱地址:</label></th>
								<td width="39%">
									<input title="" class="form-control input-sm" type="text" name="email" id="email" value='<c:out  value='${consoleUser.email}'/>'/>
								</td>
							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="mobile">手机:</label></th>
								<td width="39%">
									<input title="" class="form-control input-sm" type="text" name="mobile" id="mobile" value='<c:out  value='${consoleUser.mobile}'/>'/>
								</td>
							</tr>

						</table>
						<table class="form_commonTable">
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="homeAddress">家庭住址:</label></th>
								<td width="39%">
									<input title="" class="form-control input-sm" type="text" name="homeAddress" id="homeAddress" value='<c:out  value='${consoleUser.homeAddress}'/>'/>
								</td>

								<th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="officeTel">办公电话:</label></th>
								<td width="38%">
									<input title="" class="form-control input-sm" type="text" name="officeTel" id="officeTel" value='<c:out  value='${consoleUser.officeTel}'/>'/>
								</td>
							</tr>
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="homeTel">家庭电话:</label></th>
								<td width="39%" >
									<input title="" class="form-control input-sm" type="text" name="homeTel" id="homeTel" value='<c:out  value='${consoleUser.homeTel}'/>'/>
								</td>
								<th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="fax">传真:</label></th>
								<td width="38%">
									<input title="" class="form-control input-sm" type="text" name="fax" id="fax" value='<c:out  value='${consoleUser.fax}'/>'/>
								</td>
							</tr>

						</table>

					</form>
				</div>
				<div data-options="region:'south',border:false" style="height: 40px;margin-top: 80px">
					<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
						<table class="tableForm" style="border:0;cellspacing:1;width:100%">
							<tr>
								<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
									<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存" id="consoleUser_saveForm">保存</a>
									<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="consoleUser_closeForm">取消</a>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!--上传头像-->
				<div id="addUserPhotoDialog" style="overflow: auto;display: none">
					<form action="platform/console/userupload/headerphoto" method="post" id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
						<table width="100%" border="0">
							<tr>
								<td width="10%"  nowrap="nowrap">选择本地头像文件</td>
								<td width="90%" align="left"><input type=file style='width:90%' id=sysUserPhoto name=sysUserPhoto></td>
							</tr>
						</table>
						<br>
						<div style="color:red;font-style:oblique">(文件最大不能超过${maxSize}kb！)</div>
						<input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="${userId}" />
					</form>
				</div>
			</div>
			
			<%--修改密码--%>
			<!-- <div role="tabpanel" class="tab-pane" id="modifyPassword">
				<div data-options="region:'center',split:true,border:false" style='padding-left:170px;'>
					<form id='form2' style="margin-top: 20px">
						<table width="60%" border="0">
							<tr style="height:48px;">
								<td width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><label for="oldpassword"><font color='red'>*</font>旧密码:</label></td>
								<td width="39%" align="center">
									<input title="新密码" class="form-control input-sm" type="password" name="oldpassword" id="oldpassword" />
								</td>
							</tr>
							
							<tr style="height:48px;">
								<td width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><label for="mobile"><font color='red'>*</font>新密码:</label></td>
								<td width="39%" align="left">
									 <input title="" class="form-control input-sm" type="password" name="password" id="password" value=''/>
								</td>
							</tr>
							<tr style="height:48px;">
								<td width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><label for="mobile"><font color='red'>*</font>确认密码:</label></td>
								<td width="39%" align="left">
									 <input title="" class="form-control input-sm" type="password" name="confirm_password" id="confirm_password" value=''/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false" style="height: 40px;margin-top: 235px">
					<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
						<table class="tableForm" style="border:0;cellspacing:1;width:100%">
							<tr>
								<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
									<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="password_save">保存</a>
									<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="close">取消</a>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div> -->

			<%--个人群组--%>
			<div role="tabpanel" class="tab-pane" id="personGroup">
				<div id="personGroupTableToolbar" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_add" permissionDes="添加">
							<a id="personGroup_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_save" permissionDes="保存">
							<a id="personGroup_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="fa fa-save"></i> 保存</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_del" permissionDes="删除">
							<a id="personGroup_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
					</div>
				</div>
				<table id="personGroupJqGrid"></table>
				<div id="personGroupJqGridPager"></div>

			</div>

			<%--常用意见--%>
			<div role="tabpanel" class="tab-pane" id="approvalOption">
				<div id="approvalOptionTableToolbar" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_add" permissionDes="添加">
							<a id="approvalOption_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_save" permissionDes="保存">
							<a id="approvalOption_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="fa fa-save"></i> 保存</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_del" permissionDes="删除">
							<a id="approvalOption_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
					</div>
				</div>
				<table id="approvalOptionJqGrid"></table>
				<div id="approvalOptionJqGridPager"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleSelect.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/themes/oa/js/customedEdit.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/user/js/modifyPassword.js"></script>
	
	<script type="text/javascript">
		var isAdmin ='${isAdmin}';
        var maxSize = '${maxSize}';
		var viewScopeType='';
		if(isAdmin=="true"){
			viewScopeType = '';
		}else{
			viewScopeType = 'allowAcross';
		}
		$( function() {
            //检测电话号码是否正确
            jQuery.validator.addMethod("isEnName", function(value, element) {
                var enName =   /^[A-Za-z]{1}[A-Za-z ]*$/;
                return this.optional(element) || (enName.test(value));
            },"请正确填写您的英文名");

            //检测电话号码是否正确
            jQuery.validator.addMethod("isTel", function(value, element) {
                var tel =   /^\d{3,4}-?\d{7,9}$/;
                return this.optional(element) || (tel.test(value));
            },"请正确填写您的电话号码");

            //检测手机号是否正确
            jQuery.validator.addMethod("isMobile", function(value, element) {
                var length = value.length;
                var regPhone = /^0?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;
                return this.optional(element) || ( length == 11 && regPhone.test( value ) );
            }, "请正确填写您的手机号码");


    		//------加载用户头像和页签
    		$("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId=${userId}");
        
			$("#uploadForm").submit(function(){
                var uploadUserPhono = {
                    type: 'POST',
                    dataType: 'json',
                    success:function(r){
                        if(r=="1"){
                            layer.alert('文件大小超出范围！用户头像只能上传'+ maxSize +'KB以内的图片！',{
                                    icon: 7,
                                    title:'提示',
                                    area: ['400px', ''], //宽高
                                    closeBtn: 0
                                }
                            );
                        }
                        $("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random());
                        $(parent.document.body).find(".haedimg").src="platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
					},
                    error : function(xhr, status, err) {
                    	$("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random());
                        $(parent.document.body).find(".haedimg").src="platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
                	}
            };
				$(this).ajaxSubmit(uploadUserPhono);
				return false;
			});

            formValidate($('#form'));
            //保存按钮绑定事件
            $('#consoleUser_saveForm').off('click').on('click', function(){
                saveForm($('#form'));
            });
            //返回按钮绑定事件
            $('#consoleUser_closeForm').off('click').on('click', function(){
                resetUpdate();
                closeForm();
            });

            //删除按钮绑定事件
            $('#deleteUpdate').bind('click', function(){
                deleteUpdate();
            });

            //修改密码保存事件
            $('#close').off('click').on('click', function(){
                closeForm();
            });


            //初始化群组表格
            personGroupJqGridInit($("#personGroupJqGrid"));
			//添加按钮绑定事件
            $('#personGroup_insert').off('click').on('click', function(){
                addPersonGroup($("#personGroupJqGrid"));
            });
            //保存按钮绑定事件
            $('#personGroup_save').off('click').on('click', function(){
                savePersonGroup($("#personGroupJqGrid"));
            });
            //删除按钮绑定事件
            $('#personGroup_del').off('click').on('click', function(){
                deletePersonGroup($("#personGroupJqGrid"));
            });


            //初始化个人意见表格
            approvalOptionInit($("#approvalOptionJqGrid"));
			//添加按钮绑定事件
            $('#approvalOption_insert').off('click').on('click', function(){
                addApprovalOption($("#approvalOptionJqGrid"));
            });
            //保存按钮绑定事件
            $('#approvalOption_save').off('click').on('click', function(){
                saveApprovalOption($("#approvalOptionJqGrid"));
            });
            //删除按钮绑定事件
            $('#approvalOption_del').off('click').on('click', function(){
                deleteApprovalOption($("#approvalOptionJqGrid"));
            });
            
            $('#password_save').bind('click', function(){
				changePassword();
			});

  		});

        function deleteUpdate() {
            $.ajax({
                type: "post",
                data: {},
                url : "platform/console/userupload/deleteheaderphoto?sysUserId="+'${userId}'+"&o=" + Math.random(),
                success:function(r){
                    document.getElementById("sysUserHeadPhotoImg").src="platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random();
                },
            });
        }

        function resetUpdate() {
            $.ajax({
                type: "post",
                data: {},
                url : "platform/console/userupload/resetphoto?"+"&o=" + Math.random(),
            });
        }

	var modifyIndex;
	function changePassword(){
		var maxlength = shangeSelfPasswordVo.maxlength;
		var intensity = shangeSelfPasswordVo.intensity;
		var distinctBefore = shangeSelfPasswordVo.distinctBefore;
		var minlength = shangeSelfPasswordVo.minlength;
		var difference = shangeSelfPasswordVo.difference;
		var secretLevelName = shangeSelfPasswordVo.secretLevelName;
		var newPassword = $("#password").val();
		var oldPassword = $("#oldpassword").val();
		var confirmPassword = $("#confirm_password").val();
		

		if(!hasText(oldPassword)){
			top.layer.alert('旧密码不允许为空，请输入！', {
				  title : '提示',
				  icon : 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
			);
			return;
		}
		
		if(!hasText(newPassword)){
			top.layer.alert('新密码不允许为空，请输入！', {
				  title : '提示',
				  icon : 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
			);
			return;
		}
		if(!hasText(confirmPassword)){
			top.layer.alert('确认密码不允许为空，请输入！', {
				  title : '提示',
				  icon : 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
			);
			return;
		}
		if(confirmPassword != newPassword){
			top.layer.alert('确认密码和新密码不一致，请重新输入！', {
				  title : '提示',
				  icon : 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
			);
			return;
		}

		var level = 0;
		if(minlength){
			if(newPassword.length < minlength){
			  top.layer.alert("新密码的长度不能小于"+minlength+"位",{
						  		icon: 7,
						  		area: ['400px', ''], //宽高
						  		title:'提示',
						  		closeBtn: 0
					    }
			         );
			  return false;
		    }
		}else{
		}
		if(maxlength){
			if(newPassword.length > maxlength&&newPassword.length<=100){
			    top.layer.alert("新密码的长度不能大于"+maxlength+"位",{
						  		icon: 7,
						  		area: ['400px', ''], //宽高
						  		title:'提示',
						  		closeBtn: 0
					    }
			         );
			   return false;
		    }
		}else{
		}

		level= mate(newPassword);
		if(intensity!="" && intensity !=null && level<intensity){
			 top.layer.alert("新密码应最少包含以下四类字符中的"+intensity+"种（数字，小写字母，大写字母，特殊字符<包含标点符号>）",{
			  		icon: 7,
			  		titile:'提示',
			  		area: ['400px', ''], //宽高
			  		closeBtn: 0
		    	    }
     			 );
			 return false;
		}
		$('#confirmBtn').attr("disabled","disabled"); 
		//parent.modifyPassword(uid,newPassword,oldPassword);
		 $.ajax({
			url : 'platform/console/user/'+uid+'/changePassword',
			data : {newPassword: newPassword,oldPassword:oldPassword},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if(r.s){
					top.layer.alert(r.s,{
							  		icon: 6,
							  		title:'提示',
							  		area: ['400px', ''], //宽高
							  		closeBtn: 0
						    },function(){
						    	top.layer.close(top.layer.index);
						    	closeForm();
						    }
						    
				         );
				//parent.closeModiyPassworDilog();
				}else{
					top.layer.alert(r.f,{
						  		icon: 7,
						  		title:'提示',
						  		area: ['400px', ''], //宽高
						  		closeBtn: 0
					    }
			         );
				}
				
			}
		});      
		 
	}




	</script>
</body>
</html>