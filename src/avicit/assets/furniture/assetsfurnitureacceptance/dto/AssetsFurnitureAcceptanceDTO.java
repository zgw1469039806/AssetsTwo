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
 * @类说明：ASSETS_FURNITURE_ACCEPTANCE
 * @修改记录： 
 */
@PojoRemark(table = "assets_furniture_acceptance", object = "AssetsFurnitureAcceptanceDTO", name = "ASSETS_FURNITURE_ACCEPTANCE")
public class AssetsFurnitureAcceptanceDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private java.lang.String activityalias_; // 节点中文名称
	private java.lang.String activityname_; // 当前节点id
	private java.lang.String businessstate_; // 流程当前状态
	private java.lang.String currUserId; // 当前登录人ID
	private java.lang.String bpmType;
	private java.lang.String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
	@LogField

	@FieldRemark(column = "acceptance_no", field = "acceptanceNo", name = "验收单号")
	/*
	 *验收单号
	 */
	private java.lang.String acceptanceNo;

	@FieldRemark(column = "fur_no", field = "furNo", name = "申购单号")
	/*
	 *申购单号
	 */
	private java.lang.String furNo;

	@FieldRemark(column = "buyer", field = "buyer", name = "采购员")
	/*
	 *采购员
	 */
	private java.lang.String buyer;
	/*
	 *采购员显示字段
	 */
	private java.lang.String buyerAlias;

	@FieldRemark(column = "created_by_persion", field = "createdByPersion", name = "申请人")
	/*
	 *申请人
	 */
	private java.lang.String createdByPersion;
	/*
	 *申请人显示字段
	 */
	private java.lang.String createdByPersionAlias;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "申请人部门")
	/*
	 *申请人部门
	 */
	private java.lang.String createdByDept;
	/*
	 *申请人部门显示字段
	 */
	private java.lang.String createdByDeptAlias;
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

	@FieldRemark(column = "apply_reason", field = "applyReason", name = "申购原因")
	/*
	 *申购原因
	 */
	private java.lang.String applyReason;

	@FieldRemark(column = "contract_num", field = "contractNum", name = "合同号")
	/*
	 *合同号
	 */
	private java.lang.String contractNum;

	@FieldRemark(column = "arrival_date", field = "arrivalDate", name = "预计到货时间")
	/*
	 *预计到货时间
	 */
	private java.util.Date arrivalDate;
	/*
	 *预计到货时间开始时间
	 */
	private java.util.Date arrivalDateBegin;
	/*
	 *预计到货时间截止时间
	 */
	private java.util.Date arrivalDateEnd;

	@FieldRemark(column = "actually_date", field = "actuallyDate", name = "实际到货时间")
	/*
	 *实际到货时间
	 */
	private java.util.Date actuallyDate;
	/*
	 *实际到货时间开始时间
	 */
	private java.util.Date actuallyDateBegin;
	/*
	 *实际到货时间截止时间
	 */
	private java.util.Date actuallyDateEnd;

	@FieldRemark(column = "form_price", field = "formPrice", name = "单据总金额")
	/*
	 *单据总金额
	 */
	private java.math.BigDecimal formPrice;

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

	public java.lang.String getAcceptanceNo() {
		return acceptanceNo;
	}

	public void setAcceptanceNo(java.lang.String acceptanceNo) {
		this.acceptanceNo = acceptanceNo;
	}

	public java.lang.String getFurNo() {
		return furNo;
	}

	public void setFurNo(java.lang.String furNo) {
		this.furNo = furNo;
	}

	public java.lang.String getBuyer() {
		return buyer;
	}

	public void setBuyer(java.lang.String buyer) {
		this.buyer = buyer;
	}

	public java.lang.String getBuyerAlias() {
		return buyerAlias;
	}

	public void setBuyerAlias(java.lang.String buyerAlias) {
		this.buyerAlias = buyerAlias;
	}

	public java.lang.String getCreatedByPersion() {
		return createdByPersion;
	}

	public void setCreatedByPersion(java.lang.String createdByPersion) {
		this.createdByPersion = createdByPersion;
	}

	public java.lang.String getCreatedByPersionAlias() {
		return createdByPersionAlias;
	}

	public void setCreatedByPersionAlias(java.lang.String createdByPersionAlias) {
		this.createdByPersionAlias = createdByPersionAlias;
	}

	public java.lang.String getCreatedByDept() {
		return createdByDept;
	}

	public void setCreatedByDept(java.lang.String createdByDept) {
		this.createdByDept = createdByDept;
	}

	public java.lang.String getCreatedByDeptAlias() {
		return createdByDeptAlias;
	}

	public void setCreatedByDeptAlias(java.lang.String createdByDeptAlias) {
		this.createdByDeptAlias = createdByDeptAlias;
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

	public java.lang.String getApplyReason() {
		return applyReason;
	}

	public void setApplyReason(java.lang.String applyReason) {
		this.applyReason = applyReason;
	}

	public java.lang.String getContractNum() {
		return contractNum;
	}

	public void setContractNum(java.lang.String contractNum) {
		this.contractNum = contractNum;
	}

	public java.util.Date getArrivalDate() {
		return arrivalDate;
	}

	public void setArrivalDate(java.util.Date arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

	public java.util.Date getArrivalDateBegin() {
		return arrivalDateBegin;
	}

	public void setArrivalDateBegin(java.util.Date arrivalDateBegin) {
		this.arrivalDateBegin = arrivalDateBegin;
	}

	public java.util.Date getArrivalDateEnd() {
		return arrivalDateEnd;
	}

	public void setArrivalDateEnd(java.util.Date arrivalDateEnd) {
		this.arrivalDateEnd = arrivalDateEnd;
	}

	public java.util.Date getActuallyDate() {
		return actuallyDate;
	}

	public void setActuallyDate(java.util.Date actuallyDate) {
		this.actuallyDate = actuallyDate;
	}

	public java.util.Date getActuallyDateBegin() {
		return actuallyDateBegin;
	}

	public void setActuallyDateBegin(java.util.Date actuallyDateBegin) {
		this.actuallyDateBegin = actuallyDateBegin;
	}

	public java.util.Date getActuallyDateEnd() {
		return actuallyDateEnd;
	}

	public void setActuallyDateEnd(java.util.Date actuallyDateEnd) {
		this.actuallyDateEnd = actuallyDateEnd;
	}

	public java.math.BigDecimal getFormPrice() {
		return formPrice;
	}

	public void setFormPrice(java.math.BigDecimal formPrice) {
		this.formPrice = formPrice;
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

	public java.lang.String getActivityalias_() {
		return activityalias_;
	}

	public void setActivityalias_(java.lang.String activityalias_) {
		this.activityalias_ = activityalias_;
	}

	public java.lang.String getActivityname_() {
		return activityname_;
	}

	public void setActivityname_(java.lang.String activityname_) {
		this.activityname_ = activityname_;
	}

	public java.lang.String getBusinessstate_() {
		return businessstate_;
	}

	public void setBusinessstate_(java.lang.String businessstate_) {
		this.businessstate_ = businessstate_;
	}

	public java.lang.String getBpmType() {
		return bpmType;
	}

	public void setBpmType(java.lang.String bpmType) {
		this.bpmType = bpmType;
	}

	public java.lang.String getBpmState() {
		return bpmState;
	}

	public void setBpmState(java.lang.String bpmState) {
		this.bpmState = bpmState;
	}

	public java.lang.String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(java.lang.String currUserId) {
		this.currUserId = currUserId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "ASSETS_FURNITURE_ACCEPTANCE";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "ASSETS_FURNITURE_ACCEPTANCE";
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