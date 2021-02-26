package avicit.assets.furniture.assetsfurnitureacceptance.dto;

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
 * @创建时间： 2020-08-26 08:34 
 * @类说明：家具验收子表
 * @修改记录： 
 */
@PojoRemark(table = "assets_fur_acceptance_rel", object = "AssetsFurAcceptanceRelDTO", name = "家具验收子表")
public class AssetsFurAcceptanceRelDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
	@LogField

	@FieldRemark(column = "acceptance_id", field = "acceptanceId", name = "验收单ID")
	/*
	 *验收单ID
	 */
	private java.lang.String acceptanceId;
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

	@FieldRemark(column = "furniture_name", field = "furnitureName", name = "家具名称")
	/*
	 *家具名称
	 */
	private java.lang.String furnitureName;

	@FieldRemark(column = "furniture_category", field = "furnitureCategory", name = "家具分类")
	/*
	 *家具分类
	 */
	private java.lang.String furnitureCategory;
	/*
	 *家具分类显示名称
	 */
	private java.lang.String furnitureCategoryName;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private java.lang.String manufacturerId;

	@FieldRemark(column = "guarantee_period", field = "guaranteePeriod", name = "质保期(单位：天)")
	/*
	 *质保期(单位：天)
	 */
	private Long guaranteePeriod;

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

	@FieldRemark(column = "furniture_spec", field = "furnitureSpec", name = "规格")
	/*
	 *规格
	 */
	private java.lang.String furnitureSpec;

	@FieldRemark(column = "position_id", field = "positionId", name = "安装地点ID")
	/*
	 *安装地点ID
	 */
	private java.lang.String positionId;

	@FieldRemark(column = "check_num", field = "checkNum", name = "验收数量")
	/*
	 *验收数量
	 */
	private Long checkNum;

	@FieldRemark(column = "unit_price", field = "unitPrice", name = "采购单价")
	/*
	 *采购单价
	 */
	private java.math.BigDecimal unitPrice;

	@FieldRemark(column = "total_price", field = "totalPrice", name = "采购总价")
	/*
	 *采购总价
	 */
	private java.math.BigDecimal totalPrice;

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

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getAcceptanceId() {
		return acceptanceId;
	}

	public void setAcceptanceId(java.lang.String acceptanceId) {
		this.acceptanceId = acceptanceId;
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

	public java.lang.String getFurnitureName() {
		return furnitureName;
	}

	public void setFurnitureName(java.lang.String furnitureName) {
		this.furnitureName = furnitureName;
	}

	public java.lang.String getFurnitureCategory() {
		return furnitureCategory;
	}

	public void setFurnitureCategory(java.lang.String furnitureCategory) {
		this.furnitureCategory = furnitureCategory;
	}

	public java.lang.String getFurnitureCategoryName() {
		return furnitureCategoryName;
	}

	public void setFurnitureCategoryName(java.lang.String furnitureCategoryName) {
		this.furnitureCategoryName = furnitureCategoryName;
	}

	public java.lang.String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(java.lang.String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public Long getGuaranteePeriod() {
		return guaranteePeriod;
	}

	public void setGuaranteePeriod(Long guaranteePeriod) {
		this.guaranteePeriod = guaranteePeriod;
	}

	public java.util.Date getGuaranteeDate() {
		return guaranteeDate;
	}

	public void setGuaranteeDate(java.util.Date guaranteeDate) {
		this.guaranteeDate = guaranteeDate;
	}

	public java.util.Date getGuaranteeDateBegin() {
		return guaranteeDateBegin;
	}

	public void setGuaranteeDateBegin(java.util.Date guaranteeDateBegin) {
		this.guaranteeDateBegin = guaranteeDateBegin;
	}

	public java.util.Date getGuaranteeDateEnd() {
		return guaranteeDateEnd;
	}

	public void setGuaranteeDateEnd(java.util.Date guaranteeDateEnd) {
		this.guaranteeDateEnd = guaranteeDateEnd;
	}

	public java.lang.String getFurnitureSpec() {
		return furnitureSpec;
	}

	public void setFurnitureSpec(java.lang.String furnitureSpec) {
		this.furnitureSpec = furnitureSpec;
	}

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
	}

	public Long getCheckNum() {
		return checkNum;
	}

	public void setCheckNum(Long checkNum) {
		this.checkNum = checkNum;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "家具验收子表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "家具验收子表";
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