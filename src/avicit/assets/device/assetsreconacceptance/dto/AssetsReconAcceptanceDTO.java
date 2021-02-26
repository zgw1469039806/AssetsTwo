package avicit.assets.device.assetsreconacceptance.dto;

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
 * @创建时间： 2020-09-11 17:21 
 * @类说明：大修改造验收表
 * @修改记录： 
 */
@PojoRemark(table = "assets_recon_acceptance", object = "AssetsReconAcceptanceDTO", name = "大修改造验收表")
public class AssetsReconAcceptanceDTO extends BeanDTO {
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

	@FieldRemark(column = "acceptance_no", field = "acceptanceNo", name = "验收单号")
	/*
	 *验收单号
	 */
	private String acceptanceNo;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "创建人部门")
	/*
	 *创建人部门
	 */
	private String createdByDept;
	/*
	 *创建人部门显示字段
	 */
	private String createdByDeptAlias;
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

	@FieldRemark(column = "form_state", field = "formState", name = "单据状态")
	/*
	 *单据状态
	 */
	private String formState;

	@FieldRemark(column = "apply_by", field = "applyBy", name = "申请人")
	/*
	 *申请人
	 */
	private String applyBy;
	/*
	 *申请人显示字段
	 */
	private String applyByAlias;

	@FieldRemark(column = "apply_by_dept", field = "applyByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private String applyByDept;
	/*
	 *申请人部门显示字段
	 */
	private String applyByDeptAlias;

	@FieldRemark(column = "reconstruction_no", field = "reconstructionNo", name = "申购单号")
	/*
	 *申购单号
	 */
	private String reconstructionNo;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private String secretLevel;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private String manufacturerId;

	@FieldRemark(column = "competent_chief_engineer", field = "competentChiefEngineer", name = "主管总师")
	/*
	 *主管总师
	 */
	private String competentChiefEngineer;
	/*
	 *主管总师显示字段
	 */
	private String competentChiefEngineerAlias;

	@FieldRemark(column = "owner_dept", field = "ownerDept", name = "责任人部门")
	/*
	 *责任人部门
	 */
	private String ownerDept;
	/*
	 *责任人部门显示字段
	 */
	private String ownerDeptAlias;

	@FieldRemark(column = "owner_id", field = "ownerId", name = "责任人")
	/*
	 *责任人
	 */
	private String ownerId;
	/*
	 *责任人显示字段
	 */
	private String ownerIdAlias;

	@FieldRemark(column = "owner_tel", field = "ownerTel", name = "责任人联系方式")
	/*
	 *责任人联系方式
	 */
	private String ownerTel;

	@FieldRemark(column = "sets_count", field = "setsCount", name = "台(套)数")
	/*
	 *台(套)数
	 */
	private Long setsCount;

	@FieldRemark(column = "unit_price", field = "unitPrice", name = "单价(元)")
	/*
	 *单价(元)
	 */
	private Long unitPrice;

	@FieldRemark(column = "project_director", field = "projectDirector", name = "项目主管")
	/*
	 *项目主管
	 */
	private String projectDirector;
	/*
	 *项目主管显示字段
	 */
	private String projectDirectorAlias;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategory;

	@FieldRemark(column = "if_regular_check", field = "ifRegularCheck", name = "是否定检")
	/*
	 *是否定检
	 */
	private String ifRegularCheck;

	@FieldRemark(column = "if_spot_check", field = "ifSpotCheck", name = "是否点检")
	/*
	 *是否点检
	 */
	private String ifSpotCheck;

	@FieldRemark(column = "if_precision_inspection", field = "ifPrecisionInspection", name = "是否精度检查")
	/*
	 *是否精度检查
	 */
	private String ifPrecisionInspection;

	@FieldRemark(column = "if_upkeep", field = "ifUpkeep", name = "是否保养")
	/*
	 *是否保养
	 */
	private String ifUpkeep;

	@FieldRemark(column = "upkeep_cycle", field = "upkeepCycle", name = "保养周期(天)")
	/*
	 *保养周期(天)
	 */
	private Long upkeepCycle;

	@FieldRemark(column = "upkeep_requirements", field = "upkeepRequirements", name = "保养要求")
	/*
	 *保养要求
	 */
	private String upkeepRequirements;

	@FieldRemark(column = "next_upkeep_date", field = "nextUpkeepDate", name = "下次保养时间")
	/*
	 *下次保养时间
	 */
	private java.util.Date nextUpkeepDate;
	/*
	 *下次保养时间开始时间
	 */
	private java.util.Date nextUpkeepDateBegin;
	/*
	 *下次保养时间截止时间
	 */
	private java.util.Date nextUpkeepDateEnd;

	@FieldRemark(column = "if_measure", field = "ifMeasure", name = "是否计量")
	/*
	 *是否计量
	 */
	private String ifMeasure;

	@FieldRemark(column = "if_install", field = "ifInstall", name = "是否需要安装")
	/*
	 *是否需要安装
	 */
	private String ifInstall;

	@FieldRemark(column = "if_measure_onsite", field = "ifMeasureOnsite", name = "是否现场计量")
	/*
	 *是否现场计量
	 */
	private String ifMeasureOnsite;

	@FieldRemark(column = "measure_identify", field = "measureIdentify", name = "计量标识")
	/*
	 *计量标识
	 */
	private String measureIdentify;

	@FieldRemark(column = "measure_by", field = "measureBy", name = "计量人员")
	/*
	 *计量人员
	 */
	private String measureBy;
	/*
	 *计量人员显示字段
	 */
	private String measureByAlias;

	@FieldRemark(column = "metering_date", field = "meteringDate", name = "计量时间")
	/*
	 *计量时间
	 */
	private java.util.Date meteringDate;
	/*
	 *计量时间开始时间
	 */
	private java.util.Date meteringDateBegin;
	/*
	 *计量时间截止时间
	 */
	private java.util.Date meteringDateEnd;

	@FieldRemark(column = "metering_cycle", field = "meteringCycle", name = "计量周期(天)")
	/*
	 *计量周期(天)
	 */
	private Long meteringCycle;

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点")
	/*
	 *安装地点
	 */
	private String positionId;

	@FieldRemark(column = "if_has_computer", field = "ifHasComputer", name = "是否含计算机/无线模板")
	/*
	 *是否含计算机/无线模板
	 */
	private String ifHasComputer;

	@FieldRemark(column = "is_safety_production", field = "isSafetyProduction", name = "是否涉及安全生产")
	/*
	 *是否涉及安全生产
	 */
	private String isSafetyProduction;

	@FieldRemark(column = "financial_resources", field = "financialResources", name = "经费来源")
	/*
	 *经费来源
	 */
	private String financialResources;

	@FieldRemark(column = "belong_project", field = "belongProject", name = "所属项目")
	/*
	 *所属项目
	 */
	private String belongProject;

	@FieldRemark(column = "project_no", field = "projectNo", name = "项目序号")
	/*
	 *项目序号
	 */
	private String projectNo;

	@FieldRemark(column = "reply_name", field = "replyName", name = "批复名称")
	/*
	 *批复名称
	 */
	private String replyName;

	@FieldRemark(column = "project_approval_no", field = "projectApprovalNo", name = "立项单号")
	/*
	 *立项单号
	 */
	private String projectApprovalNo;

	@FieldRemark(column = "abc_category", field = "abcCategory", name = "ABC分类")
	/*
	 *ABC分类
	 */
	private String abcCategory;

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
	private String attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
	/*
	 *扩展字段12
	 */
	private String attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
	/*
	 *扩展字段13
	 */
	private String attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
	/*
	 *扩展字段14
	 */
	private String attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
	/*
	 *扩展字段15
	 */
	private String attribute15;

	@FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
	/*
	 *扩展字段16
	 */
	private Long attribute16;

	@FieldRemark(column = "attribute_17", field = "attribute17", name = "扩展字段17")
	/*
	 *扩展字段17
	 */
	private Long attribute17;

	@FieldRemark(column = "attribute_18", field = "attribute18", name = "扩展字段18")
	/*
	 *扩展字段18
	 */
	private Long attribute18;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
	/*
	 *扩展字段19
	 */
	private Long attribute19;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
	/*
	 *扩展字段20
	 */
	private Long attribute20;

	@FieldRemark(column = "attribute_21", field = "attribute21", name = "扩展字段21")
	/*
	 *扩展字段21
	 */
	private java.math.BigDecimal attribute21;

	@FieldRemark(column = "attribute_22", field = "attribute22", name = "扩展字段22")
	/*
	 *扩展字段22
	 */
	private java.math.BigDecimal attribute22;

	@FieldRemark(column = "attribute_23", field = "attribute23", name = "扩展字段23")
	/*
	 *扩展字段23
	 */
	private java.math.BigDecimal attribute23;

	@FieldRemark(column = "attribute_24", field = "attribute24", name = "扩展字段24")
	/*
	 *扩展字段24
	 */
	private java.math.BigDecimal attribute24;

	@FieldRemark(column = "attribute_25", field = "attribute25", name = "扩展字段25")
	/*
	 *扩展字段25
	 */
	private java.math.BigDecimal attribute25;

	@FieldRemark(column = "attribute_26", field = "attribute26", name = "扩展字段26")
	/*
	 *扩展字段26
	 */
	private java.util.Date attribute26;
	/*
	 *扩展字段26开始时间
	 */
	private java.util.Date attribute26Begin;
	/*
	 *扩展字段26截止时间
	 */
	private java.util.Date attribute26End;

	@FieldRemark(column = "attribute_27", field = "attribute27", name = "扩展字段27")
	/*
	 *扩展字段27
	 */
	private java.util.Date attribute27;
	/*
	 *扩展字段27开始时间
	 */
	private java.util.Date attribute27Begin;
	/*
	 *扩展字段27截止时间
	 */
	private java.util.Date attribute27End;

	@FieldRemark(column = "attribute_28", field = "attribute28", name = "扩展字段28")
	/*
	 *扩展字段28
	 */
	private java.util.Date attribute28;
	/*
	 *扩展字段28开始时间
	 */
	private java.util.Date attribute28Begin;
	/*
	 *扩展字段28截止时间
	 */
	private java.util.Date attribute28End;

	@FieldRemark(column = "attribute_29", field = "attribute29", name = "扩展字段29")
	/*
	 *扩展字段29
	 */
	private java.util.Date attribute29;
	/*
	 *扩展字段29开始时间
	 */
	private java.util.Date attribute29Begin;
	/*
	 *扩展字段29截止时间
	 */
	private java.util.Date attribute29End;

	@FieldRemark(column = "attribute_30", field = "attribute30", name = "扩展字段30")
	/*
	 *扩展字段30
	 */
	private java.util.Date attribute30;
	/*
	 *扩展字段30开始时间
	 */
	private java.util.Date attribute30Begin;
	/*
	 *扩展字段30截止时间
	 */
	private java.util.Date attribute30End;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAcceptanceNo() {
		return acceptanceNo;
	}

	public void setAcceptanceNo(String acceptanceNo) {
		this.acceptanceNo = acceptanceNo;
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

	public String getFormState() {
		return formState;
	}

	public void setFormState(String formState) {
		this.formState = formState;
	}

	public String getApplyBy() {
		return applyBy;
	}

	public void setApplyBy(String applyBy) {
		this.applyBy = applyBy;
	}

	public String getApplyByAlias() {
		return applyByAlias;
	}

	public void setApplyByAlias(String applyByAlias) {
		this.applyByAlias = applyByAlias;
	}

	public String getApplyByDept() {
		return applyByDept;
	}

	public void setApplyByDept(String applyByDept) {
		this.applyByDept = applyByDept;
	}

	public String getApplyByDeptAlias() {
		return applyByDeptAlias;
	}

	public void setApplyByDeptAlias(String applyByDeptAlias) {
		this.applyByDeptAlias = applyByDeptAlias;
	}

	public String getReconstructionNo() {
		return reconstructionNo;
	}

	public void setReconstructionNo(String reconstructionNo) {
		this.reconstructionNo = reconstructionNo;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public String getCompetentChiefEngineer() {
		return competentChiefEngineer;
	}

	public void setCompetentChiefEngineer(String competentChiefEngineer) {
		this.competentChiefEngineer = competentChiefEngineer;
	}

	public String getCompetentChiefEngineerAlias() {
		return competentChiefEngineerAlias;
	}

	public void setCompetentChiefEngineerAlias(String competentChiefEngineerAlias) {
		this.competentChiefEngineerAlias = competentChiefEngineerAlias;
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

	public String getOwnerTel() {
		return ownerTel;
	}

	public void setOwnerTel(String ownerTel) {
		this.ownerTel = ownerTel;
	}

	public Long getSetsCount() {
		return setsCount;
	}

	public void setSetsCount(Long setsCount) {
		this.setsCount = setsCount;
	}

	public Long getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Long unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getProjectDirector() {
		return projectDirector;
	}

	public void setProjectDirector(String projectDirector) {
		this.projectDirector = projectDirector;
	}

	public String getProjectDirectorAlias() {
		return projectDirectorAlias;
	}

	public void setProjectDirectorAlias(String projectDirectorAlias) {
		this.projectDirectorAlias = projectDirectorAlias;
	}

	public String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public String getIfRegularCheck() {
		return ifRegularCheck;
	}

	public void setIfRegularCheck(String ifRegularCheck) {
		this.ifRegularCheck = ifRegularCheck;
	}

	public String getIfSpotCheck() {
		return ifSpotCheck;
	}

	public void setIfSpotCheck(String ifSpotCheck) {
		this.ifSpotCheck = ifSpotCheck;
	}

	public String getIfPrecisionInspection() {
		return ifPrecisionInspection;
	}

	public void setIfPrecisionInspection(String ifPrecisionInspection) {
		this.ifPrecisionInspection = ifPrecisionInspection;
	}

	public String getIfUpkeep() {
		return ifUpkeep;
	}

	public void setIfUpkeep(String ifUpkeep) {
		this.ifUpkeep = ifUpkeep;
	}

	public Long getUpkeepCycle() {
		return upkeepCycle;
	}

	public void setUpkeepCycle(Long upkeepCycle) {
		this.upkeepCycle = upkeepCycle;
	}

	public String getUpkeepRequirements() {
		return upkeepRequirements;
	}

	public void setUpkeepRequirements(String upkeepRequirements) {
		this.upkeepRequirements = upkeepRequirements;
	}

	public java.util.Date getNextUpkeepDate() {
		return nextUpkeepDate;
	}

	public void setNextUpkeepDate(java.util.Date nextUpkeepDate) {
		this.nextUpkeepDate = nextUpkeepDate;
	}

	public java.util.Date getNextUpkeepDateBegin() {
		return nextUpkeepDateBegin;
	}

	public void setNextUpkeepDateBegin(java.util.Date nextUpkeepDateBegin) {
		this.nextUpkeepDateBegin = nextUpkeepDateBegin;
	}

	public java.util.Date getNextUpkeepDateEnd() {
		return nextUpkeepDateEnd;
	}

	public void setNextUpkeepDateEnd(java.util.Date nextUpkeepDateEnd) {
		this.nextUpkeepDateEnd = nextUpkeepDateEnd;
	}

	public String getIfMeasure() {
		return ifMeasure;
	}

	public void setIfMeasure(String ifMeasure) {
		this.ifMeasure = ifMeasure;
	}

	public String getIfInstall() {
		return ifInstall;
	}

	public void setIfInstall(String ifInstall) {
		this.ifInstall = ifInstall;
	}

	public String getIfMeasureOnsite() {
		return ifMeasureOnsite;
	}

	public void setIfMeasureOnsite(String ifMeasureOnsite) {
		this.ifMeasureOnsite = ifMeasureOnsite;
	}

	public String getMeasureIdentify() {
		return measureIdentify;
	}

	public void setMeasureIdentify(String measureIdentify) {
		this.measureIdentify = measureIdentify;
	}

	public String getMeasureBy() {
		return measureBy;
	}

	public void setMeasureBy(String measureBy) {
		this.measureBy = measureBy;
	}

	public String getMeasureByAlias() {
		return measureByAlias;
	}

	public void setMeasureByAlias(String measureByAlias) {
		this.measureByAlias = measureByAlias;
	}

	public java.util.Date getMeteringDate() {
		return meteringDate;
	}

	public void setMeteringDate(java.util.Date meteringDate) {
		this.meteringDate = meteringDate;
	}

	public java.util.Date getMeteringDateBegin() {
		return meteringDateBegin;
	}

	public void setMeteringDateBegin(java.util.Date meteringDateBegin) {
		this.meteringDateBegin = meteringDateBegin;
	}

	public java.util.Date getMeteringDateEnd() {
		return meteringDateEnd;
	}

	public void setMeteringDateEnd(java.util.Date meteringDateEnd) {
		this.meteringDateEnd = meteringDateEnd;
	}

	public Long getMeteringCycle() {
		return meteringCycle;
	}

	public void setMeteringCycle(Long meteringCycle) {
		this.meteringCycle = meteringCycle;
	}

	public String getPositionId() {
		return positionId;
	}

	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}

	public String getIfHasComputer() {
		return ifHasComputer;
	}

	public void setIfHasComputer(String ifHasComputer) {
		this.ifHasComputer = ifHasComputer;
	}

	public String getIsSafetyProduction() {
		return isSafetyProduction;
	}

	public void setIsSafetyProduction(String isSafetyProduction) {
		this.isSafetyProduction = isSafetyProduction;
	}

	public String getFinancialResources() {
		return financialResources;
	}

	public void setFinancialResources(String financialResources) {
		this.financialResources = financialResources;
	}

	public String getBelongProject() {
		return belongProject;
	}

	public void setBelongProject(String belongProject) {
		this.belongProject = belongProject;
	}

	public String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}

	public String getReplyName() {
		return replyName;
	}

	public void setReplyName(String replyName) {
		this.replyName = replyName;
	}

	public String getProjectApprovalNo() {
		return projectApprovalNo;
	}

	public void setProjectApprovalNo(String projectApprovalNo) {
		this.projectApprovalNo = projectApprovalNo;
	}

	public String getAbcCategory() {
		return abcCategory;
	}

	public void setAbcCategory(String abcCategory) {
		this.abcCategory = abcCategory;
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

	public String getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(String attribute11) {
		this.attribute11 = attribute11;
	}

	public String getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(String attribute12) {
		this.attribute12 = attribute12;
	}

	public String getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(String attribute13) {
		this.attribute13 = attribute13;
	}

	public String getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(String attribute14) {
		this.attribute14 = attribute14;
	}

	public String getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(String attribute15) {
		this.attribute15 = attribute15;
	}

	public Long getAttribute16() {
		return attribute16;
	}

	public void setAttribute16(Long attribute16) {
		this.attribute16 = attribute16;
	}

	public Long getAttribute17() {
		return attribute17;
	}

	public void setAttribute17(Long attribute17) {
		this.attribute17 = attribute17;
	}

	public Long getAttribute18() {
		return attribute18;
	}

	public void setAttribute18(Long attribute18) {
		this.attribute18 = attribute18;
	}

	public Long getAttribute19() {
		return attribute19;
	}

	public void setAttribute19(Long attribute19) {
		this.attribute19 = attribute19;
	}

	public Long getAttribute20() {
		return attribute20;
	}

	public void setAttribute20(Long attribute20) {
		this.attribute20 = attribute20;
	}

	public java.math.BigDecimal getAttribute21() {
		return attribute21;
	}

	public void setAttribute21(java.math.BigDecimal attribute21) {
		this.attribute21 = attribute21;
	}

	public java.math.BigDecimal getAttribute22() {
		return attribute22;
	}

	public void setAttribute22(java.math.BigDecimal attribute22) {
		this.attribute22 = attribute22;
	}

	public java.math.BigDecimal getAttribute23() {
		return attribute23;
	}

	public void setAttribute23(java.math.BigDecimal attribute23) {
		this.attribute23 = attribute23;
	}

	public java.math.BigDecimal getAttribute24() {
		return attribute24;
	}

	public void setAttribute24(java.math.BigDecimal attribute24) {
		this.attribute24 = attribute24;
	}

	public java.math.BigDecimal getAttribute25() {
		return attribute25;
	}

	public void setAttribute25(java.math.BigDecimal attribute25) {
		this.attribute25 = attribute25;
	}

	public java.util.Date getAttribute26() {
		return attribute26;
	}

	public void setAttribute26(java.util.Date attribute26) {
		this.attribute26 = attribute26;
	}

	public java.util.Date getAttribute26Begin() {
		return attribute26Begin;
	}

	public void setAttribute26Begin(java.util.Date attribute26Begin) {
		this.attribute26Begin = attribute26Begin;
	}

	public java.util.Date getAttribute26End() {
		return attribute26End;
	}

	public void setAttribute26End(java.util.Date attribute26End) {
		this.attribute26End = attribute26End;
	}

	public java.util.Date getAttribute27() {
		return attribute27;
	}

	public void setAttribute27(java.util.Date attribute27) {
		this.attribute27 = attribute27;
	}

	public java.util.Date getAttribute27Begin() {
		return attribute27Begin;
	}

	public void setAttribute27Begin(java.util.Date attribute27Begin) {
		this.attribute27Begin = attribute27Begin;
	}

	public java.util.Date getAttribute27End() {
		return attribute27End;
	}

	public void setAttribute27End(java.util.Date attribute27End) {
		this.attribute27End = attribute27End;
	}

	public java.util.Date getAttribute28() {
		return attribute28;
	}

	public void setAttribute28(java.util.Date attribute28) {
		this.attribute28 = attribute28;
	}

	public java.util.Date getAttribute28Begin() {
		return attribute28Begin;
	}

	public void setAttribute28Begin(java.util.Date attribute28Begin) {
		this.attribute28Begin = attribute28Begin;
	}

	public java.util.Date getAttribute28End() {
		return attribute28End;
	}

	public void setAttribute28End(java.util.Date attribute28End) {
		this.attribute28End = attribute28End;
	}

	public java.util.Date getAttribute29() {
		return attribute29;
	}

	public void setAttribute29(java.util.Date attribute29) {
		this.attribute29 = attribute29;
	}

	public java.util.Date getAttribute29Begin() {
		return attribute29Begin;
	}

	public void setAttribute29Begin(java.util.Date attribute29Begin) {
		this.attribute29Begin = attribute29Begin;
	}

	public java.util.Date getAttribute29End() {
		return attribute29End;
	}

	public void setAttribute29End(java.util.Date attribute29End) {
		this.attribute29End = attribute29End;
	}

	public java.util.Date getAttribute30() {
		return attribute30;
	}

	public void setAttribute30(java.util.Date attribute30) {
		this.attribute30 = attribute30;
	}

	public java.util.Date getAttribute30Begin() {
		return attribute30Begin;
	}

	public void setAttribute30Begin(java.util.Date attribute30Begin) {
		this.attribute30Begin = attribute30Begin;
	}

	public java.util.Date getAttribute30End() {
		return attribute30End;
	}

	public void setAttribute30End(java.util.Date attribute30End) {
		this.attribute30End = attribute30End;
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
			return "大修改造验收表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "大修改造验收表";
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