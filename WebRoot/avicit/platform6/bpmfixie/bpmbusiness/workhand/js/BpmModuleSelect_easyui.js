function BpmModuleSelect(dataId, textId, callback, isOpen) {
    this.dataId = dataId;
    this.textId = textId;
    this.callback = callback;
    if(isOpen){
    	this.open();
    }else{
    	this.init();
    }
};

BpmModuleSelect.prototype.open = function(){
	var _self = this;
	// bootstrap弹出框
    var box = layer.open({
        type:  2,
        area: [ "800px",  "450px"],
        title: "流程业务目录",
        skin: 'bs-modal', // 加载skin
        shade:   0.3,
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/platform6/bpmfixie/bpmbusiness/workhand/moduleSelectTree_easyui.jsp" ,
        btn: ['确定', '关闭'],
        yes: function(index, layero){
         //   console.log(layero);
            var iframeWin = layero.find('iframe')[0].contentWindow;
            // bpmModuleView 在moduleSelectTree.jsp中声明
            var data = iframeWin.bpmModuleView.getSelectedFlow();
            if(data.ids.length == 0) {
                layer.alert("您还没有选择流程",{
                    icon: 0,
                    title: ""
                    });
                return ;
            }
            _self.callback(data);
            // console.log(iframeWin);
            layer.close(index);
        },
        cancel: function(index){
            layer.close(index);
            $('html').addClass('fix-ie-font-face');
            setTimeout(function() {
                $('html').removeClass('fix-ie-font-face');
            }, 10);
        },
        success: function(layero, index){

        }
    });
};

BpmModuleSelect.prototype.init = function (){
    var _self = this;
    var $target;
    if(this.textId instanceof jQuery){
        $target = this.textId;
    }else{
        $target = $("#"+this.textId);
    }

    $target.on('click',function(){
    	_self.open();
    });
};