// 修复ie8的indexof兼容问题
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function(elt /*, from*/ ) {
        var len = this.length >>> 0;
        var from = Number(arguments[1]) || 0;
        from = (from < 0) ?
            Math.ceil(from) :
            Math.floor(from);
        if (from < 0)
            from += len;
        for (; from < len; from++) {
            if (from in this &&
                this[from] === elt)
                return from;
        }
        return -1;
    };
}
$(function() {
    setHeight();
    getMenus();
    addPmenu("#tabs-panel");
    //绑定个人消息按钮显示事件
    loadPersonalMessage();
    queryUnReadMessageAmount(); //获取未读消息数量
    $('#addMessageDialog').sendMsg({ area: ['70%', '70%'] });

    //主动释放 5秒一次
    setInterval(function() {
        if (navigator.userAgent.indexOf('MSIE') >= 0) {
            if (CollectGarbage) {
                CollectGarbage(); //IE 特有 释放内存
            }
        }
    }, 5000);
    $('.square').hide();
});
/**
 * 加载个人消息并更新dom
 */
function loadPersonalMessage() {
    $.ajax({
        url: "portal/getUnReadMessageList?o="+Math.random()+"&_notUpdateSession=true",
        type: 'get',
        dataType: 'json',
        quiet: true,
        success: function(r) {
            if (r.flag == 'success') {
                var html = '';
                var data = r.list;
                for (var i = 0; i < data.length; i++) {
                    html += '<li title="' + data[i].title + '" data-id="' + data[i].id + '" data-broadcastFlag="' + data[i].broadcastFlag + '" onclick="readPersonalMessage(this)" rel="' + data[i].urlAddress + '">' + data[i].title + '</li>';
                }
                $('#personalMessageUl').html(html);
            } else {
                layer.alert('获取失败！' + r.data, {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                });
            }
        }
    });
}

/**
 * 获取本人未读消息数量
 */
function queryUnReadMessageAmount() {
    $.ajax({
        url: "portal/getUnReadMessageCount?o="+Math.random()+"&_notUpdateSession=true",
        // type: 'post',
        quiet: true,
        success: function(r) {
            if (r.flag == 'success') {
                var data = r.count;
                if (data > 99) {
                    data = 99;
                }
                if (data > 0) {
                    //                    $('#unreadMessage').html('<div class="msg-tip"><span class="text">'+data+'</span></div>');
                	$('#unreadMessage').show();
                	$('#unreadMessage').text(data);
                } else {
                	$('#unreadMessage').hide();
                    $('#unreadMessage').text('');
                }
            } else {
                layer.alert('当前会话已失效，请重新登录系统.', {icon: 7,title : '提示',area: ['400px', ''], closeBtn: 0}, function(index){
                    top.location.href="login";
                    layer.close(index);
                });
            }
        }
    });
}

/**
 * 独立添加tab标签
 * @param {string} title 标签名
 * @param {string} url   地址链接
 * @param {boolean} isRefresh 是否用新url刷新页面
 */
function addTab(title, url, isRefresh) {
    var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
    if (!exist && url != undefined) {
        $('#tabs-panel').tabs({
            onAdd:function(title,index){
                var target = this;
                //获取当前添加的tab并增加title属性
                var currentTab = $(target).tabs('select', title).find(".tabs-selected").find("span.tabs-title");
                if(currentTab != null && currentTab != '' && currentTab != undefined){
                    currentTab.attr("title",title);
                }
        }
        });
        $('#tabs-panel').tabs('add', {
            title: title,
            content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
            closable: true
        });
    } else {
        var tab = $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
        //是否用新url刷新
        if(isRefresh){
        	tab.tabs("getTab", title).find('iframe').attr('src', url);
        } else {
        	var nowurl = tab.tabs("getTab", title).find('iframe').attr('src');
        	tab.tabs("getTab", title).find('iframe').attr('src', nowurl);
        }
    }
}

function getMenus() {
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random() * 16 | 0,
            v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
    $.ajax({
        url: 'console/' + userId + '/indexmenu?jid=' + uuid,
        type: 'get',
        dataType: 'json',
        success: function(r) {
            drowFirstMenu(r, $('#navbar'));
            //drows[0].call(drows,r,$('#navbar'))
            uiPath();
            initHeadMenu();
            $(window).on('resize', function() {
                initHeadMenu();
            });
            $.each($(".dropdown-menu"), function(key, elment){
            	//加的20是div上下padding的和
            	var divHeight = $(elment).height() + 20;
            	$(elment).attr("divheight",divHeight);
            });
        }
    });
}
var _tempDiv= $('<div/>');

