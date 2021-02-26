package avicit.assets.device.assetsstdtempapplyproc.dto;

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
 * @邮箱：请填写
 * @创建时间： 2020-06-20 16:59
 * @类说明：ASSETS_SUPPLIER
 * @修改记录：
 */
@PojoRemark(table = "assets_supplier", object = "AssetsSupplierDTO", name = "ASSETS_SUPPLIER")
public class AssetsSupplierDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField

    @FieldRemark(column = "id", field = "id", name = "ID")
    /*
     *ID
     */
    private String id;

    @FieldRemark(column = "name", field = "name", name = "供应商名称")
    /*
     *供应商名称
     */
    private String name;

    @FieldRemark(column = "address", field = "address", name = "供应商地址")
    /*
     *供应商地址
     */
    private String address;

    @FieldRemark(column = "contact", field = "contact", name = "联系人")
    /*
     *联系人
     */
    private String contact;

    @FieldRemark(column = "contact_number", field = "contactNumber", name = "联系电话")
    /*
     *联系电话
     */
    private String contactNumber;

    @FieldRemark(column = "business_scope", field = "businessScope", name = "经验范围")
    /*
     *经验范围
     */
    private String businessScope;
    /*
     *创建时间开始时间
     */
    private java.util.Date creationDateBegin;
    /*
     *创建时间截止时间
     */
    private java.util.Date creationDateEnd;
    /*
     *最后修改时间开始时间
     */
    private java.util.Date lastUpdateDateBegin;
    /*
     *最后修改时间截止时间
     */
    private java.util.Date lastUpdateDateEnd;

    @FieldRemark(column = "status", field = "status", name = "供应商状态：0:正常状态 2:停用")
    /*
     *供应商状态：0:正常状态 2:停用
     */
    private String status;

    @FieldRemark(column = "attribute_01", field = "attribute01", name = "扩展字段01")
    /*
     *扩展字段01
     */
    private String attribute01;

    @FieldRemark(column = "attribute_02", field = "attribute02", name = "扩展字段02")
    /*
     *扩展字段02
     */
    private String attribute02;

    @FieldRemark(column = "attribute_03", field = "attribute03", name = "扩展字段03")
    /*
     *扩展字段03
     */
    private String attribute03;

    @FieldRemark(column = "attribute_04", field = "attribute04", name = "扩展字段04")
    /*
     *扩展字段04
     */
    private String attribute04;

    @FieldRemark(column = "attribute_05", field = "attribute05", name = "扩展字段05")
    /*
     *扩展字段05
     */
    private String attribute05;

    @FieldRemark(column = "attribute_06", field = "attribute06", name = "扩展字段06")
    /*
     *扩展字段06
     */
    private String attribute06;

    @FieldRemark(column = "attribute_07", field = "attribute07", name = "扩展字段07")
    /*
     *扩展字段07
     */
    private String attribute07;

    @FieldRemark(column = "attribute_08", field = "attribute08", name = "扩展字段08")
    /*
     *扩展字段08
     */
    private String attribute08;

    @FieldRemark(column = "attribute_09", field = "attribute09", name = "扩展字段09")
    /*
     *扩展字段09
     */
    private String attribute09;

    @FieldRemark(column = "attribute_10", field = "attribute10", name = "扩展字段10")
    /*
     *扩展字段10
     */
    private String attribute10;

    @FieldRemark(column = "attribute_11", field = "attribute11", name = "扩展字段11")
    /*
     *扩展字段11
     */
    private String attribute11;

    @FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
    /*
     *扩展字段12
     */
    private String attribute12;

    @FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
    /*
     *扩展字段13
     */
    private String attribute13;

    @FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
    /*
     *扩展字段14
     */
    private String attribute14;

    @FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
    /*
     *扩展字段15
     */
    private java.util.Date attribute15;
    /*
     *扩展字段15开始时间
     */
    private java.util.Date attribute15Begin;
    /*
     *扩展字段15截止时间
     */
    private java.util.Date attribute15End;

    @FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
    /*
     *扩展字段16
     */
    private java.util.Date attribute16;
    /*
     *扩展字段16开始时间
     */
    private java.util.Date attribute16Begin;
    /*
     *扩展字段16截止时间
     */
    private java.util.Date attribute16End;

    @FieldRemark(column = "attribute_17", field = "attribute17", name = "扩展字段17")
    /*
     *扩展字段17
     */
    private java.util.Date attribute17;
    /*
     *扩展字段17开始时间
     */
    private java.util.Date attribute17Begin;
    /*
     *扩展字段17截止时间
     */
    private java.util.Date attribute17End;

    @FieldRemark(column = "attribute_18", field = "attribute18", name = "扩展字段18")
    /*
     *扩展字段18
     */
    private Long attribute18;

    @FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
    /*
     *扩展字段19
     */
    private Long attribute19;

    @FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
    /*
     *扩展字段20
     */
    private Long attribute20;

    @FieldRemark(column = "level_up_id", field = "levelUpId", name = "父ID")
    /*
     *父ID
     */
    private String levelUpId;


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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getBusinessScope() {
        return businessScope;
    }

    public void setBusinessScope(String businessScope) {
        this.businessScope = businessScope;
    }

    public java.util.Date getCreationDateBegin() {
        return creationDateBegin;
    }

    public void setCreationDateBegin(java.util.Date creationDateBegin) {
        this.creationDateBegin = creationDateBegin;
    }

    public java.util.Date getCreationDateEnd() {
        return creationDateEnd;
    }

    public void setCreationDateEnd(java.util.Date creationDateEnd) {
        this.creationDateEnd = creationDateEnd;
    }

    public java.util.Date getLastUpdateDateBegin() {
        return lastUpdateDateBegin;
    }

    public void setLastUpdateDateBegin(java.util.Date lastUpdateDateBegin) {
        this.lastUpdateDateBegin = lastUpdateDateBegin;
    }

    public java.util.Date getLastUpdateDateEnd() {
        return lastUpdateDateEnd;
    }

    public void setLastUpdateDateEnd(java.util.Date lastUpdateDateEnd) {
        this.lastUpdateDateEnd = lastUpdateDateEnd;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAttribute01() {
        return attribute01;
    }

    public void setAttribute01(String attribute01) {
        this.attribute01 = attribute01;
    }

    public String getAttribute02() {
        return attribute02;
    }

    public void setAttribute02(String attribute02) {
        this.attribute02 = attribute02;
    }

    public String getAttribute03() {
        return attribute03;
    }

    public void setAttribute03(String attribute03) {
        this.attribute03 = attribute03;
    }

    public String getAttribute04() {
        return attribute04;
    }

    public void setAttribute04(String attribute04) {
        this.attribute04 = attribute04;
    }

    public String getAttribute05() {
        return attribute05;
    }

    public void setAttribute05(String attribute05) {
        this.attribute05 = attribute05;
    }

    public String getAttribute06() {
        return attribute06;
    }

    public void setAttribute06(String attribute06) {
        this.attribute06 = attribute06;
    }

    public String getAttribute07() {
        return attribute07;
    }

    public void setAttribute07(String attribute07) {
        this.attribute07 = attribute07;
    }

    public String getAttribute08() {
        return attribute08;
    }

    public void setAttribute08(String attribute08) {
        this.attribute08 = attribute08;
    }

    public String getAttribute09() {
        return attribute09;
    }

    public void setAttribute09(String attribute09) {
        this.attribute09 = attribute09;
    }

    public String getAttribute10() {
        return attribute10;
    }

    public void setAttribute10(String attribute10) {
        this.attribute10 = attribute10;
    }

    public String getAttribute11() {
        return attribute11;
    }

    public void setAttribute11(String attribute11) {
        this.attribute11 = attribute11;
    }

    public String getAttribute12() {
        return attribute12;
    }

    public void setAttribute12(String attribute12) {
        this.attribute12 = attribute12;
    }

    public String getAttribute13() {
        return attribute13;
    }

    public void setAttribute13(String attribute13) {
        this.attribute13 = attribute13;
    }

    public String getAttribute14() {
        return attribute14;
    }

    public void setAttribute14(String attribute14) {
        this.attribute14 = attribute14;
    }

    public java.util.Date getAttribute15() {
        return attribute15;
    }

    public void setAttribute15(java.util.Date attribute15) {
        this.attribute15 = attribute15;
    }

    public java.util.Date getAttribute15Begin() {
        return attribute15Begin;
    }

    public void setAttribute15Begin(java.util.Date attribute15Begin) {
        this.attribute15Begin = attribute15Begin;
    }

    public java.util.Date getAttribute15End() {
        return attribute15End;
    }

    public void setAttribute15End(java.util.Date attribute15End) {
        this.attribute15End = attribute15End;
    }

    public java.util.Date getAttribute16() {
        return attribute16;
    }

    public void setAttribute16(java.util.Date attribute16) {
        this.attribute16 = attribute16;
    }

    public java.util.Date getAttribute16Begin() {
        return attribute16Begin;
    }

    public void setAttribute16Begin(java.util.Date attribute16Begin) {
        this.attribute16Begin = attribute16Begin;
    }

    public java.util.Date getAttribute16End() {
        return attribute16End;
    }

    public void setAttribute16End(java.util.Date attribute16End) {
        this.attribute16End = attribute16End;
    }

    public java.util.Date getAttribute17() {
        return attribute17;
    }

    public void setAttribute17(java.util.Date attribute17) {
        this.attribute17 = attribute17;
    }

    public java.util.Date getAttribute17Begin() {
        return attribute17Begin;
    }

    public void setAttribute17Begin(java.util.Date attribute17Begin) {
        this.attribute17Begin = attribute17Begin;
    }

    public java.util.Date getAttribute17End() {
        return attribute17End;
    }

    public void setAttribute17End(java.util.Date attribute17End) {
        this.attribute17End = attribute17End;
    }

    public Long getAttribute18() {
        return attribute18;
    }

    public void setAttribute18(Long attribute18) {
        this.attribute18 = attribute18;
    }

    public Long getAttribute19() {
        return attribute19;
    }

    public void setAttribute19(Long attribute19) {
        this.attribute19 = attribute19;
    }

    public Long getAttribute20() {
        return attribute20;
    }

    public void setAttribute20(Long attribute20) {
        this.attribute20 = attribute20;
    }

    public String getLevelUpId() {
        return levelUpId;
    }

    public void setLevelUpId(String levelUpId) {
        this.levelUpId = levelUpId;
    }


    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "ASSETS_SUPPLIER";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_SUPPLIER";
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