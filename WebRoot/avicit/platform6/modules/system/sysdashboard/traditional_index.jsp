<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="avicit.platform6.api.sysuser.SysDeptAPI"%>
<%@page import="avicit.platform6.api.sysuser.SysOrgAPI"%>
<%@page import="avicit.platform6.core.spring.CacheSpringFactory"%>
<%@page import="avicit.platform6.api.session.dto.SecurityUser"%>
<%@page import="avicit.platform6.api.session.dto.SecurityMenu"%>
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.sysprofile.SysProfileAPI"%>
<%@page import="avicit.platform6.api.sysmenu.impl.SysMenuAPImpl"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<%@page import="java.util.Locale"%>

<%
	Locale locale =SessionHelper.getLocaleByUser(request);
	String hm=PlatformLocalesJSTL.getBundleValue("portal.index.homePage",locale);
	SysMenuAPImpl sysMenuAPI = SpringFactory.getBean(SysMenuAPImpl.class);
	SysProfileAPI sysProfileAPI = SpringFactory.getBean(SysProfileAPI.class);
	SecurityUser user = SessionHelper.getSecurityUser(request);
	SysDeptAPI sysDeptAPI = CacheSpringFactory.getInstance().getBean(SysDeptAPI.class);
	
	SecurityMenu menu = new SecurityMenu();
	menu.setAdmin(Boolean.valueOf(session.getAttribute(AfterLoginSessionProcess.SESSION_IS_ADMIN).toString()));
	menu.reflashMenu(SessionHelper.getApplicationId(),session.getAttribute(AfterLoginSessionProcess.SESSION_PORTLET_MENU));
	
    String indexElement = sysMenuAPI.getTraditionalIndexElementVlign(SessionHelper.getCurrentUserLanguageCode(request), user, menu,SessionHelper.getApplicationId(),session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_ORG).toString());
	String messageURL = sysMenuAPI.getMessagerUrl();
	
	String messageCount = "";
 	String loginname =user.getUser().getName();
 	String currentDeptId = user.getUser().getAttribute05();
 	String deptName = sysDeptAPI.getSysDeptNameBySysDeptId(currentDeptId,SessionHelper.getSystemDefaultLanguageCode());
 	String orgName =CacheSpringFactory.getInstance().getBean(SysOrgAPI.class).getSysOrgNameBySysOrgId(session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_ORG).toString(), SessionHelper.getSystemDefaultLanguageCode());
 	String controlMessageDialog = sysProfileAPI.getProfileValueByCode("PLATFORM_V6_MESSAGE_DIALOG_SHOW"); //控制消息弹出窗口是否显示
	boolean isAdmin = true;
	String quickSearch = sysMenuAPI.getQuickSearch(locale);
	
	//add by xingc
	String skinColor = (String)request.getSession().getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
	String skinSwitch = (String)request.getSession(false).getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_SKIN_SWITCH);
	
	String showArrowFlag = sysProfileAPI.getProfileValueByCode("PLATFORM_V6_DISPLAY_SEARCH");
	if(showArrowFlag == null || "".equals(showArrowFlag)){
		showArrowFlag = "true";
	}
	//版权信息
	int copyrightHeight = 30;
	String copyright = sysProfileAPI.getProfileValueByCode("PLATFORM_V6_COPYRIGHT");
	if(copyright == null || "".equals(copyright)){
		copyright = "";
		copyrightHeight = 0;
	}
%>
<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=8">
<script type="text/javascript">
	var logoutTip = "<%=PlatformLocalesJSTL.getBundleValue("platform.dashboard.index.logout.tip",locale)%>";
	var onFocusTip = "<%=PlatformLocalesJSTL.getBundleValue("platform.search.onFocus.tip",locale)%>";
	var resetPorletTip = "<%=PlatformLocalesJSTL.getBundleValue("platform.portlet.reset.tip",locale)%>";
	var homePage = "<%=PlatformLocalesJSTL.getBundleValue("portal.index.homePage",locale)%>";
	var messageIntervalTime = "<%=sysProfileAPI.getProfileValueByCode("PLATFORM_V6_MESSAGE_REQUEST_INTERVAL")%>";
	if(typeof(messageIntervalTime)=='undefined' || messageIntervalTime == null || messageIntervalTime == "null"){
		messageIntervalTime = 10000;
	}
	//add by xingc
	var skinSwitch = "<%=skinSwitch %>";
