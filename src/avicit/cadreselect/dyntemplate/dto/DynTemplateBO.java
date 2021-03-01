package avicit.cadreselect.dyntemplate.dto;


import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;

import javax.persistence.Id;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DynTemplateBO {

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
    private java.util.Date lastUpdateDate;

    /**
     * 最后更新时间止
     */
    private java.util.Date lastUpdateDateEnd;

    /**
     * 创建时间起
     */
    private java.util.Date creationDate;

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
    private Integer temShouldInvestNum;

    /**
     * 实投数
     */
    @FieldRemark(column="TEM_ACTUAL_INVEST_NUM", field="temActualInvestNum", name="实投数")
    private Integer temActualInvestNum;

    @FieldRemark(column="TEM_VOTE_NUM", field="temVoteNum", name="出票数")
    private Integer temVoteNum;

    private String lastUpdateIp;

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

    private String lastUpdatedBy;

    /**
     * 组织ID
     */
    @LogField
    @FieldRemark(column="ORG_IDENTITY", field="orgIdentity", name="组织ID")
    private java.lang.String orgIdentity;

    private java.util.Date temStartDate;//开始时间

    private java.util.Date temEndDate;//结束时间

    private List<DynTemItemDTO> dynTemItemDTOArrayList = new ArrayList<>();


    //region get set
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getLastUpdateDateEnd() {
        return lastUpdateDateEnd;
    }

    public void setLastUpdateDateEnd(Date lastUpdateDateEnd) {
        this.lastUpdateDateEnd = lastUpdateDateEnd;
    }


    public Date getCreationDateEnd() {
        return creationDateEnd;
    }

    public void setCreationDateEnd(Date creationDateEnd) {
        this.creationDateEnd = creationDateEnd;
    }

    public String getTemTitle() {
        return temTitle;
    }

    public void setTemTitle(String temTitle) {
        this.temTitle = temTitle;
    }

    public String getTemNotice() {
        return temNotice;
    }

    public void setTemNotice(String temNotice) {
        this.temNotice = temNotice;
    }

    public String getTemText() {
        return temText;
    }

    public void setTemText(String temText) {
        this.temText = temText;
    }

    public Integer getTemShouldInvestNum() {
        return temShouldInvestNum;
    }

    public void setTemShouldInvestNum(Integer temShouldInvestNum) {
        this.temShouldInvestNum = temShouldInvestNum;
    }

    public Integer getTemActualInvestNum() {
        return temActualInvestNum;
    }

    public void setTemActualInvestNum(Integer temActualInvestNum) {
        this.temActualInvestNum = temActualInvestNum;
    }

    public BigDecimal getTemSceneNum() {
        return temSceneNum;
    }

    public void setTemSceneNum(BigDecimal temSceneNum) {
        this.temSceneNum = temSceneNum;
    }

    public Integer getTemType() {
        return temType;
    }

    public void setTemType(Integer temType) {
        this.temType = temType;
    }

    public String getTemTypeName() {
        return temTypeName;
    }

    public void setTemTypeName(String temTypeName) {
        this.temTypeName = temTypeName;
    }

    public Integer getTemState() {
        return temState;
    }

    public void setTemState(Integer temState) {
        this.temState = temState;
    }

    public String getOrgIdentity() {
        return orgIdentity;
    }

    public void setOrgIdentity(String orgIdentity) {
        this.orgIdentity = orgIdentity;
    }

    public List<DynTemItemDTO> getDynTemItemDTOArrayList() {
        return dynTemItemDTOArrayList;
    }

    public void setDynTemItemDTOArrayList(List<DynTemItemDTO> dynTemItemDTOArrayList) {
        this.dynTemItemDTOArrayList = dynTemItemDTOArrayList;
    }

    public Date getLastUpdateDate() {
        return lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getLastUpdateIp() {
        return lastUpdateIp;
    }

    public void setLastUpdateIp(String lastUpdateIp) {
        this.lastUpdateIp = lastUpdateIp;
    }

    public String getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    public Integer getTemVoteNum() {
        return temVoteNum;
    }

    public void setTemVoteNum(Integer temVoteNum) {
        this.temVoteNum = temVoteNum;
    }

    public Date getTemStartDate() {
        return temStartDate;
    }

    public void setTemStartDate(Date temStartDate) {
        this.temStartDate = temStartDate;
    }

    public Date getTemEndDate() {
        return temEndDate;
    }

    public void setTemEndDate(Date temEndDate) {
        this.temEndDate = temEndDate;
    }
//endregion
}
