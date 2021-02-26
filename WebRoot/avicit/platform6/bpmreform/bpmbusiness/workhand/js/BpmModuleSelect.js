function BpmModuleSelect(dataId, textId, callback,isShowParent,$idDom, $textDom, $typeDom, isPdId) {
    this.dataId = dataId;
    this.textId = textId;
    this.callback = callback;
    this.isShowParent = isShowParent;
    this.$idDom = $idDom;
    this.$textDom = $textDom;
    this.$typeDom = $typeDom;
    this.isPdId = isPdId;
    this.init();
}

BpmModuleSelect.prototype.init = function (){
    var _self = this;
    var $target;
    if(this.textId instanceof jQuery){
        $target = this.textId;
    }else{
        $target = $("#"+this.textId);
    }

    $target.on('click',function(){
        var box = layer.open({
            type:  2,
            area: [ "800px",  "300px"],
            title: "流程业务目录",
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            shade:   0.3,
            maxmin: false, //开启最大化最小化按钮
            content: "avicit/platform6/bpmreform/bpmbusiness/workhand/moduleSelectTree.jsp?isShowParent="+_self.isShowParent + "&isPdId=" + _self.isPdId,
            btn: ['确定', '关闭'],
            yes: function(index, layero){
             //   console.log(layero);
                var iframeWin = layero.find('iframe')[0].contentWindow;
                // bpmModuleView 在moduleSelectTree.jsp中声明
                var data = iframeWin.bpmModuleView.getSelectedFlow();
                if(data.ids.length == 0) {
                    // layer.msg("您还没有选择流程");
                    // return ;
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
                var iframeWin = layero.find('iframe')[0].contentWindow;
                if(typeof _self.$idDom != "undefined" && typeof _self.$textDom != "undefined"){
                    var ids = _self.$idDom.val();
                    var texts = _self.$textDom.val();
                    var types = "";
                    if(typeof _self.$typeDom != "undefined"){
                        types = _self.$typeDom.val();
                    }
                    if(typeof ids != "undefined" && ids.length > 0){
                        var idArr = ids.split(",");
                        var textArr = texts.split(",");
                        var typeArr = types.split(",");
                        for(var i = 0; i < idArr.length; i++){
                            var type = "1";
                            if(i < typeArr.length){
                                type = typeArr[i];
                            }
                            iframeWin.bpmModuleView.addObject(idArr[i], textArr[i], type, _self.isShowParent);
                        }
                    }
                }
              //ie8下页面加载完成重绘关闭按钮
                redrawPseudoEl();
            }
        });
    });
}