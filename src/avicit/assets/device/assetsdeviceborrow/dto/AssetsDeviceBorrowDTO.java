package avicit.assets.device.assetsdeviceborrow.dto;

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
 * @创建时间： 2020-07-15 16:48 
 * @类说明：统管设备借用
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_borrow", object = "AssetsDeviceBorrowDTO", name = "统管设备借用")
public class AssetsDeviceBorrowDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
	private String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 *ID
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

	@FieldRemark(column = "form_state", field = "formState", name = "单据状态")
	/*
	 *单据状态
	 */
	private String formState;

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

	@FieldRemark(column = "asset_id", field = "assetId", name = "资产编号")
	/*
	 *资产编号
	 */
	private String assetId;

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategory;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
	/*
	 *设备型号
	 */
	private String deviceModel;

	@FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格")
	/*
	 *设备规格
	 */
	private String deviceSpec;

	@FieldRemark(column = "owner_id", field = "ownerId", name = "责任人")
	/*
	 *责任人
	 */
	private String ownerId;
	/*
	 *责任人显示字段
	 */
	private String ownerIdAlias;

	@FieldRemark(column = "owner_dept", field = "ownerDept", name = "责任人部门")
	/*
	 *责任人部门
	 */
	private String ownerDept;
	/*
	 *责任人部门显示字段
	 */
	private String ownerDeptAlias;

	@FieldRemark(column = "user_id", field = "userId", name = "使用人")
	/*
	 *使用人
	 */
	private String userId;
	/*
	 *使用人显示字段
	 */
	private String userIdAlias;

	@FieldRemark(column = "user_dept", field = "userDept", name = "使用人部门")
	/*
	 *使用人部门
	 */
	private String userDept;
	/*
	 *使用人部门显示字段
	 */
	private String userDeptAlias;

	@FieldRemark(column = "borrow_date", field = "borrowDate", name = "实际借用时间")
	/*
	 *实际借用时间
	 */
	private java.util.Date borrowDate;
	/*
	 *实际借用时间开始时间
	 */
	private java.util.Date borrowDateBegin;
	/*
	 *实际借用时间截止时间
	 */
	private java.util.Date borrowDateEnd;

	@FieldRemark(column = "expect_return_date", field = "expectReturnDate", name = "预计归还时间")
	/*
	 *预计归还时间
	 */
	private java.util.Date expectReturnDate;
	/*
	 *预计归还时间开始时间
	 */
	private java.util.Date expectReturnDateBegin;
	/*
	 *预计归还时间截止时间
	 */
	private java.util.Date expectReturnDateEnd;

	@FieldRemark(column = "return_date", field = "returnDate", name = "实际归还时间")
	/*
	 *实际归还时间
	 */
	private java.util.Date returnDate;
	/*
	 *实际归还时间开始时间
	 */
	private java.util.Date returnDateBegin;
	/*
	 *实际归还时间截止时间
	 */
	private java.util.Date returnDateEnd;

	@FieldRemark(column = "borrow_length", field = "borrowLength", name = "借用时长")
	/*
	 *借用时长
	 */
	private Long borrowLength;

	@FieldRemark(column = "manage_state", field = "manageState", name = "统管设备状态")
	/*
	 *统管设备状态
	 */
	private String manageState;

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

	public String getFormState() {
		return formState;
	}

	public void setFormState(String formState) {
		this.formState = formState;
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

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getDeviceSpec() {
		return deviceSpec;
	}

	public void setDeviceSpec(String deviceSpec) {
		this.deviceSpec = deviceSpec;
	}

	public String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}

	public String getOwnerIdAlias() {
		return ownerIdAlias;
	}

	public void setOwnerIdAlias(String ownerIdAlias) {
		this.ownerIdAlias = ownerIdAlias;
	}

	public String getOwnerDept() {
		return ownerDept;
	}

	public void setOwnerDept(String ownerDept) {
		this.ownerDept = ownerDept;
	}

	public String getOwnerDeptAlias() {
		return ownerDeptAlias;
	}

	public void setOwnerDeptAlias(String ownerDeptAlias) {
		this.ownerDeptAlias = ownerDeptAlias;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserIdAlias() {
		return userIdAlias;
	}

	public void setUserIdAlias(String userIdAlias) {
		this.userIdAlias = userIdAlias;
	}

	public String getUserDept() {
		return userDept;
	}

	public void setUserDept(String userDept) {
		this.userDept = userDept;
	}

	public String getUserDeptAlias() {
		return userDeptAlias;
	}

	public void setUserDeptAlias(String userDeptAlias) {
		this.userDeptAlias = userDeptAlias;
	}

	public java.util.Date getBorrowDate() {
		return borrowDate;
	}

	public void setBorrowDate(java.util.Date borrowDate) {
		this.borrowDate = borrowDate;
	}

	public java.util.Date getBorrowDateBegin() {
		return borrowDateBegin;
	}

	public void setBorrowDateBegin(java.util.Date borrowDateBegin) {
		this.borrowDateBegin = borrowDateBegin;
	}

	public java.util.Date getBorrowDateEnd() {
		return borrowDateEnd;
	}

	public void setBorrowDateEnd(java.util.Date borrowDateEnd) {
		this.borrowDateEnd = borrowDateEnd;
	}

	public java.util.Date getExpectReturnDate() {
		return expectReturnDate;
	}

	public void setExpectReturnDate(java.util.Date expectReturnDate) {
		this.expectReturnDate = expectReturnDate;
	}

	public java.util.Date getExpectReturnDateBegin() {
		return expectReturnDateBegin;
	}

	public void setExpectReturnDateBegin(java.util.Date expectReturnDateBegin) {
		this.expectReturnDateBegin = expectReturnDateBegin;
	}

	public java.util.Date getExpectReturnDateEnd() {
		return expectReturnDateEnd;
	}

	public void setExpectReturnDateEnd(java.util.Date expectReturnDateEnd) {
		this.expectReturnDateEnd = expectReturnDateEnd;
	}

	public java.util.Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(java.util.Date returnDate) {
		this.returnDate = returnDate;
	}

	public java.util.Date getReturnDateBegin() {
		return returnDateBegin;
	}

	public void setReturnDateBegin(java.util.Date returnDateBegin) {
		this.returnDateBegin = returnDateBegin;
	}

	public java.util.Date getReturnDateEnd() {
		return returnDateEnd;
	}

	public void setReturnDateEnd(java.util.Date returnDateEnd) {
		this.returnDateEnd = returnDateEnd;
	}

	public Long getBorrowLength() {
		return borrowLength;
	}

	public void setBorrowLength(Long borrowLength) {
		this.borrowLength = borrowLength;
	}

	public String getManageState() {
		return manageState;
	}

	public void setManageState(String manageState) {
		this.manageState = manageState;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "统管设备借用";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "统管设备借用";
		} else {
			return super.logTitle;
		}
	}

	public String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(String currUserId) {
		this.currUserId = currUserId;
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

	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}