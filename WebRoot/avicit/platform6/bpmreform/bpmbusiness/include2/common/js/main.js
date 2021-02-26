var _startOrderData = null;
var _timeId = null;
var _fixedTop = true;
$(function () {
    // 浮动头部
    var topHead = $('.top-head'),
        p = 0,
        t = 0;
    $(window).scroll(function () {
        if(_fixedTop) return;
        p = $(this).scrollTop();
        if (t < p) {
            //下滚
            topHead.css('top', -50);
        } else {
            //上滚            
            topHead.css('top', 0);
        }
        setTimeout(function () {
            t = p;
        }, 0);
    });

    $('.top-logo .switch').on('click', function () {
        var navbar = $("#navHeight"),
            em = $(this).find('em');
        var type = null;
        if (em.hasClass('type2')) {
            navbar.show();
            em.attr('title', '隐藏快速导航条');
            em.removeClass('type2');
            type = 1;
        } else {
            navbar.hide();
            em.attr('title', '显示快速导航条');
            em.addClass('type2');
            type = 0;
        }
        if(_timeId != null){
            clearTimeout( _timeId);
        }
        _timeId = setTimeout(function(){
            $.ajax({
                url: "platform/bpm/business/updateBpmNavbarConfig",
                data: {type: type},
                type: "POST",
                dataType: "JSON",
                success: function (msg) {
                }
            });
            _timeId = null;
        },2000);

    });

    // 初始化滚动槽
    $('.nav-wrap').navScroll({
        navHeight: $('.top-head').height(),
        scrollSpy: true
    });

    // 设置按钮弹出
    $('.setting-btn').on('click', function () {
        var pos = $('.setting-btn').position();
        layer.open({
            type: 1,
            title: false,
            area: ['440px', '250px'],
            offset: [pos.top + 86, pos.left],
            shade: 0.01,
            closeBtn: 0,
            shift: 5,
            shadeClose: true,
            content: $('#setting-panel'),
            success: function (layero, index) {
                _startOrderData = getFlowOrderData();
            },
            end: function (layero, index) {
                var _endOrderData = getFlowOrderData();
                var _tempOrderFlg = false;
                var _tempDisplayFlg = false;
                var _end_idea_display = 0;
                var _end_pic_display = 0;
                var _start_idea_display = 0;
                var _start_pic_display = 0;
                for (var i = 0; i < _endOrderData.length; i++) {
                    if (_endOrderData[i].code != _startOrderData[i].code) {
                        _tempOrderFlg = true;
                    }
                    if (_endOrderData[i].display != _startOrderData[i].display) {
                        _tempDisplayFlg = true;
                    }
                    if(_endOrderData[i].code == "bpm_idea_tab" && _endOrderData[i].display == "1"){
                        _end_idea_display = 1;
                    }
                    if(_endOrderData[i].code == "bpm_pic_tab" && _endOrderData[i].display == "1"){
                        _end_pic_display = 1;
                    }
                }
                for (var i = 0; i < _startOrderData.length; i++) {
                    if(_startOrderData[i].code == "bpm_idea_tab" && _startOrderData[i].display == "1"){
                        _start_idea_display = 1;
                    }
                    if(_startOrderData[i].code == "bpm_pic_tab" && _startOrderData[i].display == "1"){
                        _start_pic_display = 1;
                    }
                }

                if (_tempOrderFlg || _tempDisplayFlg) {
                    $.ajax({
                        url: "platform/bpm/business/updateBpmTabsExts",
                        data: {listStr: JSON.stringify(_endOrderData)},
                        type: "POST",
                        dataType: "JSON",
                        success: function (msg) {
                            //如果从隐藏设置为显示，并且需要刷新则刷新
                            if(_start_idea_display == 0 && _end_idea_display == 1 && _flow_editor.needRefreshIdea){
                                _flow_editor.refreshIdea();
                            }
                            if(_start_pic_display == 0 && _end_pic_display == 1 && _flow_editor.needRefreshPic){
                                _flow_editor.refreshPic();
                            }
                            if (_tempOrderFlg) {
                                if(_flow_editor.isStartPage){
                                    //如果是发起页面，不能刷新
                                    layer.msg("设置完成，下次打开页面时生效。");
                                }else {
                                    layer.confirm('设置完成，排序结果需要刷新才可生效。', {
                                        title: false,
                                        closeBtn: false,
                                        shadeClose: true,
                                        btn: ['立刻刷新', '先不刷新']
                                    }, function (index, layero) {
                                        location.reload();
                                        layer.close(index);
                                    }, function (index) {
                                        layer.close(index);
                                    });
                                }
                            }
                        }
                    });
                }
                _startOrderData = null;
            }
        });
    });

    // 设置是否展示
    $('.l-radio').on('click', function (e) {
        if($(this).hasClass("disabled")){
            return;
        }
        e.stopPropagation();
        var panelid = $(this).data('for');
        if ($(this).hasClass('checked')) {
            $(this).removeClass('checked');
            $("#" + panelid).hide();
            $("#" + panelid + "-nav").hide();
        } else {
            $(this).addClass('checked');
            $("#" + panelid).show();
            $("#" + panelid + "-nav").show();
        }
    });

    //列表排序
    $("#drag-list-1").dragsort({
        dragSelector: ".m",
        dragEnd: function () {
            // 排序完成后执行方法 this为被排序对象
            // console.log(this);
            sortlist($(this));
        }
    });
    smartBtnBar();
});
//避免将有下拉的放入收缩，有下拉的只有提交和退回，尽量往前放
// 自动收纳放出头部工具条的按钮
function smartBtnBar() {
    var btnbar = $('#top-tool .top-btns'),
        others = btnbar.siblings(),
        space = 100, //呼吸区
        more = $('#top-tool .more-list'),
        morelist = $('#top-tool .more-list .sub-list'),
        othersW = 0;

    $.each(others, function (i, v) {
        othersW += $(v).innerWidth();
    });
    var setWidth = function () {
        var barW = btnbar.parent().width();
        btnbar.css('max-width',barW - othersW);
    }

    var diffWidth = function () {
        var barW = btnbar.parent().width();
        var lis = btnbar.find('>ul>li'),
            lisl = lis.length,
            btnbarW = barW - othersW - space,
            lisW = 0;
        $.each(lis, function (i, v) {
            if($(v).is(':hidden')) return;
            lisW += $(v).innerWidth();
        });
        if(lisW > btnbarW){
            var li = $(lis[lisl-2]);
            morelist.prepend(li);
            diffWidth();
        }else if(lisW + 115 < btnbarW){
            var firstLi = morelist.find('li:eq(0)');
            btnbar.find('.more-list').before(firstLi);
            if(morelist.find('li').length > 0) diffWidth();
        }
        (more.find("li").length)?more.show():more.hide();
    }

    setWidth();
    diffWidth();

    $(window).on('resize', function () {
        diffWidth();
        setWidth();
    });
}
// 帮助框
function help(dom) {
    var pos = $(dom).parent().position();
    layer.open({
        type: 1,
        title: false,
        area: ['440px', '250px'],
        /*offset: [pos.top + 50, pos.left],*/
        shade: 0.01,
        /*closeBtn: 0,*/
        shift: 5,
        shadeClose: true,
        content: $('#help-panel'),
        success: function (layero, index) {
            //弹层不显示标题栏，以下特殊设置只显示标题栏上的关闭按钮
            $(".layui-layer-setwin .layui-layer-close2").css('right','-20px');
            $(".layui-layer-setwin .layui-layer-close2").css('top','-3px');
            $(".help-panel").css('padding-top','22px');
        }
    });
}

//排序列表重新显示新序列号
function sortlist(dom) {
    var trs = dom.parent().find('tr');
    $.each(trs, function (i, v) {
        $(v).find('.l').text(i + 1);
    });
}

function getFlowOrderData() {
    var result = [];
    var trs = $("#drag-list-1").find('tr');
    $.each(trs, function (i, v) {
        var obj = {};
        obj.code = $(v).find('.l-radio').attr("data-for");
        obj.display = $(v).find('.l-radio').hasClass("checked") ? "1" : "0";
        obj.order = $(v).find('.l').text();
        result.add(obj);
    });
    return result;
}

function changeLock() {
    _fixedTop = !_fixedTop;
    if(_fixedTop){
        $("#top_lock_unlock").hide();
        $("#top_lock_lock").show();
    }else{
        $("#top_lock_unlock").show();
        $("#top_lock_lock").hide();
    }
}