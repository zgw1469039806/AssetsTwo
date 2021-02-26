(function($){

	/**
	 * 用class名称加载
	 */
	$(function(){
		if($('.easyui-subwindow').length > 0){
			$('.easyui-subwindow').subwindow({});
		}
	});
	
	/**
	 * 初始化
	 */
	function init(target){
		var t = $(target);
		t.addClass('subwindow-f').hide();
		
		var span = $(
				'<span class="combo">' +
				'<input type="text" class="combo-text" autocomplete="off" value="'+ t.val() +'">' +
				'<span><span class="combo-arrow subwindow-arrow"></span></span>' +
				'<input type="hidden" class="combo-value" value="'+ t.val() +'">' +
				'</span>'
				).insertAfter(target);
		
		
		//替换input
		var name = $(target).attr('name');
		if (name){
			span.find('input.combo-value').attr('name', name);
			$(target).removeAttr('name').attr('comboName', name);
		}

		return {
			subwindow: span
		};
	}
	
	/**
	 * 创建
	 */
	function buildSubwindow(target){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		if (opts.hasDownArrow){
			subwindow.find('.combo-arrow').show();
		} else {
			subwindow.find('.combo-arrow').hide();
		}
		setDisabled(target, opts.disabled);
		setReadonly(target, opts.readonly);
	}
	
	/**
	 * 修改大小
	 */
	function setSize(target){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		
		var c = $(target).clone();
		c.css('visibility','hidden');
		c.appendTo('body');
		var width = c.outerWidth();
		var height = c.outerHeight();
		c.remove();

		var input = subwindow.find('input.combo-text');
		var arrow = subwindow.find('.combo-arrow');
		var arrowWidth = opts.hasDownArrow ? arrow._outerWidth() : 0;
		
		subwindow._outerWidth(width)._outerHeight(height);
		input._outerWidth(subwindow.width() - arrowWidth);
		input.css({
			height: subwindow.height()+'px',
			lineHeight: subwindow.height()+'px'
		});
		arrow._outerHeight(subwindow.height());
		subwindow.insertAfter(target);
	}
	
	/**
	 * 绑定事件
	 */
	function bindEvents(target){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		var input = subwindow.find('.combo-text');
		var arrow = subwindow.find('.combo-arrow');
		
		input.unbind('.combo');
		arrow.unbind('.combo');

		if (!opts.disabled && !opts.readonly){
			input.bind('click.combo', function(e){
				if (!opts.editable){
					opts.onClick.call(this);
				} 
			}).bind('keydown.combo', function(e){
				switch(e.keyCode){
					case 38:	// up
						opts.keyHandler.up.call(target, e);
						break;
					case 40:	// down
						opts.keyHandler.down.call(target, e);
						break;
					case 37:	// left
						opts.keyHandler.left.call(target, e);
						break;
					case 39:	// right
						opts.keyHandler.right.call(target, e);
						break;
					case 13:	// enter
						e.preventDefault();
						opts.keyHandler.enter.call(target, e);
						return false;
					case 9:		// tab
					case 27:	// esc
						break;
					default:
						if (opts.editable){
							if (state.timer){
								clearTimeout(state.timer);
							}
							state.timer = setTimeout(function(){
								var q = input.val();
								if (state.previousValue != q){
									state.previousValue = q;
									setValue(target, input.val());
									opts.keyHandler.query.call(target, input.val(), e);
									$(target).subwindow('validate');
								}
							}, opts.delay);
						}
				}
			});
			
			arrow.bind('click.combo', function(){
				opts.onClick.call(this);
			}).bind('mouseenter.combo', function(){
				$(this).addClass('combo-arrow-hover');
			}).bind('mouseleave.combo', function(){
				$(this).removeClass('combo-arrow-hover');
			});
		}
	}
	
	/**
	 * 构造方法
	 */
	$.fn.subwindow = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.subwindow.methods[options];
			if (method){
				return method(this, param);
			} else {
				return this.each(function(){
					var input = $(this).subwindow('textbox');
					input.validatebox(options, param);
				});
			}
		}
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'subwindow');
			if (state){
				$.extend(state.options, options);
			} else {
				var r = init(this);
				state = $.data(this, 'subwindow', {
					options: $.extend({}, $.fn.subwindow.defaults, $.fn.subwindow.parseOptions(this), options),
					subwindow: r.subwindow,
					previousValue: null
				});
				$(this).removeAttr('disabled');
			}
			validate(this);
			buildSubwindow(this);
			setSize(this);
			bindEvents(this);
		});
	};
	
	/**
	 * 方法
	 */
	$.fn.subwindow.methods = {
		options: function(jq){
			return $.data(jq[0], 'subwindow').options;
		},
		textbox: function(jq){
			return $.data(jq[0], 'subwindow').subwindow.find('input.combo-text');
		},
		clear: function(jq){
			return jq.each(function(){
				clear(this);
			});
		},
		reset: function(jq){
			return jq.each(function(){
				reset(this);
			});
		},
		getValue: function(jq){
			return getValue(jq[0]);
		},
		setValue: function(jq, value){
			return jq.each(function(){
				setValue(this, value);
			});
		},
		disable: function(jq){
			return jq.each(function(){
				setDisabled(this, true);
				bindEvents(this);
			});
		},
		enable: function(jq){
			return jq.each(function(){
				setDisabled(this, false);
				bindEvents(this);
			});
		},
		readonly: function(jq, mode){
			return jq.each(function(){
				setReadonly(this, mode);
				bindEvents(this);
			});
		},
		destroy: function(jq){
			return jq.each(function(){
				destroy(this);
			});
		}
	};
	
	/**
	 * 获取参数
	 */
	$.fn.subwindow.parseOptions = function(target){
		var t = $(target);
		return $.extend({}, $.fn.validatebox.parseOptions(target), $.parser.parseOptions(target, [
			{editable:'boolean', disabled:'boolean', readonly:'boolean', hasDownArrow:'boolean',delay:'number'}
		]), {
			editable: (t.attr('editable') ? ((t.attr('editable') == 'false') ? false: true) : undefined),
			disabled: (t.attr('disabled') ? true : undefined),
			readonly: (t.attr('readonly') ? true : undefined),
			value: (t.val() || undefined)
		});
	};

	/**
	 * 默认参数
	 */
	$.fn.subwindow.defaults = $.extend({}, $.fn.validatebox.defaults, {
		editable: true,
		disabled: false,
		readonly: false,
		hasDownArrow: true,
		value: '',
		delay: 200,
		deltaX: 19,
		keyHandler: {
			up: function(e){},
			down: function(e){},
			left: function(e){},
			right: function(e){},
			enter: function(e){},
			query: function(q,e){}
		},
		onClick: function(){},
		onChange: function(newValue, oldValue){}
	});
	
	/**
	 * 获取值
	 */
	function getValue(target){
		var state = $.data(target, 'subwindow');
		var subwindow = state.subwindow;
		return subwindow.find('input.combo-value').val();
	}
	
	/**
	 * 设置值
	 */
	function setValue(target, value){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		var oldValue = getValue(target);
		subwindow.find('input.combo-value').val(value);
		subwindow.find('input.combo-text').val(value);
		state.previousValue = value;
		if (value != oldValue){
			opts.onChange.call(target, value, oldValue);
		}
	}
	
	/**
	 * 清除内容
	 */
	function clear(target){
		var state = $.data(target, 'subwindow');
		var subwindow = state.subwindow;
		subwindow.find('input.combo-value').val('');
		subwindow.find('input.combo-text').val('');
	}
	
	/**
	 * 重置内容
	 */
	function reset(target){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		subwindow.find('input.combo-value').val(opts.value);
		subwindow.find('input.combo-text').val(opts.value);
	}
	
	/**
	 * 加载验证
	 */
	function validate(target){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		var input = $(target).subwindow('textbox');
		input.validatebox($.extend({}, opts, {
			deltaX: (opts.hasDownArrow ? opts.deltaX : (opts.deltaX>0?1:-1))
		}));
	}
	
	/**
	 * 设置是否可用
	 */
	function setDisabled(target, disabled){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		if (disabled){
			opts.disabled = true;
			$(target).attr('disabled', true);
			subwindow.find('.combo-value').attr('disabled', true);
			subwindow.find('.combo-text').attr('disabled', true).addClass('disabled').addClass('pt6-disabled');
			subwindow.find('.combo-text').css('cursor', 'auto');
			subwindow.find('.combo-arrow').css('cursor', 'auto');
		} else {
			opts.disabled = false;
			$(target).removeAttr('disabled');
			subwindow.find('.combo-value').removeAttr('disabled');
			subwindow.find('.combo-text').removeAttr('disabled').removeClass('disabled').removeClass('pt6-disabled');
			if(!opts.readonly){
				subwindow.find('.combo-text').css('cursor', opts.editable ? 'auto': 'pointer');
				subwindow.find('.combo-arrow').css('cursor', 'pointer');
			}
		}
	}
	
	/**
	 * 设置只读
	 */
	function setReadonly(target, mode){
		var state = $.data(target, 'subwindow');
		var opts = state.options;
		var subwindow = state.subwindow;
		opts.readonly = mode==undefined ? true : mode;
		var readonly = opts.readonly ? true : (!opts.editable);
		subwindow.find('.combo-text').attr('readonly', readonly);
		if(opts.readonly){
			subwindow.find('.combo-text').css('cursor', 'auto');
			subwindow.find('.combo-arrow').css('cursor', 'auto');
			subwindow.find('.combo-text').addClass('input-readonly');
		}else{
			subwindow.find('.combo-text').removeClass('input-readonly');
			if(!opts.disabled){
				subwindow.find('.combo-text').css('cursor', opts.editable ? 'auto': 'pointer');
				subwindow.find('.combo-arrow').css('cursor', 'pointer');
			}
		}
	}
	
	/**
	 * 摧毁方法
	 */
	function destroy(target){
		var state = $.data(target, 'subwindow');
		var input = state.subwindow.find('input.combo-text');
		input.validatebox('destroy');
		state.subwindow.remove();
		$(target).remove();
	}
})(jQuery);
