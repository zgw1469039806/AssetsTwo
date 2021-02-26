package avicit.assets.device.assetsaccidentproc.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-07-14 20:11
 * @类说明：ASSETS_ACCIDENT_PROC
 * @修改记录：
 */
@PojoRemark(table = "assets_accident_proc", object = "AssetsAccidentProcDTO", name = "ASSETS_ACCIDENT_PROC")
public class AssetsAccidentProcDTO extends BeanDTO {
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

    @FieldRemark(column = "accident_no", field = "accidentNo", name = "事故编号")
    /*
     *事故编号
     */
    private java.lang.String accidentNo;

    @FieldRemark(column = "created_by", field = "createdBy", name = "申请人")
    /*
     *申请人
     */
    private java.lang.String createdBy;
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

    @FieldRemark(column = "assets_operator", field = "assetsOperator", name = "设备操作者")
    /*
     *设备操作者
     */
    private java.lang.String assetsOperator;
    /*
     *设备操作者显示字段
     */
    private java.lang.String assetsOperatorAlias;

    @FieldRemark(column = "operator_dept", field = "operatorDept", name = "操作人单位")
    /*
     *操作人单位
     */
    private java.lang.String operatorDept;
    /*
     *操作人单位显示字段
     */
    private java.lang.String operatorDeptAlias;
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

    @FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
    /*
     *设备型号
     */
    private java.lang.String deviceModel;

    @FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格")
    /*
     *设备规格
     */
    private java.lang.String deviceSpec;

    @FieldRemark(column = "occur_time", field = "occurTime", name = "事故发生时间")
    /*
     *事故发生时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
    private java.util.Date occurTime;
    /*
     *事故发生时间开始时间
     */
    private java.util.Date occurTimeBegin;
    /*
     *事故发生时间截止时间
     */
    private java.util.Date occurTimeEnd;

    @FieldRemark(column = "report_leader_time", field = "reportLeaderTime", name = "报告单位领导时间")
    /*
     *报告单位领导时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
    private java.util.Date reportLeaderTime;
    /*
     *报告单位领导时间开始时间
     */
    private java.util.Date reportLeaderTimeBegin;
    /*
     *报告单位领导时间截止时间
     */
    private java.util.Date reportLeaderTimeEnd;

    @FieldRemark(column = "report_time", field = "reportTime", name = "报告时间")
    /*
     *报告时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
    private java.util.Date reportTime;
    /*
     *报告时间开始时间
     */
    private java.util.Date reportTimeBegin;
    /*
     *报告时间截止时间
     */
    private java.util.Date reportTimeEnd;

    @FieldRemark(column = "accident_process", field = "accidentProcess", name = "事故发生经过")
    /*
     *事故发生经过
     */
    private java.lang.String accidentProcess;

    @FieldRemark(column = "accident_consequence", field = "accidentConsequence", name = "事故后果")
    /*
     *事故后果
     */
    private java.lang.String accidentConsequence;

    @FieldRemark(column = "reason_analysis", field = "reasonAnalysis", name = "事故原因分析")
    /*
     *事故原因分析
     */
    private java.lang.String reasonAnalysis;

    @FieldRemark(column = "prevention_measures", field = "preventionMeasures", name = "防止事故措施")
    /*
     *防止事故措施
     */
    private java.lang.String preventionMeasures;

    @FieldRemark(column = "repair_time", field = "repairTime", name = "修复时间")
    /*
     *修复时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
    private java.util.Date repairTime;
    /*
     *修复时间开始时间
     */
    private java.util.Date repairTimeBegin;
    /*
     *修复时间截止时间
     */
    private java.util.Date repairTimeEnd;

    @FieldRemark(column = "stop_work_days", field = "stopWorkDays", name = "停工天数")
    /*
     *停工天数
     */
    private Long stopWorkDays;

    @FieldRemark(column = "direct_economic_loss", field = "directEconomicLoss", name = "直接经济损失")
    /*
     *直接经济损失
     */
    private java.math.BigDecimal directEconomicLoss;

    @FieldRemark(column = "accident_property", field = "accidentProperty", name = "事故性质")
    /*
     *事故性质
     */
    private java.lang.String accidentProperty;

    @FieldRemark(column = "assets_man", field = "assetsMan", name = "设备员")
    /*
     *设备员
     */
    private java.lang.String assetsMan;
    /*
     *设备员显示字段
     */
    private java.lang.String assetsManAlias;

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

    public java.lang.String getAccidentNo() {
        return accidentNo;
    }

    public void setAccidentNo(java.lang.String accidentNo) {
        this.accidentNo = accidentNo;
    }

