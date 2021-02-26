package avicit.assets.device.nationalclassify.dto;

import javax.persistence.Id;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写 @创建时间： 2020-05-28 09:07
 * @类说明：NATIONAL_CLASSIFY @修改记录：
 */
@PojoRemark(table = "national_classify", object = "NationalClassifyDTO", name = "NATIONAL_CLASSIFY")
public class NationalClassifyTreeDTO{
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "ID")
	private java.lang.String id;

	@FieldRemark(column = "parentid", field = "pId", name = "PARENTID")
	private java.lang.String pId;

	@FieldRemark(column = "name", field = "name", name = "NAME")
	private java.lang.String name;
	
	@FieldRemark(column = "item_num", field = "itemNum", name = "ITEM_NUM")
	private java.lang.String itemNum;
	
	@FieldRemark(column = "tree_path", field = "treePath", name = "TREE_PATH")
	private java.lang.String treePath;

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
	
	public java.lang.String getItemNum() {
		return itemNum;
	}
	public void setItemNum(java.lang.String itemNum) {
		this.itemNum = itemNum;
	}
	
	public java.lang.String getTreePath() {
		return treePath;
	}
	public void setTreePath(java.lang.String treePath) {
		this.treePath = treePath;
	}
}