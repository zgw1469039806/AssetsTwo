package avicit.assets.device.assetsdevicerepair.dto;

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
 * @创建时间： 2020-07-14 14:08 
 * @类说明：设备维修
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_repair", object = "AssetsDeviceRepairDTO", name = "设备维修")
public class AssetsDeviceRepairDTO extends BeanDTO {
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

	@FieldRemark(column = "proc_id", field = "procId", name = "流程ID")
	/*
	 *流程ID
	 */
	private java.lang.String procId;

	@LogField

	@FieldRemark(column = "applicant_id", field = "applicantId", name = "申请人")
	/*
	 *申请人
	 */
	private String applicantId;
	/*
	 *申请人显示字段
	 */
	private String applicantIdAlias;
	@LogField

	@FieldRemark(column = "applicant_depart", field = "applicantDepart", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private String applicantDepart;
	/*
	 *申请人部门显示字段
	 */
	private String applicantDepartAlias;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "form_state", field = "formState", name = "表单状态")
	/*
	 *表单状态
	 */
	private String formState;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategory;

	@FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格")
	/*
	 *设备规格
	 */
	private String deviceSpec;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
	/*
	 *设备型号
	 */
	private String deviceModel;

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

	@FieldRemark(column = "contact", field = "contact", name = "责任人联系方式")
	/*
	 *责任人联系方式
	 */
	private String contact;

	@FieldRemark(column = "position", field = "position", name = "安装地点")
	/*
	 *安装地点
	 */
	private String position;

