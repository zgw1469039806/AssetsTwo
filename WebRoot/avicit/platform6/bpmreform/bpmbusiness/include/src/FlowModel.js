/**
 * 数据模板
 */
function FlowModel(defineId, deploymentId, entryId, executionId, taskId) {
	this.defineId = defineId;
	this.deploymentId = deploymentId;
    _fileupload_entryId = entryId;
	this.entryId = entryId;
	this.executionId = executionId;
	this.taskId = taskId;
};
/**
 * 流程定义文件主键
 *
 * @param defineId
 */
FlowModel.prototype.defineId = null;
FlowModel.prototype.setDefineId = function(defineId) {
	this.defineId = defineId;
};
/**
 * 流程部署文件主键
 *
 * @param deploymentId
 */
FlowModel.prototype.deploymentId = null;
FlowModel.prototype.setDeploymentId = function(deploymentId) {
	this.deploymentId = deploymentId;
};

/**
 * 流程实例主键
 *
 * @param entryId
 */
FlowModel.prototype.entryId = null;
FlowModel.prototype.setEntryId = function(entryId) {
    _fileupload_entryId = entryId;
	this.entryId = entryId;
};
/**
 * 流程指针ID
 *
 * @param executionId
 */
FlowModel.prototype.executionId = null;
FlowModel.prototype.setExecutionId = function(executionId) {
	this.executionId = executionId;
};
/**
 * 流程任务ID
 *
 * @param taskId
 */
FlowModel.prototype.taskId = null;
FlowModel.prototype.setTaskId = function(taskId) {
	this.taskId = taskId;
};
/**
 * 当前节点名称
 *
 * @param activityname
 */
FlowModel.prototype.activityname = null;
FlowModel.prototype.setActivityname = function(activityname) {
    _fileupload_taskName = activityname;
	this.activityname = activityname;
};
/**
 * 当前节点显示名
 *
 * @param activityname
 */
FlowModel.prototype.activitylabel = null;
FlowModel.prototype.setActivitylabel = function(activitylabel) {
	this.activitylabel = activitylabel;
};
/**
 * 当前身份
 * 用户身份 1待办人2 已办人 3待阅人 4已阅人 5读者，6拟稿人，7管理员，0未知
 *
 * @param activityname
 */
FlowModel.prototype.userIdentityKey = null;
FlowModel.prototype.setUserIdentityKey = function(userIdentityKey) {
	this.userIdentityKey = userIdentityKey;
};
/**
 * 当前身份
 * 用户身份 待办人 已办人 待阅人 已阅人 读者，拟稿人，管理员
 *
 * @param activityname
 */
FlowModel.prototype.userIdentity = null;
FlowModel.prototype.setUserIdentity = function(userIdentity) {
	this.userIdentity = userIdentity;
};
/**
 * 自定义强制表态意见
 * @type {null}
 */
FlowModel.prototype.ideasBySelf = null;
FlowModel.prototype.setIdeasBySelf = function(ideasBySelf) {
	this.ideasBySelf = ideasBySelf;
};
//暴漏的全局变量，下载附件是像后台传递
var _fileupload_entryId = "";
var _fileupload_taskName = "";
