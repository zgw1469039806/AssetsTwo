<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<style type="text/css">
	.skins{
		width: 20px;
		height: 20px;
		float : left;
	}
	.content{
		text-align:center;
		margin-left: 5%;
	}
	.content tr{
		height: 40px;
	}
	.content .type label,.content .isDefault label{
		cursor: pointer;
		font-weight:normal;
	}
	.content textarea{
		width: 97%;
	}
</style>
</head>
<body>
<div class="easyui-layout" fit="true">
	<div id="edit_content">
	   <form id="form">
		<div class="content">
			<br/>
			<table width="90%" border="0">
			  <tr>
			    <td align="right"><label><font color="red">*</font>名称：</label></td>
			    <td style="width:39%;" align="left"><input type="text" id="portletName" name="portletName"  class="form-control input-sm" value="${portletName}"></td>
			    <td align="right"><label><font color="red">*</font>编码：</label></td>
			    <td style="width:39%;" align="left"><input type="text" id="portletCode" name="portletCode" class="form-control input-sm" value="${portletCode}"></td>
			  </tr>
			  <tr>
			    <td width="12%" align="right"><label><font color="red">*</font>应用范围：</label></td>
			    <td  align="left" class="type">
			    	<label><input type="radio" name="resourceType" value="0">系统默认</label>
			    	<label><input type="radio" name="resourceType" value="1">角色定义</label>
			    	<label><input type="radio" name="resourceType" value="2">用户自定义</label>
			    </td>
			    <td width="12%" align="right"><label>是否默认：</label></td>
			    <td  align="left" class="isDefault">
			    	<label><input type="radio" name="isDefault" value="1">是</label>
			    	<label><input type="radio" name="isDefault" value="0">否</label>
			    </td>
			  </tr>
			  <tr id="role" style="display:;">
			    <td align="right"><label><font color="red">*</font>角色：</label></td>
			    <td colspan="3" align="left" >
			    	<div class="input-group  input-group-sm" style="width:100%;">
				   	  <input type="hidden"  id="ruleId" name="ruleId" value='${ruleId}'>
				      <input class="form-control" placeholder="请选择角色" readonly type="text" id="applyRoleidAlias" name="applyRoleidAlias" value='${roleName}' >
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button" id="rolebtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
				      </span>
			        </div>
			    </td>
			  </tr>
			  <tr id="user" style="display:none;">
			    <td  align="right"><label><font color="red">*</font>用户：</label></td>
			    <td colspan="3" align="left">
			    	<div class="input-group  input-group-sm" style="width:100%;">
				   	  <input type="hidden"  id="userId" name="userId" value='${userId}'>
				      <input class="form-control" placeholder="请选择用户" readonly type="text" id="applyUseridAlias" name="applyUseridAlias" value='${userName}' >
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button" id="userbtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
				      </span>
			        </div>
			    </td>
			  </tr>
			  <tr  id="orderSelector">
                    <td align="right"><label><font color="red">*</font>排序：</label></td>
                    <td style="width:39%;" align="left">
						<%--<input  id="orderBy" class="form-control input-sm" name="orderBy" value="${orderBy}">--%>
                         <div class="input-group input-group-sm spinner" data-trigger="spinner"  style="border: none;">
                             <input title="" type="text" class="form-control" name="orderBy" id="orderBy"  data-min="1" data-max="99999" value='${orderBy}' data-step="1" data-precision="0">
                             <span class="input-group-addon">
                           <a href="javascript:;" class="spin-up" data-spin="up"><i class="fa fa-caret-up"></i></a>
                           <a href="javascript:;" class="spin-down" data-spin="down"><i class="fa fa-caret-down"></i></a>
                        </span>
                         </div>
                     </td>
                </tr>
			  <tr>
			    <td align="right"><label>描述：</label></td>
			    <td colspan="3" align="left" height="90px"><textarea class="form-control" rows="4" id="memo" style="width:100%;">${memo}</textarea></td>
			   </tr>
			</table>
		</div>
	  </form>
	</div>
</div>
<input type="hidden" id="id" name="id" value="${id}">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 模块js -->
<script type="text/javascript">
var isAdmin ='${isAdmin}';
var viewScopeType='';
if(isAdmin=="true"){
	viewScopeType = 'currentOrg';
}else{
	viewScopeType = 'allowAcross';
}
var resourceType = "${resourceType}";
var isDefault = "${isDefault}";
$(document).ready(function(){
	$("input[name='resourceType']").bind('click', function() {
		if($(this).val() == 2){
			$('tr#user').show();
		} else {
			$('tr#user').hide();
		}
		if($(this).val() == 1){
			$('tr#role').show();
		} else {
			$('tr#role').hide();
		}
	});
	selectRole();
	selectUser();
	autoDisplayRoleSelectOrUserSelect();
	$("input[name='resourceType'][value='" + resourceType + "']").prop("checked", "checked");
	$("input[name='isDefault'][value='" + isDefault + "']").prop("checked", "checked");
});
function autoDisplayRoleSelectOrUserSelect(){
	  if(resourceType == 2){
			$('tr#user').show();
		} else {
			$('tr#user').hide();
		}
		if(resourceType == 1){
			$('tr#role').show();
		} else {
			$('tr#role').hide();
		}
}
function selectRole(){
	$('#rolebtn').on('click',function(){
    	new H5CommonSelect({type:'roleSelect', idFiled:'ruleId',viewScope:viewScopeType,textFiled:'applyRoleidAlias'});
//     	new H5CommonSelect({type:'roleSelect', idFiled:'ruleId',textFiled:'applyRoleidAlias',selectModel:'multi'});
	});
}

function selectUser(){
	$('#userbtn').on('click',function(){
    	new H5CommonSelect({type:'userSelect', idFiled:'userId',viewScope:viewScopeType,textFiled:'applyUseridAlias'});
//     	new H5CommonSelect({type:'userSelect', idFiled:'userId',textFiled:'applyUseridAlias',selectModel:'multi'});
	});
}
function getSaveData(){
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
}
</script>
<input type='hidden' id='appId' name='appId' value='${appId}' />
<input type='hidden' id='orgIdentity' name='orgIdentity' value='${orgIdentity}' />
</body>
</html>