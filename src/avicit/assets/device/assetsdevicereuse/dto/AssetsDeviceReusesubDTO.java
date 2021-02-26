package avicit.assets.device.assetsdevicereuse.dto;

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
 * @创建时间： 2020-07-16 09:10 
 * @类说明：设备再用子表
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_reusesub", object = "AssetsDeviceReusesubDTO", name = "设备再用子表")
public class AssetsDeviceReusesubDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 *ID
	 */
	private String id;
	@LogField

	@FieldRemark(column = "parent_id", field = "parentId", name = "父表ID")
	/*
	 *父表ID
	 */
	private String parentId;
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

	@FieldRemark(column = "asset_id", field = "assetId", name = "资产编号")
	/*
	 *资产编号
	 */
	private String assetId;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategory;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
	/*
	 *设备型号
	 */
	private String deviceModel;

	@FieldRemark(column = "device_spec", field = "deviceSpec", name = "设备规格")
	/*
	 *设备规格
	 */
	private String deviceSpec;

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

	@FieldRemark(column = "user_id", field = "userId", name = "使用人")
	/*
	 *使用人
	 */
	private String userId;
	/*
	 *使用人显示字段
	 */
	private String userIdAlias;

	@FieldRemark(column = "user_dept", field = "userDept", name = "使用人部门")
	/*
	 *使用人部门
	 */
	private String userDept;
	/*
	 *使用人部门显示字段
	 */
	private String userDeptAlias;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private String manufacturerId;

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

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点ID")
	/*
	 *安装地点ID
	 */
	private String positionId;

	@FieldRemark(column = "original_value", field = "originalValue", name = "原值")
	/*
	 *原值
	 */
	private java.math.BigDecimal originalValue;

	@FieldRemark(column = "total_depreciation", field = "totalDepreciation", name = "累计折旧")
	/*
	 *累计折旧
	 */
	private Long totalDepreciation;

	@FieldRemark(column = "net_value", field = "netValue", name = "净值")
	/*
	 *净值
	 */
	private java.math.BigDecimal netValue;

	@FieldRemark(column = "net_salvage", field = "netSalvage", name = "净残值")
	/*
	 *净残值
	 */
	private java.math.BigDecimal netSalvage;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private String secretLevel;
	/*
	 *密级显示名称
	 */
	private String secretLevelName;

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

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
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

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getDeviceSpec() {
		return deviceSpec;
	}

	public void setDeviceSpec(String deviceSpec) {
		this.deviceSpec = deviceSpec;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserIdAlias() {
		return userIdAlias;
	}

	public void setUserIdAlias(String userIdAlias) {
		this.userIdAlias = userIdAlias;
	}

	public String getUserDept() {
		return userDept;
	}

	public void setUserDept(String userDept) {
		this.userDept = userDept;
	}

	public String getUserDeptAlias() {
		return userDeptAlias;
	}

	public void setUserDeptAlias(String userDeptAlias) {
		this.userDeptAlias = userDeptAlias;
	}

	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
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

	public String getPositionId() {
		return positionId;
	}

	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}

	public java.math.BigDecimal getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(java.math.BigDecimal originalValue) {
		this.originalValue = originalValue;
	}

	public Long getTotalDepreciation() {
		return totalDepreciation;
	}

	public void setTotalDepreciation(Long totalDepreciation) {
		this.totalDepreciation = totalDepreciation;
	}

	public java.math.BigDecimal getNetValue() {
		return netValue;
	}

	public void setNetValue(java.math.BigDecimal netValue) {
		this.netValue = netValue;
	}

	public java.math.BigDecimal getNetSalvage() {
		return netSalvage;
	}

	public void setNetSalvage(java.math.BigDecimal netSalvage) {
		this.netSalvage = netSalvage;
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

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "设备再用子表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "设备再用子表";
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