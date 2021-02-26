package avicit.assets.furniture.assetsfurnitureinventory.dto;

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
 * @创建时间： 2020-09-09 15:15 
 * @类说明：家具盘点子表
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_inventory_sub", object = "AssetsFurnitureInventorySubDTO", name = "家具盘点子表")
public class AssetsFurnitureInventorySubDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
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

	@FieldRemark(column = "furniture_id", field = "furnitureId", name = "家具ID")
	/*
	 *家具ID
	 */
	private String furnitureId;
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

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "生产厂家")
	/*
	 *生产厂家
	 */
	private String manufacturerId;

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

	@FieldRemark(column = "furniture_state", field = "furnitureState", name = "家具状态")
	/*
	 *家具状态
	 */
	private String furnitureState;
	/*
	 *家具状态显示名称
	 */
	private String furnitureStateName;

	@FieldRemark(column = "inventory_person", field = "inventoryPerson", name = "盘点人")
	/*
	 *盘点人
	 */
	private String inventoryPerson;
	/*
	 *盘点人显示字段
	 */
	private String inventoryPersonAlias;

	@FieldRemark(column = "inventory_dept", field = "inventoryDept", name = "盘点人部门")
	/*
	 *盘点人部门
	 */
	private String inventoryDept;
	/*
	 *盘点人部门显示字段
	 */
	private String inventoryDeptAlias;

	@FieldRemark(column = "inventory_date", field = "inventoryDate", name = "盘点时间")
	/*
	 *盘点时间
	 */
	private java.util.Date inventoryDate;
	/*
	 *盘点时间开始时间
	 */
	private java.util.Date inventoryDateBegin;
	/*
	 *盘点时间截止时间
	 */
	private java.util.Date inventoryDateEnd;

	@FieldRemark(column = "remarks", field = "remarks", name = "备注")
	/*
	 *备注
	 */
	private String remarks;

	@FieldRemark(column = "flag", field = "flag", name = "标志位")
	/*
	 *标志位
	 */
	private String flag;

	@FieldRemark(column = "inventory_state", field = "inventoryState", name = "盘点状态")
	/*
	 *盘点状态
	 */
	private String inventoryState;
	/*
	 *盘点状态显示名称
	 */
	private String inventoryStateName;

	@FieldRemark(column = "inventory_result", field = "inventoryResult", name = "盘点结果")
	/*
	 *盘点结果
	 */
	private String inventoryResult;
	/*
	 *盘点结果显示名称
	 */
	private String inventoryResultName;

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
	private Long attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
	/*
	 *扩展字段12
	 */
	private Long attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
	/*
	 *扩展字段13
	 */
	private Long attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
	/*
	 *扩展字段14
	 */
	private java.math.BigDecimal attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
	/*
	 *扩展字段15
	 */
	private java.math.BigDecimal attribute15;

	@FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
	/*
	 *扩展字段16
	 */
	private java.math.BigDecimal attribute16;

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
	private java.util.Date attribute18;
	/*
	 *扩展字段18开始时间
	 */
	private java.util.Date attribute18Begin;
	/*
	 *扩展字段18截止时间
	 */
	private java.util.Date attribute18End;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
	/*
	 *扩展字段19
	 */
	private java.util.Date attribute19;
	/*
	 *扩展字段19开始时间
	 */
	private java.util.Date attribute19Begin;
	/*
	 *扩展字段19截止时间
	 */
	private java.util.Date attribute19End;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
	/*
	 *扩展字段20
	 */
	private java.util.Date attribute20;
	/*
	 *扩展字段20开始时间
	 */
	private java.util.Date attribute20Begin;
	/*
	 *扩展字段20截止时间
	 */
	private java.util.Date attribute20End;

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

	public String getFurnitureId() {
		return furnitureId;
	}

	public void setFurnitureId(String furnitureId) {
		this.furnitureId = furnitureId;
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

	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
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

	public String getInventoryPerson() {
		return inventoryPerson;
	}

	public void setInventoryPerson(String inventoryPerson) {
		this.inventoryPerson = inventoryPerson;
	}

	public String getInventoryPersonAlias() {
		return inventoryPersonAlias;
	}

	public void setInventoryPersonAlias(String inventoryPersonAlias) {
		this.inventoryPersonAlias = inventoryPersonAlias;
	}

	public String getInventoryDept() {
		return inventoryDept;
	}

	public void setInventoryDept(String inventoryDept) {
		this.inventoryDept = inventoryDept;
	}

	public String getInventoryDeptAlias() {
		return inventoryDeptAlias;
	}

	public void setInventoryDeptAlias(String inventoryDeptAlias) {
		this.inventoryDeptAlias = inventoryDeptAlias;
	}

	public java.util.Date getInventoryDate() {
		return inventoryDate;
	}

	public void setInventoryDate(java.util.Date inventoryDate) {
		this.inventoryDate = inventoryDate;
	}

	public java.util.Date getInventoryDateBegin() {
		return inventoryDateBegin;
	}

	public void setInventoryDateBegin(java.util.Date inventoryDateBegin) {
		this.inventoryDateBegin = inventoryDateBegin;
	}

	public java.util.Date getInventoryDateEnd() {
		return inventoryDateEnd;
	}

	public void setInventoryDateEnd(java.util.Date inventoryDateEnd) {
		this.inventoryDateEnd = inventoryDateEnd;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getInventoryState() {
		return inventoryState;
	}

	public void setInventoryState(String inventoryState) {
		this.inventoryState = inventoryState;
	}

	public String getInventoryStateName() {
		return inventoryStateName;
	}

	public void setInventoryStateName(String inventoryStateName) {
		this.inventoryStateName = inventoryStateName;
	}

	public String getInventoryResult() {
		return inventoryResult;
	}

	public void setInventoryResult(String inventoryResult) {
		this.inventoryResult = inventoryResult;
	}

	public String getInventoryResultName() {
		return inventoryResultName;
	}

	public void setInventoryResultName(String inventoryResultName) {
		this.inventoryResultName = inventoryResultName;
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

	public Long getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(Long attribute11) {
		this.attribute11 = attribute11;
	}

	public Long getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(Long attribute12) {
		this.attribute12 = attribute12;
	}

	public Long getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(Long attribute13) {
		this.attribute13 = attribute13;
	}

	public java.math.BigDecimal getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(java.math.BigDecimal attribute14) {
		this.attribute14 = attribute14;
	}

	public java.math.BigDecimal getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(java.math.BigDecimal attribute15) {
		this.attribute15 = attribute15;
	}

	public java.math.BigDecimal getAttribute16() {
		return attribute16;
	}

	public void setAttribute16(java.math.BigDecimal attribute16) {
		this.attribute16 = attribute16;
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

	public java.util.Date getAttribute18() {
		return attribute18;
	}

	public void setAttribute18(java.util.Date attribute18) {
		this.attribute18 = attribute18;
	}

	public java.util.Date getAttribute18Begin() {
		return attribute18Begin;
	}

	public void setAttribute18Begin(java.util.Date attribute18Begin) {
		this.attribute18Begin = attribute18Begin;
	}

	public java.util.Date getAttribute18End() {
		return attribute18End;
	}

	public void setAttribute18End(java.util.Date attribute18End) {
		this.attribute18End = attribute18End;
	}

	public java.util.Date getAttribute19() {
		return attribute19;
	}

	public void setAttribute19(java.util.Date attribute19) {
		this.attribute19 = attribute19;
	}

	public java.util.Date getAttribute19Begin() {
		return attribute19Begin;
	}

	public void setAttribute19Begin(java.util.Date attribute19Begin) {
		this.attribute19Begin = attribute19Begin;
	}

	public java.util.Date getAttribute19End() {
		return attribute19End;
	}

	public void setAttribute19End(java.util.Date attribute19End) {
		this.attribute19End = attribute19End;
	}

	public java.util.Date getAttribute20() {
		return attribute20;
	}

	public void setAttribute20(java.util.Date attribute20) {
		this.attribute20 = attribute20;
	}

	public java.util.Date getAttribute20Begin() {
		return attribute20Begin;
	}

	public void setAttribute20Begin(java.util.Date attribute20Begin) {
		this.attribute20Begin = attribute20Begin;
	}

	public java.util.Date getAttribute20End() {
		return attribute20End;
	}

	public void setAttribute20End(java.util.Date attribute20End) {
		this.attribute20End = attribute20End;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "家具盘点子表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "家具盘点子表";
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