package avicit.cadreselect.dyntemplate.dto;

import avicit.cadreselect.dynvote.dto.VoteItem;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class QueryDetailsDTO {

    private String temTitle;//投票标题

    private String temType;//投票类型 0-优秀干部投票开发文档(显示同意,反对) 1-XX部副部长人选推荐投票(同意,反对,弃权)

    private String temId;//投票轮次

    private String temNotice;//投票规则

    private Integer temVoteNum;//出票数

    private Integer temState;//状态 0-正常 1-暂停 2-终止

    private String temTypeName;//投票类型

    private Date temStartDate;//开始时间

    private Date temEndDate;//结束时间

    private Integer temShouldInvestNum;//应到数

    private Integer temScentNum;//实到数

    private Integer temActualInvestNum;;//实投数

    private List<DynTemItemDTO> list = new ArrayList<>();//候选人


    //region get set

    public String getTemTitle() {
        return temTitle;
    }

    public void setTemTitle(String temTitle) {
        this.temTitle = temTitle;
    }

    public String getTemType() {
        return temType;
    }

    public void setTemType(String temType) {
        this.temType = temType;
    }

    public String getTemId() {
        return temId;
    }

    public void setTemId(String temId) {
        this.temId = temId;
    }

    public List<DynTemItemDTO> getList() {
        return list;
    }

    public void setList(List<DynTemItemDTO> list) {
        this.list = list;
    }

    public Integer getTemShouldInvestNum() {
        return temShouldInvestNum;
    }

    public void setTemShouldInvestNum(Integer temShouldInvestNum) {
        this.temShouldInvestNum = temShouldInvestNum;
    }

    public String getTemNotice() {
        return temNotice;
    }

    public void setTemNotice(String temNotice) {
        this.temNotice = temNotice;
    }

    public Integer getTemVoteNum() {
        return temVoteNum;
    }

    public void setTemVoteNum(Integer temVoteNum) {
        this.temVoteNum = temVoteNum;
    }

    public Integer getTemState() {
        return temState;
    }

    public void setTemState(Integer temState) {
        this.temState = temState;
    }

    public String getTemTypeName() {
        return temTypeName;
    }

    public void setTemTypeName(String temTypeName) {
        this.temTypeName = temTypeName;
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

    public Integer getTemScentNum() {
        return temScentNum;
    }

    public void setTemScentNum(Integer temScentNum) {
        this.temScentNum = temScentNum;
    }

    public Integer getTemActualInvestNum() {
        return temActualInvestNum;
    }

    public void setTemActualInvestNum(Integer temActualInvestNum) {
        this.temActualInvestNum = temActualInvestNum;
    }

    //endregion
}
