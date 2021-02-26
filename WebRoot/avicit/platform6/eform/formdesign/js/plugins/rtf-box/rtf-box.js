var MyElement = {
    elecode: "rtf-box",
    colType:"CLOB",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "富文本";
    	dragelement.icon = "fa fa-file-text";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="富文本输入框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    initAttrForm: function (form, attrJson) {
    }
};