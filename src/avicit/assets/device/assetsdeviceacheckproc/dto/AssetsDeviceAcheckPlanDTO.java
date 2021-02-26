package avicit.assets.device.assetsdeviceacheckproc.dto;

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
 * @创建时间： 2020-09-08 17:30 
 * @类说明：ASSETS_DEVICE_ACHECK_PLAN
 * @修改记录： 
 */
@PojoRemark(table = "assets_device_acheck_plan", object = "AssetsDeviceAcheckPlanDTO", name = "ASSETS_DEVICE_ACHECK_PLAN")
public class AssetsDeviceAcheckPlanDTO extends BeanDTO {
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

	@FieldRemark(column = "product_area", field = "productArea", name = "产地")
	/*
	 *产地
	 */
	private java.lang.String productArea;

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点")
	/*
	 *安装地点
	 */
	private java.lang.String positionId;

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

	@FieldRemark(column = "last_acc_check_date", field = "lastAccCheckDate", name = "上次精度检查时间")
	/*
	 *上次精度检查时间
	 */
	private java.util.Date lastAccCheckDate;
	/*
	 *上次精度检查时间开始时间
	 */
	private java.util.Date lastAccCheckDateBegin;
	/*
	 *上次精度检查时间截止时间
	 */
	private java.util.Date lastAccCheckDateEnd;

	@FieldRemark(column = "acc_check_cycle", field = "accCheckCycle", name = "精度检查周期")
	/*
	 *精度检查周期
	 */
	private Long accCheckCycle;

	@FieldRemark(column = "next_acc_check_date", field = "nextAccCheckDate", name = "下次精度检查时间")
	/*
	 *下次精度检查时间
	 */
	private java.util.Date nextAccCheckDate;
	/*
	 *下次精度检查时间开始时间
	 */
	private java.util.Date nextAccCheckDateBegin;
	/*
	 *下次精度检查时间截止时间
	 */
	private java.util.Date nextAccCheckDateEnd;

	@FieldRemark(column = "attachment", field = "attachment", name = "附件")
	/*
	 *附件
	 */
	private java.lang.String attachment;

	@FieldRemark(column = "proc_id", field = "procId", name = "精度计划子表")
	/*
	 *精度计划子表
	 */
	private java.lang.String procId;
	@LogField

	@FieldRemark(column = "check_id", field = "checkId", name = "台账的定检信息ID")
	/*
	 *台账的定检信息ID
	 */
	private java.lang.String checkId;

	@FieldRemark(column = "acc_check_date", field = "accCheckDate", name = "精度检查时间")
	/*
	 *精度检查时间
	 */
	private java.util.Date accCheckDate;
	/*
	 *精度检查时间开始时间
	 */
	private java.util.Date accCheckDateBegin;
	/*
	 *精度检查时间截止时间
	 */
	private java.util.Date accCheckDateEnd;

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

	public java.lang.String getProductArea() {
		return productArea;
	}

	public void setProductArea(java.lang.String productArea) {
		this.productArea = productArea;
	}

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
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

	public java.util.Date getLastAccCheckDate() {
		return lastAccCheckDate;
	}

	public void setLastAccCheckDate(java.util.Date lastAccCheckDate) {
		this.lastAccCheckDate = lastAccCheckDate;
	}

	public java.util.Date getLastAccCheckDateBegin() {
		return lastAccCheckDateBegin;
	}

	public void setLastAccCheckDateBegin(java.util.Date lastAccCheckDateBegin) {
		this.lastAccCheckDateBegin = lastAccCheckDateBegin;
	}

	public java.util.Date getLastAccCheckDateEnd() {
		return lastAccCheckDateEnd;
	}

	public void setLastAccCheckDateEnd(java.util.Date lastAccCheckDateEnd) {
		this.lastAccCheckDateEnd = lastAccCheckDateEnd;
	}

	public Long getAccCheckCycle() {
		return accCheckCycle;
	}

	public void setAccCheckCycle(Long accCheckCycle) {
		this.accCheckCycle = accCheckCycle;
	}

	public java.util.Date getNextAccCheckDate() {
		return nextAccCheckDate;
	}

	public void setNextAccCheckDate(java.util.Date nextAccCheckDate) {
		this.nextAccCheckDate = nextAccCheckDate;
	}

	public java.util.Date getNextAccCheckDateBegin() {
		return nextAccCheckDateBegin;
	}

	public void setNextAccCheckDateBegin(java.util.Date nextAccCheckDateBegin) {
		this.nextAccCheckDateBegin = nextAccCheckDateBegin;
	}

	public java.util.Date getNextAccCheckDateEnd() {
		return nextAccCheckDateEnd;
	}

	public void setNextAccCheckDateEnd(java.util.Date nextAccCheckDateEnd) {
		this.nextAccCheckDateEnd = nextAccCheckDateEnd;
	}

	public java.lang.String getAttachment() {
		return attachment;
	}

	public void setAttachment(java.lang.String attachment) {
		this.attachment = attachment;
	}

	public java.lang.String getProcId() {
		return procId;
	}

	public void setProcId(java.lang.String procId) {
		this.procId = procId;
	}

	public java.lang.String getCheckId() {
		return checkId;
	}

	public void setCheckId(java.lang.String checkId) {
		this.checkId = checkId;
	}

	public java.util.Date getAccCheckDate() {
		return accCheckDate;
	}

	public void setAccCheckDate(java.util.Date accCheckDate) {
		this.accCheckDate = accCheckDate;
	}

	public java.util.Date getAccCheckDateBegin() {
		return accCheckDateBegin;
	}

	public void setAccCheckDateBegin(java.util.Date accCheckDateBegin) {
		this.accCheckDateBegin = accCheckDateBegin;
	}

	public java.util.Date getAccCheckDateEnd() {
		return accCheckDateEnd;
	}

	public void setAccCheckDateEnd(java.util.Date accCheckDateEnd) {
		this.accCheckDateEnd = accCheckDateEnd;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "ASSETS_DEVICE_ACHECK_PLAN";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_DEVICE_ACHECK_PLAN";
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