var MyElement = {
    elecode: "linkform-box",
    colType:"NOT_DB_COL_ELE",
    //selectflag:false,
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "联动表单";
    	dragelement.icon = "fa fa-quote-right";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="联动表单">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if (!eleattr.domId ||(eleattr.domId!=null && !regExp.test(eleattr.domId))) {
            layer.msg('引用表单控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('引用表单控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }

        return true;
    },

    initAttrForm: function (form, attrJson) {
        $("#domId").val(GenNonDuplicateID()).trigger("keyup");
        var _self = this;
        $("#propertyBtn").click(function () {

            linkagedialog = top.layer.open({
                type: 2,
                title: '联动属性维护',
                skin: 'bs-modal',
                area: ['100%', '100%'],
                maxmin: false,
                content: "avicit/platform6/eform/formdesign/js/plugins/linkform-box/linkform-property.jsp",
                btn: ['确定', '取消'],
                yes: function(index, layero){
                    var frm = layero.find('iframe')[0].contentWindow;
                    var reData = frm.commitForm();
                    if (reData == false){
                        return false;
                    }
                    $("#linkformColumnid").val(reData.linkageColumnid);
                    $("#linkformPara").val(JSON.stringify(reData.datagridData)).trigger("keyup");

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