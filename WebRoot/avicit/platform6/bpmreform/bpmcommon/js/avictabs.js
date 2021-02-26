(function($){
	$.fn.avictabs = function(opt){
		var options = {
			onSwitch:'',
			success:''
			//扩展预留
		},that = this;
		//扩展预留
		var setting = $.extend(options,opt);

		var tabbar = this.find('.tab-bar'),
			tabpanel = this.find('.tab-panel');
		function resizeWin(){
			var tabbar = that.find('.tab-bar'),
				tabpanel = that.find('.tab-panel');
			var baseHeight = $('body').innerHeight() - tabbar.outerHeight() - 1,
				baseWidth = $('body').width() - $('.editFrom').width();
			// tabpanel.height(baseHeight);

			if(tabpanel.find('>.panel-body:eq(0)').height() < baseHeight - 5 ){
				tabpanel.find('>.panel-body:eq(0)').css({
					width:baseWidth,
					height:baseHeight - 5
				});
			}

			tabpanel.find('>.panel-body:gt(0)').css({
				width:baseWidth,
				height:baseHeight - 5
			});
		}

		window.avicTabResizeWin = resizeWin;

		resizeWin();

		$(window).on('resize',function(){
			avicTabResizeWin();
		});

		var index = tabbar.find('.on').index();
		tabpanel.find('>.panel-body').eq(index).addClass('on');

		tabbar.find('>ul>li').on('click',function(){
			if(!tabpanel.has('>.panel-body:eq('+$(this).index()+')').length){
				alert('<'+$(this).text()+'>标签没有子面板');
				return;
			}
			var url = $(this).attr('rel'),that = $(this);
			var targetDom = tabpanel.find('>.panel-body:eq('+$(this).index()+')');
			$(this)
				.addClass('on')
				.siblings("li")
				.removeClass("on");
			targetDom
				.addClass('on')
				.siblings('.panel-body')
				.removeClass('on');
			if(url){
				if(targetDom.find('>iframe').length){
					if(targetDom.find('>iframe').attr('src') != url){
						targetDom.find('>iframe').attr('src',url);
					}
				}else{
					targetDom
						.empty()
						.append('<iframe src="'+url+'" frameborder="0"></iframe>');
				}
			}
			if(setting.onSwitch && typeof setting.onSwitch === "function"){
				setting.onSwitch(that);
			}
		});
		if(setting.success && typeof setting.success === "function"){
			setting.success(that);
		}
	};
})(jQuery);