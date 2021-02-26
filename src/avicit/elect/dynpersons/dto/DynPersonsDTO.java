package avicit.elect.dynpersons.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.util.Date;

/**
* @科技有限责任公司
* @作者：shiys
* @邮箱：260289963@qq.com
* @创建时间： 2021-02-05 00:05
* @类说明：候选人表Dto
* @修改记录：
*/
@PojoRemark(table="DYN_PERSONS", object="DynPersonsDTO", name="候选人表")
public class DynPersonsDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 序号
	*/
	@FieldRemark(column="NO", field="no", name="序号")
	private java.lang.String no;

	/**
	* 姓名
	*/
	@FieldRemark(column="NAME", field="name", name="姓名")
	private java.lang.String name;

	/**
	* 部门名称
	*/
	@FieldRemark(column="DEPT_NAME", field="deptName", name="部门名称")
	private java.lang.String deptName;

	/**
	* 专业
	*/
	@FieldRemark(column="MAJOR", field="major", name="专业")
	private java.lang.String major;

	/**
	* 状态
	*/
	@FieldRemark(column="STATUS", field="status", name="状态", dataType="lookup", lookupType="candidate_status")
	private java.lang.String status;
	private java.lang.String statusName;

	/**
	* 中选轮次
	*/
	@FieldRemark(column="TURN_NUM", field="turnNum", name="中选轮次")
	private java.math.BigDecimal turnNum;

	/**
	* 是否加星
	*/
	@FieldRemark(column="IF_MARK", field="ifMark", name="是否加星")
	private java.lang.String ifMark;

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

	/**
	 * 晋级/淘汰操作时间
	 */
	private java.util.Date operationDate;

	public java.lang.String getNo(){
		return no;
	}

	public void setNo(java.lang.String no){
		this.no = no;
	}

	public java.lang.String getName(){
		return name;
	}

	public void setName(java.lang.String name){
		this.name = name;
	}

	public java.lang.String getDeptName(){
		return deptName;
	}

	public void setDeptName(java.lang.String deptName){
		this.deptName = deptName;
	}

	public java.lang.String getMajor(){
		return major;
	}

	public void setMajor(java.lang.String major){
		this.major = major;
	}
	public java.lang.String getStatus(){
		return status;
	}

	public void setStatus(java.lang.String status){
		this.status = status;
	}

	public java.lang.String getStatusName(){
		return statusName;
	}

	public void setStatusName(java.lang.String statusName){
		this.statusName = statusName;
	}

	public java.math.BigDecimal getTurnNum(){
		return turnNum;
	}

	public void setTurnNum(java.math.BigDecimal turnNum){
		this.turnNum = turnNum;
	}

	public java.lang.String getIfMark(){
		return ifMark;
	}

	public void setIfMark(java.lang.String ifMark){
		this.ifMark = ifMark;
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

	public Date getOperationDate() {
		return operationDate;
	}

	public void setOperationDate(Date operationDate) {
		this.operationDate = operationDate;
	}

	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "候选人表";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "候选人表";
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
