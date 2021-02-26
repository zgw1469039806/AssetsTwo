$(function() {
    init();
    $('.square').hide();
});


//控制菜单侧滑显示效果
$(document).ready(function() {
    var trigger = $('#beginMenu'),
        overlay = $('#overlay'),
        isClosed = false;
    $("#tabs-menu-panel").bind('mouseenter',function(e){
    	 hamburger_cross();
	});
    $("#overlay").bind('click',function(e){
   	    hamburger_cross();
	});
    $("#beginMenu").bind('click',function(e){
    	 //fixed:ie8下侧滑二级菜单消失后点击二级菜单区域无法关闭页面，由于beginMenu区域在二级菜单区域是200px的一个透明层
        if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
        	e = window.event || e; // 兼容IE7
    		obj = $(e.srcElement || e.target);
    		if (!$(obj).is(".sidebar-nav")) {
    			hamburger_cross();
    		}
        }
		
	});
    function hamburger_cross() {
        if (isClosed == true) {
            overlay.hide();
            isClosed = false;
            $('#tabs-menu-panel').removeClass('all-menu-selected');
        } else {
        	trigger.show();
            overlay.show();
            isClosed = true;
            $('#tabs-menu-panel').addClass("all-menu-selected");
            perfectScroll($('.navList'), { railalign: "left" });
            setTimeout(function(){
            	$("div[id*='ascrail']").css("left","0");
            },1000);
        	
        }
        $('#wrapper').toggleClass('toggled');
    }
});   


function init() {
    setHeight();
    leftMenuEvent();
    // 首页标签加子菜单
    $('#tabs-panel').tabs({
        onUpdate: function() {
            if (!$('#indexMenu').hasClass('menu')) {
                addSubMenu(0, 'index');
            }
        }
    });
    
    addPmenu("#tabs-panel");

    
    perfectScroll($('.tabs-panels'));
    perfectScroll($('.avic-smenu'));
    initPersonalMenu();//初始化常用区
    //兼容性问题，增加滚动条美化后，生成的滚动条区域会影响菜单区域滑过问题，将所有生成的美化滚动条初始化放最左边
    $("div[id*='ascrail']").css("left","0");
}
/**
 * 初始化个人菜单
 */
function initPersonalMenu() {
    //绑定常用菜单按钮显示事件
    $('#personalMenu').on('show.bs.dropdown', function () {
        loadPersonalMenu();
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

// 换主题或者换肤里的交互效果
function changeThemeOrSkin(dom) {
    //皮肤选择效果初始化
    dom.find('.changui-skins .preview').css('color', dom.find('.changui-skins li.on').css('backgroundColor'));
    dom.find('.changui-skins li').on('mouseenter', function() {
        var color = $(this).css('backgroundColor');
        $(this).parents('.changui-skins').find('.preview').css('color', color);
    }).on('mouseout', function() {
        var color = $(this).parent().find('li.on').css('backgroundColor');
        $(this).parents('.changui-skins').find('.preview').css('color', color);
    }).on('click', function() {
        $(this).addClass('on').siblings().removeClass('on');
    }).changeui({
        linkDom: "#theme",
        childDom: '.main'
    });
}

// 简单标签切换
function simpleTab(dom) {
    var tabsWidth = dom.find('.simple-tab-title li').length * dom.find('.simple-tab-title li').innerWidth(),
        movetabwidth = dom.find('.simple-tab-title').width() - tabsWidth;
    dom.find('.simple-movetab').css({
        width: movetabwidth
    });
    dom.find('.simple-tab-content').css({
        height: dom.parent().innerHeight() - dom.find('.simple-tab-title').innerHeight() - 1
    });
    dom.find('.simple-tab-title li').off().on('click', function(e) {
        e.stopPropagation();
        var index = $(this).index();
        $(this).addClass('on').siblings('li').removeClass('on');
        $(this)
            .parent().siblings('.simple-tab-content')
            .find('.simple-tab-item').eq(index)
            .addClass('on')
            .siblings('.simple-tab-item').removeClass('on');
    });
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
// 给标签加菜单
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
//            $('#tabs-panel').tabs('select', index);
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
             $('#tabs-panel').tabs('select', tagName).tabs('update', {
                     tab: tab,
                     options: {
                         title: tagName,
                         content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                     }
              });
        }
    });

    $('#' + index + "Menu li .setting").off().on('click', function(e) {
        var tagName = $(this).parents('.tabsSubMenu').data('for');
        e.stopPropagation();
    });
}

