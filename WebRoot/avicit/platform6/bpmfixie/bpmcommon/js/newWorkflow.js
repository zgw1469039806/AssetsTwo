$(function(){
	nwListLiEvent();
});

function nwListLiEvent(){
	$('.nw-list ul li').on('mouseenter',function(){
		$(this).addClass('on');
	}).on('mouseleave',function(){
		$(this).removeClass('on').removeClass('open');
	});
}