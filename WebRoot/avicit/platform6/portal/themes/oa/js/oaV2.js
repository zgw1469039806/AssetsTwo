$(function() {
    init();
    $(window).on('resize',function(){
        setTimeout(function(){
            $('.tabs-header,.tabs-panels,.panel-htop,.panel-body,.tabs-wrap').css('width',$('#tabs-panel').width())
        },300);
    });
    $('.square').hide();
});
function init() {
    setHeight();
    hideLeft();
    leftMenuEvent();
    // 首页标签加子菜单
    $('#tabs-panel').tabs({
        onUpdate: function() {
            if ($('#indexMenu').hasClass('menu')) return;
            addSubMenu(0, 'index');
        }
    });

    addPmenu("#tabs-panel");
    perfectScroll($('body'));
    perfectScroll($('.avic-smenu'));
    perfectScroll($('.navList'),{railalign:"left"});
    initPersonalMenu();//初始化常用区
    //兼容性问题，增加滚动条美化后，生成的滚动条区域会影响菜单区域滑过问题，将所有生成的美化滚动条初始化放最左边
	  $("div[id*='ascrail']").css("left","0");
//    $("div[id*='ascrail']").css("display","none");
}

/**
 * 初始化个人菜单
 */
function initPersonalMenu() {
    //绑定常用菜单按钮显示事件
    $('#personalMenu').on('show.bs.dropdown', function () {
        loadPersonalMenu();
        perfectScroll($('.avic-smenu'));
    });
   
       //绑定个人收藏按钮显示事件
    $('#personalCollect').on('show.bs.dropdown', function () {
        loadPersonalCollect();
    });

    //绑定个人消息按钮显示事件
    $('#personalMessage').on('show.bs.dropdown', function () {
        loadPersonalMessage();
    });
    queryUnReadMessageAmount();//获取未读消息数量
    $('#addMessageDialog').sendMsg({area: ['70%', '70%']});
    
    loadUserDefined(0);
}

function loadPersonalCollect(){
    
}

/**
 * 独立添加tab标签
 * @param {string} title 标签名
 * @param {string} url   地址链接
 * @param {boolean} isRefresh   是否刷新页面
 */
function addTab(title, url, isRefresh) {
    var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
    if (!exist && url != undefined) {
        $('#tabs-panel').tabs({
            onAdd:function(title,index){
                var target = this;
                var tab = $('#tabs-panel').tabs('getTab', title);
                setTimeout(function(){
                    $(target).tabs('select', title).tabs('update',{
                        tab:tab,
                        options:{
                            content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>'
                        }
                    });
                },500);
            }
        });
        $('#tabs-panel').tabs('add', {
            title: title,
            content: ' ',
            closable: true
        });
    } else {
        $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口

        //刷新
        if(url != undefined && isRefresh){
            $("#tabs-panel").tabs("getTab", title).find('iframe').attr('src', url);
        }
    }
}

//删除Tabs
function closeTab(id, menu, type) {
    var allTabs = $(id).tabs('tabs');
    var allTabtitle = [];
    $.each(allTabs, function(i, n) {
        var opt = $(n).panel('options');
        if (opt.closable)
            allTabtitle.push(opt.title);
    });
    var curTabTitle = $(menu).data("tabTitle");
    var curTabIndex = $(id).tabs("getTabIndex", $(id).tabs("getTab", curTabTitle));
    switch (type) {
        case 1: //刷新
            var nowurl = $(id).tabs("getTab", curTabTitle).find('iframe').attr('src');
            $(id).tabs("getTab", curTabTitle).find('iframe').attr('src', nowurl);
            break;
        case 2: //关闭
            $(id).tabs("close", curTabIndex);
            return false;
            break;
        case 3: //全部关闭
            for (var i = 0; i < allTabtitle.length; i++) {
                $(id).tabs('close', allTabtitle[i]);
            }
            break;
        case 4: // 关闭其他全部
            for (var i = 0; i < allTabtitle.length; i++) {
                if (curTabTitle != allTabtitle[i])
                    $(id).tabs('close', allTabtitle[i]);
            }
            $(id).tabs('select', curTabTitle);
            break;
    }
}

