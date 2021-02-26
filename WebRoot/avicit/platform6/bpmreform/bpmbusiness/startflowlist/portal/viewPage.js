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

function getModuleTemplate(title, pdid, color) {
    var c = color? color : "blue";
    return '<div class="nw-card '+c+'" >'  +
        ' <div class="txt" onclick="flowUtils.openOnDialog(\'platform/bpm/business/start?defineId='+pdid+'\',\''+title+'\')" title="'+title+'">' +
        '  <input type="hidden" value="'+pdid+'">' +
        '  <i class="icon icon-shouwenguanli"></i><div class="wd"><p>' + title +
        '     </p></div></div>' +
        '   <a href="javascript:void(0)" onclick="deleteFav(\''+pdid+'@@'+title+'\',this);"></a>' +
        '      </div>';

}
function deleteFav(pdid,that) {
    doFav(pdid, "unfollow",that);
}

//ie9以上美化滚动条
function perfectScroll(dom) {
   dom.perfectScrollbar();
}
//美化滚动条
$(function() {
	perfectScroll($('body'));
});