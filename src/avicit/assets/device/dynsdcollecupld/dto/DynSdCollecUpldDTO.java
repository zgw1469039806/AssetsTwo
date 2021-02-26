package avicit.assets.device.dynsdcollecupld.dto;

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
 * @创建时间： 2020-07-20 15:42
 * @类说明：DYN_SD_COLLEC_UPLD
 * @修改记录：
 */
@PojoRemark(table = "dyn_sd_collec_upld", object = "DynSdCollecUpldDTO", name = "DYN_SD_COLLEC_UPLD")
public class DynSdCollecUpldDTO extends BeanDTO {
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

    @FieldRemark(column = "author", field = "author", name = "上报人")
    /*
     *上报人
     */
    private String author;
    /*
     *上报人显示字段
     */
    private String authorAlias;
    /*
     *LAST_UPDATE_DATE开始时间
     */
    private java.util.Date lastUpdateDateBegin;
    /*
     *LAST_UPDATE_DATE截止时间
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

    @FieldRemark(column = "releasedate", field = "releasedate", name = "上报日期")
    /*
     *上报日期
     */
    private java.util.Date releasedate;
    /*
     *上报日期开始时间
     */
    private java.util.Date releasedateBegin;
    /*
     *上报日期截止时间
     */
    private java.util.Date releasedateEnd;

    @FieldRemark(column = "dept", field = "dept", name = "上报单位")
    /*
     *上报单位
     */
    private String dept;
    /*
     *上报单位显示字段
     */
    private String deptAlias;

    @FieldRemark(column = "tel", field = "tel", name = "电话")
    /*
     *电话
     */
    private String tel;

    @FieldRemark(column = "collect_select", field = "collectSelect", name = "关联征集单")
    /*
     *关联征集单
     */
    private String collectSelect;

    @FieldRemark(column = "collect_year", field = "collectYear", name = "年度")
    /*
     *年度
     */
    private String collectYear;

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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getAuthorAlias() {
        return authorAlias;
    }

    public void setAuthorAlias(String authorAlias) {
        this.authorAlias = authorAlias;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getCollectSelect() {
        return collectSelect;
    }

    public void setCollectSelect(String collectSelect) {
        this.collectSelect = collectSelect;
    }

    public String getCollectYear() {
        return collectYear;
    }

    public void setCollectYear(String collectYear) {
        this.collectYear = collectYear;
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

    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "DYN_SD_COLLEC_UPLD";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "DYN_SD_COLLEC_UPLD";
        } else {
            return super.logTitle;
        }
    }

    public String getCurrUserId() {
        return currUserId;
    }

    public void setCurrUserId(String currUserId) {
        this.currUserId = currUserId;
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

    public LogType getLogType() {
        if (super.logType == null || super.logType.equals("")) {
            return LogType.module_operate;
        } else {
            return super.logType;
        }
    }

}