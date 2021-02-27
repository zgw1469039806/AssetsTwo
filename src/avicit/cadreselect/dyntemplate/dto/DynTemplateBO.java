package avicit.cadreselect.dyntemplate.dto;


import avicit.cadreselect.dynperson.dao.DynPersonDAO;
import avicit.cadreselect.dynperson.dto.DynPersonDTO;
import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;

import javax.persistence.Id;
import java.math.BigDecimal;
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
     * 登陆数
     */
    @FieldRemark(column="TEM_LOGIN_NUM", field="temLoginNum", name="登陆数")
    private java.math.BigDecimal temLoginNum;

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

    private List<DynTemItemDTO> dynTemItemDTOArrayList = new ArrayList<>();


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getLastUpdateDateBegin() {
        return lastUpdateDateBegin;
    }

    public void setLastUpdateDateBegin(Date lastUpdateDateBegin) {
        this.lastUpdateDateBegin = lastUpdateDateBegin;
    }

    public Date getLastUpdateDateEnd() {
        return lastUpdateDateEnd;
    }

    public void setLastUpdateDateEnd(Date lastUpdateDateEnd) {
        this.lastUpdateDateEnd = lastUpdateDateEnd;
    }

    public Date getCreationDateBegin() {
        return creationDateBegin;
    }

    public void setCreationDateBegin(Date creationDateBegin) {
        this.creationDateBegin = creationDateBegin;
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

    public BigDecimal getTemShouldInvestNum() {
        return temShouldInvestNum;
    }

    public void setTemShouldInvestNum(BigDecimal temShouldInvestNum) {
        this.temShouldInvestNum = temShouldInvestNum;
    }

    public BigDecimal getTemActualInvestNum() {
        return temActualInvestNum;
    }

    public void setTemActualInvestNum(BigDecimal temActualInvestNum) {
        this.temActualInvestNum = temActualInvestNum;
    }

    public BigDecimal getTemLoginNum() {
        return temLoginNum;
    }

    public void setTemLoginNum(BigDecimal temLoginNum) {
        this.temLoginNum = temLoginNum;
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
}
