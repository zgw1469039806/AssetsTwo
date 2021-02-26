// 数据检查 防止xss注入 
var checkData = {
	xss: function(v) {
		if (!v) return false;
		var reg = /<script[^>]*>[\s\S]*?<\/[^>]*script>/gi;
		return this.run(v, reg);
	},
	xssCheck: function(list) {
		var flag = false,
			that = this;
		if(typeof list == "string"){
			flag = that.xss(list);
			if (flag) {
				return false;
			}
		}else if(typeof list == "object"){
			$.each(list, function(k, v) {
				flag = that.xss(v);
				if (flag) {
					return false;
				}
			});
		}
		return flag;
	},
	trim: function(v) {
		v += "";
		return v.replace(/(^\s+)|(\s+$)/g, "");
	},
	//执行匹配
	run: function(v,reg,cut) {
		if(!v) return false;
		var _emp = /^\s*|\s*$/g;
		if(typeof v == "string"){
			v = v.replace(_emp, "");
		}
		if(!cut){
			v = this.trim(v);
		}
		if (!v || !reg) {
			return false;
		}
		if (reg.test(v)) {
			return true;
		}
		return false;
	}
};

var avicAjaxLoading;

// 封装ajax方法
var avicAjax = {
	_loading:function(type){
		if(type == "close" ){
			return layer.close(avicAjaxLoading);
		}
		//全屏遮罩式loading
		avicAjaxLoading = layer.load(2,{shade: [0.1, '#000'],scrollbar: true});
	},
	_:function(type,obj) {
		var defaults = {
			url:'',
			dom:'',
			type:'post',
			data:{},
			beforeSend:'',
			dataType:'json',
			cache:true,
			async:true,
			quiet:false,//是否所有提示
			success:'',
			contentType:'application/x-www-form-urlencoded',
			context:'',
			complete:'',
			error:'',
			msgOffet:"20%",
			showLoading:true,
			showSucMsg:false
		};

		var setting = $.extend(defaults, obj);

		var ajaxDataType = 'json',ajaxType = type,that = this;
		if(type == "ajax"){
			ajaxType = setting.type;
		}
		if(type == 'jsonp'){
			setting.dataType = 'jsonp';
			ajaxType = 'get';
		}
		if(checkData.xssCheck(setting.data)){
			return;
		}
		if(setting.dom){
			if(setting['dom'].hasClass('loading')) return;
			if(!setting['dom'].hasClass('loading')){
				setting['dom'].addClass('loading');
			}
		}
		if(!setting.quiet){
			if(setting.showLoading){
				that._loading();
			}
		}

		$.ajax({
			url: setting.url,
			type: ajaxType,
			data: setting.data,
			cache:setting.cache,
			async:setting.async,
			contentType:setting.contentType,
			context:setting.context,
			dataType:setting.dataType,
			beforeSend:function(XHR){
				if(setting.beforeSend) setting.beforeSend(XHR);
			},
			success: function(data) {
				var showmsg = "";
				if(setting['dom']) setting['dom'].removeClass('loading');
				that._loading('close');

				if(setting.success){
					setting.success(data);
				}else{
					showmsg = (data.message)?data.message:'操作成功';
					//判断是否展示成功消息
					if(setting.showSucMsg) layer.msg(showmsg, {icon:6,offset:setting.msgOffet,scrollbar: false, time:3000});
				}
			},
			complete:function(){
				if(setting['dom']) setting['dom'].removeClass('loading');

				//修改嵌套调用时遮罩关闭的问题
				//that._loading('close');
				if(setting.complete) setting.complete();
			},
			error: function(XMLHttpRequest, textStatus) {
				if(setting['dom']) setting['dom'].removeClass('loading');
				that._loading('close');
				if(setting.error){
					setting.error(XMLHttpRequest, textStatus);
				}
				if(!setting.quiet){
					layer.confirm('操作失败，网络问题，请稍后重试', {
						icon:2,
						title:'请求失败',
						btn: ['确定'],
						btnAlign: 'c',
						offset: setting.msgOffet,
						yes:function(e){
							layer.close(e);
						},
						time:8*1000
					});
				}
			}
		});
	},
	post:function(data){
		this._('post',data);
	},
	get:function(data){
		this._('get',data);
	},
	jsonp:function(data){
		this._('jsonp',data);
	},
	ajax:function(data){
		this._('ajax',data);
	}
};