//绘制一级菜单
var drowFirstMenu = function(array, $parent) {
    var $ul = $('<ul></ul>');
    var _self = this;
    $.each(array, function(i, menu) {
        var $a = $('<a href="javascript:void(0);" class="dropdown"></a>');
        /* var active='';
         if(i===0){
             active=' class="on"';
         }*/
        var menuIcon = menu.icon;
        if(menuIcon == null || menuIcon == ""){
        	menuIcon = "icon iconfont icon-menu2";
        }
        var $li = $('<li></li>');
        var caret = '';
        if (!menu.isleaf) { //不是叶子节点
            caret = '<i class="caret"></i>';
        }
        //一级菜单名称显示最多9个字
        var _preFirstMenuName = menu.name;
        var _newFirstMenuName = (_preFirstMenuName.length > 9) ? _preFirstMenuName.substr(0,9) + "..." : _preFirstMenuName;

        $('<span class="taburl" rel="' + menu.url + '" title="' +  _tempDiv.html(menu.name).text() + '">' + _newFirstMenuName + caret + '</span>').appendTo($li);
        if (menu.children.length > 0) {
            drowSecendMenu(menu.children, $li);
            //_self[1].call(_self,menu.children,$li);
        }
        $($li).appendTo($a);
        $a.appendTo($ul);


    });
    $ul.appendTo($parent);
};
//绘制二级菜单
var drowSecendMenu = function(array, $parent) {
    //+(array.length>=2?2:1)
    var $div = $('<div class="dropdown-menu"></div>');
    var $ul = $('<ul></ul>');
    var $ul1 = $('<ul></ul>');
    var $ul2 = $('<ul></ul>');
    var _self = this;
    $.each(array, function(i, menu) {
    	 var menuIcon = menu.icon;
         if(menuIcon == null || menuIcon == ""){
         	menuIcon = "icon icon-point";
         }
        //二级菜单名称显示最多7个字
        var _preSecMenuName = menu.name;
        var _newSecMenuName = (_preSecMenuName.length > 7) ? _preSecMenuName.substr(0,7) + "..." : _preSecMenuName;

        var $li = $('<li></li>');
        var $div = $('<div class="submenu"></div>');
        var $menu = $('<div class="subtitle taburl" openType="' + menu.openType + '" rel="' + menu.url + '" title="' +_tempDiv.html(menu.name).text() + '"><i class="'+menuIcon+'"></i>' + _newSecMenuName + '</div>');
        $menu.appendTo($div);
        if (menu.children.length > 0) {
            drowThirdMenu(menu.children, $div);
            //_self[1].call(_self,menu.children,$div);
        }

        $div.appendTo($li);
        // $li.appendTo($ul);
        if (i % 3 == 0) {
            $li.appendTo($ul);
        } else if (i % 3 == 1) {
            $li.appendTo($ul1);
        } else {
            $li.appendTo($ul2);
        }
    });
    $ul.appendTo($div);
    $ul1.appendTo($div);
    $ul2.appendTo($div);
    $div.appendTo($parent);
};

var drowThirdMenu = function(array, $parent) {
    var $ul = $('<ul></ul>');
    // var $ul1=$('<ul></ul>');
    //三级菜单名称显示最多8个字
    var _preThirdMenuName = '';
    var _newThirdMenuName = '';
    $.each(array, function(i, menu) {
        _preThirdMenuName = menu.name;
        _newThirdMenuName = (_preThirdMenuName.length > 8) ? _preThirdMenuName.substr(0,8) + "..." : _preThirdMenuName;
        //if(i%2==0){
        $('<li class="afont taburl" openType="' + menu.openType + '" rel="' + menu.url + '" title="' +  _tempDiv.html(menu.name).text() + '">' + _tempDiv.html(_newThirdMenuName).text() + '</li>').appendTo($ul);
        //}else{
        // $('<li class="afont taburl">&nbsp;&nbsp;&nbsp;</li>').appendTo($ul1);
        //}
    });
    $ul.appendTo($parent);
    //$ul1.appendTo($parent);
};

var drows = [drowFirstMenu, drowSecendMenu, drowThirdMenu];

