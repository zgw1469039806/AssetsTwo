$(function() {
    setTimeout('init()', 300);
});

function init() {
    setHeight();
    limitTxt($('.textArea textarea'));
//    miniMenu($('.titleBar .menu'));
    switchBtn();
    slideEvent();
    resizeWorkFlowWin(true);
    $('.avic-tab').avictabs({
        onSwitch:function(dom){
            $('.avic-tab .btn-bar').removeClass('on');
            if($('.avic-tab .btn-bar').length > dom.index()){
            	$('.avic-tab .btn-bar').eq(dom.index()).addClass('on');
            }
            avicTabOnSwitch(dom.index());
        }
    });

    $('.menuBtn').on('mouseenter',function(){
        $(this).addClass("on");
        var menu = $(this).find('.childMenu');
        menu.css({
            height:$(".editFrom").height() - ($(this).offset().top+$(this).height()) - 10
        });
    }).on('mouseleave',function(){
        $(this).removeClass("on");
    });

    $('.titleBar .menu').on('mouseenter',function(){
        $(this).addClass("on");
        $(this).find('.menu').css({height:300})
    }).on('mouseleave',function(){
        $(this).removeClass("on");
    });

    $('.editFrom').delegate('.dropdown-toggle','click',function(e){
        e.stopPropagation();
        $('.dropdown-menu').hide();
        $(this).next('.dropdown-menu').show();
        $(document).off('click.dropdown-toggle').on('click.dropdown-toggle',function(e){
            $('.dropdown-menu').hide();
        })
    });

}

/**
 * 设置主体高度
 */
function setHeight() {
    var main = $('.main');
    main.height($(window).innerHeight());
    $(window).on('resize', function() {
        main.height($(window).innerHeight());
    });
}

// 限制输入自动回删
function limitTxt(dom) {
    dom.each(function() {
        var numDom = $(this).parent().find('.num');
        var limit = parseInt($(this).data('len'));
        numDom.find('.limit').text(limit);
        $(this).on("keyup", function() {
            var str = $(this).val(),
                strlen = str.length;
            if (strlen >= limit) {
                $(this).val(str.substr(0, limit));
                strlen = limit;
            }
            numDom.find('.now').text(strlen);
        });
    });
}

// 自定义下拉菜单选择回填
//function miniMenu(dom) {
//    dom.each(function() {
//        var menu = dom.find('.submenu'),
//            ipt = dom.parents('.titleBar').next('.textArea').find('textarea');
//        menu.find('li').on('click', function() {
//            ipt.val(ipt.val()+$(this).text()).trigger('keyup');
//        });
//    });
//}

// // 按钮菜单初始化
// function listBtn(dom) {
//     dom.each(function() {
//         var menu = $(this).find('ul'),
//             that = $(this);
//         $(this).on('click', function() {
//             asynList(menu, $(this).attr('rel'));
//         });
//         $(document).on('click', function(e) {
//             if (!that.is(e.target) && that.has(e.target).length) {} else {
//                 menu.hide();
//             }
//         });
//     });
// }

// // 异步获取菜单权限
// function asynList(dom, url) {
//     if (!url) return;
//     $.ajax({
//         url: url,
//         data: {},
//         dataType: 'json',
//         success: function(data) {
//             if (data.list.length) {
//                 var html = '';
//                 $.each(data.list, function(i, v) {
//                     html += '<li onClick="submitForm(\'' + v.token + '\')">' + v.name + '</li>';
//                 });
//                 dom.empty().append(html).show();
//             } else {
//                 submitForm(data.token);
//             }
//         }
//     });
// }

// //按钮提交事件
// function submitForm(token) {
//     console.log('submitToken=' + token);
// }

// 视图切换按钮事件
function switchBtn() {
    $('.switch>div').on('click', function() {
        var val = $(this).attr('for');
        if (!val) return;
        $(this).addClass("on").siblings('div').removeClass("on");
        $('.switch-panel.' + val).addClass('on').siblings(".switch-panel").removeClass("on");
    });
}

// 收起按钮事件
function slideEvent() {
    $('.slideup').each(function() {
        $(this).on('click', function() {
            $(this).parents('.wf-cont').find('.wf-body').slideToggle(300, function() {
                setTimeout('resizeWorkFlowWin()', 500);
            });
            $(this).toggleClass("on");
        });
    });
}

// 设置流程视窗子窗口高度
// todo  扩展抽象方法
function resizeWorkFlowWin(type) {
    $('.workflow .wf-body').each(function() {
        if ($(this).hasClass("fixdom")) {
            return;
        }
        var baseHeight = $('.workflow').height() - $(this).offset().top - 21;
        if (type) {
            $(this).data('baseheight', baseHeight);
        }
        if ($(this).is(':hidden')) return;
        $(this).css({
            height: $(this).data('baseHeight')
        });
        $(window).on('resize', function() {
            resizeWorkFlowWin(true);
        });
    });
}
