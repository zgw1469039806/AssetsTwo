function BpmProcessNodeSelect(domId, callback) {
    this.domId = domId;
    this.callback = callback;
    this.init();
}

BpmProcessNodeSelect.prototype.init = function (){
    var _self = this;
    var $target;
    if(this.domId instanceof jQuery){
        $target = this.domId;
    }else{
        $target = $("#"+this.domId);
    }

    $target.on('click',function(){
        var box = layer.open({
            type:  2,
            area: [ "800px",  "450px"],
            title: "流程节点",
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            shade:   0.3,
            maxmin: false, //开启最大化最小化按钮
            content: "avicit/platform6/bpmreform/forthird/bpmProcessNodeSelect.jsp" ,
            btn: ['确定', '关闭'],
            yes: function(index, layero){
             //   console.log(layero);
                var iframeWin = layero.find('iframe')[0].contentWindow;
                // bpmModuleView 在moduleSelectTree.jsp中声明
                var data = iframeWin.bpmModuleView.getSelectedFlow();
                if(data.ids.length == 0) {
                    layer.msg("您还没有选择流程");
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
    });
}

function BpmModuleView(option) {
    this.id = option.id; // 用户选择视图id
    this.template = option.template;
    var self = this;

    this.removeAll = function () {
        $("#"+self.id).empty();
    };

    this.remove = function (id) {
        var obj = $("#"+self.id).find("div[id='"+id+"']");
        obj.remove();
    };

    this.addObject = function (id , name) {
        if($("#"+self.id +" #"+id).length>0) {
            layer.msg("已添加该条记录");
            return ;
        }
        var tmp = self.template
            .replace(/#id#/g, id)
            .replace(/#flowname#/g, name);
        $("#"+self.id).append(tmp);
    };
    this.print = function () {
//        console.log(1111111111111111111);
    };
    this.getSelectedFlow = function() {
        var ids = "";
        var texts = "";
        $("#"+self.id).children().each(function(){
            ids += ","+$(this).attr("id");
            texts += ","+$(this).find(".flowname").text().trim();
        });

        return {
          ids: (ids.length > 0 ? ids.substr(1) : ids ),
            texts: (texts.length > 0 ? texts.substr(1):texts)
        };
    }
}