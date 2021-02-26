package avicit.assets.device.classifydata.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;

import javax.persistence.Id;

@PojoRemark(table = "classify_data", object = "ClassifyTreeDTO", name = "CLASSIFY_DATA")
public class ClassifyTreeDTO {
    @Id
    @LogField
    @FieldRemark(column = "id", field = "id", name = "主键")
    /*
     *主键
     */
    private java.lang.String id;

    @FieldRemark(column = "name", field = "name", name = "分类名称")
    /*
     *分类名称
     */
    private java.lang.String name;

    @FieldRemark(column = "code", field = "code", name = "分类编号")
    /*
     *分类编号
     */
    private java.lang.String code;

    @FieldRemark(column = "parent_code", field = "parentCode", name = "父分类编号")
    /*
     *父分类编号
     */
    private java.lang.String parentCode;

    @FieldRemark(column = "parent_id", field = "pId", name = "父分类ID")
    /*
     *父分类ID
     */
    private java.lang.String pId;

    @FieldRemark(column = "tree_path", field = "path", name = "分类TreePath")
    /*
     *分类TreePath
     */
    private java.lang.String path;

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    public String getParentCode() {
        return parentCode;
    }
    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public String getpId() {
        return pId;
    }
    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }
}
