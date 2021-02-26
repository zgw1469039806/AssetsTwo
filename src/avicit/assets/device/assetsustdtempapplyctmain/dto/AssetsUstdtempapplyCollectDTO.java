package avicit.assets.device.assetsustdtempapplyctmain.dto;

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
 * @创建时间： 2020-08-26 16:24
 * @类说明：非标设备年度申购征集上报
 * @修改记录：
 */
@PojoRemark(table = "assets_ustdtempapply_collect", object = "AssetsUstdtempapplyCollectDTO", name = "非标设备年度申购征集上报")
public class AssetsUstdtempapplyCollectDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField

    @FieldRemark(column = "id", field = "id", name = "  ")
    /*
     *
     */
    private String id;
    @LogField

    @FieldRemark(column = "std_id", field = "stdId", name = "申购单号")
    /*
     *申购单号
     */
    private String stdId;

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
    /*
     *设备类别显示名称
     */
    private String deviceCategoryName;

    @FieldRemark(column = "manufacture_unit", field = "manufactureUnit", name = "承制单位")
    /*
     *承制单位
     */
    private String manufactureUnit;

    /*
     *承制单位显示名称
     */
    private String manufactureUnitAlias;

    @FieldRemark(column = "subject_code", field = "subjectCode", name = "课题代号")
    /*
     *课题代号
     */
    private String subjectCode;

    @FieldRemark(column = "competent_authority", field = "competentAuthority", name = "主管机关")
    /*
     *主管机关
     */
    private String competentAuthority;
    /*
     *主管机关显示字段
     */
    private String competentAuthorityAlias;

    @FieldRemark(column = "model_director", field = "modelDirector", name = "型号主管")
    /*
     *型号主管
     */
    private String modelDirector;
    /*
     *型号主管显示字段
     */
    private String modelDirectorAlias;

    @FieldRemark(column = "competent_leader", field = "competentLeader", name = "主管所领导")
    /*
     *主管所领导
     */
    private String competentLeader;
    /*
     *主管所领导显示字段
     */
    private String competentLeaderAlias;

    @FieldRemark(column = "apply_reason_purpose", field = "applyReasonPurpose", name = "申购理由及用途")
    /*
     *申购理由及用途
     */
    private String applyReasonPurpose;

    @FieldRemark(column = "orign_equip_situation", field = "orignEquipSituation", name = "原有设备的情况")
    /*
     *原有设备的情况
     */
    private String orignEquipSituation;

    @FieldRemark(column = "efficiency_situation", field = "efficiencySituation", name = "使用效率情况")
    /*
     *使用效率情况
     */
    private String efficiencySituation;

    @FieldRemark(column = "development_content", field = "developmentContent", name = "研制内容")
    /*
     *研制内容
     */
    private String developmentContent;

    @FieldRemark(column = "technical_index", field = "technicalIndex", name = "技术指标")
    /*
     *技术指标
     */
    private String technicalIndex;

    @FieldRemark(column = "development_cycle", field = "developmentCycle", name = "研制周期")
    /*
     *研制周期
     */
    private String developmentCycle;

    @FieldRemark(column = "is_need_install", field = "isNeedInstall", name = "是否需要安装")
    /*
     *是否需要安装
     */
    private String isNeedInstall;
    /*
     *是否需要安装显示名称
     */
    private String isNeedInstallName;

    @FieldRemark(column = "position_id", field = "positionId", name = "安装地点ID")
    /*
     *安装地点ID
     */
    private String positionId;

    @FieldRemark(column = "service_voltage", field = "serviceVoltage", name = "使用电压")
    /*
     *使用电压
     */
    private String serviceVoltage;

    @FieldRemark(column = "is_humidity_need", field = "isHumidityNeed", name = "是否对温湿度有要求")
    /*
     *是否对温湿度有要求
     */
    private String isHumidityNeed;
    /*
     *是否对温湿度有要求显示名称
     */
    private String isHumidityNeedName;

    @FieldRemark(column = "humidity_need", field = "humidityNeed", name = "温湿度要求")
    /*
     *温湿度要求
     */
    private String humidityNeed;

    @FieldRemark(column = "is_water_need", field = "isWaterNeed", name = "是否有用水要求")
    /*
     *是否有用水要求
     */
    private String isWaterNeed;
    /*
     *是否有用水要求显示名称
     */
    private String isWaterNeedName;

    @FieldRemark(column = "water_need", field = "waterNeed", name = "用水要求")
    /*
     *用水要求
     */
    private String waterNeed;

    @FieldRemark(column = "is_gas_need", field = "isGasNeed", name = "是否有用气要求")
    /*
     *是否有用气要求
     */
    private String isGasNeed;
    /*
     *是否有用气要求显示名称
     */
    private String isGasNeedName;

    @FieldRemark(column = "gas_need", field = "gasNeed", name = "用气要求")
    /*
     *用气要求
     */
    private String gasNeed;

    @FieldRemark(column = "is_let", field = "isLet", name = "是否有气体排放")
    /*
     *是否有气体排放
     */
    private String isLet;
    /*
     *是否有气体排放显示名称
     */
    private String isLetName;

    @FieldRemark(column = "let_need", field = "letNeed", name = "气体排放要求")
    /*
     *气体排放要求
     */
    private String letNeed;

    @FieldRemark(column = "is_other_need", field = "isOtherNeed", name = "是否有其他特殊要求")
    /*
     *是否有其他特殊要求
     */
    private String isOtherNeed;
    /*
     *是否有其他特殊要求显示名称
     */
    private String isOtherNeedName;

    @FieldRemark(column = "other_need", field = "otherNeed", name = "其他特殊要求")
    /*
     *其他特殊要求
     */
    private String otherNeed;

    @FieldRemark(column = "is_above_conditions", field = "isAboveConditions", name = "以上需求条件在拟安装地点是否都已具备")
    /*
     *以上需求条件在拟安装地点是否都已具备
     */
    private String isAboveConditions;
    /*
     *以上需求条件在拟安装地点是否都已具备显示名称
     */
    private String isAboveConditionsName;

    @FieldRemark(column = "is_metering", field = "isMetering", name = "是否计量")
    /*
     *是否计量
     */
    private String isMetering;
    /*
     *是否计量名称
     */
    private String isMeteringName;

    @FieldRemark(column = "metering_requirement", field = "meteringRequirement", name = "计量要求")
    /*
     *计量要求
     */
    private String meteringRequirement;

    @FieldRemark(column = "financial_estimate", field = "financialEstimate", name = "经费概算")
    /*
     *经费概算
     */
    private java.math.BigDecimal financialEstimate;

    @FieldRemark(column = "financial_resources", field = "financialResources", name = "经费来源")
    /*
     *经费来源
     */
    private String financialResources;
    /*
     *经费来源显示名称
     */
    private String financialResourcesName;

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

    @FieldRemark(column = "approval_form_number", field = "approvalFormNumber", name = "立项单号")
    /*
     *立项单号
     */
    private String approvalFormNumber;

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
    @LogField

    @FieldRemark(column = "attribute_05", field = "attribute05", name = "扩展字段05")
    /*
     *申请人
     */
    private String attribute05;
    /*申请人名字*/
    private String createdByPersionAlias;

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
    private java.util.Date attribute15;
    /*
     *扩展字段15开始时间
     */
    private java.util.Date attribute15Begin;
    /*
     *扩展字段15截止时间
     */
    private java.util.Date attribute15End;

    @FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
    /*
     *扩展字段16
     */
    private java.util.Date attribute16;
    /*
     *扩展字段16开始时间
     */
    private java.util.Date attribute16Begin;
    /*
     *扩展字段16截止时间
     */
    private java.util.Date attribute16End;

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

    @FieldRemark(column = "is_test_device", field = "isTestDevice", name = "是否测试设备")
    /*
     *是否测试设备
     */
    private String isTestDevice;
    /*
     *是否测试设备显示名称
     */
    private String isTestDeviceName;

    @FieldRemark(column = "competent_device_leader", field = "competentDeviceLeader", name = "主管设备所领导")
    /*
     *主管设备所领导
     */
    private String competentDeviceLeader;
    /*
     *主管设备所领导显示字段
     */
    private String competentDeviceLeaderAlias;

    @FieldRemark(column = "header_id", field = "headerId", name = "主表id")
    /*
     *主表id
     */
    private String headerId;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStdId() {
        return stdId;
    }

    public void setStdId(String stdId) {
        this.stdId = stdId;
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

    public String getDeviceCategoryName() {
        return deviceCategoryName;
    }

    public void setDeviceCategoryName(String deviceCategoryName) {
        this.deviceCategoryName = deviceCategoryName;
    }

    public String getManufactureUnit() {
        return manufactureUnit;
    }

    public void setManufactureUnit(String manufactureUnit) {
        this.manufactureUnit = manufactureUnit;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getCompetentAuthority() {
        return competentAuthority;
    }

    public void setCompetentAuthority(String competentAuthority) {
        this.competentAuthority = competentAuthority;
    }

    public String getCompetentAuthorityAlias() {
        return competentAuthorityAlias;
    }

    public void setCompetentAuthorityAlias(String competentAuthorityAlias) {
        this.competentAuthorityAlias = competentAuthorityAlias;
    }

    public String getModelDirector() {
        return modelDirector;
    }

    public void setModelDirector(String modelDirector) {
        this.modelDirector = modelDirector;
    }

    public String getModelDirectorAlias() {
        return modelDirectorAlias;
    }

    public void setModelDirectorAlias(String modelDirectorAlias) {
        this.modelDirectorAlias = modelDirectorAlias;
    }

    public String getCompetentLeader() {
        return competentLeader;
    }

    public void setCompetentLeader(String competentLeader) {
        this.competentLeader = competentLeader;
    }

    public String getCompetentLeaderAlias() {
        return competentLeaderAlias;
    }

    public void setCompetentLeaderAlias(String competentLeaderAlias) {
        this.competentLeaderAlias = competentLeaderAlias;
    }

    public String getApplyReasonPurpose() {
        return applyReasonPurpose;
    }

    public void setApplyReasonPurpose(String applyReasonPurpose) {
        this.applyReasonPurpose = applyReasonPurpose;
    }

    public String getOrignEquipSituation() {
        return orignEquipSituation;
    }

    public void setOrignEquipSituation(String orignEquipSituation) {
        this.orignEquipSituation = orignEquipSituation;
    }

    public String getEfficiencySituation() {
        return efficiencySituation;
    }

    public void setEfficiencySituation(String efficiencySituation) {
        this.efficiencySituation = efficiencySituation;
    }

    public String getDevelopmentContent() {
        return developmentContent;
    }

    public void setDevelopmentContent(String developmentContent) {
        this.developmentContent = developmentContent;
    }

    public String getTechnicalIndex() {
        return technicalIndex;
    }

    public void setTechnicalIndex(String technicalIndex) {
        this.technicalIndex = technicalIndex;
    }

    public String getDevelopmentCycle() {
        return developmentCycle;
    }

    public void setDevelopmentCycle(String developmentCycle) {
        this.developmentCycle = developmentCycle;
    }

    public String getIsNeedInstall() {
        return isNeedInstall;
    }

    public void setIsNeedInstall(String isNeedInstall) {
        this.isNeedInstall = isNeedInstall;
    }

    public String getIsNeedInstallName() {
        return isNeedInstallName;
    }

    public void setIsNeedInstallName(String isNeedInstallName) {
        this.isNeedInstallName = isNeedInstallName;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getServiceVoltage() {
        return serviceVoltage;
    }

    public void setServiceVoltage(String serviceVoltage) {
        this.serviceVoltage = serviceVoltage;
    }

    public String getIsHumidityNeed() {
        return isHumidityNeed;
    }

    public void setIsHumidityNeed(String isHumidityNeed) {
        this.isHumidityNeed = isHumidityNeed;
    }

    public String getIsHumidityNeedName() {
        return isHumidityNeedName;
    }

    public void setIsHumidityNeedName(String isHumidityNeedName) {
        this.isHumidityNeedName = isHumidityNeedName;
    }

    public String getHumidityNeed() {
        return humidityNeed;
    }

    public void setHumidityNeed(String humidityNeed) {
        this.humidityNeed = humidityNeed;
    }

    public String getIsWaterNeed() {
        return isWaterNeed;
    }

    public void setIsWaterNeed(String isWaterNeed) {
        this.isWaterNeed = isWaterNeed;
    }

    public String getIsWaterNeedName() {
        return isWaterNeedName;
    }

    public void setIsWaterNeedName(String isWaterNeedName) {
        this.isWaterNeedName = isWaterNeedName;
    }

    public String getWaterNeed() {
        return waterNeed;
    }

    public void setWaterNeed(String waterNeed) {
        this.waterNeed = waterNeed;
    }

    public String getIsGasNeed() {
        return isGasNeed;
    }

    public void setIsGasNeed(String isGasNeed) {
        this.isGasNeed = isGasNeed;
    }

    public String getIsGasNeedName() {
        return isGasNeedName;
    }

    public void setIsGasNeedName(String isGasNeedName) {
        this.isGasNeedName = isGasNeedName;
    }

    public String getGasNeed() {
        return gasNeed;
    }

    public void setGasNeed(String gasNeed) {
        this.gasNeed = gasNeed;
    }

    public String getIsLet() {
        return isLet;
    }

    public void setIsLet(String isLet) {
        this.isLet = isLet;
    }

    public String getIsLetName() {
        return isLetName;
    }

    public void setIsLetName(String isLetName) {
        this.isLetName = isLetName;
    }

    public String getLetNeed() {
        return letNeed;
    }

    public void setLetNeed(String letNeed) {
        this.letNeed = letNeed;
    }

    public String getIsOtherNeed() {
        return isOtherNeed;
    }

    public void setIsOtherNeed(String isOtherNeed) {
        this.isOtherNeed = isOtherNeed;
    }

    public String getIsOtherNeedName() {
        return isOtherNeedName;
    }

    public void setIsOtherNeedName(String isOtherNeedName) {
        this.isOtherNeedName = isOtherNeedName;
    }

    public String getOtherNeed() {
        return otherNeed;
    }

    public void setOtherNeed(String otherNeed) {
        this.otherNeed = otherNeed;
    }

    public String getIsAboveConditions() {
        return isAboveConditions;
    }

    public void setIsAboveConditions(String isAboveConditions) {
        this.isAboveConditions = isAboveConditions;
    }

    public String getIsAboveConditionsName() {
        return isAboveConditionsName;
    }

    public void setIsAboveConditionsName(String isAboveConditionsName) {
        this.isAboveConditionsName = isAboveConditionsName;
    }

    public String getIsMetering() {
        return isMetering;
    }

    public void setIsMetering(String isMetering) {
        this.isMetering = isMetering;
    }

    public String getMeteringRequirement() {
        return meteringRequirement;
    }

    public void setMeteringRequirement(String meteringRequirement) {
        this.meteringRequirement = meteringRequirement;
    }

    public java.math.BigDecimal getFinancialEstimate() {
        return financialEstimate;
    }

    public void setFinancialEstimate(java.math.BigDecimal financialEstimate) {
        this.financialEstimate = financialEstimate;
    }

    public String getFinancialResources() {
        return financialResources;
    }

    public void setFinancialResources(String financialResources) {
        this.financialResources = financialResources;
    }

    public String getFinancialResourcesName() {
        return financialResourcesName;
    }

    public void setFinancialResourcesName(String financialResourcesName) {
        this.financialResourcesName = financialResourcesName;
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

    public String getApprovalFormNumber() {
        return approvalFormNumber;
    }

    public void setApprovalFormNumber(String approvalFormNumber) {
        this.approvalFormNumber = approvalFormNumber;
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

    public String getIsMeteringName() {
        return isMeteringName;
    }

    public void setIsMeteringName(String isMeteringName) {
        this.isMeteringName = isMeteringName;
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

    public java.util.Date getAttribute15() {
        return attribute15;
    }

    public void setAttribute15(java.util.Date attribute15) {
        this.attribute15 = attribute15;
    }

    public java.util.Date getAttribute15Begin() {
        return attribute15Begin;
    }

    public void setAttribute15Begin(java.util.Date attribute15Begin) {
        this.attribute15Begin = attribute15Begin;
    }

    public java.util.Date getAttribute15End() {
        return attribute15End;
    }

    public void setAttribute15End(java.util.Date attribute15End) {
        this.attribute15End = attribute15End;
    }

    public java.util.Date getAttribute16() {
        return attribute16;
    }

    public void setAttribute16(java.util.Date attribute16) {
        this.attribute16 = attribute16;
    }

    public java.util.Date getAttribute16Begin() {
        return attribute16Begin;
    }

    public void setAttribute16Begin(java.util.Date attribute16Begin) {
        this.attribute16Begin = attribute16Begin;
    }

    public java.util.Date getAttribute16End() {
        return attribute16End;
    }

    public void setAttribute16End(java.util.Date attribute16End) {
        this.attribute16End = attribute16End;
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

    public String getIsTestDevice() {
        return isTestDevice;
    }

    public void setIsTestDevice(String isTestDevice) {
        this.isTestDevice = isTestDevice;
    }

    public String getIsTestDeviceName() {
        return isTestDeviceName;
    }

    public void setIsTestDeviceName(String isTestDeviceName) {
        this.isTestDeviceName = isTestDeviceName;
    }

    public String getCompetentDeviceLeader() {
        return competentDeviceLeader;
    }

    public void setCompetentDeviceLeader(String competentDeviceLeader) {
        this.competentDeviceLeader = competentDeviceLeader;
    }

    public String getCompetentDeviceLeaderAlias() {
        return competentDeviceLeaderAlias;
    }

    public void setCompetentDeviceLeaderAlias(String competentDeviceLeaderAlias) {
        this.competentDeviceLeaderAlias = competentDeviceLeaderAlias;
    }

    public String getHeaderId() {
        return headerId;
    }

    public void setHeaderId(String headerId) {
        this.headerId = headerId;
    }


    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "非标设备年度申购征集上报";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "非标设备年度申购征集上报";
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

    public String getCreatedByPersionAlias() {
        return createdByPersionAlias;
    }

    public void setCreatedByPersionAlias(String createdByPersionAlias) {
        this.createdByPersionAlias = createdByPersionAlias;
    }

    public String getManufactureUnitAlias() {
        return manufactureUnitAlias;
    }

    public void setManufactureUnitAlias(String manufactureUnitAlias) {
        this.manufactureUnitAlias = manufactureUnitAlias;
    }
}