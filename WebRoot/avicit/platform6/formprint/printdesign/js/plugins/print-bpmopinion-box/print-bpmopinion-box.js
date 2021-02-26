var MyElement = {
    elecode: "print-bpmopinion-box",
    colType:"NOT_DB_COL_ELE",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "流程意见";
    	dragelement.icon = "fa fa-bullhorn";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="流程意见框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },

    validateForm:function(eleattr){
        if (eleattr.bpmopinionShowAll=='N') {
            if ((!eleattr.bpmopinionTexts)||(!eleattr.bpmopinionIds)) {
                layer.msg('流程意见控件流程意见属性不能为空', {icon: 7});
                return false;
            }
        }
        var regExp = /[\S+]/i;
        if((!eleattr.domId)||(eleattr.domId!=null && !regExp.test(eleattr.domId)))
        {
            layer.msg('流程意见控件页面元素ID属性不能为空', {icon: 7});
            return false;
        }else{
            var value=eleattr.domId,
                regEn = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im,
                regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im,
                regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
            if(regEn.test(value) || regCn.test(value) ||regCh.test(value)) {
                layer.msg('流程意见控件页面元素ID属性不能含有特殊字符或中文', {icon: 7});
                return false;
            }
        }
        return true;
    },

    //属性页面初始化方法  可选方法
    initAttrForm:function(form,attrJson){
        if(attrJson != undefined) {
            var attr = $.parseJSON(attrJson);
            if(attr.bpmopinionShowAll == "N") {
                $("#bpmopinionDiv").css("display", "");
            }
        }
    }
};