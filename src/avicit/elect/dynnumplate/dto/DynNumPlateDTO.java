package avicit.elect.dynnumplate.dto;

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
* @创建时间： 2021-02-05 09:30
* @类说明：号码牌表Dto
* @修改记录：
*/
@PojoRemark(table="DYN_NUM_PLATE", object="DynNumPlateDTO", name="号码牌表")
public class DynNumPlateDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 号码
	*/
	@FieldRemark(column="NUM", field="num", name="号码")
	private java.lang.String num;

	/**
	* 状态
	*/
	@FieldRemark(column="STATUS", field="status", name="状态")
	private java.lang.String status;

	/**
	* 创建时间起
	*/
	private java.util.Date creationDateBegin;
	
	/**
	* 创建时间止
	*/
	private java.util.Date creationDateEnd;

	/**
	* ID
	*/
	@Id
	@LogField
	@FieldRemark(column="ID", field="id", name="ID")
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
	* 组织ID
	*/
	@LogField
	@FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
	private java.lang.String orgIdentity;

	/**
	* 登录状态
	*/
	@FieldRemark(column="LOGIN_STATUS", field="loginStatus", name="登录状态")
	private java.lang.String loginStatus;

	/**
	* 备用字段1
	*/
	@FieldRemark(column="ATT_01", field="att01", name="备用字段1")
	private java.lang.String att01;

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


	public java.lang.String getNum(){
		return num;
	}

	public void setNum(java.lang.String num){
		this.num = num;
	}

	public java.lang.String getStatus(){
		return status;
	}

	public void setStatus(java.lang.String status){
		this.status = status;
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

	public java.lang.String getOrgIdentity(){
		return orgIdentity;
	}

	public void setOrgIdentity(java.lang.String orgIdentity){
		this.orgIdentity = orgIdentity;
	}

	public java.lang.String getLoginStatus(){
		return loginStatus;
	}

	public void setLoginStatus(java.lang.String loginStatus){
		this.loginStatus = loginStatus;
	}

	public java.lang.String getAtt01(){
		return att01;
	}

	public void setAtt01(java.lang.String att01){
		this.att01 = att01;
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
			return "号码牌表";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "号码牌表";
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
