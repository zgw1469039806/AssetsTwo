$(function(){
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
		//setHeight($(this));
	});

	var navbarHeight = $('.navbar').height();
	function resetPh(){
		var wH = $(window).innerHeight();
		var pH = wH - navbarHeight - $("#property_div .panel-heading").innerHeight()-20;
		$("#property_div .panel-body")
			.css('height',pH)
			.find('.twoTabNav')
			.css('height',pH - 50);
		$("#toolbar_div .panel-body")
			.css('height',pH);
	}
	$(window).on('resize',function(){
		resetPh();
	});
	var pHtimer = setInterval(function(){
		if(!$('#loadingDiv').length){
			setTimeout(function(){
				$(window).trigger('resize');
			},500);
			clearInterval(pHtimer);
		}
	},500);


	// 例子里设置表单默认高 .twoTabNav为双标签栏表单的父框架class
	// 实际生产环境中如果手写了初始展示的标签内容的高度 可不初始化本方法
//	setHeight(setHeight($('.twoTabNav .nav-tabs:last>li.active')));
});