/**
 * 业务操作父类
 */
function DefaultForm() {
};
/**
 * 流程操作对象
 */
DefaultForm.prototype.flowEditor = null;

/**
 * 提交和退回前是否自动保存
 */
DefaultForm.prototype.isAutoSave = true;

/**
 * 表单主键
 *
 * @param id
 */
DefaultForm.prototype.id = null;
DefaultForm.prototype.setId = function(id) {
	this.id = id;
};
/**
 * 初始化业务数据
 */
DefaultForm.prototype.initFormData = function() {
};
/**
 * 启动流程
 *
 * @param defineId
 * @param callback
 */
DefaultForm.prototype.start = function(defineId, callback) {
};
/**
 * 更新数据
 *
 * @param callback
 */
DefaultForm.prototype.save = function(callback) {
};
/**
 * 刷新权限按钮后事件
 */
DefaultForm.prototype.afterCreateButtons = function() {
};
/**
 * 刷新表单元素权限成功后事件
 */
DefaultForm.prototype.afterControlFormInput = function() {
};
/**
 * 密级下拉框再过滤事件
 */
DefaultForm.prototype.filterSecretLevel = function(secretLevelList) {
	return secretLevelList;
};
/**
 * 引用文档上传前校验密级
 */
DefaultForm.prototype.validSecretLevel = function(secretLevelArr){
	return true;
};
/**
 * 设置附件是否可增删
 */
DefaultForm.prototype.setAttachMagic = function(magic){
};

/**
 * 设置多附件是否可增删
 */
DefaultForm.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
};

/**
 * 设置多附件是否必填
 */
DefaultForm.prototype.setAttachRequired = function(tagId,required,obj){
};

/**
 * 设置多附件密级是否可修改
 */
DefaultForm.prototype.setAttachSecretLevelModify = function(tagId,modify,obj){
};

/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param operability 是否可编辑
 */
DefaultForm.prototype.controlSelfElement = function(tagId, operability, obj){
};
/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSelfElementForAccess = function(tagId, accessibility, obj){
};
/**
 * 自定义元素的必填控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param required 是否必填
 */
DefaultForm.prototype.controlSelfElementForRequired = function(tagId, accessibility, obj){
};

/**
 * 子表按钮元素的权限控制，子表按钮元素定义通过".eform_subtable_bpm_button_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSubTableButtonForAccess = function(tagId, accessibility, obj){
};

/**
 * 非电子表单子表字段的显隐控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForAccess = function(tagId, accessibility, obj){
};
/**
 * 非电子表单子表字段的可编辑控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForOperability = function(tagId, operability, obj){
};
/**
 * 非电子表单子表字段的必填控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForRequired = function(tagId, required, obj){
};
/**
 * 重新组织意见
 * @param idea
 * @param users
 * @returns {*}
 */
DefaultForm.prototype.reGetidea = function(idea, users){
    return idea;
};
/**
 * 默认流程意见
 * @param operateType 操作类型
 * @returns
 */
DefaultForm.prototype.getDefaultIdea = function (operateType) {
    return null;
};
/**
 * 判断选人框是否正确选人
 * @param users 当前选人数据
 * @returns {boolean} true继续操作，false终止操作
 */
DefaultForm.prototype.selectUserSuccess = function (users) {
	return true;
};
/**
 * 流程页面初始化事件，在按钮第一次加载后被执行
 */
DefaultForm.prototype.afterInit = function(){
};
/**
 * 是否在流程加载前执行用户密级与流程密级的匹配校验，若不匹配，则关闭页面
 */
DefaultForm.prototype.checkUserSecretLevel = function(){
	return typeof checkUserSecretLevel !== "undefined" && checkUserSecretLevel;
};
/**
 * 流程变量中哪个值存储密级，默认为"SECRETLEVEL" 或 "secretLevel"，也可以实现这个接口自行指定另外的值
 */
DefaultForm.prototype.secretLevelCode = function(){
	return typeof secretLevelCode !== "undefined" ? secretLevelCode : null;
};
/** 前后置事件 */
/**
 * 提交前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSubmit = function(data) {
	return true;
};
/**
 * 提交后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSubmit = function(data) {
};

/**
 * 退回前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeRetreat = function(data) {
	return true;
};
/**
 * 退回后事件
 *
 * @param data
 */
DefaultForm.prototype.afterRetreat = function(data) {
};

/**
 * 拿回前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdraw = function(data) {
	return true;
};
/**
 * 拿回后事件
 *
 * @param data
 */
DefaultForm.prototype.afterWithdraw = function(data) {
};

/**
 * 补发前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupplement = function(data) {
	return true;
};
/**
 * 补发后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSupplement = function(data) {
};

/**
 * 加签前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeAdduser = function(data) {
	return true;
};
/**
 * 加签后事件
 *
 * @param data
 */
DefaultForm.prototype.afterAdduser = function(data) {
};

/**
 * 转办前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupersede = function(data) {
	return true;
};
/**
 * 转办后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSupersede = function(data) {
};

/**
 * 转发前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTransmit = function(data) {
	return true;
};
/**
 * 转发后事件
 *
 * @param data
 */
DefaultForm.prototype.afterTransmit = function(data) {
};

/**
 * 增加读者前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTaskreader = function(data) {
	return true;
};
/**
 * 增加读者后事件
 *
 * @param data
 */
DefaultForm.prototype.afterTaskreader = function(data) {
};

/**
 * 减签前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdrawassignee = function(data) {
	return true;
};
/**
 * 减签后事件
 *
 * @param data
 */
DefaultForm.prototype.afterWithdrawassignee = function(data) {
};

/**
 * 流程结束前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalend = function(data) {
	return true;
};
/**
 * 流程结束后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalend = function(data) {
};

/**
 * 流程跳转前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobaljump = function(data) {
	return true;
};
/**
 * 流程跳转后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobaljump = function(data) {
};

/**
 * 流程恢复前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalresume = function(data) {
	return true;
};
/**
 * 流程恢复后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalresume = function(data) {
};

/**
 * 流程暂停前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalsuspend = function(data) {
	return true;
};
/**
 * 流程暂停后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalsuspend = function(data) {
};

/**
 * 自定义选人前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeStepuserdefined = function(data) {
	return true;
};
/**
 * 自定义选人后事件
 *
 * @param data
 */
DefaultForm.prototype.afterStepuserdefined = function(data) {
};
/**
 * 催办前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforePresstodo = function(data) {
	return true;
};
/**
 * 催办后事件
 *
 * @param data
 */
DefaultForm.prototype.afterPresstodo = function(data) {
};
/**
 * 引导按钮code
 */
DefaultForm.prototype.getLeadButCodeList = function() {
	var result = new Array();
	result.push("dosubmit");
	result.push("dosubmit_mesh");
	result.push("dostart");
	result.push("dotransmitsubmit");
	return result;
};