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
}

/**
 * 设置主体高度
 */
function setHeight() {
    var main = $('.main');
    main.height($('body').innerHeight());
    $(window).on('resize', function() {
        main.height($('body').innerHeight());
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
//            ipt.val(ipt.val()+$(this).attr("data-val")).trigger('keyup');
//        });
//    });
//}

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