// 添加标签的右键管理菜单
function addPmenu(id) {
    $('body').append('<div id="p-menu" class="easyui-menu" style="width:120px;">' +
        '<div id="pm-tabclosrefresh" data-options="name:1">刷新</div>' +
        '<div id="pm-tabclose" data-options="name:2">关闭</div>' +
        '<div id="pm-tabcloseall" data-options="name:3">全部关闭</div>' +
        '<div id="pm-tabcloseother" data-options="name:4">关闭其他全部</div>' +
        '</div>');

    $(id).tabs({
        onContextMenu: function(e, title, index) {
            e.preventDefault();
            if(!$(e.target).parents('li').hasClass('tabs-selected')){
                $("#pm-tabclosrefresh").hide();
            }else{
                $("#pm-tabclosrefresh").show();
            }
            $('#p-menu').menu('show', {
                left: e.pageX,
                top: e.pageY,
                onShow: function() {
                    //本标签不可关闭
                    if ($(e.target).hasClass('tabs-closable') || $(e.target).find('.tabs-title').hasClass('tabs-closable')) {
                        $("#pm-tabclose,#pm-tabcloseall").removeAttr("disabled").removeAttr("style");
                    } else {
                        $("#pm-tabclose,#pm-tabcloseall").attr({
                            disabled: "disabled"
                        }).css({
                            cursor: "default",
                            color: '#999'
                        });
                    }
                    //关闭令居
                    if ($(e.target).parents('li').siblings('li').find('.tabs-title').hasClass('tabs-closable')) {
                        $("#pm-tabcloseother").removeAttr("disabled").removeAttr("style");
                    } else {
                        $("#pm-tabcloseother").attr({
                            disabled: "disabled"
                        }).css({
                            cursor: "default",
                            color: '#999'
                        });
                    }
                }
            }).data("tabTitle", title);
        }
    });
    //右键菜单click
    $("#p-menu").menu({
        onClick: function(item) {
            if ($(item.target).attr('disabled')) return;
            closeTab("#tabs-panel", this, item.name);
        }
    });

}

//给标签加菜单
function addSubMenu(index, id) {
    var p = $('#tabs-panel').tabs().tabs('tabs')[index];
    if (!p) return;
    var mb = p.panel('options').tab.find('a.tabs-inner');
    if (id == "begin") {
        initBeginMenu();
        mb.menubutton({
            menu: '#' + id + 'Menu',
            iconCls:'icon icon-menu1'
        }).on('click', function(e) {
            $('#tabs-panel').tabs('select', index);
        });
    } else {
        initSubMenu(id);
        mb.menubutton({
            menu: '#' + id + 'Menu'
        }).on('click', function(e) {
            $('#tabs-panel').tabs('select', index);
        });
    }

}
function initBeginMenu() {
    var nod = document.createElement('style'),
        str = '#beginMenu {max-height:' + parseInt(($(window).height() - 80) / 36) * 36 + 'px}';
    nod.type = 'text/css';
    if (nod.styleSheet) {
        nod.styleSheet.cssText = str;
    } else {
        nod.innerHTML = str;
    }
    document.getElementsByTagName('head')[0].appendChild(nod);
}
//tab栏子菜单事件绑定
function initSubMenu(index) {
    $('#' + index + "Menu li").off().on('click', function() {
        var tagName = $(this).parents('.tabsSubMenu').data('for'),
            tab = $('#tabs-panel').tabs('getTab', tagName),
            url = $(this).attr('rel');
        if(url){

            $(this).addClass("checked").siblings("li").removeClass("checked");
            $('#tabs-panel')
                .tabs('select', tagName)
                .tabs('update', {
                    tab: tab,
                    options: {
                        title: tagName,
                        content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>'
                    }
                });
        }
    });
}


/**
 * 缩小左侧导航
 */
function hideLeft() {
    var bar = $('.leftAside'),
        btn = $('.hideLeftMenu'),
        mainWidth;
    btn.on('click', function() {
        bar.toggleClass("close");
        if (bar.hasClass("close")) {
            //切换展开、收缩图标
            $('.hideLeftMenu i').removeClass('icon-shousuo');
            $('.hideLeftMenu i').addClass('icon-zhankai1');
            $('.navList ul li i.menu-bg-red').css("right","2px");
            
            mainWidth = $('body').innerWidth() - 60;
            setcookie('hideIndexLeft', 1);
            $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
        } else {
            //切换展开、收缩图标
            $('.hideLeftMenu i').removeClass('icon-zhankai1');
            $('.hideLeftMenu i').addClass('icon-shousuo');
            $('.navList ul li i.menu-bg-red').css("right","15px");
          
            mainWidth = $('body').innerWidth() - 200;
            setcookie('hideIndexLeft', 0);
            setTimeout(function() {
                $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
            }, 300);
        }
        setTimeout(function(){
            perfectScroll($('.navList'),'update');
        },500);
    });
}

