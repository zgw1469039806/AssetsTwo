package avicit.assets.device.assetsdevicemetering.dto;

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
 * @创建时间： 2020-09-04 16:14 
 * @类说明：设备计量
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_metering", object = "AssetsDeviceMeteringDTO", name = "设备计量")
public class AssetsDeviceMeteringDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private java.lang.String activityalias_; // 节点中文名称
	private java.lang.String activityname_; // 当前节点id
	private java.lang.String businessstate_; // 流程当前状态
	private java.lang.String currUserId; // 当前登录人ID
	private java.lang.String bpmType;
	private java.lang.String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
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

	@FieldRemark(column = "proc_id", field = "procId", name = "流程ID")
	/*
	 *流程ID
	 */
	private java.lang.String procId;

	@LogField

	@FieldRemark(column = "applicant_id", field = "applicantId", name = "申请人ID")
	/*
	 *申请人ID
	 */
	private java.lang.String applicantId;
	/*
	 *申请人ID显示字段
	 */
	private java.lang.String applicantIdAlias;
	@LogField

	@FieldRemark(column = "applicant_depart", field = "applicantDepart", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private java.lang.String applicantDepart;
	/*
	 *申请人部门显示字段
	 */
	private java.lang.String applicantDepartAlias;

	@FieldRemark(column = "owner_id", field = "ownerId", name = "责任人")
	/*
	 *责任人
	 */
	private java.lang.String ownerId;
	/*
	 *责任人显示字段
	 */
	private java.lang.String ownerIdAlias;

	@FieldRemark(column = "owner_dept", field = "ownerDept", name = "责任人部门")
	/*
	 *责任人部门
	 */
	private java.lang.String ownerDept;
	/*
	 *责任人部门显示字段
	 */
	private java.lang.String ownerDeptAlias;

	@FieldRemark(column = "senddevice_pid", field = "senddevicePid", name = "送检人ID")
	/*
	 *送检人ID
	 */
	private java.lang.String senddevicePid;
	/*
	 *送检人ID显示字段
	 */
	private java.lang.String senddevicePidAlias;

	@FieldRemark(column = "senddevice_dept", field = "senddeviceDept", name = "送检人部门")
	/*
	 *送检人部门
	 */
	private java.lang.String senddeviceDept;
	/*
	 *送检人部门显示字段
	 */
	private java.lang.String senddeviceDeptAlias;

	@FieldRemark(column = "takedevice_pid", field = "takedevicePid", name = "取走人ID")
	/*
	 *取走人ID
	 */
	private java.lang.String takedevicePid;
	/*
	 *取走人ID显示字段
	 */
	private java.lang.String takedevicePidAlias;

	@FieldRemark(column = "takedevice_dept", field = "takedeviceDept", name = "取走人部门")
	/*
	 *取走人部门
	 */
	private java.lang.String takedeviceDept;
	/*
	 *取走人部门显示字段
	 */
	private java.lang.String takedeviceDeptAlias;

	@FieldRemark(column = "delivery_pid", field = "deliveryPid", name = "外送员ID")
	/*
	 *外送员ID
	 */
	private java.lang.String deliveryPid;
	/*
	 *外送员ID显示字段
	 */
	private java.lang.String deliveryPidAlias;

	@FieldRemark(column = "delivery_dept", field = "deliveryDept", name = "外送员部门")
	/*
	 *外送员部门
	 */
	private java.lang.String deliveryDept;
	/*
	 *外送员部门显示字段
	 */
	private java.lang.String deliveryDeptAlias;

	@FieldRemark(column = "form_state", field = "formState", name = "表单状态")
	/*
	 *表单状态
	 */
	private java.lang.String formState;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private java.lang.String unifiedId;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private java.lang.String deviceName;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private java.lang.String deviceCategory;

	@FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格")
	/*
	 *设备规格
	 */
	private java.lang.String deviceSpec;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
	/*
	 *设备型号
	 */
	private java.lang.String deviceModel;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private java.lang.String secretLevel;
	/*
	 *密级显示名称
	 */
	private java.lang.String secretLevelName;

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点ID")
	/*
	 *安装地点ID
	 */
	private java.lang.String positionId;

	@FieldRemark(column = "manufacturer", field = "manufacturer", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private java.lang.String manufacturer;

	@FieldRemark(column = "is_metering", field = "isMetering", name = "是否计量")
	/*
	 *是否计量
	 */
	private java.lang.String isMetering;
	/*
	 *是否计量显示名称
	 */
	private java.lang.String isMeteringName;

	@FieldRemark(column = "meter_mode", field = "meterMode", name = "计量方式")
	/*
	 *计量方式
	 */
	private java.lang.String meterMode;
	/*
	 *计量方式显示名称
	 */
	private java.lang.String meterModeName;

	@FieldRemark(column = "meter_finish_date", field = "meterFinishDate", name = "计量完成时间")
	/*
	 *计量完成时间
	 */
	private java.util.Date meterFinishDate;
	/*
	 *计量完成时间开始时间
	 */
	private java.util.Date meterFinishDateBegin;
	/*
	 *计量完成时间截止时间
	 */
	private java.util.Date meterFinishDateEnd;

	@FieldRemark(column = "meter_cycle", field = "meterCycle", name = "计量周期")
	/*
	 *计量周期
	 */
	private Long meterCycle;

	@FieldRemark(column = "last_metering_date", field = "lastMeteringDate", name = "上次计量时间")
	/*
	 *上次计量时间
	 */
	private java.util.Date lastMeteringDate;
	/*
	 *上次计量时间开始时间
	 */
	private java.util.Date lastMeteringDateBegin;
	/*
	 *上次计量时间截止时间
	 */
	private java.util.Date lastMeteringDateEnd;

	@FieldRemark(column = "meter_person", field = "meterPerson", name = "计量员")
	/*
	 *计量员
	 */
	private java.lang.String meterPerson;
	/*
	 *计量员显示字段
	 */
	private java.lang.String meterPersonAlias;

	@FieldRemark(column = "meter_plan_person", field = "meterPlanPerson", name = "计量计划员")
	/*
	 *计量计划员
	 */
	private java.lang.String meterPlanPerson;
	/*
	 *计量计划员显示字段
	 */
	private java.lang.String meterPlanPersonAlias;

	@FieldRemark(column = "meter_takeaway_person", field = "meterTakeawayPerson", name = "外送员")
	/*
	 *外送员
	 */
	private java.lang.String meterTakeawayPerson;
	/*
	 *外送员显示字段
	 */
	private java.lang.String meterTakeawayPersonAlias;

	@FieldRemark(column = "meter_conclusion", field = "meterConclusion", name = "计量结论")
	/*
	 *计量结论
	 */
	private java.lang.String meterConclusion;
	/*
	 *计量结论显示名称
	 */
	private java.lang.String meterConclusionName;

	@FieldRemark(column = "is_derive_oft", field = "isDeriveOft", name = "是否派生超差追溯")
	/*
	 *是否派生超差追溯
	 */
	private java.lang.String isDeriveOft;
	/*
	 *是否派生超差追溯显示名称
	 */
	private java.lang.String isDeriveOftName;

	@FieldRemark(column = "express_number", field = "expressNumber", name = "快递单号")
	/*
	 *快递单号
	 */
	private java.lang.String expressNumber;

	@FieldRemark(column = "delivery_date", field = "deliveryDate", name = "预送检日期")
	/*
	 *预送检日期
	 */
	private java.util.Date deliveryDate;
	/*
	 *预送检日期开始时间
	 */
	private java.util.Date deliveryDateBegin;
	/*
	 *预送检日期截止时间
	 */
	private java.util.Date deliveryDateEnd;

	@FieldRemark(column = "attribute_01", field = "attribute01", name = "扩展字段01")
	/*
	 *扩展字段01
	 */
	private java.lang.String attribute01;

	@FieldRemark(column = "attribute_02", field = "attribute02", name = "扩展字段02")
	/*
	 *扩展字段02
	 */
	private java.lang.String attribute02;

	@FieldRemark(column = "attribute_03", field = "attribute03", name = "扩展字段03")
	/*
	 *扩展字段03
	 */
	private java.lang.String attribute03;

	@FieldRemark(column = "attribute_04", field = "attribute04", name = "扩展字段04")
	/*
	 *扩展字段04
	 */
	private java.lang.String attribute04;

	@FieldRemark(column = "attribute_05", field = "attribute05", name = "扩展字段05")
	/*
	 *扩展字段05
	 */
	private java.lang.String attribute05;

	@FieldRemark(column = "attribute_06", field = "attribute06", name = "扩展字段06")
	/*
	 *扩展字段06
	 */
	private java.lang.String attribute06;

	@FieldRemark(column = "attribute_07", field = "attribute07", name = "扩展字段07")
	/*
	 *扩展字段07
	 */
	private java.lang.String attribute07;

	@FieldRemark(column = "attribute_08", field = "attribute08", name = "扩展字段08")
	/*
	 *扩展字段08
	 */
	private java.lang.String attribute08;

	@FieldRemark(column = "attribute_09", field = "attribute09", name = "扩展字段09")
	/*
	 *扩展字段09
	 */
	private java.lang.String attribute09;

	@FieldRemark(column = "attribute_10", field = "attribute10", name = "扩展字段10")
	/*
	 *扩展字段10
	 */
	private java.lang.String attribute10;

	@FieldRemark(column = "attribute_11", field = "attribute11", name = "扩展字段11")
	/*
	 *扩展字段11
	 */
	private Long attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
	/*
	 *扩展字段12
	 */
	private Long attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
	/*
	 *扩展字段13
	 */
	private Long attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
	/*
	 *扩展字段14
	 */
	private java.math.BigDecimal attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
	/*
	 *扩展字段15
	 */
	private java.math.BigDecimal attribute15;

	@FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
	/*
	 *扩展字段16
	 */
	private java.math.BigDecimal attribute16;

	@FieldRemark(column = "attribute_17", field = "attribute17", name = "扩展字段17")
	/*
	 *扩展字段17
	 */
	private java.util.Date attribute17;
	/*
	 *扩展字段17开始时间
	 */
	private java.util.Date attribute17Begin;
	/*
	 *扩展字段17截止时间
	 */
	private java.util.Date attribute17End;

	@FieldRemark(column = "attribute_18", field = "attribute18", name = "扩展字段18")
	/*
	 *扩展字段18
	 */
	private java.util.Date attribute18;
	/*
	 *扩展字段18开始时间
	 */
	private java.util.Date attribute18Begin;
	/*
	 *扩展字段18截止时间
	 */
	private java.util.Date attribute18End;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
	/*
	 *扩展字段19
	 */
	private java.util.Date attribute19;
	/*
	 *扩展字段19开始时间
	 */
	private java.util.Date attribute19Begin;
	/*
	 *扩展字段19截止时间
	 */
	private java.util.Date attribute19End;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
	/*
	 *扩展字段20
	 */
	private java.util.Date attribute20;
	/*
	 *扩展字段20开始时间
	 */
	private java.util.Date attribute20Begin;
	/*
	 *扩展字段20截止时间
	 */
	private java.util.Date attribute20End;

	@FieldRemark(column = "procedure_file_id", field = "procedureFileId", name = "计量文件受控号")
	/*
	 *计量文件受控号
	 */
	private java.lang.String procedureFileId;

	@FieldRemark(column = "metering_origin", field = "meteringOrigin", name = "计量任务来源")
	/*
	 *计量任务来源
	 */
	private java.lang.String meteringOrigin;
	/*
	 *计量任务来源显示名称
	 */
	private java.lang.String meteringOriginName;

	@FieldRemark(column = "is_delivery_allowed", field = "isDeliveryAllowed", name = "是否允许外送检")
	/*
	 *是否允许外送检
	 */
	private java.lang.String isDeliveryAllowed;
	/*
	 *是否允许外送检显示名称
	 */
	private java.lang.String isDeliveryAllowedName;

	@FieldRemark(column = "form_check_conclude", field = "formCheckConclude", name = "形式审核结论")
	/*
	 *形式审核结论
	 */
	private java.lang.String formCheckConclude;
	/*
	 *形式审核结论显示名称
	 */
	private java.lang.String formCheckConcludeName;

	@FieldRemark(column = "manager_conclude", field = "managerConclude", name = "计量室主任审核结论")
	/*
	 *计量室主任审核结论
	 */
	private java.lang.String managerConclude;
	/*
	 *计量室主任审核结论显示名称
	 */
	private java.lang.String managerConcludeName;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
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

	public java.lang.String getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(java.lang.String applicantId) {
		this.applicantId = applicantId;
	}

	public java.lang.String getApplicantIdAlias() {
		return applicantIdAlias;
	}

	public void setApplicantIdAlias(java.lang.String applicantIdAlias) {
		this.applicantIdAlias = applicantIdAlias;
	}

	public java.lang.String getApplicantDepart() {
		return applicantDepart;
	}

	public void setApplicantDepart(java.lang.String applicantDepart) {
		this.applicantDepart = applicantDepart;
	}

	public java.lang.String getApplicantDepartAlias() {
		return applicantDepartAlias;
	}

	public void setApplicantDepartAlias(java.lang.String applicantDepartAlias) {
		this.applicantDepartAlias = applicantDepartAlias;
	}

	public java.lang.String getProcId() {
		return procId;
	}

	public void setProcId(java.lang.String procId) {
		this.procId = procId;
	}

	public java.lang.String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(java.lang.String ownerId) {
		this.ownerId = ownerId;
	}

	public java.lang.String getOwnerIdAlias() {
		return ownerIdAlias;
	}

	public void setOwnerIdAlias(java.lang.String ownerIdAlias) {
		this.ownerIdAlias = ownerIdAlias;
	}

	public java.lang.String getOwnerDept() {
		return ownerDept;
	}

	public void setOwnerDept(java.lang.String ownerDept) {
		this.ownerDept = ownerDept;
	}

	public java.lang.String getOwnerDeptAlias() {
		return ownerDeptAlias;
	}

	public void setOwnerDeptAlias(java.lang.String ownerDeptAlias) {
		this.ownerDeptAlias = ownerDeptAlias;
	}

	public java.lang.String getSenddevicePid() {
		return senddevicePid;
	}

	public void setSenddevicePid(java.lang.String senddevicePid) {
		this.senddevicePid = senddevicePid;
	}

	public java.lang.String getSenddevicePidAlias() {
		return senddevicePidAlias;
	}

	public void setSenddevicePidAlias(java.lang.String senddevicePidAlias) {
		this.senddevicePidAlias = senddevicePidAlias;
	}

	public java.lang.String getSenddeviceDept() {
		return senddeviceDept;
	}

	public void setSenddeviceDept(java.lang.String senddeviceDept) {
		this.senddeviceDept = senddeviceDept;
	}

	public java.lang.String getSenddeviceDeptAlias() {
		return senddeviceDeptAlias;
	}

	public void setSenddeviceDeptAlias(java.lang.String senddeviceDeptAlias) {
		this.senddeviceDeptAlias = senddeviceDeptAlias;
	}

	public java.lang.String getTakedevicePid() {
		return takedevicePid;
	}

	public void setTakedevicePid(java.lang.String takedevicePid) {
		this.takedevicePid = takedevicePid;
	}

	public java.lang.String getTakedevicePidAlias() {
		return takedevicePidAlias;
	}

	public void setTakedevicePidAlias(java.lang.String takedevicePidAlias) {
		this.takedevicePidAlias = takedevicePidAlias;
	}

	public java.lang.String getTakedeviceDept() {
		return takedeviceDept;
	}

	public void setTakedeviceDept(java.lang.String takedeviceDept) {
		this.takedeviceDept = takedeviceDept;
	}

	public java.lang.String getTakedeviceDeptAlias() {
		return takedeviceDeptAlias;
	}

	public void setTakedeviceDeptAlias(java.lang.String takedeviceDeptAlias) {
		this.takedeviceDeptAlias = takedeviceDeptAlias;
	}

	public java.lang.String getDeliveryPid() {
		return deliveryPid;
	}

	public void setDeliveryPid(java.lang.String deliveryPid) {
		this.deliveryPid = deliveryPid;
	}

	public java.lang.String getDeliveryPidAlias() {
		return deliveryPidAlias;
	}

	public void setDeliveryPidAlias(java.lang.String deliveryPidAlias) {
		this.deliveryPidAlias = deliveryPidAlias;
	}

	public java.lang.String getDeliveryDept() {
		return deliveryDept;
	}

	public void setDeliveryDept(java.lang.String deliveryDept) {
		this.deliveryDept = deliveryDept;
	}

	public java.lang.String getDeliveryDeptAlias() {
		return deliveryDeptAlias;
	}

	public void setDeliveryDeptAlias(java.lang.String deliveryDeptAlias) {
		this.deliveryDeptAlias = deliveryDeptAlias;
	}

	public java.lang.String getFormState() {
		return formState;
	}

	public void setFormState(java.lang.String formState) {
		this.formState = formState;
	}

	public java.lang.String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(java.lang.String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public java.lang.String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(java.lang.String deviceName) {
		this.deviceName = deviceName;
	}

	public java.lang.String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(java.lang.String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public java.lang.String getDeviceSpec() {
		return deviceSpec;
	}

	public void setDeviceSpec(java.lang.String deviceSpec) {
		this.deviceSpec = deviceSpec;
	}

	public java.lang.String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(java.lang.String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public java.lang.String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(java.lang.String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public java.lang.String getSecretLevelName() {
		return secretLevelName;
	}

	public void setSecretLevelName(java.lang.String secretLevelName) {
		this.secretLevelName = secretLevelName;
	}

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
	}

	public java.lang.String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(java.lang.String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public java.lang.String getIsMetering() {
		return isMetering;
	}

	public void setIsMetering(java.lang.String isMetering) {
		this.isMetering = isMetering;
	}

	public java.lang.String getIsMeteringName() {
		return isMeteringName;
	}

	public void setIsMeteringName(java.lang.String isMeteringName) {
		this.isMeteringName = isMeteringName;
	}

	public java.lang.String getMeterMode() {
		return meterMode;
	}

	public void setMeterMode(java.lang.String meterMode) {
		this.meterMode = meterMode;
	}

	public java.lang.String getMeterModeName() {
		return meterModeName;
	}

	public void setMeterModeName(java.lang.String meterModeName) {
		this.meterModeName = meterModeName;
	}

	public java.util.Date getMeterFinishDate() {
		return meterFinishDate;
	}

	public void setMeterFinishDate(java.util.Date meterFinishDate) {
		this.meterFinishDate = meterFinishDate;
	}

	public java.util.Date getMeterFinishDateBegin() {
		return meterFinishDateBegin;
	}

	public void setMeterFinishDateBegin(java.util.Date meterFinishDateBegin) {
		this.meterFinishDateBegin = meterFinishDateBegin;
	}

	public java.util.Date getMeterFinishDateEnd() {
		return meterFinishDateEnd;
	}

	public void setMeterFinishDateEnd(java.util.Date meterFinishDateEnd) {
		this.meterFinishDateEnd = meterFinishDateEnd;
	}

	public Long getMeterCycle() {
		return meterCycle;
	}

	public void setMeterCycle(Long meterCycle) {
		this.meterCycle = meterCycle;
	}

	public java.util.Date getLastMeteringDate() {
		return lastMeteringDate;
	}

	public void setLastMeteringDate(java.util.Date lastMeteringDate) {
		this.lastMeteringDate = lastMeteringDate;
	}

	public java.util.Date getLastMeteringDateBegin() {
		return lastMeteringDateBegin;
	}

	public void setLastMeteringDateBegin(java.util.Date lastMeteringDateBegin) {
		this.lastMeteringDateBegin = lastMeteringDateBegin;
	}

	public java.util.Date getLastMeteringDateEnd() {
		return lastMeteringDateEnd;
	}

	public void setLastMeteringDateEnd(java.util.Date lastMeteringDateEnd) {
		this.lastMeteringDateEnd = lastMeteringDateEnd;
	}

	public java.lang.String getMeterPerson() {
		return meterPerson;
	}

	public void setMeterPerson(java.lang.String meterPerson) {
		this.meterPerson = meterPerson;
	}

	public java.lang.String getMeterPersonAlias() {
		return meterPersonAlias;
	}

	public void setMeterPersonAlias(java.lang.String meterPersonAlias) {
		this.meterPersonAlias = meterPersonAlias;
	}

	public java.lang.String getMeterPlanPerson() {
		return meterPlanPerson;
	}

	public void setMeterPlanPerson(java.lang.String meterPlanPerson) {
		this.meterPlanPerson = meterPlanPerson;
	}

	public java.lang.String getMeterPlanPersonAlias() {
		return meterPlanPersonAlias;
	}

	public void setMeterPlanPersonAlias(java.lang.String meterPlanPersonAlias) {
		this.meterPlanPersonAlias = meterPlanPersonAlias;
	}

	public java.lang.String getMeterTakeawayPerson() {
		return meterTakeawayPerson;
	}

	public void setMeterTakeawayPerson(java.lang.String meterTakeawayPerson) {
		this.meterTakeawayPerson = meterTakeawayPerson;
	}

	public java.lang.String getMeterTakeawayPersonAlias() {
		return meterTakeawayPersonAlias;
	}

	public void setMeterTakeawayPersonAlias(java.lang.String meterTakeawayPersonAlias) {
		this.meterTakeawayPersonAlias = meterTakeawayPersonAlias;
	}

	public java.lang.String getMeterConclusion() {
		return meterConclusion;
	}

	public void setMeterConclusion(java.lang.String meterConclusion) {
		this.meterConclusion = meterConclusion;
	}

	public java.lang.String getMeterConclusionName() {
		return meterConclusionName;
	}

	public void setMeterConclusionName(java.lang.String meterConclusionName) {
		this.meterConclusionName = meterConclusionName;
	}

	public java.lang.String getIsDeriveOft() {
		return isDeriveOft;
	}

	public void setIsDeriveOft(java.lang.String isDeriveOft) {
		this.isDeriveOft = isDeriveOft;
	}

	public java.lang.String getIsDeriveOftName() {
		return isDeriveOftName;
	}

	public void setIsDeriveOftName(java.lang.String isDeriveOftName) {
		this.isDeriveOftName = isDeriveOftName;
	}

	public java.lang.String getExpressNumber() {
		return expressNumber;
	}

	public void setExpressNumber(java.lang.String expressNumber) {
		this.expressNumber = expressNumber;
	}

	public java.util.Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(java.util.Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public java.util.Date getDeliveryDateBegin() {
		return deliveryDateBegin;
	}

	public void setDeliveryDateBegin(java.util.Date deliveryDateBegin) {
		this.deliveryDateBegin = deliveryDateBegin;
	}

	public java.util.Date getDeliveryDateEnd() {
		return deliveryDateEnd;
	}

	public void setDeliveryDateEnd(java.util.Date deliveryDateEnd) {
		this.deliveryDateEnd = deliveryDateEnd;
	}

	public java.lang.String getAttribute01() {
		return attribute01;
	}

	public void setAttribute01(java.lang.String attribute01) {
		this.attribute01 = attribute01;
	}

	public java.lang.String getAttribute02() {
		return attribute02;
	}

	public void setAttribute02(java.lang.String attribute02) {
		this.attribute02 = attribute02;
	}

	public java.lang.String getAttribute03() {
		return attribute03;
	}

	public void setAttribute03(java.lang.String attribute03) {
		this.attribute03 = attribute03;
	}

	public java.lang.String getAttribute04() {
		return attribute04;
	}

	public void setAttribute04(java.lang.String attribute04) {
		this.attribute04 = attribute04;
	}

	public java.lang.String getAttribute05() {
		return attribute05;
	}

	public void setAttribute05(java.lang.String attribute05) {
		this.attribute05 = attribute05;
	}

	public java.lang.String getAttribute06() {
		return attribute06;
	}

	public void setAttribute06(java.lang.String attribute06) {
		this.attribute06 = attribute06;
	}

	public java.lang.String getAttribute07() {
		return attribute07;
	}

	public void setAttribute07(java.lang.String attribute07) {
		this.attribute07 = attribute07;
	}

	public java.lang.String getAttribute08() {
		return attribute08;
	}

	public void setAttribute08(java.lang.String attribute08) {
		this.attribute08 = attribute08;
	}

	public java.lang.String getAttribute09() {
		return attribute09;
	}

	public void setAttribute09(java.lang.String attribute09) {
		this.attribute09 = attribute09;
	}

	public java.lang.String getAttribute10() {
		return attribute10;
	}

	public void setAttribute10(java.lang.String attribute10) {
		this.attribute10 = attribute10;
	}

	public Long getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(Long attribute11) {
		this.attribute11 = attribute11;
	}

	public Long getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(Long attribute12) {
		this.attribute12 = attribute12;
	}

	public Long getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(Long attribute13) {
		this.attribute13 = attribute13;
	}

	public java.math.BigDecimal getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(java.math.BigDecimal attribute14) {
		this.attribute14 = attribute14;
	}

	public java.math.BigDecimal getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(java.math.BigDecimal attribute15) {
		this.attribute15 = attribute15;
	}

	public java.math.BigDecimal getAttribute16() {
		return attribute16;
	}

	public void setAttribute16(java.math.BigDecimal attribute16) {
		this.attribute16 = attribute16;
	}

	public java.util.Date getAttribute17() {
		return attribute17;
	}

	public void setAttribute17(java.util.Date attribute17) {
		this.attribute17 = attribute17;
	}

	public java.util.Date getAttribute17Begin() {
		return attribute17Begin;
	}

	public void setAttribute17Begin(java.util.Date attribute17Begin) {
		this.attribute17Begin = attribute17Begin;
	}

	public java.util.Date getAttribute17End() {
		return attribute17End;
	}

	public void setAttribute17End(java.util.Date attribute17End) {
		this.attribute17End = attribute17End;
	}

	public java.util.Date getAttribute18() {
		return attribute18;
	}

	public void setAttribute18(java.util.Date attribute18) {
		this.attribute18 = attribute18;
	}

	public java.util.Date getAttribute18Begin() {
		return attribute18Begin;
	}

	public void setAttribute18Begin(java.util.Date attribute18Begin) {
		this.attribute18Begin = attribute18Begin;
	}

	public java.util.Date getAttribute18End() {
		return attribute18End;
	}

	public void setAttribute18End(java.util.Date attribute18End) {
		this.attribute18End = attribute18End;
	}

	public java.util.Date getAttribute19() {
		return attribute19;
	}

	public void setAttribute19(java.util.Date attribute19) {
		this.attribute19 = attribute19;
	}

	public java.util.Date getAttribute19Begin() {
		return attribute19Begin;
	}

	public void setAttribute19Begin(java.util.Date attribute19Begin) {
		this.attribute19Begin = attribute19Begin;
	}

	public java.util.Date getAttribute19End() {
		return attribute19End;
	}

	public void setAttribute19End(java.util.Date attribute19End) {
		this.attribute19End = attribute19End;
	}

	public java.util.Date getAttribute20() {
		return attribute20;
	}

	public void setAttribute20(java.util.Date attribute20) {
		this.attribute20 = attribute20;
	}

	public java.util.Date getAttribute20Begin() {
		return attribute20Begin;
	}

	public void setAttribute20Begin(java.util.Date attribute20Begin) {
		this.attribute20Begin = attribute20Begin;
	}

	public java.util.Date getAttribute20End() {
		return attribute20End;
	}

	public void setAttribute20End(java.util.Date attribute20End) {
		this.attribute20End = attribute20End;
	}

	public java.lang.String getProcedureFileId() {
		return procedureFileId;
	}

	public void setProcedureFileId(java.lang.String procedureFileId) {
		this.procedureFileId = procedureFileId;
	}

	public java.lang.String getMeteringOrigin() {
		return meteringOrigin;
	}

	public void setMeteringOrigin(java.lang.String meteringOrigin) {
		this.meteringOrigin = meteringOrigin;
	}

	public java.lang.String getMeteringOriginName() {
		return meteringOriginName;
	}

	public void setMeteringOriginName(java.lang.String meteringOriginName) {
		this.meteringOriginName = meteringOriginName;
	}

	public java.lang.String getIsDeliveryAllowed() {
		return isDeliveryAllowed;
	}

	public void setIsDeliveryAllowed(java.lang.String isDeliveryAllowed) {
		this.isDeliveryAllowed = isDeliveryAllowed;
	}

	public java.lang.String getIsDeliveryAllowedName() {
		return isDeliveryAllowedName;
	}

	public void setIsDeliveryAllowedName(java.lang.String isDeliveryAllowedName) {
		this.isDeliveryAllowedName = isDeliveryAllowedName;
	}

	public java.lang.String getFormCheckConclude() {
		return formCheckConclude;
	}

	public void setFormCheckConclude(java.lang.String formCheckConclude) {
		this.formCheckConclude = formCheckConclude;
	}

	public java.lang.String getFormCheckConcludeName() {
		return formCheckConcludeName;
	}

	public void setFormCheckConcludeName(java.lang.String formCheckConcludeName) {
		this.formCheckConcludeName = formCheckConcludeName;
	}

	public java.lang.String getManagerConclude() {
		return managerConclude;
	}

	public void setManagerConclude(java.lang.String managerConclude) {
		this.managerConclude = managerConclude;
	}

	public java.lang.String getManagerConcludeName() {
		return managerConcludeName;
	}

	public void setManagerConcludeName(java.lang.String managerConcludeName) {
		this.managerConcludeName = managerConcludeName;
	}

	public java.lang.String getActivityalias_() {
		return activityalias_;
	}

	public void setActivityalias_(java.lang.String activityalias_) {
		this.activityalias_ = activityalias_;
	}

	public java.lang.String getActivityname_() {
		return activityname_;
	}

	public void setActivityname_(java.lang.String activityname_) {
		this.activityname_ = activityname_;
	}

	public java.lang.String getBusinessstate_() {
		return businessstate_;
	}

	public void setBusinessstate_(java.lang.String businessstate_) {
		this.businessstate_ = businessstate_;
	}

	public java.lang.String getBpmType() {
		return bpmType;
	}

	public void setBpmType(java.lang.String bpmType) {
		this.bpmType = bpmType;
	}

	public java.lang.String getBpmState() {
		return bpmState;
	}

	public void setBpmState(java.lang.String bpmState) {
		this.bpmState = bpmState;
	}

	public java.lang.String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(java.lang.String currUserId) {
		this.currUserId = currUserId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "设备计量";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "设备计量";
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