$(function () {
    //tab切换事件
    $(".process_title").children("a").on("click", function () {
        $(this).addClass('act').siblings("a").removeClass("act");
        $(".process_inner").children().eq($(this).index()).addClass('on').siblings("div").removeClass("on");

        //记录用户习惯
        processViewTabNum($(this).index());
    })

    reloadCard();
});

var _view_timeId = null;

function processViewTabNum(value) {
    //延时2秒，防止频繁操作
    if (_view_timeId != null) {
        clearTimeout(_view_timeId);
    }
    _view_timeId = setTimeout(function () {
        $.ajax({
            url: 'platform/bpm/business/processViewTabNum',
            data: {
                value: value,
            },
            type: 'POST',
            dataType: 'JSON',
            success: function (r) {
                if (r.status == 0) {
                } else {
                }
            }
        });
        _view_timeId = null;
    }, 2000);
}