    public java.lang.String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(java.lang.String createdBy) {
        this.createdBy = createdBy;
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

    public java.lang.String getAssetsOperator() {
        return assetsOperator;
    }

    public void setAssetsOperator(java.lang.String assetsOperator) {
        this.assetsOperator = assetsOperator;
    }

    public java.lang.String getAssetsOperatorAlias() {
        return assetsOperatorAlias;
    }

    public void setAssetsOperatorAlias(java.lang.String assetsOperatorAlias) {
        this.assetsOperatorAlias = assetsOperatorAlias;
    }

    public java.lang.String getOperatorDept() {
        return operatorDept;
    }

    public void setOperatorDept(java.lang.String operatorDept) {
        this.operatorDept = operatorDept;
    }

    public java.lang.String getOperatorDeptAlias() {
        return operatorDeptAlias;
    }

    public void setOperatorDeptAlias(java.lang.String operatorDeptAlias) {
        this.operatorDeptAlias = operatorDeptAlias;
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

    public java.lang.String getDeviceModel() {
        return deviceModel;
    }

    public void setDeviceModel(java.lang.String deviceModel) {
        this.deviceModel = deviceModel;
    }

    public java.lang.String getDeviceSpec() {
        return deviceSpec;
    }

    public void setDeviceSpec(java.lang.String deviceSpec) {
        this.deviceSpec = deviceSpec;
    }

    public java.util.Date getOccurTime() {
        return occurTime;
    }

    public void setOccurTime(java.util.Date occurTime) {
        this.occurTime = occurTime;
    }

    public java.util.Date getOccurTimeBegin() {
        return occurTimeBegin;
    }

    public void setOccurTimeBegin(java.util.Date occurTimeBegin) {
        this.occurTimeBegin = occurTimeBegin;
    }

    public java.util.Date getOccurTimeEnd() {
        return occurTimeEnd;
    }

    public void setOccurTimeEnd(java.util.Date occurTimeEnd) {
        this.occurTimeEnd = occurTimeEnd;
    }

    public java.util.Date getReportLeaderTime() {
        return reportLeaderTime;
    }

    public void setReportLeaderTime(java.util.Date reportLeaderTime) {
        this.reportLeaderTime = reportLeaderTime;
    }

    public java.util.Date getReportLeaderTimeBegin() {
        return reportLeaderTimeBegin;
    }

    public void setReportLeaderTimeBegin(java.util.Date reportLeaderTimeBegin) {
        this.reportLeaderTimeBegin = reportLeaderTimeBegin;
    }

    public java.util.Date getReportLeaderTimeEnd() {
        return reportLeaderTimeEnd;
    }

    public void setReportLeaderTimeEnd(java.util.Date reportLeaderTimeEnd) {
        this.reportLeaderTimeEnd = reportLeaderTimeEnd;
    }

    public java.util.Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(java.util.Date reportTime) {
        this.reportTime = reportTime;
    }

    public java.util.Date getReportTimeBegin() {
        return reportTimeBegin;
    }

    public void setReportTimeBegin(java.util.Date reportTimeBegin) {
        this.reportTimeBegin = reportTimeBegin;
    }

    public java.util.Date getReportTimeEnd() {
        return reportTimeEnd;
    }

    public void setReportTimeEnd(java.util.Date reportTimeEnd) {
        this.reportTimeEnd = reportTimeEnd;
    }

    public java.lang.String getAccidentProcess() {
        return accidentProcess;
    }

    public void setAccidentProcess(java.lang.String accidentProcess) {
        this.accidentProcess = accidentProcess;
    }

    public java.lang.String getAccidentConsequence() {
        return accidentConsequence;
    }

    public void setAccidentConsequence(java.lang.String accidentConsequence) {
        this.accidentConsequence = accidentConsequence;
    }

    public java.lang.String getReasonAnalysis() {
        return reasonAnalysis;
    }

    public void setReasonAnalysis(java.lang.String reasonAnalysis) {
        this.reasonAnalysis = reasonAnalysis;
    }

    public java.lang.String getPreventionMeasures() {
        return preventionMeasures;
    }

    public void setPreventionMeasures(java.lang.String preventionMeasures) {
        this.preventionMeasures = preventionMeasures;
    }

    public java.util.Date getRepairTime() {
        return repairTime;
    }

    public void setRepairTime(java.util.Date repairTime) {
        this.repairTime = repairTime;
    }

    public java.util.Date getRepairTimeBegin() {
        return repairTimeBegin;
    }

    public void setRepairTimeBegin(java.util.Date repairTimeBegin) {
        this.repairTimeBegin = repairTimeBegin;
    }

    public java.util.Date getRepairTimeEnd() {
        return repairTimeEnd;
    }

    public void setRepairTimeEnd(java.util.Date repairTimeEnd) {
        this.repairTimeEnd = repairTimeEnd;
    }

    public Long getStopWorkDays() {
        return stopWorkDays;
    }

    public void setStopWorkDays(Long stopWorkDays) {
        this.stopWorkDays = stopWorkDays;
    }

    public java.math.BigDecimal getDirectEconomicLoss() {
        return directEconomicLoss;
    }

    public void setDirectEconomicLoss(java.math.BigDecimal directEconomicLoss) {
        this.directEconomicLoss = directEconomicLoss;
    }

    public java.lang.String getAccidentProperty() {
        return accidentProperty;
    }

    public void setAccidentProperty(java.lang.String accidentProperty) {
        this.accidentProperty = accidentProperty;
    }

    public java.lang.String getAssetsMan() {
        return assetsMan;
    }

    public void setAssetsMan(java.lang.String assetsMan) {
        this.assetsMan = assetsMan;
    }

    public java.lang.String getAssetsManAlias() {
        return assetsManAlias;
    }

    public void setAssetsManAlias(java.lang.String assetsManAlias) {
        this.assetsManAlias = assetsManAlias;
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
            return "ASSETS_ACCIDENT_PROC";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_ACCIDENT_PROC";
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

    public java.lang.String getAutoCodeValue() {
        return autoCodeValue;
    }

    public void setAutoCodeValue(java.lang.String autoCodeValue) {
        this.autoCodeValue = autoCodeValue;
    }
}