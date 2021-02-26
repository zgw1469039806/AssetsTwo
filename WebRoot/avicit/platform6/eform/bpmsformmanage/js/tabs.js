function getPar($this){
    if(!$this) return false;
    if($this.parents().hasClass('tab-cont')){
        return getPar($this.parents('.tab-cont:last'));
    }else if($this.parent().hasClass('nav-tabs')){
        return $this.parent();
    }
    return $this.parent().find('>.nav-tabs');
}
function setHeight($this){
    var par = getPar($this);
    if(!par) return false;
    var fH = par.parent().height();
    var fcont = $this.parent().siblings('.tab-cont');

    par.parent().find('.tab-cont').removeAttr('style');
    fcont.height(fH - (fcont.offset().top - par.offset().top));
}
$('.nav-tabs>li').on('click',function(){
    var that = $(this);
    var clazz = that.attr("class");
    if (clazz){
        clazz = clazz.replace("active","");
        clazz = $.trim(clazz);
        that = $("."+clazz);
    }
    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.nav-tabs')
        .siblings('.tab-cont')
        .find('>li:eq('+that.index()+')')
        .addClass('active')
        .siblings('li')
        .removeClass('active');
    // 设置高度
  //  setHeight($(this));

    $(window).resize();
});