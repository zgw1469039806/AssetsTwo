package avicit.assets.device.assetsustdregisterproc.dto;

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
 * @创建时间： 2020-07-11 12:56
 * @类说明：ASSETS_USTDREGISTER_PROC
 * @修改记录：
 */
@PojoRemark(table = "assets_ustdregister_proc", object = "AssetsUstdregisterProcDTO", name = "ASSETS_USTDREGISTER_PROC")
public class AssetsUstdregisterProcDTO extends BeanDTO {
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

    @LogField
    @FieldRemark(column = "register_no", field = "registerNo", name = "非标立项编号")
    /*
     *非标立项编号
     */
    private java.lang.String registerNo;

    /*
     *申请人显示字段
     */
    private java.lang.String createdByAlias;

    @FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
    /*
     *申请人部门
     */
    private java.lang.String createdByDept;
    /*
     *申请人部门显示字段
     */
    private java.lang.String createdByDeptAlias;

    @FieldRemark(column = "created_by_tel", field = "createdByTel", name = "申请人电话")
    /*
     *申请人电话
     */
    private java.lang.String createdByTel;
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
    private java.lang.String formState;

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

    @FieldRemark(column = "tech_incharge", field = "techIncharge", name = "技术负责人")
    /*
     *技术负责人
     */
    private java.lang.String techIncharge;
    /*
     *技术负责人显示字段
     */
    private java.lang.String techInchargeAlias;

    @FieldRemark(column = "project_director", field = "projectDirector", name = "项目主管")
    /*
     *项目主管
     */
    private java.lang.String projectDirector;
    /*
     *项目主管显示字段
     */
    private java.lang.String projectDirectorAlias;

    @FieldRemark(column = "single_or_set", field = "singleOrSet", name = "台/套")
    /*
     *台/套
     */
    private java.lang.String singleOrSet;

    @FieldRemark(column = "set_count", field = "setCount", name = "台(套)数")
    /*
     *台(套)数
     */
    private Long setCount;

    @FieldRemark(column = "budget_price", field = "budgetPrice", name = "预算单价")
    /*
     *预算单价
     */
    private java.math.BigDecimal budgetPrice;

    @FieldRemark(column = "financial_estimate", field = "financialEstimate", name = "经费概算")
    /*
     *经费概算
     */
    private java.math.BigDecimal financialEstimate;

    @FieldRemark(column = "financial_resources", field = "financialResources", name = "经费来源")
    /*
     *经费来源
     */
    private java.lang.String financialResources;

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

    @FieldRemark(column = "simple_or_large", field = "simpleOrLarge", name = "简易/大型设备")
    /*
     *简易/大型设备
     */
    private java.lang.String simpleOrLarge;

    @FieldRemark(column = "install_position", field = "installPosition", name = "安装地点")
    /*
     *安装地点
     */
    private java.lang.String installPosition;

    @FieldRemark(column = "is_satisfy_bearing", field = "isSatisfyBearing", name = "安装设备楼层承重能否满足")
    /*
     *安装设备楼层承重能否满足
     */
    private java.lang.String isSatisfyBearing;

    @FieldRemark(column = "has_outdoor_unit", field = "hasOutdoorUnit", name = "设备是否有室外机")
    /*
     *设备是否有室外机
     */
    private java.lang.String hasOutdoorUnit;

    @FieldRemark(column = "is_allow_outdoorunit", field = "isAllowOutdoorunit", name = "所安装位置是否允许安装室外机")
    /*
     *所安装位置是否允许安装室外机
     */
    private java.lang.String isAllowOutdoorunit;

    @FieldRemark(column = "has_foundation", field = "hasFoundation", name = "所安装位置是否具备设置地基条件")
    /*
     *所安装位置是否具备设置地基条件
     */
    private java.lang.String hasFoundation;

    @FieldRemark(column = "use_voltage", field = "useVoltage", name = "使用电压")
    /*
     *使用电压
     */
    private java.lang.String useVoltage;

    @FieldRemark(column = "has_voltage_condition", field = "hasVoltageCondition", name = "安装位置是否具备电压条件")
    /*
     *安装位置是否具备电压条件
     */
    private java.lang.String hasVoltageCondition;

    @FieldRemark(column = "has_humidity_need", field = "hasHumidityNeed", name = "是否有温湿度要求")
    /*
     *是否有温湿度要求
     */
    private java.lang.String hasHumidityNeed;

    @FieldRemark(column = "humidity_need", field = "humidityNeed", name = "温湿度要求")
    /*
     *温湿度要求
     */
    private java.lang.String humidityNeed;

    @FieldRemark(column = "has_cleanliness_need", field = "hasCleanlinessNeed", name = "是否有洁净度要求")
    /*
     *是否有洁净度要求
     */
    private java.lang.String hasCleanlinessNeed;

    @FieldRemark(column = "cleanliness_need", field = "cleanlinessNeed", name = "净度要求")
    /*
     *净度要求
     */
    private java.lang.String cleanlinessNeed;

