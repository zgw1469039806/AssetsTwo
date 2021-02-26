<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	


String userId = (String)request.getParameter("userId");
String modifyIndex = (String)request.getParameter("modifyIndex");



%>
<!DOCTYPE html>
<HTML>
<head>
<title>修改密码</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>


<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
	

	<script type="text/javascript">
			
	var uid='<%=userId%>';
	//var modifyIndex='<%=modifyIndex%>';
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<table class="form_commonTable">
				
				<tr>
					<th width="5%" style="word-break: break-all; word-warp: break-word;"><label for="oldpassword">旧密码:</label></th>
					<td width="39%"><input title="新密码" class="form-control input-sm" type="password" name="oldpassword" id="oldpassword" /></td>
				</tr>
				
				<tr>
					<th width="5%" style="word-break: break-all; word-warp: break-word;"><label for="password">新密码:</label></th>
					<td width="39%"><input title="新密码" class="form-control input-sm" type="password" name="password" id="password" /></td>
				</tr>
				<tr>
					<th width="5%" style="word-break: break-all; word-warp: break-word;"><label for="confirm_password">确认密码:</label></th>
					<td width="39%"><input title="确认密码" class="form-control input-sm" type="password" name="confirm_password" id="confirm_password" /></td>
					
				</tr>
				
				
			</table>
			
			
			
		</form>
		<div data-options="region:'south',border:false" style="height: 80px;">
			<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-top:6%;" align="center">
						<a href="javascript:void(0)" style="margin-right:20px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="consoleUser_saveForm">保存</a>
						<a href="javascript:void(0)" style="margin-right:20px;" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="consoleUser_closeForm">返回</a>
					</td>
				</tr>
			</table>
			</div>
	</div>
	</div>
	
	
	
	
	
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="avicit/platform6/console/user/js/modifyPassword.js"></script>

	<script type="text/javascript">
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
		layer.msg("旧密码不能为空");
		return;
	}
	
	if(!hasText(newPassword)){
		layer.msg("新密码不能为空");
		return;
	}
	if(!hasText(confirmPassword)){
		layer.msg("确认密码不能为空");
		return;
	}
	if(confirmPassword != newPassword){
		layer.msg("确认密码和新密码不一致");
		return;
	}

	var level = 0;
	if(minlength){
		if(newPassword.length < minlength){
		  layer.alert("新密码的长度不能小于"+minlength+"位",{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
		  return false;
	    }
	}else{
	}
	if(maxlength){
		if(newPassword.length > maxlength&&newPassword.length<=100){
		    layer.alert("新密码的长度不能大于"+maxlength+"位",{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
		   return false;
	    }
	}else{
	}

	level= mate(newPassword);
	if(intensity!="" && intensity !=null && level<intensity){
		   layer.alert("新密码应同时包含以下四类字符中的"+intensity+"类--（数字，小写字母，大写字母，特殊字符<包含标点符号>）",{
					  		icon: 7,
					  		titile:'提示',
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
		 return false;
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
			layer.alert(r.s,{
					  		icon: 6,
					  		title:'提示',
					  		area: ['400px', ''], //宽高
					  		closeBtn: 10
				    },function(){
				    	parent.closeModiyPassworDilog();
				    }
				    
		         );
			//parent.closeModiyPassworDilog();
			}else{
				layer.alert(r.f,{
					  		icon: 7,
					  		area: ['400px', ''], //宽高
					  		closeBtn: 0
				    }
		         );
				layer.close(modifyIndex);
			}
			
		}
	});      
	 
};
	$(function(){     
	
		
		
			$('#consoleUser_saveForm').bind('click', function(){
				changePassword();
			}); 
			//返回按钮绑定事件
			$('#consoleUser_closeForm').bind('click', function(){
				parent.closeModiyPassworDilog();
			});
	
		});
		
	
			
	
	</script>
</body>
</html>