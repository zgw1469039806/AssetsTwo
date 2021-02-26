(function ($) {
    function generatePageItem(pages) {
        return '<li class="page-item"><a class="page-link" href="JavaScript:void(0);">' + pages + '</a></li>';
    }

    /**
     *
     * @param option
     * @returns {*}
     */
    $.fn.eformPagination = function (option) {
        var _this = this;
        return this.each(function () {
            var _that = this;
            initSpiritPagination(option, this);

            $(this).on("click", '.page-item', function () {
                var pageList = $(_that).find(".page-item");
                var click = $(this);
                var textClick = click.text();
                var active = $(_that).find(".active");
                var textActive = active.text();
                var pagePre = $(_that).find(".page-pre");
                var pageNext = $(_that).find(".page-next");
                var firstSeparator = $(_that).find(".page-first-separator");
                var lastSeparator = $(_that).find(".page-last-separator");
                if (click.hasClass('disabled')) {
                    return false;
                }
                // 页面只有7页及其以下的数据
                if ($.fn.eformPagination.pages <= 7) {
                    if (textClick === "‹") {
                        // 点击的是上一页
                        if (active.text() !== "1") {
                            active.removeClass("active");
                            active.prev().addClass("active");
                        } else {
                            active.removeClass("active");
                            pageNext.prev().addClass("active");
                        }
                    } else if (textClick === "›") {
                        // 点击的是下一页
                        if (active.text() !== $.fn.eformPagination.pages + "") {
                            active.removeClass("active");
                            active.next().addClass("active");
                        } else {
                            active.removeClass("active");
                            pagePre.next().addClass("active");
                        }
                    } else {
                        pageList.removeClass("active");
                        $(this).addClass("active");
                    }
                } else {
                    // 当前点击的是第几个元素
                    var indexClick = pageList.index(this);
                    var indexActive = pageList.index(active);
                    var textClickInt = parseInt(textClick);
                    var textActiveInt = parseInt(textActive);
                    if (textClick === "‹") {
                        // 点击的是上一页
                        if (($.fn.eformPagination.pages - textActiveInt) === 3) {
                            pageNext.prev().prev().remove();
                            pageNext.prev().prev().remove();
                            pageNext.prev().before($.fn.eformPagination.htmlLastSeparator);
                        }
                        if (indexActive === 4) {
                            if (textActiveInt !== 4) {
                                // 在最后一个分隔符前去掉一列
                                lastSeparator.prev().remove();
                                // 在第一个分隔符后面加入一列
                                firstSeparator.after(generatePageItem(textActiveInt - 2));
                            }
                            if (textActiveInt === 5) {
                                firstSeparator.after(generatePageItem(textActiveInt - 3));
                                firstSeparator.remove();
                            }
                        }
                        if (textActiveInt !== 1) {
                            active.removeClass("active");
                            active.prev().addClass("active");
                        } else {
                            // 点击的是最后一个元素
                            for (var m = 0; m < 5; m++) {
                                pageNext.prev().prev().remove();
                            }
                            for (var n = 0; n < 4; n++) {
                                pageNext.prev().before(generatePageItem($.fn.eformPagination.pages - 4 + n));
                            }
                            pagePre.next().after($.fn.eformPagination.htmlFirstSeparator);
                            active.removeClass("active");
                            pageNext.prev().addClass("active");
                        }
                    } else if (textClick === "›") {
                        // 点击的是下一页
                        if (textActiveInt === 4) {
                            // 移除2个列
                            pagePre.next().next().remove();
                            pagePre.next().next().remove();
                            // 添加第一个分隔符
                            pagePre.next().after($.fn.eformPagination.htmlFirstSeparator);
                        }
                        if (indexActive === 4) {
                            if (($.fn.eformPagination.pages - textActiveInt) !== 3) {
                                firstSeparator.next().remove();
                                // 在最后一个分隔符前添加一列
                                lastSeparator.before(generatePageItem(textActiveInt + 2));
                            }
                            if (($.fn.eformPagination.pages - textActiveInt) === 4) {
                                lastSeparator.before(generatePageItem(textActiveInt + 3));
                                lastSeparator.remove();
                            }
                        }
                        if (textActiveInt !== $.fn.eformPagination.pages) {
                            active.removeClass("active");
                            active.next().addClass("active");
                        } else {
                            for (var o = 0; o < 5; o++) {
                                pagePre.next().next().remove();
                            }
                            for (var p = 0; p < 4; p++) {
                                pagePre.next().after(generatePageItem(5 - p));
                            }
                            pageNext.prev().before($.fn.eformPagination.htmlLastSeparator);
                            active.removeClass("active");
                            pagePre.next().addClass("active");
                        }
                    } else {
                        if (indexClick === 7) {
                            // 点击的是最后一个元素
                            for (var i = 0; i < 5; i++) {
                                pageNext.prev().prev().remove();
                            }
                            for (var j = 0; j < 4; j++) {
                                pageNext.prev().before(generatePageItem($.fn.eformPagination.pages - 4 + j));
                            }
                            pagePre.next().after($.fn.eformPagination.htmlFirstSeparator);
                        } else if (indexClick === 5) {
                            if (textClickInt === 5) {
                                // 移除2个列
                                pagePre.next().next().remove();
                                pagePre.next().next().remove();
                                // 添加第一个分隔符
                                pagePre.next().after($.fn.eformPagination.htmlFirstSeparator);
                                // 当前页码后再添加一个页码
                                $(this).after(generatePageItem(6));
                                // 判断是否去掉最后一个分隔符
                                if (($.fn.eformPagination.pages - textClickInt) === 3) {
                                    lastSeparator.before(generatePageItem($.fn.eformPagination.pages - 1));
                                    lastSeparator.remove();
                                }
                            } else {
                                if (($.fn.eformPagination.pages - textClickInt) !== 2) {
                                    // 移除前一个分隔符后面的一列
                                    firstSeparator.next().remove();
                                    // 在后一个分隔符前面加入一列
                                    lastSeparator.before(generatePageItem(textClickInt + 1));
                                    // 判断是否去掉最后一个分隔符
                                    if (($.fn.eformPagination.pages - textClickInt) === 3) {
                                        lastSeparator.before(generatePageItem($.fn.eformPagination.pages - 1));
                                        lastSeparator.remove();
                                    }
                                }
                            }
                        } else if (indexClick === 4) {
                            // 无变化
                        } else if (indexClick === 3) {
                            if (($.fn.eformPagination.pages - textClickInt) === 4) {
                                pageNext.prev().prev().remove();
                                pageNext.prev().prev().remove();
                                pageNext.prev().before($.fn.eformPagination.htmlLastSeparator);
                            }
                            if (textClickInt !== 3) {
                                // 移除后一个分隔符前面的一列
                                lastSeparator.prev().remove();
                                // 在第一个分隔符前面加入一列
                                firstSeparator.after(generatePageItem(textClickInt - 1));
                                // 如果点击的数字是4，再在第一个分隔符前面加入一列，同时移除第一个分隔符
                                if (textClickInt === 4) {
                                    firstSeparator.after(generatePageItem(2));
                                    firstSeparator.remove();
                                }
                            }
                        } else if (indexClick === 1) {
                            // 点击的是第一个元素
                            for (var k = 0; k < 5; k++) {
                                pagePre.next().next().remove();
                            }
                            for (var l = 0; l < 4; l++) {
                                pagePre.next().after(generatePageItem(5 - l));
                            }
                            pageNext.prev().before($.fn.eformPagination.htmlLastSeparator);
                        }
                        if (textClick !== "...") {
                            pageList.removeClass("active");
                            $(this).addClass("active");
                        }
                    }
                }
                updatePaginationDetail(parseInt($(_that).find(".active").text()),option.clickevent);
            });

        });
    };

    $.fn.eformPagination.total = 0;
    $.fn.eformPagination.pages = 0;
    $.fn.eformPagination.limit = 0;
    $.fn.eformPagination.htmlFirstSeparator = '<li class="page-item page-first-separator disabled"><a class="page-link" href="JavaScript:void(0);">...</a></li>';
    $.fn.eformPagination.htmlLastSeparator = '<li class="page-item page-last-separator disabled"><a class="page-link" href="JavaScript:void(0);">...</a></li>';

    function initSpiritPagination(option, dom) {
        $.fn.eformPagination.total = option.total;
        $.fn.eformPagination.pages = option.pages;
        $.fn.eformPagination.limit = option.limit;
        var html = '';
        var commonHead = '<div class="float-right pagination-detail" style="float:right">' +
            '<span class="pagination-info" style="line-height: 45px">' +
            '第1到第' + option.limit + '条  共 ' + option.total + ' 条' +
            '</span>' +
            '</div>' +
            '<div class="float-left pagination" style="margin:0 10px;float:left">' +
            '<ul class="pagination" style="margin:0">' +
            '<li class="page-item page-pre"><a class="page-link" href="JavaScript:void(0);">‹</a></li>' +
            '<li class="page-item active"><a class="page-link" href="JavaScript:void(0);">1</a></li>';
        if (option.pages === 0) {
            html = '<div class="float-right pagination-detail" style="float:right">' +
                '<span class="pagination-info" style="line-height: 45px">' +
                '第0到第0条  共 0 条' +
                '</span>' +
                '</div>';
        } else if (option.pages === 1) {//只有一页数据
            html = '<div class="float-right pagination-detail">' +
                '<span class="pagination-info" style="line-height: 45px">' +
                '第1到第' + option.total + '条 共 ' + option.total + ' 条' +
                '</span>' +
                '</div>';
        } else if (option.pages <= 7) {
            html = commonHead;
            for (var i = 1; i < option.pages; i++) {
                html += '<li class="page-item"><a class="page-link" href="JavaScript:void(0);">' + (i + 1) + '</a></li>';
            }
            html += '<li class="page-item page-next"><a class="page-link" href="JavaScript:void(0);">›</a></li>' +
                '</ul></div>';
        } else if (option.pages > 7) {
            html = commonHead;
            for (var j = 0; j < 4; j++) {
                html += '<li class="page-item"><a class="page-link" href="JavaScript:void(0);">' + (j + 2) + '</a></li>';
            }
            html += '<li class="page-item page-last-separator disabled"><a class="page-link" href="JavaScript:void(0);">...</a></li>' +
                '<li class="page-item"><a class="page-link" href="JavaScript:void(0);">' + option.pages + '</a></li>' +
                '<li class="page-item page-next"><a class="page-link" href="JavaScript:void(0);">›</a></li>' +
                '</ul></div>';
        }
        $(dom).html(html);
        $(dom).find('.page-pre').addClass("disabled");
    }

    function updatePaginationDetail(pages,paginationclick) {
        $('.page-pre').removeClass("disabled");
        $('.page-next').removeClass("disabled");
        var from = (pages - 1) * $.fn.eformPagination.limit + 1;
        var to = pages * $.fn.eformPagination.limit;
        if (pages === $.fn.eformPagination.pages) {
            $('.page-next').addClass("disabled");
            to = $.fn.eformPagination.total;
        } else if (pages == 1) {
            $('.page-pre').addClass("disabled");
        }
        var html = '第' + from + '到第' + to + '条 共 ' + $.fn.eformPagination.total + ' 条';
        $(".pagination-info").html(html);
        if (typeof paginationclick == "function")
            paginationclick(pages, $.fn.eformPagination.limit);
    }
})(jQuery);