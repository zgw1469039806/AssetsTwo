package avicit.assets.device.assetsustdtempacceptance.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-09-08 11:13
 * @类说明：ASSETS_USTDTEMP_ACCEPTANCE
 * @修改记录：
 */
@PojoRemark(table = "assets_ustdtemp_acceptance", object = "AssetsUstdtempAcceptanceDTO", name = "ASSETS_USTDTEMP_ACCEPTANCE")
public class AssetsUstdtempAcceptanceDTO extends BeanDTO {
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

	@FieldRemark(column = "acceptance_no", field = "acceptanceNo", name = "验收单号")
	/*
	 *验收单号
	 */
	private java.lang.String acceptanceNo;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private java.lang.String createdByDept;

	/*
	 *创建时间开始时间
	 */
	private java.util.Date creationDateBegin;
	/*
	 *创建时间截止时间
	 */
	private java.util.Date creationDateEnd;
	/*
	 *更新人显示字段
	 */
	private java.lang.String lastUpdatedByAlias;
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
	private java.lang.String formState;

	@FieldRemark(column = "subscribe_no", field = "subscribeNo", name = "申购单号")
	/*
	 *申购单号
	 */
	private java.lang.String subscribeNo;

	@FieldRemark(column = "apply_by", field = "applyBy", name = "申请人")
	/*
	 *申请人
	 */
	private java.lang.String applyBy;
	/*
	 *申请人显示字段
	 */
	private java.lang.String applyByAlias;

