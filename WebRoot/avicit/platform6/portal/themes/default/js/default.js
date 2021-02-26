$(function() {
    init();
});

function init() {
    setHeight();
    uiPath();
    setTimeout(function(){initHeadMenu();},300);
    $('#tabs-panel').tabs({
        onUpdate: function() {
            if (!$('#indexMenu').hasClass('menu')) {
                addSubMenu(0, 'index');
            }
        }
    });
    headSearch();
    addPmenu("#tabs-panel");
    initPersonalMenu();//初始化常用区
    $('.dropdown-menu').unbind('click');
    setTimeout(function() {
		//针对logo图片太大时菜单宽度计算时logo区域没有，logo加载完成后会将菜单整体向右挤出
		if ($(".logo").width() == 0) {
			initHeadMenuWidth(110);
			$('.square').hide();
		} else {
			initHeadMenuWidth(180);
			$('.square').hide();
		}
	}, 500);
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
                    if ($(e.target).hasClass('tabs-closable')) {
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
 * 设置主体高度
 */
function setHeight() {
    var head = $('.header'),
        body = $('.bodyCont');
    body.height($('body').innerHeight() - head.height());
    $(window).on('resize', function() {
        body.height($('body').innerHeight() - head.height());
    });
}

/**
 * 初始化皮肤选择按钮
 */
function uiPath() {
    $('.PathItem .item').changeui({
        linkDom: '#theme',
        childDom: '#tabs-panel'
    });
    $('#PathMenu>div').on('click', function() {
        PathRun();
    });
}

/**
 * 头部菜单下拉效果初始化
 */
var initHeadMenuTimer;
function initHeadMenu(update) {
    $('.header .navbar .dropdown-menu').each(function() {
        var col = $(this).data('col') || $(this).find('>ul').length || 2,
            menuWidth = col * 190 + col * 1,
            bodyWidth = $('body').innerWidth(),
            parOffset = $(this).parents('.dropdown').offset();
        if (menuWidth + parOffset.left <= bodyWidth) {
            $(this).css({
                left: 0,
                right: 'inherit',
                width: menuWidth
            });
        } else if (menuWidth + parOffset.left > bodyWidth && menuWidth - (parOffset.left + $(this).parents('.dropdown').width()) <= 0 && menuWidth < bodyWidth) {
            $(this).css({
                left: 'inherit',
                right: 0,
                width: menuWidth
            });
        } else {
            $(this).css({
                left: 0 - parOffset.left,
                width: bodyWidth
            });
        }
        var eachCol = 190;
        if(bodyWidth < menuWidth){
            eachCol = (bodyWidth-col)/col;
        }
        var childMaxHeight = 0;

        $(this).find('>ul').removeAttr('style').each(function() {
            var marginLeft = ($(this).siblings("ul").length) ? -1 : 0;
            if ($(this).index() === 0) {
                $(this).css({
                    'width': eachCol
                });
            }
            if ($(this).index() !== 0) $(this).css({
                'borderRight': 0,
                'width': eachCol,
                'borderLeftWidth': 1,
                'marginLeft': marginLeft
            });
        });
        $(this).find('>ul').each(function() {
            var childHeight = $(this).parent().height();
            if (childHeight > childMaxHeight) {
                childMaxHeight = childHeight;
            }
            $(this).siblings('ul').css('height', childMaxHeight);
        });
    });
    clearTimeout(initHeadMenuTimer);
    $(window).on('resize',function(){
        clearTimeout(initHeadMenuTimer);
        initHeadMenuTimer = setTimeout(function(){
            initHeadMenu('update');
        },300);
    });
    if (!update && update!=='update') {
        //打开标签
        $('.dropdown').delegate(".taburl", 'click', function(e) {
            e.preventDefault();
            var title = $(this).text(),
                url = $(this).attr("rel"),
                exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
            if (!exist && url != undefined) {
                var noclose = ($(this).data('noclose')) ? false : true;
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
                    }
                });
                $('#tabs-panel').tabs('add', {
                    title: title,
                    content: ' ',
                    closable: noclose
                });
            } else {
                $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
            }
        });
    }

}

function headSearch(){
    $('.head-search').on('click',function(){
        $(this).parents('.search').addClass("open");
        $(this).parent().find('input[name="keyword"]').focus().on('blur',function(){
            $(this).parents('.search').removeClass("open");
        })
    });
}

