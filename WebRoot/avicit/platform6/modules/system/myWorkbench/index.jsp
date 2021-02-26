<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<%
	//String sysPortletConfigId = request.getParameter("sysPortletConfigId");
	String sysPortletConfigId = (String)request.getAttribute("sysPortletConfigId");
	//首页皮肤设置
	String skinColor = (String)request.getSession().getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
%>
<html>
<head>
<title>我的工作台</title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<script type="text/javascript">
	var homePage = "<%=PlatformLocalesJSTL.getBundleValue("portal.index.homePage")%>";
</script>
<title><%=PlatformLocalesJSTL.getBundleValue("portal.index.homePage")%></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="static/css/platform/themes/<%=skinColor %>/index/style/easyui.css" rel="stylesheet" id="skins" type="text/css" />
<link href="static/css/platform/themes/<%=skinColor %>/index/style/platform_title.css" rel="stylesheet" type="text/css" />
<link href="static/css/platform/themes/<%=skinColor %>/sysmessage/style/messageDialogCss.css" rel="stylesheet" type="text/css" />
<link href="static/css/platform/public/skin/skin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/jQuery/jQuery-easydrag-1.5/jquery.hoverIntent.minified.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/jQuery/jQuery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.jquery.dcmegamenu.1.3.3.js"></script>
<!-- add by xingc-->
<script type="text/javascript" src="static/js/platform/sysmessage/js/messageDialog.js"></script>
<script type="text/javascript" src="static/js/platform/search/js/quickSearch.js"></script>
<script type="text/javascript" src="static/js/platform/component/common/CommonDialog.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.dashboard.index.js"></script>
<script type="text/javascript" src="static/js/platform/index/js/platform.dashboard.index.classic.js"></script>


<script type="text/javascript">
var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
var messageCount = 0;

function loadMessageData(){
	} 

function openLayoutPage() {
	var dialogId = "layoutDialog";
	var usd = new CommonDialog(dialogId, "450", "450",
			baseUrl + 'avicit/platform6/modules/system/myWorkbench/portlet/indexPortletConfig.jsp?isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>&dialogId='+dialogId, "设置页面布局", false, true, false);
	usd.show();
}
function openPortletAdd() {
	var dialogId = "portletAddDialog";
	var usd = new CommonDialog(dialogId, "450", "450",
			baseUrl + 'avicit/platform6/modules/system/myWorkbench/portlet/indexPortletAdd.jsp?isgloable=true&dialogId='+dialogId, "添加首页应用", false, true, false);
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
			url: baseUrl+'platform/myWorkbenchController/saveIndexPortlet.json',
			async : false,
			type: "POST",
			data : 'isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>&portlet=' + portlet+'&layout='+layout,
			success: function(){
				//获取当前操作的数据行记录
				$.messager.defaults = {ok:"确定"};
				$.messager.alert('提示','保存页面设置成功!','info',function(){
					hideDialog();
					window.location.reload();
					//refreshPortlet();	
				});
				//alert('保存页面设置成功!')
				
			},
			error : function(){
				//alert('portlet配置信息保存失败!');
			}
		});
	}else{
		$.messager.alert('提示','请至少添加一个首页模块','info',
			function(){
		window.location.reload();
		});
	}

}
</script>

<!-- 菜单栏css & js -->
<%-- 
<link rel="stylesheet" type="text/css" href="static/css/platform/public/myWorkbench.css" />
<script type="text/javascript" src="static/js/platform/public/myWorkbench.js"></script>
--%>

<link rel="stylesheet" type="text/css" href="static/css/platform/public/newWorkbench.css" />
<!-- fontawesome -->
<link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css" />

<script type="text/javascript">
function activeMenu(that) {
	//首页class稍微不同，特此判断处理
	//STEP1:删除激活状态li的class
	if($(".activeBg").attr("id") == "indexLi") {
		$("#indexLi").removeClass("activeBg");
		$("#indexA").removeClass("active");
	}
	else {
		$(".activeBg").removeClass("activeBg");
	}
	
	//STEP2:添加新激活状态li的class
	var li = $(that).parent();
	if(li.attr("id") == "indexLi") {
		li.addClass("activeBg");
		$("#indexA").addClass("active");
	}
	else {
		li.addClass("activeBg");
	}
}
</script>
</head>

