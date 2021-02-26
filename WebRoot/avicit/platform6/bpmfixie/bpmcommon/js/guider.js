$(function(){
	// 监听刷新
	$('.refresh').on("click",function(e){
		e.stopPropagation();
		var win = $(this).parents('.guider').find('.cont iframe'),
			url = win.attr('src');
		win.attr('src',url);
	});
});