/**
 * 流程意见操作
 */
function FlowIdea() {
	FlowIdeaBase.call(this);
};
FlowIdea.prototype = new FlowIdeaBase();
/**
 * 流程操作对象
 */
FlowIdea.prototype.flowEditor = null;
/**
 * 初始化
 */
FlowIdea.prototype.init = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {defineId : this.flowEditor.flowModel.defineId},
		url : "platform/bpm/business/getMyIdeaList",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				$.each(msg.result, function(i, n) {
					var $li = $('<li>' + n.value + '</li>');
					$li.attr("data-val", n.value);
					$li.on('click', function() {
						$("#bpm_buttons_idea").val($("#bpm_buttons_idea").val()+$(this).text()).trigger('keyup');
			        });
					$("#bpm_buttons_idealist").append($li);
				});
			}
		}
	});
};
/**
 * 显示
 */
FlowIdea.prototype.show = function() {
	$("#bpm_buttons_area").children(".titleBar").show();
	$("#bpm_buttons_area").children(".textArea").show();
};
/**
 * 隐藏
 */
FlowIdea.prototype.hide = function() {
	$("#bpm_buttons_area").children(".titleBar").hide();
	$("#bpm_buttons_area").children(".textArea").hide();
};
/**
 * 清空内容
 */
FlowIdea.prototype.clear = function() {
	$("#bpm_buttons_idea").val("");
};
/**
 * 设置是否只读
 */
FlowIdea.prototype.readonly = function(readonly) {
	if(readonly){
		$("#bpm_buttons_idea").attr("readonly", "readonly");
		$("#bpm_buttons_idealist").attr("readonly", "readonly");
	}else{
		$("#bpm_buttons_idea").removeAttr("readonly");
		$("#bpm_buttons_idealist").removeAttr("readonly");
	}
};
/**
 * 获取内容
 */
FlowIdea.prototype.getIdea = function(ideaElementIdBySelf) {
    var ideaElementBySelf = this.getIdeaElementBySelf(ideaElementIdBySelf);
    if(ideaElementBySelf != null){
        return ideaElementBySelf.val();
    }
    return $("#bpm_buttons_idea").val();
};
/**
 * 设置焦点
 */
FlowIdea.prototype.focusIdeaText = function(ideaElementIdBySelf) {
    var ideaElementBySelf = this.getIdeaElementBySelf(ideaElementIdBySelf);
    if(ideaElementBySelf != null){
        ideaElementBySelf.focus();
        return;
	}
    $("#bpm_buttons_idea").focus();
};
FlowIdea.prototype.hasIdeaElementBySelf = function(ideaElementIdBySelf) {
    return this.getIdeaElementBySelf(ideaElementIdBySelf) != null;
};
FlowIdea.prototype.getIdeaElementBySelf = function(ideaElementIdBySelf) {
    if(typeof ideaElementIdBySelf != "undefined" && ideaElementIdBySelf != null && ideaElementIdBySelf != ""){
        if($("#" + ideaElementIdBySelf).length > 0){
            return $("#" + ideaElementIdBySelf);
        }
        if($("[name='" + ideaElementIdBySelf + "']").length > 0){
            return $("[name='" + ideaElementIdBySelf + "']");
        }
    }
    return null;
};