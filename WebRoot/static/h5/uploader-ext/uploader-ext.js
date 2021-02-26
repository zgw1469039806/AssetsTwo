(function($) {
	/**
	 * 用class名称加载
	 */
	$(function() {
		if ($('.uploader-ext').length > 0) {
			$('.uploader-ext').uploaderExt({});
		}
	});

	/**
	 * 构造方法
	 * @param options
	 * @param param
	 */
	$.fn.uploaderExt = function(options, param) {
		if (typeof options == 'string') {
			return $.fn.uploaderExt.methods[options](this, param);
		}
		options = options || {};
		return this.each(function() {
			var state = $.data(this, 'uploaderExt');
			if (state) {
				$.extend(state.options, options);
			} else {
				var r = init(this);
				state = $.data(this, 'uploaderExt', {
					options : $.extend({}, $.fn.uploaderExt.defaults, $.fn.uploaderExt.parseOptions(this), options),
					fileListDIV : r.fileListDIV,
					selectBtn : r.selectBtn, //选择文件按钮
					uploadBtn : r.uploadBtn, //上传文件按钮
					downloadAllBtn : r.downloadAllBtn, // 下载所有文件按钮
					fileNumber : 0,
					fileItems : [], //附件个体对象集合
					fileCategoryList : [], //附件类型选项
					secretLevelList : []
				//附件密级选项
				});
			}
			bindEvents(this);
			if (state.uploader) {

			} else {
				var webUploader = initWebUploader(this);
				$.extend(state, {
					uploader : webUploader
				});
			}
		});
	};

	/**
	 * 是否需要flash
	 */
	$.fn.uploaderExt.needFlash = false;

	$.fn.uploaderExt.fileSizeLimit = 1024 * 1024 * 1024; // 平台可上传最大附件上限大小1GB，与配置文件中的设置保持一致，参照platform6.properties中的platform.default.upload.fileSizeLimit配置

	/**
	 * 自定义状态
	 */
	$.fn.uploaderExt.status = {
		inited : 'inited', // 初始状态
		uploaded : 'uploaded' //已上传服务器
	};

	/**
	 * 附件类型ico
	 */
	$.fn.uploaderExt.fileTypeIco = {
		text : 'icon-txt', //文本样式
		code : 'icon-text', //xml,html样式
		word : 'icon-word', //word样式
		excel : 'icon-excel', //excel样式
		ppt : 'icon-PPT', //ppt样式
		pdf : 'icon-PDF', //pdf样式
		zip : 'icon-ZIP', //压缩文件样式
		image : 'icon-tupian', //图片样式
		video : 'icon-shipin', //视频样式
		audio : 'icon-mp3', //音频样式
		file : 'icon-file1' //其他文件样式
	};

	/**
	 * 附件类型后缀名
	 */
	$.fn.uploaderExt.fileTypeExts = {
		text : [ 'txt', 'js', 'jsp', 'java', 'css', 'sql', 'ini', 'conf' ],
		code : [ 'xml', 'html', 'htm' ],
		word : [ 'doc', 'docx', 'wps' ],
		excel : [ 'xls', 'xlsx', 'et' ],
		ppt : [ 'ppt', 'pptx', 'dps' ],
		pdf : [ 'pdf' ],
		zip : [ 'zip', 'rar', 'tar', 'gz', 'cab', 'uue', 'arj', 'bz2', 'lzh', 'jar', 'ace', 'iso', '7z', 'z' ],
		image : [ 'bmp', 'gif', 'jpg', 'jpeg', 'png', 'tif', 'psd', 'pic', 'svg' ],
		video : [ 'rm', 'avi', 'mp4', 'mpg', 'mov', 'swf' ],
		audio : [ 'wav', 'mp3', 'aif', 'au', 'ram', 'wma', 'mmf', 'amr', 'aac', 'flac' ]
	};

	/**
	 * 方法
	 */
	$.fn.uploaderExt.methods = {
		options : function(jq) {
			return $.data(jq[0], 'uploaderExt').options;
		},
		doUpload : function(jq, formId, elementId) {
			return jq.each(function() {
				doUpload(this, formId, elementId);
			});
		},
		doDownLoadAll : function(jq, formId, elementId) {
			return jq.each(function() {
				doDownLoadAll(this, formId, elementId);
			});
		},
		getUploadFiles : function(jq) {
			return getUploadFileData(jq[0]);
		},
		getUploadedFiles : function(jq) {
			return getUploadedFileData(jq[0]);
		},
		validateSecret : function(jq) {
			return validateSecret(jq[0]);
		}
	};

	/**
	 * 获取参数
	 * @param target
	 */
	$.fn.uploaderExt.parseOptions = function(target) {
		var t = $(target);
		return $.extend({}, {
			eformUI : t.attr('eformUI') || 'bootstrap',
			formId : t.attr('formId') || undefined,
			elementId : t.attr('elementId') || undefined,
			tableName : t.attr('tableName') || undefined,
			saveType : t.attr('saveType') || undefined,
			auto : (t.attr('auto') ? ((t.attr('auto') == 'false') ? false : true) : undefined),
			expand : (t.attr('expand') ? ((t.attr('expand') == 'false') ? false : true) : undefined),
			multiple : (t.attr('multiple') ? ((t.attr('multiple') == 'false') ? false : true) : undefined),
			allowUpload : (t.attr('allowUpload') ? ((t.attr('allowUpload') == 'false') ? false : true) : undefined),
			allowDownload : (t.attr('allowDownload') ? ((t.attr('allowDownload') == 'false') ? false : true) : undefined),
			allowAdd : (t.attr('allowAdd') ? ((t.attr('allowAdd') == 'false') ? false : true) : undefined),
			allowDelete : (t.attr('allowDelete') ? ((t.attr('allowDelete') == 'false') ? false : true) : undefined),
			allowEncry : (t.attr('allowEncry') ? ((t.attr('allowEncry') == 'false') ? false : true) : undefined),
			allowPreview : (t.attr('allowPreview') ? ((t.attr('allowPreview') == 'false') ? false : true) : undefined),
			allowSaveOnlineDisk : (t.attr('allowSaveOnlineDisk') ? ((t.attr('allowSaveOnlineDisk') == 'false') ? false : true) : undefined),
			allowSameName : (t.attr('allowSameName') ? ((t.attr('allowSameName') == 'false') ? false : true) : undefined),
			collapsible : (t.attr('collapsible') ? ((t.attr('collapsible') == 'false') ? false : true) : undefined),
			fileNumLimit : isNaN(parseInt(t.attr('fileNumLimit'), 10)) ? undefined : parseInt(t.attr('fileNumLimit'), 10),
			fileSizeLimit : t.attr('fileSizeLimit') || undefined,
			secretLevel : t.attr('secretLevel') || undefined,
			formSecret : t.attr('formSecret') || undefined,
			fileCategory : t.attr('fileCategory') || undefined,
			allowEditsecretLevel : (t.attr('allowEditsecretLevel') ? ((t.attr('allowEditsecretLevel') == 'false') ? false : true) : undefined),
			accept : t.attr('accept') || undefined,
			beforeUpload : t.attr('beforeUpload') ? window[t.attr('beforeUpload')] : undefined,
			afterUpload : t.attr('afterUpload') ? window[t.attr('afterUpload')] : undefined,
			uploadError : t.attr('afterUpload') ? window[t.attr('afterUpload')] : undefined,
			ready : t.attr('ready') ? window[t.attr('ready')] : undefined
		});
	};

	/**
	 * 默认参数
	 */
	$.fn.uploaderExt.defaults = {
		eformUI : 'bootstrap',
		formId : '',//业务数据ID(根据此ID查询旗下附件)
		elementId : '',//控件区域ID
		attIds : '',//所有附件ID，根据这些ID加载附件
		deleteAttachUrl : 'platform/webuploader/delete.json',//附件删除的url
		tableName : '',//业务表名称
		saveType : 'DataBase',//上传类型,包括DataBase、Disk、Fastfds和第三方
		auto : false, //不需要手动调用上传，有文件选择即开始上传
		expand : true, //初始是否展开
		multiple : true, //是否可以一次选择多个文件
		allowUpload : false, //是否显示上传按钮
		allowDownload : true, //是否允许下载附件
		allowAdd : true, //是否允许添加附件
		allowDelete : true, //是否允许删除附件
		allowEncry : false, //是否允许附件加密存储
		allowPreview : false,//是否允许预览附件
		allowSaveOnlineDisk : false,//是否允许存网盘
		allowSameName : false,//是否允许上传文件名称重复
		collapsible : true,//是否显示折叠按钮(包括附件个数信息,为false时忽略expand属性，折叠附件初始展开)
		fileNumLimit : 10,//允许上传的个数
		fileSizeLimit : undefined,//单个附件大小限制，可以带单位，合法的单位有:B、KB、MB、GB，如果省略单位，则默认为KB。该属性为0时，表示不限制文件的大小。
		secretLevel : '', //附件密级对应的通用代码
		fileCategory : '', //附件类型对应的通用代码
		formSecret : '',//表单密级字段id
		allowEditsecretLevel : false, //是否允许修改密级
		accept : undefined,//可上传的文件类型，参考webupload的
		beforeUpload : function(files) {
		}, //上传前调用，返回false不能上传
		afterUpload : function() {
		}, //上传完调用
		uploadError : function() {
		}, //上传失败调用
		ready : function() {

		}//初始化完成后调用
	};

	/**
	 * 初始化
	 * @param target
	 */
	function init(target) {
		var DEFAULT_VERSION = 8.0;
		var ua = navigator.userAgent.toLowerCase();
		var isIE = ua.indexOf("msie") > -1;

		if (!WebUploader.Uploader.support()) {
			$.fn.uploaderExt.needFlash = true;
		}

		var t = $(target);
		t.addClass('uploader-ext');

		if ($.fn.uploaderExt.needFlash == true) {
			$('<div class="uploader-panel-body">' + '<div class="uploader-file-list"></div>' + '</div>').appendTo(target);

		} else {
			$(
					'<div class="uploader-panel-heading">' + '<div class="webuploader-container uploader-file-picker" style="*float:left;padding-bottom:3px;">'
							+ '<span class="icon icon-add">&nbsp;</span>选择文件</div>' + '<button class="uploader-btn-upload"><i class="glyphicon glyphicon-open fa-fw"></i>开始上传</button>' +

							'<div class="webuploader-container uploader-file-all-download" style="*float:left;padding-bottom:3px; ">'
							+ '<div class="webuploader-pick"><span class="iconfont icon-download">&nbsp;</span>下载全部</div></div>' +

							'<div class="uploader-heading-infos">' + '<span class="uploader-panel-title" style="display:none"> ' + '附件(已添加<span class="uploade-file-number">0</span>个附件)' + '</span>'
							+ '<i class="glyphicon glyphicon-triangle-bottom fa-lg uploader-btn-expend"></i>' + '</div>' + '</div>' + '<div class="uploader-panel-body">'
							+ '<div class="uploader-file-list"></div>' + '</div>').appendTo(target);
		}
		var fileListDIV = t.find('.uploader-file-list');
		var selectBtn = t.find('.uploader-file-picker');
		var uploadBtn = t.find('.uploader-btn-upload');
		var downloadAllBtn = t.find('.uploader-file-all-download');

		downloadAllBtn.hide();

		//解决IE8鼠标滑过后给图标动态修改颜色不能及时重绘问题
		if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i) == "8.") {
			$(".webuploader-container").hover(function() {
				setTimeout(function() {
					var iconEl = $('.icon');
					iconEl.addClass('content-empty');
					setTimeout(function() {
						iconEl.removeClass('content-empty');
					}, 0);
				}, 200);
			}, function() {
				setTimeout(function() {
					var iconEl = $('.icon');
					iconEl.addClass('content-empty');
					setTimeout(function() {
						iconEl.removeClass('content-empty');
					}, 0);
				}, 500);
			});
		}

		return {
			fileListDIV : fileListDIV,
			selectBtn : selectBtn,
			downloadAllBtn : downloadAllBtn,
			uploadBtn : uploadBtn
		};
	}

	/**
	 * 绑定事件
	 * @param target
	 */
	function bindEvents(target) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var t = $(target);

		//上传按钮添加上传事件
		if (opts.auto) {
			state.uploadBtn.remove();
		} else {
			state.uploadBtn.unbind().on("click", function() {
				doUpload(target);
			})
		}
		// 下载所有文件按钮添加事件

		if (opts.auto) {
			state.downloadAllBtn.remove();
		} else {
			state.downloadAllBtn.unbind().on("click", function() {
				doDownLoadAll(target);
			})
		}
		if (!opts.allowUpload) {
			state.uploadBtn.remove();
		}

		if (!opts.allowAdd) {
			//state.selectBtn.remove();
			state.uploadBtn.remove();
		}

		//如果设置不可折叠，隐藏折叠按钮和附件信息。同时忽略expand属性，折叠附件一直显示。
		if (!opts.collapsible) {
			t.find('.uploader-heading-infos').hide();
		} else {
			t.find('.uploader-heading-infos').show();
			//如果设置不展开，折叠附件列表
			if (!opts.expand) {
				t.find('.uploader-panel-body').hide();
				t.find('.uploader-panel-heading').addClass("uploader-panel-heading-collapsed");
				if (t.find('i.glyphicon-triangle-bottom').length > 0) {
					t.find('i.glyphicon-triangle-bottom').addClass('glyphicon-triangle-left').removeClass('glyphicon-triangle-bottom');
				}
			}
		}

		//信息增加可以展开/折叠附件列表事件
		t.find('.uploader-heading-infos').unbind().bind("click", function() {
			t.find('.uploader-panel-body').toggle();
			var expendBtn = t.find('.uploader-btn-expend');
			if (expendBtn.hasClass('glyphicon-triangle-bottom')) {
				expendBtn.addClass('glyphicon-triangle-left').removeClass('glyphicon-triangle-bottom');
			} else {
				expendBtn.addClass('glyphicon-triangle-bottom').removeClass('glyphicon-triangle-left');
			}
		});
	}

	/**
	 * 初始化WebUploader
	 * @param target
	 */

	function initWebUploader(target) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;

		var fileSingleSizeLimit = getFileSizeLimit(opts.fileSizeLimit);

		var guid = WebUploader.Base.guid();

		var pickParam = {
			id : state.selectBtn,
			multiple : opts.multiple
		};
		//设置不能添加
		if (!opts.allowAdd) {
			pickParam = undefined;
		}

		if ($.fn.uploaderExt.needFlash == true) {
			loadInfos(target);
			var BASE_URL = function() {
				if ($("base").length > 0) {
					if (typeof ($("base")[0].href) != "undefined" && $("base")[0].href != "") {
						return $("base")[0].href;
					}
				}
				var hostname = location.hostname;
				var pathname = location.pathname;
				var contextPath = pathname.split("/")[1];
				var port = location.port;
				var protocol = location.protocol;
				return protocol + "//" + hostname + ":" + port + "/" + contextPath + "/";
			}();
			top.layer.alert('您当前的浏览器没有安装flash插件或flash插件的版本较低；请安装或者升级flash插件！点击【<a href="https://www.flash.cn/">flash</a>】下载！', {
				icon : 7,
				title : "提示",
				area : [ '400px', '' ]
			});
			return false;
		}

		var fileSizeLimit = $.fn.uploaderExt.fileSizeLimit;
		if (opts.fileSizeLimit != null && opts.fileSizeLimit <= $.fn.uploaderExt.fileSizeLimit) {
			fileSizeLimit = getFileSizeLimit(opts.fileSizeLimit);
		}

		var uploader = WebUploader.create({
			// 选完文件后，是否自动上传。
			auto : opts.auto,
			// swf文件路径
			swf : 'static/h5/webuploader-0.1.5/dist/Uploader.swf',
			// 文件接收服务端。
			server : 'platform/webuploader/upload.json',
			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick : pickParam,
			method : 'POST',
			fileSizeLimit : fileSizeLimit,
			formData : {
				guid : guid, //唯一标识
				formId : opts.formId,
				elementId : opts.elementId,
				allowEncry : opts.allowEncry,
				tableName : opts.tableName,
				saveType : opts.saveType
			},
			chunked : false, //分片在上传
			//chunkSize: 10485760, //如果要分片，分多大一片？ 默认大小为5M.这里改为10M
			disableGlobalDnd : true,//禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
			compress : null,//图片不压缩
			duplicate : true,//去重  true为可重复，false为不可重复   默认为undifind  也是不可重复。
			fileSingleSizeLimit : fileSingleSizeLimit, //单个附件大小限制
			accept : opts.accept
		//限制上传的文件类型
		});

		//文件上传之前，传入自定义参数
		uploader.on('uploadBeforeSend', function(block, data) {
			// file为分块对应的file对象。
			var file = block.file;
			var fileDIV = $('#' + file.id);
			var category = fileDIV.find('select[name="fileCategory"]');
			var secretLevel = fileDIV.find('select[name="fileSecretLevel"]');
			/// 修改data可以控制发送哪些携带数据。
			data.category = category.val();
			data.secretLevel = secretLevel.val();
			data.formId = opts.formId;
			data.elementId = opts.elementId;
			data.allowEncry = opts.allowEncry;
			data.addTime = new Date().getTime();
		});

		//当有文件被添加进队列前执行。判断是否符合条件，否则返回false阻止
		uploader.on('beforeFileQueued', function(file) {

			if (file.ext == "") {
				layer.msg("上传文件必须有后缀！");
				return false;
			} else {
				if (file.ext.replace(/[^\x00-\xff]/g, "**").length > 10) {
					layer.msg("上传文件后缀字符小于等于10!");
					return false;
				}
			}

			if (typeof (opts.fileCategoryList) != "undefined" && opts.fileCategoryList.length > 0) {
				var isDefinitionfileCategory = true;
				for (var i = 0; i < opts.fileCategoryList.length; i++) {
					if (opts.fileCategoryList[i].toLowerCase() == file.ext.toLowerCase()) {
						isDefinitionfileCategory = false;
						break;
					}
				}
				if (isDefinitionfileCategory) {
					layer.msg("上传文件格式有误!允许上传格式后缀" + JSON.stringify(opts.fileCategoryList));
					return false;
				}
			}

			if (opts.fileNumLimit > 0) {
				if (state.fileNumber >= opts.fileNumLimit) {
					layer.msg("超过附件数量限制。您最多能添加" + opts.fileNumLimit + "个文件。");
					return false;
				}
			}

			if (!opts.allowSameName) {
				var isSameName = isHaveSameName(target, file.name);
				if (isSameName) {
					layer.msg("文件[" + file.name + "]名称重复，请重新选择。");
					return false;
				}
			}

		});

		//当有文件被添加进队列的时候
		uploader.on('fileQueued', function(file) {
			var param = {
				id : file.id,
				fileId : '',
				name : file.name,
				size : file.size,
				ext : file.ext,
				status : $.fn.uploaderExt.status.inited
			};
			var fileItem = new FileItem(target, param);
			//添加一个新附件后需要自适应
			fitWidth(target);
		});

		//文件上传过程中创建进度条实时显示。
		uploader.on('uploadProgress', function(file, percentage) {
			var $li = $('#' + file.id), $progress = $li.find('.uploader-file-progress');
			$percent = $progress.find('.uploader-file-progress-bar');

			// 避免重复创建
			if (!$percent.length) {
				$percent = $('<div class="uploader-file-progress-bar" style="width: 0%"></div>').appendTo($progress);
			}

			$progress.show();
			$percent.css('width', percentage * 100 + '%');
		});

		//文件上传成功
		uploader.on('uploadSuccess', function(file, response) {
			if (response.result && response.result == 'success') {
				//上传附件时，隐藏删除标记
				$('.uploader-btn-remove').hide();
				var fileItem = getFileItemById(target, file.id);
				if (fileItem) {
					var data = fileItem.getData();
					data.fileId = response.fileId;
					data.status = $.fn.uploaderExt.status.uploaded;
				}
				//修改状态
				$('#' + file.id).find('.uploader-file-tools').fadeOut(0, function() {
					$(this).remove();
					$('#' + file.id).removeClass('uploader-file-inited');
					//判断所有附件是否上传完成，都完成调用事件
					if (isUploaded(target)) {
						opts.afterUpload.call(target);
					}
				});

				if (opts.fileCategory && opts.fileCategory !== '') {
					var category = $('#' + file.id).find('select[name="fileCategory"]');
					var categoryName = category.find("option:selected").text();
					category.fadeOut(300, function() {
						$(this).remove();
						$('#' + file.id).find('.uploader-file-category').text(categoryName);
					});
				}
				if (opts.secretLevel && opts.secretLevel !== '') {
					var secret = $('#' + file.id).find('select[name="fileSecretLevel"]');
					var secretName = secret.find("option:selected").text();

					if (!opts.allowEditsecretLevel) {
						secret.fadeOut(300, function() {
							$(this).remove();
							$('#' + file.id).find('.uploader-file-secret').text(secretName);
							$('#' + file.id).find('.uploader-file-secret').attr("filesecret", secret.find("option:selected").val());
						});
					} else {
						secret.bind('change', function(e) {
							fileItem.getSecretData(response.fileId, secret, opts, fileItem);
						});
					}
				}
			} else {
				//修改状态
				$('#' + file.id).addClass('uploader-file-error');
				opts.uploadError.call(target, file, response);
			}
		});

		//文件上传失败
		uploader.on('uploadError', function(file, reason) {
			$('#' + file.id).addClass('uploader-file-error');
			$('#' + file.id).find(".uploader-btn-remove").show();
			opts.uploadError.call(target, file, reason);
		});

		//错误
		uploader.on('error', function(handler, infos) {
			if (handler == 'F_EXCEED_SIZE') {
				layer.msg("超过附件大小限制！");
			} else if (handler == 'Q_TYPE_DENIED') {
				if (infos.hasOwnProperty("size")) {
					if (infos.size == 0) {

						layer.msg("文件内容不能为空！");
					} else {
						layer.msg("不支持上传此文件类型！");
					}
				} else {
					layer.msg("不支持上传此文件类型！");
				}

			} else if (handler == 'Q_EXCEED_SIZE_LIMIT') {
				var renderSize = function(value) {
					if (null == value || value == '') {
						return "0 Bytes";
					}
					var unitArr = [ "Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" ];
					var index = 0;
					var srcsize = parseFloat(value);
					index = Math.floor(Math.log(srcsize) / Math.log(1024));
					var size = srcsize / Math.pow(1024, index);
					size = size.toFixed(2);//保留的小数位数
					return size + unitArr[index];
				}(infos);
				if (infos != null && infos != "") {
					var srcsize = parseFloat(infos);
					if (srcsize < $.fn.uploaderExt.fileSizeLimit) {
						layer.msg("文件大小不能超出" + renderSize);
					} else {
						layer.msg("文件大小超出系统默认最大值,请联系管理员");
					}
				} else {
					layer.msg("文件大小不能超出" + renderSize);
				}

			} else {
				layer.msg("附件不能上传！");
			}
		});

		//文件上传完毕(成功或失败后都会执行)
		uploader.on('uploadComplete', function(file) {
			$('#' + file.id).find('.uploader-file-progress').fadeOut(300, function() {
				$(this).remove();
			});
		});

		//组件加载完后执行加载已上传附件
		uploader.on('ready', function() {
			loadInfos(target);
			opts.ready();
		});

		return uploader;
	}

	/**
	 * 将设置单个附件限制(字符串)转化为实际数字
	 * @param fileSizeLimit 单个附件限制(字符串)
	 * @returns {Number}
	 */
	function getFileSizeLimit(fileSizeLimit) {
		var _K = 1024;
		var _M = _K * 1024;
		var _G = _M * 1024;
		var _fileSizeLimit;
		if (fileSizeLimit != undefined && fileSizeLimit !== '' && fileSizeLimit !== '0') {
			if (fileSizeLimit.indexOf('K') > 0) {
				_fileSizeLimit = parseInt(fileSizeLimit.split('K')[0], 10) * _K;
			} else if (fileSizeLimit.indexOf('M') > 0) {
				_fileSizeLimit = parseInt(fileSizeLimit.split('M')[0], 10) * _M;
			} else if (fileSizeLimit.indexOf('G') > 0) {
				_fileSizeLimit = parseInt(fileSizeLimit.split('G')[0], 10) * _G;
			} else if (fileSizeLimit.indexOf('B') > 0) {
				_fileSizeLimit = parseInt(fileSizeLimit.split('B')[0], 10);
			} else {
				_fileSizeLimit = parseInt(fileSizeLimit, 10) * _K;
			}
		}
		if (isNaN(_fileSizeLimit)) {
			return $.fn.uploaderExt.fileSizeLimit;
		} else if (_fileSizeLimit < $.fn.uploaderExt.fileSizeLimit) {
			return _fileSizeLimit;
		} else {
			return $.fn.uploaderExt.fileSizeLimit;
		}
	}

	/**
	 * 加载已存在附件和件类型、附件密级选项信息
	 * @param target
	 */
	function loadInfos(target) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		$.ajax({
			cache : false,
			type : "post",
			url : "platform/webuploader/getInfos.json",
			dataType : "json",
			data : {
				formId : opts.formId,
				elementId : opts.elementId,
				//allowEncry: opts.allowEncry,
				fileCategory : opts.fileCategory,
				secretLevel : opts.secretLevel,
				attIds : opts.attIds
			},
			async : false,
			error : function(request) {
			},
			success : function(data) {
				// 当存在多个文件时才显示下载全部按钮
				if (data.fileList.length > 1) {
					$(target).find('.uploader-file-all-download').show();
				}
				initData(target);
				$.extend(state, {
					fileCategoryList : data.fileCategoryList,
					secretLevelList : data.secretLevelList
				});

				//写入已存附件
				$.each(data.fileList, function(index, element) {
					var param = $.extend({
						id : '',
						status : $.fn.uploaderExt.status.uploaded
					}, element);
					var fileItem = new FileItem(target, param);
				});
				//显示标题信息(先隐藏再显示是为了加载时文字内容变化不显示)
				$(target).find('.uploader-panel-title').show();

				//附件自适应宽度，屏幕大小改变时也触发
				fitWidth(target);
				$(window).resize(function() {
					setTimeout(function() {
						fitWidth(target);
					}, 300)
				});
			}
		});
	}

	/**
	 * 初始化数据
	 * @param target
	 */
	function initData(target) {
		var state = $.data(target, 'uploaderExt');

		$.extend(state, {
			fileNumber : 0,
			fileItems : [],
			fileCategoryList : [],
			secretLevelList : []
		});
		state.fileListDIV.html('');
		$(target).find('span.uploade-file-number').text(0);
	}

	/**
	 * 附件自适应宽度
	 * @param target
	 */
	function fitWidth(target) {
		var state = $.data(target, 'uploaderExt');

		var itemOuterWidth = state.itemOuterWidth;
		var itemWidth = state.itemWidth;
		var nameWidth = state.nameWidth;
		if (!itemOuterWidth) {
			itemOuterWidth = state.fileListDIV.find('.uploader-file-item').outerWidth(true);
			itemWidth = state.fileListDIV.find('.uploader-file-item').width();
			nameWidth = state.fileListDIV.find('.uploader-file-name').width();
			$.extend(state, {
				itemOuterWidth : itemOuterWidth,
				itemWidth : itemWidth,
				nameWidth : nameWidth
			});
		}

		var totalWidth = state.fileListDIV.width();
		var overWidth = totalWidth % itemOuterWidth;
		var rowNumber = Math.floor(totalWidth / itemOuterWidth);
		//ie9下有问题，减少一像素
		if (Math.floor(overWidth / rowNumber) > 1) {
			var newWidth = itemWidth + Math.floor(overWidth / rowNumber) - 1;
			var newNameWidth = nameWidth + Math.floor(overWidth / rowNumber) - 1;
			state.fileListDIV.find('.uploader-file-item').css('width', newWidth + 'px');
			state.fileListDIV.find('.uploader-file-name').css('width', newNameWidth + 'px');
		}
	}

	/**
	 * 根据ID(和fileId不是一个)获取附件个体对象
	 * @param target
	 * @param target file的ID
	 * @returns {Object}
	 */
	function getFileItemById(target, id) {
		var state = $.data(target, 'uploaderExt');
		var fileItems = state.fileItems;

		for (var i = 0; i < fileItems.length; i++) {
			if (fileItems[i].getData().id == id) {
				return fileItems[i];
			}
		}

		return null;
	}

	/**
	 * 附件个体对象
	 * @param target
	 * @param data file数据
	 */
	function FileItem(target, data) {
		this.target = target;
		this.data = data;
		this.$element; //对应页面元素
		var state = $.data(target, 'uploaderExt');
		/**
		 * 初始化
		 */
		this.create = function() {
			var thisObj = this;

			this.$element = $(this.getHtml()).appendTo(state.fileListDIV);
			//增加删除事件
			this.$element.find('.uploader-btn-remove').bind("click", function() {
				thisObj.$element.remove();
				thisObj.removeFromList();
				state.uploader.removeFile(data.id, true); //移除想要放弃上传的附件
			});

			var opts = state.options;
			//是否显示更多信息(密级和附件类型)
			var allowEditsecretLevel = state.options.allowEditsecretLevel;
			var fileData = thisObj.data; //附件参数
			fileData.elmobj = this.$element;
			var isAdd = (data.status == $.fn.uploaderExt.status.inited);
			if (allowEditsecretLevel && !isAdd) {
				this.$element.find("select[name='fileSecretLevel']").bind('change', function(e) {
					thisObj.getSecretData(fileData.fileId, thisObj.$element, opts, thisObj);
				});

			}
			this.bindFileItemInfos();

			this.addToList();
		};

		this.getSecretData = function(fileId, obj, opts, fileItem) {
			var secret = obj.find('option:selected').val();
			//var state = $.data(target, 'uploaderExt');
			//var opts = state.options;
			$.ajax({
				cache : false,
				type : "post",
				url : "platform/webuploader/EditInfo.json",
				dataType : "json",
				data : {
					formId : opts.formId,
					elementId : opts.elementId,
					allowEncry : opts.allowEncry,
					secretLevel : secret,
					fileId : fileId
				},
				async : false,
				error : function(request) {
				},
				success : function(data) {
					var fileData = fileItem.getData();
					fileData.secret = secret;
					layer.msg("附件密级修改成功！");
				}
			});
		};

		/**
		 * 获取file的值
		 * @returns {Array}
		 */
		this.getData = function() {
			return this.data;
		};

		/**
		 * 获取附件类型的值
		 * @returns {String}
		 */
		this.getCategory = function() {
			return this.$element.find('select[name="fileCategory"]').val();
		};

		/**
		 * 获取附件密级的值
		 * @returns {String}
		 */
		this.getSecret = function() {
			return this.$element.find('select[name="fileSecretLevel"]').val();
		};

		/**
		 * 将此对象加入集合
		 */
		this.addToList = function() {
			var fileItems = state.fileItems;
			fileItems.push(this);
			//增加附件数量
			$(target).find('span.uploade-file-number').text(++state.fileNumber);
		};

		/**
		 * 将此对象从集合移除
		 */
		this.removeFromList = function() {
			var fileItems = state.fileItems;

			var index = -1;
			for (var i = 0; i < fileItems.length; i++) {
				if (fileItems[i] == this) {
					index = i;
					break;
				}
			}
			fileItems.splice(index, 1);
			//减少附件数量
			$(target).find('span.uploade-file-number').text(--state.fileNumber);

		};

		/**
		 * 获取一个附件的html
		 * @returns {String}
		 */
		this.getHtml = function() {
			var opts = state.options;
			//是否显示更多信息(密级和附件类型)
			var allowEditsecretLevel = state.options.allowEditsecretLevel;
			var isMoreInfo = false;
			if (opts.fileCategory && opts.fileCategory !== '') {
				isMoreInfo = true;
			} else if (opts.secretLevel && opts.secretLevel !== '') {
				isMoreInfo = true;
			}

			var isAdd = (data.status == $.fn.uploaderExt.status.inited);

			var html = [];
			html.push('<div id="' + data.id + '" class="uploader-file-item');
			html.push(isAdd ? ' uploader-file-inited' : '');
			html.push(isMoreInfo ? ' uploader-file-more' : '');
			html.push('">');

			var eformUI = state.options.eformUI;
			if (eformUI === "easyui") {
				var fileImg = "avicit/platform6/eform/common/icon/" + getFileTypeIco(data.ext) + ".png";
				html.push('<img src="' + fileImg + '" style="margin-top: 3px">');
			} else {
//				html.push('<i class="icon ' + getFileTypeIco(data.ext) + ' uploader-file-ico"></i>');
				html.push('<i class="' + getFileTypeIco(data.ext) + ' uploader-file-ico"></i>');
			}

			html.push('<span class="uploader-file-name" title="' + data.name + '">' + data.name + '</span>');
			html.push('<span class="uploader-file-size">' + getFileSize(data.size) + '</span>');
			if (isAdd) {
				html.push('<span class="uploader-file-tools">');

				if (eformUI === "easyui") {
					html.push('<span class="icon-remove uploader-btn-remove" title="删除">&nbsp;</span>');
				} else {
					html.push('<i class="icon icon-guanbi2 uploader-btn-remove" title="删除"></i>');
				}

				html.push('</span>');
				html.push('<span class="uploader-file-progress" style="display:none"></span>');
			}
			if (isMoreInfo) {
				html.push('<span class="uploader-file-moreInfo">');
				if (opts.secretLevel && opts.secretLevel !== '') {
					html.push('<span class="uploader-file-secret" title="附件密级">');
					//html.push(isAdd ? getSecretLevelHtml(target) : data.secretName);
					//密级允许修改需求
					html.push((isAdd && data.secretName == undefined) ? getSecretLevelHtml(target) : (allowEditsecretLevel ? getSecretLevelHtml(target, data.secret) : data.secretName));
					html.push('</span>');
				}
				if (opts.fileCategory && opts.fileCategory !== '') {
					html.push('<span class="uploader-file-category" title="附件类型">');
					html.push(isAdd ? getFileCategoryHtml(target) : data.categoryName);
					html.push('</span>');
				}
				html.push('</span>');
			}
			html.push('</div>');
			return html.join('');
		};

		/**
		 * 生成附件详细信息并弹出
		 */
		this.bindFileItemInfos = function() {
			var opts = state.options;
			var thisObj = this;
			var fileInfos;

			this.$element.bind("mouseenter", function(e) {
				if (data.status == $.fn.uploaderExt.status.inited) {
					return;
				}

				if ($('.uploader-file-infos[fileId="' + data.fileId + '"]').length > 0) {
					return;
				}

				var html = [];
				html.push('<div class="uploader-file-infos" fileId="' + data.fileId + '" style="visibility:hidden">');
				html.push('<span class="uploader-file-infos-tip"><i class="glyphicon glyphicon-triangle-top fa-fw"></i></span>');
				html.push('<div class="uploader-file-infos-name">' + data.name + '</div>');
				html.push('<div class="uploader-file-infos-tools">');

				var eformUI = state.options.eformUI;
				if (opts.allowDownload) {
					html.push('<span class="uploader-file-infos-download" title="下载">');

					if (eformUI === "easyui") {
						html.push('<span class="icon-download">&nbsp;</span>下载');
					} else {
						html.push('<i class="glyphicon glyphicon-save fa-fw"></i>下载');
					}

					html.push('</span>');
				}
				if (opts.allowPreview) {
					html.push('<span class="uploader-file-infos-preview" title="预览">');

					if (eformUI === "easyui") {
						html.push('<span class="icon-eye">&nbsp;</span>预览');
					} else {
						html.push('<i class="glyphicon glyphicon-eye-open fa-fw"></i>预览');
					}

					html.push('</span>');
				}
				if (opts.allowDelete) {
					html.push('<span class="uploader-file-infos-delete" title="删除">');

					if (eformUI === "easyui") {
						html.push('<span class="icon-remove">&nbsp;</span>删除');
					} else {
						html.push('<i class="glyphicon glyphicon-trash fa-fw"></i>删除');
					}

					html.push('</span>');
				}
				if (opts.allowSaveOnlineDisk) {
					html.push('<span class="uploader-file-infos-saveonlinedisk" title="存网盘">');

					if (eformUI === "easyui") {
						html.push('<span class="icon-save">&nbsp;</span>存网盘');
					} else {
						html.push('<i class="glyphicon glyphicon-floppy-disk fa-fw"></i>存网盘');
					}

					html.push('</span>');
				}
				html.push('</div>');
				html.push('</div>');

				fileInfos = $(html.join('')).appendTo($('body'));
				if (opts.allowDelete) {
					fileInfos.find('.uploader-file-infos-delete').show()
				}
				//判断详细信息框是否超出最下面。如果超过向上显示
				if (($(this).offset().top + $(this).outerHeight() + fileInfos.outerHeight(true)) > $(window).height()) {
					fileInfos.addClass('uploader-file-infos-up');
					fileInfos.find('.glyphicon-triangle-top').addClass('glyphicon-triangle-bottom').removeClass('glyphicon-triangle-top');
					fileInfos.css('top', $(this).offset().top - fileInfos.outerHeight(true) + 'px');
					fileInfos.css('left', $(this).offset().left + 'px');
					fileInfos.css('width', $(this).outerWidth() + 'px');
				} else {
					fileInfos.css('top', $(this).offset().top + $(this).outerHeight() + 'px');
					fileInfos.css('left', $(this).offset().left + 'px');
					fileInfos.css('width', $(this).outerWidth() + 'px');
				}
				//增加动画效果
				fileInfos.hide();
				fileInfos.css('visibility', '');
				fileInfos.show(100);
				if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i) == "8.") {
					fileInfos.find('.fa').each(function() {
						$(this).clone().insertAfter($(this));
						$(this).remove();
					});
				}
				//增加下载事件
				if (opts.allowDownload) {
					var _allowEncry = opts.allowEncry;
					$(fileInfos).find('.uploader-file-infos-download').unbind().bind('click', function(e) {
						downloadFile(data.fileId, _allowEncry, this);
					});
				}

				//增加预览事件
				if (opts.allowPreview) {

				}

				//则增加删除事件
				if (opts.allowDelete) {
					$(fileInfos).find('.uploader-file-infos-delete').unbind().bind('click', function() {
						layer.confirm('确定要删除此附件吗？', {
							icon : 3,
							title : "提示",
							area : [ '400px', '' ]
						}, function(index) {
							$.ajax({
								cache : false,
								type : "post",
								url : opts.deleteAttachUrl,
								dataType : "json",
								data : {
									fileId : data.fileId
								},
								async : false,
								error : function(request) {
								},
								success : function(data) {
									thisObj.$element.remove();
									thisObj.removeFromList();
									// 当删除文件后文件数量 <= 1 时，隐藏下载全部按钮
									var downAllBtn = $(thisObj.target).find('.uploader-file-all-download');
									if (downAllBtn.length == 1 && downAllBtn.is(":visible") && state.fileNumber <= 1) {
										downAllBtn.hide();
									}
								}
							});
							layer.close(index);
						});
					});
				}

				//增加存网盘
				if (opts.allowSaveOnlineDisk) {

				}

				window['uploader-ext-timer'] = "";
				//绑定鼠标离开事件
				fileInfos.off("mouseleave mouseenter").on("mouseleave", function(e) {
					var toElement = e.relatedTarget || e.toElement;
					if ($(toElement).closest('.uploader-file-item').length == 0 || $(toElement).closest('.uploader-file-item')[0] != thisObj.$element[0]) {
						window['uploader-ext-timer'] = setTimeout(function() {
							fileInfos.hide(100, function() {
								fileInfos.remove()
							});
						}, 200);
					}
				}).on("mouseenter", function(e) {
					clearTimeout(window['uploader-ext-timer']);
				});

				//绑定鼠标离开事件
				thisObj.$element.off("mouseenter.leave mouseleave").on("mouseleave", function(e) {
					var toElement = e.relatedTarget || e.toElement;
					if ($(toElement).closest('.uploader-file-infos').length == 0 || $(toElement).closest('.uploader-file-infos')[0] != fileInfos[0]) {
						window['uploader-ext-timer'] = setTimeout(function() {
							fileInfos.hide(100, function() {
								fileInfos.remove()
							});
						}, 200);
					}
				}).on("mouseenter.leave", function(e) {
					clearTimeout(window['uploader-ext-timer']);
				});

				//解决IE8鼠标滑过后给图标动态修改颜色不能及时重绘问题
				if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i) == "8.") {
					var iconEl = $('.fa-fw');
					iconEl.addClass('content-empty');
					setTimeout(function() {
						iconEl.removeClass('content-empty');
					}, 0);
				}

			});
		};

		this.create();
	}

	/**
	 * 获取附件类型的html
	 * @param target
	 * @returns {String}
	 */
	function getFileCategoryHtml(target) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var list = state.fileCategoryList;

		var html = [];
		if (opts.fileCategory != "" && list && list.length > 0) {
			html.push('<select name="fileCategory">');
			for (var i = 0; i < list.length; i++) {
				html.push('<option value="' + list[i].lookupCode + '">' + list[i].lookupName + '</option>');
			}
			html.push('</select>');
		}
		return html.join('');
	}

	/**
	 * 获取附件密级的html
	 * @param target
	 * @returns {String}
	 */
	function getSecretLevelHtml(target, serectvalue) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var list = state.secretLevelList;

		var html = [];
		if (opts.secretLevel != "" && list && list.length > 0) {
			html.push('<select name="fileSecretLevel">');
			for (var i = 0; i < list.length; i++) {
				if (serectvalue == list[i].lookupCode) {
					html.push('<option value="' + list[i].lookupCode + '" selected>' + list[i].lookupName + '</option>');
				} else {
					html.push('<option value="' + list[i].lookupCode + '">' + list[i].lookupName + '</option>');
				}
			}
			html.push('</select>');
		}
		return html.join('');
	}

	/**
	 * 格式化文件大小
	 * @param fileSize
	 * @returns {String}
	 */
	function getFileSize(fileSize) {
		if (typeof (fileSize) != 'number') {
			fileSize = parseInt(fileSize, '10');
		}

		var str = "";
		if (fileSize > 1024 * 1024 * 1024) {
			str = (fileSize / (1024 * 1024 * 1024)).toFixed(2) + "G";
		} else if (fileSize > 1024 * 1024) {
			str = (fileSize / (1024 * 1024)).toFixed(2) + "M";
		} else if (fileSize > 1024) {
			str = (fileSize / 1024).toFixed(2) + "K";
		} else {
			str = fileSize + "B";
		}
		return str;
	}

	/**
	 * 下载附件
	 * @param fileId
	 */
	function downloadFile(fileId, _allowEncry, thisObj) {
		if (undefined != thisObj) {
			var $downStatusDiv = $('#downStatusDiv' + fileId);
			if ($downStatusDiv.length == 0) {
				$downStatusDiv = $('<div id="downStatusDiv' + fileId + '" style="display: none;"></div>').appendTo('body');
				window.setTimeout(function() {
					$("#downStatusDiv" + fileId).remove();
				}, 20000);
			} else {
				layer.msg("服务端已接受下载请求，请勿重复下载！请在20秒后后重试！");
				return false;
			}
		}
		var $downloadFrame = $('#uploaderDownloadFrame');

		if ($downloadFrame.length == 0) {
			$downloadFrame = $('<iframe id="uploaderDownloadFrame" style="display: none;"></iframe>').appendTo('body');
		}
		if (typeof _fileupload_entryId != "undefined" && _fileupload_entryId != "" && typeof _fileupload_taskName != "undefined" && _fileupload_taskName != "") {
			$downloadFrame.attr('src', 'platform/webuploader/download?fileId=' + fileId + '&allowEncry=' + _allowEncry + "&_taskName=" + _fileupload_taskName + "&_entryId=" + _fileupload_entryId);
		} else {
			$downloadFrame.attr('src', 'platform/webuploader/download?fileId=' + fileId + '&allowEncry=' + _allowEncry);
		}
	}

	/**
	 * 下载一个控件中所有的文件
	 * 参考 loadInfos 方法，获取一个控件中所有的fileid
	 * @param target
	 * @param formId
	 * @param elementId
	 */
	function doDownLoadAll(target, formId, elementId) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var fileIds = [];
		$.ajax({
			cache : false,
			type : "post",
			url : "platform/webuploader/getInfos.json",
			dataType : "json",
			data : {
				formId : opts.formId,
				elementId : opts.elementId,
				//allowEncry: opts.allowEncry,
				fileCategory : opts.fileCategory,
				secretLevel : opts.secretLevel,
				attIds : opts.attIds
			},
			async : false,
			error : function(request) {
				layer.msg("下载全部出现异常，请单独下载！");
			},
			success : function(data) {
				var files = data.fileList;
				for (var i = 0; i < files.length; i++) {
					fileIds.push(files[i].fileId);
				}
				multiDownload(fileIds, opts);
			}
		});

	}

	/**
	 * 参考downloadFile，将一组fileId打包下载
	 * @param fileIds
	 * @param options
	 */
	function multiDownload(fileIds, options) {

		var $downloadFrame = $('#uploaderDownloadFrame');
		var fileId = encodeURIComponent(JSON.stringify(fileIds));
		var _allowEncry = options.allowEncry;

		if ($downloadFrame.length == 0) {
			$downloadFrame = $('<iframe id="uploaderDownloadFrame" style="display: none;"></iframe>').appendTo('body');
		}
		if (typeof _fileupload_entryId != "undefined" && _fileupload_entryId != "" && typeof _fileupload_taskName != "undefined" && _fileupload_taskName != "") {
			$downloadFrame.attr('src', 'platform/webuploader/multidownload?fileIds=' + fileId + '&allowEncry=' + _allowEncry + "&_taskName=" + _fileupload_taskName + "&_entryId="
					+ _fileupload_entryId);
		} else {
			$downloadFrame.attr('src', 'platform/webuploader/multidownload?fileIds=' + fileId + '&allowEncry=' + _allowEncry);
		}

	}
	/**
	 * 上传附件
	 * @param target
	 * @param formId
	 */
	function doUpload(target, formId, elementId) {
		if ($.fn.uploaderExt.needFlash == true) {
			layer.msg("请安装flash插件！");
			return false;
		}

		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var allowEditsecretLevel = opts.allowEditsecretLevel;
		if (formId && formId !== '') {
			opts.formId = formId;
		}
		if (elementId && elementId !== '') {
			opts.elementId = elementId;
		}
		var files = getUploadFileData(target);
		//如果设置了调用提交前验证方法，调用。返回false不执行上传
		var validate = opts.beforeUpload.call(target, files);
		if (!(typeof (validate) == 'boolean' && !validate)) {
			//考虑到没选择上传附件情况，也要触发一下后置事件
			if (isUploaded(target)) {
				opts.afterUpload.call(target);
			}
			state.uploader.upload();
		}
	}

	function validateSecret(target) {
		var state = $.data(target, 'uploaderExt');
		var opts = state.options;
		var files = getUploadFileData(target);
		var filesUploaded = getUploadedFileData(target);
		if (opts.secretLevel != "" && opts.formSecret != "") {

			var value = $("[id='" + opts.formSecret + "']").val() || $("[name='" + opts.formSecret + "']").val();
			if ((value == "" || value == undefined || value == null) && files.length > 0) {
				layer.msg("表单密级[" + opts.formSecret + "]没有值，请检查！");
				return false;
			}
			var msg = "";
			for (var i = 0; i < filesUploaded.length; i++) {
				if (filesUploaded[i].secretLevel > value) {
					msg = "已上传的第" + (i + 1) + "个附件密级高于文档密级！";
					break;
				}
			}
			for (var i = 0; i < files.length; i++) {
				if (files[i].secretLevel > value) {
					msg = "待上传的第" + (i + 1) + "个附件密级高于文档密级！";
					break;
				}
			}
			if ("" != msg) {
				layer.msg(msg);
				return false;
			} else {
				return true;
			}
		}
		return true;
	}
	/**
	 * 是否已经上传完所有附件
	 * @param target
	 * @returns {Boolean}
	 */
	function isUploaded(target) {
		var state = $.data(target, 'uploaderExt');

		var unUploadNumber = 0;
		//将准备上传的文件信息放入数组
		$.each(state.fileItems, function(index, fileItem) {
			var data = fileItem.getData();
			if (data.status == $.fn.uploaderExt.status.inited) {
				unUploadNumber++;
			}
		});

		if (unUploadNumber == 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 是否含有名称相同的附件
	 * @param target
	 * @param fileName
	 * @returns {Boolean}
	 */
	function isHaveSameName(target, fileName) {
		var state = $.data(target, 'uploaderExt');
		var isSameName = false;
		//将准备上传的文件信息放入数组
		$.each(state.fileItems, function(index, fileItem) {
			var data = fileItem.getData();
			if (data.name == fileName) {
				isSameName = true;
			}
		});
		return isSameName;
	}

	/**
	 * 获取要上传文件信息
	 * @param target
	 * @returns {Array}
	 */
	function getUploadFileData(target) {
		var state = $.data(target, 'uploaderExt');

		var files = [];
		//将准备上传的文件信息放入数组
		$.each(state.fileItems, function(index, fileItem) {
			var data = fileItem.getData();
			if (data.status == $.fn.uploaderExt.status.inited) {

				var category = fileItem.getCategory();
				var secretLevel = fileItem.getSecret();

				var param = {
					id : data.id,
					name : data.name,
					size : data.size,
					category : category,
					secretLevel : secretLevel
				};

				files.push(param);
			}
		});
		return files;
	}

	/**
	 * 获取已上传文件信息
	 * @param target
	 * @returns {Array}
	 */
	function getUploadedFileData(target) {
		var state = $.data(target, 'uploaderExt');

		var files = [];
		//将上传完毕的文件信息放入数组
		$.each(state.fileItems, function(index, fileItem) {
			var data = fileItem.getData();
			if (data.status == $.fn.uploaderExt.status.uploaded) {

				var category = fileItem.getCategory();
				//var secretLevel = fileItem.getSecret();
				var secretLevel = data.secret;
				if (!secretLevel) {
					secretLevel = this.$element.find('.uploader-file-secret').attr("filesecret");
				}

				var param = {
					id : data.id,
					fileId : data.fileId,
					name : data.name,
					size : data.size,
					category : category,
					secretLevel : secretLevel
				};

				files.push(param);
			}
		});
		return files;
	}

	/**
	 * 根据文件后缀名获取显示的ico样式
	 * @param ext 文件后缀名
	 * @returns {String}
	 */
	function getFileTypeIco(ext) {
		if (ext) {
			ext = ext.toLowerCase();
		} else {
			return $.fn.uploaderExt.fileTypeIco.file;
		}

		for ( var key in $.fn.uploaderExt.fileTypeExts) {
			var exts = $.fn.uploaderExt.fileTypeExts[key];
			for (var i = 0; i < exts.length; i++) {
				if (exts[i] == ext) {
					return $.fn.uploaderExt.fileTypeIco[key];
				}
			}
		}

		return $.fn.uploaderExt.fileTypeIco.file;
	}
})(jQuery);