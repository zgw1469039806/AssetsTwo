package avicit.assets.device.dynreconmsg.dto;

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
 * @创建时间： 2020-09-04 19:14 
 * @类说明：DYN_RECON_MSG
 * @修改记录： 
 */
@PojoRemark(table = "dyn_recon_msg", object = "DynReconMsgDTO", name = "DYN_RECON_MSG")
public class DynReconMsgDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
	private String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 *ID
	 */
	private String id;

	@FieldRemark(column = "apply_year", field = "applyYear", name = "年度")
	/*
	 *年度
	 */
	private String applyYear;

	@FieldRemark(column = "author", field = "author", name = "字段_1")
	/*
	 *字段_1
	 */
	private String author;

	@FieldRemark(column = "releasedate", field = "releasedate", name = "发布日期")
	/*
	 *发布日期
	 */
	private java.util.Date releasedate;
	/*
	 *发布日期开始时间
	 */
	private java.util.Date releasedateBegin;
	/*
	 *发布日期截止时间
	 */
	private java.util.Date releasedateEnd;
	/*
	*最后更新时间开始时间
	*/
	private java.util.Date lastUpdateDateBegin;
	/*
	 *最后更新时间截止时间
	 */
	private java.util.Date lastUpdateDateEnd;
	/*
	*创建时间开始时间
	*/
	private java.util.Date creationDateBegin;
	/*
	 *创建时间截止时间
	 */
	private java.util.Date creationDateEnd;

	@FieldRemark(column = "dept_deadline", field = "deptDeadline", name = "部门上报截至日期")
	/*
	 *部门上报截至日期
	 */
	private java.util.Date deptDeadline;
	/*
	 *部门上报截至日期开始时间
	 */
	private java.util.Date deptDeadlineBegin;
	/*
	 *部门上报截至日期截止时间
	 */
	private java.util.Date deptDeadlineEnd;

	@FieldRemark(column = "telephone", field = "telephone", name = "电话")
	/*
	 *电话
	 */
	private String telephone;

	@FieldRemark(column = "dept", field = "dept", name = "发布人部门")
	/*
	 *发布人部门
	 */
	private String dept;
	/*
	 *发布人部门显示字段
	 */
	private String deptAlias;

	@FieldRemark(column = "form_remarks", field = "formRemarks", name = "备注")
	/*
	 *备注
	 */
	private String formRemarks;

	@FieldRemark(column = "form_title", field = "formTitle", name = "标题")
	/*
	 *标题
	 */
	private String formTitle;

	@FieldRemark(column = "org_identity", field = "orgIdentity", name = "组织ID")
	/*
	 *组织ID
	 */
	private String orgIdentity;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getApplyYear() {
		return applyYear;
	}

	public void setApplyYear(String applyYear) {
		this.applyYear = applyYear;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public java.util.Date getReleasedate() {
		return releasedate;
	}

	public void setReleasedate(java.util.Date releasedate) {
		this.releasedate = releasedate;
	}

	public java.util.Date getReleasedateBegin() {
		return releasedateBegin;
	}

	public void setReleasedateBegin(java.util.Date releasedateBegin) {
		this.releasedateBegin = releasedateBegin;
	}

	public java.util.Date getReleasedateEnd() {
		return releasedateEnd;
	}

	public void setReleasedateEnd(java.util.Date releasedateEnd) {
		this.releasedateEnd = releasedateEnd;
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

	public java.util.Date getDeptDeadline() {
		return deptDeadline;
	}

	public void setDeptDeadline(java.util.Date deptDeadline) {
		this.deptDeadline = deptDeadline;
	}

	public java.util.Date getDeptDeadlineBegin() {
		return deptDeadlineBegin;
	}

	public void setDeptDeadlineBegin(java.util.Date deptDeadlineBegin) {
		this.deptDeadlineBegin = deptDeadlineBegin;
	}

	public java.util.Date getDeptDeadlineEnd() {
		return deptDeadlineEnd;
	}

	public void setDeptDeadlineEnd(java.util.Date deptDeadlineEnd) {
		this.deptDeadlineEnd = deptDeadlineEnd;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getDeptAlias() {
		return deptAlias;
	}

	public void setDeptAlias(String deptAlias) {
		this.deptAlias = deptAlias;
	}

	public String getFormRemarks() {
		return formRemarks;
	}

	public void setFormRemarks(String formRemarks) {
		this.formRemarks = formRemarks;
	}

	public String getFormTitle() {
		return formTitle;
	}

	public void setFormTitle(String formTitle) {
		this.formTitle = formTitle;
	}

	public String getOrgIdentity() {
		return orgIdentity;
	}

	public void setOrgIdentity(String orgIdentity) {
		this.orgIdentity = orgIdentity;
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
			return "DYN_RECON_MSG";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "DYN_RECON_MSG";
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