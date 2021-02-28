package avicit.cadreselect.dyntemplate.dto;

import avicit.cadreselect.dynvote.dto.VoteItem;

import java.util.ArrayList;
import java.util.List;

public class QueryDetailsDTO {

    private String temTitle;//投票标题

    private String temType;//投票类型 0-优秀干部投票开发文档(显示同意,反对) 1-XX部副部长人选推荐投票(同意,反对,弃权)

    private String temId;//投票轮次

    private Integer temShouldInvestNum;//应投数

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

    //endregion
}
