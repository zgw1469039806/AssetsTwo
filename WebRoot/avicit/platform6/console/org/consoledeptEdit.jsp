<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";	
%>  
<!DOCTYPE html>
<HTML>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value='<c:out  value='${consoleDept.version}'/>' /> 
			<input type="hidden" name="id" value='<c:out  value='${consoleDept.id}'/>'/>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptCode">部门编码:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="deptCode" id="deptCode" value='<c:out  value='${consoleDept.deptCode}'/>' />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptName">部门名称:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="deptName" id="deptName" value='<c:out  value='${consoleDept.deptName}'/>' />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="orderBy">排序编号:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="orderBy" id="orderBy" value='<c:out  value='${consoleDept.orderBy}'/>' />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="parentDeptName">上级部门:</label></th>
					<%--<td width="39%">
						<input class="form-control input-sm" type="text" name="parentDeptName" id="parentDeptName" disabled="disabled" value='<c:out  value='${consoleDept.parentDeptName}'/>' />
					</td>--%>
                    <td width="39%" >
                        <div class="input-group input-group-sm">
                            <input type="hidden" id="parentDeptId" name="parentDeptId" value='<c:out value='${consoleDept.parentDeptId}'/>'>
                            <input class="form-control" placeholder="请选择部门" disabled="disabled" type="text" id="parentDeptName" name="parentDeptName" value='<c:out value='${consoleDept.parentDeptName}'/>'>
                            <span class="input-group-btn">
							    <button class="btn btn-default" type="button" id="deptbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							</span>
                        </div>

						<%--<input type="hidden" id="parentDeptId" name="parentDeptId" value='<c:out value='${consoleDept.parentDeptId}'/>'>
						<input class="form-control" placeholder="请选择部门" disabled="disabled" type="text" id="parentDeptName" name="parentDeptName" value='<c:out value='${consoleDept.parentDeptName}'/>'>
					--%>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptPinYin">全拼/简拼:</label></th>
					<td width="39%">
		                <input disabled="disabled" class="form-control input-sm" type="text" name="deptPinYin" id="deptPinYin" value='<c:out  value='${consoleDept.deptPinYin}'/>' />
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptAlias">部门别名:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="deptAlias" id="deptAlias" value='<c:out  value='${consoleDept.deptAlias}'/>' />
					</td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="tel">电话:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="tel" id="tel" value='<c:out  value='${consoleDept.tel}'/>' />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="fax">传真:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="fax" id="fax" value='<c:out  value='${consoleDept.fax}'/>' />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="email">邮箱:</label></th>
					<td width="39%">
		                <input class="form-control input-sm" type="text" name="email" id="email" value='<c:out  value='${consoleDept.email}'/>' />
					</td>
					
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptPlace">办公地点:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="deptPlace" id="deptPlace" value='<c:out  value='${consoleDept.deptPlace}'/>'/>
					</td>
				</tr>
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="post">邮编:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="post" id="post" value='<c:out  value='${consoleDept.post}'/>' />
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="validFlag">是否有效:</label></th>
					<td width="39%">
						<pt6:h5radio css_class="radio-inline"  name="validFlag" title="" canUse="0" lookupCode="PLATFORM_VALID_FLAG" defaultValue='${consoleDept.validFlag}'/>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptType">部门类型:</label></th>
					<td width="39%">
						<pt6:h5radio css_class="radio-inline"  name="deptType" title="" canUse="0" lookupCode="PLATFORM_DEPT_TYPE" defaultValue='${consoleDept.deptType}'/>
					</td>
				</tr>
				
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptDesc">描述:</label></th>
					<td width="39%" colspan="3"><textarea class="form-control input-sm" rows="3"  name="deptDesc" id="deptDesc" >${consoleDept.deptDesc}</textarea></td>
				</tr>
					
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="demoSingle_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="demoSingle_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		function closeForm(){
			parent.orgList.closeDialog("editDept");
        }
        function saveForm(){
		    if(($('#parentDeptName').val() == "请选择部门" || $('#parentDeptName').val() == "" || $('#parentDeptName').val() == null || $('#parentDeptName').val() == undefined) ){
		        layer.msg("请填写上级部门");
		        return false;
			}
		    $('#demoSingle_saveForm').addClass("disabled");
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
				$('#demoSingle_saveForm').removeClass("disabled");
	            isValidate.showErrors();
	            return false;
	        }

			  parent.orgList.savedept($('#form'),"editDept");
        }
        $('#deptbtn').on('click',function(){
            new H5CommonSelect({type:'deptSelect', idFiled:'parentDeptId',viewScope:'currentOrg',textFiled:'parentDeptName'});
        });

		$(function(){

					//检测手机号是否正确  
		jQuery.validator.addMethod("isMobile", function(value, element) {  
    		var length = value.length;  
    		var regPhone = /^0?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;  
   			 return this.optional(element) || ( length == 11 && regPhone.test( value ) );    
		}, "请正确填写您的手机号码");  

			//检测手机号是否正确  
		jQuery.validator.addMethod("isFax", function(value, element) {  
    		var length = value.length;  
    		var regPhone  = /^0\d{2,3}-?\d{7,8}$/; 
   			 return this.optional(element) || (regPhone.test( value ) );    
		}, "请正确填写您的传真号");
		//检测邮政编码  
		jQuery.validator.addMethod("isZipCode", function(value, element) {    
    		var tel = /^[0-9]{6}$/;
   			 return this.optional(element) || (tel.test(value));  
		}, "请正确填写您的邮政编码");  
			
			parent.orgList.formValidatedept($('#form'));
			//保存按钮绑定事件
			$('#demoSingle_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#demoSingle_closeForm').bind('click', function(){
				closeForm();
			});
		});
	</script>
</body>
</html>