</script>
<title><%=hm%></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="static/css/platform/themes/<%=skinColor %>/index/style/easyui.css" rel="stylesheet" id="skins" type="text/css" />
<link href="static/css/platform/themes/<%=skinColor %>/traditional_index/style/traditional_title.css" rel="stylesheet" type="text/css" />
<link href="static/css/platform/themes/<%=skinColor %>/sysmessage/style/messageDialogCss.css" rel="stylesheet" type="text/css" />
<link href="static/css/platform/public/skin/skin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/jQuery/jQuery-easydrag-1.5/jquery.hoverIntent.minified.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/jQuery/jQuery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.jquery.dcmegamenu.1.3.3.js"></script>
<script type="text/javascript" src="static/js/platform/component/common/Tools.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.dashboard.index.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.dashboard.index.classic.js"></script>
<script type="text/javascript" src="static/js/platform/sysmessage/js/messageDialog.js"></script>
<script type="text/javascript" src="static/js/platform/search/js/quickSearch.js"></script>
<script type="text/javascript" src="static/js/platform/component/common/CommonDialog.js"></script>


<script type="text/javascript">
var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
var messageCount = "<%=messageCount%>";
var controlMessageDialog ="<%=controlMessageDialog%>";

function loadMessageData(){
	if(controlMessageDialog!="" && controlMessageDialog == "true"){
		loadMessage(baseUrl,messageIntervalTime,false);
	}else{
		
	}
}
function openLayoutPage() {
	var dialogId = "layoutDialog";
	var usd = new CommonDialog(dialogId, "450", "450",
			baseUrl + 'avicit/platform6/modules/system/sysdashboard/indexPortletConfig.jsp?isgloable=false&dialogId='+dialogId, "设置页面布局", false, true, false);
	usd.show();
}
function openPortletAdd() {
	var dialogId = "portletAddDialog";
	var usd = new CommonDialog(dialogId, "450", "450",
			baseUrl + 'avicit/platform6/modules/system/sysdashboard/indexPortletAdd.jsp?isgloable=false&dialogId='+dialogId, "添加首页应用", false, true, false);
	usd.show();
}
function savePortlet(){
	var portlet = "";
	var iframeBody = $("#iframeBody")[0].contentWindow;
	var portletRow = iframeBody.$("#portalContent .ui-portlet");
	var layout = iframeBody.$("#layout").val();
	$.each(portletRow,function(k,v){
		 var indexs = iframeBody.getPortletInfo(v.id);
         $.each(indexs, function(k1, v1) {
        	 portlet = portlet + v.id+";"+k1+";"+v1.x+":"+v1.y+"@";
         });
	});

	if(portlet!=null&&portlet!=""){
		portlet = portlet.substring(0,portlet.length-1);
		$.ajax({ 
			url: baseUrl+'platform/IndexPortalController/saveIndexPortlet.json',
			async : false,
			type: "POST",
			data : 'isgloable=false&portlet=' + portlet+'&layout='+layout,
			success: function(){
				//获取当前操作的数据行记录
				$.messager.defaults = {ok:"确定"};
				$.messager.alert('提示','保存页面设置成功!','info',function(){
					hideDialog();
					window.location.reload();
					//refreshPortlet();	
				});
				//alert('保存页面设置成功!')
				//refreshPortlet();	
			},
			error : function(){
				//alert('portlet配置信息保存失败!');
			}
		});
	}

}

function displaySubMenu(li) {          
	var subMenu =  $(li).find('> ul');
	if(subMenu.css('display') == "none"){
		subMenu.css('display', 'block');
		//增加菜单自适应,不让菜单超过底边而被遮挡，或者超过右侧被遮挡。
		if(!$(li).hasClass("firstmenu")){
			subMenu.css('top', "");
			if((subMenu.offset().top + subMenu.outerHeight(true)) > winHeight){
				var newTop = winHeight - (subMenu.offset().top + subMenu.outerHeight(true));
				subMenu.css('top', newTop + "px");
			}
			subMenu.css('left', "");
			if((subMenu.offset().left + subMenu.outerWidth(true)) > winWidth){
				subMenu.css('left', "-" + subMenu.outerWidth(true) + "px");
			}
		}else{
			subMenu.css('left', "");
			if((subMenu.offset().left + subMenu.outerWidth(true)) > winWidth){
				var newLeft = winWidth - (subMenu.offset().left + subMenu.outerWidth(true));
				subMenu.css('left', newLeft + "px");
			}
		}
	}
}

function hideSubMenu(li){
	var subMenu =  $(li).find('> ul');
	if(subMenu.css('display') == "block"){
		subMenu.css('display', 'none');
	}
}

$(function(){
	setTimeout(function(){
		$("#copyFooter").children("span").show();
	},"1000");
});
</script>
</head>

