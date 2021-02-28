package avicit.cadreselect.dynvote.dto;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class QueryVoteByIdDTO {


    private String temTitle;//投票标题

    private String temNotice;//规则

    private String temType;//投票类型 0-优秀干部投票开发文档(显示同意,反对) 1-XX部副部长人选推荐投票(同意,反对,弃权)

    private String temId;//投票轮次

    private Integer is = 0;//是否投票 0-否 1-是

    private List<VoteItem> list = new ArrayList<>();//候选人

    private List<VoteItem> recommends = new ArrayList<>();//推荐人

    private List<String> temNotices = new ArrayList<>();//条件

    //region get set

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
        String[] split = temNotice.split("\\|");
        List<String> strings = Arrays.asList(split);
        temNotices.addAll(strings);
    }

    public List<VoteItem> getList() {
        return list;
    }

    public void setList(List<VoteItem> list) {
        this.list = list;
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

    public List<VoteItem> getRecommends() {
        return recommends;
    }

    public void setRecommends(List<VoteItem> recommends) {
        this.recommends = recommends;
    }

    public Integer getIs() {
        return is;
    }

    public void setIs(Integer is) {
        this.is = is;
    }

    public List<String> getTemNotices() {
        return temNotices;
    }

    public void setTemNotices(List<String> temNotices) {
        this.temNotices = temNotices;
    }

    //endregion

}
