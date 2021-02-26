var MyElement = {
    elecode: "custom-select-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "自定下拉";
    	dragelement.icon = "fa fa-angle-down";
    	return dragelement;
    },
    dropElement: function () {
        return '<select><option>自定下拉</option></select>';
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if((!eleattr.customCode)||(eleattr.customCode!=null && !regExp.test(eleattr.customCode)))
        {
            layer.msg('自定义下拉控件编码属性不能为空', {icon: 7});
            return false;
        }
        return true;
    },

    initAttrForm:function(form,attrJson){

        $('#customCode').focus(function(event){
            layer.open({
                type : 2,
                area : [ '800px', '450px' ],
                title : '请选择编码',
                btn: ['确定', '取消'],
                maxmin : false, // 开启最大化最小化按钮
                content : 'avicit/platform6/eform/formdesign/js/plugins/custom-select-box/customselectpage.jsp',
                yes: function(index,layero){//
                    var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
                    var rowdatas = iframeWin.getSelectedData();
                    if(rowdatas.length == 1){
                        $("#customCode").val(rowdatas[0].code_);
                    }else if(rowdatas.length > 1){
                        layer.msg('只能选择一条数据！', {icon: 7});
                        return false;
                    }

                    $('input').trigger("keyup");
                    layer.close(index);
                },
                cancel: function(index){
                    layer.close(index);
                },
                success : function(layero, index) {
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.init({
                        callback : function (data){
                            $("#customCode").val(data.code_).trigger("keyup");
                            layer.close(index);
                        }
                    });
                    var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                }
            });
            this.blur();
        });
    }
};