
$(document).ready(function() {
//	CKEDITOR.disableAutoInline = true;
//	var contenthandle = CKEDITOR.replace( 'contenteditor' ,{
//		language: 'zh-cn',
//		contentsCss: ['css/bootstrap-combined.min.css'],
//		allowedContent: true
//	});
    $("body").css("min-height", $(window).height() - 90);
    $(".demo").css("min-height", $(window).height() - 160);
    //布局拖动
    $(".sidebar-nav .lyrow").draggable({
        connectToSortable: ".demo",//允许draggable被拖拽到指定的sortables中，如果使用此选项helper属性必须设置成clone才能正常工作
        helper: "clone",//拖拽元素时的显示方式（如果是函数，必须返回值是一个DOM元素）可选值：'original', 'clone', Function
        handle: ".drag",//指定可以被拖动的元素，这里指的是含有drag类的元素，相当于给该元素设置了属性draggable="true"
        start: function(e,t) {//当鼠标开始拖拽时，触发此事件
            if (!startdrag) stopsave++;
            startdrag = 1;
        },
        drag: function(e, t) {//当鼠标拖拽移动时，触发此事件:浏览器自有event对象，和经过封装的ui对象
            t.helper.width(400);
        },
        stop: function(e, t) {//当鼠标松开时，触发此事件
            $(".demo .column").sortable({//排序
                opacity: .35,
                connectWith: ".column",
                start: function(e,t) {
                    if (!startdrag) stopsave++;
                    startdrag = 1;
                },
                stop: function(e,t) {
                    if(stopsave>0) stopsave--;
                    startdrag = 0;
                    setting();//模板页面拖拽后绑定弹出层事件
                }
            });
            setting();//模板页面拖拽后绑定弹出层事件
            if(stopsave>0) stopsave--;
            startdrag = 0;
            //移除布局提示
            $('.layoutTip').remove();
        }
    });

    //门户小页拖动
    $(".sidebar-nav .box").draggable({
        connectToSortable: ".column",
        helper: "clone",
        handle: ".drag",
        start: function(e,t) {
            if (!startdrag) stopsave++;
            startdrag = 1;
        },
        drag: function(e, t) {
            t.helper.width(400);
        },
        stop: function(e, t) {
            handleJsIds();
            if(stopsave>0) stopsave--;
            startdrag = 0;
            setting();
        }
    });
    initContainer();
    $('body.edit .demo').on("click","[data-target=#editorModal]",function(e) {
        e.preventDefault();
        currenteditor = $(this).parent().parent().find('.view');
        var eText = currenteditor.html();
        contenthandle.setData(eText);
    });
    $("#savecontent").click(function(e) {
        e.preventDefault();
        currenteditor.html(contenthandle.getData());
    });
    $("#save").click(function(e) {
        e.preventDefault();
        if($(this).hasClass('disabled')){
            return;
        } else {
//			保存逻辑:1,如果是前台保存，并且是系统定义，角色定义，保存成个人设置;
//			      2,如果是后台保存，直接进行保存
//			      3,如果是用户自定义保存，直接保存
            var isPortal = $('#isPortal').val();
            var resourceType = $('#resourceType').val();
            if(isPortal == 'true'){
                if(resourceType == '0' || resourceType == '1'){
                    setDefaultPortletEvent();
                } else {
                    saveEvent();
                }
            } else {
                saveEvent();
            }
        }
    });
    //取消
    $("#cancel").click(function(e) {
        parent.layer.closeAll();
    });
    var userAgentPortlet = navigator.userAgent; //取得浏览器的userAgent字符串
    $("#edit").click(function() {//编辑
        $("body").removeClass("devpreview sourcepreview");
        $("body").addClass("edit");
        removeMenuClasses();
        $(this).addClass("active");
        $("#save").removeClass("disabled");
        $("#config").removeClass("disabled");
        if(userAgentPortlet.indexOf('MSIE') >= 0){
            $('.column').removeAttr('style');
            /*$('.three_column_3_4_3').find('.span3').css('width','28.213931623931625%');
            $('.three_column_3_4_3').find('.span6').css('width','38.433931623931625%');
            $('.three_column_4_4_4').find('.span4').css('width','31.54331623931625%');*/
        }else {
            $('.two_column_7_3').find('.span9').css('width','68.33897435897436%');
            $('.two_column_7_3').find('.span3').css('width','28.994255319148934%');
            $('.two_column_3_7').find('.span9').css('width','68.33897435897436%');
            $('.two_column_3_7').find('.span3').css('width','28.994255319148934%');
            $('.two_column_6_4').find('.span8').css('width','58.33897435897436%');
            $('.two_column_6_4').find('.span4').css('width','38.994255319148934%');
            $('.two_column_4_6').find('.span8').css('width','58.33897435897436%');
            $('.two_column_4_6').find('.span4').css('width','38.994255319148934%');
            $('.two_column_5_5').find('.span6').css('width','48.557948717948715%');
            $('.three_column_3_4_3').find('.span3').css('width','28.113931623931625%');
            $('.three_column_3_4_3').find('.span6').css('width','38.233931623931625%');
            $('.three_column_2_5_3').find('.span2').css('width','18.33991452991453%');
            $('.three_column_2_5_3').find('.span6').css('width','48.11948717948715%');
            $('.three_column_2_5_3').find('.span4').css('width','28.33931623931625%');
            $('.three_column_4_4_4').find('.span4').css('width','31.53331623931625%');
        }
        $('.demo').find('.columnTip').show();

        $('#edit').css('display','none');
        $('#sourcepreview').css('display','');
        return false;
    });
    $("#sourcepreview").click(function() {//预览
        $("body").removeClass("edit");
        $("body").addClass("devpreview sourcepreview");
        removeMenuClasses();
        $(this).addClass("active");
        $("#save").addClass("disabled");
        $("#config").addClass("disabled");

        if(userAgentPortlet.indexOf('MSIE') >= 0){
            $('.column').css('margin-left','10px');
            $('.two_column_7_3').find('.span9').css('width','69.46%');
            $('.two_column_7_3').find('.span3').css('width','29.46%');
            $('.two_column_3_7').find('.span9').css('width','69.46%');
            $('.two_column_3_7').find('.span3').css('width','29.46%');
            $('.two_column_6_4').find('.span8').css('width','59.46%');
            $('.two_column_6_4').find('.span4').css('width','39.46%');
            $('.two_column_4_6').find('.span8').css('width','59.46%');
            $('.two_column_4_6').find('.span4').css('width','39.46%');
            $('.two_column_5_5').find('.span6').css('width','49.46%');
            $('.three_column_3_4_3').find('.span3').css('width','29.46%');
            $('.three_column_3_4_3').find('.span6').css('width','39.46%');
            $('.three_column_2_5_3').find('.span2').css('width','19.13%');
            $('.three_column_2_5_3').find('.span6').css('width','49.93%');
            $('.three_column_2_5_3').find('.span4').css('width','29.13%');
            $('.three_column_4_4_4').find('.span4').css('width','32.76%');

        }else {
            $('.two_column_7_3').find('.span9').css('width','69.99266486422946%');
            $('.two_column_7_3').find('.span3').css('width','29.991712707182323%');
            $('.two_column_3_7').find('.span9').css('width','69.99266486422946%');
            $('.two_column_3_7').find('.span3').css('width','29.991712707182323%');
            $('.two_column_6_4').find('.span8').css('width','59.99897435897436%');
            $('.two_column_6_4').find('.span4').css('width','39.994255319148934%');
            $('.two_column_4_6').find('.span8').css('width','59.993897435897436%');
            $('.two_column_4_6').find('.span4').css('width','39.994255319148934%');
            $('.two_column_5_5').find('.span6').css('width','49.997948717948715%');
            $('.three_column_3_4_3').find('.span3').css('width','29.993931623931625%');
            $('.three_column_3_4_3').find('.span6').css('width','39.993931623931625%');
            $('.three_column_2_5_3').find('.span2').css('width','19.99391452991453%');
            $('.three_column_2_5_3').find('.span6').css('width','49.993948717948715%');
            $('.three_column_2_5_3').find('.span4').css('width','29.993931623931625%');
            $('.three_column_4_4_4').find('.span4').css('width','33.333333333333333%');
        }

        $('.demo').find('.columnTip').hide();

        $('#edit').css('display','');
        $('#sourcepreview').css('display','none');

        return false;
    });
    $(".nav-header").click(function() {
        $(".sidebar-nav .boxes, .sidebar-nav .rows").hide();
        $(this).next().slideToggle(function(){
            if(($('#elmJS').css('display') == 'none') && ($('#tempJS').css('display') == 'none')){
                $('#estRows').siblings().children('i').removeClass('icon-chevron-up').addClass('icon-chevron-down');
                $('#elmJS').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
                $('#tempJS').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
            }else if(($('#estRows').css('display') == 'none') && ($('#tempJS').css('display') == 'none')){
                $('#elmJS').siblings().children('i').removeClass('icon-chevron-up').addClass('icon-chevron-down');
                $('#estRows').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
                $('#tempJS').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
            }else if(($('#elmJS').css('display') == 'none') && ($('#estRows').css('display') == 'none')){
                $('#tempJS').siblings().children('i').removeClass('icon-chevron-up').addClass('icon-chevron-down');
                $('#elmJS').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
                $('#estRows').siblings().children('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
            }
        });
    });
    removeElm();
    asyncGetPortletContent();
    deletePortlet();
    setDefaultPortlet();
    restDefaultPortlet();
    setNavListPortletContentHeight();
});

function setNavListPortletContentHeight(){
    $("#elmJS").css("max-height",window.innerHeight - 153);
    $("#tempJS").css("max-height",window.innerHeight - 206);
    $("#tempJS").css("height",window.innerHeight - 206);
}

/**
 * 保存
 */
function saveEvent(){
    var orderBy = $("#orderBy").val();
    var portletName = $("#portletName").val();

    if(validationNameAndSort(portletName,orderBy)){
        $.ajax({
            type: 'POST',
            url: 'platform/portal/portlet/toSavePortalConfigDesignContent',
            data: {
                id: $("#id").val(),
                portletName : $("#portletName").val(),
                orderBy : $("#orderBy").val(),
                content : $('.demo').html()
            },
            success: function(data) {
                $(window.parent).focus();
                top.layer.confirm('保存成功! 确认要刷新门户吗?', {
                    title : '提示',
                    icon : 3,
                    area: ['400px', ''],
                    btn: ['确定','取消'],
                    closeBtn : 0
                }, function(index,layero){
                    try{
                        parent.asynGetUserDefinedPortlet();
                    }catch(e){ }
                    try{
                        top.layer.closeAll();
                    }catch(e){}
                    try {
                        parent.layer.closeAll();
                    }catch (e){}
                }, function(){

                });

            },
            error :function(data){
                top.layer.alert('保存失败！',{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''],
                        closeBtn: 0
                    }
                );
            }
        });
    }
}

