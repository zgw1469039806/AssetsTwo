$(function () {
    //分类展开/收起事件
    $(".all_box .process_list_title").on("click", function () {
        $(this).next().toggle("normal");
        if ($(this).find(".iconfont").hasClass("icon-jiantou-you")) {
            $(this).find(".iconfont").addClass('icon-jiantou-xia').removeClass("icon-jiantou-you");
        } else {
            $(this).find(".iconfont").addClass('icon-jiantou-you').removeClass("icon-jiantou-xia");
        }
    });

    //搜索事件
    $("#search").bind("keypress", function (e) {
        var keycode = e.keyCode || e.which;
        if (keycode != 13) {
            return;
        }
        search();
        e.stopPropagation();
        return false;
    });
    $("#search").change(function (e) {
        search();
        e.stopPropagation();
        return false;
    });

    function search() {
        var searchtext = $.trim($("#search").val());
        searchtext = stripscript(searchtext);
        if (searchtext != "") {
            //全部流程
            $(".process_list_box").removeClass("on");
            $(".process_list").each(function (i, n) {
                var show = $(n).attr("_text").indexOf(searchtext) != -1;
                if (show) {
                    $(n).show();
                    //对应展开/收起
                    $(n).parent().show();
                    $(n).parents(".process_list_box").find(".process_list_title .iconfont").addClass('icon-jiantou-xia').removeClass("icon-jiantou-you");
                    $(n).parents(".process_list_box").addClass("on");
                } else {
                    $(n).hide();
                }
            });
            //常用流程
            $(".process_card").each(function (i, n) {
                var show = $(n).attr("_text").indexOf(searchtext) != -1;
                if (show) {
                    $(n).addClass("on");
                } else {
                    $(n).removeClass("on");
                }
            });
        } else {
            $(".process_list_box").addClass("on");
            $(".process_list").show();
            $(".process_card").addClass("on");
        }

        commonBoxIsBlank();
    }
});

function commonBoxIsBlank() {
    if ($(".common_box").find(".process_card").filter(".on").length == 0) {
        $(".common_box").find(".common_box_blank").show();
    } else {
        $(".common_box").find(".common_box_blank").hide();
    }
    if ($(".all_box").find(".process_list_box").filter(".on").length == 0) {
        $(".all_box").find(".common_box_blank").show();
    } else {
        $(".all_box").find(".common_box_blank").hide();
    }
}

function stripscript(s) {
    var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
}

//常用流程加载
function reloadCard() {
    if ($(".common_box").length == 0) {
        return;
    }
    var placeholder = $("#search").attr("placeholder");
    $.ajax({
        url: 'platform/bpm/business/getBmpFavs',
        type: 'POST',
        dataType: 'JSON',
        success: function (r) {
            $(".common_box").find("ul").empty();
            $(".all_box").find(".star").removeClass("icon-star-fill").addClass("icon-star");
            if (r.status == 0) {

                //对应搜索
                var searchtext = $.trim($("#search").val());
                if (placeholder == searchtext) {
                    searchtext = "";
                }
                searchtext = stripscript(searchtext);
                for (var i = 0; i < r.data.length; i++) {
                    var d = r.data[i];
                    var $process = $(".all_box").find("#process_" + d.pdid);
                    if ($process.length > 0) {
                        var pdName = $process.attr("_text");
                        var pdVersion = $process.find(".pr_version").text();
                        var flowTypeName = $process.find(".pr_type").text();
                        $process.find(".star").removeClass("icon-star").addClass("icon-star-fill");
                        var card = createCardFromTemplate(d.pdid, pdName, pdVersion, flowTypeName, i);
                        var $card = $(card);
                        //对应搜索
                        if (searchtext != "" && pdName.indexOf(searchtext) == -1) {
                            $card.removeClass("on");
                        }
                        $(".common_box").find("ul").append($card);
                    }
                }
            } else {
                flowUtils.error("加载常用流程失败");
            }

            commonBoxIsBlank();
        }
    });
}

var colorArr = ["purple", "red", "blue", "green", "cyan", "tangerine"];

function createCardFromTemplate(pdId, pdName, pdVersion, flowTypeName, index) {

    var template = '<li class="process_card on" _text="' + pdName + '">\n' +
        '             <div class="process_icon ' + (colorArr[index % colorArr.length]) + '">\n' +
        '               <i class="icon iconfont icon-share"></i>\n' +
        '             </div>\n' +
        '             <a href="javascript:void(0)" class="process_name" title="' + pdName + '" onclick="openDetail(\'' + pdId + '\')">' + pdName + '</a>\n' +
        (pdVersion ? ('<div class="process_type">版本：' + pdVersion + '</div>\n') : '') +
        (flowTypeName ? ('<div class="process_type">类型：' + flowTypeName + '</div>\n') : '') +
        '             <div class="process_icon_box">\n' +
        '               <i class="icon iconfont icon-star-fill " title="取消收藏" onclick="doFav(\'' + pdId + '\',\'unfollow\')"></i>\n' +
        '             </div>\n' +
        '             <div class="process_btn">\n' +
        '               <a class="initiate" onclick="flowUtils.openOnDialog(\'platform/bpm/business/start?defineId=' + pdId + '\',\'' + pdName + '\')">\n' +
        '                 <i class="icon iconfont icon-faqi"></i><span>发起流程</span>\n' +
        '               </a>\n' +
        '             </div>\n' +
        '           </li>';

    return template;
}

//value: pdid
//act: unfollow || follow
function doFav(value, act, that, callback) {
    if (!act) {
        if ($(that).find("i").length > 0) {
            act = $(that).find("i").hasClass("icon-star-fill") ? "unfollow" : "follow";
        } else {
            act = $(that).hasClass("icon-star-fill") ? "unfollow" : "follow";
        }
    }
    $.ajax({
        url: 'platform/bpm/business/doBmpFav',
        data: {
            value: value,
            act: act
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (r) {
            if (r.status == 0) {
                reloadCard();
                flowUtils.success(act == "unfollow" ? "取消收藏成功" : "收藏成功");
                if (typeof callback == "function") {
                    callback(that, act);
                }
            } else {
                flowUtils.error(r.err);
            }
        }
    });
}

function openDetail(pdId) {
    if (typeof top.addTab == "function") {
        top.addTab("流程模板详情", "platform/bpm/business/viewDetail?pdId=" + pdId, true);
    }
}
