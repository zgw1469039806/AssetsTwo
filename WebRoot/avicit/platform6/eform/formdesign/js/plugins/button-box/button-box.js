var MyElement = {
    elecode: "button-box",
    colType:"NOT_DB_COL_ELE",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "按钮控件";
    	dragelement.icon = "fa fa-square";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="button" value="按钮">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if((!eleattr.domId)||(eleattr.domId!=null && !regExp.test(eleattr.domId)))
        {
            layer.msg('按钮控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('按钮控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }
        return true;
    },


    initAttrForm: function (form, attrJson) {
        var _this = this;
        var iconlayer;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
            if(json.buttonIcon!=''){
                var html = json.buttonIcon;
                html = html.replace(/&lt;/g,"<").replace(/&gt;/g,">");
                $("#buttonPreview").append(""+html+ "<span style='float:right' onclick='$(\"#buttonPreview\").empty();$(\"#buttonIcon\").val(\"\");$(\"#propertyBtn\").show();$(\"#buttonIcon\").keyup();event.stopPropagation();'>x</span>");
                $("#propertyBtn").hide();
            }
        }

        $(".propertyBtn").click(function () {
            var content = 'static/h5/selectIcon/index.html';
            window.iconlayer = layer.open({
                type: 2,
                title: "图标选择",
                skin: 'layui-layer-rim',
                area: ['70%', '80%'],
                shadeClose: true,
                content: content,
                success: function(layero, index){
                	var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                	}
            });
        });


    }
};


