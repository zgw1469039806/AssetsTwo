$(function() {
      setHeight();
      leftMenuEventDrawer();
    var accordion = new Accordion($('#accordion'), false);
    perfectScrollDrawer($('.accordion'));

    initFirstMenuClickEvent();
    
    initHeadMenu();
    
    setLeftSideHeight();

    hideLeftDraw();
    
    initPersonalMenu();//初始化常用区
    
    addPmenu("#tabs-panel");

    setTimeout(function(){
        $(window).trigger('resize');
    },1000);
    $('.square').hide();
});

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
 * 缩小左侧导航
 */
function hideLeftDraw() {
    var btn2 = $('<div class="hideLeft out" style="display: none;left: -3px;"><i class="icon icon-xiangyoujiantou"></i></div>');
    $('.bodyCont').append(btn2);
    var bar = $('.leftAside'),
        btn = $('.hideLeft'),
        mainWidth;
    btn.on('click', function() {
        bar.toggleClass("close");
        if (bar.hasClass("close")) {
            perfectScrollDrawer($('.accordion'),'hide');
            mainWidth = $('body').innerWidth();
            btn.hide();
            btn2.show();
            setcookie('hideIndexLeft', 1);
            $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
        } else {
            mainWidth = $('body').innerWidth() - 200;
            setcookie('hideIndexLeft', 0);
            btn.show();
            btn2.hide();
            setTimeout(function() {
                $('#tabs-panel,#tabs-panel .tabs-header,#tabs-panel .tabs-wrap,#tabs-panel .tabs-panels,#tabs-panel .panel-htop,#tabs-panel .panel-body').css("width", mainWidth);
                perfectScrollDrawer($('.accordion'),'show');
            }, 300);
        }
    });
}


/**
 * 设置主体高度
 */
function setLeftSideHeight() {
    var head = $('.header'),
        leftAside = $('.leftAside');
    leftAside.height($('body').innerHeight() - head.height());
    $(window).on('resize.leftside', function() {
        leftAside.height($('body').innerHeight() - head.height());
    });
}

function initFirstMenuClickEvent(){
    $(".lt-list a").click(function(e){
        if($(this).attr('data')){
        	//加载成功后将 一级菜单设为选中
            $("a[name='firstMenus']").removeClass("select");
            $(this).addClass("select");
            $.ajax({
                url : 'portal/themes_simple',
                dataType : "html",
                data : {
                    id : $(this).attr('data')
                },
                type : "GET",
                success : function(msg) {
                    $('#accordion').html(msg);
                    //加载完成之后，重新初始化
                     var accordion = new Accordion($('#accordion'), false);
                     perfectScrollDrawer($('.accordion'));
                     
                     //oldHtml = $(".la-list > ul").html();
                     oldHtml = msg;
                }
            });
        }
    });
    
    $(".lt-list a li").click(function(e){
    	  $("a[name='firstMenus']").removeClass("select");
    });
    
}