	@FieldRemark(column = "apply_by_dept", field = "applyByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private java.lang.String applyByDept;
	/*
	 *申请人部门显示字段
	 */
	private java.lang.String applyByDeptAlias;

	@FieldRemark(column = "contract_num", field = "contractNum", name = "合同编号")
	/*
	 *合同编号
	 */
	private java.lang.String contractNum;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private java.lang.String deviceName;

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private java.lang.String unifiedId;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private java.lang.String secretLevel;
	/*
	 *密级显示名称
	 */
	private java.lang.String secretLevelName;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private java.lang.String manufacturerId;

	@FieldRemark(column = "competent_chief_engineer", field = "competentChiefEngineer", name = "主管总师")
	/*
	 *主管总师
	 */
	private java.lang.String competentChiefEngineer;
	/*
	 *主管总师显示字段
	 */
	private java.lang.String competentChiefEngineerAlias;

	@FieldRemark(column = "owner_dept", field = "ownerDept", name = "责任人部门")
	/*
	 *责任人部门
	 */
	private java.lang.String ownerDept;
	/*
	 *责任人部门显示字段
	 */
	private java.lang.String ownerDeptAlias;

	@FieldRemark(column = "owner_id", field = "ownerId", name = "责任人")
	/*
	 *责任人
	 */
	private java.lang.String ownerId;
	/*
	 *责任人显示字段
	 */
	private java.lang.String ownerIdAlias;

	@FieldRemark(column = "owner_tel", field = "ownerTel", name = "责任人联系方式")
	/*
	 *责任人联系方式
	 */
	private java.lang.String ownerTel;

	@FieldRemark(column = "sets_count", field = "setsCount", name = "台(套)数")
	/*
	 *台(套)数
	 */
	private Long setsCount;

	@FieldRemark(column = "unit_price", field = "unitPrice", name = "单价(元)")
	/*
	 *单价(元)
	 */
	private java.math.BigDecimal unitPrice;

	@FieldRemark(column = "project_director", field = "projectDirector", name = "项目主管")
	/*
	 *项目主管
	 */
	private java.lang.String projectDirector;
	/*
	 *项目主管显示字段
	 */
	private java.lang.String projectDirectorAlias;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private java.lang.String deviceCategory;
	/*
	 *设备类别显示名称
	 */
	private java.lang.String deviceCategoryName;

	@FieldRemark(column = "if_regular_check", field = "ifRegularCheck", name = "是否定检")
	/*
	 *是否定检
	 */
	private java.lang.String ifRegularCheck;
	/*
	 *是否定检显示名称
	 */
	private java.lang.String ifRegularCheckName;

	@FieldRemark(column = "if_spot_check", field = "ifSpotCheck", name = "是否点检")
	/*
	 *是否点检
	 */
	private java.lang.String ifSpotCheck;
	/*
	 *是否点检显示名称
	 */
	private java.lang.String ifSpotCheckName;

	@FieldRemark(column = "if_precision_inspection", field = "ifPrecisionInspection", name = "是否精度检查")
	/*
	 *是否精度检查
	 */
	private java.lang.String ifPrecisionInspection;
	/*
	 *是否精度检查显示名称
	 */
	private java.lang.String ifPrecisionInspectionName;

	@FieldRemark(column = "if_upkeep", field = "ifUpkeep", name = "是否保养")
	/*
	 *是否保养
	 */
	private java.lang.String ifUpkeep;
	/*
	 *是否保养显示名称
	 */
	private java.lang.String ifUpkeepName;

	@FieldRemark(column = "upkeep_cycle", field = "upkeepCycle", name = "保养周期(天)")
	/*
	 *保养周期(天)
	 */
	private Long upkeepCycle;

	@FieldRemark(column = "upkeep_requirements", field = "upkeepRequirements", name = "保养要求")
	/*
	 *保养要求
	 */
	private java.lang.String upkeepRequirements;

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
	private java.lang.String ifMeasure;
	/*
	 *是否计量显示名称
	 */
	private java.lang.String ifMeasureName;

	@FieldRemark(column = "if_install", field = "ifInstall", name = "是否需要安装")
	/*
	 *是否需要安装
	 */
	private java.lang.String ifInstall;
	/*
	 *是否需要安装显示名称
	 */
	private java.lang.String ifInstallName;

	@FieldRemark(column = "if_measure_onsite", field = "ifMeasureOnsite", name = "是否现场计量")
	/*
	 *是否现场计量
	 */
	private java.lang.String ifMeasureOnsite;
	/*
	 *是否现场计量显示名称
	 */
	private java.lang.String ifMeasureOnsiteName;

	@FieldRemark(column = "measure_identify", field = "measureIdentify", name = "计量标识")
	/*
	 *计量标识
	 */
	private java.lang.String measureIdentify;

	@FieldRemark(column = "measure_by", field = "measureBy", name = "计量人员")
	/*
	 *计量人员
	 */
	private java.lang.String measureBy;
	/*
	 *计量人员显示字段
	 */
	private java.lang.String measureByAlias;

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
	private java.lang.String positionId;

	@FieldRemark(column = "if_has_computer", field = "ifHasComputer", name = "是否含计算机/无线模板")
	/*
	 *是否含计算机/无线模板
	 */
	private java.lang.String ifHasComputer;
	/*
	 *是否含计算机/无线模板显示名称
	 */
	private java.lang.String ifHasComputerName;

	@FieldRemark(column = "is_safety_production", field = "isSafetyProduction", name = "是否涉及安全生产")
	/*
	 *是否涉及安全生产
	 */
	private java.lang.String isSafetyProduction;
	/*
	 *是否涉及安全生产显示名称
	 */
	private java.lang.String isSafetyProductionName;

	@FieldRemark(column = "financial_resources", field = "financialResources", name = "经费来源")
	/*
	 *经费来源
	 */
	private java.lang.String financialResources;
	/*
	 *经费来源显示名称
	 */
	private java.lang.String financialResourcesName;

	@FieldRemark(column = "belong_project", field = "belongProject", name = "所属项目")
	/*
	 *所属项目
	 */
	private java.lang.String belongProject;

	@FieldRemark(column = "project_no", field = "projectNo", name = "项目序号")
	/*
	 *项目序号
	 */
	private java.lang.String projectNo;

	@FieldRemark(column = "reply_name", field = "replyName", name = "批复名称")
	/*
	 *批复名称
	 */
	private java.lang.String replyName;

	@FieldRemark(column = "project_approval_no", field = "projectApprovalNo", name = "立项单号")
	/*
	 *立项单号
	 */
	private java.lang.String projectApprovalNo;

	@FieldRemark(column = "abc_category", field = "abcCategory", name = "ABC分类")
	/*
	 *ABC分类
	 */
	private java.lang.String abcCategory;
	/*
	 *ABC分类显示名称
	 */
	private java.lang.String abcCategoryName;

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
	private java.lang.String attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
	/*
	 *扩展字段12
	 */
	private java.lang.String attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
	/*
	 *扩展字段13
	 */
	private java.lang.String attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
	/*
	 *扩展字段14
	 */
	private java.lang.String attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
	/*
	 *扩展字段15
	 */
	private java.lang.String attribute15;

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

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getAcceptanceNo() {
		return acceptanceNo;
	}

	public void setAcceptanceNo(java.lang.String acceptanceNo) {
		this.acceptanceNo = acceptanceNo;
	}

	public java.lang.String getCreatedByDept() {
		return createdByDept;
	}

	public void setCreatedByDept(java.lang.String createdByDept) {
		this.createdByDept = createdByDept;
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

	public java.lang.String getLastUpdatedByAlias() {
		return lastUpdatedByAlias;
	}

	public void setLastUpdatedByAlias(java.lang.String lastUpdatedByAlias) {
		this.lastUpdatedByAlias = lastUpdatedByAlias;
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

	public java.lang.String getFormState() {
		return formState;
	}

	public void setFormState(java.lang.String formState) {
		this.formState = formState;
	}

	public java.lang.String getSubscribeNo() {
		return subscribeNo;
	}

	public void setSubscribeNo(java.lang.String subscribeNo) {
		this.subscribeNo = subscribeNo;
	}

	public java.lang.String getApplyBy() {
		return applyBy;
	}

	public void setApplyBy(java.lang.String applyBy) {
		this.applyBy = applyBy;
	}

	public java.lang.String getApplyByAlias() {
		return applyByAlias;
	}

	public void setApplyByAlias(java.lang.String applyByAlias) {
		this.applyByAlias = applyByAlias;
	}

	public java.lang.String getApplyByDept() {
		return applyByDept;
	}

	public void setApplyByDept(java.lang.String applyByDept) {
		this.applyByDept = applyByDept;
	}

	public java.lang.String getApplyByDeptAlias() {
		return applyByDeptAlias;
	}

	public void setApplyByDeptAlias(java.lang.String applyByDeptAlias) {
		this.applyByDeptAlias = applyByDeptAlias;
	}

	public java.lang.String getContractNum() {
		return contractNum;
	}

	public void setContractNum(java.lang.String contractNum) {
		this.contractNum = contractNum;
	}

	public java.lang.String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(java.lang.String deviceName) {
		this.deviceName = deviceName;
	}

	public java.lang.String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(java.lang.String unifiedId) {
		this.unifiedId = unifiedId;
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

	public java.lang.String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(java.lang.String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public java.lang.String getCompetentChiefEngineer() {
		return competentChiefEngineer;
	}

	public void setCompetentChiefEngineer(java.lang.String competentChiefEngineer) {
		this.competentChiefEngineer = competentChiefEngineer;
	}

	public java.lang.String getCompetentChiefEngineerAlias() {
		return competentChiefEngineerAlias;
	}

	public void setCompetentChiefEngineerAlias(java.lang.String competentChiefEngineerAlias) {
		this.competentChiefEngineerAlias = competentChiefEngineerAlias;
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

	public java.lang.String getOwnerTel() {
		return ownerTel;
	}

	public void setOwnerTel(java.lang.String ownerTel) {
		this.ownerTel = ownerTel;
	}

	public Long getSetsCount() {
		return setsCount;
	}

	public void setSetsCount(Long setsCount) {
		this.setsCount = setsCount;
	}

	public java.math.BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(java.math.BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public java.lang.String getProjectDirector() {
		return projectDirector;
	}

	public void setProjectDirector(java.lang.String projectDirector) {
		this.projectDirector = projectDirector;
	}

	public java.lang.String getProjectDirectorAlias() {
		return projectDirectorAlias;
	}

	public void setProjectDirectorAlias(java.lang.String projectDirectorAlias) {
		this.projectDirectorAlias = projectDirectorAlias;
	}

	public java.lang.String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(java.lang.String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public java.lang.String getDeviceCategoryName() {
		return deviceCategoryName;
	}

	public void setDeviceCategoryName(java.lang.String deviceCategoryName) {
		this.deviceCategoryName = deviceCategoryName;
	}

	public java.lang.String getIfRegularCheck() {
		return ifRegularCheck;
	}

	public void setIfRegularCheck(java.lang.String ifRegularCheck) {
		this.ifRegularCheck = ifRegularCheck;
	}

	public java.lang.String getIfRegularCheckName() {
		return ifRegularCheckName;
	}

	public void setIfRegularCheckName(java.lang.String ifRegularCheckName) {
		this.ifRegularCheckName = ifRegularCheckName;
	}

	public java.lang.String getIfSpotCheck() {
		return ifSpotCheck;
	}

	public void setIfSpotCheck(java.lang.String ifSpotCheck) {
		this.ifSpotCheck = ifSpotCheck;
	}

	public java.lang.String getIfSpotCheckName() {
		return ifSpotCheckName;
	}

	public void setIfSpotCheckName(java.lang.String ifSpotCheckName) {
		this.ifSpotCheckName = ifSpotCheckName;
	}

	public java.lang.String getIfPrecisionInspection() {
		return ifPrecisionInspection;
	}

	public void setIfPrecisionInspection(java.lang.String ifPrecisionInspection) {
		this.ifPrecisionInspection = ifPrecisionInspection;
	}

	public java.lang.String getIfPrecisionInspectionName() {
		return ifPrecisionInspectionName;
	}

	public void setIfPrecisionInspectionName(java.lang.String ifPrecisionInspectionName) {
		this.ifPrecisionInspectionName = ifPrecisionInspectionName;
	}

	public java.lang.String getIfUpkeep() {
		return ifUpkeep;
	}

	public void setIfUpkeep(java.lang.String ifUpkeep) {
		this.ifUpkeep = ifUpkeep;
	}

	public java.lang.String getIfUpkeepName() {
		return ifUpkeepName;
	}

	public void setIfUpkeepName(java.lang.String ifUpkeepName) {
		this.ifUpkeepName = ifUpkeepName;
	}

	public Long getUpkeepCycle() {
		return upkeepCycle;
	}

	public void setUpkeepCycle(Long upkeepCycle) {
		this.upkeepCycle = upkeepCycle;
	}

	public java.lang.String getUpkeepRequirements() {
		return upkeepRequirements;
	}

	public void setUpkeepRequirements(java.lang.String upkeepRequirements) {
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

	public java.lang.String getIfMeasure() {
		return ifMeasure;
	}

	public void setIfMeasure(java.lang.String ifMeasure) {
		this.ifMeasure = ifMeasure;
	}

	public java.lang.String getIfMeasureName() {
		return ifMeasureName;
	}

	public void setIfMeasureName(java.lang.String ifMeasureName) {
		this.ifMeasureName = ifMeasureName;
	}

	public java.lang.String getIfInstall() {
		return ifInstall;
	}

	public void setIfInstall(java.lang.String ifInstall) {
		this.ifInstall = ifInstall;
	}

	public java.lang.String getIfInstallName() {
		return ifInstallName;
	}

	public void setIfInstallName(java.lang.String ifInstallName) {
		this.ifInstallName = ifInstallName;
	}

	public java.lang.String getIfMeasureOnsite() {
		return ifMeasureOnsite;
	}

	public void setIfMeasureOnsite(java.lang.String ifMeasureOnsite) {
		this.ifMeasureOnsite = ifMeasureOnsite;
	}

	public java.lang.String getIfMeasureOnsiteName() {
		return ifMeasureOnsiteName;
	}

	public void setIfMeasureOnsiteName(java.lang.String ifMeasureOnsiteName) {
		this.ifMeasureOnsiteName = ifMeasureOnsiteName;
	}

	public java.lang.String getMeasureIdentify() {
		return measureIdentify;
	}

	public void setMeasureIdentify(java.lang.String measureIdentify) {
		this.measureIdentify = measureIdentify;
	}

	public java.lang.String getMeasureBy() {
		return measureBy;
	}

	public void setMeasureBy(java.lang.String measureBy) {
		this.measureBy = measureBy;
	}

	public java.lang.String getMeasureByAlias() {
		return measureByAlias;
	}

	public void setMeasureByAlias(java.lang.String measureByAlias) {
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

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
	}

	public java.lang.String getIfHasComputer() {
		return ifHasComputer;
	}

	public void setIfHasComputer(java.lang.String ifHasComputer) {
		this.ifHasComputer = ifHasComputer;
	}

	public java.lang.String getIfHasComputerName() {
		return ifHasComputerName;
	}

	public void setIfHasComputerName(java.lang.String ifHasComputerName) {
		this.ifHasComputerName = ifHasComputerName;
	}

	public java.lang.String getIsSafetyProduction() {
		return isSafetyProduction;
	}

	public void setIsSafetyProduction(java.lang.String isSafetyProduction) {
		this.isSafetyProduction = isSafetyProduction;
	}

	public java.lang.String getIsSafetyProductionName() {
		return isSafetyProductionName;
	}

	public void setIsSafetyProductionName(java.lang.String isSafetyProductionName) {
		this.isSafetyProductionName = isSafetyProductionName;
	}

	public java.lang.String getFinancialResources() {
		return financialResources;
	}

	public void setFinancialResources(java.lang.String financialResources) {
		this.financialResources = financialResources;
	}

	public java.lang.String getFinancialResourcesName() {
		return financialResourcesName;
	}

	public void setFinancialResourcesName(java.lang.String financialResourcesName) {
		this.financialResourcesName = financialResourcesName;
	}

	public java.lang.String getBelongProject() {
		return belongProject;
	}

	public void setBelongProject(java.lang.String belongProject) {
		this.belongProject = belongProject;
	}

	public java.lang.String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(java.lang.String projectNo) {
		this.projectNo = projectNo;
	}

	public java.lang.String getReplyName() {
		return replyName;
	}

	public void setReplyName(java.lang.String replyName) {
		this.replyName = replyName;
	}

	public java.lang.String getProjectApprovalNo() {
		return projectApprovalNo;
	}

	public void setProjectApprovalNo(java.lang.String projectApprovalNo) {
		this.projectApprovalNo = projectApprovalNo;
	}

	public java.lang.String getAbcCategory() {
		return abcCategory;
	}

	public void setAbcCategory(java.lang.String abcCategory) {
		this.abcCategory = abcCategory;
	}

	public java.lang.String getAbcCategoryName() {
		return abcCategoryName;
	}

	public void setAbcCategoryName(java.lang.String abcCategoryName) {
		this.abcCategoryName = abcCategoryName;
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

	public java.lang.String getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(java.lang.String attribute11) {
		this.attribute11 = attribute11;
	}

	public java.lang.String getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(java.lang.String attribute12) {
		this.attribute12 = attribute12;
	}

	public java.lang.String getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(java.lang.String attribute13) {
		this.attribute13 = attribute13;
	}

	public java.lang.String getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(java.lang.String attribute14) {
		this.attribute14 = attribute14;
	}

	public java.lang.String getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(java.lang.String attribute15) {
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
			return "ASSETS_USTDTEMP_ACCEPTANCE";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_USTDTEMP_ACCEPTANCE";
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

	//编码管理：加入编码值属性
	private java.lang.String autoCodeValue;

	public java.lang.String getAutoCodeValue() {
		return autoCodeValue;
	}

	public void setAutoCodeValue(java.lang.String autoCodeValue) {
		this.autoCodeValue = autoCodeValue;
	}
}