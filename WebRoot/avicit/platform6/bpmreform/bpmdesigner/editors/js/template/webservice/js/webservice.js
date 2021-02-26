function WebService(option){
	// 用户参数
	this.topId = option.topId; // 当前节点id
	this.processId = option.processId;
	this.container = $((this.topId ? "#"+this.topId:"" ) + (option.selectContainer ? "  #" +option.selectContainer :""));  // 选人容器
	this.dataField = this.container.find("#" +option.dataField);
	this.textField = this.container.find("#" +option.textField);
	this.template = option.template || "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/connectcenter.jsp";
	this.callback = option.callback;
	this.init.call(this);
	return this;
};

WebService.prototype.init = function() {
	var _self = this;
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}
	layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	var box = layer.open({
	    type:  2,
	    area: [ "850px",  "450px"],
	    title: "服务选择",
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	    shade:   0.3,
        maxmin: true, //开启最大化最小化按钮
	    content: _self.template ,
	    btn: ['确定', '关闭'],
	    yes: function(index, layero){
	    	var iframeWin = layero.find('iframe')[0].contentWindow;
	    	var serviceType = iframeWin.getServiceType();
	    	var selectData = iframeWin.getSelectRow();
	    	if(null!=selectData){
	    		_self.dataField.val(selectData.id);
	    		_self.textField.val(selectData.name);
	    		_self.callback(serviceType,selectData);
	    		layer.close(index);
	    	}	    	
		 },
		 cancel: function(index){
			layer.close(index);
	     },
	     success: function(layero, index){
	    	  var iframeWin = layero.find('iframe')[0].contentWindow;
	    	  //iframeWin.initUserSelectView(_self.dataField.val()); // 此方法UserSelect.jsp中？？
	     }
	});
}