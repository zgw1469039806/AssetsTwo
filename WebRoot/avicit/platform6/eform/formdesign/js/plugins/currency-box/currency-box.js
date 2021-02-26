var MyElement = {
    elecode: "currency-box",
    colType:"NUMBER",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "货币";
    	dragelement.icon = "fa fa-jpy";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="货币输入框"></input>';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if ((!eleattr.attribute02)||(eleattr.attribute02 != null && !regExp.test(eleattr.attribute02))) {
            layer.msg('货币控件小数位数属性不能为空', {icon: 7});
            return false;
        }
        var regExp = /^(0|([1-9]\d*))$/;
        if (eleattr.attribute02 != null &&
            (!regExp.test(eleattr.attribute02) || eleattr.attribute02 < 0 || eleattr.attribute02 > 10)) {
            layer.msg('货币控件小数位数必须为正整数，且值区间为[0, 10]！', {icon: 7});
            return false;
        }
        return true;
    },

    initAttrForm: function (form, attrJson) {
        var _this = this;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
        }


        $("#propertyBtn").click(function () {

            linkagedialog = top.layer.open({
                type: 2,
                title: '计算属性维护',
                skin: 'bs-modal',
                area: ['1100px', '570px'],
                maxmin: false,
                content: "avicit/platform6/eform/formdesign/js/plugins/attr-jsp/calculate-property.jsp",
                btn: ['确定', '取消'],
                yes: function(index, layero){
                    var frm = layero.find('iframe')[0].contentWindow;
                    var reData = frm.commitForm();
                    if (!reData){
                        return false;
                    }

                    $("#calculateValue").val(reData.calculateValue);
                    $("#calculateCol").val(reData.calculateCol);
                    $("#calculateText").val(reData.calculateText).trigger("keyup");

                    top.layer.close(index);

                },
                no: function(index, layero){
                    layero.close(index);
                },
                success: function(layero, index){
                	var btn1= $(".layui-layer-btn .layui-layer-btn0");
                	btn1.addClass("form-tool-btn");
                	btn1.addClass("typeb");
                	}
            });
        });
    }
};