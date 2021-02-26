package avicit.assets.device.nationalclassify.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写 @创建时间： 2020-05-28 09:07
 * @类说明：NATIONAL_CLASSIFY @修改记录：
 */
@PojoRemark(table = "national_classify", object = "NationalClassifyDTO", name = "NATIONAL_CLASSIFY")
public class NationalClassifyDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 * ID
	 */
	private java.lang.String id;

	@FieldRemark(column = "parentid", field = "parentid", name = "PARENTID")
	/*
	 * PARENTID
	 */
	private java.lang.String parentid;

	@FieldRemark(column = "name", field = "name", name = "NAME")
	/*
	 * NAME
	 */
	private java.lang.String name;

	@FieldRemark(column = "item_num", field = "itemNum", name = "ITEM_NUM")
	/*
	 * ITEM_NUM
	 */
	private java.lang.String itemNum;

	@FieldRemark(column = "sn", field = "sn", name = "SN")
	/*
	 * SN
	 */
	private Long sn;

	@FieldRemark(column = "father_num", field = "fatherNum", name = "FATHER_NUM")
	/*
	 * FATHER_NUM
	 */
	private java.lang.String fatherNum;

	@FieldRemark(column = "isvalid", field = "isvalid", name = "ISVALID")
	/*
	 * ISVALID
	 */
	private java.lang.String isvalid;

	@FieldRemark(column = "tree_path", field = "treePath", name = "TREE_PATH")
	/*
	 * TREE_PATH
	 */
	private java.lang.String treePath;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getParentid() {
		return parentid;
	}

	public void setParentid(java.lang.String parentid) {
		this.parentid = parentid;
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

	public Long getSn() {
		return sn;
	}

	public void setSn(Long sn) {
		this.sn = sn;
	}

	public java.lang.String getFatherNum() {
		return fatherNum;
	}

	public void setFatherNum(java.lang.String fatherNum) {
		this.fatherNum = fatherNum;
	}

	public java.lang.String getIsvalid() {
		return isvalid;
	}

	public void setIsvalid(java.lang.String isvalid) {
		this.isvalid = isvalid;
	}

	public java.lang.String getTreePath() {
		return treePath;
	}

	public void setTreePath(java.lang.String treePath) {
		this.treePath = treePath;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "NATIONAL_CLASSIFY";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "NATIONAL_CLASSIFY";
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