package avicit.assets.furniture.assetsfurniturerepairproc.dto;

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
 * @创建时间： 2020-08-19 09:30 
 * @类说明：家具维修子表
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_repair_sub", object = "AssetsFurnitureRepairSubDTO", name = "家具维修子表")
public class AssetsFurnitureRepairSubDTO extends BeanDTO {
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
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "asset_id", field = "assetId", name = "资产编号")
	/*
	 *资产编号
	 */
	private String assetId;

	@FieldRemark(column = "furniture_name", field = "furnitureName", name = "家具名称")
	/*
	 *家具名称
	 */
	private String furnitureName;

	@FieldRemark(column = "furniture_category", field = "furnitureCategory", name = "家具分类")
	/*
	 *家具分类
	 */
	private String furnitureCategory;
	/*
	 *家具分类显示名称
	 */
	private String furnitureCategoryName;

	@FieldRemark(column = "furniture_spec", field = "furnitureSpec", name = "家具规格")
	/*
	 *家具规格
	 */
	private String furnitureSpec;

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

	@FieldRemark(column = "furniture_photo", field = "furniturePhoto", name = "家具照片")
	/*
	 *家具照片
	 */
	private String furniturePhoto;

	@FieldRemark(column = "furniture_state", field = "furnitureState", name = "家具状态")
	/*
	 *家具状态
	 */
	private String furnitureState;
	/*
	 *家具状态显示名称
	 */
	private String furnitureStateName;

	@FieldRemark(column = "original_value", field = "originalValue", name = "原值")
	/*
	 *原值
	 */
	private java.math.BigDecimal originalValue;

	@FieldRemark(column = "net_value", field = "netValue", name = "净值")
	/*
	 *净值
	 */
	private java.math.BigDecimal netValue;

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

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getFurnitureName() {
		return furnitureName;
	}

	public void setFurnitureName(String furnitureName) {
		this.furnitureName = furnitureName;
	}

	public String getFurnitureCategory() {
		return furnitureCategory;
	}

	public void setFurnitureCategory(String furnitureCategory) {
		this.furnitureCategory = furnitureCategory;
	}

	public String getFurnitureCategoryName() {
		return furnitureCategoryName;
	}

	public void setFurnitureCategoryName(String furnitureCategoryName) {
		this.furnitureCategoryName = furnitureCategoryName;
	}

	public String getFurnitureSpec() {
		return furnitureSpec;
	}

	public void setFurnitureSpec(String furnitureSpec) {
		this.furnitureSpec = furnitureSpec;
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

	public String getFurniturePhoto() {
		return furniturePhoto;
	}

	public void setFurniturePhoto(String furniturePhoto) {
		this.furniturePhoto = furniturePhoto;
	}

	public String getFurnitureState() {
		return furnitureState;
	}

	public void setFurnitureState(String furnitureState) {
		this.furnitureState = furnitureState;
	}

	public String getFurnitureStateName() {
		return furnitureStateName;
	}

	public void setFurnitureStateName(String furnitureStateName) {
		this.furnitureStateName = furnitureStateName;
	}

	public java.math.BigDecimal getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(java.math.BigDecimal originalValue) {
		this.originalValue = originalValue;
	}

	public java.math.BigDecimal getNetValue() {
		return netValue;
	}

	public void setNetValue(java.math.BigDecimal netValue) {
		this.netValue = netValue;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "家具维修子表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "家具维修子表";
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