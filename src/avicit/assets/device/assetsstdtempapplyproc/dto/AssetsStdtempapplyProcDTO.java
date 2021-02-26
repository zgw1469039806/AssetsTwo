package avicit.assets.device.assetsstdtempapplyproc.dto;

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
 * @创建时间： 2020-06-20 16:59
 * @类说明：ASSETS_STDTEMPAPPLY_PROC
 * @修改记录：
 */
@PojoRemark(table = "assets_stdtempapply_proc", object = "AssetsStdtempapplyProcDTO", name = "ASSETS_STDTEMPAPPLY_PROC")
public class AssetsStdtempapplyProcDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;
    private String activityalias_; // 节点中文名称
    private String activityname_; // 当前节点id
    private String businessstate_; // 流程当前状态
    private String currUserId; // 当前登录人ID
    private String bpmType;
    private String bpmState;
    private String autoCodeValue;

    public String getAutoCodeValue() {
        return autoCodeValue;
    }

    public void setAutoCodeValue(String autoCodeValue) {
        this.autoCodeValue = autoCodeValue;
    }

    @Id
    @LogField

    @FieldRemark(column = "id", field = "id", name = "主键")
    /*
     *主键
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
     *最后修改时间 开始时间
     */
    private java.util.Date lastUpdateDateBegin;
    /*
     *最后修改时间 截止时间
     */
    private java.util.Date lastUpdateDateEnd;

    @FieldRemark(column = "form_state", field = "formState", name = "单据状态 ")
    /*
     *单据状态
     */
    private String formState;

    @FieldRemark(column = "device_name", field = "deviceName", name = "设备名称 ")
    /*
     *设备名称
     */
    private String deviceName;

    @FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格 ")
    /*
     *设备规格
     */
    private String deviceSpec;

    @FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号 ")
    /*
     *设备型号
     */
    private String deviceModel;

    @FieldRemark(column = "secret_level", field = "secretLevel", name = "密级 ")
    /*
     *密级
     */
    private String secretLevel;
    /*
     *密级 显示名称
     */
    private String secretLevelName;

    @FieldRemark(column = "reference_plant", field = "referencePlant", name = "参考厂家 ")
    /*
     *参考厂家
     */
    private String referencePlant;

    @FieldRemark(column = "device_num", field = "deviceNum", name = "台（套）数 ")
    /*
     *台（套）数
     */
    private Long deviceNum;

    @FieldRemark(column = "unit_price", field = "unitPrice", name = "单价(元) ")
    /*
     *单价(元)
     */
    private java.math.BigDecimal unitPrice;

    @FieldRemark(column = "total_price", field = "totalPrice", name = "总金额（元） ")
    /*
     *总金额（元）
     */
    private java.math.BigDecimal totalPrice;

    @FieldRemark(column = "device_type", field = "deviceType", name = "设备类型 ")
    /*
     *设备类型
     */
    private String deviceType;
    /*
     *设备类型 显示名称
     */
    private String deviceTypeName;

    @FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别 ")
    /*
     *设备类别
     */
    private String deviceCategory;
    /*
     *设备类别 显示名称
     */
    private String deviceCategoryName;

    @FieldRemark(column = "is_metering", field = "isMetering", name = "是否计量 ")
    /*
     *是否计量
     */
    private String isMetering;
    /*
     *是否计量 显示名称
     */
    private String isMeteringName;

    @FieldRemark(column = "is_scene_metering", field = "isSceneMetering", name = "是否现场计量 ")
    /*
     *是否现场计量
     */
    private String isSceneMetering;
    /*
     *是否现场计量 显示名称
     */
    private String isSceneMeteringName;

    @FieldRemark(column = "is_maintain", field = "isMaintain", name = "是否保养 ")
    /*
     *是否保养
     */
    private String isMaintain;
    /*
     *是否保养 显示名称
     */
    private String isMaintainName;

    @FieldRemark(column = "is_accuracy_check", field = "isAccuracyCheck", name = "是否精度检查 ")
    /*
     *是否精度检查
     */
    private String isAccuracyCheck;
    /*
     *是否精度检查 显示名称
     */
    private String isAccuracyCheckName;

    @FieldRemark(column = "is_regular_check", field = "isRegularCheck", name = "是否定检 ")
    /*
     *是否定检
     */
    private String isRegularCheck;
    /*
     *是否定检 显示名称
     */
    private String isRegularCheckName;

    @FieldRemark(column = "is_spot_check", field = "isSpotCheck", name = "是否点检 ")
    /*
     *是否点检
     */
    private String isSpotCheck;
    /*
     *是否点检 显示名称
     */
    private String isSpotCheckName;

    @FieldRemark(column = "is_special_device", field = "isSpecialDevice", name = "是否特种设备 ")
    /*
     *是否特种设备
     */
    private String isSpecialDevice;
    /*
     *是否特种设备 显示名称
     */
    private String isSpecialDeviceName;

    @FieldRemark(column = "is_precision_index", field = "isPrecisionIndex", name = "是否精度指标 ")
    /*
     *是否精度指标
     */
    private String isPrecisionIndex;
    /*
     *是否精度指标 显示名称
     */
    private String isPrecisionIndexName;

    @FieldRemark(column = "is_need_install", field = "isNeedInstall", name = "是否需要安装 ")
    /*
     *是否需要安装
     */
    private String isNeedInstall;
    /*
     *是否需要安装 显示名称
     */
    private String isNeedInstallName;

    @FieldRemark(column = "install_position", field = "installPosition", name = "安装地点 ")
    /*
     *安装地点
     */
    private String installPosition;

    @FieldRemark(column = "is_foundation", field = "isFoundation", name = "是否需要地基基础 ")
    /*
     *是否需要地基基础
     */
    private String isFoundation;
    /*
     *是否需要地基基础 显示名称
     */
    private String isFoundationName;

    @FieldRemark(column = "is_safety_production", field = "isSafetyProduction", name = "是否涉及安全生产 ")
    /*
     *是否涉及安全生产
     */
    private String isSafetyProduction;
    /*
     *是否涉及安全生产 显示名称
     */
    private String isSafetyProductionName;

    @FieldRemark(column = "financial_resources", field = "financialResources", name = "经费来源 ")
    /*
     *经费来源
     */
    private String financialResources;
    /*
     *经费来源 显示名称
     */
    private String financialResourcesName;

    @FieldRemark(column = "to_project", field = "toProject", name = "所属项目")
    /*
     *所属项目
     */
    private String toProject;

    @FieldRemark(column = "approval_name", field = "approvalName", name = "批复名称")
    /*
     *批复名称
     */
    private String approvalName;

    @FieldRemark(column = "chief_engineer", field = "chiefEngineer", name = "主管总师")
    /*
     *主管总师
     */
    private String chiefEngineer;
    /*
     *主管总师显示字段
     */
    private String chiefEngineerAlias;

    @FieldRemark(column = "project_num", field = "projectNum", name = "项目序号")
    /*
     *项目序号
     */
    private String projectNum;

    @FieldRemark(column = "project_director", field = "projectDirector", name = "项目主管")
    /*
     *项目主管
     */
    private String projectDirector;
    /*
     *项目主管显示字段
     */
    private String projectDirectorAlias;

    @FieldRemark(column = "demand_urgency_degree", field = "demandUrgencyDegree", name = "需求紧急程度 ")
    /*
     *需求紧急程度
     */
    private String demandUrgencyDegree;
    /*
     *需求紧急程度 显示名称
     */
    private String demandUrgencyDegreeName;

    @FieldRemark(column = "is_train", field = "isTrain", name = "是否需要设备培训 ")
    /*
     *是否需要设备培训
     */
    private String isTrain;
    /*
     *是否需要设备培训 显示名称
     */
    private String isTrainName;

    @FieldRemark(column = "is_pc", field = "isPc", name = "是否是计算机 ")
    /*
     *是否是计算机
     */
    private String isPc;
    /*
     *是否是计算机 显示名称
     */
    private String isPcName;

    @FieldRemark(column = "plan_delivery_time", field = "planDeliveryTime", name = "计划到货时间 ")
    /*
     *计划到货时间
     */
    private java.util.Date planDeliveryTime;
    /*
     *计划到货时间 开始时间
     */
    private java.util.Date planDeliveryTimeBegin;
    /*
     *计划到货时间 截止时间
     */
    private java.util.Date planDeliveryTimeEnd;

    @FieldRemark(column = "buyer", field = "buyer", name = "采购员 ")
    /*
     *采购员
     */
    private String buyer;
    /*
     *采购员 显示字段
     */
    private String buyerAlias;

    @FieldRemark(column = "plan_buyer", field = "planBuyer", name = "采购计划员 ")
    /*
     *采购计划员
     */
    private String planBuyer;
    /*
     *采购计划员 显示字段
     */
    private String planBuyerAlias;

    @FieldRemark(column = "is_wireless", field = "isWireless", name = "是否具有无线功能 ")
    /*
     *是否具有无线功能
     */
    private String isWireless;
    /*
     *是否具有无线功能 显示名称
     */
    private String isWirelessName;

    @FieldRemark(column = "device_purchase_type", field = "devicePurchaseType", name = "设备购置类型 ")
    /*
     *设备购置类型
     */
    private String devicePurchaseType;

    @FieldRemark(column = "device_purchase_cause", field = "devicePurchaseCause", name = "设备购置原因 ")
    /*
     *设备购置原因
     */
    private String devicePurchaseCause;

    @FieldRemark(column = "technical_index", field = "technicalIndex", name = "技术指标 ")
    /*
     *技术指标
     */
    private String technicalIndex;

    @FieldRemark(column = "technical_index_02", field = "technicalIndex02", name = "技术指标 ")
    /*
     *技术指标
     */
    private String technicalIndex02;

    @FieldRemark(column = "advancement", field = "advancement", name = "指标先进性 ")
    /*
     *指标先进性
     */
    private String advancement;

    @FieldRemark(column = "device_reliability", field = "deviceReliability", name = "设备可靠性 ")
    /*
     *设备可靠性
     */
    private String deviceReliability;

    @FieldRemark(column = "is_weed_out", field = "isWeedOut", name = "是否属于即将产能淘汰设备 ")
    /*
     *是否属于即将产能淘汰设备
     */
    private String isWeedOut;
    /*
     *是否属于即将产能淘汰设备 显示名称
     */
    private String isWeedOutName;

    @FieldRemark(column = "not_meet_demand", field = "notMeetDemand", name = "已有设备为什么不能满足要求 ")
    /*
     *已有设备为什么不能满足要求
     */
    private String notMeetDemand;

    @FieldRemark(column = "use_ratio", field = "useRatio", name = "设备利用率情况 ")
    /*
     *设备利用率情况
     */
    private String useRatio;

    @FieldRemark(column = "energy_consumption", field = "energyConsumption", name = "设备能耗情况 ")
    /*
     *设备能耗情况
     */
    private String energyConsumption;

    @FieldRemark(column = "consumable_economics", field = "consumableEconomics", name = "设备耗材经济性 ")
    /*
     *设备耗材经济性
     */
    private String consumableEconomics;

    @FieldRemark(column = "universality", field = "universality", name = "设备通用性 ")
    /*
     *设备通用性
     */
    private String universality;

    @FieldRemark(column = "maintain_cost", field = "maintainCost", name = "设备维保费用情况 ")
    /*
     *设备维保费用情况
     */
    private String maintainCost;

    @FieldRemark(column = "security", field = "security", name = "安全性 ")
    /*
     *安全性
     */
    private String security;

    @FieldRemark(column = "is_bearing_meet", field = "isBearingMeet", name = "安装设备楼层承重是否满足 ")
    /*
     *安装设备楼层承重是否满足
     */
    private String isBearingMeet;
    /*
     *安装设备楼层承重是否满足 显示名称
     */
    private String isBearingMeetName;

    @FieldRemark(column = "is_outdoor_unit", field = "isOutdoorUnit", name = "设备是否有室外机 ")
    /*
     *设备是否有室外机
     */
    private String isOutdoorUnit;
    /*
     *设备是否有室外机 显示名称
     */
    private String isOutdoorUnitName;

    @FieldRemark(column = "is_allow_outdoor_unit", field = "isAllowOutdoorUnit", name = "所安装位置是否允许安装室外机 ")
    /*
     *所安装位置是否允许安装室外机
     */
    private String isAllowOutdoorUnit;
    /*
     *所安装位置是否允许安装室外机 显示名称
     */
    private String isAllowOutdoorUnitName;

    @FieldRemark(column = "is_need_foundation", field = "isNeedFoundation", name = "设备是否需要地基基础 ")
    /*
     *设备是否需要地基基础
     */
    private String isNeedFoundation;
    /*
     *设备是否需要地基基础 显示名称
     */
    private String isNeedFoundationName;

    @FieldRemark(column = "is_foundation_condition", field = "isFoundationCondition", name = "所安装位置是否具备设置地基条件 ")
    /*
     *所安装位置是否具备设置地基条件
     */
    private String isFoundationCondition;
    /*
     *所安装位置是否具备设置地基条件 显示名称
     */
    private String isFoundationConditionName;

    @FieldRemark(column = "service_voltage", field = "serviceVoltage", name = "使用电压 ")
    /*
     *使用电压
     */
    private String serviceVoltage;

    @FieldRemark(column = "is_voltage_condition", field = "isVoltageCondition", name = "安装位置是否具备电压条件 ")
    /*
     *安装位置是否具备电压条件
     */
    private String isVoltageCondition;
    /*
     *安装位置是否具备电压条件 显示名称
     */
    private String isVoltageConditionName;

    @FieldRemark(column = "is_humidity_need", field = "isHumidityNeed", name = "是否对温湿度有要求 ")
    /*
     *是否对温湿度有要求
     */
    private String isHumidityNeed;
    /*
     *是否对温湿度有要求 显示名称
     */
    private String isHumidityNeedName;

    @FieldRemark(column = "humidity_need", field = "humidityNeed", name = "温湿度要求 ")
    /*
     *温湿度要求
     */
    private String humidityNeed;

    @FieldRemark(column = "is_cleanliness_need", field = "isCleanlinessNeed", name = "是否对洁净度有要求 ")
    /*
     *是否对洁净度有要求
     */
    private String isCleanlinessNeed;
    /*
     *是否对洁净度有要求 显示名称
     */
    private String isCleanlinessNeedName;

    @FieldRemark(column = "cleanliness_need", field = "cleanlinessNeed", name = "洁净度要求 ")
    /*
     *洁净度要求
     */
    private String cleanlinessNeed;

    @FieldRemark(column = "is_water_need", field = "isWaterNeed", name = "是否有用水要求 ")
    /*
     *是否有用水要求
     */
    private String isWaterNeed;
    /*
     *是否有用水要求 显示名称
     */
    private String isWaterNeedName;

    @FieldRemark(column = "water_need", field = "waterNeed", name = "用水要求 ")
    /*
     *用水要求
     */
    private String waterNeed;

    @FieldRemark(column = "is_gas_need", field = "isGasNeed", name = "是否有用气要求 ")
    /*
     *是否有用气要求
     */
    private String isGasNeed;
    /*
     *是否有用气要求 显示名称
     */
    private String isGasNeedName;

    @FieldRemark(column = "gas_need", field = "gasNeed", name = "用气要求 ")
    /*
     *用气要求
     */
    private String gasNeed;

    @FieldRemark(column = "is_let", field = "isLet", name = "是否是否有气体、污水排放 ")
    /*
     *是否是否有气体、污水排放
     */
    private String isLet;
    /*
     *是否是否有气体、污水排放 显示名称
     */
    private String isLetName;

    @FieldRemark(column = "let_need", field = "letNeed", name = "气体、污水排放要求 ")
    /*
     *气体、污水排放要求
     */
    private String letNeed;

    @FieldRemark(column = "is_other_need", field = "isOtherNeed", name = "是否有其他特殊要求 ")
    /*
     *是否有其他特殊要求
     */
    private String isOtherNeed;
    /*
     *是否有其他特殊要求 显示名称
     */
    private String isOtherNeedName;

    @FieldRemark(column = "other_need", field = "otherNeed", name = "其他特殊要求 ")
    /*
     *其他特殊要求
     */
    private String otherNeed;

    @FieldRemark(column = "is_noise", field = "isNoise", name = "是否有噪音 ")
    /*
     *是否有噪音
     */
    private String isNoise;
    /*
     *是否有噪音 显示名称
     */
    private String isNoiseName;

    @FieldRemark(column = "is_noise_influence", field = "isNoiseInfluence", name = "噪音是否影响安装地工作办公 ")
    /*
     *噪音是否影响安装地工作办公
     */
    private String isNoiseInfluence;
    /*
     *噪音是否影响安装地工作办公 显示名称
     */
    private String isNoiseInfluenceName;

    @FieldRemark(column = "above_need_have", field = "aboveNeedHave", name = "以上需求条件在拟安装地点是否都已具备 ")
    /*
     *以上需求条件在拟安装地点是否都已具备
     */
    private String aboveNeedHave;

    @FieldRemark(column = "examine_approve_engineer", field = "examineApproveEngineer", name = "审批总师 ")
    /*
     *审批总师
     */
    private String examineApproveEngineer;

    @FieldRemark(column = "professional_auditor", field = "professionalAuditor", name = "专业审核员 ")
    /*
     *专业审核员
     */
    private String professionalAuditor;

    @FieldRemark(column = "competent_leader", field = "competentLeader", name = "主管所领导 ")
    /*
     *主管所领导
     */
    private String competentLeader;

    @FieldRemark(column = "dept_head_conclusion", field = "deptHeadConclusion", name = "部门领导结论 ")
    /*
     *部门领导结论
     */
    private String deptHeadConclusion;

    @FieldRemark(column = "dept_head_opinion", field = "deptHeadOpinion", name = "部门领导意见 ")
    /*
     *部门领导意见
     */
    private String deptHeadOpinion;

    @FieldRemark(column = "professional_auditor_opinion", field = "professionalAuditorOpinion", name = "专业审核员意见 ")
    /*
     *专业审核员意见
     */
    private String professionalAuditorOpinion;

    @FieldRemark(column = "chief_engineer_conclusion", field = "chiefEngineerConclusion", name = "总师结论 ")
    /*
     *总师结论
     */
    private String chiefEngineerConclusion;

    @FieldRemark(column = "chief_engineer_opinion", field = "chiefEngineerOpinion", name = "总师意见 ")
    /*
     *总师意见
     */
    private String chiefEngineerOpinion;

    @FieldRemark(column = "competent_leader_conclusion", field = "competentLeaderConclusion", name = "主管所领导结论 ")
    /*
     *主管所领导结论
     */
    private String competentLeaderConclusion;

    @FieldRemark(column = "competent_leader_opinion", field = "competentLeaderOpinion", name = "主管所领导意见 ")
    /*
     *主管所领导意见
     */
    private String competentLeaderOpinion;

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

    @FieldRemark(column = "large_device_type", field = "largeDeviceType", name = "简易/大型设备")
    /*
     *简易/大型设备
     */
    private String largeDeviceType;
    /*
     *简易/大型设备显示名称
     */
    private String largeDeviceTypeName;

    @FieldRemark(column = "institute_or_company", field = "instituteOrCompany", name = "研究所/公司")
    /*
     *研究所/公司
     */
    private String instituteOrCompany;
    /*
     *研究所/公司显示名称
     */
    private String instituteOrCompanyName;

    @FieldRemark(column = "created_by_persion", field = "createdByPersion", name = "申请人")
    /*
     *申请人
     */
    private String createdByPersion;
    /*
     *申请人显示字段
     */
    private String createdByPersionAlias;


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

    public String getSecretLevel() {
        return secretLevel;
    }

    public void setSecretLevel(String secretLevel) {
        this.secretLevel = secretLevel;
    }

    public String getSecretLevelName() {
        return secretLevelName;
    }

    public void setSecretLevelName(String secretLevelName) {
        this.secretLevelName = secretLevelName;
    }

    public String getReferencePlant() {
        return referencePlant;
    }

    public void setReferencePlant(String referencePlant) {
        this.referencePlant = referencePlant;
    }

    public Long getDeviceNum() {
        return deviceNum;
    }

    public void setDeviceNum(Long deviceNum) {
        this.deviceNum = deviceNum;
    }

    public java.math.BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(java.math.BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public java.math.BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(java.math.BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getDeviceTypeName() {
        return deviceTypeName;
    }

    public void setDeviceTypeName(String deviceTypeName) {
        this.deviceTypeName = deviceTypeName;
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

    public String getIsMetering() {
        return isMetering;
    }

    public void setIsMetering(String isMetering) {
        this.isMetering = isMetering;
    }

    public String getIsMeteringName() {
        return isMeteringName;
    }

    public void setIsMeteringName(String isMeteringName) {
        this.isMeteringName = isMeteringName;
    }

    public String getIsSceneMetering() {
        return isSceneMetering;
    }

    public void setIsSceneMetering(String isSceneMetering) {
        this.isSceneMetering = isSceneMetering;
    }

    public String getIsSceneMeteringName() {
        return isSceneMeteringName;
    }

    public void setIsSceneMeteringName(String isSceneMeteringName) {
        this.isSceneMeteringName = isSceneMeteringName;
    }

    public String getIsMaintain() {
        return isMaintain;
    }

    public void setIsMaintain(String isMaintain) {
        this.isMaintain = isMaintain;
    }

    public String getIsMaintainName() {
        return isMaintainName;
    }

    public void setIsMaintainName(String isMaintainName) {
        this.isMaintainName = isMaintainName;
    }

    public String getIsAccuracyCheck() {
        return isAccuracyCheck;
    }

    public void setIsAccuracyCheck(String isAccuracyCheck) {
        this.isAccuracyCheck = isAccuracyCheck;
    }

    public String getIsAccuracyCheckName() {
        return isAccuracyCheckName;
    }

    public void setIsAccuracyCheckName(String isAccuracyCheckName) {
        this.isAccuracyCheckName = isAccuracyCheckName;
    }

    public String getIsRegularCheck() {
        return isRegularCheck;
    }

    public void setIsRegularCheck(String isRegularCheck) {
        this.isRegularCheck = isRegularCheck;
    }

    public String getIsRegularCheckName() {
        return isRegularCheckName;
    }

    public void setIsRegularCheckName(String isRegularCheckName) {
        this.isRegularCheckName = isRegularCheckName;
    }

    public String getIsSpotCheck() {
        return isSpotCheck;
    }

    public void setIsSpotCheck(String isSpotCheck) {
        this.isSpotCheck = isSpotCheck;
    }

    public String getIsSpotCheckName() {
        return isSpotCheckName;
    }

    public void setIsSpotCheckName(String isSpotCheckName) {
        this.isSpotCheckName = isSpotCheckName;
    }

    public String getIsSpecialDevice() {
        return isSpecialDevice;
    }

    public void setIsSpecialDevice(String isSpecialDevice) {
        this.isSpecialDevice = isSpecialDevice;
    }

    public String getIsSpecialDeviceName() {
        return isSpecialDeviceName;
    }

    public void setIsSpecialDeviceName(String isSpecialDeviceName) {
        this.isSpecialDeviceName = isSpecialDeviceName;
    }

    public String getIsPrecisionIndex() {
        return isPrecisionIndex;
    }

    public void setIsPrecisionIndex(String isPrecisionIndex) {
        this.isPrecisionIndex = isPrecisionIndex;
    }

    public String getIsPrecisionIndexName() {
        return isPrecisionIndexName;
    }

    public void setIsPrecisionIndexName(String isPrecisionIndexName) {
        this.isPrecisionIndexName = isPrecisionIndexName;
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

    public String getInstallPosition() {
        return installPosition;
    }

    public void setInstallPosition(String installPosition) {
        this.installPosition = installPosition;
    }

    public String getIsFoundation() {
        return isFoundation;
    }

    public void setIsFoundation(String isFoundation) {
        this.isFoundation = isFoundation;
    }

    public String getIsFoundationName() {
        return isFoundationName;
    }

    public void setIsFoundationName(String isFoundationName) {
        this.isFoundationName = isFoundationName;
    }

    public String getIsSafetyProduction() {
        return isSafetyProduction;
    }

    public void setIsSafetyProduction(String isSafetyProduction) {
        this.isSafetyProduction = isSafetyProduction;
    }

    public String getIsSafetyProductionName() {
        return isSafetyProductionName;
    }

    public void setIsSafetyProductionName(String isSafetyProductionName) {
        this.isSafetyProductionName = isSafetyProductionName;
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

    public String getToProject() {
        return toProject;
    }

    public void setToProject(String toProject) {
        this.toProject = toProject;
    }

    public String getApprovalName() {
        return approvalName;
    }

    public void setApprovalName(String approvalName) {
        this.approvalName = approvalName;
    }

    public String getChiefEngineer() {
        return chiefEngineer;
    }

    public void setChiefEngineer(String chiefEngineer) {
        this.chiefEngineer = chiefEngineer;
    }

    public String getChiefEngineerAlias() {
        return chiefEngineerAlias;
    }

    public void setChiefEngineerAlias(String chiefEngineerAlias) {
        this.chiefEngineerAlias = chiefEngineerAlias;
    }

    public String getProjectNum() {
        return projectNum;
    }

    public void setProjectNum(String projectNum) {
        this.projectNum = projectNum;
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

    public String getDemandUrgencyDegree() {
        return demandUrgencyDegree;
    }

    public void setDemandUrgencyDegree(String demandUrgencyDegree) {
        this.demandUrgencyDegree = demandUrgencyDegree;
    }

    public String getDemandUrgencyDegreeName() {
        return demandUrgencyDegreeName;
    }

    public void setDemandUrgencyDegreeName(String demandUrgencyDegreeName) {
        this.demandUrgencyDegreeName = demandUrgencyDegreeName;
    }

    public String getIsTrain() {
        return isTrain;
    }

    public void setIsTrain(String isTrain) {
        this.isTrain = isTrain;
    }

    public String getIsTrainName() {
        return isTrainName;
    }

    public void setIsTrainName(String isTrainName) {
        this.isTrainName = isTrainName;
    }

    public String getIsPc() {
        return isPc;
    }

    public void setIsPc(String isPc) {
        this.isPc = isPc;
    }

    public String getIsPcName() {
        return isPcName;
    }

    public void setIsPcName(String isPcName) {
        this.isPcName = isPcName;
    }

    public java.util.Date getPlanDeliveryTime() {
        return planDeliveryTime;
    }

    public void setPlanDeliveryTime(java.util.Date planDeliveryTime) {
        this.planDeliveryTime = planDeliveryTime;
    }

    public java.util.Date getPlanDeliveryTimeBegin() {
        return planDeliveryTimeBegin;
    }

    public void setPlanDeliveryTimeBegin(java.util.Date planDeliveryTimeBegin) {
        this.planDeliveryTimeBegin = planDeliveryTimeBegin;
    }

    public java.util.Date getPlanDeliveryTimeEnd() {
        return planDeliveryTimeEnd;
    }

    public void setPlanDeliveryTimeEnd(java.util.Date planDeliveryTimeEnd) {
        this.planDeliveryTimeEnd = planDeliveryTimeEnd;
    }

    public String getBuyer() {
        return buyer;
    }

    public void setBuyer(String buyer) {
        this.buyer = buyer;
    }

    public String getBuyerAlias() {
        return buyerAlias;
    }

    public void setBuyerAlias(String buyerAlias) {
        this.buyerAlias = buyerAlias;
    }

    public String getPlanBuyer() {
        return planBuyer;
    }

    public void setPlanBuyer(String planBuyer) {
        this.planBuyer = planBuyer;
    }

    public String getPlanBuyerAlias() {
        return planBuyerAlias;
    }

    public void setPlanBuyerAlias(String planBuyerAlias) {
        this.planBuyerAlias = planBuyerAlias;
    }

    public String getIsWireless() {
        return isWireless;
    }

    public void setIsWireless(String isWireless) {
        this.isWireless = isWireless;
    }

    public String getIsWirelessName() {
        return isWirelessName;
    }

    public void setIsWirelessName(String isWirelessName) {
        this.isWirelessName = isWirelessName;
    }

    public String getDevicePurchaseType() {
        return devicePurchaseType;
    }

    public void setDevicePurchaseType(String devicePurchaseType) {
        this.devicePurchaseType = devicePurchaseType;
    }

    public String getDevicePurchaseCause() {
        return devicePurchaseCause;
    }

    public void setDevicePurchaseCause(String devicePurchaseCause) {
        this.devicePurchaseCause = devicePurchaseCause;
    }

    public String getTechnicalIndex() {
        return technicalIndex;
    }

    public void setTechnicalIndex(String technicalIndex) {
        this.technicalIndex = technicalIndex;
    }

    public String getTechnicalIndex02() {
        return technicalIndex02;
    }

    public void setTechnicalIndex02(String technicalIndex02) {
        this.technicalIndex02 = technicalIndex02;
    }

    public String getAdvancement() {
        return advancement;
    }

    public void setAdvancement(String advancement) {
        this.advancement = advancement;
    }

    public String getDeviceReliability() {
        return deviceReliability;
    }

    public void setDeviceReliability(String deviceReliability) {
        this.deviceReliability = deviceReliability;
    }

    public String getIsWeedOut() {
        return isWeedOut;
    }

    public void setIsWeedOut(String isWeedOut) {
        this.isWeedOut = isWeedOut;
    }

    public String getIsWeedOutName() {
        return isWeedOutName;
    }

    public void setIsWeedOutName(String isWeedOutName) {
        this.isWeedOutName = isWeedOutName;
    }

    public String getNotMeetDemand() {
        return notMeetDemand;
    }

    public void setNotMeetDemand(String notMeetDemand) {
        this.notMeetDemand = notMeetDemand;
    }

    public String getUseRatio() {
        return useRatio;
    }

    public void setUseRatio(String useRatio) {
        this.useRatio = useRatio;
    }

    public String getEnergyConsumption() {
        return energyConsumption;
    }

    public void setEnergyConsumption(String energyConsumption) {
        this.energyConsumption = energyConsumption;
    }

    public String getConsumableEconomics() {
        return consumableEconomics;
    }

    public void setConsumableEconomics(String consumableEconomics) {
        this.consumableEconomics = consumableEconomics;
    }

    public String getUniversality() {
        return universality;
    }

    public void setUniversality(String universality) {
        this.universality = universality;
    }

    public String getMaintainCost() {
        return maintainCost;
    }

    public void setMaintainCost(String maintainCost) {
        this.maintainCost = maintainCost;
    }

    public String getSecurity() {
        return security;
    }

    public void setSecurity(String security) {
        this.security = security;
    }

    public String getIsBearingMeet() {
        return isBearingMeet;
    }

    public void setIsBearingMeet(String isBearingMeet) {
        this.isBearingMeet = isBearingMeet;
    }

    public String getIsBearingMeetName() {
        return isBearingMeetName;
    }

    public void setIsBearingMeetName(String isBearingMeetName) {
        this.isBearingMeetName = isBearingMeetName;
    }

    public String getIsOutdoorUnit() {
        return isOutdoorUnit;
    }

    public void setIsOutdoorUnit(String isOutdoorUnit) {
        this.isOutdoorUnit = isOutdoorUnit;
    }

    public String getIsOutdoorUnitName() {
        return isOutdoorUnitName;
    }

    public void setIsOutdoorUnitName(String isOutdoorUnitName) {
        this.isOutdoorUnitName = isOutdoorUnitName;
    }

    public String getIsAllowOutdoorUnit() {
        return isAllowOutdoorUnit;
    }

    public void setIsAllowOutdoorUnit(String isAllowOutdoorUnit) {
        this.isAllowOutdoorUnit = isAllowOutdoorUnit;
    }

    public String getIsAllowOutdoorUnitName() {
        return isAllowOutdoorUnitName;
    }

    public void setIsAllowOutdoorUnitName(String isAllowOutdoorUnitName) {
        this.isAllowOutdoorUnitName = isAllowOutdoorUnitName;
    }

    public String getIsNeedFoundation() {
        return isNeedFoundation;
    }

    public void setIsNeedFoundation(String isNeedFoundation) {
        this.isNeedFoundation = isNeedFoundation;
    }

    public String getIsNeedFoundationName() {
        return isNeedFoundationName;
    }

    public void setIsNeedFoundationName(String isNeedFoundationName) {
        this.isNeedFoundationName = isNeedFoundationName;
    }

    public String getIsFoundationCondition() {
        return isFoundationCondition;
    }

    public void setIsFoundationCondition(String isFoundationCondition) {
        this.isFoundationCondition = isFoundationCondition;
    }

    public String getIsFoundationConditionName() {
        return isFoundationConditionName;
    }

    public void setIsFoundationConditionName(String isFoundationConditionName) {
        this.isFoundationConditionName = isFoundationConditionName;
    }

    public String getServiceVoltage() {
        return serviceVoltage;
    }

    public void setServiceVoltage(String serviceVoltage) {
        this.serviceVoltage = serviceVoltage;
    }

    public String getIsVoltageCondition() {
        return isVoltageCondition;
    }

    public void setIsVoltageCondition(String isVoltageCondition) {
        this.isVoltageCondition = isVoltageCondition;
    }

    public String getIsVoltageConditionName() {
        return isVoltageConditionName;
    }

    public void setIsVoltageConditionName(String isVoltageConditionName) {
        this.isVoltageConditionName = isVoltageConditionName;
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

    public String getIsCleanlinessNeed() {
        return isCleanlinessNeed;
    }

    public void setIsCleanlinessNeed(String isCleanlinessNeed) {
        this.isCleanlinessNeed = isCleanlinessNeed;
    }

    public String getIsCleanlinessNeedName() {
        return isCleanlinessNeedName;
    }

    public void setIsCleanlinessNeedName(String isCleanlinessNeedName) {
        this.isCleanlinessNeedName = isCleanlinessNeedName;
    }

    public String getCleanlinessNeed() {
        return cleanlinessNeed;
    }

    public void setCleanlinessNeed(String cleanlinessNeed) {
        this.cleanlinessNeed = cleanlinessNeed;
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

    public String getIsNoise() {
        return isNoise;
    }

    public void setIsNoise(String isNoise) {
        this.isNoise = isNoise;
    }

    public String getIsNoiseName() {
        return isNoiseName;
    }

    public void setIsNoiseName(String isNoiseName) {
        this.isNoiseName = isNoiseName;
    }

    public String getIsNoiseInfluence() {
        return isNoiseInfluence;
    }

    public void setIsNoiseInfluence(String isNoiseInfluence) {
        this.isNoiseInfluence = isNoiseInfluence;
    }

    public String getIsNoiseInfluenceName() {
        return isNoiseInfluenceName;
    }

    public void setIsNoiseInfluenceName(String isNoiseInfluenceName) {
        this.isNoiseInfluenceName = isNoiseInfluenceName;
    }

    public String getAboveNeedHave() {
        return aboveNeedHave;
    }

    public void setAboveNeedHave(String aboveNeedHave) {
        this.aboveNeedHave = aboveNeedHave;
    }

    public String getExamineApproveEngineer() {
        return examineApproveEngineer;
    }

    public void setExamineApproveEngineer(String examineApproveEngineer) {
        this.examineApproveEngineer = examineApproveEngineer;
    }

    public String getProfessionalAuditor() {
        return professionalAuditor;
    }

    public void setProfessionalAuditor(String professionalAuditor) {
        this.professionalAuditor = professionalAuditor;
    }

    public String getCompetentLeader() {
        return competentLeader;
    }

    public void setCompetentLeader(String competentLeader) {
        this.competentLeader = competentLeader;
    }

    public String getDeptHeadConclusion() {
        return deptHeadConclusion;
    }

    public void setDeptHeadConclusion(String deptHeadConclusion) {
        this.deptHeadConclusion = deptHeadConclusion;
    }

    public String getDeptHeadOpinion() {
        return deptHeadOpinion;
    }

    public void setDeptHeadOpinion(String deptHeadOpinion) {
        this.deptHeadOpinion = deptHeadOpinion;
    }

    public String getProfessionalAuditorOpinion() {
        return professionalAuditorOpinion;
    }

    public void setProfessionalAuditorOpinion(String professionalAuditorOpinion) {
        this.professionalAuditorOpinion = professionalAuditorOpinion;
    }

    public String getChiefEngineerConclusion() {
        return chiefEngineerConclusion;
    }

    public void setChiefEngineerConclusion(String chiefEngineerConclusion) {
        this.chiefEngineerConclusion = chiefEngineerConclusion;
    }

    public String getChiefEngineerOpinion() {
        return chiefEngineerOpinion;
    }

    public void setChiefEngineerOpinion(String chiefEngineerOpinion) {
        this.chiefEngineerOpinion = chiefEngineerOpinion;
    }

    public String getCompetentLeaderConclusion() {
        return competentLeaderConclusion;
    }

    public void setCompetentLeaderConclusion(String competentLeaderConclusion) {
        this.competentLeaderConclusion = competentLeaderConclusion;
    }

    public String getCompetentLeaderOpinion() {
        return competentLeaderOpinion;
    }

    public void setCompetentLeaderOpinion(String competentLeaderOpinion) {
        this.competentLeaderOpinion = competentLeaderOpinion;
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

    public String getLargeDeviceType() {
        return largeDeviceType;
    }

    public void setLargeDeviceType(String largeDeviceType) {
        this.largeDeviceType = largeDeviceType;
    }

    public String getLargeDeviceTypeName() {
        return largeDeviceTypeName;
    }

    public void setLargeDeviceTypeName(String largeDeviceTypeName) {
        this.largeDeviceTypeName = largeDeviceTypeName;
    }

    public String getInstituteOrCompany() {
        return instituteOrCompany;
    }

    public void setInstituteOrCompany(String instituteOrCompany) {
        this.instituteOrCompany = instituteOrCompany;
    }

    public String getInstituteOrCompanyName() {
        return instituteOrCompanyName;
    }

    public void setInstituteOrCompanyName(String instituteOrCompanyName) {
        this.instituteOrCompanyName = instituteOrCompanyName;
    }

    public String getCreatedByPersion() {
        return createdByPersion;
    }

    public void setCreatedByPersion(String createdByPersion) {
        this.createdByPersion = createdByPersion;
    }

    public String getCreatedByPersionAlias() {
        return createdByPersionAlias;
    }

    public void setCreatedByPersionAlias(String createdByPersionAlias) {
        this.createdByPersionAlias = createdByPersionAlias;
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
            return "ASSETS_STDTEMPAPPLY_PROC";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_STDTEMPAPPLY_PROC";
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