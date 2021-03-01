package avicit.cadreselect.dyntemplate.dto;

import avicit.platform6.core.annotation.log.FieldRemark;

import java.util.Date;

public class DynTemAndTIMEDTO {

    /**
     * 模板名称
     */
    private java.lang.String temTitle;


    /**
     * 开始时间
     */
    private java.util.Date creationDateBegin;

    /**
     * 结束时间
     */
    private java.util.Date creationDateEnd;

    /**
     * 候选人姓名
     */
    private java.lang.String tiUserName;//候选人姓名

    /**
     * 候选人部门
     */
    private java.lang.String tiUserDept;//候选人部门

    /**
     * 职务
     */
    private java.lang.String tiUserPost;//职务

    /**
     * 0-女 1-男
     */
    private java.lang.Integer tiUserSex;// 0-女 1-男

    /**
     * 生日
     */
    private java.lang.String tiUserBirth;//生日

    /**
     * 意见
     */
    private java.lang.String dynVoteOpinion;


    public String getTemTitle() {
        return temTitle;
    }

    public void setTemTitle(String temTitle) {
        this.temTitle = temTitle;
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

    public String getTiUserName() {
        return tiUserName;
    }

    public void setTiUserName(String tiUserName) {
        this.tiUserName = tiUserName;
    }

    public String getTiUserDept() {
        return tiUserDept;
    }

    public void setTiUserDept(String tiUserDept) {
        this.tiUserDept = tiUserDept;
    }

    public String getTiUserPost() {
        return tiUserPost;
    }

    public void setTiUserPost(String tiUserPost) {
        this.tiUserPost = tiUserPost;
    }

    public Integer getTiUserSex() {
        return tiUserSex;
    }

    public void setTiUserSex(Integer tiUserSex) {
        this.tiUserSex = tiUserSex;
    }

    public String getTiUserBirth() {
        return tiUserBirth;
    }

    public void setTiUserBirth(String tiUserBirth) {
        this.tiUserBirth = tiUserBirth;
    }

    public String getDynVoteOpinion() {
        return dynVoteOpinion;
    }

    public void setDynVoteOpinion(String dynVoteOpinion) {
        this.dynVoteOpinion = dynVoteOpinion;
    }
}
