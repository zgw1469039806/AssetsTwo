var MyElement = {
    elecode: "print-photo-box",
    colType:"BLOB",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "图片上传";
    	dragelement.icon = "fa fa-picture-o";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="图片选择框">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    }
}