function init() {
    //setHeight();
    //等画完菜单 在执行
    /* uiPath();
     initHeadMenu();
     $(window).on('resize',function(){
         initHeadMenu();
     });*/
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
//ie9以上美化滚动条
function perfectScroll(dom,type) {
    var action = type||"";
    dom.perfectScrollbar(action);
}
function initHeadMenu(update) {
    $('.header .navbar .dropdown-menu').each(function() {
        var col = $(this).data('col') || $(this).find('>ul').length || 2,
            menuWidth = col * 190 + col * 1,
            bodyWidth = $('body').innerWidth(),
            menuMaxHeight = $('body').innerHeight()-50,//处理菜单太多时整个屏幕出现滚动条，菜单区域最大高度，取屏幕高度减去头部高度
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
            //当二级菜单区域高度大于页面最大展示菜单高度时设置菜单区域高度增加滚动条
            if($(this).height()>menuMaxHeight){
            	$(this).parent().css('width', $(this).parent().width()+50);
            	$(this).parent().css('height', menuMaxHeight-50);
            	$(this).parent().css('overflow', "auto");
//            	perfectScroll($(this).parent());
            }else{
            	var divHeight = $(this).parent().attr("divheight");
        		$(this).parent().css('height', divHeight);
            	$(this).parent().css('overflow', "hidden");
            }
            
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
            var title = $(this).attr("title"),
                url = $(this).attr("rel");
            var openType = $(this).attr("openType");
            if(openType == '_blank' && url && url != "null"){
                openBlank(title,url);
            } else if(openType == '_top' && url && url != "null"){
                openTop(title,url);
            } else if(openType == '_self' && url && url != "null"){
                openSelf(title,url);
            } else {// default mainframe
                //tab标题长度大于8个字符,截取前8个,后面的显示为...
                var preTitle = title;
                if(title != null && title != '' && title != undefined ){
                    if(title.length > 8){
                        title = title.substr(0,8) + "...";
                    }
                }
                var exist = $('#tabs-panel').tabs('exists', title); //判断是否存在tabs选项卡了，返回false或true
                if (!exist && url && url != "null") {
                    var noclose = ($(this).data('noclose')) ? false : true;
                    $('#tabs-panel').tabs('add', {
                        title: title,
                        content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                        closable: noclose
                    });
                } else {
                    var tab = $('#tabs-panel').tabs('select', title); //匹配到title，就显示这个窗口
                    if(tab.tabs("getTab", title)){
                        var nowurl = tab.tabs("getTab", title).find('iframe').attr('src');
                        tab.tabs("getTab", title).find('iframe').attr('src', nowurl);
                    }
                }
                //获取当前添加的tab并增加title属性
                var currentTab = $('#tabs-panel').tabs('select', title).find(".tabs-selected").find("span.tabs-title");
                if(currentTab != null && currentTab != '' && currentTab != undefined){
                    currentTab.attr("title",preTitle);
                }
            }
        });
    }

}
//打开方式:top
function openTop(title,url){
    window.open(url, '_blank');
}
//打开方式:blank
function openBlank(title,url){
    window.open(url, '_blank');
}
//打开方式:self
function openSelf(title,url){
    window.open(url,'_self');
}
// 注销
function logout(path) {
    layer.confirm('确认要离开系统吗？', {
        title: '提示',
        icon: 3,
        closeBtn : 0,
        area: ['400px', ''],
        btn: ['确定', '取消'] //按钮
    }, function() {
        window.location = path + 'platform/admin/logout';
    }, function() {
        //点击取消
    });
}
//打开用户多组织身份切换界面
function openChangeMoreOrgDailog() {
    layer.open({
        type: 2,
        area: ['430px', '200px'],
        title: '切换身份',
        skin: 'bs-modal',
        maxmin: false,
        closeBtn : 0,
        content: "userChangeMultipleIdentity/getChangeUserLoginOrgWeb",
        btn: ['确定', '取消'],
        yes: function(index, layero) {
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var orgId = iframeWin.getOrgId();
            var deptId = iframeWin.getDeptId();
            var currentOrgId = iframeWin.getCurrentOrgId();
            if (orgId == currentOrgId) {
                layer.alert('当前身份已是【' + iframeWin.getCurrentOrgName() + '】', {
                    title: '提示',
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0
                });
                return;
            }
            layer.confirm('确认要切换当前身份吗？', {
                title: '提示',
                icon: 3,
                area: ['400px', ''],
                btn: ['确定', '取消'] //按钮
            }, function(index) {
                changeUserLoginDeptEvent(deptId, orgId);
                layer.close(index);
            }, function() {
                //点击取消
            });
        }
    });
}
//切换当前登陆用户身份
function changeUserLoginDeptEvent(deptId, orgId) {
    $.ajax({
        url: "userChangeMultipleIdentity/changeUserLoginOrg",
        type: 'POST',
        dataType: 'text',
        data: {
            deptId: deptId,
            orgId: orgId
        },
        success: function(r) {
            if(r == 'success') {
                window.top.location = window.top.location;
            } else {
                layer.alert(r, {icon: 7});
            }
        },
        error: function(r) {
            alert('error');
        }
    });
}

/**
 * 打开更多消息页
 */
function moreMessage() {
    addTab('我的消息', 'msystem/sysmsg/sysMsgController/toSysMsgManage');
}
/**
 * 读个人消息
 * @param obj
 */
function readPersonalMessage(obj) {
    var id = $(obj).attr('data-id');
    var broadcastFlag = $(obj).attr('data-broadcastFlag');
    var url = $(obj).attr('rel');

    $(obj).detailMsg({
        formid: id,
        url: url,
        area: ['60%', '80%'],
        success: function(layero, index) {
            $.ajax({
                url: "portal/readMessage",
                type: 'get',
                dataType: 'json',
                data: {
                    id: id,
                    broadcastFlag: broadcastFlag
                },
                quiet: true,
                success: function(r) {
                    queryUnReadMessageAmount(); //读消息后，刷新数量
                    loadPersonalMessage();//加载消息列表
                }
            });
        }
    });
}