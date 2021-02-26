package avicit.assets.device.usercollect.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写 @创建时间： 2020-06-11 11:13
 * @类说明：USER_COLLECT @修改记录：
 */
@PojoRemark(table = "user_collect", object = "UserCollectDTO", name = "USER_COLLECT")
public class UserCollectDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "user_id", field = "userId", name = "用户id")
	/*
	 * 用户id
	 */
	private java.lang.String userId;
	
	@Id
	@LogField
	@FieldRemark(column = "node_id", field = "nodeId", name = "收藏节点的id")
	/*
	 * 收藏节点的id
	 */
	private java.lang.String nodeId;

	@FieldRemark(column = "node_pid", field = "nodePid", name = "收藏节点的原父id")
	/*
	 * 收藏节点的原父id
	 */
	private java.lang.String nodePid;

	@FieldRemark(column = "new_node_pid", field = "newNodePid", name = "收藏节点的新父id")
	/*
	 * 收藏节点的新父id
	 */
	private java.lang.String newNodePid;

	@FieldRemark(column = "node_name", field = "nodeName", name = "收藏节点名称")
	/*
	 * 收藏节点名称
	 */
	private java.lang.String nodeName;

	@FieldRemark(column = "node_url", field = "nodeUrl", name = "收藏节点的url")
	/*
	 * 收藏节点的url
	 */
	private java.lang.String nodeUrl;

	@FieldRemark(column = "node_sn", field = "nodeSn", name = "收藏节点的排序编号")
	/*
	 * 收藏节点的排序编号
	 */
	private Long nodeSn;

	@FieldRemark(column = "node_treepath", field = "nodeTreepath", name = "收藏节点的tree Path")
	/*
	 * 收藏节点的tree Path
	 */
	private java.lang.String nodeTreepath;

	@FieldRemark(column = "item_num", field = "itemNum", name = "ITEM_NUM")
	/*
	 * ITEM_NUM
	 */
	private java.lang.String itemNum;

	public String getItemNum() {
		return itemNum;
	}

	public void setItemNum(String itemNum) {
		this.itemNum = itemNum;
	}

	public java.lang.String getUserId() {
		return userId;
	}

	public void setUserId(java.lang.String userId) {
		this.userId = userId;
	}

	public java.lang.String getNodeId() {
		return nodeId;
	}

	public void setNodeId(java.lang.String nodeId) {
		this.nodeId = nodeId;
	}

	public java.lang.String getNodePid() {
		return nodePid;
	}

	public void setNodePid(java.lang.String nodePid) {
		this.nodePid = nodePid;
	}

	public java.lang.String getNewNodePid() {
		return newNodePid;
	}

	public void setNewNodePid(java.lang.String newNodePid) {
		this.newNodePid = newNodePid;
	}

	public java.lang.String getNodeName() {
		return nodeName;
	}

	public void setNodeName(java.lang.String nodeName) {
		this.nodeName = nodeName;
	}

	public java.lang.String getNodeUrl() {
		return nodeUrl;
	}

	public void setNodeUrl(java.lang.String nodeUrl) {
		this.nodeUrl = nodeUrl;
	}

	public Long getNodeSn() {
		return nodeSn;
	}

	public void setNodeSn(Long nodeSn) {
		this.nodeSn = nodeSn;
	}

	public java.lang.String getNodeTreepath() {
		return nodeTreepath;
	}

	public void setNodeTreepath(java.lang.String nodeTreepath) {
		this.nodeTreepath = nodeTreepath;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "USER_COLLECT";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "USER_COLLECT";
		} else {
			return super.logTitle;
		}
	}

	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}