/**
 * 设置主体高度
 */
function setHeight() {
    var head = $('.header'),
        body = $('.mainBody'),
        main = $('.main');
    main.height($('body').innerHeight() - head.height());
    body.height($('body').innerHeight());
    $("#tabs-panel").height($('body').innerHeight() - head.height());
    $(window).on('resize', function() {
        main.height($('body').innerHeight() - head.height());
        body.height($('body').innerHeight());
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

//    $('.navList').wrap('<div class="navListClone"></div>');
    
    $('.navList').delegate('>ul>li', 'mouseenter', function() {
        var os = $(this).offset(),
//          w = $(this).innerWidth(),//由于li有一个左侧偏移3px导致获取的宽度少了3px，最终二级菜单和一级菜单有重叠
            w = $(this).parent().innerWidth(),
            ct = $(this).find('.subList');
        var winheight = $('body').innerHeight(),
            navlisttop = 0;

//        if (ct.length && os.top + ct.innerHeight() > winheight) {
//            ct.css({
//                height:'auto'
//            });
//            if(ct.height() < winheight){
//                if(os.top - ct.innerHeight() + $(this).innerHeight() <0 ){
//                    navlisttop = 0;
//                }else{
//                    navlisttop = os.top - ct.innerHeight() + $(this).innerHeight();
//                }
//            }else if(ct.height() == winheight){
//                navlisttop = 0;
//            }else{
//                ct.css({
//                    height:winheight -40,
//                    overflowY:'auto',
//                    overflowX:'hidden'
//                });
//                navlisttop = 0;
//                ct.css({
//                    left: w,
//                    top: navlisttop
//                });
//            }
//
//            ct.css({
//                left: w,
//                top: navlisttop,
//                bottom: 'inherit'
//            });
//        } else {
//            ct.css({
//                top: os.top,
//                left: w,
//                bottom: 'inherit'
//            });
//        }
        
        var topheight = 50;
        winheight = winheight - topheight;//减去顶栏高度
        if (ct.length && os.top-topheight + ct.innerHeight() > winheight) {
            ct.css({
                height:'auto'
            });
            if(ct.height() < winheight){
                if(os.top - topheight - ct.innerHeight() + $(this).innerHeight() <0 ){
                    navlisttop = topheight;
                }else{
                    navlisttop = os.top  - ct.innerHeight() + $(this).innerHeight();
                }

                ct.removeClass('subMenu'); 
            }else if(ct.height() == winheight){
                navlisttop = topheight;
            }else{
                ct.css({
                    height:winheight,
                    overflowY:'auto',
                    overflowX:'hidden'
                });
                navlisttop = topheight;
                ct.css({
                    left: w,
                    top: navlisttop
                });
            }

            ct.css({
                left: w,
                top: navlisttop,
                bottom: 'inherit'
            });
        } else {
            ct.css({
                top: os.top,
                left: w,
                bottom: 'inherit'
            });
            ct.removeClass('subMenu'); 
        }

    });
}

// 写cookie
function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
    var expires = new Date();
    expires.setTime(expires.getTime() + seconds);
    expires = seconds ? expires.toGMTString() : 0;
    document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
}

// ie9以上美化滚动条
function perfectScroll(dom, type) {
    var action = type || "";
    dom.perfectScrollbar(action);
}