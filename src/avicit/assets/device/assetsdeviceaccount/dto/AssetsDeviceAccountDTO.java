package avicit.assets.device.assetsdeviceaccount.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-06-20 17:59 
 * @类说明：ASSETS_DEVICE_ACCOUNT
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_account", object = "AssetsDeviceAccountDTO", name = "ASSETS_DEVICE_ACCOUNT")
public class AssetsDeviceAccountDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

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
	@LogField

	@FieldRemark(column = "asset_id", field = "assetId", name = "资产编号")
	/*
	 *资产编号
	 */
	private java.lang.String assetId;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private java.lang.String unifiedId;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private java.lang.String deviceCategory;

	public String getDeviceCategoryId() {
		return deviceCategoryId;
	}

	public void setDeviceCategoryId(String deviceCategoryId) {
		this.deviceCategoryId = deviceCategoryId;
	}

	/*
	 *设备类别Id
	 */
	private java.lang.String deviceCategoryId;

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

	@FieldRemark(column = "user_id", field = "userId", name = "使用人")
	/*
	 *使用人
	 */
	private java.lang.String userId;
	/*
	 *使用人显示字段
	 */
	private java.lang.String userIdAlias;

	@FieldRemark(column = "user_dept", field = "userDept", name = "使用人部门")
	/*
	 *使用人部门
	 */
	private java.lang.String userDept;
	/*
	 *使用人部门显示字段
	 */
	private java.lang.String userDeptAlias;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private java.lang.String manufacturerId;

	@FieldRemark(column = "created_date", field = "createdDate", name = "立卡日期")
	/*
	 *立卡日期
	 */
	private java.util.Date createdDate;
	/*
	 *立卡日期开始时间
	 */
	private java.util.Date createdDateBegin;
	/*
	 *立卡日期截止时间
	 */
	private java.util.Date createdDateEnd;

	@FieldRemark(column = "is_manage", field = "isManage", name = "是否统管设备")
	/*
	 *是否统管设备
	 */
	private java.lang.String isManage;

	@FieldRemark(column = "is_in_workflow", field = "isInWorkflow", name = "是否在流程中")
	/*
	 *是否在流程中
	 */
	private java.lang.String isInWorkflow;

	@FieldRemark(column = "manage_state", field = "manageState", name = "统管设备状态")
	/*
	 *统管设备状态
	 */
	private java.lang.String manageState;

	@FieldRemark(column = "device_state", field = "deviceState", name = "设备状态")
	/*
	 *设备状态
	 */
	private java.lang.String deviceState;

	@FieldRemark(column = "parent_id", field = "parentId", name = "父级设备ID")
	/*
	 *父级设备ID
	 */
	private java.lang.String parentId;

	@FieldRemark(column = "parent_name", field = "parentName", name = "父级设备名称")
	/*
	 *父级设备名称
	 */
	private java.lang.String parentName;

	@FieldRemark(column = "common_name", field = "commonName", name = "常用名")
	/*
	 *常用名
	 */
	private java.lang.String commonName;

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点ID")
	/*
	 *安装地点ID
	 */
	private java.lang.String positionId;

	@FieldRemark(column = "abc_category", field = "abcCategory", name = "ABC分类")
	/*
	 *ABC分类
	 */
	private java.lang.String abcCategory;

	@FieldRemark(column = "is_key_device", field = "isKeyDevice", name = "是否军工关键设备设施")
	/*
	 *是否军工关键设备设施
	 */
	private java.lang.String isKeyDevice;

	@FieldRemark(column = "is_research", field = "isResearch", name = "是否科研生产设备")
	/*
	 *是否科研生产设备
	 */
	private java.lang.String isResearch;

	@FieldRemark(column = "product_country", field = "productCountry", name = "生产国家和地区")
	/*
	 *生产国家和地区
	 */
	private java.lang.String productCountry;

	@FieldRemark(column = "product_factory", field = "productFactory", name = "制造厂")
	/*
	 *制造厂
	 */
	private java.lang.String productFactory;

	@FieldRemark(column = "supplier", field = "supplier", name = "供应商")
	/*
	 *供应商
	 */
	private java.lang.String supplier;

	@FieldRemark(column = "product_date", field = "productDate", name = "出厂日期")
	/*
	 *出厂日期
	 */
	private java.util.Date productDate;
	/*
	 *出厂日期开始时间
	 */
	private java.util.Date productDateBegin;
	/*
	 *出厂日期截止时间
	 */
	private java.util.Date productDateEnd;

	@FieldRemark(column = "product_num", field = "productNum", name = "出厂编号")
	/*
	 *出厂编号
	 */
	private java.lang.String productNum;

	@FieldRemark(column = "device_power", field = "devicePower", name = "功率(单位：千瓦)")
	/*
	 *功率(单位：千瓦)
	 */
	private java.lang.String devicePower;

	@FieldRemark(column = "device_weight", field = "deviceWeight", name = "重量(单位：公斤)")
	/*
	 *重量(单位：公斤)
	 */
	private java.lang.String deviceWeight;

	@FieldRemark(column = "device_size", field = "deviceSize", name = "外形尺寸")
	/*
	 *外形尺寸
	 */
	private java.lang.String deviceSize;

	@FieldRemark(column = "check_date", field = "checkDate", name = "验收时间")
	/*
	 *验收时间
	 */
	private java.util.Date checkDate;
	/*
	 *验收时间开始时间
	 */
	private java.util.Date checkDateBegin;
	/*
	 *验收时间截止时间
	 */
	private java.util.Date checkDateEnd;

	@FieldRemark(column = "improve_project", field = "improveProject", name = "技改项目")
	/*
	 *技改项目
	 */
	private java.lang.String improveProject;

	@FieldRemark(column = "unit_price", field = "unitPrice", name = "单价(单位：元)")
	/*
	 *单价(单位：元)
	 */
	private java.math.BigDecimal unitPrice;

	@FieldRemark(column = "contract_num", field = "contractNum", name = "合同号")
	/*
	 *合同号
	 */
	private java.lang.String contractNum;

	@FieldRemark(column = "apply_num", field = "applyNum", name = "申购单号")
	/*
	 *申购单号
	 */
	private java.lang.String applyNum;

	@FieldRemark(column = "check_num", field = "checkNum", name = "验收单号")
	/*
	 *验收单号
	 */
	private java.lang.String checkNum;

	@FieldRemark(column = "car_frame_num", field = "carFrameNum", name = "车架号")
	/*
	 *车架号
	 */
	private java.lang.String carFrameNum;

	@FieldRemark(column = "engine_num", field = "engineNum", name = "发动机号")
	/*
	 *发动机号
	 */
	private java.lang.String engineNum;

	@FieldRemark(column = "car_num", field = "carNum", name = "车牌号")
	/*
	 *车牌号
	 */
	private java.lang.String carNum;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private java.lang.String secretLevel;

	@FieldRemark(column = "is_metering", field = "isMetering", name = "是否计量")
	/*
	 *是否计量
	 */
	private java.lang.String isMetering;

	@FieldRemark(column = "is_maintain", field = "isMaintain", name = "是否保养")
	/*
	 *是否保养
	 */
	private java.lang.String isMaintain;

	@FieldRemark(column = "is_accuracy_check", field = "isAccuracyCheck", name = "是否精度检查")
	/*
	 *是否精度检查
	 */
	private java.lang.String isAccuracyCheck;

	@FieldRemark(column = "is_regular_check", field = "isRegularCheck", name = "是否定检")
	/*
	 *是否定检
	 */
	private java.lang.String isRegularCheck;

	@FieldRemark(column = "is_spot_check", field = "isSpotCheck", name = "是否点检")
	/*
	 *是否点检
	 */
	private java.lang.String isSpotCheck;

	@FieldRemark(column = "is_special_device", field = "isSpecialDevice", name = "是否特种设备")
	/*
	 *是否特种设备
	 */
	private java.lang.String isSpecialDevice;

	@FieldRemark(column = "is_safety_production", field = "isSafetyProduction", name = "是否涉及安全生产")
	/*
	 *是否涉及安全生产
	 */
	private java.lang.String isSafetyProduction;

	@FieldRemark(column = "is_need_install", field = "isNeedInstall", name = "是否安装")
	/*
	 *是否安装
	 */
	private java.lang.String isNeedInstall;

	@FieldRemark(column = "is_pc", field = "isPc", name = "是否计算机")
	/*
	 *是否计算机
	 */
	private java.lang.String isPc;

	@FieldRemark(column = "device_type", field = "deviceType", name = "设备类型")
	/*
	 *设备类型
	 */
	private java.lang.String deviceType;

	@FieldRemark(column = "enable_date", field = "enableDate", name = "设备启用年月")
	/*
	 *设备启用年月
	 */
	private java.util.Date enableDate;
	/*
	 *设备启用年月开始时间
	 */
	private java.util.Date enableDateBegin;
	/*
	 *设备启用年月截止时间
	 */
	private java.util.Date enableDateEnd;

	@FieldRemark(column = "running_time", field = "runningTime", name = "运行时间")
	/*
	 *运行时间
	 */
	private Long runningTime;

	@FieldRemark(column = "ip", field = "ip", name = "IP地址")
	/*
	 *IP地址
	 */
	private java.lang.String ip;

	@FieldRemark(column = "mac", field = "mac", name = "MAC地址")
	/*
	 *MAC地址
	 */
	private java.lang.String mac;

	@FieldRemark(column = "disk_num", field = "diskNum", name = "硬盘序列号")
	/*
	 *硬盘序列号
	 */
	private java.lang.String diskNum;

	@FieldRemark(column = "os", field = "os", name = "操作系统")
	/*
	 *操作系统
	 */
	private java.lang.String os;

	@FieldRemark(column = "os_install_date", field = "osInstallDate", name = "操作系统安装时间")
	/*
	 *操作系统安装时间
	 */
	private java.util.Date osInstallDate;
	/*
	 *操作系统安装时间开始时间
	 */
	private java.util.Date osInstallDateBegin;
	/*
	 *操作系统安装时间截止时间
	 */
	private java.util.Date osInstallDateEnd;

	@FieldRemark(column = "metering_id", field = "meteringId", name = "计量标识")
	/*
	 *计量标识
	 */
	private java.lang.String meteringId;

	@FieldRemark(column = "meterman", field = "meterman", name = "计量人员")
	/*
	 *计量人员
	 */
	private java.lang.String meterman;
	/*
	 *计量人员显示字段
	 */
	private java.lang.String metermanAlias;

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

	@FieldRemark(column = "metering_cycle", field = "meteringCycle", name = "计量周期")
	/*
	 *计量周期
	 */
	private Long meteringCycle;

	@FieldRemark(column = "last_metering_date", field = "lastMeteringDate", name = "上次计量日期")
	/*
	 *上次计量日期
	 */
	private java.util.Date lastMeteringDate;
	/*
	 *上次计量日期开始时间
	 */
	private java.util.Date lastMeteringDateBegin;
	/*
	 *上次计量日期截止时间
	 */
	private java.util.Date lastMeteringDateEnd;

	@FieldRemark(column = "next_metering_date", field = "nextMeteringDate", name = "下次计量日期")
	/*
	 *下次计量日期
	 */
	private java.util.Date nextMeteringDate;
	/*
	 *下次计量日期开始时间
	 */
	private java.util.Date nextMeteringDateBegin;
	/*
	 *下次计量日期截止时间
	 */
	private java.util.Date nextMeteringDateEnd;

	@FieldRemark(column = "plan_meterman", field = "planMeterman", name = "计量计划员")
	/*
	 *计量计划员
	 */
	private java.lang.String planMeterman;
	/*
	 *计量计划员显示字段
	 */
	private java.lang.String planMetermanAlias;

	@FieldRemark(column = "metering_dept", field = "meteringDept", name = "计量单位")
	/*
	 *计量单位
	 */
	private java.lang.String meteringDept;
	/*
	 *计量单位显示字段
	 */
	private java.lang.String meteringDeptAlias;

	@FieldRemark(column = "is_scene_metering", field = "isSceneMetering", name = "是否现场计量")
	/*
	 *是否现场计量
	 */
	private java.lang.String isSceneMetering;

	@FieldRemark(column = "last_maintain_date", field = "lastMaintainDate", name = "上次保养日期")
	/*
	 *上次保养日期
	 */
	private java.util.Date lastMaintainDate;
	/*
	 *上次保养日期开始时间
	 */
	private java.util.Date lastMaintainDateBegin;
	/*
	 *上次保养日期截止时间
	 */
	private java.util.Date lastMaintainDateEnd;

	@FieldRemark(column = "last_accuracy_check_date", field = "lastAccuracyCheckDate", name = "上次精度检查日期")
	/*
	 *上次精度检查日期
	 */
	private java.util.Date lastAccuracyCheckDate;
	/*
	 *上次精度检查日期开始时间
	 */
	private java.util.Date lastAccuracyCheckDateBegin;
	/*
	 *上次精度检查日期截止时间
	 */
	private java.util.Date lastAccuracyCheckDateEnd;

	@FieldRemark(column = "metering_conclution", field = "meteringConclution", name = "计量结论")
	/*
	 *计量结论
	 */
	private java.lang.String meteringConclution;

	@FieldRemark(column = "total_borrow", field = "totalBorrow", name = "累计借用天数")
	/*
	 *累计借用天数
	 */
	private Long totalBorrow;

	@FieldRemark(column = "safe_info", field = "safeInfo", name = "安全信息")
	/*
	 *安全信息
	 */
	private java.lang.String safeInfo;

	@FieldRemark(column = "use_cost", field = "useCost", name = "设备使用费")
	/*
	 *设备使用费
	 */
	private java.math.BigDecimal useCost;

	@FieldRemark(column = "repair_dept", field = "repairDept", name = "维修部门")
	/*
	 *维修部门
	 */
	private java.lang.String repairDept;
	/*
	 *维修部门显示字段
	 */
	private java.lang.String repairDeptAlias;

	@FieldRemark(column = "state_change_date", field = "stateChangeDate", name = "状态变动日期")
	/*
	 *状态变动日期
	 */
	private java.util.Date stateChangeDate;
	/*
	 *状态变动日期开始时间
	 */
	private java.util.Date stateChangeDateBegin;
	/*
	 *状态变动日期截止时间
	 */
	private java.util.Date stateChangeDateEnd;

	@FieldRemark(column = "device_sys_name", field = "deviceSysName", name = "设备系统名称")
	/*
	 *设备系统名称
	 */
	private java.lang.String deviceSysName;

	@FieldRemark(column = "device_attribute", field = "deviceAttribute", name = "专项设备属性")
	/*
	 *专项设备属性
	 */
	private java.lang.String deviceAttribute;

	@FieldRemark(column = "device_related_man", field = "deviceRelatedMan", name = "设备关联人员")
	/*
	 *设备关联人员
	 */
	private java.lang.String deviceRelatedMan;
	/*
	 *设备关联人员显示字段
	 */
	private java.lang.String deviceRelatedManAlias;

	@FieldRemark(column = "is_lab_device", field = "isLabDevice", name = "是否实验室设备")
	/*
	 *是否实验室设备
	 */
	private java.lang.String isLabDevice;

	@FieldRemark(column = "is_fixed_assets", field = "isFixedAssets", name = "是否固定资产")
	/*
	 *是否固定资产
	 */
	private java.lang.String isFixedAssets;

	@FieldRemark(column = "assets_finance_type", field = "assetsFinanceType", name = "资产财务类别")
	/*
	 *资产财务类别
	 */
	private java.lang.String assetsFinanceType;

	@FieldRemark(column = "assets_source", field = "assetsSource", name = "资产来源")
	/*
	 *资产来源
	 */
	private java.lang.String assetsSource;

	@FieldRemark(column = "assets_finance_state", field = "assetsFinanceState", name = "资产财务状态")
	/*
	 *资产财务状态
	 */
	private java.lang.String assetsFinanceState;

	@FieldRemark(column = "finance_entry_date", field = "financeEntryDate", name = "财务入账时间")
	/*
	 *财务入账时间
	 */
	private java.util.Date financeEntryDate;
	/*
	 *财务入账时间开始时间
	 */
	private java.util.Date financeEntryDateBegin;
	/*
	 *财务入账时间截止时间
	 */
	private java.util.Date financeEntryDateEnd;

	@FieldRemark(column = "original_value", field = "originalValue", name = "原值")
	/*
	 *原值
	 */
	private java.math.BigDecimal originalValue;

	@FieldRemark(column = "total_depreciation", field = "totalDepreciation", name = "累计折旧")
	/*
	 *累计折旧
	 */
	private java.math.BigDecimal totalDepreciation;

	@FieldRemark(column = "depreciation_method", field = "depreciationMethod", name = "折旧方法")
	/*
	 *折旧方法
	 */
	private java.lang.String depreciationMethod;

	@FieldRemark(column = "depreciation_year", field = "depreciationYear", name = "折旧年限")
	/*
	 *折旧年限
	 */
	private java.math.BigDecimal depreciationYear;

	@FieldRemark(column = "net_salvage_rate", field = "netSalvageRate", name = "净残值率")
	/*
	 *净残值率
	 */
	private java.math.BigDecimal netSalvageRate;

	@FieldRemark(column = "net_salvage", field = "netSalvage", name = "净残值")
	/*
	 *净残值
	 */
	private java.math.BigDecimal netSalvage;

	@FieldRemark(column = "month_depreciation_rate", field = "monthDepreciationRate", name = "月折旧率")
	/*
	 *月折旧率
	 */
	private java.math.BigDecimal monthDepreciationRate;

	@FieldRemark(column = "month_depreciation", field = "monthDepreciation", name = "月折旧额")
	/*
	 *月折旧额
	 */
	private java.math.BigDecimal monthDepreciation;

	@FieldRemark(column = "year_depreciation_rate", field = "yearDepreciationRate", name = "年折旧率")
	/*
	 *年折旧率
	 */
	private java.math.BigDecimal yearDepreciationRate;

	@FieldRemark(column = "year_depreciation", field = "yearDepreciation", name = "年折旧额")
	/*
	 *年折旧额
	 */
	private java.math.BigDecimal yearDepreciation;

	@FieldRemark(column = "net_value", field = "netValue", name = "净值")
	/*
	 *净值
	 */
	private java.math.BigDecimal netValue;

	@FieldRemark(column = "month_count", field = "monthCount", name = "已提月份")
	/*
	 *已提月份
	 */
	private Long monthCount;

	@FieldRemark(column = "month_remain", field = "monthRemain", name = "未计提月份")
	/*
	 *未计提月份
	 */
	private Long monthRemain;

	@FieldRemark(column = "institute_or_company", field = "instituteOrCompany", name = "研究所/公司")
	/*
	 *研究所/公司
	 */
	private java.lang.String instituteOrCompany;

	@FieldRemark(column = "index_info", field = "indexInfo", name = "指标信息")
	/*
	 *指标信息
	 */
	private java.lang.String indexInfo;

	@FieldRemark(column = "", field = "isNeedCertificate", name = "是否需要操作证")
	/*
	 *是否需要操作证
	 */
	private java.lang.String isNeedCertificate;

	@FieldRemark(column = "is_trans_fixed", field = "isTransFixed", name = "是否转固")
	/*
	 *是否转固
	 */
	private java.lang.String isTransFixed;

	@FieldRemark(column = "metering_outer", field = "meteringOuter", name = "计量外送员")
	/*
	 *计量外送员
	 */
	private java.lang.String meteringOuter;
	/*
	 *计量外送员显示字段
	 */
	private java.lang.String meteringOuterAlias;

	@FieldRemark(column = "apply_model", field = "applyModel", name = "适用机型")
	/*
	 *适用机型
	 */
	private java.lang.String applyModel;

	@FieldRemark(column = "apply_product", field = "applyProduct", name = "适用产品")
	/*
	 *适用产品
	 */
	private java.lang.String applyProduct;

	@FieldRemark(column = "tested_object", field = "testedObject", name = "受测对象")
	/*
	 *受测对象
	 */
	private java.lang.String testedObject;

	@FieldRemark(column = "major_type", field = "majorType", name = "专业类别")
	/*
	 *专业类别
	 */
	private java.lang.String majorType;

	@FieldRemark(column = "device_nature", field = "deviceNature", name = "设备性质")
	/*
	 *设备性质
	 */
	private java.lang.String deviceNature;

	@FieldRemark(column = "software_num", field = "softwareNum", name = "软件标识号")
	/*
	 *软件标识号
	 */
	private java.lang.String softwareNum;

	@FieldRemark(column = "software_designer", field = "softwareDesigner", name = "软件设计人员")
	/*
	 *软件设计人员
	 */
	private java.lang.String softwareDesigner;
	/*
	 *软件设计人员显示字段
	 */
	private java.lang.String softwareDesignerAlias;

	@FieldRemark(column = "hardware_designer", field = "hardwareDesigner", name = "硬件设计人员")
	/*
	 *硬件设计人员
	 */
	private java.lang.String hardwareDesigner;
	/*
	 *硬件设计人员显示字段
	 */
	private java.lang.String hardwareDesignerAlias;

	@FieldRemark(column = "is_test_device", field = "isTestDevice", name = "是否测试设备")
	/*
	 *是否测试设备
	 */
	private java.lang.String isTestDevice;

	@FieldRemark(column = "proof_num", field = "proofNum", name = "凭证编号")
	/*
	 *凭证编号
	 */
	private java.lang.String proofNum;


	/*子表虚拟字段-begin*/
	@FieldRemark(column = "t_ComponentName", field = "tComponentName", name = "测试设备组件名称")
	/*
	 *测试设备组件名称
	 */
	private java.lang.String tComponentName;

	public String gettComponentName() {
		return tComponentName;
	}

	public void settComponentName(String tComponentName) {
		this.tComponentName = tComponentName;
	}


	@FieldRemark(column = "t_SoftwareName", field = "tSoftwareName", name = "测试设备软件名称")
	/*
	 *测试设备软件名称
	 */
	private java.lang.String tSoftwareName;

	public String gettSoftwareName() {
		return tSoftwareName;
	}

	public void settSoftwareName(String tSoftwareName) {
		this.tSoftwareName = tSoftwareName;
	}
	/*子表虚拟字段-end*/

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

	@FieldRemark(column = "guarantee_period", field = "guaranteePeriod", name = "质保期")
	/*
	 *质保期
	 */
	private java.math.BigDecimal guaranteePeriod;

	@FieldRemark(column = "guarantee_date", field = "guaranteeDate", name = "质保截止日期")
	/*
	 *质保截止日期
	 */
	private java.util.Date guaranteeDate;

	/*
	 *质保截止日期开始时间
	 */
	private java.util.Date guaranteeDateBegin;
	/*
	 *质保截止日期截止时间
	 */
	private java.util.Date guaranteeDateEnd;

	@FieldRemark(column = "is_abandon", field = "isAbandon", name = "是否报废")
	/*
	 *是否报废
	 */
	private java.lang.String isAbandon;

	public String getIsAbandon() { return isAbandon; }

	public void setIsAbandon(String isAbandon) { this.isAbandon = isAbandon; }

	public BigDecimal getGuaranteePeriod() {
		return guaranteePeriod;
	}

	public void setGuaranteePeriod(BigDecimal guaranteePeriod) {
		this.guaranteePeriod = guaranteePeriod;
	}

	public Date getGuaranteeDate() {
		return guaranteeDate;
	}

	public void setGuaranteeDate(Date guaranteeDate) {
		this.guaranteeDate = guaranteeDate;
	}

	public Date getGuaranteeDateBegin() {
		return guaranteeDateBegin;
	}

	public void setGuaranteeDateBegin(Date guaranteeDateBegin) {
		this.guaranteeDateBegin = guaranteeDateBegin;
	}

	public Date getGuaranteeDateEnd() {
		return guaranteeDateEnd;
	}

	public void setGuaranteeDateEnd(Date guaranteeDateEnd) {
		this.guaranteeDateEnd = guaranteeDateEnd;
	}

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

	public java.lang.String getAssetId() {
		return assetId;
	}

	public void setAssetId(java.lang.String assetId) {
		this.assetId = assetId;
	}

	public java.lang.String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(java.lang.String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public java.lang.String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(java.lang.String deviceCategory) {
		this.deviceCategory = deviceCategory;
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

	public java.lang.String getUserId() {
		return userId;
	}

	public void setUserId(java.lang.String userId) {
		this.userId = userId;
	}

	public java.lang.String getUserIdAlias() {
		return userIdAlias;
	}

	public void setUserIdAlias(java.lang.String userIdAlias) {
		this.userIdAlias = userIdAlias;
	}

	public java.lang.String getUserDept() {
		return userDept;
	}

	public void setUserDept(java.lang.String userDept) {
		this.userDept = userDept;
	}

	public java.lang.String getUserDeptAlias() {
		return userDeptAlias;
	}

	public void setUserDeptAlias(java.lang.String userDeptAlias) {
		this.userDeptAlias = userDeptAlias;
	}

	public java.lang.String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(java.lang.String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public java.util.Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(java.util.Date createdDate) {
		this.createdDate = createdDate;
	}

	public java.util.Date getCreatedDateBegin() {
		return createdDateBegin;
	}

	public void setCreatedDateBegin(java.util.Date createdDateBegin) {
		this.createdDateBegin = createdDateBegin;
	}

	public java.util.Date getCreatedDateEnd() {
		return createdDateEnd;
	}

	public void setCreatedDateEnd(java.util.Date createdDateEnd) {
		this.createdDateEnd = createdDateEnd;
	}

	public java.lang.String getIsManage() {
		return isManage;
	}

	public void setIsManage(java.lang.String isManage) {
		this.isManage = isManage;
	}

	public java.lang.String getIsInWorkflow() {
		return isInWorkflow;
	}

	public void setIsInWorkflow(java.lang.String isInWorkflow) {
		this.isInWorkflow = isInWorkflow;
	}

	public java.lang.String getManageState() {
		return manageState;
	}

	public void setManageState(java.lang.String manageState) {
		this.manageState = manageState;
	}

	public java.lang.String getDeviceState() {
		return deviceState;
	}

	public void setDeviceState(java.lang.String deviceState) {
		this.deviceState = deviceState;
	}

	public java.lang.String getParentId() {
		return parentId;
	}

	public void setParentId(java.lang.String parentId) {
		this.parentId = parentId;
	}

	public java.lang.String getParentName() {
		return parentName;
	}

	public void setParentName(java.lang.String parentName) {
		this.parentName = parentName;
	}

	public java.lang.String getCommonName() {
		return commonName;
	}

	public void setCommonName(java.lang.String commonName) {
		this.commonName = commonName;
	}

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
	}

	public java.lang.String getAbcCategory() {
		return abcCategory;
	}

	public void setAbcCategory(java.lang.String abcCategory) {
		this.abcCategory = abcCategory;
	}

	public java.lang.String getIsKeyDevice() {
		return isKeyDevice;
	}

	public void setIsKeyDevice(java.lang.String isKeyDevice) {
		this.isKeyDevice = isKeyDevice;
	}

	public java.lang.String getIsResearch() {
		return isResearch;
	}

	public void setIsResearch(java.lang.String isResearch) {
		this.isResearch = isResearch;
	}

	public java.lang.String getProductCountry() {
		return productCountry;
	}

	public void setProductCountry(java.lang.String productCountry) {
		this.productCountry = productCountry;
	}

	public java.lang.String getProductFactory() {
		return productFactory;
	}

	public void setProductFactory(java.lang.String productFactory) {
		this.productFactory = productFactory;
	}

	public java.lang.String getSupplier() {
		return supplier;
	}

	public void setSupplier(java.lang.String supplier) {
		this.supplier = supplier;
	}

	public java.util.Date getProductDate() {
		return productDate;
	}

	public void setProductDate(java.util.Date productDate) {
		this.productDate = productDate;
	}

	public java.util.Date getProductDateBegin() {
		return productDateBegin;
	}

	public void setProductDateBegin(java.util.Date productDateBegin) {
		this.productDateBegin = productDateBegin;
	}

	public java.util.Date getProductDateEnd() {
		return productDateEnd;
	}

	public void setProductDateEnd(java.util.Date productDateEnd) {
		this.productDateEnd = productDateEnd;
	}

	public java.lang.String getProductNum() {
		return productNum;
	}

	public void setProductNum(java.lang.String productNum) {
		this.productNum = productNum;
	}

	public java.lang.String getDevicePower() {
		return devicePower;
	}

	public void setDevicePower(java.lang.String devicePower) {
		this.devicePower = devicePower;
	}

	public java.lang.String getDeviceWeight() {
		return deviceWeight;
	}

	public void setDeviceWeight(java.lang.String deviceWeight) {
		this.deviceWeight = deviceWeight;
	}

	public java.lang.String getDeviceSize() {
		return deviceSize;
	}

	public void setDeviceSize(java.lang.String deviceSize) {
		this.deviceSize = deviceSize;
	}

	public java.util.Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(java.util.Date checkDate) {
		this.checkDate = checkDate;
	}

	public java.util.Date getCheckDateBegin() {
		return checkDateBegin;
	}

	public void setCheckDateBegin(java.util.Date checkDateBegin) {
		this.checkDateBegin = checkDateBegin;
	}

	public java.util.Date getCheckDateEnd() {
		return checkDateEnd;
	}

	public void setCheckDateEnd(java.util.Date checkDateEnd) {
		this.checkDateEnd = checkDateEnd;
	}

	public java.lang.String getImproveProject() {
		return improveProject;
	}

	public void setImproveProject(java.lang.String improveProject) {
		this.improveProject = improveProject;
	}

	public java.math.BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(java.math.BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public java.lang.String getContractNum() {
		return contractNum;
	}

	public void setContractNum(java.lang.String contractNum) {
		this.contractNum = contractNum;
	}

	public java.lang.String getApplyNum() {
		return applyNum;
	}

	public void setApplyNum(java.lang.String applyNum) {
		this.applyNum = applyNum;
	}

	public java.lang.String getCheckNum() {
		return checkNum;
	}

	public void setCheckNum(java.lang.String checkNum) {
		this.checkNum = checkNum;
	}

	public java.lang.String getCarFrameNum() {
		return carFrameNum;
	}

	public void setCarFrameNum(java.lang.String carFrameNum) {
		this.carFrameNum = carFrameNum;
	}

	public java.lang.String getEngineNum() {
		return engineNum;
	}

	public void setEngineNum(java.lang.String engineNum) {
		this.engineNum = engineNum;
	}

	public java.lang.String getCarNum() {
		return carNum;
	}

	public void setCarNum(java.lang.String carNum) {
		this.carNum = carNum;
	}

	public java.lang.String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(java.lang.String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public java.lang.String getIsMetering() {
		return isMetering;
	}

	public void setIsMetering(java.lang.String isMetering) {
		this.isMetering = isMetering;
	}

	public java.lang.String getIsMaintain() {
		return isMaintain;
	}

	public void setIsMaintain(java.lang.String isMaintain) {
		this.isMaintain = isMaintain;
	}

	public java.lang.String getIsAccuracyCheck() {
		return isAccuracyCheck;
	}

	public void setIsAccuracyCheck(java.lang.String isAccuracyCheck) {
		this.isAccuracyCheck = isAccuracyCheck;
	}

	public java.lang.String getIsRegularCheck() {
		return isRegularCheck;
	}

	public void setIsRegularCheck(java.lang.String isRegularCheck) {
		this.isRegularCheck = isRegularCheck;
	}

	public java.lang.String getIsSpotCheck() {
		return isSpotCheck;
	}

	public void setIsSpotCheck(java.lang.String isSpotCheck) {
		this.isSpotCheck = isSpotCheck;
	}

	public java.lang.String getIsSpecialDevice() {
		return isSpecialDevice;
	}

	public void setIsSpecialDevice(java.lang.String isSpecialDevice) {
		this.isSpecialDevice = isSpecialDevice;
	}

	public java.lang.String getIsSafetyProduction() {
		return isSafetyProduction;
	}

	public void setIsSafetyProduction(java.lang.String isSafetyProduction) {
		this.isSafetyProduction = isSafetyProduction;
	}

	public java.lang.String getIsNeedInstall() {
		return isNeedInstall;
	}

	public void setIsNeedInstall(java.lang.String isNeedInstall) {
		this.isNeedInstall = isNeedInstall;
	}

	public java.lang.String getIsPc() {
		return isPc;
	}

	public void setIsPc(java.lang.String isPc) {
		this.isPc = isPc;
	}

	public java.lang.String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(java.lang.String deviceType) {
		this.deviceType = deviceType;
	}

	public java.util.Date getEnableDate() {
		return enableDate;
	}

	public void setEnableDate(java.util.Date enableDate) {
		this.enableDate = enableDate;
	}

	public java.util.Date getEnableDateBegin() {
		return enableDateBegin;
	}

	public void setEnableDateBegin(java.util.Date enableDateBegin) {
		this.enableDateBegin = enableDateBegin;
	}

	public java.util.Date getEnableDateEnd() {
		return enableDateEnd;
	}

	public void setEnableDateEnd(java.util.Date enableDateEnd) {
		this.enableDateEnd = enableDateEnd;
	}

	public Long getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(Long runningTime) {
		this.runningTime = runningTime;
	}

	public java.lang.String getIp() {
		return ip;
	}

	public void setIp(java.lang.String ip) {
		this.ip = ip;
	}

	public java.lang.String getMac() {
		return mac;
	}

	public void setMac(java.lang.String mac) {
		this.mac = mac;
	}

	public java.lang.String getDiskNum() {
		return diskNum;
	}

	public void setDiskNum(java.lang.String diskNum) {
		this.diskNum = diskNum;
	}

	public java.lang.String getOs() {
		return os;
	}

	public void setOs(java.lang.String os) {
		this.os = os;
	}

	public java.util.Date getOsInstallDate() {
		return osInstallDate;
	}

	public void setOsInstallDate(java.util.Date osInstallDate) {
		this.osInstallDate = osInstallDate;
	}

	public java.util.Date getOsInstallDateBegin() {
		return osInstallDateBegin;
	}

	public void setOsInstallDateBegin(java.util.Date osInstallDateBegin) {
		this.osInstallDateBegin = osInstallDateBegin;
	}

	public java.util.Date getOsInstallDateEnd() {
		return osInstallDateEnd;
	}

	public void setOsInstallDateEnd(java.util.Date osInstallDateEnd) {
		this.osInstallDateEnd = osInstallDateEnd;
	}

	public java.lang.String getMeteringId() {
		return meteringId;
	}

	public void setMeteringId(java.lang.String meteringId) {
		this.meteringId = meteringId;
	}

	public java.lang.String getMeterman() {
		return meterman;
	}

	public void setMeterman(java.lang.String meterman) {
		this.meterman = meterman;
	}

	public java.lang.String getMetermanAlias() {
		return metermanAlias;
	}

	public void setMetermanAlias(java.lang.String metermanAlias) {
		this.metermanAlias = metermanAlias;
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

	public java.util.Date getNextMeteringDate() {
		return nextMeteringDate;
	}

	public void setNextMeteringDate(java.util.Date nextMeteringDate) {
		this.nextMeteringDate = nextMeteringDate;
	}

	public java.util.Date getNextMeteringDateBegin() {
		return nextMeteringDateBegin;
	}

	public void setNextMeteringDateBegin(java.util.Date nextMeteringDateBegin) {
		this.nextMeteringDateBegin = nextMeteringDateBegin;
	}

	public java.util.Date getNextMeteringDateEnd() {
		return nextMeteringDateEnd;
	}

	public void setNextMeteringDateEnd(java.util.Date nextMeteringDateEnd) {
		this.nextMeteringDateEnd = nextMeteringDateEnd;
	}

	public java.lang.String getPlanMeterman() {
		return planMeterman;
	}

	public void setPlanMeterman(java.lang.String planMeterman) {
		this.planMeterman = planMeterman;
	}

	public java.lang.String getPlanMetermanAlias() {
		return planMetermanAlias;
	}

	public void setPlanMetermanAlias(java.lang.String planMetermanAlias) {
		this.planMetermanAlias = planMetermanAlias;
	}

	public java.lang.String getMeteringDept() {
		return meteringDept;
	}

	public void setMeteringDept(java.lang.String meteringDept) {
		this.meteringDept = meteringDept;
	}

	public java.lang.String getMeteringDeptAlias() {
		return meteringDeptAlias;
	}

	public void setMeteringDeptAlias(java.lang.String meteringDeptAlias) {
		this.meteringDeptAlias = meteringDeptAlias;
	}

	public java.lang.String getIsSceneMetering() {
		return isSceneMetering;
	}

	public void setIsSceneMetering(java.lang.String isSceneMetering) {
		this.isSceneMetering = isSceneMetering;
	}

	public java.util.Date getLastMaintainDate() {
		return lastMaintainDate;
	}

	public void setLastMaintainDate(java.util.Date lastMaintainDate) {
		this.lastMaintainDate = lastMaintainDate;
	}

	public java.util.Date getLastMaintainDateBegin() {
		return lastMaintainDateBegin;
	}

	public void setLastMaintainDateBegin(java.util.Date lastMaintainDateBegin) {
		this.lastMaintainDateBegin = lastMaintainDateBegin;
	}

	public java.util.Date getLastMaintainDateEnd() {
		return lastMaintainDateEnd;
	}

	public void setLastMaintainDateEnd(java.util.Date lastMaintainDateEnd) {
		this.lastMaintainDateEnd = lastMaintainDateEnd;
	}

	public java.util.Date getLastAccuracyCheckDate() {
		return lastAccuracyCheckDate;
	}

	public void setLastAccuracyCheckDate(java.util.Date lastAccuracyCheckDate) {
		this.lastAccuracyCheckDate = lastAccuracyCheckDate;
	}

	public java.util.Date getLastAccuracyCheckDateBegin() {
		return lastAccuracyCheckDateBegin;
	}

	public void setLastAccuracyCheckDateBegin(java.util.Date lastAccuracyCheckDateBegin) {
		this.lastAccuracyCheckDateBegin = lastAccuracyCheckDateBegin;
	}

	public java.util.Date getLastAccuracyCheckDateEnd() {
		return lastAccuracyCheckDateEnd;
	}

	public void setLastAccuracyCheckDateEnd(java.util.Date lastAccuracyCheckDateEnd) {
		this.lastAccuracyCheckDateEnd = lastAccuracyCheckDateEnd;
	}

	public java.lang.String getMeteringConclution() {
		return meteringConclution;
	}

	public void setMeteringConclution(java.lang.String meteringConclution) {
		this.meteringConclution = meteringConclution;
	}

	public Long getTotalBorrow() {
		return totalBorrow;
	}

	public void setTotalBorrow(Long totalBorrow) {
		this.totalBorrow = totalBorrow;
	}

	public java.lang.String getSafeInfo() {
		return safeInfo;
	}

	public void setSafeInfo(java.lang.String safeInfo) {
		this.safeInfo = safeInfo;
	}

	public java.math.BigDecimal getUseCost() {
		return useCost;
	}

	public void setUseCost(java.math.BigDecimal useCost) {
		this.useCost = useCost;
	}

	public java.lang.String getRepairDept() {
		return repairDept;
	}

	public void setRepairDept(java.lang.String repairDept) {
		this.repairDept = repairDept;
	}

	public java.lang.String getRepairDeptAlias() {
		return repairDeptAlias;
	}

	public void setRepairDeptAlias(java.lang.String repairDeptAlias) {
		this.repairDeptAlias = repairDeptAlias;
	}

	public java.util.Date getStateChangeDate() {
		return stateChangeDate;
	}

	public void setStateChangeDate(java.util.Date stateChangeDate) {
		this.stateChangeDate = stateChangeDate;
	}

	public java.util.Date getStateChangeDateBegin() {
		return stateChangeDateBegin;
	}

	public void setStateChangeDateBegin(java.util.Date stateChangeDateBegin) {
		this.stateChangeDateBegin = stateChangeDateBegin;
	}

	public java.util.Date getStateChangeDateEnd() {
		return stateChangeDateEnd;
	}

	public void setStateChangeDateEnd(java.util.Date stateChangeDateEnd) {
		this.stateChangeDateEnd = stateChangeDateEnd;
	}

	public java.lang.String getDeviceSysName() {
		return deviceSysName;
	}

	public void setDeviceSysName(java.lang.String deviceSysName) {
		this.deviceSysName = deviceSysName;
	}

	public java.lang.String getDeviceAttribute() {
		return deviceAttribute;
	}

	public void setDeviceAttribute(java.lang.String deviceAttribute) {
		this.deviceAttribute = deviceAttribute;
	}

	public java.lang.String getDeviceRelatedMan() {
		return deviceRelatedMan;
	}

	public void setDeviceRelatedMan(java.lang.String deviceRelatedMan) {
		this.deviceRelatedMan = deviceRelatedMan;
	}

	public java.lang.String getDeviceRelatedManAlias() {
		return deviceRelatedManAlias;
	}

	public void setDeviceRelatedManAlias(java.lang.String deviceRelatedManAlias) {
		this.deviceRelatedManAlias = deviceRelatedManAlias;
	}

	public java.lang.String getIsLabDevice() {
		return isLabDevice;
	}

	public void setIsLabDevice(java.lang.String isLabDevice) {
		this.isLabDevice = isLabDevice;
	}

	public java.lang.String getIsFixedAssets() {
		return isFixedAssets;
	}

	public void setIsFixedAssets(java.lang.String isFixedAssets) {
		this.isFixedAssets = isFixedAssets;
	}

	public java.lang.String getAssetsFinanceType() {
		return assetsFinanceType;
	}

	public void setAssetsFinanceType(java.lang.String assetsFinanceType) {
		this.assetsFinanceType = assetsFinanceType;
	}

	public java.lang.String getAssetsSource() {
		return assetsSource;
	}

	public void setAssetsSource(java.lang.String assetsSource) {
		this.assetsSource = assetsSource;
	}

	public java.lang.String getAssetsFinanceState() {
		return assetsFinanceState;
	}

	public void setAssetsFinanceState(java.lang.String assetsFinanceState) {
		this.assetsFinanceState = assetsFinanceState;
	}

	public java.util.Date getFinanceEntryDate() {
		return financeEntryDate;
	}

	public void setFinanceEntryDate(java.util.Date financeEntryDate) {
		this.financeEntryDate = financeEntryDate;
	}

	public java.util.Date getFinanceEntryDateBegin() {
		return financeEntryDateBegin;
	}

	public void setFinanceEntryDateBegin(java.util.Date financeEntryDateBegin) {
		this.financeEntryDateBegin = financeEntryDateBegin;
	}

	public java.util.Date getFinanceEntryDateEnd() {
		return financeEntryDateEnd;
	}

	public void setFinanceEntryDateEnd(java.util.Date financeEntryDateEnd) {
		this.financeEntryDateEnd = financeEntryDateEnd;
	}

	public java.math.BigDecimal getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(java.math.BigDecimal originalValue) {
		this.originalValue = originalValue;
	}

	public java.math.BigDecimal getTotalDepreciation() {
		return totalDepreciation;
	}

	public void setTotalDepreciation(java.math.BigDecimal totalDepreciation) {
		this.totalDepreciation = totalDepreciation;
	}

	public java.lang.String getDepreciationMethod() {
		return depreciationMethod;
	}

	public void setDepreciationMethod(java.lang.String depreciationMethod) {
		this.depreciationMethod = depreciationMethod;
	}

	public java.math.BigDecimal getDepreciationYear() {
		return depreciationYear;
	}

	public void setDepreciationYear(java.math.BigDecimal depreciationYear) {
		this.depreciationYear = depreciationYear;
	}

	public java.math.BigDecimal getNetSalvageRate() {
		return netSalvageRate;
	}

	public void setNetSalvageRate(java.math.BigDecimal netSalvageRate) {
		this.netSalvageRate = netSalvageRate;
	}

	public java.math.BigDecimal getNetSalvage() {
		return netSalvage;
	}

	public void setNetSalvage(java.math.BigDecimal netSalvage) {
		this.netSalvage = netSalvage;
	}

	public java.math.BigDecimal getMonthDepreciationRate() {
		return monthDepreciationRate;
	}

	public void setMonthDepreciationRate(java.math.BigDecimal monthDepreciationRate) {
		this.monthDepreciationRate = monthDepreciationRate;
	}

	public java.math.BigDecimal getMonthDepreciation() {
		return monthDepreciation;
	}

	public void setMonthDepreciation(java.math.BigDecimal monthDepreciation) {
		this.monthDepreciation = monthDepreciation;
	}

	public java.math.BigDecimal getYearDepreciationRate() {
		return yearDepreciationRate;
	}

	public void setYearDepreciationRate(java.math.BigDecimal yearDepreciationRate) {
		this.yearDepreciationRate = yearDepreciationRate;
	}

	public java.math.BigDecimal getYearDepreciation() {
		return yearDepreciation;
	}

	public void setYearDepreciation(java.math.BigDecimal yearDepreciation) {
		this.yearDepreciation = yearDepreciation;
	}

	public java.math.BigDecimal getNetValue() {
		return netValue;
	}

	public void setNetValue(java.math.BigDecimal netValue) {
		this.netValue = netValue;
	}

	public Long getMonthCount() {
		return monthCount;
	}

	public void setMonthCount(Long monthCount) {
		this.monthCount = monthCount;
	}

	public Long getMonthRemain() {
		return monthRemain;
	}

	public void setMonthRemain(Long monthRemain) {
		this.monthRemain = monthRemain;
	}

	public java.lang.String getInstituteOrCompany() {
		return instituteOrCompany;
	}

	public void setInstituteOrCompany(java.lang.String instituteOrCompany) {
		this.instituteOrCompany = instituteOrCompany;
	}

	public java.lang.String getIndexInfo() {
		return indexInfo;
	}

	public void setIndexInfo(java.lang.String indexInfo) {
		this.indexInfo = indexInfo;
	}

	public java.lang.String getIsNeedCertificate() {
		return isNeedCertificate;
	}

	public void setIsNeedCertificate(java.lang.String isNeedCertificate) {
		this.isNeedCertificate = isNeedCertificate;
	}

	public java.lang.String getIsTransFixed() {
		return isTransFixed;
	}

	public void setIsTransFixed(java.lang.String isTransFixed) {
		this.isTransFixed = isTransFixed;
	}

	public java.lang.String getMeteringOuter() {
		return meteringOuter;
	}

	public void setMeteringOuter(java.lang.String meteringOuter) {
		this.meteringOuter = meteringOuter;
	}

	public java.lang.String getMeteringOuterAlias() {
		return meteringOuterAlias;
	}

	public void setMeteringOuterAlias(java.lang.String meteringOuterAlias) {
		this.meteringOuterAlias = meteringOuterAlias;
	}

	public java.lang.String getApplyModel() {
		return applyModel;
	}

	public void setApplyModel(java.lang.String applyModel) {
		this.applyModel = applyModel;
	}

	public java.lang.String getApplyProduct() {
		return applyProduct;
	}

	public void setApplyProduct(java.lang.String applyProduct) {
		this.applyProduct = applyProduct;
	}

	public java.lang.String getTestedObject() {
		return testedObject;
	}

	public void setTestedObject(java.lang.String testedObject) {
		this.testedObject = testedObject;
	}

	public java.lang.String getMajorType() {
		return majorType;
	}

	public void setMajorType(java.lang.String majorType) {
		this.majorType = majorType;
	}

	public java.lang.String getDeviceNature() {
		return deviceNature;
	}

	public void setDeviceNature(java.lang.String deviceNature) {
		this.deviceNature = deviceNature;
	}

	public java.lang.String getSoftwareNum() {
		return softwareNum;
	}

	public void setSoftwareNum(java.lang.String softwareNum) {
		this.softwareNum = softwareNum;
	}

	public java.lang.String getSoftwareDesigner() {
		return softwareDesigner;
	}

	public void setSoftwareDesigner(java.lang.String softwareDesigner) {
		this.softwareDesigner = softwareDesigner;
	}

	public java.lang.String getSoftwareDesignerAlias() {
		return softwareDesignerAlias;
	}

	public void setSoftwareDesignerAlias(java.lang.String softwareDesignerAlias) {
		this.softwareDesignerAlias = softwareDesignerAlias;
	}

	public java.lang.String getHardwareDesigner() {
		return hardwareDesigner;
	}

	public void setHardwareDesigner(java.lang.String hardwareDesigner) {
		this.hardwareDesigner = hardwareDesigner;
	}

	public java.lang.String getHardwareDesignerAlias() {
		return hardwareDesignerAlias;
	}

	public void setHardwareDesignerAlias(java.lang.String hardwareDesignerAlias) {
		this.hardwareDesignerAlias = hardwareDesignerAlias;
	}

	public java.lang.String getIsTestDevice() {
		return isTestDevice;
	}

	public void setIsTestDevice(java.lang.String isTestDevice) {
		this.isTestDevice = isTestDevice;
	}

	public java.lang.String getProofNum() {
		return proofNum;
	}

	public void setProofNum(java.lang.String proofNum) {
		this.proofNum = proofNum;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "ASSETS_DEVICE_ACCOUNT";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_DEVICE_ACCOUNT";
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

	@Override
	public String toString() {
		return "AssetsDeviceAccountDTO{" +
				"id='" + id + '\'' +
				", creationDateBegin=" + creationDateBegin +
				", creationDateEnd=" + creationDateEnd +
				", lastUpdateDateBegin=" + lastUpdateDateBegin +
				", lastUpdateDateEnd=" + lastUpdateDateEnd +
				", assetId='" + assetId + '\'' +
				", unifiedId='" + unifiedId + '\'' +
				", deviceCategory='" + deviceCategory + '\'' +
				", deviceName='" + deviceName + '\'' +
				", deviceModel='" + deviceModel + '\'' +
				", deviceSpec='" + deviceSpec + '\'' +
				", ownerId='" + ownerId + '\'' +
				", ownerIdAlias='" + ownerIdAlias + '\'' +
				", ownerDept='" + ownerDept + '\'' +
				", ownerDeptAlias='" + ownerDeptAlias + '\'' +
				", userId='" + userId + '\'' +
				", userIdAlias='" + userIdAlias + '\'' +
				", userDept='" + userDept + '\'' +
				", userDeptAlias='" + userDeptAlias + '\'' +
				", manufacturerId='" + manufacturerId + '\'' +
				", createdDate=" + createdDate +
				", createdDateBegin=" + createdDateBegin +
				", createdDateEnd=" + createdDateEnd +
				", isManage='" + isManage + '\'' +
				", isInWorkflow='" + isInWorkflow + '\'' +
				", manageState='" + manageState + '\'' +
				", deviceState='" + deviceState + '\'' +
				", parentId='" + parentId + '\'' +
				", parentName='" + parentName + '\'' +
				", commonName='" + commonName + '\'' +
				", positionId='" + positionId + '\'' +
				", abcCategory='" + abcCategory + '\'' +
				", isKeyDevice='" + isKeyDevice + '\'' +
				", isResearch='" + isResearch + '\'' +
				", productCountry='" + productCountry + '\'' +
				", productFactory='" + productFactory + '\'' +
				", supplier='" + supplier + '\'' +
				", productDate=" + productDate +
				", productDateBegin=" + productDateBegin +
				", productDateEnd=" + productDateEnd +
				", productNum='" + productNum + '\'' +
				", devicePower='" + devicePower + '\'' +
				", deviceWeight='" + deviceWeight + '\'' +
				", deviceSize='" + deviceSize + '\'' +
				", checkDate=" + checkDate +
				", checkDateBegin=" + checkDateBegin +
				", checkDateEnd=" + checkDateEnd +
				", improveProject='" + improveProject + '\'' +
				", unitPrice=" + unitPrice +
				", contractNum='" + contractNum + '\'' +
				", applyNum='" + applyNum + '\'' +
				", checkNum='" + checkNum + '\'' +
				", carFrameNum='" + carFrameNum + '\'' +
				", engineNum='" + engineNum + '\'' +
				", carNum='" + carNum + '\'' +
				", secretLevel='" + secretLevel + '\'' +
				", isMetering='" + isMetering + '\'' +
				", isMaintain='" + isMaintain + '\'' +
				", isAccuracyCheck='" + isAccuracyCheck + '\'' +
				", isRegularCheck='" + isRegularCheck + '\'' +
				", isSpotCheck='" + isSpotCheck + '\'' +
				", isSpecialDevice='" + isSpecialDevice + '\'' +
				", isSafetyProduction='" + isSafetyProduction + '\'' +
				", isNeedInstall='" + isNeedInstall + '\'' +
				", isPc='" + isPc + '\'' +
				", deviceType='" + deviceType + '\'' +
				", enableDate=" + enableDate +
				", enableDateBegin=" + enableDateBegin +
				", enableDateEnd=" + enableDateEnd +
				", runningTime=" + runningTime +
				", ip='" + ip + '\'' +
				", mac='" + mac + '\'' +
				", diskNum='" + diskNum + '\'' +
				", os='" + os + '\'' +
				", osInstallDate=" + osInstallDate +
				", osInstallDateBegin=" + osInstallDateBegin +
				", osInstallDateEnd=" + osInstallDateEnd +
				", meteringId='" + meteringId + '\'' +
				", meterman='" + meterman + '\'' +
				", metermanAlias='" + metermanAlias + '\'' +
				", meteringDate=" + meteringDate +
				", meteringDateBegin=" + meteringDateBegin +
				", meteringDateEnd=" + meteringDateEnd +
				", meteringCycle=" + meteringCycle +
				", lastMeteringDate=" + lastMeteringDate +
				", lastMeteringDateBegin=" + lastMeteringDateBegin +
				", lastMeteringDateEnd=" + lastMeteringDateEnd +
				", nextMeteringDate=" + nextMeteringDate +
				", nextMeteringDateBegin=" + nextMeteringDateBegin +
				", nextMeteringDateEnd=" + nextMeteringDateEnd +
				", planMeterman='" + planMeterman + '\'' +
				", planMetermanAlias='" + planMetermanAlias + '\'' +
				", meteringDept='" + meteringDept + '\'' +
				", meteringDeptAlias='" + meteringDeptAlias + '\'' +
				", isSceneMetering='" + isSceneMetering + '\'' +
				", lastMaintainDate=" + lastMaintainDate +
				", lastMaintainDateBegin=" + lastMaintainDateBegin +
				", lastMaintainDateEnd=" + lastMaintainDateEnd +
				", lastAccuracyCheckDate=" + lastAccuracyCheckDate +
				", lastAccuracyCheckDateBegin=" + lastAccuracyCheckDateBegin +
				", lastAccuracyCheckDateEnd=" + lastAccuracyCheckDateEnd +
				", meteringConclution='" + meteringConclution + '\'' +
				", totalBorrow=" + totalBorrow +
				", safeInfo='" + safeInfo + '\'' +
				", useCost=" + useCost +
				", repairDept='" + repairDept + '\'' +
				", repairDeptAlias='" + repairDeptAlias + '\'' +
				", stateChangeDate=" + stateChangeDate +
				", stateChangeDateBegin=" + stateChangeDateBegin +
				", stateChangeDateEnd=" + stateChangeDateEnd +
				", deviceSysName='" + deviceSysName + '\'' +
				", deviceAttribute='" + deviceAttribute + '\'' +
				", deviceRelatedMan='" + deviceRelatedMan + '\'' +
				", deviceRelatedManAlias='" + deviceRelatedManAlias + '\'' +
				", isLabDevice='" + isLabDevice + '\'' +
				", isFixedAssets='" + isFixedAssets + '\'' +
				", assetsFinanceType='" + assetsFinanceType + '\'' +
				", assetsSource='" + assetsSource + '\'' +
				", assetsFinanceState='" + assetsFinanceState + '\'' +
				", financeEntryDate=" + financeEntryDate +
				", financeEntryDateBegin=" + financeEntryDateBegin +
				", financeEntryDateEnd=" + financeEntryDateEnd +
				", originalValue=" + originalValue +
				", totalDepreciation=" + totalDepreciation +
				", depreciationMethod='" + depreciationMethod + '\'' +
				", depreciationYear=" + depreciationYear +
				", netSalvageRate=" + netSalvageRate +
				", netSalvage=" + netSalvage +
				", monthDepreciationRate=" + monthDepreciationRate +
				", monthDepreciation=" + monthDepreciation +
				", yearDepreciationRate=" + yearDepreciationRate +
				", yearDepreciation=" + yearDepreciation +
				", netValue=" + netValue +
				", monthCount=" + monthCount +
				", monthRemain=" + monthRemain +
				", instituteOrCompany='" + instituteOrCompany + '\'' +
				", indexInfo='" + indexInfo + '\'' +
				", isNeedCertificate='" + isNeedCertificate + '\'' +
				", isTransFixed='" + isTransFixed + '\'' +
				", meteringOuter='" + meteringOuter + '\'' +
				", meteringOuterAlias='" + meteringOuterAlias + '\'' +
				", applyModel='" + applyModel + '\'' +
				", applyProduct='" + applyProduct + '\'' +
				", testedObject='" + testedObject + '\'' +
				", majorType='" + majorType + '\'' +
				", deviceNature='" + deviceNature + '\'' +
				", softwareNum='" + softwareNum + '\'' +
				", softwareDesigner='" + softwareDesigner + '\'' +
				", softwareDesignerAlias='" + softwareDesignerAlias + '\'' +
				", hardwareDesigner='" + hardwareDesigner + '\'' +
				", hardwareDesignerAlias='" + hardwareDesignerAlias + '\'' +
				", isTestDevice='" + isTestDevice + '\'' +
				", proofNum='" + proofNum + '\'' +
				", tComponentName='" + tComponentName + '\'' +
				", tSoftwareName='" + tSoftwareName + '\'' +
				", attribute01='" + attribute01 + '\'' +
				", attribute02='" + attribute02 + '\'' +
				", attribute03='" + attribute03 + '\'' +
				", attribute04='" + attribute04 + '\'' +
				", attribute05='" + attribute05 + '\'' +
				", attribute06='" + attribute06 + '\'' +
				", attribute07='" + attribute07 + '\'' +
				", attribute08='" + attribute08 + '\'' +
				", attribute09='" + attribute09 + '\'' +
				", attribute10='" + attribute10 + '\'' +
				", attribute11='" + attribute11 + '\'' +
				", attribute12='" + attribute12 + '\'' +
				", attribute13='" + attribute13 + '\'' +
				", attribute14='" + attribute14 + '\'' +
				", attribute15='" + attribute15 + '\'' +
				", attribute16=" + attribute16 +
				", attribute17=" + attribute17 +
				", attribute18=" + attribute18 +
				", attribute19=" + attribute19 +
				", attribute20=" + attribute20 +
				", attribute21=" + attribute21 +
				", attribute22=" + attribute22 +
				", attribute23=" + attribute23 +
				", attribute24=" + attribute24 +
				", attribute25=" + attribute25 +
				", attribute26=" + attribute26 +
				", attribute26Begin=" + attribute26Begin +
				", attribute26End=" + attribute26End +
				", attribute27=" + attribute27 +
				", attribute27Begin=" + attribute27Begin +
				", attribute27End=" + attribute27End +
				", attribute28=" + attribute28 +
				", attribute28Begin=" + attribute28Begin +
				", attribute28End=" + attribute28End +
				", attribute29=" + attribute29 +
				", attribute29Begin=" + attribute29Begin +
				", attribute29End=" + attribute29End +
				", attribute30=" + attribute30 +
				", attribute30Begin=" + attribute30Begin +
				", attribute30End=" + attribute30End +
				", guaranteePeriod=" + guaranteePeriod +
				", guaranteeDate=" + guaranteeDate +
				", guaranteeDateBegin=" + guaranteeDateBegin +
				", guaranteeDateEnd=" + guaranteeDateEnd +
				", isAbandon='" + isAbandon + '\'' +
				", createdBy='" + createdBy + '\'' +
				", creationDate=" + creationDate +
				", lastUpdateDate=" + lastUpdateDate +
				", lastUpdatedBy='" + lastUpdatedBy + '\'' +
				", lastUpdateIp='" + lastUpdateIp + '\'' +
				", logFormName='" + logFormName + '\'' +
				", logTitle='" + logTitle + '\'' +
				", logType=" + logType +
				", version=" + version +
				'}';
	}
}