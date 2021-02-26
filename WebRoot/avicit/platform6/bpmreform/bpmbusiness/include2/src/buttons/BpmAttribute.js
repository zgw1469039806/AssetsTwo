/**
 * 扩展按钮
 */
function BpmAttribute(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.buttonData = buttonData;
    this.getHtml();
};
BpmAttribute.prototype = new BpmButton();

BpmAttribute.prototype.getHtml = function () {
    var _self = this;
    if (this.isEvent) {
        return;
    }
    $("._attribute").each(function (i, n) {
        $(n).children("a").off("click");
    });
    var meshMap = new Map();
    $.each(this.buttonData, function (i, n) {
        if (flowUtils.notNull(n.event) && n.event.endsWith("_attribute")) {
            var id = n.event.replaceAll("_attribute", "");
            if (id.endsWith("_mesh")) {
                $("#" + id).children("ul").empty();
                id = id.replaceAll("_mesh", "");
                meshMap.put(id, n);
            }
        }
    });
    $.each(this.buttonData, function (i, n) {
        if (flowUtils.notNull(n.event) && n.event.endsWith("_attribute")) {
            var id = n.event.replaceAll("_attribute", "");
            var func = $("#" + id).attr("_function");
            if (flowUtils.notNull(func)) {
                if (!id.endsWith("_mesh")) {
                    if (id.indexOf("_") != -1) {
                        var key = id.substr(0, id.indexOf("_"));
                        if (meshMap.containsKey(key)) {
                            var meshDomeId = key + "_mesh";
                            var label = $("#" + id).find("span").text();
                            var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
                            li.children("a").on("click", function() {
                                eval(func + "(_self)");
                            });
                            $("#" + meshDomeId).children("ul").append(li);
                            _self.flowEditor.showButtons(meshDomeId);
                            return;
                        }
                    }
                }

                $("#" + id).children("a").on("click", function () {
                    eval(func + "(_self)");
                });
                _self.flowEditor.showButtons(id);
            }
        }
    });
};