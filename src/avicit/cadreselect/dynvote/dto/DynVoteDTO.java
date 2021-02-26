package avicit.cadreselect.dynvote.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
* @金航数码科技有限责任公司
* @作者：one
* @邮箱：邮箱
* @创建时间： 2021-02-24 12:58
* @类说明：DYN_VOTEDto
* @修改记录：
*/
@PojoRemark(table="DYN_VOTE", object="DynVoteDTO", name="DYN_VOTE")
public class DynVoteDTO extends BeanDTO{
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
	* 模板ITEM ID
	*/
	@FieldRemark(column="DYN_IT_ID", field="dynItId", name="模板ITEM ID")
	private java.lang.String dynItId;

	/**
	* 意见
	*/
	@FieldRemark(column="DYN_VOTE_OPINION", field="dynVoteOpinion", name="意见")
	private java.lang.String dynVoteOpinion;

	/**
	* 标识
	*/
	@FieldRemark(column="DYN_VOTE_ID", field="dynVoteId", name="标识")
	private java.lang.String dynVoteId;

	/**
	* 投票人IP
	*/
	@FieldRemark(column="DYN_VOTE_IP", field="dynVoteIp", name="投票人IP")
	private java.lang.String dynVoteIp;

	/**
	* 是否登录
	*/
	@FieldRemark(column="DYN_VOTE_LOG", field="dynVoteLog", name="是否登录")
	private java.lang.Integer dynVoteLog;

	/**
	* 组织ID
	*/
	@LogField
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;


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

	public java.lang.String getDynItId(){
		return dynItId;
	}

	public void setDynItId(java.lang.String dynItId){
		this.dynItId = dynItId;
	}

	public java.lang.String getDynVoteOpinion(){
		return dynVoteOpinion;
	}

	public void setDynVoteOpinion(java.lang.String dynVoteOpinion){
		this.dynVoteOpinion = dynVoteOpinion;
	}

	public java.lang.String getDynVoteId(){
		return dynVoteId;
	}

	public void setDynVoteId(java.lang.String dynVoteId){
		this.dynVoteId = dynVoteId;
	}

	public java.lang.String getDynVoteIp(){
		return dynVoteIp;
	}

	public void setDynVoteIp(java.lang.String dynVoteIp){
		this.dynVoteIp = dynVoteIp;
	}

	public java.lang.Integer getDynVoteLog(){
		return dynVoteLog;
	}

	public void setDynVoteLog(java.lang.Integer dynVoteLog){
		this.dynVoteLog = dynVoteLog;
	}

	public java.lang.String getOrgIdentity(){
		return orgIdentity;
	}

	public void setOrgIdentity(java.lang.String orgIdentity){
		this.orgIdentity = orgIdentity;
	}

	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "DYN_VOTE";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "DYN_VOTE";
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
