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
	<title>添加</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
	<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
	<script src="static/fixie/utils/easyui_editor_ex.js" type="text/javascript"></script>
	<style type="text/css">
		a{
			color : #555;
		}
	</style>
	<script type="text/javascript">
		var uid='${uid}';
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div style="margin:0px 20px">
		<div class="easyui-tabs" id="settingContent" style="width:860px;height: 510px" data-options="border:false,fit:true">
			<%--个人信息--%>
			<div title="个人信息" style="padding:10px;" id="userSetting" >
				<div data-options="region:'center',split:true,border:false">
					<form id='form' enctype="multipart/form-data" style="margin-top: 20px">
						<input type="hidden" name="version" value='<c:out  value='${consoleUser.version}'/>' />
						<input type="hidden" name="id" value='<c:out  value='${consoleUser.id}'/>'/>
						<input type="hidden" name="deptId" value='<c:out  value='${consoleUser.deptId}'/>'/>
						<input type="hidden" name="positionId" value='<c:out  value='${consoleUser.positionId}'/>'/>
						<%--<input type="file" name="userHeadUpload" id="userHeadUpload"  style="display:none;">--%>
						<table class="form_commonTable">
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;">英文名:</th>
								<td width="38%"><input title="英文名" class="easyui-validatebox" data-options="validType:['isEnName','maxLength[50]']" type="text" name="nameEn" id="nameEn" style="width:315px!important" value='<c:out  value='${consoleUser.nameEn}'/>'/></td>
								<td width="48%" valign="top" style="padding-bottom: 6px;" rowspan="6">
											<div style="margin-left:110px;">
												<img title='上传个人头像文件' id="sysUserHeadPhotoImg" src="avicit/platform6/console/user/touxiang.svg"
													width="130px" height="180px" name="sysUserHeadPhotoImg" style="cursor:pointer;" onclick="chooseUserPhoto();" />
											</div>
								</td>
							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;">性别:</th>
								<td width="38%">
									<pt6:JigsawRadio  name="sex" title="" canUse="0" lookupCode="PLATFORM_SEX" defaultValue='${consoleUser.sex}'/>
								</td>
							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;">邮箱地址:</th>
								<td width="38%">
									<input title="" class="easyui-validatebox" data-options="validType:['email','maxLength[50]']" type="text" name="email" id="email" style="width:315px!important" value='<c:out  value='${consoleUser.email}'/>'/>
								</td>
							</tr>
							<tr>
								<th width="10%" style="word-break: break-all; word-warp: break-word;">手机:</th>
								<td width="38%">
									<input title="" class="easyui-validatebox" data-options="validType:['isMobile','maxLength[50]']" type="text" name="mobile" id="mobile" style="width:315px!important" value='<c:out  value='${consoleUser.mobile}'/>'/>
								</td>
							</tr>
						</table>
						<table class="form_commonTable">
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;">家庭住址:</th>
								<td width="38%">
									<input title="" class="easyui-validatebox" data-options="validType:'maxLength[100]'" type="text" name="homeAddress" id="homeAddress" value='<c:out  value='${consoleUser.homeAddress}'/>'/>
								</td>

								<th width="10%" style="word-break: break-all; word-warp: break-word;">办公电话:</th>
								<td width="38%">
									<input title="" class="easyui-validatebox" data-options="validType:['isTel','maxLength[50]']" type="text" name="officeTel" id="officeTel" value='<c:out  value='${consoleUser.officeTel}'/>'/>
								</td>
							</tr>
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;">家庭电话:</th>
								<td width="38%" >
									<input title="" class="easyui-validatebox" data-options="validType:['isTel','maxLength[50]']" type="text" name="homeTel" id="homeTel" value='<c:out  value='${consoleUser.homeTel}'/>'/>
								</td>
								<th width="10%" style="word-break: break-all; word-warp: break-word;">传真:</th>
								<td width="38%">
									<input title="" class="easyui-validatebox" data-options="validType:['isTel','maxLength[50]']" type="text" name="fax" id="fax" value='<c:out  value='${consoleUser.fax}'/>'/>
								</td>
							</tr>

						</table>

					</form>
				</div>
				<div data-options="region:'south',border:false" style="height: 40px;">
					<div id="toolbar1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
						<div class="tableForm" style="text-align:right;padding-right:4%;">
							<a href="javascript:void(0)" style="margin-right:10px;" class="easyui-linkbutton primary-btn" role="button" title="保存" id="consoleUser_saveForm">保存</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" role="button" title="取消" id="consoleUser_closeForm">取消</a>
						</div>
					</div>
				</div>
				<%--<!--上传头像-->
				<div id="addUserPhotoDialog" style="overflow: auto;display: none">
					<form action="platform/console/userupload/headerphoto" method="post" id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
						<table width="100%" border="0">
							<tr>
								<td width="10%"  nowrap="nowrap">选择本地头像文件</td>
								<td width="90%" align="left"><input type=file style='width:90%' id=sysUserPhoto name=sysUserPhoto></td>
							</tr>
						</table>
						<input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="${userId}" />
					</form>
				</div>--%>
			</div>
			
			<%--修改密码--%>
			<div title="修改密码" style="padding:10px;" id="modifyPassword">
				<div data-options="region:'center',split:true,border:false" style='padding:0px 170px 0px 150px '>
					<form id='form2' style="margin-top: 20px">
						<table class="form_commonTable" width="60%" border="0" >
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><font color='red'>*</font>旧密码:</th>
								<td width="39%" align="left">
									<input title="旧密码" class="easyui-validatebox" type="password" name="oldpassword" id="oldpassword" />
								</td>
							</tr>
							
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><font color='red'>*</font>新密码:</th>
								<td width="39%" align="left">
									 <input title="" class="easyui-validatebox" type="password" name="password" id="password" value=''/>
								</td>
							</tr>
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;" align="right"><font color='red'>*</font>确认密码:</th>
								<td width="39%" align="left">
									 <input title="" class="easyui-validatebox" type="password" name="confirm_password" id="confirm_password" value=''/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false" style="height: 40px;">
					<div id="toolbar2" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
						<div class="tableForm" style="text-align:right;padding-right:4%;">
							<a href="javascript:void(0)" style="margin-right:10px;" class="easyui-linkbutton primary-btn" role="button" title="保存" id="password_save">保存</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" role="button" title="取消" id="close">取消</a>
						</div>
					</div>
				</div>
			</div>

			<%--个人群组--%>
			<div title="个人群组" style="padding:10px;" id="personGroup">
				<div id="personGroupTableToolbar" class="datagrid-toolbar" style="overflow: auto; zoom: 1;">
					<div class="ext-toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_add" permissionDes="添加">
							<a id="personGroup_insert" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" title="添加">添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_save" permissionDes="保存">
							<a id="personGroup_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" title="保存">保存</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_personGroup_button_del" permissionDes="删除">
							<a id="personGroup_del" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" title="删除">删除</a>
						</sec:accesscontrollist>
					</div>
				</div>
				<table id="personGroupJqGrid" class="easyui-datagrid"
					   data-options="
							fit: true,
							border: false,
							rownumbers: true,
							animate: true,
							collapsible: false,
							fitColumns: true,
							autoRowHeight: false,
							toolbar:'#personGroupTableToolbar',
							idField:'id',
							singleSelect: true,
							checkOnSelect: true,
							selectOnCheck: false,
							pagination:true,
							method:'get',
							url:'platform/console/customed/getPersonalGroupListByPageIe?random='+Math.random(),
							pageSize:dataOptions.pageSize,
							pageList:dataOptions.pageList,
							popWindowCount:0,
							onLoadSuccess:loadSuccess,
							pageSize:15,
							striped:true">
					<thead>
					<tr>
						<th data-options="field:'id',halign:'center',checkbox:true" width="20">主键</th>
						<th data-options="field:'sysGroupId',align:'center', hidden:'true',editor:{type:'text'}" >群组ID</th>
						<th data-column="true" data-options="field:'sysGroupName',align:'center',editor:{type:'text'}" width="250">群组名称</th>
						<th data-options="field:'sysUserId', halign:'center', hidden:'true',editor:{type:'text'}" >群组成员ID</th>
						<th data-column="true" data-options="field:'sysUserIdAlias', halign:'center',editor:{type:'text'}"
							editor="{type:'EasyuiCommonSelect',
											options:{	type:'userSelect',
														selectModel:'multi',
														dataGridId:'personGroupJqGrid',
														idFiled:'sysUserId',
														viewScope:'currentOrg',
														textFiled:'sysUserIdAlias',
														callBack:callBackUser
														}}"
							width="540">群组成员</th>
					</tr>
					</thead>
				</table>
			</div>

			<%--常用意见--%>
			<div title="常用意见" style="padding:10px;" id="approvalOption">
				<div id="approvalOptionTableToolbar" class="datagrid-toolbar" style="overflow: auto; zoom: 1;">
					<div class="ext-toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_add" permissionDes="添加">
							<a id="approvalOption_insert" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" title="添加">添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_save" permissionDes="保存">
							<a id="approvalOption_save" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" title="保存">保存</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysCustomed_approvalOption_button_del" permissionDes="删除">
							<a id="approvalOption_del" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" title="删除">删除</a>
						</sec:accesscontrollist>
					</div>
				</div>
				<table id="approvalOptionJqGrid" class="easyui-datagrid"
					   data-options="
							fit: true,
							border: false,
							rownumbers: true,
							animate: true,
							collapsible: false,
							fitColumns: true,
							autoRowHeight: false,
							toolbar:'#approvalOptionTableToolbar',
							idField :'id',
							singleSelect: true,
							checkOnSelect: true,
							selectOnCheck: false,
							pagination:true,
							method:'get',
							url:'platform/console/customed/getApprovalOptionListByPageIe?random='+Math.random(),
							pageSize:dataOptions.pageSize,
							pageList:dataOptions.pageList,
							popWindowCount:0,
							onLoadSuccess:loadSuccess,
							onAfterEdit:afterEdit,
							pageSize:15,
							striped:true">
					<thead>
					<tr>
						<th data-options="field:'id',halign:'center',checkbox:true" width="20">主键</th>
						<th data-column="true" data-options="field:'value',align:'center',editor:{type:'text'}" width="250">审批意见</th>
						<th data-column="true" data-options="field:'processType',align:'center',formatter:formatterProcessType"
							editor="{type:'EasyuiCombobox',options:{panelHeight:'auto',
																editable:false,
																valueField:'value',
																textField:'text',
																data:[{ 'value':'1','text':'全部'},{ 'value':'0','text':'自定义'}]}}" width="100">类型</th>
						<th data-options="field:'processIds', halign:'center', hidden:'true',editor:{type:'text'}" >流程ID</th>
						<th data-options="field:'hiddenProcessIds', halign:'center', hidden:'true',editor:{type:'text'}" >流程ID</th>
						<th data-options="field:'hiddenProcessIdsAlias', halign:'center', hidden:'true',editor:{type:'text'}" >流程名称</th>
						<th data-options="field:'processName', halign:'center', hidden:'true',editor:{type:'text'}" >流程名称</th>
						<th data-column="true" data-options="field:'processIdsAlias', halign:'center'"
							editor="{type:'EasyuiBpmModuleSelect',
										options:{
												 dataGridId:'approvalOptionJqGrid',
												 idFiled:'processIds',
												 textFiled:'processIdsAlias',
												 othersFiled:'processType',
												 editable:false
									}}"
							width="540">流程名称</th>
					</tr>
					</thead>
				</table>
			</div>
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
			<input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="${userId}" />
		</form>
	</div>

	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmbusiness/workhand/js/BpmModuleSelect_easyui.js"></script>
	<script type="text/javascript" src="avicit/platform6/portalie/js/customedEditIe.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/user/js/modifyPassword.js"></script>
	
	<script type="text/javascript">
		var isAdmin ='${isAdmin}';
		var viewScopeType='';
		if(isAdmin=="true"){
			viewScopeType = '';
		}else{
			viewScopeType = 'allowAcross';
		}

		$( function() {
            $.extend($.fn.validatebox.defaults.rules, {
                isEnName: {
                    validator: function(value,param){
                        var enName =   /^[A-Za-z]{1}[A-Za-z ]*$/;
                        return  enName.test(value);
                    },
                    message: '请正确填写您的英文名'
                },
                isTel: {
                    validator: function(value,param){
                        var tel =   /^\d{3,4}-?\d{7,9}$/;
                        return  tel.test(value);
                    },
                    message: '请正确填写您的电话号码'
                },
                isMobile: {
                    validator: function(value,param){
                        var length = value.length;
                        var regPhone = /^0?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;
                        return  length == 11 && regPhone.test( value );
                    },
                    message: '请正确填写您的手机号码'
                }
            });

            var processType;
            //扩展流程选择框
            $.extend($.fn.datagrid.defaults.editors, {
                EasyuiBpmModuleSelect: {
                    init: function(container, options){
                        var dataGridId = options.dataGridId ;
                        var rowIndex = container[0].parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getAttribute("datagrid-row-index");

                        var row = $('#'+options.dataGridId).datagrid('getRows')[rowIndex];
                        processType = row[options.othersFiled];
                        if(processType == '0') {
                            var combo = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
                            combo.combobox(options || {textField: options.textFiled});

                            new BpmModuleSelect(options.idFiled, container, function (data) {
                                var editorAlias = $('#'+options.dataGridId).datagrid('getEditor', {
                                    index: rowIndex,
                                    field: options.textFiled
                                });
                                $(editorAlias.target).combobox('setValue', data.texts);
                                var editorId = $('#'+options.dataGridId).datagrid('getEditor', {
                                    index: rowIndex,
                                    field: options.idFiled
                                });
                                $(editorId.target).val(data.ids);
                            });
                            return combo;
                        }else{
                            return $('').appendTo(container);
						}
                    },
                    destroy: function(target){
                        if(processType == '0') {
                            $(target).combobox('destroy');
                        }
                    },
                    getValue: function(target){
                        if(processType == '0') {
                            return $(target).combobox('getValue');
                        }else{
                            return "";
						}

                    },
                    setValue: function(target, value){
                        if(processType == '0') {
                            var opts = $(target).combobox('options');
                            $(target).combobox('setValue', value);
                        }else{
                            $(target).combobox('setValue', "");
						}
                    },
                    resize: function(target, width){
                        if(processType == '0') {
                            $(target).combobox('resize', width);
                        }
                    }
                },
                EasyuiCombobox: {
                    init: function(container, options){
						var combo = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
						combo.combobox(options || {textField: options.textFiled});
                        combo.combobox("showPanel");
						return combo;
                    },
                    destroy: function(target){
						$(target).combobox('destroy');
                    },
                    getValue: function(target){
						return $(target).combobox('getValue');
                    },
                    setValue: function(target, value){
						var opts = $(target).combobox('options');
						$(target).combobox('setValue', value);
                    },
                    resize: function(target, width){
						$(target).combobox('resize', width);

                    }
                }
            });


            //------加载用户头像和页签
    		$("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId=${userId}");
        
			$("#uploadForm").submit(function(){
                var uploadUserPhono = {
                    type: 'POST',
                    dataType: 'json',
                    success:function(r){
                        $("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random());
                        $(parent.document.body).find(".userhead").attr("style","background-image:url('platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random()+"')");
					},
                    error : function(xhr, status, err) {
                    	$("#sysUserHeadPhotoImg").attr("src","platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random());
                        $(parent.document.body).find(".userhead").attr("style","background-image:url('platform/console/userupload/headerphoto?sysUserId="+'${userId}'+"&o=" + Math.random()+"')");
                	}
            };
				$(this).ajaxSubmit(uploadUserPhono);
				return false;
			});


            //保存按钮绑定事件
            $('#consoleUser_saveForm').off('click').on('click', function(){
                saveForm($('#form'));
            });
            //返回按钮绑定事件
            $('#consoleUser_closeForm').off('click').on('click', function(){
                closeForm();
            });
            //修改密码保存事件
            $('#close').off('click').on('click', function(){
                closeForm();
            });


            initDataGrid("personGroupJqGrid");
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


            initDataGrid("approvalOptionJqGrid");
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
				debugger;
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

    //回填数据选人
    function callBackUser(obj,rowIndex){
        var editorUserAlias = $('#personGroupJqGrid').datagrid('getEditor', {
            index : rowIndex,
            field : "sysUserIdAlias"
        });
        $(editorUserAlias.target).combobox('setValue', obj.usernames);
        var editorUserid = $('#personGroupJqGrid').datagrid('getEditor', {
            index : rowIndex,
            field : "sysUserId"
        });
        $(editorUserid.target).val(obj.userids);
    }

    function formatterProcessType(value,row){
        if(value == "0"){
            return "自定义";
        }else if(value == "1") {
            return "全部";
        }
	}
	
	function afterEdit(rowIndex, rowData, changes) {
	    var cellName;
        for(var i in changes){
            cellName = i;
        }
        if(cellName == "processType" ) {
            if (changes[cellName] == "1") {
                rowData["hiddenProcessIds"] = rowData["processIds"];
                rowData["hiddenProcessIdsAlias"] = rowData["processIdsAlias"];
                rowData["processIds"] = "";
                rowData["processIdsAlias"] = "";
                rowData["processName"] = "";
            } else {
                rowData["processIds"] = rowData["hiddenProcessIds"];
                rowData["processIdsAlias"] = rowData["hiddenProcessIdsAlias"];
                rowData["processName"] = rowData["hiddenProcessIdsAlias"];
            }
        }
        if(cellName == "processIdsAlias" ) {
            if (changes[cellName]) {
                rowData["processName"] = rowData["processIdsAlias"];
            }
        }
        $('#approvalOptionJqGrid').datagrid('updateRow',{
            index: rowIndex,
            row: rowData
        });
    }

	</script>
</body>
</html>