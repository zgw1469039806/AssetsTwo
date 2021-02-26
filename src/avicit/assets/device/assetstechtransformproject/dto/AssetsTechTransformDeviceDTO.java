package avicit.assets.device.assetstechtransformproject.dto;

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
 * @创建时间： 2020-07-07 09:54
 * @类说明：ASSETS_TECH_TRANSFORM_DEVICE
 * @修改记录：
 */
@PojoRemark(table = "assets_tech_transform_device", object = "AssetsTechTransformDeviceDTO", name = "ASSETS_TECH_TRANSFORM_DEVICE")
public class AssetsTechTransformDeviceDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField
    @FieldRemark(column = "id", field = "id", name = "主键")
    /*
     *主键
     */
    private java.lang.String id;

    @FieldRemark(column = "project_id", field = "projectId", name = "技改项目")
    /*
     *技改项目
     */
    private java.lang.String projectId;

    @FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
    /*
     *设备名称
     */
    private java.lang.String deviceName;

    @FieldRemark(column = "is_entity", field = "isEntity", name = "是否为实体")
    /*
     *是否为实体
     */
    private java.lang.String isEntity;
    /*
     *是否为实体显示名称
     */
    private java.lang.String isEntityName;

    @FieldRemark(column = "technical_requirement", field = "technicalRequirement", name = "主要技术（性能）指标或规格要求")
    /*
     *主要技术（性能）指标或规格要求
     */
    private java.lang.String technicalRequirement;

    @FieldRemark(column = "nation", field = "nation", name = "国别")
    /*
     *国别
     */
    private java.lang.String nation;

    @FieldRemark(column = "single_or_set", field = "singleOrSet", name = "单位（台/套）")
    /*
     *单位（台/套）
     */
    private java.lang.String singleOrSet;
    /*
     *单位（台/套）显示名称
     */
    private java.lang.String singleOrSetName;

    @FieldRemark(column = "unit_price", field = "unitPrice", name = "单价")
    /*
     *单价
     */
    private java.math.BigDecimal unitPrice;

    @FieldRemark(column = "amount", field = "amount", name = "数量")
    /*
     *数量
     */
    private Long amount;

    @FieldRemark(column = "total", field = "total", name = "合计")
    /*
     *合计
     */
    private java.math.BigDecimal total;

    @FieldRemark(column = "foreign_exchange", field = "foreignExchange", name = "外汇")
    /*
     *外汇
     */
    private java.math.BigDecimal foreignExchange;

    @FieldRemark(column = "bidding_situation", field = "biddingSituation", name = "招标情况")
    /*
     *招标情况
     */
    private java.lang.String biddingSituation;

    @FieldRemark(column = "remarks", field = "remarks", name = "备注")
    /*
     *备注
     */
    private java.lang.String remarks;

    @FieldRemark(column = "parent_id", field = "parentId", name = "父节点ID")
    /*
     *父节点ID
     */
    private java.lang.String parentId;

    @FieldRemark(column = "point_no", field = "pointNo", name = "节点序号")
    /*
     *节点序号
     */
    private java.lang.String pointNo;

    @FieldRemark(column = "tree_path", field = "treePath", name = "节点路径")
    /*
     *节点路径
     */
    private java.lang.String treePath;

    @FieldRemark(column = "point_level", field = "pointLevel", name = "节点层级")
    /*
     *节点层级
     */
    private Long pointLevel;

    @FieldRemark(column = "is_leaf", field = "isLeaf", name = "是否子节点")
    /*
     *是否子节点
     */
    private java.lang.String isLeaf;

    @FieldRemark(column = "device_sn", field = "deviceSn", name = "设备排序号")
    /*
     *设备排序号
     */
    private Long deviceSn;
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

    @FieldRemark(column = "attribute_01", field = "attribute01", name = "扩展字段01")
    /*
     *扩展字段01
     */
    private java.lang.String attribute01;

    @FieldRemark(column = "attribute_02", field = "attribute02", name = "扩展字段02")
    /*
     *扩展字段02
     */
    private java.lang.String attribute02;

    @FieldRemark(column = "attribute_03", field = "attribute03", name = "扩展字段03")
    /*
     *扩展字段03
     */
    private java.lang.String attribute03;

    @FieldRemark(column = "attribute_04", field = "attribute04", name = "扩展字段04")
    /*
     *扩展字段04
     */
    private java.lang.String attribute04;

    @FieldRemark(column = "attribute_05", field = "attribute05", name = "扩展字段05")
    /*
     *扩展字段05
     */
    private java.lang.String attribute05;

    @FieldRemark(column = "attribute_06", field = "attribute06", name = "扩展字段06")
    /*
     *扩展字段06
     */
    private java.lang.String attribute06;

    @FieldRemark(column = "attribute_07", field = "attribute07", name = "扩展字段07")
    /*
     *扩展字段07
     */
    private java.lang.String attribute07;

    @FieldRemark(column = "attribute_08", field = "attribute08", name = "扩展字段08")
    /*
     *扩展字段08
     */
    private java.lang.String attribute08;

    @FieldRemark(column = "attribute_09", field = "attribute09", name = "扩展字段09")
    /*
     *扩展字段09
     */
    private java.lang.String attribute09;

    @FieldRemark(column = "attribute_10", field = "attribute10", name = "扩展字段10")
    /*
     *扩展字段10
     */
    private java.lang.String attribute10;

    @FieldRemark(column = "attribute_11", field = "attribute11", name = "扩展字段11")
    /*
     *扩展字段11
     */
    private java.lang.String attribute11;

    @FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
    /*
     *扩展字段12
     */
    private java.lang.String attribute12;

    @FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
    /*
     *扩展字段13
     */
    private java.lang.String attribute13;

    @FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
    /*
     *扩展字段14
     */
    private java.lang.String attribute14;

    @FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
    /*
     *扩展字段15
     */
    private java.lang.String attribute15;

    @FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
    /*
     *扩展字段16
     */
    private Long attribute16;

    @FieldRemark(column = "attribute_17", field = "attribute17", name = "扩展字段17")
    /*
     *扩展字段17
     */
    private Long attribute17;

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

    @FieldRemark(column = "attribute_21", field = "attribute21", name = "扩展字段21")
    /*
     *扩展字段21
     */
    private java.math.BigDecimal attribute21;

    @FieldRemark(column = "attribute_22", field = "attribute22", name = "扩展字段22")
    /*
     *扩展字段22
     */
    private java.math.BigDecimal attribute22;

    @FieldRemark(column = "attribute_23", field = "attribute23", name = "扩展字段23")
    /*
     *扩展字段23
     */
    private java.math.BigDecimal attribute23;

    @FieldRemark(column = "attribute_24", field = "attribute24", name = "扩展字段24")
    /*
     *扩展字段24
     */
    private java.math.BigDecimal attribute24;

    @FieldRemark(column = "attribute_25", field = "attribute25", name = "扩展字段25")
    /*
     *扩展字段25
     */
    private java.math.BigDecimal attribute25;

    @FieldRemark(column = "attribute_26", field = "attribute26", name = "扩展字段26")
    /*
     *扩展字段26
     */
    private java.util.Date attribute26;
    /*
     *扩展字段26开始时间
     */
    private java.util.Date attribute26Begin;
    /*
     *扩展字段26截止时间
     */
    private java.util.Date attribute26End;

    @FieldRemark(column = "attribute_27", field = "attribute27", name = "扩展字段27")
    /*
     *扩展字段27
     */
    private java.util.Date attribute27;
    /*
     *扩展字段27开始时间
     */
    private java.util.Date attribute27Begin;
    /*
     *扩展字段27截止时间
     */
    private java.util.Date attribute27End;

    @FieldRemark(column = "attribute_28", field = "attribute28", name = "扩展字段28")
    /*
     *扩展字段28
     */
    private java.util.Date attribute28;
    /*
     *扩展字段28开始时间
     */
    private java.util.Date attribute28Begin;
    /*
     *扩展字段28截止时间
     */
    private java.util.Date attribute28End;

    @FieldRemark(column = "attribute_29", field = "attribute29", name = "扩展字段29")
    /*
     *扩展字段29
     */
    private java.util.Date attribute29;
    /*
     *扩展字段29开始时间
     */
    private java.util.Date attribute29Begin;
    /*
     *扩展字段29截止时间
     */
    private java.util.Date attribute29End;

    @FieldRemark(column = "attribute_30", field = "attribute30", name = "扩展字段30")
    /*
     *扩展字段30
     */
    private java.util.Date attribute30;
    /*
     *扩展字段30开始时间
     */
    private java.util.Date attribute30Begin;
    /*
     *扩展字段30截止时间
     */
    private java.util.Date attribute30End;

    public java.lang.String getId() {
        return id;
    }

    public void setId(java.lang.String id) {
        this.id = id;
    }

    public java.lang.String getProjectId() {
        return projectId;
    }

    public void setProjectId(java.lang.String projectId) {
        this.projectId = projectId;
    }

    public java.lang.String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(java.lang.String deviceName) {
        this.deviceName = deviceName;
    }

    public java.lang.String getIsEntity() {
        return isEntity;
    }

    public void setIsEntity(java.lang.String isEntity) {
        this.isEntity = isEntity;
    }

    public java.lang.String getIsEntityName() {
        return isEntityName;
    }

    public void setIsEntityName(java.lang.String isEntityName) {
        this.isEntityName = isEntityName;
    }

    public java.lang.String getTechnicalRequirement() {
        return technicalRequirement;
    }

    public void setTechnicalRequirement(java.lang.String technicalRequirement) {
        this.technicalRequirement = technicalRequirement;
    }

    public java.lang.String getNation() {
        return nation;
    }

    public void setNation(java.lang.String nation) {
        this.nation = nation;
    }

    public java.lang.String getSingleOrSet() {
        return singleOrSet;
    }

    public void setSingleOrSet(java.lang.String singleOrSet) {
        this.singleOrSet = singleOrSet;
    }

    public java.lang.String getSingleOrSetName() {
        return singleOrSetName;
    }

    public void setSingleOrSetName(java.lang.String singleOrSetName) {
        this.singleOrSetName = singleOrSetName;
    }

    public java.math.BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(java.math.BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public java.math.BigDecimal getTotal() {
        return total;
    }

    public void setTotal(java.math.BigDecimal total) {
        this.total = total;
    }

    public java.math.BigDecimal getForeignExchange() {
        return foreignExchange;
    }

    public void setForeignExchange(java.math.BigDecimal foreignExchange) {
        this.foreignExchange = foreignExchange;
    }

    public java.lang.String getBiddingSituation() {
        return biddingSituation;
    }

    public void setBiddingSituation(java.lang.String biddingSituation) {
        this.biddingSituation = biddingSituation;
    }

    public java.lang.String getRemarks() {
        return remarks;
    }

    public void setRemarks(java.lang.String remarks) {
        this.remarks = remarks;
    }

    public java.lang.String getParentId() {
        return parentId;
    }

    public void setParentId(java.lang.String parentId) {
        this.parentId = parentId;
    }

    public java.lang.String getPointNo() {
        return pointNo;
    }

    public void setPointNo(java.lang.String pointNo) {
        this.pointNo = pointNo;
    }

    public java.lang.String getTreePath() {
        return treePath;
    }

    public void setTreePath(java.lang.String treePath) {
        this.treePath = treePath;
    }

    public Long getPointLevel() {
        return pointLevel;
    }

    public void setPointLevel(Long pointLevel) {
        this.pointLevel = pointLevel;
    }

    public java.lang.String getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(java.lang.String isLeaf) {
        this.isLeaf = isLeaf;
    }

    public Long getDeviceSn() {
        return deviceSn;
    }

    public void setDeviceSn(Long deviceSn) {
        this.deviceSn = deviceSn;
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

    public java.lang.String getAttribute01() {
        return attribute01;
    }

    public void setAttribute01(java.lang.String attribute01) {
        this.attribute01 = attribute01;
    }

    public java.lang.String getAttribute02() {
        return attribute02;
    }

    public void setAttribute02(java.lang.String attribute02) {
        this.attribute02 = attribute02;
    }

    public java.lang.String getAttribute03() {
        return attribute03;
    }

    public void setAttribute03(java.lang.String attribute03) {
        this.attribute03 = attribute03;
    }

    public java.lang.String getAttribute04() {
        return attribute04;
    }

    public void setAttribute04(java.lang.String attribute04) {
        this.attribute04 = attribute04;
    }

    public java.lang.String getAttribute05() {
        return attribute05;
    }

    public void setAttribute05(java.lang.String attribute05) {
        this.attribute05 = attribute05;
    }

    public java.lang.String getAttribute06() {
        return attribute06;
    }

    public void setAttribute06(java.lang.String attribute06) {
        this.attribute06 = attribute06;
    }

    public java.lang.String getAttribute07() {
        return attribute07;
    }

    public void setAttribute07(java.lang.String attribute07) {
        this.attribute07 = attribute07;
    }

    public java.lang.String getAttribute08() {
        return attribute08;
    }

    public void setAttribute08(java.lang.String attribute08) {
        this.attribute08 = attribute08;
    }

    public java.lang.String getAttribute09() {
        return attribute09;
    }

    public void setAttribute09(java.lang.String attribute09) {
        this.attribute09 = attribute09;
    }

    public java.lang.String getAttribute10() {
        return attribute10;
    }

    public void setAttribute10(java.lang.String attribute10) {
        this.attribute10 = attribute10;
    }

    public java.lang.String getAttribute11() {
        return attribute11;
    }

    public void setAttribute11(java.lang.String attribute11) {
        this.attribute11 = attribute11;
    }

    public java.lang.String getAttribute12() {
        return attribute12;
    }

    public void setAttribute12(java.lang.String attribute12) {
        this.attribute12 = attribute12;
    }

    public java.lang.String getAttribute13() {
        return attribute13;
    }

    public void setAttribute13(java.lang.String attribute13) {
        this.attribute13 = attribute13;
    }

    public java.lang.String getAttribute14() {
        return attribute14;
    }

    public void setAttribute14(java.lang.String attribute14) {
        this.attribute14 = attribute14;
    }

    public java.lang.String getAttribute15() {
        return attribute15;
    }

    public void setAttribute15(java.lang.String attribute15) {
        this.attribute15 = attribute15;
    }

    public Long getAttribute16() {
        return attribute16;
    }

    public void setAttribute16(Long attribute16) {
        this.attribute16 = attribute16;
    }

    public Long getAttribute17() {
        return attribute17;
    }

    public void setAttribute17(Long attribute17) {
        this.attribute17 = attribute17;
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

    public java.math.BigDecimal getAttribute21() {
        return attribute21;
    }

    public void setAttribute21(java.math.BigDecimal attribute21) {
        this.attribute21 = attribute21;
    }

    public java.math.BigDecimal getAttribute22() {
        return attribute22;
    }

    public void setAttribute22(java.math.BigDecimal attribute22) {
        this.attribute22 = attribute22;
    }

    public java.math.BigDecimal getAttribute23() {
        return attribute23;
    }

    public void setAttribute23(java.math.BigDecimal attribute23) {
        this.attribute23 = attribute23;
    }

    public java.math.BigDecimal getAttribute24() {
        return attribute24;
    }

    public void setAttribute24(java.math.BigDecimal attribute24) {
        this.attribute24 = attribute24;
    }

    public java.math.BigDecimal getAttribute25() {
        return attribute25;
    }

    public void setAttribute25(java.math.BigDecimal attribute25) {
        this.attribute25 = attribute25;
    }

    public java.util.Date getAttribute26() {
        return attribute26;
    }

    public void setAttribute26(java.util.Date attribute26) {
        this.attribute26 = attribute26;
    }

    public java.util.Date getAttribute26Begin() {
        return attribute26Begin;
    }

    public void setAttribute26Begin(java.util.Date attribute26Begin) {
        this.attribute26Begin = attribute26Begin;
    }

    public java.util.Date getAttribute26End() {
        return attribute26End;
    }

    public void setAttribute26End(java.util.Date attribute26End) {
        this.attribute26End = attribute26End;
    }

    public java.util.Date getAttribute27() {
        return attribute27;
    }

    public void setAttribute27(java.util.Date attribute27) {
        this.attribute27 = attribute27;
    }

    public java.util.Date getAttribute27Begin() {
        return attribute27Begin;
    }

    public void setAttribute27Begin(java.util.Date attribute27Begin) {
        this.attribute27Begin = attribute27Begin;
    }

    public java.util.Date getAttribute27End() {
        return attribute27End;
    }

    public void setAttribute27End(java.util.Date attribute27End) {
        this.attribute27End = attribute27End;
    }

    public java.util.Date getAttribute28() {
        return attribute28;
    }

    public void setAttribute28(java.util.Date attribute28) {
        this.attribute28 = attribute28;
    }

    public java.util.Date getAttribute28Begin() {
        return attribute28Begin;
    }

    public void setAttribute28Begin(java.util.Date attribute28Begin) {
        this.attribute28Begin = attribute28Begin;
    }

    public java.util.Date getAttribute28End() {
        return attribute28End;
    }

    public void setAttribute28End(java.util.Date attribute28End) {
        this.attribute28End = attribute28End;
    }

    public java.util.Date getAttribute29() {
        return attribute29;
    }

    public void setAttribute29(java.util.Date attribute29) {
        this.attribute29 = attribute29;
    }

    public java.util.Date getAttribute29Begin() {
        return attribute29Begin;
    }

    public void setAttribute29Begin(java.util.Date attribute29Begin) {
        this.attribute29Begin = attribute29Begin;
    }

    public java.util.Date getAttribute29End() {
        return attribute29End;
    }

    public void setAttribute29End(java.util.Date attribute29End) {
        this.attribute29End = attribute29End;
    }

    public java.util.Date getAttribute30() {
        return attribute30;
    }

    public void setAttribute30(java.util.Date attribute30) {
        this.attribute30 = attribute30;
    }

    public java.util.Date getAttribute30Begin() {
        return attribute30Begin;
    }

    public void setAttribute30Begin(java.util.Date attribute30Begin) {
        this.attribute30Begin = attribute30Begin;
    }

    public java.util.Date getAttribute30End() {
        return attribute30End;
    }

    public void setAttribute30End(java.util.Date attribute30End) {
        this.attribute30End = attribute30End;
    }

    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "ASSETS_TECH_TRANSFORM_DEVICE";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_TECH_TRANSFORM_DEVICE";
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