<body class="easyui-layout"	onload="addTab('<%=hm%>','avicit/platform6/modules/system/sysdashboard/indexPortlet.jsp','static/images/platform/index/images/icons.gif','homePage','-0px -20px');loadMessageData();mainOfQuickSearch();">
	<div region="center" style="overflow: hidden;">
		<div id="divBodyWidth">
			<div id="header">
				<div class="logo">
					<ul class="info" style="*width:auto;">
						<li>
							<div class="user"></div> 
							<%=loginname%><a href="javascript:openDeptWin();" style="cursor:hand;">[<span id="currentDeptName"><%=orgName %>/<%= deptName %></span>]</a>
						</li>
						<li>
							<div class="msgbg">
								<a href="javascript:void(0);" style="cursor:pointer;" onclick="<%=messageURL%>"><%=messageCount%></a>
							</div> 
							<a href="javascript:void(0);" style="cursor:pointer;" onclick="<%=messageURL%>"><%=PlatformLocalesJSTL.getBundleValue("portal.index.message")%></a>
						</li>
						<li id="portalItems">
						</li>
						<li>
							<a href="javascript:void(0);" onclick="showVersion();return false;" ><img src='static/images/platform/index/images/version.png' border='0' width='12px' height='12px'></a>
							<div id="versionDialog" title="平台版本" style="background:#fff;padding:5px;width:400px;height:180px;display:none" >
						</li>
					</ul>
					<%=quickSearch%>
					<div id ="skinList"></div>
				</div>
			</div>
		</div>
		<div class="headtop" id="headtop" style="position:relative;z-index:4;">
			<div class="menu-scroller-left" ></div>
			<div class="menu-scroller-right"></div>
			<div class="menu-header">
				<ul id="navigation">
					<%=indexElement%>
				</ul>
			</div>
			<%if("true".equalsIgnoreCase(showArrowFlag)){ %>
			<div class="menu-arrow"><span id="arrowUpAndDown" class="arrowUp"></span></div>
			<%} %>
		</div>
		<div id="divBody">
			<div id="tabs" class="easyui-tabs"></div><!-- style='ovetriangletrianglerflow: hidden;position:absolute;' -->
		</div>
	</div>
	<!-- 版权信息，用ID"copyFooter"标识该div，在计算tab高度时需要减去这部分div高度 -->
	<div id="copyFooter" region="south" style="line-height:<%=copyrightHeight%>px;overflow: hidden;height:<%=copyrightHeight%>px;text-align:center;">
		<span style="display:none;">版权所有：<%=copyright %></span>
	</div>
	<div id="context_menu" class="easyui-menu" style="width:150px; display:none;">
		<div id="m-close" ><%=PlatformLocalesJSTL.getBundleValue("portal.toolbar.close")%></div>
		<div class="menu-sep"></div>
		<div id="m-closeother"><%=PlatformLocalesJSTL.getBundleValue("portal.toolbar.closeOther")%></div>
		<div id="m-closeall"><%=PlatformLocalesJSTL.getBundleValue("portal.toolbar.closeAll")%></div>
		<div class="menu-sep"></div>
		<div id="m-refresh"><%=PlatformLocalesJSTL.getBundleValue("portal.toolbar.refresh")%></div>
	</div>
	<div id="change_dept_dialog" title="<%=PlatformLocalesJSTL.getBundleValue("portal.change.dept")%>" style="background:#fff;padding:5px;width:300px;height:200px;display:none" >
	</div>
	<div id="modify_dialog" title="<%=PlatformLocalesJSTL.getBundleValue("portal.modify.password")%>" style="background:#fff;padding:5px;width:500px;height:380px;display:none" >
	</div>
	<div id="menu">
	    <div id="tooltip_menu" >
	        <a href="javascript:void(0);" onclick="openPortletAdd();return false;" ><img src='static/images/platform/index/images/portlet_add.gif' border='0'>&nbsp;添加首页应用</a>
	        <a href="javascript:void(0);" onclick="openLayoutPage();return false;" ><img src='static/images/platform/index/images/portlet_undo.gif' border='0'>&nbsp;设置页面布局</a>
	        <a href="javascript:void(0);" onclick="savePortlet();return false;" ><img src='static/images/platform/index/images/portlet_all.gif' border='0'>&nbsp;保存页面设置</a>
	    </div>
    </div>
	<div id="dialog" class="web_dialog">
	  <table style="width: 100%; border: 0px;" cellpadding="3" cellspacing="0">
	    <tr>
	      <td class="web_dialog_title"><span>Online Survey</span></td>
	      <td class="web_dialog_title align_right"><a href="#" id="btnClose">X</a></td>
	    </tr>
	    <tr>
	      <td colspan="2"><div id="context" style="width: 100%;"></div></td>
	    </tr>
	    <tr>
	      <td>&nbsp;</td>
	      <td align="right">
	      	<input type="button" id="save" value="<%=PlatformLocalesJSTL.getBundleValue("portal.conpnent.save")%>">
	      	<input type="button" id="cancel" onclick="hideDialog();return false;" value="<%=PlatformLocalesJSTL.getBundleValue("portal.conpnent.cancel")%>" >&nbsp;&nbsp;&nbsp;</td>
	    </tr>
	  </table>
	</div>
	<!-- 敏捷搜索提示框；默认隐藏，激发敏捷搜索后显示  -->
	<div id="agileSearchResult" class="agileSearchResults"></div>
</body>

</html>