//表单校验
function validationNameAndSort(name,sort){
    if((name == null || name == '' || name == undefined)){
        layer.msg('名称字段不能为空！',{
            icon: 2,
            area: ['220px', ''],
            closeBtn: 0
        });
        return false;
    }else if((sort == null || sort == '' || sort == undefined)){
        layer.msg('排序字段不能为空！',{
            icon: 2,
            area: ['220px', ''],
            closeBtn: 0
        });
        return false;
    }else{
        if(!(/(^[0-9]\d*$)/.test(sort))){
            layer.msg('排序字段只能输入正整数或零！',{
                icon: 2,
                area: ['280px', ''],
                closeBtn: 0
            });
            return false;
        }else{
            return true;
        }
    }
}
//删除单个的
function deletePortlet(){
    $('#delete').bind('click', function() {
        $(window.parent).focus();
        top.layer.confirm('确定要删除【' + $('#portletName').val() +'】门户吗?', {
            title:'提示',
            icon: 3,
            area: ['400px', ''],
            closeBtn: 0,
            btn: ['确定','取消'] //按钮
        }, function(layerIndex){
            deletePortletAjaxEvent(layerIndex);
        }, function(){

        });
    });
}
//删除
function deletePortletAjaxEvent(layerIndex){
    $.ajax({
        url:'portal/portlet/toDeletePortletConfig',
        data : {
            data : $('#id').val()
        },
        dataType : "text",
        type : 'POST',
        success : function(msg){
            try{
                parent.asynGetUserDefinedPortlet(0);
            }catch(e){

            }
            try{
                parent.document.getElementById('portletFrame').contentWindow.reloadGrid();
            }catch(e){

            }
            top.layer.close(layerIndex);
            parent.layer.msg('删除成功！');
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
            try{
                if($('#isPortal').val() == 'true'){
                    window.location = window.location;
                }
            }catch(e){}
        },
        error : function(msg){
            top.layer.msg('删除失败！');
        }
    });
}
//设置默认
function setDefaultPortlet(){
    $('#setDefault').bind('click', function() {
        setDefaultPortletEvent();
    });
}
function setDefaultPortletEvent(){
    $.ajax({
        url:'portal/portlet/toSetDefaultPortletConfig',
        data : {
            id : $('#id').val(),
            content : $('.demo').html()
        },
        dataType : "text",
        type : 'POST',
        success : function(msg){
            try{
                parent.asynGetUserDefinedPortlet();
            }catch(e){}
            top.layer.close(top.layer.index);
            parent.layer.msg('设置默认成功！');
        },
        error : function(msg){
            parent.layer.msg('设置默认失败！');
        }
    });
}
function restDefaultPortlet(){
    $('#restDefault').bind('click', function() {
        restDefaultPortletEvent();
    });
}
function restDefaultPortletEvent(){
    $.ajax({
        url:'portal/portlet/toRestDefaultPortletConfig',
        data : {
            id : $('#id').val()
        },
        dataType : "json",
        type : 'POST',
        success : function(msg){
            parent.asynGetUserDefinedPortlet();
            top.layer.close(top.layer.index);
            parent.layer.msg('恢复默认成功！');
        },
        error : function(msg){
            parent.layer.msg('恢复默认失败！');
        }
    });
}
/**
 * 异步获取portlet设置过的内容
 */
