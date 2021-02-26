<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<% 
Object lang=session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_LANGUAGE_CODE);
String languageCode="zh_CN";
if(lang!=null){
	languageCode=lang.toString();
}
	List<String> list = new ArrayList<String>();
	list.add("azure");
	list.add("black");
	list.add("blue");
	list.add("blue_oa");
	list.add("bootstrap");
	list.add("bpmtoolbar");
	list.add("cyan");
	list.add("default");
	list.add("gray");
	list.add("green");
	list.add("icons");
	list.add("metro");
	list.add("orange");
	list.add("red");
	//modify by xingc
	String skinColor = (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
	if(skinColor == null || !list.contains(skinColor)){
		skinColor="blue";
	}
%>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/<%=skinColor%>/easyui.css" type="text/css" rel="stylesheet">
<link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/<%=skinColor%>/avicit-easyui-extend-1.3.5.css" type="text/css" rel="stylesheet">
<link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/<%=skinColor%>/icon.css" rel="stylesheet" type="text/css">
<link href="static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/<%=skinColor%>/page.css"  type="text/css"  rel="stylesheet">
<!--[if IE 6]>	
<script type="text/javascript"> 
	try { document.execCommand('BackgroundImageCache', false, true); } catch(e) {} 
</script>
<![endif]-->
<script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
<script src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/jquery.easyui.min.js" type="text/javascript"></script>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/datagrid-scrollview.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/locale/easyui-lang-<%=languageCode %>.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/pageUtil.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/Tools.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/platform6-fn-6.3.1.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/CommonDialog.js" type="text/javascript"></script>
<script src="static/js/platform/component/dialog/UserSelectDialog.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/wz_jsgraphics.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/ToolBar.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/ButtonProcessing.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/Button.js" type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/Idea.js" type="text/javascript"></script>

