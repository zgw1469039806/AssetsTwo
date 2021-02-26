/**
 * 流程意见操作
 */
function FlowIdea(flowEditor) {
    this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowIdea.prototype.flowEditor = null;

FlowIdea.prototype.refresh = function () {
    if(!flowUtils.notNull(this.flowEditor.flowModel.entryId)){
        //初始化时，没有数据，默认隐藏
        $('.l-radio[data-for="bpm_idea_tab"]').click();
        return;
    }
    var _self = this;
    $.ajax({
        url: "platform/bpm/business/getAllIdeaStyleData",
        data: {entryId: this.flowEditor.flowModel.entryId},
        type: "POST",
        dataType: "JSON",
        success: function (r) {
            if(flowUtils.notNull(r)){
                _self.drawIdeaAndSign(r);
            }
        }
    });
};
FlowIdea.prototype.drawIdeaAndSign = function (r){
    var result = r.result;
    if(!flowUtils.notNull(result)){
        //没有数据时，默认隐藏
        $('.l-radio[data-for="bpm_idea_tab"]').click();
        return;
    }
    var _self = this;
    $("#ideaDiv").empty();
    $.each(result, function (x, ideas) {
        if(!flowUtils.notNull(ideas)){
            return;
        }
        var $tr = $("<tr class='pttable'></tr>");
        var $td1 = $("<td class='l pttable'></td>");
        $tr.append($td1);
        var $td2 = $("<td class='r pttable'></td>");
        var $td2_table = $("<table class='pslist-table'></table>");
        var $td2_tbody = $("<tbody class='pslist-text'></tbody>");
        $.each(ideas, function (y, idea) {
            if(y == 0){
                $td1.text(idea.title);
            }
            var $td2_tr = $("<tr></tr>");
            var $td2_tr_td1 = $("<td></td>");
            if(idea.showSign=="1"){
                var $img = $('<img width="80" height="30" title="电子签名" style="cursor: pointer;" src="platform/cc/sysuserphoto/upload/signphoto?sysUserId=' + idea.userId + '"/>');
                $td2_tr_td1.append($img);
            }else{
                $td2_tr_td1.text(idea.user+"/"+idea.dept);
            }
            $td2_tr.append($td2_tr_td1);
            var $td2_tr_td2 = $("<td class='r'></td>");
            $td2_tr_td2.text(_self.getComment(idea));
            $td2_tr.append($td2_tr_td2);
            $td2_tbody.append($td2_tr);
        });
        $td2_table.append($td2_tbody);
        $td2.append($td2_table);
        $tr.append($td2);
        $("#ideaDiv").append($tr);
    });
};
FlowIdea.prototype.getComment = function(ideaData){
    var comment = "";
    var displayStyle = ideaData.displayStyle;
    var displayStyleArr = displayStyle.split(",");
    for(var i = 0; i < displayStyleArr.length; i++){
        if(displayStyleArr[i] == "user" || displayStyleArr[i] == "dept"){
            continue;
        }
        comment += ideaData[displayStyleArr[i]] + " ";
    }
    return comment;
};