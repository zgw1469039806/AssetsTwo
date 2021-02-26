function BpmModuleView(option) {
    this.id = option.id; // 用户选择视图id
    this.template = option.template;
    var self = this;

    this.removeAll = function () {
        $("#"+self.id).empty();
    };

    this.remove = function (id) {
        var obj = $("#"+self.id).find("div[id='"+id+"']");
        obj.remove();
    };

    this.addObject = function (id , name,type) {
        if($("#"+self.id +" #"+id).length>0) {
            layer.msg("已添加该条记录");
            return ;
        }
        var tmp = self.template
            .replace(/#id#/g, id)
            .replace(/#flowname#/g, name)
            .replace(/#type#/g, type);
        $("#"+self.id).append(tmp);
    };
    this.print = function () {
//        console.log(1111111111111111111);
    };
    this.getSelectedFlow = function() {
        var ids = "";
        var texts = "";
        var types = "";
        $("#"+self.id).children().each(function(){
            ids += ","+$(this).attr("id");
            texts += ","+$(this).find(".flowname").text().trim();
            types += ","+$(this).attr("type");
        });

        return {
          ids: (ids.length > 0 ? ids.substr(1) : ids ),
            texts: (texts.length > 0 ? texts.substr(1):texts),
            types:(types.length > 0 ? types.substr(1):types)
        };
    }
}