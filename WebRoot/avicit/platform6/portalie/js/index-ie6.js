$(function() {
    init();
});

function init() {
    setHeight();
    hideLeft();
    leftMenuEvent();

    // 首页标签加子菜单
    $('#tabs-panel').tabs({
        onUpdate: function() {
            if ($('#indexMenu').hasClass('menu')) return;
            addSubMenu(0, "index");
        }
    });

    addPmenu("#tabs-panel");
    userSwich();

    // 打开添加常用窗口
    $('.addFrequently').on('click', function(e) {
        layer.open({
            title: '新增栏目',
            skin: 'index-model',
            area: ['370px', '580px'],
            content: $('#addFrequently').html(),
            success: function(dom) {},
            btn: ['确认', '取消'],
            yes: function(index, layero) {
                //按钮【确认】的回调
            },
            btn2: function(index, layero) {
                //按钮【取消】的回调

                //return false; //开启该代码可禁止点击该按钮关闭
            }
        });
    });

}

/**
 * 设置主体高度
 */
function setHeight() {
    var head = $('.header'),
        body = $('.mainBody'),
        main = $('.main');
    main.height($('body').innerHeight() - head.height() - 1);
    body.height($('body').innerHeight());
    $("#tabs-panel").height($('body').innerHeight() - head.height());
    $('.bodyCont').css('width', $('body').innerWidth() - 200);
    $(window).on('resize', function() {
        main.height($('body').innerHeight() - head.height() - 1);
        body.height($('body').innerHeight());
        $('.bodyCont').css('width', $('body').innerWidth() - 200);
    });
}

/**
 * 缩小左侧导航
 */
function hideLeft() {
    var bar = $('.leftAside'),
        btn = $('.hideLeftMenu'),
        mainWidth = 0;
    btn.on('click', function() {
        bar.toggleClass("close");
        if (bar.hasClass("close")) {
            mainWidth = $('body').innerWidth() - 70;
            console.log(mainWidth)
            $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
            $('.mainBody .bodyCont').css('paddingLeft', 70);
        } else {
            mainWidth = $('body').innerWidth() - 200;
            $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
            $('.mainBody .bodyCont').css('paddingLeft', 200);
        }
    });
}

// 左侧菜单事件
function leftMenuEvent() {
    var navList = $('.navList');
    $('.navList .subList').each(function() {
        var col = $(this).data('col');
        if (col) {
            $(this).css({
                width: col * 180
            });
        }
    });
    $('.navList').delegate(".taburl", 'click', function(e) {
        e.stopPropagation();
        e.preventDefault();
        var title = $(this).text(),
            url = $(this).attr("rel"),
            exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
        if (!exist && url != undefined) {
            $('#tabs-panel').tabs('add', {
                title: title,
                content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                closable: true
            });
        } else {
            $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
        }
    });

    var clonedom, cloneDomArea, cloneDomA, cloneTimer;

    cloneDomArea = document.createElement("div");
    cloneDomArea.id = 'cloneDomArea';
    cloneDomArea.className = 'navListClone';
    document.body.appendChild(cloneDomArea);

    cloneDomA = $('#cloneDomArea');

    $('#navList').delegate('>ul>li', 'mouseenter', function(e) {
        e.stopPropagation();
        $(document).off('mousemove.navclone');
        $(this).addClass('onhover').siblings('li').removeClass('onhover');
        cloneDomA.empty().hide();
        var ct = $(this).find('.subList'),
            os = $(this).offset(),
            w = $(this).innerWidth(),
            that = $(this);
        if (!ct.length) return;

        clearTimeout(cloneTimer);

        cloneTimer = setTimeout(function() {
            clonedom = ct.clone().get(0);

            cloneDomA.empty();

            cloneDomArea.appendChild(clonedom);

            cloneDomA.find('.taburl').off().on('click', function(e) {
                e.stopPropagation();
                e.preventDefault();
                var title = $(this).text(),
                    url = $(this).attr("rel"),
                    exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
                if (!exist && url != undefined) {
                    $('#tabs-panel').tabs('add', {
                        title: title,
                        content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                        closable: true
                    });
                } else {
                    $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
                }
            });
            cloneDomA.css({
                visibility: 'hidden',
                position: 'absolute',
                top:0
            }).show();
            if (cloneDomA.length && os.top + cloneDomA.find('.subList').outerHeight() > $('body').innerHeight()) {
                cloneDomA.css({
                    position: 'absolute',
                    visibility: 'visible',
                    left: w - 1,
                    top: os.top - cloneDomA.find('.subList').outerHeight() + that.innerHeight()
                }).show();
            } else {
                cloneDomA.css({
                    position: 'absolute',
                    visibility: 'visible',
                    top: os.top,
                    left: w - 1,
                    bottom: 'inherit'
                }).show();
            }
            cloneDomA.off().on('mouseleave', function(e) {
                e.stopPropagation();
                cloneDomA.empty().hide();
                that.removeClass('onhover');
            });
        }, 200);


    }).delegate('>ul>li', 'mouseleave', function(e) {
        e.stopPropagation();
        var ct = $(this).find('.subList'),
            that = $(this);
        $(document).on('mousemove.navclone', function(d) {
            if (!$(d.target).parents().is('#cloneDomArea')) {
                cloneDomA.empty().hide();
                that.removeClass('onhover');
            }
        });
    });

    $('.navList').height($('body').innerHeight() - $('.leftAside .logoDom').height() - 2);

    $(window).on('resize', function() {
        setTimeout(function() {
            $('.navList').height($('body').innerHeight() - $('.leftAside .logoDom').height() - 2);
        }, 500);
    });


    // 翻页
    navListTurnPage(navList);
}

