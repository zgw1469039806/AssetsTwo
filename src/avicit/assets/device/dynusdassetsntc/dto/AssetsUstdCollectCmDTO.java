package avicit.assets.device.dynusdassetsntc.dto;

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
 * @创建时间： 2020-09-04 19:12
 * @类说明：非标设备年度征集实际下发表
 * @修改记录：
 */
@PojoRemark(table = "assets_ustd_collect_cm", object = "AssetsUstdCollectCmDTO", name = "非标设备年度征集实际下发表")
public class AssetsUstdCollectCmDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField

    @FieldRemark(column = "id", field = "id", name = "ID")
    /*
     *ID
     */
    private String id;

    @FieldRemark(column = "std_id_cm", field = "stdIdCm", name = "申购单号")
    /*
     *申购单号
     */
    private String stdIdCm;

    @FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
    /*
     *申请人部门
     */
    private String createdByDept;
    /*
     *申请人部门显示
     */
    private String createdByDeptAliasCm;

    @FieldRemark(column = "created_by_tel_cm", field = "createdByTelCm", name = "申请人电话")
    /*
     *申请人电话
     */
    private String createdByTelCm;
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

    @FieldRemark(column = "form_state_cm", field = "formStateCm", name = "单据状态")
    /*
     *单据状态
     */
    private String formStateCm;

    @FieldRemark(column = "device_name_cm", field = "deviceNameCm", name = "设备名称")
    /*
     *设备名称
     */
    private String deviceNameCm;

    @FieldRemark(column = "device_category_cm", field = "deviceCategoryCm", name = "设备类别")
    /*
     *设备类别
     */
    private String deviceCategoryCm;
    /*
     *设备类别显示名称
     */
    private String deviceCategoryCmName;

    @FieldRemark(column = "manufacture_unit_cm", field = "manufactureUnitCm", name = "承制单位")
    /*
     *承制单位
     */
    private String manufactureUnitCm;
    /*
     *承制单位显示字段
     */
    private String manufactureUnitCmAlias;

    @FieldRemark(column = "subject_code_cm", field = "subjectCodeCm", name = "课题代号")
    /*
     *课题代号
     */
    private String subjectCodeCm;

    @FieldRemark(column = "competent_authority_cm", field = "competentAuthorityCm", name = "主管机关")
    /*
     *主管机关
     */
    private String competentAuthorityCm;
    /*
     *主管机关显示字段
     */
    private String competentAuthorityCmAlias;

    @FieldRemark(column = "model_director_cm", field = "modelDirectorCm", name = "型号主管")
    /*
     *型号主管
     */
    private String modelDirectorCm;
    /*
     *型号主管显示字段
     */
    private String modelDirectorCmAlias;

    @FieldRemark(column = "competent_leader_cm", field = "competentLeaderCm", name = "主管所领导")
    /*
     *主管所领导
     */
    private String competentLeaderCm;
    /*
     *主管所领导显示字段
     */
    private String competentLeaderCmAlias;

    @FieldRemark(column = "apply_reason_purpose_cm", field = "applyReasonPurposeCm", name = "申购理由及用途")
    /*
     *申购理由及用途
     */
    private String applyReasonPurposeCm;

    @FieldRemark(column = "orign_equip_situation_cm", field = "orignEquipSituationCm", name = "原有设备的情况")
    /*
     *原有设备的情况
     */
    private String orignEquipSituationCm;

    @FieldRemark(column = "efficiency_situation_cm", field = "efficiencySituationCm", name = "使用效率情况")
    /*
     *使用效率情况
     */
    private String efficiencySituationCm;

    @FieldRemark(column = "development_content_cm", field = "developmentContentCm", name = "研制内容")
    /*
     *研制内容
     */
    private String developmentContentCm;

    @FieldRemark(column = "technical_index_cm", field = "technicalIndexCm", name = "技术指标")
    /*
     *技术指标
     */
    private String technicalIndexCm;

    @FieldRemark(column = "development_cycle_cm", field = "developmentCycleCm", name = "研制周期")
    /*
     *研制周期
     */
    private String developmentCycleCm;

    @FieldRemark(column = "is_need_install_cm", field = "isNeedInstallCm", name = "是否需要安装")
    /*
     *是否需要安装
     */
    private String isNeedInstallCm;
    /*
     *是否需要安装显示名称
     */
    private String isNeedInstallCmName;

    @FieldRemark(column = "position_id_cm", field = "positionIdCm", name = "安装地点ID")
    /*
     *安装地点ID
     */
    private String positionIdCm;

    @FieldRemark(column = "service_voltage_cm", field = "serviceVoltageCm", name = "使用电压")
    /*
     *使用电压
     */
    private String serviceVoltageCm;

    @FieldRemark(column = "is_humidity_need_cm", field = "isHumidityNeedCm", name = "是否对温湿度有要求")
    /*
     *是否对温湿度有要求
     */
    private String isHumidityNeedCm;
    /*
     *是否对温湿度有要求显示名称
     */
    private String isHumidityNeedCmName;

    @FieldRemark(column = "humidity_need_cm", field = "humidityNeedCm", name = "温湿度要求")
    /*
     *温湿度要求
     */
    private String humidityNeedCm;

    @FieldRemark(column = "is_water_need_cm", field = "isWaterNeedCm", name = "是否有用水要求")
    /*
     *是否有用水要求
     */
    private String isWaterNeedCm;
    /*
     *是否有用水要求显示名称
     */
    private String isWaterNeedCmName;

    @FieldRemark(column = "water_need_cm", field = "waterNeedCm", name = "用水要求")
    /*
     *用水要求
     */
    private String waterNeedCm;

    @FieldRemark(column = "is_gas_need_cm", field = "isGasNeedCm", name = "是否有用气要求")
    /*
     *是否有用气要求
     */
    private String isGasNeedCm;
    /*
     *是否有用气要求显示名称
     */
    private String isGasNeedCmName;

    @FieldRemark(column = "gas_need_cm", field = "gasNeedCm", name = "用气要求")
    /*
     *用气要求
     */
    private String gasNeedCm;

    @FieldRemark(column = "is_let_cm", field = "isLetCm", name = "是否有气体排放")
    /*
     *是否有气体排放
     */
    private String isLetCm;
    /*
     *是否有气体排放显示名称
     */
    private String isLetCmName;

    @FieldRemark(column = "let_need_cm", field = "letNeedCm", name = "气体排放要求")
    /*
     *气体排放要求
     */
    private String letNeedCm;

    @FieldRemark(column = "is_other_need_cm", field = "isOtherNeedCm", name = "是否有其他特殊要求")
    /*
     *是否有其他特殊要求
     */
    private String isOtherNeedCm;
    /*
     *是否有其他特殊要求显示名称
     */
    private String isOtherNeedCmName;

    @FieldRemark(column = "other_need_cm", field = "otherNeedCm", name = "其他特殊要求")
    /*
     *其他特殊要求
     */
    private String otherNeedCm;

    @FieldRemark(column = "is_above_conditions_cm", field = "isAboveConditionsCm", name = "以上需求条件在拟安装地点是否都已具备")
    /*
     *以上需求条件在拟安装地点是否都已具备
     */
    private String isAboveConditionsCm;
    /*
     *以上需求条件在拟安装地点是否都已具备显示名称
     */
    private String isAboveConditionsCmName;

    @FieldRemark(column = "is_metering_cm", field = "isMeteringCm", name = "是否计量")
    /*
     *是否计量
     */
    private String isMeteringCm;
    /*
     *是否计量显示名称
     */
    private String isMeteringCmName;

    @FieldRemark(column = "metering_requirement_cm", field = "meteringRequirementCm", name = "计量要求")
    /*
     *计量要求
     */
    private String meteringRequirementCm;

    @FieldRemark(column = "financial_estimate_cm", field = "financialEstimateCm", name = "经费概算")
    /*
     *经费概算
     */
    private java.math.BigDecimal financialEstimateCm;

    @FieldRemark(column = "financial_resources_cm", field = "financialResourcesCm", name = "经费来源")
    /*
     *经费来源
     */
    private String financialResourcesCm;
    /*
     *经费来源显示名称
     */
    private String financialResourcesCmName;

    @FieldRemark(column = "belong_project_cm", field = "belongProjectCm", name = "所属项目")
    /*
     *所属项目
     */
    private String belongProjectCm;

    @FieldRemark(column = "project_no_cm", field = "projectNoCm", name = "项目序号")
    /*
     *项目序号
     */
    private String projectNoCm;

    @FieldRemark(column = "reply_name_cm", field = "replyNameCm", name = "批复名称")
    /*
     *批复名称
     */
    private String replyNameCm;

    @FieldRemark(column = "approval_form_number_cm", field = "approvalFormNumberCm", name = "立项单号")
    /*
     *立项单号
     */
    private String approvalFormNumberCm;

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
    /*申请人名字*/
    private String createdByPersionAliasCm;

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

    @FieldRemark(column = "is_test_device_cm", field = "isTestDeviceCm", name = "是否测试设备")
    /*
     *是否测试设备
     */
    private String isTestDeviceCm;
    /*
     *是否测试设备显示名称
     */
    private String isTestDeviceCmName;

    @FieldRemark(column = "competent_device_leader_cm", field = "competentDeviceLeaderCm", name = "主管设备所领导")
    /*
     *主管设备所领导
     */
    private String competentDeviceLeaderCm;
    /*
     *主管设备所领导显示字段
     */
    private String competentDeviceLeaderCmAlias;

    @FieldRemark(column = "header_id_cm", field = "headerIdCm", name = "主表id")
    /*
     *主表id
     */
    private String headerIdCm;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStdIdCm() {
        return stdIdCm;
    }

    public void setStdIdCm(String stdIdCm) {
        this.stdIdCm = stdIdCm;
    }

    public String getCreatedByDept() {
        return createdByDept;
    }

    public void setCreatedByDept(String createdByDept) {
        this.createdByDept = createdByDept;
    }

    public String getCreatedByTelCm() {
        return createdByTelCm;
    }

    public void setCreatedByTelCm(String createdByTelCm) {
        this.createdByTelCm = createdByTelCm;
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

    public String getFormStateCm() {
        return formStateCm;
    }

    public void setFormStateCm(String formStateCm) {
        this.formStateCm = formStateCm;
    }

    public String getDeviceNameCm() {
        return deviceNameCm;
    }

    public void setDeviceNameCm(String deviceNameCm) {
        this.deviceNameCm = deviceNameCm;
    }

    public String getDeviceCategoryCm() {
        return deviceCategoryCm;
    }

    public void setDeviceCategoryCm(String deviceCategoryCm) {
        this.deviceCategoryCm = deviceCategoryCm;
    }

    public String getDeviceCategoryCmName() {
        return deviceCategoryCmName;
    }

    public void setDeviceCategoryCmName(String deviceCategoryCmName) {
        this.deviceCategoryCmName = deviceCategoryCmName;
    }

    public String getManufactureUnitCm() {
        return manufactureUnitCm;
    }

    public void setManufactureUnitCm(String manufactureUnitCm) {
        this.manufactureUnitCm = manufactureUnitCm;
    }

    public String getManufactureUnitCmAlias() {
        return manufactureUnitCmAlias;
    }

    public void setManufactureUnitCmAlias(String manufactureUnitCmAlias) {
        this.manufactureUnitCmAlias = manufactureUnitCmAlias;
    }

    public String getSubjectCodeCm() {
        return subjectCodeCm;
    }

    public void setSubjectCodeCm(String subjectCodeCm) {
        this.subjectCodeCm = subjectCodeCm;
    }

    public String getCompetentAuthorityCm() {
        return competentAuthorityCm;
    }

    public void setCompetentAuthorityCm(String competentAuthorityCm) {
        this.competentAuthorityCm = competentAuthorityCm;
    }

    public String getCompetentAuthorityCmAlias() {
        return competentAuthorityCmAlias;
    }

    public void setCompetentAuthorityCmAlias(String competentAuthorityCmAlias) {
        this.competentAuthorityCmAlias = competentAuthorityCmAlias;
    }

    public String getModelDirectorCm() {
        return modelDirectorCm;
    }

    public void setModelDirectorCm(String modelDirectorCm) {
        this.modelDirectorCm = modelDirectorCm;
    }

    public String getModelDirectorCmAlias() {
        return modelDirectorCmAlias;
    }

    public void setModelDirectorCmAlias(String modelDirectorCmAlias) {
        this.modelDirectorCmAlias = modelDirectorCmAlias;
    }

    public String getCompetentLeaderCm() {
        return competentLeaderCm;
    }

    public void setCompetentLeaderCm(String competentLeaderCm) {
        this.competentLeaderCm = competentLeaderCm;
    }

    public String getCompetentLeaderCmAlias() {
        return competentLeaderCmAlias;
    }

    public void setCompetentLeaderCmAlias(String competentLeaderCmAlias) {
        this.competentLeaderCmAlias = competentLeaderCmAlias;
    }

    public String getApplyReasonPurposeCm() {
        return applyReasonPurposeCm;
    }

    public void setApplyReasonPurposeCm(String applyReasonPurposeCm) {
        this.applyReasonPurposeCm = applyReasonPurposeCm;
    }

    public String getOrignEquipSituationCm() {
        return orignEquipSituationCm;
    }

    public void setOrignEquipSituationCm(String orignEquipSituationCm) {
        this.orignEquipSituationCm = orignEquipSituationCm;
    }

    public String getEfficiencySituationCm() {
        return efficiencySituationCm;
    }

    public void setEfficiencySituationCm(String efficiencySituationCm) {
        this.efficiencySituationCm = efficiencySituationCm;
    }

    public String getDevelopmentContentCm() {
        return developmentContentCm;
    }

    public void setDevelopmentContentCm(String developmentContentCm) {
        this.developmentContentCm = developmentContentCm;
    }

    public String getTechnicalIndexCm() {
        return technicalIndexCm;
    }

    public void setTechnicalIndexCm(String technicalIndexCm) {
        this.technicalIndexCm = technicalIndexCm;
    }

    public String getDevelopmentCycleCm() {
        return developmentCycleCm;
    }

    public void setDevelopmentCycleCm(String developmentCycleCm) {
        this.developmentCycleCm = developmentCycleCm;
    }

    public String getIsNeedInstallCm() {
        return isNeedInstallCm;
    }

    public void setIsNeedInstallCm(String isNeedInstallCm) {
        this.isNeedInstallCm = isNeedInstallCm;
    }

    public String getIsNeedInstallCmName() {
        return isNeedInstallCmName;
    }

    public void setIsNeedInstallCmName(String isNeedInstallCmName) {
        this.isNeedInstallCmName = isNeedInstallCmName;
    }

    public String getPositionIdCm() {
        return positionIdCm;
    }

    public void setPositionIdCm(String positionIdCm) {
        this.positionIdCm = positionIdCm;
    }

    public String getServiceVoltageCm() {
        return serviceVoltageCm;
    }

    public void setServiceVoltageCm(String serviceVoltageCm) {
        this.serviceVoltageCm = serviceVoltageCm;
    }

    public String getIsHumidityNeedCm() {
        return isHumidityNeedCm;
    }

    public void setIsHumidityNeedCm(String isHumidityNeedCm) {
        this.isHumidityNeedCm = isHumidityNeedCm;
    }

    public String getIsHumidityNeedCmName() {
        return isHumidityNeedCmName;
    }

    public void setIsHumidityNeedCmName(String isHumidityNeedCmName) {
        this.isHumidityNeedCmName = isHumidityNeedCmName;
    }

    public String getHumidityNeedCm() {
        return humidityNeedCm;
    }

    public void setHumidityNeedCm(String humidityNeedCm) {
        this.humidityNeedCm = humidityNeedCm;
    }

    public String getIsWaterNeedCm() {
        return isWaterNeedCm;
    }

    public void setIsWaterNeedCm(String isWaterNeedCm) {
        this.isWaterNeedCm = isWaterNeedCm;
    }

    public String getIsWaterNeedCmName() {
        return isWaterNeedCmName;
    }

    public void setIsWaterNeedCmName(String isWaterNeedCmName) {
        this.isWaterNeedCmName = isWaterNeedCmName;
    }

    public String getWaterNeedCm() {
        return waterNeedCm;
    }

    public void setWaterNeedCm(String waterNeedCm) {
        this.waterNeedCm = waterNeedCm;
    }

    public String getIsGasNeedCm() {
        return isGasNeedCm;
    }

    public void setIsGasNeedCm(String isGasNeedCm) {
        this.isGasNeedCm = isGasNeedCm;
    }

    public String getIsGasNeedCmName() {
        return isGasNeedCmName;
    }

    public void setIsGasNeedCmName(String isGasNeedCmName) {
        this.isGasNeedCmName = isGasNeedCmName;
    }

    public String getGasNeedCm() {
        return gasNeedCm;
    }

    public void setGasNeedCm(String gasNeedCm) {
        this.gasNeedCm = gasNeedCm;
    }

    public String getIsLetCm() {
        return isLetCm;
    }

    public void setIsLetCm(String isLetCm) {
        this.isLetCm = isLetCm;
    }

    public String getIsLetCmName() {
        return isLetCmName;
    }

    public void setIsLetCmName(String isLetCmName) {
        this.isLetCmName = isLetCmName;
    }

    public String getLetNeedCm() {
        return letNeedCm;
    }

    public void setLetNeedCm(String letNeedCm) {
        this.letNeedCm = letNeedCm;
    }

    public String getIsOtherNeedCm() {
        return isOtherNeedCm;
    }

    public void setIsOtherNeedCm(String isOtherNeedCm) {
        this.isOtherNeedCm = isOtherNeedCm;
    }

    public String getIsOtherNeedCmName() {
        return isOtherNeedCmName;
    }

    public void setIsOtherNeedCmName(String isOtherNeedCmName) {
        this.isOtherNeedCmName = isOtherNeedCmName;
    }

    public String getOtherNeedCm() {
        return otherNeedCm;
    }

    public void setOtherNeedCm(String otherNeedCm) {
        this.otherNeedCm = otherNeedCm;
    }

    public String getIsAboveConditionsCm() {
        return isAboveConditionsCm;
    }

    public void setIsAboveConditionsCm(String isAboveConditionsCm) {
        this.isAboveConditionsCm = isAboveConditionsCm;
    }

    public String getIsAboveConditionsCmName() {
        return isAboveConditionsCmName;
    }

    public void setIsAboveConditionsCmName(String isAboveConditionsCmName) {
        this.isAboveConditionsCmName = isAboveConditionsCmName;
    }

    public String getIsMeteringCm() {
        return isMeteringCm;
    }

    public void setIsMeteringCm(String isMeteringCm) {
        this.isMeteringCm = isMeteringCm;
    }

    public String getIsMeteringCmName() {
        return isMeteringCmName;
    }

    public void setIsMeteringCmName(String isMeteringCmName) {
        this.isMeteringCmName = isMeteringCmName;
    }

    public String getMeteringRequirementCm() {
        return meteringRequirementCm;
    }

    public void setMeteringRequirementCm(String meteringRequirementCm) {
        this.meteringRequirementCm = meteringRequirementCm;
    }

    public java.math.BigDecimal getFinancialEstimateCm() {
        return financialEstimateCm;
    }

    public void setFinancialEstimateCm(java.math.BigDecimal financialEstimateCm) {
        this.financialEstimateCm = financialEstimateCm;
    }

    public String getFinancialResourcesCm() {
        return financialResourcesCm;
    }

    public void setFinancialResourcesCm(String financialResourcesCm) {
        this.financialResourcesCm = financialResourcesCm;
    }

    public String getFinancialResourcesCmName() {
        return financialResourcesCmName;
    }

    public void setFinancialResourcesCmName(String financialResourcesCmName) {
        this.financialResourcesCmName = financialResourcesCmName;
    }

    public String getBelongProjectCm() {
        return belongProjectCm;
    }

    public void setBelongProjectCm(String belongProjectCm) {
        this.belongProjectCm = belongProjectCm;
    }

    public String getProjectNoCm() {
        return projectNoCm;
    }

    public void setProjectNoCm(String projectNoCm) {
        this.projectNoCm = projectNoCm;
    }

    public String getReplyNameCm() {
        return replyNameCm;
    }

    public void setReplyNameCm(String replyNameCm) {
        this.replyNameCm = replyNameCm;
    }

    public String getApprovalFormNumberCm() {
        return approvalFormNumberCm;
    }

    public void setApprovalFormNumberCm(String approvalFormNumberCm) {
        this.approvalFormNumberCm = approvalFormNumberCm;
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

    public String getIsTestDeviceCm() {
        return isTestDeviceCm;
    }

    public void setIsTestDeviceCm(String isTestDeviceCm) {
        this.isTestDeviceCm = isTestDeviceCm;
    }

    public String getIsTestDeviceCmName() {
        return isTestDeviceCmName;
    }

    public void setIsTestDeviceCmName(String isTestDeviceCmName) {
        this.isTestDeviceCmName = isTestDeviceCmName;
    }

    public String getCompetentDeviceLeaderCm() {
        return competentDeviceLeaderCm;
    }

    public void setCompetentDeviceLeaderCm(String competentDeviceLeaderCm) {
        this.competentDeviceLeaderCm = competentDeviceLeaderCm;
    }

    public String getCompetentDeviceLeaderCmAlias() {
        return competentDeviceLeaderCmAlias;
    }

    public void setCompetentDeviceLeaderCmAlias(String competentDeviceLeaderCmAlias) {
        this.competentDeviceLeaderCmAlias = competentDeviceLeaderCmAlias;
    }

    public String getHeaderIdCm() {
        return headerIdCm;
    }

    public void setHeaderIdCm(String headerIdCm) {
        this.headerIdCm = headerIdCm;
    }


    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "非标设备年度征集实际下发表";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "非标设备年度征集实际下发表";
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

    public String getCreatedByPersionAliasCm() {
        return createdByPersionAliasCm;
    }

    public void setCreatedByPersionAliasCm(String createdByPersionAliasCm) {
        this.createdByPersionAliasCm = createdByPersionAliasCm;
    }

    public String getCreatedByDeptAliasCm() {
        return createdByDeptAliasCm;
    }

    public void setCreatedByDeptAliasCm(String createdByDeptAliasCm) {
        this.createdByDeptAliasCm = createdByDeptAliasCm;
    }
}