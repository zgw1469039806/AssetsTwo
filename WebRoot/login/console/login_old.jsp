<!DOCTYPE html>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.verifycode.VerifyCodeUtil"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<html>
<head>
    <%
	String host = request.getContextPath();
	
	//首次登录的问题
	Object _m=session.getAttribute("_&_");
	session.removeAttribute("_&_");
	String _title= (String) session.getAttribute("exception_msg_");
	String userId = (String)session.getAttribute("_&_U");
	/* 判断是否存在登录失败的情况 */
	String exception_msg_ = _title;
	//移除登录信息
	session.removeAttribute("exception_msg_");
	boolean isShow = VerifyCodeUtil.isShow(SessionHelper.getClientIp(request));
	String importlibs = "common,table,form";	
	
%>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit|ie-stand">
<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"
	type="image/x-icon">
<meta charset="utf-8" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="description" content="">
<meta name="keywords" content="登录">
<link rel="stylesheet" type="text/css"
	href="login/console/css/login.css">
<link rel="stylesheet" type="text/css"
	href="login/console/css/reset.css">
<title>欢迎使用-业务基础平台-控制台</title>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/base64/aes.js"></script>
<script type="text/javascript">
	 $(function(){
		  var loginFlag = "<%=_m%>";
		  var userid ='<%=userId%>';
		  if(loginFlag == "1" || loginFlag == "2" || loginFlag == "3"){
			 modifyIndex = layer.open({
	    			type: 2,
	   				area: ['45%', '50%'],
	    			title: '提示',
	    			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        			maxmin: false, //开启最大化最小化按钮
	    			content: '<%=ViewUtil.getRequestPath(request)%>'+'avicit/platform6/console/user/modifyUserPasswordbyadmin.jsp?userId='+ userid + '&loginFlag=' + loginFlag
				});  
		}
	});
	 function closeModiyPassworDilog(){
			layer.close(modifyIndex);
		}
</script>
</head>

