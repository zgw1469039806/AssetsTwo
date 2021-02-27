package avicit.cadreselect.dyntemplate.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;

import javax.persistence.Id;

@PojoRemark(table="DYN_RECORD", object="DynRecord", name="记录表")
public class DynRecord extends BeanDTO {

    private static final long serialVersionUID = 1L;

    @Id
    @LogField
    @FieldRemark(column="RE_ID", field="reId", name="主键")
    private java.lang.String reId;


    /**
     * 记录名称
     */
    @LogField
    @FieldRemark(column="RE_NAME", field="reName", name="记录名称")
    private java.lang.String reName;

    @LogField
    @FieldRemark(column="RE_RULE", field="reRule", name="记录规则")
    private java.lang.String reRule;

    //region get set


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getReId() {
        return reId;
    }

    public void setReId(String reId) {
        this.reId = reId;
    }

    public String getReName() {
        return reName;
    }

    public void setReName(String reName) {
        this.reName = reName;
    }

    public String getReRule() {
        return reRule;
    }

    public void setReRule(String reRule) {
        this.reRule = reRule;
    }

    @Override
    public String getLogFormName() {
        return null;
    }
    //endregion
}
