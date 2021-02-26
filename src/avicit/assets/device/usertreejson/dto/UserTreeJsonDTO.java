package avicit.assets.device.usertreejson.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写 @创建时间： 2020-06-05 10:55
 * @类说明：USER_TREE_JSON @修改记录：
 */
@PojoRemark(table = "user_tree_json", object = "UserTreeJsonDTO", name = "USER_TREE_JSON")
public class UserTreeJsonDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "ID")
	private java.lang.String id;

	@FieldRemark(column = "belong_object_id", field = "belongObjectId", name = "所属对象的ID")
	private java.lang.String belongObjectId;

	@FieldRemark(column = "tree_name", field = "treeName", name = "对应的树名称")
	private java.lang.String treeName;

	@FieldRemark(column = "tree_json", field = "treeJson", name = "树Json")
	private java.lang.String treeJson;

	@FieldRemark(column = "object_type", field = "objectType", name = "所属对象类型：用户、角色")
	private java.lang.String objectType;

	public java.lang.String getId() {
		return id;
	}
	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getBelongObjectId() {
		return belongObjectId;
	}
	public void setBelongObjectId(java.lang.String belongObjectId) {
		this.belongObjectId = belongObjectId;
	}

	public java.lang.String getTreeName() {
		return treeName;
	}
	public void setTreeName(java.lang.String treeName) {
		this.treeName = treeName;
	}

	public java.lang.String getTreeJson() {
		return treeJson;
	}
	public void setTreeJson(java.lang.String treeJson) {
		this.treeJson = treeJson;
	}

	public java.lang.String getObjectType() {
		return objectType;
	}
	public void setObjectType(java.lang.String objectType) {
		this.objectType = objectType;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "USER_TREE_JSON";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "USER_TREE_JSON";
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