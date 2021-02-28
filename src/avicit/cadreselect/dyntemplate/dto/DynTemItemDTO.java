package avicit.cadreselect.dyntemplate.dto;

import avicit.cadreselect.dynvote.dto.VoteItem;

import java.util.ArrayList;
import java.util.List;

public class DynTemItemDTO {

    /**
     * 候选人姓名
     */
    private java.lang.String tiUserName;//候选人姓名

    /**
     * 候选人部门
     */
    private java.lang.String tiUserDept;//候选人部门

    /**
     * 0-女 1-男
     */
    private java.lang.Integer tiUserSex;// 0-女 1-男

    /**
     * 职务
     */
    private java.lang.String tiUserPost;//职务

    /**
     * 生日
     */
    private java.lang.String tiUserBirth;//生日

    private String tiUserType;//0-候选人 1-推荐人

    private Integer up = 0;//推荐数量

    private Integer down = 0;//反对数量

    private Integer lost = 0;//弃权数量

    private List<VoteItem> items = new ArrayList<>();

    //region get set

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

    public String getTiUserBirth() {
        return tiUserBirth;
    }

    public void setTiUserBirth(String tiUserBirth) {
        this.tiUserBirth = tiUserBirth;
    }

    public String getTiUserType() {
        return tiUserType;
    }

    public void setTiUserType(String tiUserType) {
        this.tiUserType = tiUserType;
    }

    public List<VoteItem> getItems() {
        return items;
    }

    public void setItems(List<VoteItem> items) {
        this.items = items;
    }

    public Integer getUp() {
        return up;
    }

    public void setUp(Integer up) {
        this.up = up;
    }

    public Integer getDown() {
        return down;
    }

    public void setDown(Integer down) {
        this.down = down;
    }

    public Integer getLost() {
        return lost;
    }

    public void setLost(Integer lost) {
        this.lost = lost;
    }
    //endregion

}
