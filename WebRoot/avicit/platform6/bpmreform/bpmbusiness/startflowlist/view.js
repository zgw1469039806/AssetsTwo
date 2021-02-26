$(function(){
   $("a[name='bpmDoFav']").on('click',function(){
       var pdid = $(this).find("input").val();
       if(typeof  pdid == 'undefined' || pdid == '') {
           flowUtils.error("流程id不能为空");
           return;
       }
      if($(".newWorkflow").children(".nw-cont:eq(0)").find("input[value='"+pdid+"']").length < 1){
          var title = $(this).parentsUntil(".nw-l-cont").prev("a").text();
          doFav(pdid+"@@"+title, "follow", this);
      } else {
          flowUtils.error("您已经收藏了该流程");
      }
   }) ;

    $('.slideup').each(function() {
        $(this).on('click', function() {
            $(this).parents('.nw-list').find('li').slideToggle(300, function() {
                //setTimeout('resizeWorkFlowWin()', 500);
            });
            $(this).toggleClass("on");
        });
    });

   var searchInx = 0;
    //$("#search").on("change", function () {
    $("#search").keydown(function (event) {
        if(event.keyCode!=13){
            return;
        }
        $(this).blur();
    });
    $("#search").blur(function(){
        searchInx = 0;
        $(".height-text").each(function (i, n) {
            $(this).parents(".a-text").html($(this).parents(".a-text").attr("_text"));
        });
        var searchtext = $.trim($(this).val());
        searchtext = stripscript(searchtext);
        if(searchtext != ""){
            var reg = new RegExp("(" + searchtext + ")","ig");
            $(".a-text").each(function (i, n) {
                n.innerHTML = n.innerHTML.replace(reg, "<span class='height-text'>$1</span>");
            });
        }
    });

    function stripscript(s){
        var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
        var rs = "";
        for (var i = 0; i < s.length; i++) {
            rs = rs+s.substr(i, 1).replace(pattern, '');
        }
        return rs;
    }

    $(document).keydown(function(event){
        if(event.keyCode==13){
            selectSearchText();
        }
    });

    $("#search").next().on("click", function () {
        selectSearchText();
    });

    function selectSearchText() {
        var $searchArr = $(".height-text");
        if($searchArr.length == 0){
            return;
        }
        if($searchArr.length <= searchInx){
            searchInx = 0;
        }
        $searchArr.removeClass("entryOn");
        $searchArr.eq(searchInx).addClass("entryOn");
        $searchArr.eq(searchInx).parents("a").focus();
        $searchArr.eq(searchInx).parents("a").blur();
        searchInx ++;
    }

    init();

   function init() {
       $.ajax({
           url : 'platform/bpm/business/getBmpFavs',
           type : 'post',
           dataType : 'json',
           success : function(r) {
               if (r.status == 0) {
                    for(var i = 0; i < r.data.length ; i++) {
                        var d = r.data[i];
                        if($(".newWorkflow").children(".nw-cont:eq(1)").find("input[value='"+d.pdid+"']").length > 0){
                            var pdName = $(".newWorkflow").children(".nw-cont:eq(1)").find("input[value='"+d.pdid+"']").attr("_text");
                        	$(".newWorkflow").children(".nw-cont:eq(0)").find(".nw-body").append(getModuleTemplate(d.title,d.pdid,colorList[i%5], pdName));
                        }
                    }
               } else {
                   flowUtils.error("初始化错误")
               }
           }
       });
   }

});



var colorList = ["blue","aqua", "orange", "green", "yellow"];

function doFav(value ,act,that) {
    $.ajax({
        url : 'platform/bpm/business/doBmpFav',
        data : {
            value : value,
            act : act
        },
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.status == 0) {
                if(act == 'follow') {
                    var title = $(that).parentsUntil(".nw-l-cont").prev("a").text();
                    var b = $(".newWorkflow").children(".nw-cont:eq(0)").find(".nw-body");
                    var pdid = value.slice(0,value.indexOf("@@"));
                    b.append(getModuleTemplate(title,pdid, colorList[(b.children().length + 1) % 5]));
                } else {
                    $(that).parent().remove();
                }
                flowUtils.success("操作成功");
            } else {
                flowUtils.error(r.err);
            }
        }
    });
}

function getModuleTemplate(title, pdid, color, pdName) {
    var showTitle = title;
    if(flowUtils.notNull(pdName)){
        showTitle = pdName;
    }
    var c = color? color : "blue";
    return '<div class="nw-card '+c+'" >'  +
        ' <div class="txt" onclick="flowUtils.openOnDialog(\'platform/bpm/business/start?defineId='+pdid+'\',\''+showTitle+'\')" title="'+showTitle+'">' +
        '  <input type="hidden" value="'+pdid+'">' +
        '  <i class="icon icon-shouwenguanli"></i><div class="wd"><p>' +showTitle +
        '     </p></div></div>' +
        '   <a class="close glyphicon glyphicon-remove" href="javascript:void(0)" onclick="deleteFav(\''+pdid+'@@'+title+'\',this);"></a>' +
        '      </div>';

}
function deleteFav(pdid,that) {
    doFav(pdid, "unfollow",that);
}

/*//ie9以上美化滚动条
function perfectScroll(dom) {
    dom.perfectScrollbar();
}
//美化滚动条
$(function() {
	perfectScroll($('body'));
});*/
