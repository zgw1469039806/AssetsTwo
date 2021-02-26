<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>三员登录</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body>
	<form id="sanyuanlogin" name="sanyuanlogin" method="post" >
		
		<div class="formExtendBase" style="height: 350px;">
			
			<div class="formUnit column1">
				<label class="labelbg">系统管理员：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="text" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="systemlogin" id="systemlogin" style="width:80%"></input>
				</div>
			</div>
			<div class="formUnit column1">
				<label class="labelbg">密码：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="password" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="systempassword" id="systempassword" style="width:80%"></input>
				</div>
			</div>
			<div class="formUnit column1">
				<label class="labelbg">安全管理员：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="text" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="safemanager" id="safemanager" style="width:80%"></input>
				</div>
			</div>
			<div class="formUnit column1">
				<label class="labelbg">密码：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="password" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="safemanagerpassword" id="safemanagerpassword" style="width:80%"></input>
				</div>
			</div>
			<div class="formUnit column1">
				<label class="labelbg">安全审计员：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="text" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="safesheji" id="safesheji" style="width:80%"></input>
				</div>
			</div>
			
			<div class="formUnit column1">
				<label class="labelbg">密码：</label>
				<div class="inputContainer">
					<input class="easyui-validatebox" type="password" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;" data-options="required:true,validType:length[0,50]"  name="safeshejipassword" id="safeshejipassword" style="width:80%"></input>
				</div>
			</div>
			<div class="formUnit column1" style="height: 110px;">
				<label >原因：</label>
				<div class="inputContainer" >
					<textarea rows="6" cols="40" id="ofcause" onkeyup="if(event.keyCode==13){login();}else{return true;};return false;"></textarea>
				</div>
			</div>
			
		</div>
	</form>
	
	
	<div style="text-align: center">
		<div style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
			<button id="confirmBtn" onclick="login()">登录</button>
			<button id="confirmBtn2" onclick="closeDialog();">取消</button>
		</div>
	</div>
</body>
</html>







