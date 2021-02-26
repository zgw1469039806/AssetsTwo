package avicit.elect.dynelectlog.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
* @科技有限责任公司
* @作者：shiys
* @邮箱：260289963@qq.com
* @创建时间： 2021-02-05 00:36
* @类说明：选举记录表Dto
* @修改记录：
*/
@PojoRemark(table="DYN_ELECT_LOG", object="DynElectLogDTO", name="选举记录表")
public class DynElectLogDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 创建时间起
	*/
	private java.util.Date creationDateBegin;
	
	/**
	* 创建时间止
	*/
	private java.util.Date creationDateEnd;

	/**
	* 最后更新时间起
	*/
	private java.util.Date lastUpdateDateBegin;
	
	/**
	* 最后更新时间止
	*/
	private java.util.Date lastUpdateDateEnd;

	/**
	* 选举表id
	*/
	@FieldRemark(column="ELECT_ID", field="electId", name="选举表id")
	private java.lang.String electId;

	/**
	* 选举名称
	*/
	@FieldRemark(column="ELECT_NAME", field="electName", name="选举名称")
	private java.lang.String electName;

	/**
	* 规则描述
	*/
	@FieldRemark(column="RULE_DESC", field="ruleDesc", name="规则描述")
	private java.lang.String ruleDesc;

	/**
	* 号码牌
	*/
	@FieldRemark(column="NUM_PLATE", field="numPlate", name="号码牌")
	private java.lang.String numPlate;

	/**
	* 候选人id
	*/
	@FieldRemark(column="PERSON_ID", field="personId", name="候选人id")
	private java.lang.String personId;

	/**
	* 候选人姓名
	*/
	@FieldRemark(column="PERSON_NAME", field="personName", name="候选人姓名")
	private java.lang.String personName;

	/**
	* 候选人部门
	*/
	@FieldRemark(column="PERSON_DEPT_NAME", field="personDeptName", name="候选人部门")
	private java.lang.String personDeptName;

	/**
	* 备用字段1
	*/
	@FieldRemark(column="ATT_01", field="att01", name="备用字段1")
	private java.lang.String att01;

	/**
	* 赞成数
	*/
	@FieldRemark(column="AGREE_NUM", field="agreeNum", name="赞成数")
	private java.math.BigDecimal agreeNum;

	/**
	* 反对数
	*/
	@FieldRemark(column="UNAGREE_NUM", field="unagreeNum", name="反对数")
	private java.math.BigDecimal unagreeNum;

	/**
	* 弃权数
	*/
	@FieldRemark(column="GIVEUP_NUM", field="giveupNum", name="弃权数")
	private java.math.BigDecimal giveupNum;

	/**
	* 提交时间
	*/
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
	@FieldRemark(column="SUBMIT_DATE", field="submitDate", name="提交时间")
	private java.util.Date submitDate;

	/**
	* 提交时间起
	*/
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
	private java.util.Date submitDateBegin;

	/**
	* 提交时间止
	*/
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
	private java.util.Date submitDateEnd;

	/**
	* ID
	*/
	@Id
	@LogField
	@FieldRemark(column="ID", field="id", name="ID")
	private java.lang.String id;

	/**
	* 组织ID
	*/
	@LogField
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;

	/**
	* 备用字段2
	*/
	@FieldRemark(column="ATT_02", field="att02", name="备用字段2")
	private java.lang.String att02;

	/**
	* 备用字段3
	*/
	@FieldRemark(column="ATT_03", field="att03", name="备用字段3")
	private java.lang.String att03;

	/**
	* 备用字段4
	*/
	@FieldRemark(column="ATT_04", field="att04", name="备用字段4")
	private java.lang.String att04;

	/**
	* 备用字段5
	*/
	@FieldRemark(column="ATT_05", field="att05", name="备用字段5")
	private java.lang.String att05;

	/**
	* 备用字段6
	*/
	@FieldRemark(column="ATT_06", field="att06", name="备用字段6")
	private java.math.BigDecimal att06;

	/**
	* 备用字段7
	*/
	@FieldRemark(column="ATT_07", field="att07", name="备用字段7")
	private java.math.BigDecimal att07;

	/**
	* 备用字段8
	*/
	@FieldRemark(column="ATT_08", field="att08", name="备用字段8")
	private java.math.BigDecimal att08;

	/**
	* 备用字段9
	*/
	@FieldRemark(column="ATT_09", field="att09", name="备用字段9")
	private java.math.BigDecimal att09;

	/**
	* 备用字段10
	*/
	@FieldRemark(column="ATT_10", field="att10", name="备用字段10")
	private java.math.BigDecimal att10;


	public java.util.Date getCreationDateBegin(){
		return creationDateBegin;
	}

	public void setCreationDateBegin(java.util.Date creationDateBegin){
		this.creationDateBegin = creationDateBegin;
	}

	public java.util.Date getCreationDateEnd(){
		return creationDateEnd;
	}

	public void setCreationDateEnd(java.util.Date creationDateEnd){
		this.creationDateEnd = creationDateEnd;
	}

	public java.util.Date getLastUpdateDateBegin(){
		return lastUpdateDateBegin;
	}

	public void setLastUpdateDateBegin(java.util.Date lastUpdateDateBegin){
		this.lastUpdateDateBegin = lastUpdateDateBegin;
	}

	public java.util.Date getLastUpdateDateEnd(){
		return lastUpdateDateEnd;
	}

	public void setLastUpdateDateEnd(java.util.Date lastUpdateDateEnd){
		this.lastUpdateDateEnd = lastUpdateDateEnd;
	}

	public java.lang.String getElectId(){
		return electId;
	}

	public void setElectId(java.lang.String electId){
		this.electId = electId;
	}

	public java.lang.String getElectName(){
		return electName;
	}

	public void setElectName(java.lang.String electName){
		this.electName = electName;
	}

	public java.lang.String getRuleDesc(){
		return ruleDesc;
	}

	public void setRuleDesc(java.lang.String ruleDesc){
		this.ruleDesc = ruleDesc;
	}

	public java.lang.String getNumPlate(){
		return numPlate;
	}

	public void setNumPlate(java.lang.String numPlate){
		this.numPlate = numPlate;
	}

	public java.lang.String getPersonId(){
		return personId;
	}

	public void setPersonId(java.lang.String personId){
		this.personId = personId;
	}

	public java.lang.String getPersonName(){
		return personName;
	}

	public void setPersonName(java.lang.String personName){
		this.personName = personName;
	}

	public java.lang.String getPersonDeptName(){
		return personDeptName;
	}

	public void setPersonDeptName(java.lang.String personDeptName){
		this.personDeptName = personDeptName;
	}

	public java.lang.String getAtt01(){
		return att01;
	}

	public void setAtt01(java.lang.String att01){
		this.att01 = att01;
	}

	public java.math.BigDecimal getAgreeNum(){
		return agreeNum;
	}

	public void setAgreeNum(java.math.BigDecimal agreeNum){
		this.agreeNum = agreeNum;
	}

	public java.math.BigDecimal getUnagreeNum(){
		return unagreeNum;
	}

	public void setUnagreeNum(java.math.BigDecimal unagreeNum){
		this.unagreeNum = unagreeNum;
	}

	public java.math.BigDecimal getGiveupNum(){
		return giveupNum;
	}

	public void setGiveupNum(java.math.BigDecimal giveupNum){
		this.giveupNum = giveupNum;
	}

	public java.util.Date getSubmitDate(){
		return submitDate;
	}

	public void setSubmitDate(java.util.Date submitDate){
		this.submitDate = submitDate;
	}

	public java.util.Date getSubmitDateBegin(){
		return submitDateBegin;
	}

	public void setSubmitDateBegin(java.util.Date submitDateBegin){
		this.submitDateBegin = submitDateBegin;
	}

	public java.util.Date getSubmitDateEnd(){
		return submitDateEnd;
	}

	public void setSubmitDateEnd(java.util.Date submitDateEnd){
		this.submitDateEnd = submitDateEnd;
	}

	public java.lang.String getId(){
		return id;
	}

	public void setId(java.lang.String id){
		this.id = id;
	}

	public java.lang.String getOrgIdentity(){
		return orgIdentity;
	}

	public void setOrgIdentity(java.lang.String orgIdentity){
		this.orgIdentity = orgIdentity;
	}

	public java.lang.String getAtt02(){
		return att02;
	}

	public void setAtt02(java.lang.String att02){
		this.att02 = att02;
	}

	public java.lang.String getAtt03(){
		return att03;
	}

	public void setAtt03(java.lang.String att03){
		this.att03 = att03;
	}

	public java.lang.String getAtt04(){
		return att04;
	}

	public void setAtt04(java.lang.String att04){
		this.att04 = att04;
	}

	public java.lang.String getAtt05(){
		return att05;
	}

	public void setAtt05(java.lang.String att05){
		this.att05 = att05;
	}

	public java.math.BigDecimal getAtt06(){
		return att06;
	}

	public void setAtt06(java.math.BigDecimal att06){
		this.att06 = att06;
	}

	public java.math.BigDecimal getAtt07(){
		return att07;
	}

	public void setAtt07(java.math.BigDecimal att07){
		this.att07 = att07;
	}

	public java.math.BigDecimal getAtt08(){
		return att08;
	}

	public void setAtt08(java.math.BigDecimal att08){
		this.att08 = att08;
	}

	public java.math.BigDecimal getAtt09(){
		return att09;
	}

	public void setAtt09(java.math.BigDecimal att09){
		this.att09 = att09;
	}

	public java.math.BigDecimal getAtt10(){
		return att10;
	}

	public void setAtt10(java.math.BigDecimal att10){
		this.att10 = att10;
	}

	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "选举记录表";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "选举记录表";
		}else{
			return super.logTitle;
		}
	}

	@Override
	public LogType getLogType() {
		if (super.logType == null || "".equals(super.logType)) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}
