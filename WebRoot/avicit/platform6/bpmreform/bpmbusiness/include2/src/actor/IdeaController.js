$(function () {
    //流程意见区域是否显示了，显示了才需要去加载常用意见
    if ($(".opinion-panel").is(':hidden')) {
        return;
    }
    //all-1,新版没有了如何添加到模板的功能，所以先实现只显示设置为所有的模板的意见的功能
    var defineId = null;
    try{
        defineId = parent._flow_editor.flowModel.defineId;
    }catch (e) {
        defineId = "all-1";
    }
    $.ajax({
        url: "platform/bpm/business/getMyIdeaList",
        data: {
            defineId: defineId
        },
        type: "POST",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error);
            } else {
                $.each(msg.result, function (i, n) {
                    var $li = $('<li class="quikmsg" _id="' + n.id + '"><em></em>' + n.value + '</li>');
                    $(".opinion-panel").find(".often-more").children("ul").append($li);

                    //title=拖动排序
                    // var $li2 = $('<li title="" _id="' + n.id + '"><i class="sm-checkbox"></i>' + n.value + '<em class="clear"></em></li>');
                    //var $li2 = $('<li class="quikmsg" title="" _id="' + n.id + '">' + n.value + '<em class="clear"></em></li>');
                    var $li2 = $('<li class="quikmsg" title="" _id="' + n.id + '">' + n.value + '<em class="clear" title="删除"></em></li>');
                    $("#setting-msg-drag").append($li2);
                });
            }
            if(parent._flow_editor){
                var defaultIdea = parent._flow_editor.defaultForm.getDefaultIdea(parent._data.event);
                if(defaultIdea){
                    var textarea = $(".opinion-panel").find("textarea");
                    textarea.empty().val(defaultIdea);
                }
            }
        }
    });
});

function initIdeaComment(actorModel) {
    // 快捷消息事件
    $('.opinion-panel').off().delegate('.quikmsg', 'click', function (e) {
        e.stopPropagation();
        var textarea = $(this).parents('.opinion-panel').find("textarea");
        textarea.empty().val($(this).text());
    });

    // 收藏事件
    $('.opinion-panel').delegate('.like', 'click', function (e) {
        e.stopPropagation();
        if ($(this).hasClass('on')) {
            flowUtils.success("已收藏");
            return;
        }
        var quiks = $('.opinion-panel').find('.quikmsg'),
            newTxt = $('.opinion-panel').find("textarea").val();
        if ($.trim(newTxt) == "") {
            return;
        }
        if(newTxt.gblen() > 30){
            flowUtils.warning("审批意见最多可以输入30个字符(一个中文字符长度为2)!");
            return;
        }
        var _flg = false;
        $.each(quiks, function (i, v) {
            if ($(v).text() == newTxt) {
                _flg = true;
            }
        });
        $('.opinion-panel .like').addClass('on');
        if (_flg) {
            flowUtils.success("已收藏");
            return;
        }
        var data = [{
            value: newTxt,
            processType: "1"
        }];
        $.ajax({
            url: "platform/console/customed/insertOrUpdateApprovalOptionJSP",
            data: {customedData: JSON.stringify(data)},
            type: 'POST',
            dataType: 'JSON',
            success: function (r) {
                if (r.flag == "success") {
                    flowUtils.success("已收藏");
                    var $li = $('<li class="quikmsg" _id="' + r.id + '"><em></em>' + newTxt + '</li>');
                    $(".opinion-panel").find(".often-more").children("ul").append($li);

                    //title=拖动排序
                    //var $li2 = $('<li title="" _id="' + r.id + '"><i class="sm-checkbox"></i>' + newTxt + '<em class="clear"></em></li>');
                    var $li2 = $('<li class="quikmsg" title="" _id="' + r.id + '">' + newTxt + '<em class="clear" title="删除"></em></li>');
                    $("#setting-msg-drag").append($li2);
                } else {
                    flowUtils.warning("收藏失败");
                }
            }
        });
    });


    // 收藏设置内全删除
    $('.opinion-panel .clear-all').off().on('click', function (e) {
        e.stopPropagation();
        var that = $(this);
        if (that.parents('.sd-box').find('ul .sm-checkbox.on').length == 0) {
            flowUtils.warning("请先选择数据");
            return;
        }
        layer.confirm('确定移除已选中的常用意见吗？', {
            btn: ['确定', '取消']
        }, function (index, layero) {
            var idsInDb = [];
            that.parents('.sd-box').find('ul .sm-checkbox.on').each(function () {
                var id = $(this).parent().attr("_id");
                $(this).parent().remove();
                $('.opinion-panel').find('.quikmsg[_id="' + id + '"]').remove();
                idsInDb.push(id);
            });

            $.ajax({
                url: "platform/console/customed/deleteApprovalOptionJSP",
                data: JSON.stringify(idsInDb),
                type: 'POST',
                contentType: 'application/json',
                dataType: 'JSON',
                success: function (r) {
                    if (r.flag == "success") {
                        flowUtils.success("移除成功");
                    } else {
                        flowUtils.warning("移除失败");
                    }
                }
            });

            layer.close(index);
        }, function (index) {
            layer.close(index);
        });
    });
    // 收藏设置内全选
    $('.opinion-panel .sm-check-all').off().on('click', function (e) {
        e.stopPropagation();
        var ul = $(this).parent().next('ul');
        $(this).toggleClass('on');
        if ($(this).hasClass('on')) {
            ul.find('.sm-checkbox').addClass('on');
        } else {
            ul.find('.sm-checkbox').removeClass('on');
        }
    });
    // 收藏设置内选择单条
    $('.opinion-panel').delegate('.sm-checkbox', 'click', function (e) {
        e.stopPropagation();
        $(this).toggleClass('on');
    });
    // 收藏设置内删除单条
    $('.opinion-panel').delegate('.clear', 'click', function (e) {
        e.stopPropagation();
        var that = $(this),
            txt = that.parent().text();
        layer.confirm('确定把常用意见“' + txt + '”移除吗？', {
            btn: ['确定', '取消']
        }, function (index, layero) {
            that.parent().remove();

            var id = that.parent().attr("_id");
            $('.opinion-panel').find('.quikmsg[_id="' + id + '"]').remove();

            var idsInDb = [];
            idsInDb.push(id);
            $.ajax({
                url: "platform/console/customed/deleteApprovalOptionJSP",
                data: JSON.stringify(idsInDb),
                type: 'POST',
                contentType: 'application/json',
                dataType: 'JSON',
                success: function (r) {
                    if (r.flag == "success") {
                        flowUtils.success("移除成功");
                    } else {
                        flowUtils.warning("移除失败");
                    }
                }
            });

            layer.close(index);
        }, function (index) {
            layer.close(index);
        });
    });

    // 校验输入内容是否已在收藏
    $('.opinion-panel').delegate('.op-textarea textarea', 'keyup', function () {
        var newTxt = $(this).val(),
            quiks = $('.opinion-panel').find('.quikmsg');
        $('.opinion-panel .like').removeClass('on');
        $.each(quiks, function (i, v) {
            if ($(v).text() == newTxt) {
                $('.opinion-panel .like').addClass('on');
            }
        });
    });
}
