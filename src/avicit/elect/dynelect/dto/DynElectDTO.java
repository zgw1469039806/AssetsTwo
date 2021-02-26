package avicit.elect.dynelect.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.math.BigDecimal;

/**
* @科技有限责任公司
* @作者：shiys
* @邮箱：260289963@qq.com
* @创建时间： 2021-02-05 00:18
* @类说明：选举表Dto
* @修改记录：
*/
@PojoRemark(table="DYN_ELECT", object="DynElectDTO", name="选举表")
public class DynElectDTO extends BeanDTO{
	private static final long serialVersionUID = 1L;

	/**
	* 选举名称
	*/
	@FieldRemark(column="NAME", field="name", name="选举名称")
	private java.lang.String name;

	/**
	* 状态 1 开启  0 关闭 默认0
	*/
	
	@FieldRemark(column="STATUS", field="status", name="状态", dataType="lookup", lookupType="elect_status")
	private java.lang.String status;
	private java.lang.String statusName;


	/**
	* 可赞成数
	*/
	@FieldRemark(column="AGREE_RULE_NUM", field="agreeRuleNum", name="可赞成数")
	private java.math.BigDecimal agreeRuleNum;

	/**
	* 应投数
	*/
	@FieldRemark(column="SHOULD_INVEST_NUM", field="shouldInvestNum", name="应投数")
	private java.math.BigDecimal shouldInvestNum;

	/**
	* 实到数
	*/
	@FieldRemark(column="SCENE_NUM", field="sceneNum", name="实到数")
	private java.math.BigDecimal sceneNum;

	/**
	* 登陆数
	*/
	@FieldRemark(column="LOGIN_NUM", field="loginNum", name="登陆数")
	private java.math.BigDecimal loginNum;

	/**
	* 实投数
	*/
	@FieldRemark(column="ACTUAL_INVEST_NUM", field="actualInvestNum", name="实投数")
	private java.math.BigDecimal actualInvestNum;

	/**
	* 规则描述
	*/
	@FieldRemark(column="RULE_DESC", field="ruleDesc", name="规则描述")
	private java.lang.String ruleDesc;

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
	 * 轮数
	 */
	@FieldRemark(column="ROUND_NUM", field="roundNum", name="轮数")
	private java.math.BigDecimal roundNum;

	/**
	 * 是否显示人员信息
	 */
	@FieldRemark(column="IS_SHOW_PERSONS", field="isShowPersons", name="是否显示人员信息", dataType="lookup", lookupType="SHOW_OR_HIDE")
	private java.math.BigDecimal isShowPersons;
	/**
	 * 是否显示票数
	 */
	@FieldRemark(column="IS_SHOW_VOTE_NUM", field="isShowVoteNum", name="是否显示票数", dataType="lookup", lookupType="SHOW_OR_HIDE")
	private java.math.BigDecimal isShowVoteNum;
	/**
	 * 是否显示排名
	 */
	@FieldRemark(column="IS_SHOW_RANKING", field="isShowRanking", name="是否显示排名", dataType="lookup", lookupType="SHOW_OR_HIDE")
	private java.math.BigDecimal isShowRanking;

	/**
	 * 扫码方案（1为多个二维码方案；2为1个二维码方案）
	 */
	@FieldRemark(column="SCAN_PLAN", field="scanPlan", name="扫码方案")
	private java.math.BigDecimal scanPlan;

	/**
	 * 选举活动标识
	 */
	@FieldRemark(column="GROUP_ID", field="groupId", name="选举活动标识")
	private java.lang.String groupId;

	public java.lang.String getName(){
    	return name;
    }

    public void setName(java.lang.String name){
    	this.name = name;
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
    public java.math.BigDecimal getAgreeRuleNum(){
    	return agreeRuleNum;
    }

    public void setAgreeRuleNum(java.math.BigDecimal agreeRuleNum){
    	this.agreeRuleNum = agreeRuleNum;
    }
    public java.math.BigDecimal getShouldInvestNum(){
    	return shouldInvestNum;
    }

    public void setShouldInvestNum(java.math.BigDecimal shouldInvestNum){
    	this.shouldInvestNum = shouldInvestNum;
    }
    public java.math.BigDecimal getSceneNum(){
    	return sceneNum;
    }

    public void setSceneNum(java.math.BigDecimal sceneNum){
    	this.sceneNum = sceneNum;
    }
    public java.math.BigDecimal getLoginNum(){
    	return loginNum;
    }

    public void setLoginNum(java.math.BigDecimal loginNum){
    	this.loginNum = loginNum;
    }
    public java.math.BigDecimal getActualInvestNum(){
    	return actualInvestNum;
    }

    public void setActualInvestNum(java.math.BigDecimal actualInvestNum){
    	this.actualInvestNum = actualInvestNum;
    }
    public java.lang.String getRuleDesc(){
    	return ruleDesc;
    }

    public void setRuleDesc(java.lang.String ruleDesc){
    	this.ruleDesc = ruleDesc;
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
	public BigDecimal getRoundNum() {
		return roundNum;
	}

	public void setRoundNum(BigDecimal roundNum) {
		this.roundNum = roundNum;
	}

	public BigDecimal getIsShowPersons() {
		return isShowPersons;
	}

	public void setIsShowPersons(BigDecimal isShowPersons) {
		this.isShowPersons = isShowPersons;
	}

	public BigDecimal getIsShowVoteNum() {
		return isShowVoteNum;
	}

	public void setIsShowVoteNum(BigDecimal isShowVoteNum) {
		this.isShowVoteNum = isShowVoteNum;
	}

	public BigDecimal getIsShowRanking() {
		return isShowRanking;
	}

	public void setIsShowRanking(BigDecimal isShowRanking) {
		this.isShowRanking = isShowRanking;
	}

	public BigDecimal getScanPlan() {
		return scanPlan;
	}

	public void setScanPlan(BigDecimal scanPlan) {
		this.scanPlan = scanPlan;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	@Override
	public String getLogFormName() {
		if (super.logFormName == null || "".equals(super.logFormName)) {
			return "选举表";
		}else{
			return super.logFormName;
		}
	}

	@Override
	public String getLogTitle() {
		if (super.logTitle == null || "".equals(super.logTitle)) {
			return "选举表";
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
