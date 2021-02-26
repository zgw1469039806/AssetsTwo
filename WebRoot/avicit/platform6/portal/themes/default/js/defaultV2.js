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
                    
                    /*if (!$(e.target).parents().is('.navListClone1') && !$(e.target).is('.navListClone1') 
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
                    }*/
                    
                });
            menu.append(leftBtn);
            menu.append(rightBtn);
        }
        
        var headmenuClone, clonedom2;
		var navListClone, clonedom;
		
        menu.find('.dropdown').each(function() {
            var that = $(this);
            $(this).off().on('mouseenter', function() {
            	var ct = $(this).find(".subList");
            	os = $(this).offset(),
                // w = $(this).innerWidth(),
                w = os.left,
                that = $(this);
                
                $(".navListClone1").remove();
		        clonedom = ct.clone(true);
		        $(this).addClass('on').siblings().removeClass('on');
		        if (!ct.length) return;
		        $(document).off('mousemove.navclone');
		        clonedom.find('.taburl').on('click', function(e) {
		            e.stopPropagation();
		            e.preventDefault();
//		            var title = $(this).text();
		            var title = $(this).attr("title");
		            var url = $(this).attr("rel");
		            if(typeof(url) == 'undefined' || url == '')return;
					if(url.indexOf("paraSource") != -1){
						url = url +"&currentSkins="+currentSkins+ "&orgId="+currentOrgIdentity + "&deptId="+deptId;
					}
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
                
                //判断与父级菜单平行向下时能否显示全
		        if (navListClone.length && os.top + navListClone.innerHeight() > $('body').innerHeight()) {
		        	//显示不全时判断与父级菜单平行向上时能否显示的全
		        	if(navListClone.length && os.top +  $(this).innerHeight()< navListClone.innerHeight()){
		        		//显示不全时判断上边框与浏览器齐平时能否显示全
		        		 if(navListClone.innerHeight() > $('body').innerHeight()){ 
		        			 //显示不全满屏显示
		        			 navListClone.css({
		    	                 left: w,
		    	                 zIndex:11,
		    	                 top: 50,
		    	                 height:$('body').innerHeight(),
		    	                 'overflow-y':'auto'
		    	             });
		        		 }else{
		        			 navListClone.css({
		    	                 left: w,
		    	                 zIndex:11,
		    	                 top: 50
		    	             });
		        		 }
		        	}else{
		                navListClone.css({
		                    left: w,
		                    zIndex:11,
		                    //top: os.top - navListClone.innerHeight() + $(this).innerHeight()
		                    top:50
		                });
		        	}
		        } else {
		            navListClone.css({
		                top: 50,
		                left: w,
		                zIndex:11
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
            	
            }).on('mouseleave', function() {
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
            
        });
    }
    renden();
    $(window).on('resize.headmenu', function() {
        renden();
    });
    
    $('.navbar>ul>a>li>.subList>.subChild').mouseenter(function(){
    	cloneChild(this,2);
    });

    $('.navbar>ul>a>li>.subList>.subChild>ul>.subChild').mouseenter(function(){
    	cloneChild(this,3);
    });
    $('.navbar>ul>a>li>.subList>.subChild>ul>.subChild>ul>.subChild').mouseenter(function(){
    	cloneChild(this,4);
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
	                 zIndex:11,
	                 top: 0,
	                 height:$('body').innerHeight(),
	                 'overflow-y':'auto'
	             });
    		 }else{
    			 navListClone2.css({
	                 left: w,
	                 zIndex:11,
	                 top: 0
	             });
    		 }
    	}else{
            navListClone2.css({
                left: w,
                zIndex:11,
                top: os.top - navListClone2.innerHeight() + 38
            });
    	}
    } else {
        navListClone2.css({
            top: os.top,
            left: w,
            zIndex:11
//            ,
//            bottom: 'inherit'
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
	var d_width = 180;
    var d_height = document.getElementById("navListClone"+id).clientHeight;
    if(wx < d_left || wy<d_top || wx > (d_left + d_width) || wy > (d_top + d_height)){
	    //不在内
	    return false;
	}else{
	    return true;
	}
}

