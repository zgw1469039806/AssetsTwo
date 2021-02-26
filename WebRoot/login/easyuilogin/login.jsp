<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<%@page import="avicit.platform6.commons.utils.AESUtils"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	
%>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit|ie-stand">
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
    <meta charset="utf-8" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
    <meta name="description" content="">
    <meta name="keywords" content="登录">
    <link rel="stylesheet" type="text/css" href="login/easyuilogin/css/login.css">
    <link rel="stylesheet" type="text/css" href="login/easyuilogin/css/reset.css">
    <title>欢迎使用-业务基础平台-控制台</title>
</head>

<body>
	<div class="login_Box">
		<div class="Login_Top">
			<div class="Login_Top_Logo">
				<div class="logoPng"></div>
				<h1>业务基础平台</h1>
			</div>
		</div>
		<div class="Login_Con">
			<form action="${baseurl}/admin/login" onsubmit="return check();"
				method="post" style="height: 278px">
				<div class="Login_Con_Urse">
					<i class="icon-user-pic tb"></i> <input
						type="text" id="username_" name="username_" focucmsg="请输入用户名" tabindex="1"
						value="">
				</div>
				<div class="Login_Con_Password">
					<i class="icon-pwd-pic tb"></i> <input
						type="text" autocomplete="off" class="userinput" id="showPwd"
						focucmsg="请输入密码" value="" tabindex="2"> <input autocomplete="off" style="display: none;"
						id="password" size="20" tabindex="2" type="password">
				</div>

               	<div id="errorMsg" class="forgetPwdLine">
					<%
							if (exception_msg_ != null && exception_msg_ != "") {
								out.println("<font id='msgContent' color=\"red\">"+ PlatformLocalesJSTL.getBundleValue("login.error.info")+":" + exception_msg_
										+ "</font>");
							}
						%>
				</div>
				<div class="Login_Con_Button">
					<button type="submit">登录</button>
				</div>

			</form>
		</div>
	</div>
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/base64/aes.js"></script>
    <!--[if IE 6]>
		<script src="avicit/platform6/login/js/jquery.pngFix.pack.js"></script>
	<![endif]-->

	<script>
		var firstLoginFalg = 0; // 首次登陆标记
		var path = ""; // api地址
		var userid = 1111;  // 用户id
		var modifyUserPwd =  path+'';
		var isShow = 0;
		var errmsg = '';
		function closeModiyPassworDilog(){
			layer.close(modifyIndex);
		}
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
            if(isShow){
            	var inputCode=$("#inputCode_").val();
				if(!inputCode || inputCode==='验证码'){
				    if($('#msgContent').length===0) {
				        $('<span id="msgContent" style="color: Red;">'+'验证码不能为空!'+'</span>').appendTo($('#errorMsg'));
				    }
				    return false;
				}
            }


            $("#password").val(encrypt(password));
            return true;

        };
		$(function(){
			if(firstLoginFalg && firstLoginFalg ==1){
				modifyIndex = layer.open({
					type: 2,
					area: ['45%', '40%'],
					title: '初始密码拒绝登录请修改密码！',
					skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
					maxmin: false, //开启最大化最小化按钮
					content: modifyUserPwd
				});
			}
			if(errmsg){
				$('#msgContent').show().text(errmsg)
			}
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
		});

        function encrypt(data) {
            var _0  = CryptoJS.enc.Utf8.parse('dufy20170329java');
            var encryptedData =  CryptoJS.AES.encrypt(data, _0, {mode:CryptoJS.mode.ECB,padding:CryptoJS.pad.Pkcs7}).toString();
            return encryptedData;
        }

    </script>
</body>

</html>