// 给标签加菜单
function addSubMenu(index, id) {
    var p = $('#tabs-panel').tabs('getTab', index);
    var mb = p.panel('options').tab.find('a.tabs-inner');
    initSubMenu(id);
    mb.menubutton({
        menu: '#' + id + 'Menu'
    }).on('click', function(e) {
        $('#tabs-panel').tabs('select', index);
    });
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
}
//ie9以上美化滚动条
function perfectScroll(dom,type) {
    var action = type||"";
    dom.perfectScrollbar(action);
}

// 头部菜单左右滚动
function initHeadMenuWidth(leftWidth) {
    var movex = 0;
    if(leftWidth == null || leftWidth == ''){
    	leftWidth = 0;
    }

    function renden() {
    	
        var menu = $('.header .navbar');
        var lFixed = $('.header .logoDom').width();
        var rFixed = $('.header .toolbar').offset().left+leftWidth;

        menu.removeAttr("style").find('.sbtn').remove();

        if (menu.innerWidth() + lFixed > rFixed) {
            var maxContent = 0;
            menu.find(">ul>a").each(function() {
                maxContent += $(this).outerWidth() + 4;
            });
            menu.css({
                width: rFixed - lFixed - 30,
                overflow: 'hidden'
            }).find(">ul").css({
                positon: 'relative',
                width: maxContent
            });

            var menufix = $('.header .navbar'),
                eW = menufix.width() - 60,
                menuUl = $('.header .navbar>ul');
            var leftBtn = $('<div class="sbtn icon icon-xiangzuojiantou"></div>')
                .css({
                    left: 0
                })
                .on('mouseup', function() {
                    movex += eW / 2;
                    if (movex >= 0) {
                        movex = 0;
                        $(this).hide();
                    } else {
                        $(this).show();
                    }
                    menuUl.animate({
                        "left": movex
                    }, 100);
                    $(this).parent().find('.icon-xiangyoujiantou').show();
                });
            if (movex >= 0) {
                leftBtn.hide();
            }
            var rightBtn = $('<div class="sbtn r icon icon-xiangyoujiantou"></div>')
                .css({
                    right: 0
                })
                .on('mouseup', function() {
                    if (menuUl.width() - Math.abs(movex - eW) < eW) {
                        movex -= (menuUl.width() - Math.abs(movex - eW));
                        $(this).hide();
                    } else {
                        movex -= eW / 2;
                        $(this).show();
                    }
                    menuUl.animate({
                        "left": movex
                    }, 100);
                    $(this).parent().find('.icon-xiangzuojiantou').show();
                });
            menu.append(leftBtn);
            menu.append(rightBtn);

            var headmenuClone, clonedom2;

            menu.find('.dropdown').each(function() {
                var that = $(this);
                $(this).off().on('mouseenter', function() {
                    var tpos = $(this).offset();
                    $(".headmenuClone").remove();
                    var sm = $(this).find('.dropdown-menu');
                    if (sm.length) {
                        clonedom2 = sm.clone(true);
                        $("body").append(clonedom2);
                        clonedom2.wrap('<div class="navbar headmenuClone"></div>');
                        headmenuClone = $('.headmenuClone');

                        var col = clonedom2.data('col') || clonedom2.find('>ul').length || 2,
                            menuWidth = col * 190 + col * 1,
                            bodyWidth = $('body').innerWidth(),
                            parOffset = tpos;
                        if (menuWidth + parOffset.left <= bodyWidth) {
                            clonedom2.css({
                                left: parOffset.left,
                                right: 'inherit',
                                top: $('.header').height(),
                                width: menuWidth
                            });
                        } else if (menuWidth + parOffset.left > bodyWidth && menuWidth - (parOffset.left + that.width()) <= 0 && menuWidth < bodyWidth) {
                            clonedom2.css({
                                left: 'inherit',
                                right: 0,
                                top: $('.header').height(),
                                width: menuWidth
                            });
                        } else {
                            clonedom2.css({
                                left: 0,
                                top: $('.header').height(),
                                width: bodyWidth
                            });
                        }

                        clonedom2.delegate(".taburl", 'click', function(e) {
                            e.preventDefault();
//                            var title = $(this).text();
                            var title = $(this).attr("title");
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
                        clonedom2.on('mouseleave', function() {
                            headmenuClone.remove();
                            clonedom2 = null;
                            headmenuClone = null;
                        });
                    }
                });

            });
        }
    }
    renden();
    $(window).on('resize.headmenu', function() {
        renden();
    });
}
