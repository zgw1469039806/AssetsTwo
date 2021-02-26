package avicit.assets.device.usertablemodel.dto;

import javax.persistence.Id;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-07-01 10:01
 * @类说明：USER_TABLE_MODEL
 * @修改记录：
 */
@PojoRemark(table = "user_table_model", object = "UserTableModelDTO", name = "USER_TABLE_MODEL")
public class UserTableModelDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField

    @FieldRemark(column = "id", field = "id", name = "主键")
    /*
     *主键
     */
    private java.lang.String id;

    @FieldRemark(column = "user_id", field = "userId", name = "用户ID")
    /*
     *用户ID
     */
    private java.lang.String userId;

    @FieldRemark(column = "field_name", field = "fieldName", name = "字段名称")
    /*
     *字段名称
     */
    private java.lang.String fieldName;

    @FieldRemark(column = "field_identify", field = "fieldIdentify", name = "字段标识")
    /*
     *字段标识
     */
    private java.lang.String fieldIdentify;

    @FieldRemark(column = "field_model", field = "fieldModel", name = "字段描述")
    /*
     *字段描述
     */
    private java.lang.String fieldModel;

    @FieldRemark(column = "sn", field = "sn", name = "排序号")
    /*
     *排序号
     */
    private Long sn;

    @FieldRemark(column = "belong_table", field = "belongTable", name = "所属表")
    /*
     *所属表
     */
    private java.lang.String belongTable;

    @FieldRemark(column = "view_name", field = "viewName", name = "视图名称")
    /*
     *视图名称
     */
    private java.lang.String viewName;

    @FieldRemark(column = "is_valid", field = "isValid", name = "是否可用")
    /*
     *是否可用
     */
    private java.lang.String isValid;

    public java.lang.String getId() {
        return id;
    }
    public void setId(java.lang.String id) {
        this.id = id;
    }

    public java.lang.String getUserId() {
        return userId;
    }
    public void setUserId(java.lang.String userId) {
        this.userId = userId;
    }

    public java.lang.String getFieldName() {
        return fieldName;
    }
    public void setFieldName(java.lang.String fieldName) {
        this.fieldName = fieldName;
    }

    public java.lang.String getFieldIdentify() {
        return fieldIdentify;
    }
    public void setFieldIdentify(java.lang.String fieldIdentify) {
        this.fieldIdentify = fieldIdentify;
    }

    public java.lang.String getFieldModel() {
        return fieldModel;
    }
    public void setFieldModel(java.lang.String fieldModel) {
        this.fieldModel = fieldModel;
    }

    public Long getSn() {
        return sn;
    }
    public void setSn(Long sn) {
        this.sn = sn;
    }

    public java.lang.String getBelongTable() {
        return belongTable;
    }
    public void setBelongTable(java.lang.String belongTable) {
        this.belongTable = belongTable;
    }

    public java.lang.String getViewName() {
        return viewName;
    }
    public void setViewName(java.lang.String viewName) {
        this.viewName = viewName;
    }

    public java.lang.String getIsValid() {
        return isValid;
    }
    public void setIsValid(java.lang.String isValid) {
        this.isValid = isValid;
    }

    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "USER_TABLE_MODEL";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "USER_TABLE_MODEL";
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