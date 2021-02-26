(function (window) {
    eformtab();
    $(window).on("resize",function(){
        eformtab();
    });

    function eformtab(){
        $(".nav-tabs").each(function () {
            if (!$(this).hasClass("eform-nav-tabs")) {
                $(this).addClass("eform-nav-tabs");
                $(this).wrap('<div class="tab-parent" style="position: relative;"></div>');
            }
            var _this = this;
            if (hasScrolled($(this),'horizontal')){
                if (!$(_this).parent().hasClass("hasscrolled")) {

                    $(_this).parent().addClass("hasscrolled");
                    $(_this).parent().append('<div class="eform-tabs-scroller-left" style="display: block; height: 38px;"></div>\n' +
                        '                    <div class="eform-tabs-scroller-right" style="display: block; height: 38px;"></div>');
                    $(_this).css("margin-left", "18px");
                    $(_this).css("margin-right", "18px");
                    var parentDiv = $(_this).parent();
                    parentDiv.find(".eform-tabs-scroller-left").click(function () {
                        var pianyiliang = $(_this).width() / 2;
                        $(_this).animate({scrollLeft: $(_this).scrollLeft() - pianyiliang}, 500);
                    });

                    parentDiv.find(".eform-tabs-scroller-right").click(function () {
                        var pianyiliang = $(_this).width() / 2;
                        $(_this).animate({scrollLeft: $(_this).scrollLeft() + pianyiliang}, 500);
                    });
                }
            }else{
                if ($(_this).parent().hasClass("tab-parent")) {
                    $(_this).parent().find(".eform-tabs-scroller-right").remove();
                    $(_this).parent().find(".eform-tabs-scroller-left").remove();
                    $(_this).parent().removeClass("hasscrolled");
                    $(_this).css("margin-left", "");
                    $(_this).css("margin-right", "");
                }
            }
        });
    }

    window.eformtab = function(){eformtab();};

    function hasScrolled(element, direction) {
        if (direction === 'vertical') {
            return element[0].scrollHeight > element[0].clientHeight;
        } else if (direction === 'horizontal') {
            return element[0].scrollWidth > element[0].clientWidth;
        }
    }
})(window)


function eformTabReload(obj){
    var tabid = $(obj).find("a").attr("aria-controls");
    $('a[aria-controls="'+tabid+'"]').on('shown.bs.tab', function (e) {
        $("#"+tabid).find(".eform_component").each(function(){
            if (typeof window[$(this).attr("id")+"TabReload"] == 'function'){
                window[$(this).attr("id")+"TabReload"].call();
            }
        });
    });

    $('a[aria-controls="'+tabid+'"]').parents(".tab-pane").each(function() {
        var id = $(this).attr("id");
        $('a[aria-controls="' + id + '"]').on('shown.bs.tab', function (e) {
            $('a[aria-controls="'+tabid+']').trigger('shown.bs.tab');
        });
    });

}

function setTabMenu(obj){
    $(obj).contextMenu('eform-tab-menu', {
        menuStyle: {
            border: '1px solid #ddd',
            backgroundColor:'#fafafa',
            color:'#444',
            width: '100px',
            height: '26px',
            margin: '0',
            padding: '2px'
        },
        itemStyle: {
            margin: '0px',
            color: '#444',
            display: 'block',
            cursor: 'pointer',
            padding: '0',
            border: '0px solid',
            backgroundColor: 'transparent',
            fontSize: '12px',
            height:'20px',
            paddingLeft : '20px',
            lineHeight:'20px',
            fontFamily: 'Microsoft YaHei'
        },
        itemHoverStyle: {
            borderColor: '#b7d2ff',
            backgroundColor: '#eaf2ff',
            borderRadius:'5px 5px 5px 5px'
        },
        bindings: {
            'eform-refresh': function(t) {
                var tabid = $(t).find('a').attr("aria-controls");
                $("#"+tabid).find(".eform_component").each(function(){
                    if (typeof window[$(this).attr("id")+"TabReload"] == 'function'){
                        window[$(this).attr("id")+"TabReload"].call(this,true);
                    }
                });
            }
        }
    })
}
