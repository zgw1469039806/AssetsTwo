var MyElement = {
    elecode: "view-box",
    colType:"NOT_DB_COL_ELE",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "视图控件";
    	dragelement.icon = "glyphicon glyphicon-list";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="视图控件">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        var regExp = /[\S+]/i;
        if((!eleattr.domId)||(eleattr.domId!=null && !regExp.test(eleattr.domId)))
        {
            layer.msg('视图控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('视图控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }

        if((!eleattr.viewheight)||(eleattr.viewheight!=null && !regExp.test(eleattr.viewheight)))
        {
            layer.msg('视图控件视图高度属性不能为空', {icon: 7});
            return false;
        }
        return true;
    },

    initAttrForm: function (form, attrJson) {
        var _this = this;
        if (attrJson) {
            var json = $.parseJSON(attrJson);
        }

        $("#divcontent").click(function () {
            var _this = this;
            eventEdit(_this, 'div内容');
        });

        function eventEdit(_this, title) {
            layer.open({
                type: 2,
                title: title,
                skin: 'layui-layer-rim',
                area: ['70%', '80%'],
                content: 'avicit/platform6/eform/common/htmleditor.html',
                btn: ['确认', '取消'],
                success: function (layero, index) {
                    //传入参数，并赋值给iframe的元素
                    var iframeWin = layero.find('iframe')[0].contentWindow;
                    iframeWin.setEditorValue(_this.value);
                },
                yes: function (index,layero) {
                    var frm = layero.find('iframe')[0].contentWindow;
                    $(_this).val(frm.getEditorValue()).trigger("keyup");
                    layer.close(index);
                }
            });
        }

        $("#domId").val(GenNonDuplicateID()).trigger("keyup");
        var _self = this;
        var selectPublishEform = new SelectPublishEform("viewid", "viewname", null, "", "view");
        selectPublishEform.init(function() {
            $("#viewname").trigger("keyup");
        });
    },

};