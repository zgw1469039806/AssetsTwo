/**
 * 使用此控件需在平台index.jsp中增加js引用，以使弹窗基于最顶层出现，并使遮罩全屏出现。此方法以后需放到公用js中
 * type: 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
 * shae: 不输入或false为无遮罩， true为有遮罩
 */
function openDialog(option){

	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}
	top.layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	if(option.type != null){
		if(option.type == "selectWindow"){
			top.layer.open({
			    type:  option.opentype,
			    area: [ option.width,  option.height],
			    title: option.title,
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			    shade:   option.shade?0.3:0,
		        maxmin: false, //开启最大化最小化按钮
			    content: option.url ,
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){
			    	if(option.submit!=null){
			    		option.submit(index, layero);
			    	}
			    	top.layer.close(index);
				 },
				//feng start
				//cancel: function(index, layero){
                btn2: function(index, layero){
			    //feng end
			    	if(option.beferClose!=null){
			    		option.beferClose(index, layero);
			    	}
					top.layer.close(index);
					$('html').addClass('fix-ie-font-face');
					setTimeout(function() {
						$('html').removeClass('fix-ie-font-face');
					}, 10);
			     },
			     success: function(layero, index){
			    	if(option.init!=null){
			    		option.init(index, layero);
			    	}
			    	
			    	var btn1= $(".layui-layer-btn .layui-layer-btn0");
			    	btn1.addClass("form-tool-btn");
			    	btn1.addClass("typeb");
			     }
			});
		}
	}else{
		top.layer.open({
		    type:  option.opentype,
		    area: [ option.width,  option.height],
		    title: option.title,
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   option.shade?0.3:0,
	        maxmin: true, //开启最大化最小化按钮
		    content: option.url
		});
		
	}
	
	return top.layer;
}