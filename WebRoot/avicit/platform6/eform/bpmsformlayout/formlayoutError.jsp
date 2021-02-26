<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>


<style type="text/css">
*{margin:0px;}
html,body{height:100%;
background-color:#ffffff;}
.error_dw {
	background-image: url(login/style/image/500/error_dw.jpg);
	background-repeat: repeat-x;
}
.error_title {
	font-family: "黑体";
	font-size: 32px;
	text-decoration: none;
	line-height: 46px;
	color: #666666;
}
.error_txt {
	font-family: "宋体";
	font-size: 12px;
	text-decoration: none;
	line-height: 28px;
	color: #333333;
}

#error a:link {
	font-family: "宋体";
	font-size: 12px;
	color: #C70600;
	text-decoration: none;
	line-height: 18px;
}


#error a:hover {
	font-family: "宋体";
	font-size: 12px;
	color: #307EAF;
	text-decoration: underline;
	line-height: 18px;
}
#error a:visited {
	font-family: "宋体";
	font-size: 12px;
	color: #C70600;
	text-decoration: none;
	line-height: 18px;
}
</style>


<body class="easyui-layout"  fit="true">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="error_dw">
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150" align="left" valign="top"><img src="login/style/image/500/error_ico01.gif" width="127" height="133" /></td>
            <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div align="center" class="error_title"></div></td>
                <td><div align="center"><span class="error_title">表不存在</span></div></td>
              </tr>
              <tr>
                <td width="25"><div align="center"><img src="login/style/image/500/error_ico02.gif" width="18" height="15" vspace="3" /></div></td>
                <td align="left" valign="top" class="error_txt"><h3>对不起，${tableName}表没有被创建，不能使用!</h3></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>


</body>
</html>