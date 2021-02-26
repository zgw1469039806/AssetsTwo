// 树列表切换联动右侧菜篮的动效
function cbBoxMoving(tree) {
    var box = $("#cb-for-" + tree),
        arrow = $('.c-list-arr em');
    arrow.css('top', box.position().top + (box.height()/2 - arrow.height()/2));
}

// 初始化批示表单内控件
function initComment(actorModel) {
    //formatTree();


    // 初始化模块移动
	/**
    formatDrag($('#cba-for-tree1'), 'div', function () {
        alert('移动结束1');
    },true);
    formatDrag($('#cba-for-tree2'), 'div', function () {
        alert('移动结束2');
    },true);
    formatDrag($('#cba-for-tree3'), 'div', function () {
        alert('移动结束3');
    },true);
    formatDrag($('#cba-for-tree4'), 'div', function () {
        alert('移动结束4');
    },true);
    formatDrag($('#setting-msg-drag'), 'li', function () {
        alert('移动结束5');
    },false,".drag");
*/
    //批示页树组件列表左侧页签
    $('.tree-nav li').on('click', function () {
        var tree = $(this).data('for');
        var treedom = $(this).parents('.tree-list').find("#" + tree);
        treedom.show().siblings('.tree-nav-panel').hide();
        $(this).addClass('on').siblings('li').removeClass('on');
        $("#cb-for-" + tree).addClass('on').siblings('.checked-box').removeClass('on');
        cbBoxMoving(tree);
        $("#cb-for-" + tree).parents('.checkedbox-list').animate({
            scrollTop: $("#cb-for-" + tree).position().top
        }, 500);
    });

    //批示页树组件列表分页内页签
    $('.sub-tree-nav li').on('click', function () {
        var tree = $(this).data('for');
        var treedom = $(this).parents('.tree-nav-panel').find("#" + tree);
        treedom.show().siblings('div').hide();
        $(this).addClass('on').siblings('li').removeClass('on');
        if (!treedom.find('.ztree li').length) {
            treedom.find('.ztree').empty();
            //formatTree(treedom);
        }
    });

    // 已选区域标签单点事件
    $('.c-list-boxes').off().delegate('.elm-checked', 'click', function () {
/*        if ($(this).siblings().hasClass('on')) {
            layer.msg('一次只能选择一个');
        } else {
            $(this).toggleClass('on');
        }*/
        $(this).toggleClass('on');
    });

    // 批示窗口右侧菜篮直接点击事件
    $('.checked-box').off().on('click', function () {
        var tree = $(this).data("for");
        cbBoxMoving($(this).data("for"));
        $("#cb-for-" + tree).addClass('on').siblings('.checked-box').removeClass('on');
        $('.tree-nav').find("li[data-for='" + tree + "']").trigger('click');
    });

    // 表单内单个标签置顶按钮功能
    $('.c-list-boxes .top').off().on('click', function () {
        var box = $(this).parents('.checked-box');
        var obj = box.find('.elm-checked.on').clone(true);
        box.find('.elm-checked.on').remove();
        box.find(".cb-checked-area").prepend(obj);
    });
    // 表单内单个标签置底按钮功能
    $('.c-list-boxes .bottom').off().on('click', function () {
        var box = $(this).parents('.checked-box');
        var obj = box.find('.elm-checked.on').clone(true);
        box.find('.elm-checked.on').remove();
        box.find(".cb-checked-area div:last").after(obj);
    });
    // 表单内单个标签删除按钮功能
    $('.c-list-boxes .del').off().on('click', function () {
        var box = $(this).parents('.checked-box');
        var checkedObjArr = box.find('.elm-checked.on');
        for(var ii=0;ii<checkedObjArr.length;ii++){
            var $checkObj = $(checkedObjArr[ii]);
            var treeid = $checkObj.data('treeid');
            var id =  $checkObj.attr("id");
            var dataType = $checkObj.data('type');
            var activityName = $checkObj.data('activityname');
            //自定义选人添加的记录没有对应的treeid
            if(treeid!=undefined && treeid!=''){
                for(var i = 0; i < treeArr.length; i++){
                    var activityTree = treeArr[i];
                    if(activityTree.activityName == activityName){
                        var tree = activityTree.tree;
                        var nodes = tree.getNodesByParam("id", id);
                        if(nodes != null && nodes.length > 0){
                            for(var j = 0; j < nodes.length; j++){
                                tree.checkNode(nodes[j], false, true);
                            }
                        }
                    }

                }
            }

            $(".user-lsit").find("input[value='"+id+"']").removeAttr("checked");
            $checkObj.remove();
        }
        /*if (!box.find('.elm-checked').length) {
            $(this).parent().removeClass('on');
        }*/
    });
    // 表单内清理按钮功能
    $('.c-list-boxes .clear').off().on('click', function () {
        var box = $(this).parents('.checked-box');
        var els = box.find(".cb-checked-area .elm-checked");
        $.each(els, function (ii, v) {
            var treeid = $(v).data('treeid');
            var id =   $(v).attr("id");
            var dataType =  $(v).data('type');
            var activityName = $(v).data('activityname');
            //自定义选人添加的记录没有对应的treeid
            if(treeid!=undefined && treeid!=''){
                for(var i = 0; i < treeArr.length; i++){
                    var activityTree = treeArr[i];
                    if(activityTree.activityName == activityName){
                        var tree = activityTree.tree;
                        var nodes = tree.getNodesByParam("id", id);
                        if(nodes != null && nodes.length > 0){
                            for(var j = 0; j < nodes.length; j++){
                                tree.checkNode(nodes[j], false, true);
                            }
                        }
                    }
                }
            }

            $(".user-lsit").find("input[value='"+id+"']").removeAttr("checked");
        })
        box.find(".cb-checked-area").empty();
        //$(this).parent().removeClass('on');
    });
}


//初始化指定拖拽模块
function formatDrag(dom, elm, fun,float,ds) {
	float = (float)?'float:left':'';
    if(!dom.find('div').length || dom.hasClass('draging')) return;
    dom.dragsort({
        dragSelector: ds||elm,
        placeHolderTemplate: "<"+elm+" style='"+float+"' class='placeHolder'></"+elm+">",
        dragEnd: function () {
            // 排序完成后执行方法 this为被排序对象
            fun.apply();
        }
    });
    dom.addClass('draging');
}
