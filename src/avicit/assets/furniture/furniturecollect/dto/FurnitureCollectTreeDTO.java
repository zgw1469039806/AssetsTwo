package avicit.assets.furniture.furniturecollect.dto;

import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写 @创建时间： 2020-06-11 11:13
 * @类说明：FURNITURE_COLLECT @修改记录：
 */
@PojoRemark(table = "furniture_collect", object = "FurnitureCollectTreeDTO", name = "FURNITURE_COLLECT")
public class FurnitureCollectTreeDTO{
	@LogField
	@FieldRemark(column = "node_id", field = "nodeId", name = "收藏节点的id")
	/*
	 * 收藏节点的id
	 */
	private java.lang.String id;

	@FieldRemark(column = "new_node_pid", field = "newNodePid", name = "收藏节点的新父id")
	/*
	 * 收藏节点的新父id
	 */
	private java.lang.String pId;

	@FieldRemark(column = "node_name", field = "nodeName", name = "收藏节点名称")
	/*
	 * 收藏节点名称
	 */
	private java.lang.String name;

	@FieldRemark(column = "node_url", field = "nodeUrl", name = "收藏节点的url")
	/*
	 * 收藏节点的url
	 */
	private java.lang.String url;


	@FieldRemark(column = "node_treepath", field = "nodeTreepath", name = "收藏节点的tree Path")
	/*
	 * 收藏节点的tree Path
	 */
	private java.lang.String treePath;

	@FieldRemark(column = "item_num", field = "itemNum", name = "ITEM_NUM")
	private java.lang.String itemNum;

	public java.lang.String getItemNum() {
		return itemNum;
	}
	public void setItemNum(java.lang.String itemNum) {
		this.itemNum = itemNum;
	}

	public java.lang.String getId() {
		return id;
	}
	public void setId(java.lang.String id) {
		this.id = id;
	}


	public java.lang.String getPId() {
		return pId;
	}
	public void setPId(java.lang.String pId) {
		this.pId = pId;
	}


	public java.lang.String getName() {
		return name;
	}
	public void setName(java.lang.String name) {
		this.name = name;
	}


	public java.lang.String getUrl() {
		return url;
	}
	public void setUrl(java.lang.String url) {
		this.url = url;
	}

	public java.lang.String getTreePath() {
		return treePath;
	}
	public void setTreePath(java.lang.String treepath) {
		this.treePath = treepath;
	}
}