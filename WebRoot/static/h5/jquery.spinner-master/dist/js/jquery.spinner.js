/*
 * jquery.spinner
 * https://github.com/vsn4ik/jquery.spinner
 * Copyright Vasily A., 2015&ndash;2017
 * Copyright xixilive, 2013&ndash;2015
 * Licensed under the MIT license
 */

'use strict';

(function(factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD. Register as an anonymous module
		define([ 'jquery' ], factory);
	} else if (typeof exports === 'object') {
		// Node/CommonJS
		module.exports = factory(require('jquery'));
	} else {
		// Browser globals
		factory(jQuery);
	}
})(function($) {

	var spinningTimer;
	var Spinner;
	var Spinning = function($element, options) {
		this.$el = $element;
		this.options = $.extend({}, Spinning.rules.defaults,
				Spinning.rules[options.rule] || {}, options);
		this.min = Number(this.options.min) || 0;
		this.max = Number(this.options.max) || 999999999999;

		this.$el.on({
			'focus.spinner' : $.proxy(function(e) {
				e.preventDefault();
				$(document).trigger('mouseup.spinner');
				var temp = this.$el.val();
				this.$el.val(delcommafy(temp,this.options.hascommafy));
				this.oldValue = temp;
			}, this),
			'blur.spinner' : $.proxy(function(e) {
				e.preventDefault();
				$(document).trigger('mouseup.spinner');
				var temp = delcommafy(this.$el.val(),this.options.hascommafy);
				this.value(temp);
				//this.$el.val(commafy(this.numeric(temp)));
			}, this),
			'change.spinner' : $.proxy(function(e) {
				e.preventDefault();
				var temp = this.$el.val();
				this.$el.val(commafy(temp,this.options.hascommafy));
			}, this),
			'keydown.spinner' : $.proxy(function(e) {
				var dir = {
					38 : 'up',
					40 : 'down'
				}[e.which];

				if (dir) {
					e.preventDefault();
					this.spin(dir);
				}
			}, this)
		});

		//init input value
		this.oldValue = this.value();
		//[支持没有value或value设置为空，显示也为空]没有value不再设置默认数字
		if (this.$el.val() !== '') {
			this.value(this.$el.val());
		}
		return this;
	};

	Spinning.rules = {
		defaults : {
			min : null,
			max : null,
			step : 1,
			precision : 0
		},
		currency : {
			min : 0.00,
			max : null,
			step : 0.01,
			precision : 2
		},
		quantity : {
			min : 1,
			max : 999,
			step : 1,
			precision : 0
		},
		percent : {
			min : 1,
			max : 100,
			step : 1,
			precision : 0
		},
		month : {
			min : 1,
			max : 12,
			step : 1,
			precision : 0
		},
		day : {
			min : 1,
			max : 31,
			step : 1,
			precision : 0
		},
		hour : {
			min : 0,
			max : 23,
			step : 1,
			precision : 0
		},
		minute : {
			min : 1,
			max : 59,
			step : 1,
			precision : 0
		},
		second : {
			min : 1,
			max : 59,
			step : 1,
			precision : 0
		}
	};

	Spinning.prototype = {
		spin : function(dir) {
			if (this.$el.prop('disabled') || this.$el.prop('readonly')) {
				return;
			}

			this.oldValue = delcommafy(this.value(),this.options.hascommafy);
			var step = $.isFunction(this.options.step) ? this.options.step
					.call(this, dir) : this.options.step;
			var multipler = dir === 'up' ? 1 : -1;
			//[支持没有value或value设置为空，显示也为空] value为空，设置默认最小值
			if (this.oldValue === null || this.oldValue === undefined
					|| this.oldValue === '') {
				this.value(commafy(this.numeric(delcommafy(this.$el.val(),this.options.hascommafy)),this.options.hascommafy));
			} else {
				this.value(commafy(Number(this.oldValue) + Number(step)
						* multipler),this.options.hascommafy);
			}
		},

		value : function(v) {
			if (v === null || v === undefined || v === "") {
				//[支持没有value或value设置为空，显示也为空]input的value为空，也返回空
				if (this.$el.val() === '') {
					return '';
				} else {
					return commafy(this.numeric(delcommafy(this.$el.val(),this.options.hascommafy)),this.options.hascommafy);
				}
			}
			v = this.numeric(delcommafy(v,this.options.hascommafy));

			var valid = this.validate(v);
			if (valid !== 0) {
				v = (valid === -1) ? this.min : this.max;
			}
			this.$el.val(commafy(v.toFixed(this.options.precision),this.options.hascommafy));

			if (Number(delcommafy(this.oldValue,this.options.hascommafy)) !== Number(delcommafy(this
					.value(),this.options.hascommafy))) {
				// changing.spinner
				this.$el.trigger('changing.spinner', [ this.value(),
						this.oldValue ]);

				// lazy changed.spinner
				clearTimeout(spinningTimer);
				spinningTimer = setTimeout($.proxy(function() {
					this.$el.trigger('changed.spinner', [ this.value(),
							this.oldValue ]);
				}, this), Spinner.delay);
			}
		},

		numeric : function(v) {
			v = this.options.precision > 0 ? parseFloat(v, 10)
					: parseInt(v, 10);

			// If the variable is a number
			if (isFinite(v)) {
				return v;
			}

			return v || this.options.min || 0;
		},

		validate : function(val) {
			if (this.options.min !== null && val < this.min) {
				return -1;
			}

			if (this.options.max !== null && val > this.max) {
				return 1;
			}

			return 0;
		}
	};

	Spinner = function(element, options) {
		this.$el = $(element);
		this.$spinning = this.$el.find('[data-spin="spinner"]');

		if (this.$spinning.length === 0) {
			this.$spinning = this.$el.find(':input[type="text"]');
		}

		options = $.extend({}, options, this.$spinning.data());

		this.spinning = new Spinning(this.$spinning, options);

		this.$el.on('click.spinner', '[data-spin="up"], [data-spin="down"]',
				$.proxy(this, 'spin')).on('mousedown.spinner',
				'[data-spin="up"], [data-spin="down"]', $.proxy(this, 'spin'));

		$(document).on('mouseup.spinner', $.proxy(function() {
			clearTimeout(this.spinTimeout);
			clearInterval(this.spinInterval);
		}, this));

		if (options.delay) {
			this.delay(options.delay);
		}

		if (options.changed) {
			this.changed(options.changed);
		}

		if (options.changing) {
			this.changing(options.changing);
		}
	};

	Spinner.delay = 500;

	Spinner.prototype = {
		constructor : Spinner,

		spin : function(e) {
			var dir = $(e.currentTarget).data('spin');

			switch (e.type) {
			case 'click':
				e.preventDefault();
				this.spinning.spin(dir);
				break;
			case 'mousedown':
				if (e.which === 1) {
					this.spinTimeout = setTimeout($.proxy(this, 'beginSpin',
							dir), 300);
				}
				break;
			}
		},

		delay : function(ms) {
			var delay = Number(ms);

			if (delay >= 0) {
				this.constructor.delay = delay + 100;
			}
		},

		value : function() {
			return this.spinning.value();
		},

		changed : function(fn) {
			this.bindHandler('changed.spinner', fn);
		},

		changing : function(fn) {
			this.bindHandler('changing.spinner', fn);
		},

		bindHandler : function(t, fn) {
			if ($.isFunction(fn)) {
				this.$spinning.on(t, fn);
			} else {
				this.$spinning.off(t);
			}
		},

		beginSpin : function(dir) {
			this.spinInterval = setInterval(
					$.proxy(this.spinning, 'spin', dir), 100);
		}
	};

	var old = $.fn.spinner;

	$.fn.spinner = function(options, value) {
		return this.each(function() {
			var data = $.data(this, 'spinner');

			if (!data) {
				data = new Spinner(this, options);

				$.data(this, 'spinner', data);
			}
			if (options === 'delay' || options === 'changed'
					|| options === 'changing') {
				data[options](value);
			} else if (options === 'step' && value) {
				data.spinning.step = value;
			} else if (options === 'spin' && value) {
				data.spinning.spin(value);
			}
		});
	};

	$.fn.spinner.Constructor = Spinner;
	$.fn.spinner.noConflict = function() {
		$.fn.spinner = old;
		return this;
	};

	$(function() {
		$('[data-trigger="spinner"]').spinner();
	});

	return $.fn.spinner;
});
