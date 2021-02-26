package avicit.cadreselect.dynvote.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;

import javax.persistence.Id;

public class VoteItem {

    /**
     * 模板ITEM ID
     */
    private java.lang.String dynItId;

    /**
     * 意见
     */
    private java.lang.String dynVoteOpinion;

    /**
     * 标识
     */
    private java.lang.String dynVoteId;

    /**
     * 主键
     */
    private java.lang.String id;

    /**
     * 候选人姓名
     */
    private java.lang.String tiUserName;

    /**
     * 候选人部门
     */
    private java.lang.String tiUserDept;

    /**
     * 0- 女 1-男
     */
    private java.lang.Integer tiUserSex;

    /**
     * 职务
     */
    private java.lang.String tiUserPost;


    //region get set

    public String getDynItId() {
        return dynItId;
    }

    public void setDynItId(String dynItId) {
        this.dynItId = dynItId;
    }

    public String getDynVoteOpinion() {
        return dynVoteOpinion;
    }

    public void setDynVoteOpinion(String dynVoteOpinion) {
        this.dynVoteOpinion = dynVoteOpinion;
    }

    public String getDynVoteId() {
        return dynVoteId;
    }

    public void setDynVoteId(String dynVoteId) {
        this.dynVoteId = dynVoteId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Integer getTiUserSex() {
        return tiUserSex;
    }

    public void setTiUserSex(Integer tiUserSex) {
        this.tiUserSex = tiUserSex;
    }

    public String getTiUserPost() {
        return tiUserPost;
    }

    public void setTiUserPost(String tiUserPost) {
        this.tiUserPost = tiUserPost;
    }


    //endregion
}
