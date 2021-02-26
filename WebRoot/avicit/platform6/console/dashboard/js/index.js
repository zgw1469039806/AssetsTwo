$(function() {
    init();
});

function init() {
    setHeight();
    headNavAnim();
    hideLeft();
    uiPath();
    sideControl();
    headMenu();
}

/**
 * 头部导航栏滑动效果
 */
function headNavAnim() {
    $('.header .navbar li').on('mouseenter', function() {
        var mark = $(this).parents('.navbar').find('.n-mark');
        mark.css('left', ($(this).position().left + $(this).innerWidth() / 2 - 10));
    });
    $('.header .navbar').on('mouseleave', function() {
        var li = $(this).find('li.on'),
            mark = $(this).find('.n-mark');
        mark.css('left', (li.position().left + li.innerWidth() / 2 - 10));
    });
    $(window).on('resize.headnavresize', function() {
        var li = $('.header .navbar').find('li.on'),
            mark = $('.header .navbar').find('.n-mark');
        mark.css('left', (li.position().left + li.innerWidth() / 2 - 10));
    });
}

/**
 * 设置主体高度
 */
function setHeight(){
    var head = $('.header'),body = $('.bodyCont');
    body.height($('body').innerHeight() - head.height());
    $(window).on('resize',function(){
        body.height($('body').innerHeight() - head.height());
    });
}

/**
 * 缩小左侧导航
 */
function hideLeft(type){
    var bar =$('.leftAside'),btn = $('.hideLeftBtn');
    btn.on('click',function(){
        if(bar.hasClass("close")){
            leftMenu.open();
        }else{
            leftMenu.close();
        }
    });
}

/**
 * 左侧导航开启关闭
 */
var leftMenu = {
    open:function(){
        $('.leftAside').removeClass("close");
        setcookie('hideIndexLeft',1);
    },
    close:function(){
        $('.leftAside').addClass("close");
        $('.navList .subList').slideUp(300);
        $('.navList .subTitle').removeClass("on");
        setcookie('hideIndexLeft',0);
    }
};

/**
 * 初始化皮肤选择按钮
 */
function uiPath(){
    $('.PathItem .item').changeui({
        linkDom: '#theme'
    });
    $('#PathMenu .Tmain').on('click',function(){
        PathRun();
    });
}

/**
 * 左侧菜单收放
 */
function sideControl(){
    var list = $('.navList'),leftSide = $('.leftAside');
    list.delegate(".subTitle","click",function(e){
        e.stopPropagation();
        if(leftSide.hasClass("close")){
            leftMenu.open();
        }
        var sublist = $(this).find('.subList');
        $(this)
            .siblings(".subTitle")
            .removeClass("on");

        list
            .find('.subList')
            .slideUp(300);
        if($(this).hasClass("on")){
            $(this).removeClass("on");
            sublist.stop().slideUp(300);
        }else{
            $(this).addClass("on");
            sublist.stop().slideDown(300);
        }
    }).delegate(".subList li","click",function(e){
        e.stopPropagation();
        var url = $(this).data('url');
        list.find(".subList li").removeClass("on");
        $(this).addClass("on");
        if(url) $("#contFrame").attr('src',url);
    });
}

/**
 * 头部导航切换
 */
function headMenu(){
    var nav = $('.header .navbar');
    nav.find('li').on('click',function(){
        nav.find('li').removeClass("on");
        $(this).addClass('on');
        var li = $(this),
            mark = nav.find('.n-mark');
        mark.css('left', (li.position().left + li.innerWidth() / 2 - 10));
        $.ajax({
            type:'get',
            url:'test.json',
            dataType:'json',
            data:{
                'type':$(this).data('val')
            },
            success:function(data){
                renderLeftMenu(data);
            }
        });
    });
}

/**
 * 渲染左侧菜单
 */
function renderLeftMenu(data){
    var dom = $("<ul></ul>"),domChild="";
    if(!data.list || !data.list.length){
        $(".leftAside").hide();
    }
    $.each(data.list,function(i,v){
        var subDom=$('<ul class="subList"></ul>');
        domChild = $('<li class="subTitle"><i class="icon icon-'+v.ico+'"></i><span>'+v.name+'</span></li>');
        if(v.sub.length){
            $.each(v.sub,function(i,v){
                subDom.append('<li data-url="'+v.url+'"><span title="'+v.name+'">'+v.name+'</span></li>');
            });
        }
        domChild.append(subDom);
        dom.append(domChild);
    });

    $('.navList').empty().html(dom);
}

/**
 * 写cookie
 */
function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
    var expires = new Date();
    expires.setTime(expires.getTime() + seconds);
    expires = seconds ? expires.toGMTString() : 0;
    document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
}