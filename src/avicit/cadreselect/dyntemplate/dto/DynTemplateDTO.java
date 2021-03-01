package avicit.cadreselect.dyntemplate.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.time.LocalDateTime;

/**
* @金航数码科技有限责任公司
* @作者：one
* @邮箱：邮箱
* @创建时间： 2021-02-24 12:56
* @类说明：模板表Dto
* @修改记录：
*/
@PojoRemark(table="DYN_TEMPLATE", object="DynTemplateDTO", name="模板表")
public class DynTemplateDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 主键
	*/
	@Id
	@LogField
	@FieldRemark(column="ID", field="id", name="主键")
	private java.lang.String id;

	/**
	* 最后更新时间起
	*/
	private java.util.Date lastUpdateDateBegin;
	
	/**
	* 最后更新时间止
	*/
	private java.util.Date lastUpdateDateEnd;

	/**
	* 创建时间起
	*/
	private java.util.Date creationDateBegin;
	
	/**
	* 创建时间止
	*/
	private java.util.Date creationDateEnd;

	/**
	* 模板名称
	*/
	@FieldRemark(column="TEM_TITLE", field="temTitle", name="模板名称")
	private java.lang.String temTitle;

	/**
	* 投票须知
	*/
	@FieldRemark(column="TEM_NOTICE", field="temNotice", name="投票须知")
	private java.lang.String temNotice;

	/**
	* 表格JSON
	*/
	@FieldRemark(column="TEM_TEXT", field="temText", name="表格JSON")
	private java.lang.String temText;

	/**
	* 应投数
	*/
	@FieldRemark(column="TEM_SHOULD_INVEST_NUM", field="temShouldInvestNum", name="应投数")
	private java.math.BigDecimal temShouldInvestNum;

	/**
	* 实投数
	*/
	@FieldRemark(column="TEM_ACTUAL_INVEST_NUM", field="temActualInvestNum", name="实投数")
	private java.math.BigDecimal temActualInvestNum;

	/**
	* 实到数
	*/
	@FieldRemark(column="TEM_SCENE_NUM", field="temSceneNum", name="实到数")
	private java.math.BigDecimal temSceneNum;

	/**
	* 投票类型
	*/
	@FieldRemark(column="TEM_TYPE", field="temType", name="投票类型",lookupType = "template_status",dataType="lookup")
	private java.lang.Integer temType;
	private String temTypeName;

	/**
	* 0-使用中 1-暂停 2-删除
	*/
	@FieldRemark(column="TEM_STATE", field="temState", name="0-使用中 1-暂停 2-删除")
	private java.lang.Integer temState;

	/**
	* 组织ID
	*/
	@LogField
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;

	@FieldRemark(column="TEM_VOTE_NUM", field="temVoteNum", name="出票数")
	private Integer temVoteNum;

	private LocalDateTime temStartDate;//开始时间

	private LocalDateTime temEndDate;//结束时间


	public java.lang.String getId(){
		return id;
	}

	public void setId(java.lang.String id){
		this.id = id;
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

	public java.lang.String getTemTitle(){
		return temTitle;
	}

	public void setTemTitle(java.lang.String temTitle){
		this.temTitle = temTitle;
	}

	public java.lang.String getTemNotice(){
		return temNotice;
	}

	public void setTemNotice(java.lang.String temNotice){
		this.temNotice = temNotice;
	}

	public java.lang.String getTemText(){
		return temText;
	}

	public void setTemText(java.lang.String temText){
		this.temText = temText;
	}

	public java.math.BigDecimal getTemShouldInvestNum(){
		return temShouldInvestNum;
	}

	public void setTemShouldInvestNum(java.math.BigDecimal temShouldInvestNum){
		this.temShouldInvestNum = temShouldInvestNum;
	}

	public java.math.BigDecimal getTemActualInvestNum(){
		return temActualInvestNum;
	}

	public void setTemActualInvestNum(java.math.BigDecimal temActualInvestNum){
		this.temActualInvestNum = temActualInvestNum;
	}


	public java.math.BigDecimal getTemSceneNum(){
		return temSceneNum;
	}

	public void setTemSceneNum(java.math.BigDecimal temSceneNum){
		this.temSceneNum = temSceneNum;
	}

	public java.lang.Integer getTemType(){
		return temType;
	}

	public void setTemType(java.lang.Integer temType){
		this.temType = temType;
	}

	public java.lang.Integer getTemState(){
		return temState;
	}

	public void setTemState(java.lang.Integer temState){
		this.temState = temState;
	}

	public java.lang.String getOrgIdentity(){
		return orgIdentity;
	}

	public void setOrgIdentity(java.lang.String orgIdentity){
		this.orgIdentity = orgIdentity;
	}


	public String getTemTypeName() {
		return temTypeName;
	}

	public void setTemTypeName(String temTypeName) {
		this.temTypeName = temTypeName;
	}
	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "模板表";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "模板表";
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

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Integer getTemVoteNum() {
		return temVoteNum;
	}

	public void setTemVoteNum(Integer temVoteNum) {
		this.temVoteNum = temVoteNum;
	}

	public LocalDateTime getTemStartDate() {
		return temStartDate;
	}

	public void setTemStartDate(LocalDateTime temStartDate) {
		this.temStartDate = temStartDate;
	}

	public LocalDateTime getTemEndDate() {
		return temEndDate;
	}

	public void setTemEndDate(LocalDateTime temEndDate) {
		this.temEndDate = temEndDate;
	}
}
