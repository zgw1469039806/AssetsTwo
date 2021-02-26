<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>

</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
var path = "<%=ViewUtil.getRequestPath(request)%>";
var sourceURL ="<%=request.getSession().getAttribute("SANYUANLOGIN_REDIRECT")%>";


$(function () {
    layer.open({
        type:2,
        area:['580px','520px'],
        title:'提示',
        skin: 'bs-modal',
        maxmin: false,
        btn: ['登录', '取消'],
        content:path+'avicit/platform6/modules/system/sanyuancheck/sanyuanloginreal.jsp',
        success: function(layero, index) {
            layer.iframeAuto(index);
        },
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var systemlogin = iframeWin.$("#systemlogin").val();
            var systempassword = iframeWin.$("#systempassword").val();
            var safemanager = iframeWin.$("#safemanager").val();
            var safemanagerpassword = iframeWin.$("#safemanagerpassword").val();
            var safesheji = iframeWin.$("#safesheji").val();
            var safeshejipassword = iframeWin.$("#safeshejipassword").val();
            var ofcause = iframeWin.$("#ofcause").val();

            if(!hasText(systemlogin)){
                layer.alert("系统管理员不能为空", {icon: 0});
                return;
            }
            if(!hasText(systempassword)){
                layer.alert("系统管理员密码不能为空", {icon: 0});
                return;
            }
            if(!hasText(safemanager)){
                layer.alert("安全管理员不能为空", {icon: 0});
                return;
            }

            if(!hasText(safemanagerpassword)){
                layer.alert("系统管理员密码不能为空", {icon: 0});
                return;
            }
            if(!hasText(safesheji)){
                layer.alert("安全审计员不能为空", {icon: 0});
                return;
            }
            if(!hasText(safeshejipassword)){
                layer.alert("安全审计员密码不能为空", {icon: 0});
                return;
            }
            $.ajax({
                url : 'platform/sanyuan/login?path='+sourceURL,
                data : {
                    systemlogin: systemlogin,
                    systempassword: systempassword,
                    safemanager: safemanager,
                    safemanagerpassword: safemanagerpassword,
                    safesheji: safesheji,
                    safeshejipassword: safeshejipassword,
                    ofcause: ofcause
                },
                type : 'post',
                dataType : 'json',
                success : function(r) {
                    if(r.result==0)
                    {
                        layer.close(index);
                        if(sourceURL !=''){
                            location.href = path+'platform'+sourceURL;
                        }
                    }
                    else
                    {
                        layer.alert('登录失败: ' +r.data,{icon: 0});
                    }
                }
            })

            layer.close(index);
        },
        cancel: function(index, layero){
            layer.close(index);
        }
    })
})

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
</script>
</html>
