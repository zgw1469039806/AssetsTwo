var MyElement = {
    elecode: "photo-box",
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
    },
    initAttrForm:function(form,attrJson){
        if(attrJson){
            var ajObject = JSON.parse(attrJson);
            if(ajObject.hasOwnProperty("crop")&&ajObject.crop == "Y"){
                $("#cropArea").show();
            }else{
                $("#cropArea").hide();
            }
        }else{
            $("#cropArea").hide();
        }
        $("#crop").change(function() {
            if($("#crop").is(':checked')){
                $("#cropArea").show();
            }else{
                $("#cropArea").hide();
            }
        });
    }
}