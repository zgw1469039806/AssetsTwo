package avicit.assets.device.dynassetsreconst.dto;

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
 * @创建时间： 2020-09-03 18:52 
 * @类说明：大修改造下发
 * @修改记录： 
 */
@PojoRemark(table = "assets_reconstruction_r", object = "AssetsReconstructionRDTO", name = "大修改造下发")
public class AssetsReconstructionRDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private String id;
	@LogField

	@FieldRemark(column = "reconstruction_id_r", field = "reconstructionIdR", name = "改造申请单号")
	/*
	 *改造申请单号
	 */
	private String reconstructionIdR;

	@FieldRemark(column = "created_by_dept_r", field = "createdByDeptR", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private String createdByDeptR;
	/*
	 *申请人部门显示字段
	 */
	private String createdByDeptRAlias;

	@FieldRemark(column = "form_state_r", field = "formStateR", name = "单据状态")
	/*
	 *单据状态
	 */
	private String formStateR;
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

	@FieldRemark(column = "owner_dept_r", field = "ownerDeptR", name = "责任部门")
	/*
	 *责任部门
	 */
	private String ownerDeptR;
	/*
	 *责任部门显示字段
	 */
	private String ownerDeptRAlias;

	@FieldRemark(column = "owner_id_r", field = "ownerIdR", name = "责任人")
	/*
	 *责任人
	 */
	private String ownerIdR;
	/*
	 *责任人显示字段
	 */
	private String ownerIdRAlias;

	@FieldRemark(column = "owner_tel_r", field = "ownerTelR", name = "责任人联系方式")
	/*
	 *责任人联系方式
	 */
	private String ownerTelR;

	@FieldRemark(column = "device_name_r", field = "deviceNameR", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceNameR;

	@FieldRemark(column = "secret_level_r", field = "secretLevelR", name = "密级")
	/*
	 *密级
	 */
	private String secretLevelR;
	/*
	 *密级显示名称
	 */
	private String secretLevelRName;

	@FieldRemark(column = "unified_id_r", field = "unifiedIdR", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedIdR;

	@FieldRemark(column = "device_model_r", field = "deviceModelR", name = "设备型号")
	/*
	 *设备型号
	 */
	private String deviceModelR;

	@FieldRemark(column = "device_spec_r", field = "deviceSpecR", name = "设备规格")
	/*
	 *设备规格
	 */
	private String deviceSpecR;

	@FieldRemark(column = "manufacturer_id_r", field = "manufacturerIdR", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private String manufacturerIdR;

	@FieldRemark(column = "lika_date_r", field = "likaDateR", name = "立卡时间")
	/*
	 *立卡时间
	 */
	private java.util.Date likaDateR;
	/*
	 *立卡时间开始时间
	 */
	private java.util.Date likaDateRBegin;
	/*
	 *立卡时间截止时间
	 */
	private java.util.Date likaDateREnd;

	@FieldRemark(column = "original_value_r", field = "originalValueR", name = "设备原值")
	/*
	 *设备原值
	 */
	private java.math.BigDecimal originalValueR;

	@FieldRemark(column = "existing_performance_r", field = "existingPerformanceR", name = "现有结构性能指标")
	/*
	 *现有结构性能指标
	 */
	private String existingPerformanceR;

	@FieldRemark(column = "reforming_reason_r", field = "reformingReasonR", name = "改造理由")
	/*
	 *改造理由
	 */
	private String reformingReasonR;

	@FieldRemark(column = "after_performance_r", field = "afterPerformanceR", name = "改造后结构性能指标")
	/*
	 *改造后结构性能指标
	 */
	private String afterPerformanceR;

	@FieldRemark(column = "transform_way_r", field = "transformWayR", name = "改造途径")
	/*
	 *改造途径
	 */
	private String transformWayR;

	@FieldRemark(column = "budget_r", field = "budgetR", name = "经费预算")
	/*
	 *经费预算
	 */
	private String budgetR;

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

	@FieldRemark(column = "net_value_r", field = "netValueR", name = "净值")
	/*
	 *净值
	 */
	private java.math.BigDecimal netValueR;

	@FieldRemark(column = "device_category_r", field = "deviceCategoryR", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategoryR;

	@FieldRemark(column = "created_by_person_r", field = "createdByPersonR", name = "申请人")
	/*
	 *申请人
	 */
	private String createdByPersonR;
	/*
	 *申请人显示字段
	 */
	private String createdByPersonRAlias;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReconstructionIdR() {
		return reconstructionIdR;
	}

	public void setReconstructionIdR(String reconstructionIdR) {
		this.reconstructionIdR = reconstructionIdR;
	}

	public String getCreatedByDeptR() {
		return createdByDeptR;
	}

	public void setCreatedByDeptR(String createdByDeptR) {
		this.createdByDeptR = createdByDeptR;
	}

	public String getCreatedByDeptRAlias() {
		return createdByDeptRAlias;
	}

	public void setCreatedByDeptRAlias(String createdByDeptRAlias) {
		this.createdByDeptRAlias = createdByDeptRAlias;
	}

	public String getFormStateR() {
		return formStateR;
	}

	public void setFormStateR(String formStateR) {
		this.formStateR = formStateR;
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

	public String getOwnerDeptR() {
		return ownerDeptR;
	}

	public void setOwnerDeptR(String ownerDeptR) {
		this.ownerDeptR = ownerDeptR;
	}

	public String getOwnerDeptRAlias() {
		return ownerDeptRAlias;
	}

	public void setOwnerDeptRAlias(String ownerDeptRAlias) {
		this.ownerDeptRAlias = ownerDeptRAlias;
	}

	public String getOwnerIdR() {
		return ownerIdR;
	}

	public void setOwnerIdR(String ownerIdR) {
		this.ownerIdR = ownerIdR;
	}

	public String getOwnerIdRAlias() {
		return ownerIdRAlias;
	}

	public void setOwnerIdRAlias(String ownerIdRAlias) {
		this.ownerIdRAlias = ownerIdRAlias;
	}

	public String getOwnerTelR() {
		return ownerTelR;
	}

	public void setOwnerTelR(String ownerTelR) {
		this.ownerTelR = ownerTelR;
	}

	public String getDeviceNameR() {
		return deviceNameR;
	}

	public void setDeviceNameR(String deviceNameR) {
		this.deviceNameR = deviceNameR;
	}

	public String getSecretLevelR() {
		return secretLevelR;
	}

	public void setSecretLevelR(String secretLevelR) {
		this.secretLevelR = secretLevelR;
	}

	public String getSecretLevelRName() {
		return secretLevelRName;
	}

	public void setSecretLevelRName(String secretLevelRName) {
		this.secretLevelRName = secretLevelRName;
	}

	public String getUnifiedIdR() {
		return unifiedIdR;
	}

	public void setUnifiedIdR(String unifiedIdR) {
		this.unifiedIdR = unifiedIdR;
	}

	public String getDeviceModelR() {
		return deviceModelR;
	}

	public void setDeviceModelR(String deviceModelR) {
		this.deviceModelR = deviceModelR;
	}

	public String getDeviceSpecR() {
		return deviceSpecR;
	}

	public void setDeviceSpecR(String deviceSpecR) {
		this.deviceSpecR = deviceSpecR;
	}

	public String getManufacturerIdR() {
		return manufacturerIdR;
	}

	public void setManufacturerIdR(String manufacturerIdR) {
		this.manufacturerIdR = manufacturerIdR;
	}

	public java.util.Date getLikaDateR() {
		return likaDateR;
	}

	public void setLikaDateR(java.util.Date likaDateR) {
		this.likaDateR = likaDateR;
	}

	public java.util.Date getLikaDateRBegin() {
		return likaDateRBegin;
	}

	public void setLikaDateRBegin(java.util.Date likaDateRBegin) {
		this.likaDateRBegin = likaDateRBegin;
	}

	public java.util.Date getLikaDateREnd() {
		return likaDateREnd;
	}

	public void setLikaDateREnd(java.util.Date likaDateREnd) {
		this.likaDateREnd = likaDateREnd;
	}

	public java.math.BigDecimal getOriginalValueR() {
		return originalValueR;
	}

	public void setOriginalValueR(java.math.BigDecimal originalValueR) {
		this.originalValueR = originalValueR;
	}

	public String getExistingPerformanceR() {
		return existingPerformanceR;
	}

	public void setExistingPerformanceR(String existingPerformanceR) {
		this.existingPerformanceR = existingPerformanceR;
	}

	public String getReformingReasonR() {
		return reformingReasonR;
	}

	public void setReformingReasonR(String reformingReasonR) {
		this.reformingReasonR = reformingReasonR;
	}

	public String getAfterPerformanceR() {
		return afterPerformanceR;
	}

	public void setAfterPerformanceR(String afterPerformanceR) {
		this.afterPerformanceR = afterPerformanceR;
	}

	public String getTransformWayR() {
		return transformWayR;
	}

	public void setTransformWayR(String transformWayR) {
		this.transformWayR = transformWayR;
	}

	public String getBudgetR() {
		return budgetR;
	}

	public void setBudgetR(String budgetR) {
		this.budgetR = budgetR;
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

	public java.math.BigDecimal getNetValueR() {
		return netValueR;
	}

	public void setNetValueR(java.math.BigDecimal netValueR) {
		this.netValueR = netValueR;
	}

	public String getDeviceCategoryR() {
		return deviceCategoryR;
	}

	public void setDeviceCategoryR(String deviceCategoryR) {
		this.deviceCategoryR = deviceCategoryR;
	}

	public String getCreatedByPersonR() {
		return createdByPersonR;
	}

	public void setCreatedByPersonR(String createdByPersonR) {
		this.createdByPersonR = createdByPersonR;
	}

	public String getCreatedByPersonRAlias() {
		return createdByPersonRAlias;
	}

	public void setCreatedByPersonRAlias(String createdByPersonRAlias) {
		this.createdByPersonRAlias = createdByPersonRAlias;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "大修改造下发";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "大修改造下发";
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