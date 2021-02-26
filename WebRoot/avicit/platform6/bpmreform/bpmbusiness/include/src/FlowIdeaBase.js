/**
 * 流程意见操作基类
 */
function FlowIdeaBase() {
};
/**
 * 流程操作对象
 */
FlowIdeaBase.prototype.flowEditor = null;
/**
 * 初始化
 */
FlowIdeaBase.prototype.init = function() {
};
/**
 * 显示
 */
FlowIdeaBase.prototype.show = function() {
};
/**
 * 隐藏
 */
FlowIdeaBase.prototype.hide = function() {
};
/**
 * 清空内容
 */
FlowIdeaBase.prototype.clear = function() {
};
/**
 * 设置是否只读
 */
FlowIdeaBase.prototype.readonly = function(readonly) {
};
/**
 * 获取内容
 * @param ideaElementIdBySelf
 */
FlowIdeaBase.prototype.getIdea = function(ideaElementIdBySelf) {
	return "";
};
/**
 * 设置焦点
 * @param ideaElementIdBySelf
 */
FlowIdeaBase.prototype.focusIdeaText = function(ideaElementIdBySelf) {
};
/**
 * 是否有配置的自定义意见框
 * @param ideaElementIdBySelf
 */
FlowIdeaBase.prototype.hasIdeaElementBySelf = function(ideaElementIdBySelf) {
	return false;
};