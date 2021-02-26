<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
/*简单标签切换 Start*/
html{} body {
	width: 100%;
	overflow: auto;
	height: 100%;
	margin: 0;
	padding: 0;
	background-color: #ffffff;
	font: normal 100%;
	font-family: PingFangSC-Regular,sans-serif,PingFangSC-Light,sans-serif,"Microsoft YaHei",arial;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
}
*{
	box-sizing: border-box;
}
h2,
h3,
h4 {
	margin: 0;
	padding: 0;
	font-weight: normal;
}
ul,
li {
	margin: 0;
	padding: 0;
	list-style: none;
}
img{
	display: block;
	border: 0;
}
a:hover,a:active,a:after,a:-webkit-any-link{
	text-decoration: none;
	webkit-transition: background-color .15s linear;
	-moz-transition: background-color .15s linear;
	transition: background-color .15s linear;
}
.clearfix:before, .clearfix:after {
    content: "";
    display: table;
    clear: both;
}
.skin-content{
	width: 650px;
	margin: 0 auto;
	padding: 0;
}
.skin-title{
	font-size: 16px;
	color: #585858;
	margin: 15px 0;
}
ul.preview-list li{
	float: left;
	width: 124px;
	display: inline-block;
	margin: 0px 18px;
}
ul.preview-list li a{
	width: 124px;
	height: 84px;
	display: inline-block;
	border: 2px solid #ffffff;
	box-shadow: 0px 0px 6px #d6d6d6;
	position: relative;
}
ul.preview-list li img{
	width: 120px;
	height: 80px;
}
ul.preview-list li.preview-select a{
	border: 2px solid #1182fa;
	box-shadow: 0px 0px 6px #d9ebfe;

}
ul.preview-list li:hover a{
	border: 2px solid #1182fa;
}
ul.preview-list li em.preview-text{
	font-style: normal;
	font-size: 14px;
	width: 124px;
	text-align: center;
	color: #585858;
	display: block;
	padding: 10px 0;
}
ul.preview-list li.preview-select span{
	background-image: url(static/images/platform/common/choice.png);
	background-position: bottom right; 
	background-repeat: no-repeat;
	display: inline-block;
	width: 38px;
	height: 38px;
	position: absolute;
	right:0;
	bottom: 0;
}
.skin-list{
	margin: 0px auto;
}
.skin-list li{
	float: left;
	margin: 5px 25px;
}
.skin-list li a{
	display: inline-block;
	width: 65px;
	height: 40px;
	background: #ffffff;
	border-radius: 4px;
	box-shadow: 0px 5px 5px #d6d6d6;
}
.skin-list li a.skin-blue{
	background: #0066cc;
}
.skin-list li a.skin-red{
	background: #e62340;
}
.skin-list li a.skin-purple{
	background: #7364bf;
}
.skin-list li a.skin-green{
	background: #00b791;
}
.skin-list li a.skin-black{
	background: #505364;
}
.skin-list li.choice a{
	background-image: url(static/images/platform/common/choice1.png);
	background-position: center center; 
	background-repeat: no-repeat;
}
.skin-list li em{
	font-style: normal;
	font-size: 14px;
	width: 65px;
	text-align: center;
	color: #585858;
	display: block;
	padding: 10px 0;
}

/*换肤模块 End*/
</style>
</head>
<body>
	<body>
		<div class="skin-content">
			<h2 class="skin-title">布局设置</h2>
			    ${previews}
			<h2 class="skin-title">皮肤设置</h2>
			<ul class="skin-list clearfix" id="skinsContent"> 
				${skins}
			</ul>
		</div>
	</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<script type="text/javascript">
