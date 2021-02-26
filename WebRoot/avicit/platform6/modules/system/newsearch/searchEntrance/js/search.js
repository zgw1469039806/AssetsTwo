$(function() {
    reset();
    treeList();
    cateWin();
    datelist();
    funPlaceholder($("input"));
});


var funPlaceholder = function(elements) {
    $.each(elements,function(i,v){
        var element = $(v);
        var placeholder = '';
    if (element && element.attr("placeholder")) {
        placeholder = element.attr("placeholder");
        element.on("focus",function() {
            if ($(this).val() == placeholder) {
                $(this).val("");
            }
            $(this).css('color','');
        });
        element.on("blur", function() {
            if ($(this).val() == "") {
                $(this).val(placeholder);
                $(this).css('color','gray');
            }
        });

        //样式初始化
        if (element.val() === "") {
            element.val(placeholder);
            element.css('color','gray');
        }
    }
    });
};

// 内容区域高度调整
function reset() {
    var mh = $(".main").innerHeight(),
        shh = $('.searchHead').innerHeight();

    //$('.searchBody').css('height', mh - shh);
    $(window).on('resize', function() {
        mh = $(".main").innerHeight(),
        shh = $('.searchHead').innerHeight();
        $('.searchBody').css('height', mh - shh);
    });
}

//分类树 初始化
function treeList() {
    var setting = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        view:{
        	showIcon: false,
            showLine: false
        }
    };

    var zNodes = [
        { id: 1, pId: 0, name: "随意勾选 1", open: true },
        { id: 11, pId: 1, name: "随意勾选 1-1", open: true },
        { id: 111, pId: 11, name: "随意勾选 1-1-1" },
        { id: 112, pId: 11, name: "随意勾选 1-1-2" },
        { id: 12, pId: 1, name: "随意勾选 1-2", open: true },
        { id: 121, pId: 12, name: "随意勾选 1-2-1" },
        { id: 122, pId: 12, name: "随意勾选 1-2-2" },
        { id: 2, pId: 0, name: "随意勾选 2", checked: true, open: true },
        { id: 21, pId: 2, name: "随意勾选 2-1" },
        { id: 22, pId: 2, name: "随意勾选 2-2", open: true },
        { id: 221, pId: 22, name: "随意勾选 2-2-1", checked: true },
        { id: 222, pId: 22, name: "随意勾选 2-2-2" },
        { id: 23, pId: 2, name: "随意勾选 2-3" }
    ];

    $.fn.zTree.init($("#treeList"), setting, zNodes);

}

// 条件区收起展开
function cateWin(){
    $('.cate-win .group .action').on('click',function(){
        var par = $(this).parent().siblings(".cont");
        if($(this).hasClass('s-up')){
            par.slideUp();
            $(this).removeClass("s-up").addClass('s-down').find('em').text('展开');
        }else{
            par.slideDown();
            $(this).removeClass("s-down").addClass("s-up").find('em').text('收起');
        }
    });
}

function _closeNotTargetDom($this,$par,event,fun){
    $(document).off("mouseup"+event)
    $(document).on("mouseup"+event,function(e){
        if(!$this.is(e.target) && $this.has(e.target).length === 0){
            if($par){
                if(!$par.is(e.target) && $par.has(e.target).length === 0){
                    fun();
                }
            }else{
                fun();
            }
        }
        e.stopPropagation();
    });
}

// 时间控件
function datelist(){
    //展开时间选择列表
    $(".result-date").on('click',function(e){
        $(this).addClass('on');
    });
    //点击空白关闭时间列表
    _closeNotTargetDom($('.c-tip-con'),'','.date',function(){
        $(".result-date").removeClass("on");
    });

    // 自定义起始时间
    $(".c-tip-custom-st input").datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        language: 'zh-CN',
        orientation: "top right"
    }).on('show',function(e){
        $(document).off("mouseup.date");
        var startTime = e.date;
        $(".c-tip-custom-et input").datepicker('setStartDate',startTime);
    }).on('hide',function(){
        setTimeout(function(){
            _closeNotTargetDom($('.c-tip-con'),'','.date',function(){
                $(".result-date").removeClass("on");
            });
        },200);
    }).on('changeDate',function(e){
        var startTime = e.date;
        $(".c-tip-custom-et input").datepicker('setStartDate',startTime);
    });
    // 自定义结束时间
    $(".c-tip-custom-et input").datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        language: 'zh-CN',
        orientation: "top right"
    }).on('show',function(e){
        $(document).off("mouseup.date");
        var endTime = e.date;
        $('#qBeginTime').datepicker('setEndDate',endTime);
    }).on('hide',function(e){
        e.stopPropagation();
        setTimeout(function(){
            _closeNotTargetDom($('.c-tip-con'),'','.date',function(){
                $(".result-date").removeClass("on");
            });
        },200);
    }).on('changeDate',function(e){
        var endTime = e.date;
        $('#qBeginTime').datepicker('setEndDate',endTime);
    });

    // 确认按钮事件
    $('.c-tip-custom-submit').on('click',function(e){
        e.stopPropagation();
        var startTime = $('.c-tip-custom-st input').val();
        var endTime = $('.c-tip-custom-et input').val();

        console.log('st ='+startTime+';et ='+endTime);

        $(".result-date").removeClass("on");
    });

    // 列表子选项时间点击事件
    $('.c-tip-menu.c-tip-timerfilter .each').on('click',function(e){
        e.stopPropagation();

        var time = $(this).data('val');
        $(this).addClass('on').parent().siblings().find('.each').removeClass("on");

        console.log('time ='+time);

        $(".result-date").removeClass("on");
    });
}