function navListTurnPage(dom){
    var eachHeight = dom.find('>ul>li').height(),
        maxHeight = dom.height(),
        num = dom.find('>ul>li').length;
    var turnDom = dom.find(".turn-dom");
    if(eachHeight*num > maxHeight){
        var turnUp = $('<div class="turnUp"><i class="icon white icon-jiantou-shang"></i></div>');
        var turnDown = $('<div class="turnDown"><i class="icon white icon-jiantou-xia"></i></div>');
        dom.append(turnUp);
        dom.append(turnDown);
        turnDown.on('click',function(e){
            e.stopPropagation();
            turnDom.css('top',parseInt(turnDom.css('top')) - eachHeight*3);
            if(maxHeight - parseInt(turnDom.css('top')) > turnDom.height()){
                turnDown.hide();
                turnUp.show();
            }else if(maxHeight - parseInt(turnDom.css('top')) < turnDom.height()){
                turnUp.show();
            }else{
                turnDown.show();
            }
        });
        turnUp.on('click',function(e){
            e.stopPropagation();
            turnDom.css('top',parseInt(turnDom.css('top')) + eachHeight*2);
            if(parseInt(turnDom.css('top')) >= 0){
                turnDom.css('top',0);
                turnUp.hide();
                turnDown.show();
            }else if(maxHeight - parseInt(turnDom.css('top')) < turnDom.height()){
                turnDown.show();
            }else if(parseInt(turnDom.css('top')) < 0){
                turnUp.show();
            }else{
                turnUp.hide();
            }
        });
    }
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
 * 独立添加tab标签
 * @param {string} title 标签名
 * @param {string} url   地址链接
 */
function addTab(title, url) {
    var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
    if (!exist && url != undefined) {
        $('#tabs-panel').tabs('add', {
            title: title,
            content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
            closable: true
        });
    } else {
        $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
    }
}

// 给标签加菜单
function addSubMenu(index, id) {
    var p = $('#tabs-panel').tabs('getTab', index);
    if (!p) return;
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

    $('#' + index + "Menu li .setting").off().on('click', function(e) {
        var tagName = $(this).parents('.tabsSubMenu').data('for');
        e.stopPropagation();
        alert("点击了" + tagName + "的设置");
    });
}

// 用户身份切换
function userSwich() {
    $('.rightTool').delegate('.userhead .switch', 'click', function(e) {
        e.stopPropagation();
        var dom = $(this).parents('.user-card').hide().siblings('.status-list').show().find('.cont');
    });
    $('.rightTool').delegate('.status-list .goback', 'click', function(e) {
        e.stopPropagation();
        $(this).parents('.status-list').hide().siblings('.user-card').show();
    });
    $('.rightTool').delegate('.status-list li', 'click', function(e) {
        e.stopPropagation();
        $(this).addClass('on').siblings('li').removeClass('on');
    });
    $('.rightTool').delegate('.status-list .ok-btn', 'click', function(e) {
        e.stopPropagation();
        var department = $('.rightTool .status-list li[data-department].on').data('department'),
            job = $('.rightTool .status-list li[data-job].on').data('job');
        par = $('.rightTool .status-list').siblings('.user-card');
        par.find('.department').text(department);
        par.find('.job').text(job);
        $('.rightTool .status-list').hide().siblings('.user-card').show();
    });
}