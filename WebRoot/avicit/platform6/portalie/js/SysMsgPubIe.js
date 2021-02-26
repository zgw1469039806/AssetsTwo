$.fn.sendMsg = function(options) {
	
	var baseUrl='msystem/sysmsg/sysMsgController/operation/PubAdd/null/';
	//默认参数
	var defaults = {
		        recvUser:'',//默认接收人
		      	type: 2,
	 		    area: ['100%', '100%'],
	 		    offset:'auto',
	 		    icon:-1,
	 		    shade:0.3,
	 		    shadeClose:false,
	 		    anim:0,
	 		    maxmin:false,
	 		    fixed:true,
	 		    resize:true,
	 		    scrollbar:true,
	 		    maxWidth:360,
	 		    zIndex:19891014,
	 		    moveOut:false,	 		    
	 		    title: '发送消息',
	 		    skin: 'bs-modal'

	 	        
				//其他参数待定
	 	        
		    };
	
	//合并默认参数与用户参数到setings
	var settings = $.extend({},defaults, options);
	settings.content=settings.recvUser==''?baseUrl+'null':baseUrl+settings.recvUser;
		    
	this.on('click', function() {
		toAddPage();
	});
	
	function toAddPage(){
		layer.open(				
		settings		
		);
	
	}
	
	//返回，用于支持链式调用
	return this;
	
}

$.fn.detailMsg = function(options) {
	var baseUrl='msystem/sysmsg/sysMsgController/operation/DetailIe6/';
	//默认参数
	var defaults = {
		        formid:'',//消息id
		        url:'',//url
		      	type: 2,
	 		    area: ['100%', '100%'],
	 		    offset:'auto',
	 		    icon:-1,
	 		    shade:0.3,
	 		    shadeClose:false,
	 		    anim:0,
	 		    maxmin:false,
	 		    fixed:true,
	 		    resize:true,
	 		    scrollbar:true,
	 		    maxWidth:360,
	 		    zIndex:19891014,
	 		    moveOut:false,	 		    
	 		    title: '消息详情'
				//其他参数待定
		    };
	//合并默认参数与用户参数到setings
	var settings = $.extend({},defaults, options);
	if (settings.url==''||settings.url==null||settings.url=='null') {
		settings.content=baseUrl+settings.formid+'/null';
	} else {
		settings.content=settings.url;
	}		    
	layer.open(				
		settings		
	);
}
