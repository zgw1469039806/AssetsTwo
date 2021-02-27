package avicit.cadreselect.dynperson.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.util.Date;

/**
* @金航数码科技有限责任公司
* @作者：one
* @邮箱：邮箱
* @创建时间： 2021-02-24 11:44
* @类说明：DYN_PERSONDto
* @修改记录：
*/
@PojoRemark(table="DYN_PERSON", object="DynPersonDTO", name="DYN_PERSON")
public class DynPersonDTO extends BeanDTO{
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
	* 姓名
	*/
	@LogField
	@FieldRemark(column="PER_NAME", field="perName", name="姓名")
	private java.lang.String perName;

	/**
	* 部门
	*/
	@FieldRemark(column="PER_DEPT", field="perDept", name="部门")
	private java.lang.String perDept;

	/**
	* 性别
	*/
	@FieldRemark(column="PER_SEX", field="perSex", name="性别")
	private java.lang.Integer perSex;

	/**
	* 出生年月
	*/
	@FieldRemark(column="PER_BIRTH", field="perBirth", name="出生年月")
	private java.lang.String perBirth;

	/**
	* 组织ID
	*/
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;

	/**
	 * 职务
	 */
	@FieldRemark(column="PER_POST", field="perPost", name="职务")
	private java.lang.String perPost;

	//region get set
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

	public java.lang.String getPerName(){
		return perName;
	}

	public void setPerName(java.lang.String perName){
		this.perName = perName;
	}

	public java.lang.String getPerDept(){
		return perDept;
	}

	public void setPerDept(java.lang.String perDept){
		this.perDept = perDept;
	}

	public java.lang.Integer getPerSex(){
		return perSex;
	}

	public void setPerSex(java.lang.Integer perSex){
		this.perSex = perSex;
	}

	public java.lang.String getPerBirth(){
		return perBirth;
	}

	public void setPerBirth(java.lang.String perBirth){
		this.perBirth = perBirth;
	}

	public java.lang.String getOrgIdentity(){
		return orgIdentity;
	}

	public void setOrgIdentity(java.lang.String orgIdentity){
		this.orgIdentity = orgIdentity;
	}

	public String getPerPost() {
		return perPost;
	}

	public void setPerPost(String perPost) {
		this.perPost = perPost;
	}

	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "DYN_PERSON";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "DYN_PERSON";
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

	//endregion
}
