var MyElement = {
    elecode: "anchortree-box",
    colType:"NOT_DB_COL_ELE",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "锚点导航";
    	dragelement.icon = "fa fa-anchor";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="锚点导航">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if((!eleattr.domId)||(eleattr.domId!=null && !regExp.test(eleattr.domId)))
        {
            layer.msg('锚点控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[-·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('锚点控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }
        return true;
    },

    initAttrForm: function (form, attrJson) {
        var _this = this;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
        }

        $("#lableEdit").click(function () {
            var _this = this;
            layer.open({
                type: 2,
                title: "标签选择",
                skin: 'layui-layer-rim',
                area: ['70%', '80%'],
                content: 'avicit/platform6/eform/formdesign/js/plugins/anchortree-box/labelSelect.jsp',
                btn: ['确认', '取消'],
                yes: function (index,layero) {
                    var frm = layero.find('iframe')[0].contentWindow;
                    var rows = frm.getSelectedData();
                    $("#labelListValue").val(JSON.stringify(rows)).trigger("keyup");
                    layer.close(index);
                },
                success: function(layero, index){
                	var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                	}
            });
        });
        $("#domId").val("anchortree").trigger("keyup");
    }

};