function asyncGetPortletContent(){
    $.ajax({
        type: "GET",
        url: "platform/portal/portlet/toGetPortalConfigDesignContent?o="+Math.random(),
        data: {
            id: $("#id").val()
        },
        dataType :'html',
        success: function(data) {
            $('.demo').html(data);
            //异步获取内容后，进行二次渲染
            $(".demo .column").sortable({
                opacity: .35,
                connectWith: ".column",
                start: function(e,t) {
                    if (!startdrag) stopsave++;
                    startdrag = 1;
                },
                stop: function(e,t) {
                    if(stopsave>0) stopsave--;
                    startdrag = 0;
                }
            });
            setting();
        },
        error :function(data){
            top.layer.alert('加载失败！',{
                    icon: 7,
                    area: ['400px', ''],
                    closeBtn: 0
                }
            );
        }
    });
}
function handleJsIds() {
    handleModalIds();
    handleAccordionIds();
    handleCarouselIds();
    handleTabsIds();
}
function handleAccordionIds() {
    var e = $(".demo #myAccordion");
    var t = randomNumber();
    var n = "accordion-" + t;
    var r;
    e.attr("id", n);
    e.find(".accordion-group").each(function(e, t) {
        r = "accordion-element-" + randomNumber();
        $(t).find(".accordion-toggle").each(function(e, t) {
            $(t).attr("data-parent", "#" + n);
            $(t).attr("href", "#" + r)
        });
        $(t).find(".accordion-body").each(function(e, t) {
            $(t).attr("id", r)
        });
    })
}
function handleCarouselIds() {
    var e = $(".demo #myCarousel");
    var t = randomNumber();
    var n = "carousel-" + t;
    e.attr("id", n);
    e.find(".carousel-indicators li").each(function(e, t) {
        $(t).attr("data-target", "#" + n);
    });
    e.find(".left").attr("href", "#" + n);
    e.find(".right").attr("href", "#" + n)
}
function handleModalIds() {
    var e = $(".demo #myModalLink");
    var t = randomNumber();
    var n = "modal-container-" + t;
    var r = "modal-" + t;
    e.attr("id", r);
    e.attr("href", "#" + n);
    e.next().attr("id", n)
}
function handleTabsIds() {
    var e = $(".demo #myTabs");
    var t = randomNumber();
    var n = "tabs-" + t;
    e.attr("id", n);
    e.find(".tab-pane").each(function(e, t) {
        var n = $(t).attr("id");
        var r = "panel-" + randomNumber();
        $(t).attr("id", r);
        $(t).parent().parent().find("a[href=#" + n + "]").attr("href", "#" + r);
    });
}
function randomNumber() {
    return randomFromInterval(1, 1e6)
}
function randomFromInterval(e, t) {
    return Math.floor(Math.random() * (t - e + 1) + e);
}

