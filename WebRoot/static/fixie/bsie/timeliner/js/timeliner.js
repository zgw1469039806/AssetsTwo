(function($){
	$.fn.timeliner = function(opt){
		var options = {
			marginBottom:40,
			data:''
			//扩展预留
		},that = this;
		//扩展预留
		var setting = $.extend(options,opt);

		function renderLiner(data){
			var tdom = $('<div class="t-dom"></div>'),tchild;
			$.each(data.list,function(i,v){
				tchild = $('<div class="t-child"></div>'),tbody = $('<div class="t-body"><ul></ul></div>');
				tchild.append('<div class="t-title">'+v.title+'</div>');
				var childv = v;
				$.each(v.list,function(i,v){
					var li = $('<li><div class="l">'+v.l+'</div><div class="p"></div><div class="r">'+v.r+'</div></li>');
					if((i+1) != childv.list.length){
						li.css({
							marginBottom:setting.marginBottom
						});
					}
					tbody.find('ul').append(li);
				});
				tchild.append(tbody);
				tdom.append(tchild);
			});
			that.empty().append(tdom);
		}

		if(setting.data){
			renderLiner(setting.data);
		}else{
			var url = this.attr('rel');
			if(!url) return;
			$.ajax({
				url:url,
				type:'get',
				dataType:'json',
				success:function(data){
					renderLiner(data);
				}
			});
		}
	};
})(jQuery);