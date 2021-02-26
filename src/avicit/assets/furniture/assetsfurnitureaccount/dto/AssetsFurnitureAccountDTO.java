package avicit.assets.furniture.assetsfurnitureaccount.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.math.BigDecimal;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-08-13 14:05 
 * @类说明：ASSETS_FURNITURE_ACCOUNT
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_account", object = "AssetsFurnitureAccountDTO", name = "ASSETS_FURNITURE_ACCOUNT")
public class AssetsFurnitureAccountDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
//	/*
//	 *家具ID
//	 */
//	private java.lang.String furnitureId;
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

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private java.lang.String unifiedId;

	@FieldRemark(column = "asset_id", field = "assetId", name = "资产编号")
	/*
	 *资产编号
	 */
	private java.lang.String assetId;

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

	@FieldRemark(column = "furniture_spec", field = "furnitureSpec", name = "家具规格")
	/*
	 *家具规格
	 */
	private java.lang.String furnitureSpec;

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
	private java.lang.String positionId;

	@FieldRemark(column = "guarantee_date", field = "guaranteeDate", name = "保修日期")
	/*
	 *保修日期
	 */
	private java.util.Date guaranteeDate;
	/*
	 *保修日期开始时间
	 */
	private java.util.Date guaranteeDateBegin;
	/*
	 *保修日期截止时间
	 */
	private java.util.Date guaranteeDateEnd;

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

	@FieldRemark(column = "is_trans_fixed", field = "isTransFixed", name = "是否转固")
	/*
	 *是否转固
	 */
	private java.lang.String isTransFixed;

	@FieldRemark(column = "proof_num", field = "proofNum", name = "凭证编号")
	/*
	 *凭证编号
	 */
	private java.lang.String proofNum;

	@FieldRemark(column = "is_in_workflow", field = "isInWorkflow", name = "是否在流程中")
	/*
	 *是否在流程中
	 */
	private java.lang.String isInWorkflow;

	@FieldRemark(column = "furniture_photo", field = "furniturePhoto", name = "家具照片")
	/*
	 *家具照片
	 */
	private java.lang.String furniturePhoto;

	@FieldRemark(column = "furniture_state", field = "furnitureState", name = "家具状态")
	/*
	 *家具状态
	 */
	private java.lang.String furnitureState;

	@FieldRemark(column = "parent_id", field = "parentId", name = "父级家具ID")
	/*
	 *父级家具ID
	 */
	private java.lang.String parentId;

	@FieldRemark(column = "parent_name", field = "parentName", name = "父级家具名称")
	/*
	 *父级家具名称
	 */
	private java.lang.String parentName;

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
	private Long guaranteePeriod;

	public Long getGuaranteePeriod() {
		return guaranteePeriod;
	}

	public void setGuaranteePeriod(Long guaranteePeriod) {
		this.guaranteePeriod = guaranteePeriod;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	@FieldRemark(column = "unit_price", field = "unitPrice", name = "单价")
	/*
	 *单价
	 */
	private java.math.BigDecimal unitPrice;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

//	public String getFurnitureId() {
//		return furnitureId;
//	}
//
//	public void setFurnitureId(String furnitureId) {
//		this.furnitureId = furnitureId;
//	}

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

	public java.lang.String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(java.lang.String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public java.lang.String getAssetId() {
		return assetId;
	}

	public void setAssetId(java.lang.String assetId) {
		this.assetId = assetId;
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

	public java.lang.String getFurnitureSpec() {
		return furnitureSpec;
	}

	public void setFurnitureSpec(java.lang.String furnitureSpec) {
		this.furnitureSpec = furnitureSpec;
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

	public java.lang.String getPositionId() {
		return positionId;
	}

	public void setPositionId(java.lang.String positionId) {
		this.positionId = positionId;
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

	public java.lang.String getIsTransFixed() {
		return isTransFixed;
	}

	public void setIsTransFixed(java.lang.String isTransFixed) {
		this.isTransFixed = isTransFixed;
	}

	public java.lang.String getProofNum() {
		return proofNum;
	}

	public void setProofNum(java.lang.String proofNum) {
		this.proofNum = proofNum;
	}

	public java.lang.String getIsInWorkflow() {
		return isInWorkflow;
	}

	public void setIsInWorkflow(java.lang.String isInWorkflow) {
		this.isInWorkflow = isInWorkflow;
	}

	public java.lang.String getFurniturePhoto() {
		return furniturePhoto;
	}

	public void setFurniturePhoto(java.lang.String furniturePhoto) {
		this.furniturePhoto = furniturePhoto;
	}

	public java.lang.String getFurnitureState() {
		return furnitureState;
	}

	public void setFurnitureState(java.lang.String furnitureState) {
		this.furnitureState = furnitureState;
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
			return "ASSETS_FURNITURE_ACCOUNT";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_FURNITURE_ACCOUNT";
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