function configurationElm(e, t) {
    $(".demo").delegate(".configuration > a", "click", function(e) {
        e.preventDefault();
        var t = $(this).parent().next().next().children();
        $(this).toggleClass("active");
        t.toggleClass($(this).attr("rel"))
    });
    $(".demo").delegate(".configuration .dropdown-menu a", "click", function(e) {
        e.preventDefault();
        var t = $(this).parent().parent();
        var n = t.parent().parent().next().next().children();
        t.find("li").removeClass("active");
        $(this).parent().addClass("active");
        var r = "";
        t.find("a").each(function() {
            r += $(this).attr("rel") + " "
        });
        t.parent().removeClass("open");
        n.removeClass(r);
        n.addClass($(this).attr("rel"))
    })
}
function removeElm() {
    $(".demo").delegate(".remove", "click", function(e) {
        e.preventDefault();
        $(this).parent().remove();
        if (!$(".demo .lyrow").length > 0) {
            clearDemo();
        }
    });
}
function clearDemo(){
    $(".demo").empty();
    $(".demo").html("<div class='layoutTip'>拖动布局到此区域</div>");
    return false;
}
function removeMenuClasses() {
    $("#menu-layoutit li button").removeClass("active");
}
function changeStructure(e, t) {
    $("#download-layout ." + e).removeClass(e).addClass(t);
}
function cleanHtml(e) {
    $(e).parent().append($(e).children().html());
}

