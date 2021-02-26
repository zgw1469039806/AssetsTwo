function IntersectionSelect(option) {
	this.processId = option.processId;
	this.pid = option.id;
	this.pname = option.name;
	this.template = option.template || "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/intersection/IntersectionSelect.jsp?processId="+this.processId+"&pid="+option.id+"&pname="+option.name;
	this.init.call(this);
	return this;
};

IntersectionSelect.prototype.init = function() {
	var _self = this;
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}
	layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	var box = parent.layer.open({
	    type:  2,
		area: [ "800px",  "450px"],
	    title: "交集选人",
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	    shade:   0.3,
        maxmin: true, //开启最大化最小化按钮
	    content: _self.template ,
	    btn: ['确定', '关闭'],
	    yes: function(index, layero){
	    	var iframeWin = layero.find('iframe')[0].contentWindow;
	        var user = iframeWin.getUserList();
	        addIntersectionNodeInfoUserSelectView(_self.pid,_self.pname,user.userList,user.showUserList);
			parent.layer.close(index);
		 },
		 cancel: function(index){
			 parent.layer.close(index);
			$('html').addClass('fix-ie-font-face');
			setTimeout(function() {
				$('html').removeClass('fix-ie-font-face');
			}, 10);
	     },
	     success: function(layero, index){
	     }
	});
	//layer.full(box);
}

$(function(){
    $('.tabbable>ul>li')
    .on(
            'click',
            function() {
                var that = $(this);
                //切换标签
                that.addClass('active').siblings('li').removeClass(
                        'active').parent().siblings('.tab-content')
                        .find('>div:eq(' + that.index() + ')')
                        .addClass('active').siblings('div')
                        .removeClass('active');
                // 设置高度
                // setHeight1($(this));
            });
});



