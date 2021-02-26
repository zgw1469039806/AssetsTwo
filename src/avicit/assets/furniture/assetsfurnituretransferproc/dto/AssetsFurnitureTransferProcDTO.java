package avicit.assets.furniture.assetsfurnituretransferproc.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-08-14 16:53 
 * @类说明：家具移交
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_transfer_proc", object = "AssetsFurnitureTransferProcDTO", name = "家具移交")
public class AssetsFurnitureTransferProcDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
	private String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private String id;
	/*
	*创建时间开始时间
	*/
	private java.util.Date creationDateBegin;
	/*
	 *创建时间截止时间
	 */
	private java.util.Date creationDateEnd;
	/*
	*最后修改时间开始时间
	*/
	private java.util.Date lastUpdateDateBegin;
	/*
	 *最后修改时间截止时间
	 */
	private java.util.Date lastUpdateDateEnd;

	@FieldRemark(column = "proc_name", field = "procName", name = "流程名称")
	/*
	 *流程名称
	 */
	private String procName;

	@FieldRemark(column = "proc_id", field = "procId", name = "流程ID")
	/*
	 *流程ID
	 */
	private String procId;

	@FieldRemark(column = "form_state", field = "formState", name = "单据状态")
	/*
	 *单据状态
	 */
	private String formState;

	@FieldRemark(column = "created_by_person", field = "createdByPerson", name = "申请人")
	/*
	 *申请人
	 */
	private String createdByPerson;
	/*
	 *申请人显示字段
	 */
	private String createdByPersonAlias;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private String createdByDept;
	/*
	 *申请人部门显示字段
	 */
	private String createdByDeptAlias;

	@FieldRemark(column = "created_by_tel", field = "createdByTel", name = "申请人电话")
	/*
	 *申请人电话
	 */
	private String createdByTel;

	@FieldRemark(column = "receiver", field = "receiver", name = "接收人")
	/*
	 *接收人
	 */
	private String receiver;
	/*
	 *接收人显示字段
	 */
	private String receiverAlias;

	@FieldRemark(column = "receiver_dept", field = "receiverDept", name = "接收人部门")
	/*
	 *接收人部门
	 */
	private String receiverDept;
	/*
	 *接收人部门显示字段
	 */
	private String receiverDeptAlias;

	@FieldRemark(column = "receiver_by_tel", field = "receiverByTel", name = "接收人电话")
	/*
	 *接收人电话
	 */
	private String receiverByTel;

	@FieldRemark(column = "receive_position_id", field = "receivePositionId", name = "接收安装地点ID")
	/*
	 *接收安装地点ID
	 */
	private String receivePositionId;

	@FieldRemark(column = "transfer_reason", field = "transferReason", name = "移交原因")
	/*
	 *移交原因
	 */
	private String transferReason;

	@FieldRemark(column = "furniture_condition", field = "furnitureCondition", name = "家具完好情况")
	/*
	 *家具完好情况
	 */
	private String furnitureCondition;

	@FieldRemark(column = "furniture_appendix", field = "furnitureAppendix", name = "家具附件和数量")
	/*
	 *家具附件和数量
	 */
	private String furnitureAppendix;

	@FieldRemark(column = "remarks", field = "remarks", name = "备注")
	/*
	 *备注
	 */
	private String remarks;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public java.util.Date getCreationDateBegin() {
		return creationDateBegin;
	}

	public void setCreationDateBegin(java.util.Date creationDateBegin) {
		this.creationDateBegin = creationDateBegin;
	}

	public java.util.Date getCreationDateEnd() {
		return creationDateEnd;
	}

	public void setCreationDateEnd(java.util.Date creationDateEnd) {
		this.creationDateEnd = creationDateEnd;
	}

	public java.util.Date getLastUpdateDateBegin() {
		return lastUpdateDateBegin;
	}

	public void setLastUpdateDateBegin(java.util.Date lastUpdateDateBegin) {
		this.lastUpdateDateBegin = lastUpdateDateBegin;
	}

	public java.util.Date getLastUpdateDateEnd() {
		return lastUpdateDateEnd;
	}

	public void setLastUpdateDateEnd(java.util.Date lastUpdateDateEnd) {
		this.lastUpdateDateEnd = lastUpdateDateEnd;
	}

	public String getProcName() {
		return procName;
	}

	public void setProcName(String procName) {
		this.procName = procName;
	}

	public String getProcId() {
		return procId;
	}

	public void setProcId(String procId) {
		this.procId = procId;
	}

	public String getFormState() {
		return formState;
	}

	public void setFormState(String formState) {
		this.formState = formState;
	}

	public String getCreatedByPerson() {
		return createdByPerson;
	}

	public void setCreatedByPerson(String createdByPerson) {
		this.createdByPerson = createdByPerson;
	}

	public String getCreatedByPersonAlias() {
		return createdByPersonAlias;
	}

	public void setCreatedByPersonAlias(String createdByPersonAlias) {
		this.createdByPersonAlias = createdByPersonAlias;
	}

	public String getCreatedByDept() {
		return createdByDept;
	}

	public void setCreatedByDept(String createdByDept) {
		this.createdByDept = createdByDept;
	}

	public String getCreatedByDeptAlias() {
		return createdByDeptAlias;
	}

	public void setCreatedByDeptAlias(String createdByDeptAlias) {
		this.createdByDeptAlias = createdByDeptAlias;
	}

	public String getCreatedByTel() {
		return createdByTel;
	}

	public void setCreatedByTel(String createdByTel) {
		this.createdByTel = createdByTel;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getReceiverAlias() {
		return receiverAlias;
	}

	public void setReceiverAlias(String receiverAlias) {
		this.receiverAlias = receiverAlias;
	}

	public String getReceiverDept() {
		return receiverDept;
	}

	public void setReceiverDept(String receiverDept) {
		this.receiverDept = receiverDept;
	}

	public String getReceiverDeptAlias() {
		return receiverDeptAlias;
	}

	public void setReceiverDeptAlias(String receiverDeptAlias) {
		this.receiverDeptAlias = receiverDeptAlias;
	}

	public String getReceiverByTel() {
		return receiverByTel;
	}

	public void setReceiverByTel(String receiverByTel) {
		this.receiverByTel = receiverByTel;
	}

	public String getReceivePositionId() {
		return receivePositionId;
	}

	public void setReceivePositionId(String receivePositionId) {
		this.receivePositionId = receivePositionId;
	}

	public String getTransferReason() {
		return transferReason;
	}

	public void setTransferReason(String transferReason) {
		this.transferReason = transferReason;
	}

	public String getFurnitureCondition() {
		return furnitureCondition;
	}

	public void setFurnitureCondition(String furnitureCondition) {
		this.furnitureCondition = furnitureCondition;
	}

	public String getFurnitureAppendix() {
		return furnitureAppendix;
	}

	public void setFurnitureAppendix(String furnitureAppendix) {
		this.furnitureAppendix = furnitureAppendix;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getActivityalias_() {
		return activityalias_;
	}

	public void setActivityalias_(String activityalias_) {
		this.activityalias_ = activityalias_;
	}

	public String getActivityname_() {
		return activityname_;
	}

	public void setActivityname_(String activityname_) {
		this.activityname_ = activityname_;
	}

	public String getBusinessstate_() {
		return businessstate_;
	}

	public void setBusinessstate_(String businessstate_) {
		this.businessstate_ = businessstate_;
	}

	public String getBpmType() {
		return bpmType;
	}

	public void setBpmType(String bpmType) {
		this.bpmType = bpmType;
	}

	public String getBpmState() {
		return bpmState;
	}

	public void setBpmState(String bpmState) {
		this.bpmState = bpmState;
	}

	public String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(String currUserId) {
		this.currUserId = currUserId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "家具移交";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "家具移交";
		} else {
			return super.logTitle;
		}
	}

	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}