// 左侧菜单事件
function leftMenuEventDrawer() {
    $('.accordion').delegate(".taburl", 'click', function(e) {
        e.stopPropagation();
        e.preventDefault();
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
    $('.accordion').delegate(".afont", 'click', function(e) {
        //三级菜单单击
    	$("li[name='thirdMenus']").removeClass("select");
    	$(e.target).addClass("select");
    });
    $('.accordion').height($('body').innerHeight());

    $(window).on('resize',function(){
        setTimeout(function(){
        	//菜单区域高度为左侧区域高度减去搜索框和扩展标题高度
        	var height = $('.leftAside .tips_box').height()+$('.leftAside .searchBox').height();
//            $('.accordion').height($('.leftAside').height()-$('.leftAside .logoDom').height()-height-2-45);
        	  $('.accordion').height($('.leftAside').height()-height-25);
            perfectScrollDrawer($('.accordion'),'update');
        },500);
    });

}

// ie9以上美化滚动条
function perfectScrollDrawer(dom,type) {
    var action = type||"";
    dom.perfectScrollbar(action);
}

/**
 * 头部菜单下拉效果初始化
 */
function initHeadMenu() {
    $('.header .lt-list .dropdown-menu').each(function() {
        var col = $(this).data('col') || $(this).find('>ul').length || 2,
            menuWidth = col * 190 + col * 1,
            bodyWidth = $('body').innerWidth(),
            parOffset = $(this).parents('.dropdown').offset();
        if (menuWidth + parOffset.left <= bodyWidth) {
            $(this).css("width", menuWidth);
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
        $(this).find('>ul').each(function() {
            var childMaxHeight = 0;
            childMaxHeight = $(this).parent().height();
            var marginLeft = ($(this).siblings("ul").length) ? -1 : 0;
            if ($(this).index() !== 0) $(this).css({
                'borderRight': 0,
                'height': childMaxHeight,
                'borderLeftWidth': 1,
                'marginLeft': marginLeft
            });
        });
    });

    //打开标签
    $('.dropdown').delegate(".taburl", 'click', function(e) {
        e.preventDefault();
        initMoreEvent($(this).parent('ul').prev().data('for'),$(this).data('for'));
        var title = $(this).text(),
            url = $(this).attr("rel"),
            exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
        if (!exist && url != undefined && url != '') {
            var noclose = ($(this).data('noclose'))?false:true;
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
/**
 * 头部菜单下拉效果初始化
 */
var initHeadMenuTimer;
function initHeadMenu(update) {
    $('.header .lt-list .dropdown-menu').each(function() {
        var col = $(this).data('col') || $(this).find('>ul').length || 2,
            menuWidth = col * 160 + col * 1,
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
        var eachCol = 160;
        if(bodyWidth < menuWidth){
            eachCol = (bodyWidth-col)/col;
        }
        var childMaxHeight = 0;
        $(this).find('>ul').removeAttr('style').each(function() {
            var marginLeft = ($(this).siblings("ul").length) ? -1 : 0;
            if($(this).index() === 0){
                $(this).css({
                    'width':eachCol
                });
            }
            if ($(this).index() !== 0) $(this).css({
                'borderRight': 0,
                'width':eachCol,
                'borderLeftWidth': 1,
                'marginLeft': marginLeft
            });
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
            e.stopPropagation();
//            initMoreEvent($(this).parent('ul').prev().data('for'),$(this).data('for'));//更新中点击事件处理
            initMoreEvent($(this).data('for'));//更多点击事件处理

//            var title = $(this).text(),
//                url = $(this).attr("rel"),
//                exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
//            if(!url) return;
//            if (!exist && url != undefined) {
//                var noclose = ($(this).data('noclose')) ? false : true;
//                $('#tabs-panel').tabs('add', {
//                    title: title,
//                    content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
//                    closable: noclose
//                });
//            } else {
//                $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
//            }
        });
    }

}
//更多中点击事件处理
function initMoreEvent(parentId,id){
    if(parentId){
        $.ajax({
            url : 'portal/themes_simple',
            dataType : "html",
            data : {
                id : parentId
            },
            type : "GET",
            success : function(msg) {
                $('#accordion').html(msg);
                //加载完成之后，重新初始化
                 var accordion = new Accordion($('#accordion'), false);
                 perfectScrollDrawer($('.accordion'));
                 $('#' + id).trigger('click');
                 selectMoreSubMenuEvent(id);
            }
        });
    }
}
//更多中点击事件处理
function initMoreEvent(id){
    if(id){
        $.ajax({
            url : 'portal/themes_simple',
            dataType : "html",
            data : {
                id : id
            },
            type : "GET",
            success : function(msg) {
                $('#accordion').html(msg);
                //加载完成之后，重新初始化
                 var accordion = new Accordion($('#accordion'), false);
                 perfectScrollDrawer($('.accordion'));
            }
        });
    }
}
function selectMoreSubMenuEvent(id){
    var title = $('#' + id).text();
    var url = $('#' + id).attr("rel");
    if(url){
        var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
        if (!exist) {
            var noclose = ($(this).data('noclose')) ? false : true;
            $('#tabs-panel').tabs('add', {
                title: title,
                content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                closable: noclose
            });
        } else {
            $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
        }
    } else {
        var next = $('#' + id).next();
        var url = next.find(":first-child").attr('rel');
        var title = next.find(":first-child").text();
        var exist = $('#tabs-panel').tabs('exists', title); 
        if (!exist) {
            var noclose = ($(this).data('noclose')) ? false : true;
            $('#tabs-panel').tabs('add', {
                title: title,
                content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                closable: noclose
            });
        } else {
            $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
        }
    }
}

var Accordion = function(el, multiple) {
    this.el = el || {};
    this.multiple = multiple || false;

    // Variables privadas
    var links = this.el.find('.link');
    // Evento
    links.on('click', { el: this.el, multiple: this.multiple }, this.dropdown);
};
Accordion.prototype.dropdown = function(e) {
    var $el = e.data.el;
    $this = $(this);
    if($(this).children().next()[0].className.indexOf("fa-chevron-down")!=-1){
    	if($this.next()[0].className=="menu-label menu-bg-red jump"){
    		$next = $this.next().next();
    	}else{
    		$next = $this.next()
    	}
    }else{
    	$next = $this.next().next();
    }
    $next.slideToggle();
    $this.parent().toggleClass('open').siblings().removeClass('open');
    if (!e.data.multiple) {
        $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
    }
    setTimeout(function(){
        perfectScrollDrawer($('.accordion'),'update');
    },500);
};

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
//ie9以上美化滚动条
function perfectScroll(dom,type) {
    var action = type||"";
    dom.perfectScrollbar(action);
}
// 写cookie
function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
    var expires = new Date();
    expires.setTime(expires.getTime() + seconds);
    expires = seconds ? expires.toGMTString() : 0;
    document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
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
