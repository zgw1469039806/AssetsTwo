
var dialog_first_row_tip = "提示：您为"; 
var dialog_second_row_tip = "密码要求：您的密码"; 
var dialog_third_row_tip = "最大长度不要超过"; 
var dialog_fourth_row_tip = "最小长度不能小于";
var dialog_five_row_tip = "其中大写字母、小写字母、数字、特殊字符至少要包含";
var dialog_five_row_end_tip = "位"; 
var dialog_six_row_begin_tip = "不能和前";
var dialog_six_row_end_tip = "次密码重复";
var dialog_seven_row_begin_tip = "不能和旧密码有";
var dialog_seven_row_end_tip = "位（连续）重复";
var dialog_eight_row_begin_tip = "请在";
var dialog_eight_row_middle_tip = "天"; 
var dialog_eight_row_end_tip = "前修改密码";

var password_length_tip = "位";


var modifyIndex;




var shangeSelfPasswordVo;
$(function(){

	$('#passwordEditForm input').bind('keyup',function(e){
		if(e.keyCode == 13){
			e.preventDefault();
			changePassword();
		}
	});
	$.ajax({
		url : 'platform/console/user/'+uid+'/getChangeSelfPasswordVo',
		type : 'post',
		success : function(r) {
			if(r){
				shangeSelfPasswordVo=r;
				//generateTipContent();
			}
		},
		error :function(request){
			alert('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
		}
	}); 
	
}); 

function generateTipContent(){
	var tipContent = $("#tipContent");

	var maxlength = shangeSelfPasswordVo.maxlength;
	var intensity = shangeSelfPasswordVo.intensity;
	var distinctBefore = shangeSelfPasswordVo.distinctBefore;
	var minlength = shangeSelfPasswordVo.minlength;
	var difference = shangeSelfPasswordVo.difference;
	var oldPassword = shangeSelfPasswordVo.oldPassword;
	var secretLevelName = shangeSelfPasswordVo.secretLevelName;
	helpMessage = dialog_first_row_tip+"<font color='red'>"+secretLevelName+"</font><br/>";
	helpMessage=helpMessage+"　　　"+dialog_second_row_tip+"<br/>";
	if(maxlength){
		helpMessage+="　　　"+dialog_third_row_tip+" <font color='red'>"+maxlength+"</font> "+password_length_tip+"<br/>";
	}
	if(minlength){
		helpMessage+="　　　"+dialog_fourth_row_tip+" <font color='red'>"+minlength+"</font> "+password_length_tip+"<br/>";
	}
	if(intensity){
		helpMessage+="　　　"+dialog_five_row_tip+" <font color='red'>"+intensity+"</font> "+dialog_five_row_end_tip+"<br/>	";
	}
	if(distinctBefore){
		helpMessage+="　　　"+dialog_six_row_begin_tip+" <font color='red'>"+distinctBefore+"</font> "+dialog_six_row_end_tip+"<br/>";
	}
	if(difference){
		helpMessage+="　　　"+dialog_seven_row_begin_tip+" <font color='red'>"+difference+"</font> "+dialog_seven_row_end_tip+"<br/>";
	}
	if(maxlength||intensity||minlength||distinctBefore||difference){
	
	}else{
	helpMessage = "提示：您为<font color='red'>非涉密人员</font><br/>　　　密码要求：无<br/>";//"密码要求：无"+"<br/>";
	}
	var noticeDateBeforeNum = null;
	if (shangeSelfPasswordVo.howLongModify &&shangeSelfPasswordVo.howLongModify>0) {
		noticeDateBeforeNum = shangeSelfPasswordVo.howLongModify; 
	} 
	if (null != noticeDateBeforeNum) {
		var dateStr = shangeSelfPasswordVo.sysPsw;
		helpMessage+="　　　"+dialog_eight_row_begin_tip+" <font color='red'>"+dateStr+"</font>"+dialog_eight_row_end_tip+"<br/>";
	}
	helpMessage =helpMessage.substring(0,helpMessage.length-1);
	helpMessage+=".";
	tipContent.html(helpMessage);
	tipContent.css("margin-top:120px;width: 400px; overflow-x: hidden; overflow-y: auto; position: relative; left: 0px; bottom: 0px;");
	tipContent.attr("visible",true);
}
function add0(m){
	return m<10?'0'+m:m ;
}
function closeParentDialog(state){
	if(state == '1'){
		alert("密码修改成功，请用新密码重新登录！");
		parent.$("#modifypsw").dialog('close');
	}else{
		parent.$("#modifypsw").dialog('close');
	}
}
function hasText(str,trim){
	var tmp = str;
	if(null == tmp){
		return false;
	}
	if(trim){
		tmp = tmp.replace(/\s*/g,"");
	}
	if(0 == str.length){
		return false;
	}
	return true;
}
function mate(password)
{
	var digit=0;
	var smallChar=0;
	var bigChar=0;
	var other=0;
	
	for(var i=0;i<password.length;i++)
	{
		var c=password.charAt(i);
		
		if(c<='9' && c>='0')
			digit=1;
		else if(c<='z' && c>='a')
			smallChar=1;
		else if(c<='Z' && c>='A')
			bigChar=1;
		else
			other=1;
	}
	
	return digit+smallChar+bigChar+other;

}
function changePasswordbyadmin(parentWindow,isAdmin){
	
	var maxlength = shangeSelfPasswordVo.maxlength;
	var intensity = shangeSelfPasswordVo.intensity;
	var distinctBefore = shangeSelfPasswordVo.distinctBefore;
	var minlength = shangeSelfPasswordVo.minlength;
	var difference = shangeSelfPasswordVo.difference;
	var secretLevelName = shangeSelfPasswordVo.secretLevelName;
	
	var newPassword = $("#password").val();
	var oldPassword = $("#oldpassword").val();
	var confirmPassword = $("#confirm_password").val();
    //用户修改初始密码时，原密码不能为空
    if(!isAdmin){
        if(!hasText(oldPassword)){
            layer.msg("原密码不能为空");
            return;
        }
    }

	/*if(!hasText(oldPassword)){
		layer.msg("旧密码不能为空");
		return;
	}*/
	
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
	}
	$('#confirmBtn').attr("disabled","disabled");
    //如果是管理员，不需要用户原始密码即可修改，非管理原必须要原始密码
    if(isAdmin) {
        $.ajax({
            url: 'platform/console/user/' + uid + '/changePasswordbyadmin',
            data: {newPassword: newPassword},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.s) {
                    layer.alert(r.s, {
                            icon: 6,
                            title: '提示',
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }, function () {
                            if (loginFlag == '1' || loginFlag == '2' || loginFlag == '3') {
                                parent.window.location = baseUrl + 'login/console/logout_forCas.jsp';
                            } else {
                                parentWindow.closeModiyPassworDilog();
                            }
                        }
                    );
                } else {
                    layer.alert(r.f, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0
                        }
                    );
                    layer.close(modifyIndex);
                }

            }
        });
    }else{
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
                            if(loginFlag == '1' || loginFlag == '2' || loginFlag == '3') {
                                parent.window.location = baseUrl+'login/console/logout_forCas.jsp';
                            } else {
                                userframe.closeModiyPassworDilog();
                            }
                        }

                    );
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
    }

}


