package avicit.cadreselect.dynvote.bo;

import avicit.cadreselect.dynvote.dto.VoteItem;

import java.util.ArrayList;
import java.util.List;

/**
 * 保存投票
 */
public class SendVoteBO {

    private String id;//投票id

    private String temId;//轮次id

    private List<VoteItem> list = new ArrayList<>();//候选人list

    private List<VoteItem> recommends = new ArrayList<>();//推荐人list

    //region get set

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<VoteItem> getList() {
        return list;
    }

    public void setList(List<VoteItem> list) {
        this.list = list;
    }

    public List<VoteItem> getRecommends() {
        return recommends;
    }

    public void setRecommends(List<VoteItem> recommends) {
        this.recommends = recommends;
    }

    public String getTemId() {
        return temId;
    }

    public void setTemId(String temId) {
        this.temId = temId;
    }
//endregion

}
