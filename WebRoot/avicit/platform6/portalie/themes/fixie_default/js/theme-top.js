$(function() {
    init();
});

function init() {
    setHeight();
    uiPath();
    setTimeout(function() { initHeadMenu() }, 300);

    $('#tabs-panel').tabs({
        onUpdate: function() {
            if (!$('#indexMenu').hasClass('menu')) {
                addSubMenu(0, 'index');
            }
        }
    });

    headSearch();

    initHeadMenuWidth();

    addPmenu("#tabs-panel");
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
                            color: '#ddd'
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
                            color: '#ddd'
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
                width: menuWidth+110
            });
        } else if (menuWidth + parOffset.left > bodyWidth && menuWidth - (parOffset.left + $(this).parents('.dropdown').width()) <= 0 && menuWidth < bodyWidth) {
            $(this).css({
                left: 'inherit',
                right: 0,
                width: menuWidth+110
            });
        } else {
            $(this).css({
                left: 0 - parOffset.left,
                width: bodyWidth
            });
        }
        var eachCol = 190;
        if (bodyWidth < menuWidth) {
            eachCol = (bodyWidth - col) / col;
        }
        var childMaxHeight = 0;
        $(this).find('>ul').removeAttr('style').each(function() {
            var childHeight = $(this).parent().height();
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
            if (childHeight > childMaxHeight) {
                childMaxHeight = childHeight;
            }
            $(this).siblings('ul').css('height', childMaxHeight);
        });
    });
    clearTimeout(initHeadMenuTimer);
    $(window).on('resize', function() {
        clearTimeout(initHeadMenuTimer);
        initHeadMenuTimer = setTimeout(function() {
            initHeadMenu('update');
        }, 300);
    });
    if (!update && update !== 'update') {
        //打开标签
        $('.dropdown').delegate(".taburl", 'click', function(e) {
            e.preventDefault();
            var title = $(this).text(),
                url = $(this).attr("rel"),
                exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
            if (!exist && url != undefined) {
                var noclose = ($(this).data('noclose')) ? false : true;
                $('#tabs-panel').tabs('add', {
                    title: title,
                    content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                    closable: noclose
                });
            } else {
                $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
            }
        });
    }

}

var hstimer;
function headSearch() {
    $('.head-search').on('click', function() {
        if($(this).parent().hasClass('opened') == false){
            $(this).parents('.search').addClass("opened");
            $(this).parent().find('input[name="keyword"]').off('blur,focus').focus().focus(function(e){
                e.stopPropagation();
                clearTimeout(hstimer);
            }).on('blur',function(e){
                e.stopPropagation();
                hstimer = setTimeout(function(){
                    $('.search').removeClass("opened");
                    $(".search .head-search").off('click.gosearch');
                },500);
            });
            $(".search .head-search").on('click.gosearch',function(e){
                execSearch();
            });
        }
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
    });
}

// 头部菜单左右滚动
function initHeadMenuWidth() {
    var movex = 0;

    function renden() {
        var menu = $('.header .navbar');
        var lFixed = $('.header .logoDom').width();
        var rFixed = $('.header .toolbar').offset().left;

        menu.removeAttr("style").find('.sbtn').remove();

        if (menu.innerWidth() + lFixed > rFixed) {
            var maxContent = 0;
            menu.find(">ul>.dropdown").each(function() {
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
            var leftBtn = $('<div class="sbtn icon white icon-jiantou-zuo"></div>')
                .css({
                    left: -1
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
                        "marginLeft": movex
                    }, 100);
                    $(this).parent().find('.icon-jiantou-you').show();
                });
            if (movex >= 0) {
                leftBtn.hide();
            }
            var rightBtn = $('<div class="sbtn r white icon icon-jiantou-you"></div>')
                .css({
                    right: -1
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
                        "marginLeft": movex
                    }, 100);
                    $(this).parent().find('.icon-jiantou-zuo').show();
                });
            menu.append(leftBtn);
            menu.append(rightBtn);
        }
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

                        // 判断ie6
                        if(!-[1,]&&!window.XMLHttpRequest){
                            menuWidth += 70;
                        }
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
                            var title = $(this).text(),
                                url = $(this).attr("rel"),
                                exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
                            if (!exist && url != undefined) {
                                var noclose = ($(this).data('noclose')) ? false : true;
                                $('#tabs-panel').tabs('add', {
                                    title: title,
                                    content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                                    closable: noclose
                                });
                            } else {
                                $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
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
    renden();
    $(window).off('resize.headmenu').on('resize.headmenu', function() {
        renden();
    });
}