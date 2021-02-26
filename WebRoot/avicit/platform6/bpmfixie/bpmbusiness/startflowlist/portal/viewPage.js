$(function(){
	nwListLiEvent();
	nwCardEvent();
});

function nwListLiEvent(){
	$('.nw-list ul li').on('mouseenter',function(){
		$(this).addClass('on');
	}).on('mouseleave',function(){
		$(this).removeClass('on').removeClass('open');
	});
}

function nwCardEvent(){
	$('.nw-card').on('mouseenter',function(){
		$(this).addClass('on');
	}).on('mouseleave',function(){
		$(this).removeClass('on');
	});
}
$(function(){
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
                        	$(".newWorkflow").children(".nw-cont:eq(0)").find(".nw-body").append(getModuleTemplate(d.title,d.pdid,colorList[i%5]));
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

function getModuleTemplate(title, pdid, color) {
    var c = color? color : "blue";
    return '<div class="nw-card '+c+'" >'  +
        ' <div class="txt" onclick="flowUtils.openOnDialog(\'platform/bpm/business/start?defineId='+pdid+'\',\''+title+'\')" title="'+title+'">' +
        '  <input type="hidden" value="'+pdid+'">' +
        '  <i class="icon icon-shouwenguanli">&#xe680;</i><p>' +title +
        '     </p></div>' +
        '      </div>';

}
function deleteFav(pdid,that) {
    doFav(pdid, "unfollow",that);
}