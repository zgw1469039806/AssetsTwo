 //动态换肤时切换portlet页面的换肤样式
 function replaceSkin(skinsType){
	   for(var i =0 ;i < $("iframe").size(); i++){
		   var curTabWin =  $("iframe")[i].contentWindow;
		   if(curTabWin.document.getElementById("portlet-skin") != null){
			   curTabWin.document.getElementById("portlet-skin").setAttribute('href',"avicit/platform6/portal/portlet/skin/"+skinsType+"-portlet.css");
				if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i) == "8.") {
					if (typeof eval(curTabWin.redrawPseudoEl) == "function") {
						//解决IE8portlet小页内容图标不重绘问题
						curTabWin.redrawPseudoEl();
					}
				}
			}
		}
	   //解决IE8portlet小页自带title图标不重绘问题
//	   redrawPseudoEl();
	   redrawPortalPseudoEl()
		 //刷新返回顶部换肤
	    var linkColor = document.getElementById("color_link");
		var linkColorStr = "avicit/platform6/portal/skin/"+skinsType+".css";
		linkColor.setAttribute('href',linkColorStr);
	}
 //兼容IE8下iconfont图标伪元素动态切换颜色是不会重新加载的问题--针对首页图标
 function redrawPortalPseudoEl(){
	   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
		     var iconEl = $('.m-btn-downarrow');
	 		  iconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 iconEl.removeClass('content-empty');
	 		  },0);
	 		 
	 	  }
 }
 //兼容IE8下iconfont图标伪元素动态切换颜色是不会重新加载的问题---不考虑换肤时可以不考虑
 function redrawPseudoEl(){
	   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
		     var iconEl = $('.icon');
	 		  iconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 iconEl.removeClass('content-empty');
	 		  },0);
	 		  var glyphiconEl = $('.glyphicon');
	 		   glyphiconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 glyphiconEl.removeClass('content-empty');
	 		  },0);
	 		  var faEl = $('.fa');
	 		  faEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 faEl.removeClass('content-empty');
	 		  },0);
	 		  var downarrowel = $('.m-btn-downarrow');
	 		  downarrowel.addClass('content-empty');
	 		  setTimeout(function(){
	 			 downarrowel.removeClass('content-empty');
	 		  },0);
	 		 var hlistEl = $('.hlist');
	 	    	hlistEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 hlistEl.removeClass('content-empty');
	 		  },0);
	 		 
	 	  }
 }
 //兼容IE8下iconfont图标伪元素动态切换颜色是不会重新加载的问题---不考虑换肤时可以不考虑
 function redrawTreePseudoEl(){
	   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
		   var buttonEl = $('.button');
		   buttonEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 buttonEl.removeClass('content-empty');
	 		  },0);
	 		  
	 		var iconEl = $('.icon');
	 		  iconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 iconEl.removeClass('content-empty');
	 		  },0);
	 	  }
 }
 //兼容IE8下iconfont图标伪元素动态切换颜色是不会重新加载的问题---该方法只针对bootstrap图标库，解决IE分页按钮不重绘问题
 function redrawPagerPseudoEl(tspg){
	   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
		   var glyphiconEl = $("#next"+tspg+", #last"+tspg + ",#first"+tspg+", #prev"+tspg).find("span");
 		   glyphiconEl.addClass('content-empty');
 		   setTimeout(function(){
 			 glyphiconEl.removeClass('content-empty');
 		  },10);
	 }
}
 
//兼容IE8下iconfont图标伪元素动态切换颜色是不会重新加载的问题---针对H+主题下收缩菜单时使用
 function oaRedrawPseudoEl(){
	   if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
		     var iconEl = $('.navList').find('.icon');
	 		  iconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 iconEl.removeClass('content-empty');
	 		  },0);
	 		  var glyphiconEl =$('.navList').find('.glyphicon');
	 		   glyphiconEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 glyphiconEl.removeClass('content-empty');
	 		  },0);
	 		  var faEl = $('.navList').find('.fa');
	 		  faEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 faEl.removeClass('content-empty');
	 		  },0);
	 		  var downarrowel = $('.navList').find('.m-btn-downarrow');
	 		  downarrowel.addClass('content-empty');
	 		  setTimeout(function(){
	 			 downarrowel.removeClass('content-empty');
	 		  },0);
	 		 var hlistEl = $('.navList').find('.hlist');
	 	    	hlistEl.addClass('content-empty');
	 		  setTimeout(function(){
	 			 hlistEl.removeClass('content-empty');
	 		  },0);
	 		 
	 	  }
 }