    @FieldRemark(column = "has_water_need", field = "hasWaterNeed", name = "是否有用水要求")
    /*
     *是否有用水要求
     */
    private java.lang.String hasWaterNeed;

    @FieldRemark(column = "water_need", field = "waterNeed", name = "用水要求")
    /*
     *用水要求
     */
    private java.lang.String waterNeed;

    @FieldRemark(column = "has_gas_need", field = "hasGasNeed", name = "是否有用气要求")
    /*
     *是否有用气要求
     */
    private java.lang.String hasGasNeed;

    @FieldRemark(column = "gas_need", field = "gasNeed", name = "用气要求")
    /*
     *用气要求
     */
    private java.lang.String gasNeed;

    @FieldRemark(column = "has_let_need", field = "hasLetNeed", name = "是否有气体排放要求")
    /*
     *是否有气体排放要求
     */
    private java.lang.String hasLetNeed;

    @FieldRemark(column = "let_need", field = "letNeed", name = "气体排放要求")
    /*
     *气体排放要求
     */
    private java.lang.String letNeed;

    @FieldRemark(column = "has_other_need", field = "hasOtherNeed", name = "是否有其他特殊要求")
    /*
     *是否有其他特殊要求
     */
    private java.lang.String hasOtherNeed;

    @FieldRemark(column = "other_need", field = "otherNeed", name = "其他特殊要求")
    /*
     *其他特殊要求
     */
    private java.lang.String otherNeed;

    @FieldRemark(column = "has_above_conditions", field = "hasAboveConditions", name = "以上需求条件在拟安装地点是否都已具备")
    /*
     *以上需求条件在拟安装地点是否都已具备
     */
    private java.lang.String hasAboveConditions;

    @FieldRemark(column = "supplementary_notes", field = "supplementaryNotes", name = "条件不具备补充说明")
    /*
     *条件不具备补充说明
     */
    private java.lang.String supplementaryNotes;

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

    public java.lang.String getRegisterNo() {
        return registerNo;
    }

    public void setRegisterNo(java.lang.String registerNo) {
        this.registerNo = registerNo;
    }

    public java.lang.String getCreatedByAlias() {
        return createdByAlias;
    }

    public void setCreatedByAlias(java.lang.String createdByAlias) {
        this.createdByAlias = createdByAlias;
    }

    public java.lang.String getCreatedByDept() {
        return createdByDept;
    }

    public void setCreatedByDept(java.lang.String createdByDept) {
        this.createdByDept = createdByDept;
    }

    public java.lang.String getCreatedByDeptAlias() {
        return createdByDeptAlias;
    }

    public void setCreatedByDeptAlias(java.lang.String createdByDeptAlias) {
        this.createdByDeptAlias = createdByDeptAlias;
    }

    public java.lang.String getCreatedByTel() {
        return createdByTel;
    }