<body>
	<div class="login_Box">
		<div class="Login_Top">
			<div class="Login_Top_Logo">
				<img src="login/console/img/logo.png" />
				<h1>业务基础平台</h1>
			</div>
		</div>
		<div class="Login_Con">
			<form action="<%=ViewUtil.getRequestPath(request)%>admin/login" onsubmit="return check();"
				method="post" style="height: 278px">
				<div class="Login_Con_Urse">
					<i class="icon icon-urse tb" style="display: none;"></i> <input
						type="text" id="username_" name="username_"
						focucmsg="<%=PlatformLocalesJSTL.getBundleValue("login.username.tip.loginname")%>" tabindex="1"
						value="">
				</div>
				<div class="Login_Con_Password">
					<i class="icon icon-password tb" style="display: none;"></i> <input
						type="text" autocomplete="off" class="userinput" id="showPwd"
						focucmsg="<%=PlatformLocalesJSTL.getBundleValue("login.password.tip.name")%>"
						value="" tabindex="2"> <input autocomplete="off" style="display: none;"
						id="password" size="20" tabindex="2" type="password">
				</div>
				<%if(isShow){ %>
				<div class="Login_Con_Urse">
					<i class="icon icon-shouwenguanli tb" style="display: none;"></i> <input type="text" name="inputCode" id="inputCode_" style="width:100px;" focucmsg="验证码" tabindex="3"/><img src="<%=ViewUtil.getRequestPath(request)%>platform/verifyCode/show" align="middle" title="看不清，请点我" onclick="refresh(this);" onmouseover="mouseover(this)" style="padding-left:20px;padding-top:2px;"/>
				</div>
				<%} %>


				<!-- <div class="Login_Con_Checkbox">
					<input type="checkbox" />记住密码</div> -->
				<div id="errorMsg" class="forgetPwdLine">
					<%
							if (exception_msg_ != null && exception_msg_ != "") {
								out.println("<font id='msgContent' color=\"red\">"+ PlatformLocalesJSTL.getBundleValue("login.error.info")+":" + exception_msg_
										+ "</font>");
							}
						%>
				</div>
				<div class="Login_Con_Button">
					<button>登录</button>
				</div>

			</form>
		</div>
	</div>



	<script type="text/javascript">
	var path = "<%=ViewUtil.getRequestPath(request)%>";
	 
	function refresh(obj){
		obj.src = path+"platform/verifyCode/show?" + Math.random();
	}
	function mouseover(obj){
		obj.style.cursor = "pointer";
	}
	  
	  function closeSubFrame() {
		  $('#modify_dialog').dialog('close');
	  }
	  
		var check=function(){
		    var userName=$("#username_").val();
            if(!userName || userName==='登录名'){
                if($('#msgContent').length===0) {
                    $('<span id="msgContent" style="color: Red;">'+'用户名不能为空!'+'</span>').appendTo($('#errorMsg'));
                }

                return false;
            }
            var password=$("#password").val();
            if(!password || password==='密码'){
                if($('#msgContent').length===0) {
                    $('<span id="msgContent" style="color: Red;">' + '密码不能为空!' + '</span>').appendTo($('#errorMsg'));
                }
                return false;
            }
            <%if(isShow){ %>
            var inputCode=$("#inputCode_").val();
            if(!inputCode || inputCode==='验证码'){
                if($('#msgContent').length===0) {
                    $('<span id="msgContent" style="color: Red;">'+'验证码不能为空!'+'</span>').appendTo($('#errorMsg'));
                }

                return false;
            }
            <%} %>

			$("#password").val(encrypt(password));
            return true;

        };
		$(function(){
		<!-- 修正ie8下图标偶尔丢失问题 -->
			$('.icon').show();

			$("#username_").each(function() {
				var user = '';
				if (user != '') {
					$(this).val(user);
					user = '';
				} else {
					$(this).val($(this).attr("focucmsg")).blur();
					$(this).val($(this).attr("focucmsg")).css("color", "#979393");
				}
				$(this).focus(function() {
				    $('#msgContent').remove();
					if ($(this).val() == $(this).attr("focucmsg")) {
						$(this).val('');
						$(this).val('').css("color","#FFFFFF");
					}
				});
				$(this).blur(function() {
					if (!$(this).val()) {
						$(this).val($(this).attr("focucmsg"));
						$(this).val($(this).attr("focucmsg")).css("color","#979393");
					}});
			});
			
			$("#showPwd").each(function() {
				$(this).val($(this).attr("focucmsg")).blur();
				$(this).val($(this).attr("focucmsg")).css("color", "#979393");

				$(this).focus(function() {
        	        $('#msgContent').remove();
						if ($(this).val() == $(this).attr("focucmsg")) {
							 $("#showPwd").hide();
							 $("#password").show().focus();
						}
				});
				 $("#password").blur(function() {
					if ($(this).val() == '') {
						$("#showPwd").show();
						$("#password").hide();
					}});
			});
			
			$("#inputCode_").each(function() {
				$(this).val($(this).attr("focucmsg")).blur();
				$(this).val($(this).attr("focucmsg")).css("color", "#979393");
				$(this).focus(function() {
				    $('#msgContent').remove();
					if ($(this).val() == $(this).attr("focucmsg")) {
						$(this).val('');
						$(this).val('').css("color","#FFFFFF");
					}
				});
				$(this).blur(function() {
					if (!$(this).val()) {
						$(this).val($(this).attr("focucmsg"));
						$(this).val($(this).attr("focucmsg")).css("color","#979393");
					}});
			});

			$("#password").attr("name", "password_");
			$("#showPwd").attr("name", "Password1");
		})

	function encrypt(data) {
		var _0  = CryptoJS.enc.Utf8.parse('dufy20170329java');
		var encryptedData =  CryptoJS.AES.encrypt(data, _0, {mode:CryptoJS.mode.ECB,padding:CryptoJS.pad.Pkcs7}).toString();
		return encryptedData;
	}
	</script>
</body>
</html>
