package avicit.cadreselect.dyntemitem.dto;

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
* @创建时间： 2021-02-24 12:54
* @类说明：DYN_TEM_ITEMDto
* @修改记录：
*/
@PojoRemark(table="DYN_TEM_ITEM", object="DynTemItemDTO", name="DYN_TEM_ITEM")
public class DynTemItemDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 模板表ID
	*/
	@FieldRemark(column="TEM_ID", field="temId", name="模板表ID")
	private java.lang.String temId;

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
	* 候选人姓名
	*/
	@FieldRemark(column="TI_USER_NAME", field="tiUserName", name="候选人姓名")
	private java.lang.String tiUserName;

	/**
	* 候选人部门
	*/
	@FieldRemark(column="TI_USER_DEPT", field="tiUserDept", name="候选人部门")
	private java.lang.String tiUserDept;

	/**
	* 候选人意见
	*/
	@FieldRemark(column="TI_OPINION", field="tiOpinion", name="候选人意见")
	private java.lang.Integer tiOpinion;

	/**
	* 应投数
	*/
	@FieldRemark(column="TI_SHOULD_INVEST_NUM", field="tiShouldInvestNum", name="应投数")
	private java.math.BigDecimal tiShouldInvestNum;

	/**
	* 实投数
	*/
	@FieldRemark(column="TI_ACTUAL_INVEST_NUM", field="tiActualInvestNum", name="实投数")
	private java.math.BigDecimal tiActualInvestNum;

	/**
	* 登陆数
	*/
	@FieldRemark(column="TI_LOGIN_NUM", field="tiLoginNum", name="登陆数")
	private java.math.BigDecimal tiLoginNum;

	/**
	* 实到数
	*/
	@FieldRemark(column="TI_SCENE_NUM", field="tiSceneNum", name="实到数")
	private java.math.BigDecimal tiSceneNum;

	/**
	* 开始时间
	*/
	@FieldRemark(column="TI_START_DATE", field="tiStartDate", name="开始时间")
	private java.util.Date tiStartDate;
	
	/**
	* 开始时间起
	*/
	private java.util.Date tiStartDateBegin;
	
	/**
	* 开始时间止
	*/
	private java.util.Date tiStartDateEnd;

	/**
	* 结束时间
	*/
	@FieldRemark(column="TI_END_DATE", field="tiEndDate", name="结束时间")
	private java.util.Date tiEndDate;
	
	/**
	* 结束时间起
	*/
	private java.util.Date tiEndDateBegin;
	
	/**
	* 结束时间止
	*/
	private java.util.Date tiEndDateEnd;

	/**
	* 0-使用中 1-暂停 2-删除
	*/
	@FieldRemark(column="TI_STATE", field="tiState", name="0-使用中 1-暂停 2-删除")
	private java.lang.Integer tiState;

	/**
	* 表格JSON
	*/
	@FieldRemark(column="TI_TEXT", field="tiText", name="表格JSON")
	private java.lang.String tiText;

	/**
	* 0- 女 1-男
	*/
	@FieldRemark(column="TI_USER_SEX", field="tiUserSex", name="0- 女 1-男")
	private java.lang.Integer tiUserSex;

	/**
	* 职务
	*/
	@FieldRemark(column="TI_USER_POST", field="tiUserPost", name="职务")
	private java.lang.String tiUserPost;

	/**
	* 组织ID
	*/
	@LogField
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;


	public java.lang.String getTemId(){
		return temId;
	}

	public void setTemId(java.lang.String temId){
		this.temId = temId;
	}

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

	public java.lang.String getTiUserName(){
		return tiUserName;
	}

	public void setTiUserName(java.lang.String tiUserName){
		this.tiUserName = tiUserName;
	}

	public java.lang.String getTiUserDept(){
		return tiUserDept;
	}

	public void setTiUserDept(java.lang.String tiUserDept){
		this.tiUserDept = tiUserDept;
	}

	public java.lang.Integer getTiOpinion(){
		return tiOpinion;
	}

	public void setTiOpinion(java.lang.Integer tiOpinion){
		this.tiOpinion = tiOpinion;
	}

	public java.math.BigDecimal getTiShouldInvestNum(){
		return tiShouldInvestNum;
	}

	public void setTiShouldInvestNum(java.math.BigDecimal tiShouldInvestNum){
		this.tiShouldInvestNum = tiShouldInvestNum;
	}

	public java.math.BigDecimal getTiActualInvestNum(){
		return tiActualInvestNum;
	}

	public void setTiActualInvestNum(java.math.BigDecimal tiActualInvestNum){
		this.tiActualInvestNum = tiActualInvestNum;
	}

	public java.math.BigDecimal getTiLoginNum(){
		return tiLoginNum;
	}

	public void setTiLoginNum(java.math.BigDecimal tiLoginNum){
		this.tiLoginNum = tiLoginNum;
	}

	public java.math.BigDecimal getTiSceneNum(){
		return tiSceneNum;
	}

	public void setTiSceneNum(java.math.BigDecimal tiSceneNum){
		this.tiSceneNum = tiSceneNum;
	}

	public java.util.Date getTiStartDate(){
		return tiStartDate;
	}

	public void setTiStartDate(java.util.Date tiStartDate){
		this.tiStartDate = tiStartDate;
	}

	public java.util.Date getTiStartDateBegin(){
		return tiStartDateBegin;
	}

	public void setTiStartDateBegin(java.util.Date tiStartDateBegin){
		this.tiStartDateBegin = tiStartDateBegin;
	}

	public java.util.Date getTiStartDateEnd(){
		return tiStartDateEnd;
	}

	public void setTiStartDateEnd(java.util.Date tiStartDateEnd){
		this.tiStartDateEnd = tiStartDateEnd;
	}

	public java.util.Date getTiEndDate(){
		return tiEndDate;
	}

	public void setTiEndDate(java.util.Date tiEndDate){
		this.tiEndDate = tiEndDate;
	}

	public java.util.Date getTiEndDateBegin(){
		return tiEndDateBegin;
	}

	public void setTiEndDateBegin(java.util.Date tiEndDateBegin){
		this.tiEndDateBegin = tiEndDateBegin;
	}

	public java.util.Date getTiEndDateEnd(){
		return tiEndDateEnd;
	}

	public void setTiEndDateEnd(java.util.Date tiEndDateEnd){
		this.tiEndDateEnd = tiEndDateEnd;
	}

	public java.lang.Integer getTiState(){
		return tiState;
	}

	public void setTiState(java.lang.Integer tiState){
		this.tiState = tiState;
	}

	public java.lang.String getTiText(){
		return tiText;
	}

	public void setTiText(java.lang.String tiText){
		this.tiText = tiText;
	}

	public java.lang.Integer getTiUserSex(){
		return tiUserSex;
	}

	public void setTiUserSex(java.lang.Integer tiUserSex){
		this.tiUserSex = tiUserSex;
	}

	public java.lang.String getTiUserPost(){
		return tiUserPost;
	}

	public void setTiUserPost(java.lang.String tiUserPost){
		this.tiUserPost = tiUserPost;
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
			return "DYN_TEM_ITEM";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "DYN_TEM_ITEM";
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
