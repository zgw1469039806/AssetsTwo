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
 * @类说明：家具盘点
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_inventory", object = "AssetsFurnitureInventoryDTO", name = "家具盘点")
public class AssetsFurnitureInventoryDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
	private String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */

	private String id;
	private String autoCodeValue;

	public String getAutoCodeValue() {
		return autoCodeValue;
	}

	public void setAutoCodeValue(String autoCodeValue) {
		this.autoCodeValue = autoCodeValue;
	}

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

	@FieldRemark(column = "inventory_name", field = "inventoryName", name = "盘点名称")
	/*
	 *盘点名称
	 */
	private String inventoryName;

	@FieldRemark(column = "inventory_id", field = "inventoryId", name = "盘点单号")
	/*
	 *盘点单号
	 */
	private String inventoryId;

	@FieldRemark(column = "created_by_person", field = "createdByPerson", name = "申请人")
	/*
	 *申请人
	 */
	private String createdByPerson;
	/*
	 *申请人显示字段
	 */
	private String createdByPersonAlias;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private String createdByDept;
	/*
	 *申请人部门显示字段
	 */
	private String createdByDeptAlias;

	@FieldRemark(column = "create_date", field = "createDate", name = "创建日期")
	/*
	 *创建日期
	 */
	private java.util.Date createDate;
	/*
	 *创建日期开始时间
	 */
	private java.util.Date createDateBegin;
	/*
	 *创建日期截止时间
	 */
	private java.util.Date createDateEnd;

	@FieldRemark(column = "begin_date", field = "beginDate", name = "基准日")
	/*
	 *基准日
	 */
	private java.util.Date beginDate;
	/*
	 *基准日开始时间
	 */
	private java.util.Date beginDateBegin;
	/*
	 *基准日截止时间
	 */
	private java.util.Date beginDateEnd;

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

	public String getInventoryName() {
		return inventoryName;
	}

	public void setInventoryName(String inventoryName) {
		this.inventoryName = inventoryName;
	}

	public String getInventoryId() {
		return inventoryId;
	}

	public void setInventoryId(String inventoryId) {
		this.inventoryId = inventoryId;
	}

	public String getCreatedByPerson() {
		return createdByPerson;
	}

	public void setCreatedByPerson(String createdByPerson) {
		this.createdByPerson = createdByPerson;
	}

	public String getCreatedByPersonAlias() {
		return createdByPersonAlias;
	}

	public void setCreatedByPersonAlias(String createdByPersonAlias) {
		this.createdByPersonAlias = createdByPersonAlias;
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

	public java.util.Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(java.util.Date createDate) {
		this.createDate = createDate;
	}

	public java.util.Date getCreateDateBegin() {
		return createDateBegin;
	}

	public void setCreateDateBegin(java.util.Date createDateBegin) {
		this.createDateBegin = createDateBegin;
	}

	public java.util.Date getCreateDateEnd() {
		return createDateEnd;
	}

	public void setCreateDateEnd(java.util.Date createDateEnd) {
		this.createDateEnd = createDateEnd;
	}

	public java.util.Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(java.util.Date beginDate) {
		this.beginDate = beginDate;
	}

	public java.util.Date getBeginDateBegin() {
		return beginDateBegin;
	}

	public void setBeginDateBegin(java.util.Date beginDateBegin) {
		this.beginDateBegin = beginDateBegin;
	}

	public java.util.Date getBeginDateEnd() {
		return beginDateEnd;
	}

	public void setBeginDateEnd(java.util.Date beginDateEnd) {
		this.beginDateEnd = beginDateEnd;
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
			return "家具盘点";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "家具盘点";
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