// 左侧菜单事件
function leftMenuEvent() {
    $('.navList .subList').each(function() {
        var col = $(this).data('col');
        if (col) {
            $(this).css({
                width: col * 180
            });
        }
        if ($(this).parent().position().top + $(this).innerHeight() > $('body').innerHeight()) {
            $(this).css({
                top: 'inherit',
                bottom: $(this).innerHeight()
            });
        }
    });
    $('.navList').delegate(".taburl", 'click', function(e) {
        e.stopPropagation();
        e.preventDefault();

        //tab标题长度大于8个字符,截取前8个,后面的显示为...
        var title = $(this).text();
        var preTitle = title;
        if(title != null && title != '' && title != undefined ){
            if(title.length > 8){
                title = title.substr(0,8) + "...";
            }
        }
        //var title = $(this).text(),
        var url = $(this).attr("rel"),
            exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
        if (!exist && url != null && url != '') {
            $('#tabs-panel').tabs({
                onAdd:function(title,index){
                    var target = this;
                    var tab = $('#tabs-panel').tabs('getTab', title);
                    setTimeout(function(){
                        $(target).tabs('select', title).tabs('update',{
                            tab:tab,
                            options:{
                                content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '"style="width:100%;height:100%;"></iframe>'
                            }
                        });
                    },500);
                    //获取当前添加的tab并增加title属性
                    var currentTab = $(target).tabs('select', title).find(".tabs-selected").find("span.tabs-title");
                    if(currentTab != null && currentTab != '' && currentTab != undefined){
                        currentTab.attr("title",preTitle);
                    }
                }
            });
            $('#tabs-panel').tabs('add', {
                title: title,
                content: ' ',
                closable: true
            });
        } else {
            $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
        }
    });
    //fixed:ie8下iframe窗口内输入框光标浮动在父页面div侧边栏菜单上的问题
    if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
        $('.leftAside .navList li').on('mouseenter',function(){
            $('iframe').contents().find('textarea').blur()
        });
    }

    var navListClone, clonedom;

    $('.navList').delegate('>ul>li', 'mouseenter', function() {
        var ct = $(this).find('.subList'),
            os = $(this).offset(),
            w = $(this).parent().innerWidth(),//由于li有一个左侧偏移3px导致获取的宽度少了3px，最终二级菜单和一级菜单有重叠
            that = $(this);
        $(".navListClone1").remove();
        clonedom = ct.clone(true);
        if (!ct.length) return;
        $(document).off('mousemove.navclone');
        $(this).addClass('on').siblings().removeClass('on');

        clonedom.find('.taburl').on('click', function(e) {
            e.stopPropagation();
            e.preventDefault();
            var title = $(this).text();
            var url = $(this).attr("rel");
            var openType = $(this).attr("openType");//打开方式
            if(openType == '_blank'){
                openBlank(title,url);
            } else if(openType == '_top'){
                openTop(title,url);
            } else if(openType == '_self'){
                openSelf(title,url);
            } else {// default mainframe
                openMainFrame(title,url);
            }

        });
        var af  = $('<iframe src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0'+
                                    ' style="position:absolute; visibility:inherit;'+
                                    'top:0px;left:0px;height:100%;width:100%;z-Index:-1;'+
                                    'filter=\'progid:DXImageTransform.Microsoft.Alpha('+
                                        'style=0,opacity=0)\';"></iframe>');
        af.appendTo(clonedom);
        $("body").append(clonedom.removeAttr('style'));
        clonedom.wrap('<div class="navListClone1" id="navListClone1"></div>');
        navListClone = $('.navListClone1');
        var winheight = $('body').innerHeight(),
            navlisttop = 0;

        var topheight = 50;
        winheight = winheight - topheight;//减去顶栏高度
        if (navListClone.length && os.top - topheight +  navListClone.innerHeight() >= winheight) {
            navListClone.css({
                height:'auto'
            });
         if(navListClone.height() < winheight){
              if(os.top- topheight - navListClone.innerHeight() + $(this).innerHeight() <0 ){
                  navlisttop = topheight;
              }else{
                  navlisttop = os.top - navListClone.innerHeight() + $(this).innerHeight();
              }
          }else if(navListClone.height() == winheight){
              navlisttop = topheight;
          }else{
              navListClone.css({
                  height:winheight
              });
              navListClone.find('.subList').wrap('<div class="subMenuOverflow" style="overflow-y:auto;overflow-x:hidden;height:100%;width:100%; box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.15);"></div>');
              navlisttop = topheight;
//            perfectScroll($('.subMenuOverflow'));
          }
            navListClone.css({
                left: w,
                zIndex:2,
                top: navlisttop
            });
        } else {
            navListClone.css({
                top: os.top,
                left: w,
                zIndex:2,
                bottom: 'inherit'
            });
        }
        $('.navListClone1').on('mouseleave', function(e) {
        	if(!isInOrOut(2)){
        	      navListClone.remove();
        	      $(".navListClone2").remove();
                  clonedom = null;
                  navListClone = null;
                  that.removeClass('on');
        	}
        });
    }).delegate('>ul>li', 'mouseleave', function() {
        var ct = $(this).find('.subList');
        var that = $(this);
        if(!ct.length) return;
        $(document).on('mousemove.navclone', function(e) {
            if (!$(e.target).parents().is('.navListClone1') && !$(e.target).is('.navListClone1') 
            		&& !$(e.target).parents().is('.navListClone2') && !$(e.target).is('.navListClone2')
            		&& !$(e.target).parents().is('.navListClone3') && !$(e.target).is('.navListClone3')
            		&& !$(e.target).parents().is('.navListClone4') && !$(e.target).is('.navListClone4')) {
                if (navListClone) {
                    navListClone.remove();
                    clonedom = null;
                    navListClone = null;
                    that.removeClass('on');
                    $(".navListClone2").remove();
                    $(".navListClone3").remove();
                    $(".navListClone4").remove();
                }
            }
        });
    });
    $('.navList>ul>li>.subList>.subChild').mouseenter(function(){
    	cloneChild(this,2);
    });

    $('.navList>ul>li>.subList>.subChild>ul>.subChild').mouseenter(function(){
    	cloneChild(this,3);
    });
    $('.navList>ul>li>.subList>.subChild>ul>.subChild>ul>.subChild').mouseenter(function(){
    	cloneChild(this,4);
    });
    $('.navList').height($('.leftAside').height()-$('.leftAside .logoDom').height()-2-96);

    $(window).on('resize',function(){
        setTimeout(function(){
            $('.navList').height($('.leftAside').height()-$('.leftAside .logoDom').height()-2-50);
            perfectScroll($('.navList'),'update');
        },500);
    });
}
//复制三、四、五级菜单并显示
function cloneChild(current,level){
	var navListClone2,clonedom2;
    var ct = $(current).children('ul'),
        os = $(current).offset(),
        parentLeft = $(".navListClone1").css("left").substring(0,$(".navListClone1").css("left").length-2);
        w =  parseInt(parentLeft) + (level - 1) * 180,
    $(".navListClone"+level).remove();
    clonedom2 = ct.clone(current);
    $(current).addClass('on').siblings().removeClass('on');
    if (!ct.length) return;
    $("body").append(clonedom2.removeAttr('style'));
    clonedom2.wrap('<div class="navListClone'+level+'" id="navListClone'+level+'" ><div class="navList"></div></div>');
    $('.navListClone'+level+' li ul').hide();
    navListClone2 = $('.navListClone'+level);
    //判断与父级菜单平行向下时能否显示全
    if (navListClone2.length && os.top + navListClone2.innerHeight() > $('body').innerHeight()) {
    	//显示不全时判断与父级菜单平行向上时能否显示的全
    	if(navListClone2.length && os.top +  38 < navListClone2.innerHeight()){
    		 //显示不全时判断上边框与浏览器齐平时能否显示全
    		 if(navListClone2.innerHeight() > $('body').innerHeight()){
    			 //显示不全满屏显示
    			 navListClone2.css({
	                 left: w,
	                 zIndex:3,
	                 top: 0,
	                 height:$('body').innerHeight(),
	                 'overflow-y':'auto'
	             });
    		 }else{
    			 navListClone2.css({
	                 left: w,
	                 zIndex:3,
	                 top: 0
	             });
    		 }
    	}else{
            navListClone2.css({
                left: w,
                zIndex:3,
                top: os.top - navListClone2.innerHeight() + 38
            });
    	}
    } else {
        navListClone2.css({
            top: os.top,
            left: w,
            zIndex:3,
            bottom: 'inherit'
        });
    }
    $('.navListClone'+level).on('mouseleave', function(e) {
    	if(!isInOrOut(level+1) && isInOrOut(level-1)){
  		  	$(".navListClone"+(level+1)).remove();
    	}
    	if(!isInOrOut(level+1) && !isInOrOut(level-1)){
            $(".navList>ul>li").removeClass('on');
    		for(var i = 1;i<=level+1;i++){
      		  	$(".navListClone"+i).remove();
    		}
    	}
    });
}
function isInOrOut(id){
	if(!$("#navListClone"+id).length) return false;
    var wx = window.event.clientX;
    var wy = window.event.clientY;
    var d_left = document.getElementById("navListClone"+id).offsetLeft;
    var d_top = document.getElementById("navListClone"+id).offsetTop;
    //var d_width = document.getElementById("navListClone"+id).clientWidth;
	var d_width = 200;
    var d_height = document.getElementById("navListClone"+id).clientHeight;
    if(wx < d_left || wy<d_top || wx > (d_left + d_width) || wy > (d_top + d_height)){
	    //不在内
	    return false;
	}else{
	    return true;
	}
}
// 写cookie
function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
    var expires = new Date();
    expires.setTime(expires.getTime() + seconds);
    expires = seconds ? expires.toGMTString() : 0;
    document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
}


//ie9以上美化滚动条
function perfectScroll(dom,type) {
    var action = type||"";
    dom.perfectScrollbar(action);
}
