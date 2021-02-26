package avicit.assets.device.assetsdevicemchecktemporary.dto;

import javax.persistence.Id;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-09-09 16:09 
 * @类说明：ASSETS_DEVICE_MCHECK_TEMPORARY
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_mcheck_temporary", object = "AssetsDeviceMcheckTemporaryDTO", name = "ASSETS_DEVICE_MCHECK_TEMPORARY")
public class AssetsDeviceMcheckTemporaryDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *创建时间开始时间
	 */
	private java.util.Date creationDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *创建时间截止时间
	 */
	private java.util.Date creationDateEnd;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *最后修改时间开始时间
	 */
	private java.util.Date lastUpdateDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *最后修改时间截止时间
	 */
	private java.util.Date lastUpdateDateEnd;

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
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段26
	 */
	private java.util.Date attribute26;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段26开始时间
	 */
	private java.util.Date attribute26Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段26截止时间
	 */
	private java.util.Date attribute26End;

	@FieldRemark(column = "attribute_27", field = "attribute27", name = "扩展字段27")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段27
	 */
	private java.util.Date attribute27;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段27开始时间
	 */
	private java.util.Date attribute27Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段27截止时间
	 */
	private java.util.Date attribute27End;

	@FieldRemark(column = "attribute_28", field = "attribute28", name = "扩展字段28")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段28
	 */
	private java.util.Date attribute28;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段28开始时间
	 */
	private java.util.Date attribute28Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段28截止时间
	 */
	private java.util.Date attribute28End;

	@FieldRemark(column = "attribute_29", field = "attribute29", name = "扩展字段29")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段29
	 */
	private java.util.Date attribute29;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段29开始时间
	 */
	private java.util.Date attribute29Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段29截止时间
	 */
	private java.util.Date attribute29End;

	@FieldRemark(column = "attribute_30", field = "attribute30", name = "扩展字段30")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段30
	 */
	private java.util.Date attribute30;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段30开始时间
	 */
	private java.util.Date attribute30Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段30截止时间
	 */
	private java.util.Date attribute30End;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private java.lang.String unifiedId;
	@LogField

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
	/*
	 *设备类别显示名称
	 */
	private java.lang.String deviceCategoryName;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "设备型号")
	/*
	 *设备型号
	 */
	private java.lang.String deviceModel;

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

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点")
	/*
	 *安装地点
	 */
	private java.lang.String positionId;

	@FieldRemark(column = "maintain_position", field = "maintainPosition", name = "保养部位")
	/*
	 *保养部位
	 */
	private java.lang.String maintainPosition;

	@FieldRemark(column = "maintain_content", field = "maintainContent", name = "保养内容")
	/*
	 *保养内容
	 */
	private java.lang.String maintainContent;

	@FieldRemark(column = "maintain_item", field = "maintainItem", name = "保养项目")
	/*
	 *保养项目
	 */
	private java.lang.String maintainItem;
	/*
	 *保养项目显示名称
	 */
	private java.lang.String maintainItemName;

	@FieldRemark(column = "maintain_mode", field = "maintainMode", name = "保养方式")
	/*
	 *保养方式
	 */
	private java.lang.String maintainMode;
	/*
	 *保养方式显示名称
	 */
	private java.lang.String maintainModeName;

	@FieldRemark(column = "maintain_cycle", field = "maintainCycle", name = "保养周期")
	/*
	 *保养周期
	 */
	private java.lang.String maintainCycle;

	@FieldRemark(column = "last_maintain_date", field = "lastMaintainDate", name = "上次保养时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *上次保养时间
	 */
	private java.util.Date lastMaintainDate;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *上次保养时间开始时间
	 */
	private java.util.Date lastMaintainDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *上次保养时间截止时间
	 */
	private java.util.Date lastMaintainDateEnd;

	@FieldRemark(column = "next_maintain_date", field = "nextMaintainDate", name = "下次保养时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *下次保养时间
	 */
	private java.util.Date nextMaintainDate;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *下次保养时间开始时间
	 */
	private java.util.Date nextMaintainDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *下次保养时间截止时间
	 */
	private java.util.Date nextMaintainDateEnd;

	@FieldRemark(column = "proc_id", field = "procId", name = "年度保养表ID")
	/*
	 *年度保养表ID
	 */
	private java.lang.String procId;

	@FieldRemark(column = "maintain_id", field = "maintainId", name = "台账年度保养表ID")
	/*
	 *台账年度保养表ID
	 */
	private java.lang.String maintainId;

	@FieldRemark(column = "maintain_date", field = "maintainDate", name = "保养时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *保养时间
	 */
	private java.util.Date maintainDate;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *保养时间开始时间
	 */
	private java.util.Date maintainDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *保养时间截止时间
	 */
	private java.util.Date maintainDateEnd;

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

	public java.lang.String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(java.lang.String deviceModel) {
		this.deviceModel = deviceModel;
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

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
	}

	public java.lang.String getMaintainPosition() {
		return maintainPosition;
	}

	public void setMaintainPosition(java.lang.String maintainPosition) {
		this.maintainPosition = maintainPosition;
	}

	public java.lang.String getMaintainContent() {
		return maintainContent;
	}

	public void setMaintainContent(java.lang.String maintainContent) {
		this.maintainContent = maintainContent;
	}

	public java.lang.String getMaintainItem() {
		return maintainItem;
	}

	public void setMaintainItem(java.lang.String maintainItem) {
		this.maintainItem = maintainItem;
	}

	public java.lang.String getMaintainItemName() {
		return maintainItemName;
	}

	public void setMaintainItemName(java.lang.String maintainItemName) {
		this.maintainItemName = maintainItemName;
	}

	public java.lang.String getMaintainMode() {
		return maintainMode;
	}

	public void setMaintainMode(java.lang.String maintainMode) {
		this.maintainMode = maintainMode;
	}

	public java.lang.String getMaintainModeName() {
		return maintainModeName;
	}

	public void setMaintainModeName(java.lang.String maintainModeName) {
		this.maintainModeName = maintainModeName;
	}

	public java.lang.String getMaintainCycle() {
		return maintainCycle;
	}

	public void setMaintainCycle(java.lang.String maintainCycle) {
		this.maintainCycle = maintainCycle;
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

	public java.util.Date getNextMaintainDate() {
		return nextMaintainDate;
	}

	public void setNextMaintainDate(java.util.Date nextMaintainDate) {
		this.nextMaintainDate = nextMaintainDate;
	}

	public java.util.Date getNextMaintainDateBegin() {
		return nextMaintainDateBegin;
	}

	public void setNextMaintainDateBegin(java.util.Date nextMaintainDateBegin) {
		this.nextMaintainDateBegin = nextMaintainDateBegin;
	}

	public java.util.Date getNextMaintainDateEnd() {
		return nextMaintainDateEnd;
	}

	public void setNextMaintainDateEnd(java.util.Date nextMaintainDateEnd) {
		this.nextMaintainDateEnd = nextMaintainDateEnd;
	}

	public java.lang.String getProcId() {
		return procId;
	}

	public void setProcId(java.lang.String procId) {
		this.procId = procId;
	}

	public java.lang.String getMaintainId() {
		return maintainId;
	}

	public void setMaintainId(java.lang.String maintainId) {
		this.maintainId = maintainId;
	}

	public java.util.Date getMaintainDate() {
		return maintainDate;
	}

	public void setMaintainDate(java.util.Date maintainDate) {
		this.maintainDate = maintainDate;
	}

	public java.util.Date getMaintainDateBegin() {
		return maintainDateBegin;
	}

	public void setMaintainDateBegin(java.util.Date maintainDateBegin) {
		this.maintainDateBegin = maintainDateBegin;
	}

	public java.util.Date getMaintainDateEnd() {
		return maintainDateEnd;
	}

	public void setMaintainDateEnd(java.util.Date maintainDateEnd) {
		this.maintainDateEnd = maintainDateEnd;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "ASSETS_DEVICE_MCHECK_TEMPORARY";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_DEVICE_MCHECK_TEMPORARY";
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