	@FieldRemark(column = "manufacturer", field = "manufacturer", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private String manufacturer;

	@FieldRemark(column = "is_pc", field = "isPc", name = "是否计算机")
	/*
	 *是否计算机
	 */
	private String isPc;

	@FieldRemark(column = "is_test_device", field = "isTestDevice", name = "是否测试设备")
	/*
	 *是否测试设备
	 */
	private String isTestDevice;

	@FieldRemark(column = "is_metering", field = "isMetering", name = "是否需要计量")
	/*
	 *是否需要计量
	 */
	private String isMetering;

	@FieldRemark(column = "repair_dept", field = "repairDept", name = "维修部门")
	/*
	 *维修部门
	 */
	private String repairDept;
	/*
	 *维修部门显示字段
	 */
	private String repairDeptAlias;

	@FieldRemark(column = "failure_desc", field = "failureDesc", name = "故障现象描述")
	/*
	 *故障现象描述
	 */
	private String failureDesc;

	@FieldRemark(column = "repair_desc", field = "repairDesc", name = "故障维修记录")
	/*
	 *故障维修记录
	 */
	private String repairDesc;

	@FieldRemark(column = "repair_finish_time", field = "repairFinishTime", name = "维修完成时间")
	/*
	 *维修完成时间
	 */
	private java.util.Date repairFinishTime;
	/*
	 *维修完成时间开始时间
	 */
	private java.util.Date repairFinishTimeBegin;
	/*
	 *维修完成时间截止时间
	 */
	private java.util.Date repairFinishTimeEnd;

	@FieldRemark(column = "finish_ack", field = "finishAck", name = "结果确认")
	/*
	 *结果确认
	 */
	private String finishAck;

	@FieldRemark(column = "repair_quality", field = "repairQuality", name = "维修质量")
	/*
	 *维修质量
	 */
	private String repairQuality;

	@FieldRemark(column = "failure_analysis_id", field = "failureAnalysisId", name = "故障分析")
	/*
	 *故障分析
	 */
	private String failureAnalysisId;

	@FieldRemark(column = "failure_analysis_desc", field = "failureAnalysisDesc", name = "故障分析描述")
	/*
	 *故障分析描述
	 */
	private String failureAnalysisDesc;

	@FieldRemark(column = "service_attitude", field = "serviceAttitude", name = "服务态度")
	/*
	 *服务态度
	 */
	private String serviceAttitude;

	@FieldRemark(column = "attribute_01", field = "attribute01", name = "扩展字段01")
	/*
	 *扩展字段01
	 */
	private String attribute01;

	@FieldRemark(column = "attribute_02", field = "attribute02", name = "扩展字段02")
	/*
	 *扩展字段02
	 */
	private String attribute02;

	@FieldRemark(column = "attribute_03", field = "attribute03", name = "扩展字段03")
	/*
	 *扩展字段03
	 */
	private String attribute03;

	@FieldRemark(column = "attribute_04", field = "attribute04", name = "扩展字段04")
	/*
	 *扩展字段04
	 */
	private String attribute04;

	@FieldRemark(column = "attribute_05", field = "attribute05", name = "扩展字段05")
	/*
	 *扩展字段05
	 */
	private String attribute05;

	@FieldRemark(column = "attribute_06", field = "attribute06", name = "扩展字段06")
	/*
	 *扩展字段06
	 */
	private String attribute06;

	@FieldRemark(column = "attribute_07", field = "attribute07", name = "扩展字段07")
	/*
	 *扩展字段07
	 */
	private String attribute07;

	@FieldRemark(column = "attribute_08", field = "attribute08", name = "扩展字段08")
	/*
	 *扩展字段08
	 */
	private String attribute08;

	@FieldRemark(column = "attribute_09", field = "attribute09", name = "扩展字段09")
	/*
	 *扩展字段09
	 */
	private String attribute09;

	@FieldRemark(column = "attribute_10", field = "attribute10", name = "扩展字段10")
	/*
	 *扩展字段10
	 */
	private String attribute10;

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

	@FieldRemark(column = "repair_progress", field = "repairProgress", name = "维修进度")
	/*
	 *维修进度
	 */
	private String repairProgress;

	@FieldRemark(column = "repair_plan_staff", field = "repairPlanStaff", name = "维修计划员")
	/*
	 *维修计划员
	 */
	private String repairPlanStaff;
	/*
	 *维修计划员显示字段
	 */
	private String repairPlanStaffAlias;

	@FieldRemark(column = "repair_staff", field = "repairStaff", name = "维修员")
	/*
	 *维修员
	 */
	private String repairStaff;
	/*
	 *维修员显示字段
	 */
	private String repairStaffAlias;

	@FieldRemark(column = "meter_plan_staff", field = "meterPlanStaff", name = "计量计划员")
	/*
	 *计量计划员
	 */
	private String meterPlanStaff;
	/*
	 *计量计划员显示字段
	 */
	private String meterPlanStaffAlias;

	@FieldRemark(column = "has_extra_expense", field = "hasExtraExpense", name = "是否存在额外开支")
	/*
	 *是否存在额外开支
	 */
	private String hasExtraExpense;

	@FieldRemark(column = "extra_expense_explain", field = "extraExpenseExplain", name = "额外开支说明")
	/*
	 *额外开支说明
	 */
	private String extraExpenseExplain;

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

	public String getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(String applicantId) {
		this.applicantId = applicantId;
	}

	public String getApplicantIdAlias() {
		return applicantIdAlias;
	}

	public void setApplicantIdAlias(String applicantIdAlias) {
		this.applicantIdAlias = applicantIdAlias;
	}

	public String getApplicantDepart() {
		return applicantDepart;
	}

	public void setApplicantDepart(String applicantDepart) {
		this.applicantDepart = applicantDepart;
	}

	public String getApplicantDepartAlias() {
		return applicantDepartAlias;
	}

	public void setApplicantDepartAlias(String applicantDepartAlias) {
		this.applicantDepartAlias = applicantDepartAlias;
	}

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getFormState() {
		return formState;
	}

	public void setFormState(String formState) {
		this.formState = formState;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public String getDeviceSpec() {
		return deviceSpec;
	}

	public void setDeviceSpec(String deviceSpec) {
		this.deviceSpec = deviceSpec;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
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

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getIsPc() {
		return isPc;
	}

	public void setIsPc(String isPc) {
		this.isPc = isPc;
	}

	public String getIsTestDevice() {
		return isTestDevice;
	}

	public void setIsTestDevice(String isTestDevice) {
		this.isTestDevice = isTestDevice;
	}

	public String getIsMetering() {
		return isMetering;
	}

	public void setIsMetering(String isMetering) {
		this.isMetering = isMetering;
	}

	public String getRepairDept() {
		return repairDept;
	}

	public void setRepairDept(String repairDept) {
		this.repairDept = repairDept;
	}

	public String getRepairDeptAlias() {
		return repairDeptAlias;
	}

	public void setRepairDeptAlias(String repairDeptAlias) {
		this.repairDeptAlias = repairDeptAlias;
	}

	public String getFailureDesc() {
		return failureDesc;
	}

	public void setFailureDesc(String failureDesc) {
		this.failureDesc = failureDesc;
	}

	public String getRepairDesc() {
		return repairDesc;
	}

	public void setRepairDesc(String repairDesc) {
		this.repairDesc = repairDesc;
	}

	public java.util.Date getRepairFinishTime() {
		return repairFinishTime;
	}

	public void setRepairFinishTime(java.util.Date repairFinishTime) {
		this.repairFinishTime = repairFinishTime;
	}

	public java.util.Date getRepairFinishTimeBegin() {
		return repairFinishTimeBegin;
	}

	public void setRepairFinishTimeBegin(java.util.Date repairFinishTimeBegin) {
		this.repairFinishTimeBegin = repairFinishTimeBegin;
	}

	public java.util.Date getRepairFinishTimeEnd() {
		return repairFinishTimeEnd;
	}

	public void setRepairFinishTimeEnd(java.util.Date repairFinishTimeEnd) {
		this.repairFinishTimeEnd = repairFinishTimeEnd;
	}

	public String getFinishAck() {
		return finishAck;
	}

	public void setFinishAck(String finishAck) {
		this.finishAck = finishAck;
	}

	public String getRepairQuality() {
		return repairQuality;
	}

	public void setRepairQuality(String repairQuality) {
		this.repairQuality = repairQuality;
	}

	public String getFailureAnalysisId() {
		return failureAnalysisId;
	}

	public void setFailureAnalysisId(String failureAnalysisId) {
		this.failureAnalysisId = failureAnalysisId;
	}

	public String getFailureAnalysisDesc() {
		return failureAnalysisDesc;
	}

	public void setFailureAnalysisDesc(String failureAnalysisDesc) {
		this.failureAnalysisDesc = failureAnalysisDesc;
	}

	public String getServiceAttitude() {
		return serviceAttitude;
	}

	public void setServiceAttitude(String serviceAttitude) {
		this.serviceAttitude = serviceAttitude;
	}

	public String getAttribute01() {
		return attribute01;
	}

	public void setAttribute01(String attribute01) {
		this.attribute01 = attribute01;
	}

	public String getAttribute02() {
		return attribute02;
	}

	public void setAttribute02(String attribute02) {
		this.attribute02 = attribute02;
	}

	public String getAttribute03() {
		return attribute03;
	}

	public void setAttribute03(String attribute03) {
		this.attribute03 = attribute03;
	}

	public String getAttribute04() {
		return attribute04;
	}

	public void setAttribute04(String attribute04) {
		this.attribute04 = attribute04;
	}

	public String getAttribute05() {
		return attribute05;
	}

	public void setAttribute05(String attribute05) {
		this.attribute05 = attribute05;
	}

	public String getAttribute06() {
		return attribute06;
	}

	public void setAttribute06(String attribute06) {
		this.attribute06 = attribute06;
	}

	public String getAttribute07() {
		return attribute07;
	}

	public void setAttribute07(String attribute07) {
		this.attribute07 = attribute07;
	}

	public String getAttribute08() {
		return attribute08;
	}

	public void setAttribute08(String attribute08) {
		this.attribute08 = attribute08;
	}

	public String getAttribute09() {
		return attribute09;
	}

	public void setAttribute09(String attribute09) {
		this.attribute09 = attribute09;
	}

	public String getAttribute10() {
		return attribute10;
	}

	public void setAttribute10(String attribute10) {
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

	public String getRepairProgress() {
		return repairProgress;
	}

	public void setRepairProgress(String repairProgress) {
		this.repairProgress = repairProgress;
	}

	public String getRepairPlanStaff() {
		return repairPlanStaff;
	}

	public java.lang.String getProcId() {
		return procId;
	}

	public void setProcId(java.lang.String procId) {
		this.procId = procId;
	}

	public void setRepairPlanStaff(String repairPlanStaff) {
		this.repairPlanStaff = repairPlanStaff;
	}

	public String getRepairPlanStaffAlias() {
		return repairPlanStaffAlias;
	}

	public void setRepairPlanStaffAlias(String repairPlanStaffAlias) {
		this.repairPlanStaffAlias = repairPlanStaffAlias;
	}

	public String getRepairStaff() {
		return repairStaff;
	}

	public void setRepairStaff(String repairStaff) {
		this.repairStaff = repairStaff;
	}

	public String getRepairStaffAlias() {
		return repairStaffAlias;
	}

	public void setRepairStaffAlias(String repairStaffAlias) {
		this.repairStaffAlias = repairStaffAlias;
	}

	public String getMeterPlanStaff() {
		return meterPlanStaff;
	}

	public void setMeterPlanStaff(String meterPlanStaff) {
		this.meterPlanStaff = meterPlanStaff;
	}

	public String getMeterPlanStaffAlias() {
		return meterPlanStaffAlias;
	}

	public void setMeterPlanStaffAlias(String meterPlanStaffAlias) {
		this.meterPlanStaffAlias = meterPlanStaffAlias;
	}

	public String getHasExtraExpense() {
		return hasExtraExpense;
	}

	public void setHasExtraExpense(String hasExtraExpense) {
		this.hasExtraExpense = hasExtraExpense;
	}

	public String getExtraExpenseExplain() {
		return extraExpenseExplain;
	}

	public void setExtraExpenseExplain(String extraExpenseExplain) {
		this.extraExpenseExplain = extraExpenseExplain;
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
			return "设备维修";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "设备维修";
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

    public void setCreatedByAlias(String sysUserNameById) {
    }

	public void setLastUpdatedByAlias(String sysUserNameById) {
	}
}