var currentDocument = null;
var timerSave = 1000;
var stopsave = 0;
var startdrag = 0;
var demoHtml = $(".demo").html();
var currenteditor = null;
$(window).resize(function() {
    $("body").css("min-height", $(window).height() - 90);
    $(".demo").css("min-height", $(window).height() - 160);
});


function initContainer(){
    $(".demo, .demo .column").sortable({
//		connectWith: ".column",
        opacity: .35,
        handle: ".drag",
        start: function(e,t) {
            if (!startdrag) stopsave++;
            startdrag = 1;
        },
        stop: function(e,t) {
            if(stopsave>0) stopsave--;
            startdrag = 0;
        }
    });
    configurationElm();
}


function setting(){
    var settinObj = $(".demo").find('.setting').popover({
        trigger:'manual',
        placement : 'bottom',
        title:'设置',
        html: 'true',
        content : $('#setting').html(),
        animation: false
    }).on("mouseenter", function () {
        var _this = this;
        $(this).popover("show");
        $(this).siblings(".popover").on("mouseleave", function () {
            $(_this).popover("hide");
        });
    }).on("mouseleave", function () {
        var _this = this;
        setTimeout(function () {
            if (!$(".popover:hover").length) {
                $(_this).popover("hide");
            }
        }, 100);
    }).on('shown.bs.popover', function(){
        var _self = $(this);
        //设置标题值
        var title = _self.parent('.box').find('.g-title').find('.l').text();
        //设置小页路径
        var _miniPagePath = _self.parent('.box').find('.cont').find('iframe').attr('src');
        _self.parent().find('#portletName').val(title);//设置回添
        _self.parent().find('#miniPagePath').val(_miniPagePath);//设置回添
        _self.parent().find('#portletName').on('input',function(e){
            _self.parent('.box').find('.g-title').find('.l').text($(this).val());
        });
        //设置标题是否显示
        var displayPortletTitle = _self.parent('.box').find('.g-title').css('display');//设置回添
        if(displayPortletTitle != 'none'){
            _self.parent().find("input[name='isDisplayPortletTitle']").attr("checked","true");
        } else {
            _self.parent().find("input[name='isDisplayPortletTitle']").removeAttr("checked");
        }
        _self.parent().find("input[name='isDisplayPortletTitle']").on('click', function(){
            if(!this.checked) {
                _self.parent('.box').find('.g-title').hide();
            } else {
                _self.parent('.box').find('.g-title').show();
            }
        });
        //配置了不显示标题
        var _showTitle = _self.parent('.box').find('.g-title').attr('_showTitle');
        if(_showTitle != null && _showTitle == "0"){
            if(_self.parent().find("input[name='isDisplayPortletTitle']").attr("checked")){
                _self.parent().find("input[name='isDisplayPortletTitle']").trigger("click");
            }
            _self.parent().find("input[name='isDisplayPortletTitle']").attr("disabled","disabled");
        }
        //设置主题

        _self.parent().find('.changeThemesColorColumn').on('click',function(){
            var bgColor = $(this).css('background-color');
            _self.parent('.box').find('.g-title').css('background-color',bgColor);
//    		_self.parent('.box').find('.view').css('border','1px solid ' + bgColor);
            _self.parent('.box').css('border','1px solid ' + bgColor);
        });
        var viewHeight;
//    	var setst=setime
        //初始化slider,并设置高度
        if(!viewHeight){
            viewHeight = _self.parent('.box').find('.cont').css('height');
        }
        $("#sliderValue").val(parseInt(viewHeight));

//    	$('#slider').slider({
//    		min: -200,
//    		max: 200,
//    		step: 10,
//    		value: 0,
//    		change:function(event,ui){
//    			if(!viewHeight){
//    				viewHeight = _self.parent('.box').find('.cont').css('height');
//    			}
//    			$("#sliderValue").val(parseInt(viewHeight) + ui.value);
//    			_self.parent('.box').find('.cont').css('height',parseInt(viewHeight) + ui.value);
//    			_self.parent('.box').find('iframe').css('height',parseInt(viewHeight) + ui.value);
//    		}
//    	});
        $('#slider').slider({
            value: $("#sliderValue").val(),
            min: 0,
            max: 2000,
            step: 10,
            change:function(event,ui){
                if(!viewHeight){
                    viewHeight = _self.parent('.box').find('.cont').css('height');
                }
                _self.parent('.box').find('.cont').css('height',ui.value);
                _self.parent('.box').find('iframe').css('height', ui.value);
            },slide: function( event, ui ) {
                $("#sliderValue").val(ui.value);
            }
        });
        $("#sliderValue").on('keyup',function(e){
            var sliderValue = $("#sliderValue").val();
            var defaultHeight="315";
            if(sliderValue == null || sliderValue == ''){
                $("#sliderValue").val(defaultHeight);
            }else{
                if(!(/(^[1-9]\d*$)/.test(sliderValue))){
                    $("#sliderValue").val(defaultHeight);
                }else if(sliderValue>2000){
                    $("#sliderValue").val(defaultHeight);
                }
            }
            $('#slider').slider("value", $("#sliderValue").val());
            _self.parent('.box').find('.cont').css('height',$("#sliderValue").val());
            _self.parent('.box').find('iframe').css('height',$("#sliderValue").val());
        });

        //初始化刷新
        _self.parent().find("input[name='isAutoRefresh']").on('click', function(){
            if(this.checked) {
                _self.parent().find('#refreshRateStatus').show();
                _self.parent().find('#refreshRateStatusTip').show();
            } else {
                _self.parent().find('#refreshRateStatus').hide();
                _self.parent().find('#refreshRateStatusTip').hide();
            }
        });
    });
}
