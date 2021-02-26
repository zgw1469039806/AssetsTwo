package avicit.cadreselect.dynvote.dto;

import java.util.ArrayList;
import java.util.List;

public class QueryVoteByIdDTO {


    //投票标题
    private String temTitle;

    //规则
    private String temNotice;

    //
    private List<VoteItem> list = new ArrayList<>();

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
    }

    public List<VoteItem> getList() {
        return list;
    }

    public void setList(List<VoteItem> list) {
        this.list = list;
    }

    //endregion

}
