$(function () {
    initFlowPic(undefined, deploymentId, function (designerEditor) {
        designerEditor.init(undefined, deploymentId);
        designerEditor.picJsp = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp";
        if (mxClient.IS_IE8) {
            setTimeout(function () {
                $("#graph").parent().height($("#graph").children().height() + 50);
                $(".process_pagt_list_box").show();
            }, 1000);
        } else {
            $(".process_pagt_list_box").show();
        }
    });
});

function setStarIcon(that, act) {
    if (act == "follow") {
        $(that).find("i").removeClass("icon-star").addClass("icon-star-fill");
        $(that).find("span").text("取消收藏")
    } else {
        $(that).find("i").removeClass("icon-star-fill").addClass("icon-star");
        $(that).find("span").text("添加收藏")
    }
    bpm_view_star();
}

/**
 * 刷新发起流程页面
 */
function bpm_view_star() {
    if (typeof (window.parent) == "undefined" || window.parent == null) {
        return;
    }
    bpm_view_star_frame(window.parent);
}

/**
 * 刷新发起流程页面
 */
function bpm_view_star_frame(parentWindow) {
    if (typeof (parentWindow.frames) == "undefined" || parentWindow.frames == null) {
        return;
    }
    for (var i = 0; i < parentWindow.frames.length; i++) {
        var frame = parentWindow.frames[i];
        bpm_view_star_frame(frame);
        if (typeof (frame.location) != "undefined" && frame.location != null) {
            try {
                if (typeof (frame.bpm_view_star_refresh) == "function") {
                    frame.bpm_view_star_refresh();//在其他页面中寻找bpm_view_star_refresh方法，如果有，则调用该方法。
                }
            } catch (e) {
                //使用try...catch是因为有的页面配置https协议的链接，导致谷歌浏览器下执行frame.bpm_view_star_refresh时报错
            }
        }
    }
}