var initSkinValue =  $('#skinsType').val();//记录页面打开时数据库保存的皮肤颜色
var initTypeKeyValue =  $('#typeKey').val();//记录页面打开时数据库保存的布局
	function save(){
		$.ajax({
			url:'portal/toSavePersonPortalConfig',
			data : {
				typeKey : $('#typeKey').val(),
				skinsType : $('#skinsType').val(),
				resourceType : 'user',
				appId : '${appId}',
				orgIdentity : '${orgIdentity}'
			},
			dataType : "text",
			type : 'GET',
			success : function(msg){
				if(msg > 0 || msg == 'success'){
					top.layer.confirm('主题皮肤设置成功，是否进行切换?',{icon: 3, title:'提示'}, function(index){
						changeThemes();
				    });
				}
			},
			error : function(msg){
				top.layer.alert('主题皮肤设置失败！',{icon: 3, title:'提示'}); 
			}
		});
	}
	function changeThemes(){
		window.top.location = window.top.location;
		return false;
	}
	//切换主题
	function selectThemes(thisObj){
		$("#typeKey").val($(thisObj).parent().attr("data"));
		$("li[name='protalThemes']").removeClass("preview-select");
		$(thisObj).parent().addClass("preview-select");
		getSkinsForThemes($("#typeKey").val());
	}
	//切换皮肤颜色
	function selectSkin(thisObj){
		$("#skinsType").val($(thisObj).parent().attr("data"));
		$("li[name='skinColor']").removeClass("choice");
		$(thisObj).parent().addClass("choice");
		replaceSkin($('#skinsType').val());
	}
	//关闭换肤页面是需要恢复原有样式
	function restSkin(){
		  replaceSkin(initSkinValue);
	}
	function replaceSkin(skinsType){
		 //动态切换头部样式
		  var link = parent.document.getElementById("theme");
		  var linkStr = "avicit/platform6/portal/themes/"+initTypeKeyValue+"/skins/"+skinsType+"/index/style.css";
		  link.setAttribute('href',linkStr);
		  //动态重绘首页图标
		  parent.redrawPseudoEl();
		  //修改换肤页面样式
		  var linkSkin = document.getElementById("skin_link");
		  var linkSkinStr = "avicit/platform6/portal/themes/"+initTypeKeyValue+"/skins/"+skinsType+"/skin/style.css";
		  linkSkin.setAttribute('href',linkSkinStr);
		  
	      //兼容新提出公共颜色换肤使用
		  var colorSkin = document.getElementById("color_link");
		  var colorSkinStr = "avicit/platform6/portal/skin/"+skinsType+".css";
		  colorSkin.setAttribute('href',colorSkinStr);
		  
			var colorSkinp = parent.document.getElementById("color_link");
			colorSkinp.setAttribute('href',colorSkinStr); 
		 
		  
		  //动态设置当前打开Tab页面的皮肤颜色
		  var tab = parent.$('#tabs-panel').tabs("getSelected");    //获取选中的标签页面板
		  var curTabWin = tab.find('iframe')[0].contentWindow;
		  if(curTabWin.document.getElementById("skin_link") != null){
		       curTabWin.document.getElementById("skin_link").setAttribute('href',linkSkinStr);
		  }
		  if(curTabWin.document.getElementById("color_link") != null){
			   curTabWin.document.getElementById("color_link").setAttribute('href',colorSkinStr);
		  }
		  //获取当前选中页签坐标
		  var index = parent.$('#tabs-panel').tabs('getTabIndex',tab);
		  if(index == 0){
			 //当前选中页签为首页，需要动态换肤portlet
			  curTabWin.replaceSkin(skinsType);
		  }
	}
	//动态获取 选中主题下的皮肤
	function getSkinsForThemes(typeKey){
		$.ajax({
			url:'portal/toPersonPortalConfigSkinsForThemes',
			data : {
				typeKey : $('#typeKey').val()
			},
			dataType : "text",
			type : 'GET',
			success : function(msg){
				$("#skinsContent").html(msg);
				//动态切换颜色
				replaceSkin($('#skinsType').val());
			},
			error : function(msg){
				top.layer.alert('主题皮肤设置失败！',{icon: 3, title:'提示'}); 
			}
		});
	}
</script>
</body>
</html>