    public void setCreatedByTel(java.lang.String createdByTel) {
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

    public java.lang.String getFormState() {
        return formState;
    }

    public void setFormState(java.lang.String formState) {
        this.formState = formState;
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

    public java.lang.String getTechIncharge() {
        return techIncharge;
    }

    public void setTechIncharge(java.lang.String techIncharge) {
        this.techIncharge = techIncharge;
    }

    public java.lang.String getTechInchargeAlias() {
        return techInchargeAlias;
    }

    public void setTechInchargeAlias(java.lang.String techInchargeAlias) {
        this.techInchargeAlias = techInchargeAlias;
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

    public java.lang.String getSingleOrSet() {
        return singleOrSet;
    }

    public void setSingleOrSet(java.lang.String singleOrSet) {
        this.singleOrSet = singleOrSet;
    }

    public Long getSetCount() {
        return setCount;
    }

    public void setSetCount(Long setCount) {
        this.setCount = setCount;
    }

    public java.math.BigDecimal getBudgetPrice() {
        return budgetPrice;
    }

    public void setBudgetPrice(java.math.BigDecimal budgetPrice) {
        this.budgetPrice = budgetPrice;
    }

    public java.math.BigDecimal getFinancialEstimate() {
        return financialEstimate;
    }

    public void setFinancialEstimate(java.math.BigDecimal financialEstimate) {
        this.financialEstimate = financialEstimate;
    }

    public java.lang.String getFinancialResources() {
        return financialResources;
    }

    public void setFinancialResources(java.lang.String financialResources) {
        this.financialResources = financialResources;
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

    public java.lang.String getSimpleOrLarge() {
        return simpleOrLarge;
    }

    public void setSimpleOrLarge(java.lang.String simpleOrLarge) {
        this.simpleOrLarge = simpleOrLarge;
    }

    public java.lang.String getInstallPosition() {
        return installPosition;
    }

    public void setInstallPosition(java.lang.String installPosition) {
        this.installPosition = installPosition;
    }

    public java.lang.String getIsSatisfyBearing() {
        return isSatisfyBearing;
    }

    public void setIsSatisfyBearing(java.lang.String isSatisfyBearing) {
        this.isSatisfyBearing = isSatisfyBearing;
    }

    public java.lang.String getHasOutdoorUnit() {
        return hasOutdoorUnit;
    }

    public void setHasOutdoorUnit(java.lang.String hasOutdoorUnit) {
        this.hasOutdoorUnit = hasOutdoorUnit;
    }

    public java.lang.String getIsAllowOutdoorunit() {
        return isAllowOutdoorunit;
    }

    public void setIsAllowOutdoorunit(java.lang.String isAllowOutdoorunit) {
        this.isAllowOutdoorunit = isAllowOutdoorunit;
    }

    public java.lang.String getHasFoundation() {
        return hasFoundation;
    }

    public void setHasFoundation(java.lang.String hasFoundation) {
        this.hasFoundation = hasFoundation;
    }

    public java.lang.String getUseVoltage() {
        return useVoltage;
    }

    public void setUseVoltage(java.lang.String useVoltage) {
        this.useVoltage = useVoltage;
    }

    public java.lang.String getHasVoltageCondition() {
        return hasVoltageCondition;
    }

    public void setHasVoltageCondition(java.lang.String hasVoltageCondition) {
        this.hasVoltageCondition = hasVoltageCondition;
    }

    public java.lang.String getHasHumidityNeed() {
        return hasHumidityNeed;
    }

    public void setHasHumidityNeed(java.lang.String hasHumidityNeed) {
        this.hasHumidityNeed = hasHumidityNeed;
    }

    public java.lang.String getHumidityNeed() {
        return humidityNeed;
    }

    public void setHumidityNeed(java.lang.String humidityNeed) {
        this.humidityNeed = humidityNeed;
    }

    public java.lang.String getHasCleanlinessNeed() {
        return hasCleanlinessNeed;
    }

    public void setHasCleanlinessNeed(java.lang.String hasCleanlinessNeed) {
        this.hasCleanlinessNeed = hasCleanlinessNeed;
    }

    public java.lang.String getCleanlinessNeed() {
        return cleanlinessNeed;
    }

    public void setCleanlinessNeed(java.lang.String cleanlinessNeed) {
        this.cleanlinessNeed = cleanlinessNeed;
    }

    public java.lang.String getHasWaterNeed() {
        return hasWaterNeed;
    }

    public void setHasWaterNeed(java.lang.String hasWaterNeed) {
        this.hasWaterNeed = hasWaterNeed;
    }

    public java.lang.String getWaterNeed() {
        return waterNeed;
    }

    public void setWaterNeed(java.lang.String waterNeed) {
        this.waterNeed = waterNeed;
    }

    public java.lang.String getHasGasNeed() {
        return hasGasNeed;
    }

    public void setHasGasNeed(java.lang.String hasGasNeed) {
        this.hasGasNeed = hasGasNeed;
    }

    public java.lang.String getGasNeed() {
        return gasNeed;
    }

    public void setGasNeed(java.lang.String gasNeed) {
        this.gasNeed = gasNeed;
    }

    public java.lang.String getHasLetNeed() {
        return hasLetNeed;
    }

    public void setHasLetNeed(java.lang.String hasLetNeed) {
        this.hasLetNeed = hasLetNeed;
    }

    public java.lang.String getLetNeed() {
        return letNeed;
    }

    public void setLetNeed(java.lang.String letNeed) {
        this.letNeed = letNeed;
    }

    public java.lang.String getHasOtherNeed() {
        return hasOtherNeed;
    }

    public void setHasOtherNeed(java.lang.String hasOtherNeed) {
        this.hasOtherNeed = hasOtherNeed;
    }

    public java.lang.String getOtherNeed() {
        return otherNeed;
    }

    public void setOtherNeed(java.lang.String otherNeed) {
        this.otherNeed = otherNeed;
    }

    public java.lang.String getHasAboveConditions() {
        return hasAboveConditions;
    }

    public void setHasAboveConditions(java.lang.String hasAboveConditions) {
        this.hasAboveConditions = hasAboveConditions;
    }

    public java.lang.String getSupplementaryNotes() {
        return supplementaryNotes;
    }

    public void setSupplementaryNotes(java.lang.String supplementaryNotes) {
        this.supplementaryNotes = supplementaryNotes;
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

    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "ASSETS_USTDREGISTER_PROC";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_USTDREGISTER_PROC";
        } else {
            return super.logTitle;
        }
    }

    public java.lang.String getCurrUserId() {
        return currUserId;
    }

    public void setCurrUserId(java.lang.String currUserId) {
        this.currUserId = currUserId;
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

    public LogType getLogType() {
        if (super.logType == null || super.logType.equals("")) {
            return LogType.module_operate;
        } else {
            return super.logType;
        }
    }

    //编码管理：加入编码值属性
    private java.lang.String autoCodeValue;

    public java.lang.String getAutoCodeValue(){
        return autoCodeValue;
    }
    public void setAutoCodeValue(java.lang.String autoCodeValue){
        this.autoCodeValue = autoCodeValue;
    }
}