<body class="easyui-layout"	onload="addTab('<%=PlatformLocalesJSTL.getBundleValue("portal.index.homePage")%>','avicit/platform6/modules/system/myWorkbench/portlet/indexPortlet.jsp?isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>','static/images/platform/index/images/icons.gif','homePage','-0px -20px');loadMessageData();mainOfQuickSearch();">
	<div region="center" style="overflow: hidden;">
		<div id="divBodyWidth">
			<div id="header">
				<div class="logo">
					<div style="float: right; margin-top: 20px; margin-right: 5px;">
						<a href="javascript:;" onclick="addTab('菜单配置','<%=request.getContextPath()%>/avicit/platform6/modules/system/myWorkbench/sysMenu/menuConfig.jsp','','menuConfig','')" class="easyui-linkbutton" style="color: #187ed2; font-weight: bold;">
							工作台菜单配置
						</a>
					</div>
				</div>
			</div>
		</div>
		
		<%-- 
		<div class="index-menu" style="width: 100%; position:relative;z-index:4;left:0px;">
			<div class="menu-scroller-left" ></div>
			<div class="menu-scroller-right"></div>
			<div class="menu-header">
				<ul id="mega-menu" class="mega-menu" style="width: 100%;">
					<li class="dc-mega-li"><a class="dc-mega" href="javascript:void(0)" style="display:block;" onclick="addTab('系统首页','avicit/platform6/modules/system/myWorkbench/portlet/indexPortlet.jsp?isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>','static/images/platform/sysmenu/icons.gif','homePage','-0px -20px');return false;">系统首页</a></li>
					
					<c:forEach var="workbenchMenu" items="${myWorkbenchMenuList}" varStatus="status">					
						<li class="dc-mega-li">
							<c:forEach var="sysMenu" items="${mySysMenuList}">
								<c:if test="${sysMenu.id == workbenchMenu.sysMenuId}">
									<a class="dc-mega" href="javascript:void(0)" style="display:block;" 
										onclick="addTab('${workbenchMenu.aliasMenuName}','${sysMenu.url}','','${workbenchMenu.id}','');return false;">
										${workbenchMenu.aliasMenuName}
									</a>								
								</c:if>
							</c:forEach>
						</li>
					</c:forEach>					
				</ul>		
			</div>
			<div class="menu-arrow"><span id="arrowUpAndDown" class="arrowUp"></span></div>
		</div>
		--%>
		
		<%-- 
		<div class="workbenchMenu">
			<div class="w t_cen">
				<div class="t_c_lr t_c_left" style="margin-top: -61px;">
				</div>
				
				<div class="t_c_cen">
					<div class="t_c_bottom">
						<ul id="mega-menu">
							<li class="thisli">
								<a href="javascript:void(0)" onclick="addTab('系统首页','avicit/platform6/modules/system/myWorkbench/portlet/indexPortlet.jsp?isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>','static/images/platform/sysmenu/icons.gif','homePage','-0px -20px');return false;">
									<em>系统首页</em>
								</a>
							</li>
						
							<c:forEach var="workbenchMenu" items="${myWorkbenchMenuList}" varStatus="status">					
								<li>
									<c:forEach var="sysMenu" items="${mySysMenuList}">
										<c:if test="${sysMenu.id == workbenchMenu.sysMenuId}">
											<a href="javascript:void(0)" onclick="addTab('${workbenchMenu.aliasMenuName}','${sysMenu.url}','','${workbenchMenu.id}','');return false;">
												<em>${workbenchMenu.aliasMenuName}</em>
											</a>
										</c:if>
									</c:forEach>
								</li>
							</c:forEach>	 
						</ul>
						
						<div class="thisMenu" id="thisMenu"></div>
					</div>
				</div>
				
				<div class="t_c_lr t_c_right" style="margin-top: -61px;">
				</div>
			</div>
		</div>
		--%>
		
		<div class="index-menu" style="width: 100%; position:relative;z-index:4;left:0px;">
			<div style="height: 65px;">
				<div class="menu">
					<ul id="mega-menu">
						<li class="menu01 activeBg" id="indexLi">
							<a id="indexA" class="active" href="javascript:void(0)" onclick="addTab('系统首页','avicit/platform6/modules/system/myWorkbench/portlet/indexPortlet.jsp?isgloable=true&sysPortletConfigId=<%=sysPortletConfigId%>','static/images/platform/sysmenu/icons.gif','homePage','-0px -20px');activeMenu(this);return false;">
								系统首页
							</a>
						</li>
					
						<c:forEach var="workbenchMenu" items="${myWorkbenchMenuList}" varStatus="status">					
							<li>
								<c:forEach var="sysMenu" items="${mySysMenuList}">
									<c:if test="${sysMenu.id == workbenchMenu.sysMenuId}">
										<div onclick="addTab('${workbenchMenu.aliasMenuName}','${sysMenu.url}','','${workbenchMenu.id}','');activeMenu(this);return false;"
											style="margin-bottom: -28px; margin-top: 2px;">
					    					<i class="${workbenchMenu.iconClass}" style="font-size: 210%;"></i>
					    				</div>
										
										<a href="javascript:void(0)" onclick="addTab('${workbenchMenu.aliasMenuName}','${sysMenu.url}','','${workbenchMenu.id}','');activeMenu(this);return false;">
											${fn:substring(workbenchMenu.aliasMenuName, 0, 6)}
										</a>
									</c:if>
								</c:forEach>
							</li>
						</c:forEach>						
					</ul>
				</div>
			</div>
		</div>
	
		<div id="divBody" style="top:85px;">
			<div id="tabs" class="easyui-tabs" style='overflow: hidden;position:absolute;'></div>
		</div>
	</div>

	<div id="menu" style="top:85px;">
	    <div id="tooltip_menu">
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
</body>

</html>