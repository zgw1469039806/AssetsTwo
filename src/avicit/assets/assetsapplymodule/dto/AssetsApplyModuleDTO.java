package avicit.assets.assetsapplymodule.dto;

import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

import java.util.Date;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-07-01 14:22
 * @类说明：ASSETS_APPLY_MODULE
 * @修改记录：
 */
@PojoRemark(table = "assets_apply_module", object = "AssetsApplyModuleDTO", name = "ASSETS_APPLY_MODULE")
public class AssetsApplyModuleDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;

    @Id
    @LogField


    @FieldRemark(column = "id", field = "id", name = "主键")
    /*
     *主键
     */
    private java.lang.String id;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *创建时间开始时间
     */
    private java.util.Date creationDateBegin;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *创建时间截止时间
     */
    private java.util.Date creationDateEnd;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *最后修改时间开始时间
     */
    private java.util.Date lastUpdateDateBegin;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *最后修改时间截止时间
     */
    private java.util.Date lastUpdateDateEnd;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private java.util.Date guaranteePeriod;

    public Date getGuaranteePeriod() {
        return guaranteePeriod;
    }

    public void setGuaranteePeriod(Date guaranteePeriod) {
        this.guaranteePeriod = guaranteePeriod;
    }

    @FieldRemark(column = "is_contract_related", field = "isContractRelated", name = "是否被合同管关联 ")
    /*
     *是否被合同管关联
     */
    private java.lang.String isContractRelated;


    @FieldRemark(column = "apply_type", field = "applyType", name = "申购类型 ")
    /*
     *申购类型
     */
    private java.lang.String applyType;


    @FieldRemark(column = "apply_id", field = "applyId", name = "申购id ")
    /*
     *申购id
     */
    private java.lang.String applyId;


    @FieldRemark(column = "apply_device_name", field = "applyDeviceName", name = "申购设备名称 ")
    /*
     *申购设备名称
     */
    private java.lang.String applyDeviceName;


    @FieldRemark(column = "apply_num", field = "applyNum", name = "申购数量 ")
    /*
     *申购数量
     */
    private Long applyNum;


    @FieldRemark(column = "apply_price", field = "applyPrice", name = "申购单价 ")
    /*
     *申购单价
     */
    private java.math.BigDecimal applyPrice;


    @FieldRemark(column = "apply_spec", field = "applySpec", name = "申购设备规格 ")
    /*
     *申购设备规格
     */
    private java.lang.String applySpec;


    @FieldRemark(column = "apply_model", field = "applyModel", name = "申购设备型号 ")
    /*
     *申购设备型号
     */
    private java.lang.String applyModel;


    @FieldRemark(column = "apply_manufacturer", field = "applyManufacturer", name = "申购制造商 ")
    /*
     *申购制造商
     */
    private java.lang.String applyManufacturer;


    @FieldRemark(column = "contract_id", field = "contractId", name = "合同ID ")
    /*
     *合同ID
     */
    private java.lang.String contractId;


    @FieldRemark(column = "contract_num", field = "contractNum", name = "合同编号 ")
    /*
     *合同编号
     */
    private java.lang.String contractNum;


    @FieldRemark(column = "contract_name", field = "contractName", name = "合同名称 ")
    /*
     *合同名称
     */
    private java.lang.String contractName;


    @FieldRemark(column = "contract_total_price", field = "contractTotalPrice", name = "合同金额 ")
    /*
     *合同金额
     */
    private java.lang.String contractTotalPrice;


    @FieldRemark(column = "contract_supplier", field = "contractSupplier", name = "合同供应商 ")
    /*
     *合同供应商
     */
    private java.lang.String contractSupplier;


    @FieldRemark(column = "contract_operator", field = "contractOperator", name = "合同经办人 ")
    /*
     *合同经办人
     */
    private java.lang.String contractOperator;


    @FieldRemark(column = "contract_device_name", field = "contractDeviceName", name = "合同设备名称 ")
    /*
     *合同设备名称
     */
    private java.lang.String contractDeviceName;


    @FieldRemark(column = "contract_device_num", field = "contractDeviceNum", name = "合同设备数量 ")
    /*
     *合同设备数量
     */
    private Long contractDeviceNum;


    @FieldRemark(column = "contract_device_price", field = "contractDevicePrice", name = "合同设备单价 ")
    /*
     *合同设备单价
     */
    private java.math.BigDecimal contractDevicePrice;


    @FieldRemark(column = "contract_device_total_price", field = "contractDeviceTotalPrice", name = "合同设备金额 ")
    /*
     *合同设备金额
     */
    private java.math.BigDecimal contractDeviceTotalPrice;


    @FieldRemark(column = "contract_spec", field = "contractSpec", name = "合同设备规格 ")
    /*
     *合同设备规格
     */
    private java.lang.String contractSpec;


    @FieldRemark(column = "contract_model", field = "contractModel", name = "合同设备型号 ")
    /*
     *合同设备型号
     */
    private java.lang.String contractModel;


    @FieldRemark(column = "contract_manufacturer", field = "contractManufacturer", name = "合同制造商 ")
    /*
     *合同制造商
     */
    private java.lang.String contractManufacturer;


    @FieldRemark(column = "contract_state", field = "contractState", name = "合同执行状态 ")
    /*
     *合同执行状态
     */
    private java.lang.String contractState;


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
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段15
     */
    private java.util.Date attribute15;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段15开始时间
     */
    private java.util.Date attribute15Begin;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段15截止时间
     */
    private java.util.Date attribute15End;


    @FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段16
     */
    private java.util.Date attribute16;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段16开始时间
     */
    private java.util.Date attribute16Begin;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段16截止时间
     */
    private java.util.Date attribute16End;


    @FieldRemark(column = "attribute_17", field = "attribute17", name = "扩展字段17")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段17
     */
    private java.util.Date attribute17;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    /*
     *扩展字段17开始时间
     */
    private java.util.Date attribute17Begin;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
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


    @FieldRemark(column = "is_derive", field = "isDerive", name = "是否派生验收")
    /*
     *是否派生验收
     */
    private java.lang.String isDerive;


    public java.lang.String getId() {
        return id;
    }

    public void setId(java.lang.String id) {
        this.id = id;
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

    public java.lang.String getIsContractRelated() {
        return isContractRelated;
    }

    public void setIsContractRelated(java.lang.String isContractRelated) {
        this.isContractRelated = isContractRelated;
    }

    public java.lang.String getApplyType() {
        return applyType;
    }

    public void setApplyType(java.lang.String applyType) {
        this.applyType = applyType;
    }

    public java.lang.String getApplyId() {
        return applyId;
    }

    public void setApplyId(java.lang.String applyId) {
        this.applyId = applyId;
    }

    public java.lang.String getApplyDeviceName() {
        return applyDeviceName;
    }

    public void setApplyDeviceName(java.lang.String applyDeviceName) {
        this.applyDeviceName = applyDeviceName;
    }

    public Long getApplyNum() {
        return applyNum;
    }

    public void setApplyNum(Long applyNum) {
        this.applyNum = applyNum;
    }

    public java.math.BigDecimal getApplyPrice() {
        return applyPrice;
    }

    public void setApplyPrice(java.math.BigDecimal applyPrice) {
        this.applyPrice = applyPrice;
    }

    public java.lang.String getApplySpec() {
        return applySpec;
    }

    public void setApplySpec(java.lang.String applySpec) {
        this.applySpec = applySpec;
    }

    public java.lang.String getApplyModel() {
        return applyModel;
    }

    public void setApplyModel(java.lang.String applyModel) {
        this.applyModel = applyModel;
    }

    public java.lang.String getApplyManufacturer() {
        return applyManufacturer;
    }

    public void setApplyManufacturer(java.lang.String applyManufacturer) {
        this.applyManufacturer = applyManufacturer;
    }

    public java.lang.String getContractId() {
        return contractId;
    }

    public void setContractId(java.lang.String contractId) {
        this.contractId = contractId;
    }

    public java.lang.String getContractNum() {
        return contractNum;
    }

    public void setContractNum(java.lang.String contractNum) {
        this.contractNum = contractNum;
    }

    public java.lang.String getContractName() {
        return contractName;
    }

    public void setContractName(java.lang.String contractName) {
        this.contractName = contractName;
    }

    public java.lang.String getContractTotalPrice() {
        return contractTotalPrice;
    }

    public void setContractTotalPrice(java.lang.String contractTotalPrice) {
        this.contractTotalPrice = contractTotalPrice;
    }

    public java.lang.String getContractSupplier() {
        return contractSupplier;
    }

    public void setContractSupplier(java.lang.String contractSupplier) {
        this.contractSupplier = contractSupplier;
    }

    public java.lang.String getContractOperator() {
        return contractOperator;
    }

    public void setContractOperator(java.lang.String contractOperator) {
        this.contractOperator = contractOperator;
    }

    public java.lang.String getContractDeviceName() {
        return contractDeviceName;
    }

    public void setContractDeviceName(java.lang.String contractDeviceName) {
        this.contractDeviceName = contractDeviceName;
    }

    public Long getContractDeviceNum() {
        return contractDeviceNum;
    }

    public void setContractDeviceNum(Long contractDeviceNum) {
        this.contractDeviceNum = contractDeviceNum;
    }

    public java.math.BigDecimal getContractDevicePrice() {
        return contractDevicePrice;
    }

    public void setContractDevicePrice(java.math.BigDecimal contractDevicePrice) {
        this.contractDevicePrice = contractDevicePrice;
    }

    public java.math.BigDecimal getContractDeviceTotalPrice() {
        return contractDeviceTotalPrice;
    }

    public void setContractDeviceTotalPrice(java.math.BigDecimal contractDeviceTotalPrice) {
        this.contractDeviceTotalPrice = contractDeviceTotalPrice;
    }

    public java.lang.String getContractSpec() {
        return contractSpec;
    }

    public void setContractSpec(java.lang.String contractSpec) {
        this.contractSpec = contractSpec;
    }

    public java.lang.String getContractModel() {
        return contractModel;
    }

    public void setContractModel(java.lang.String contractModel) {
        this.contractModel = contractModel;
    }

    public java.lang.String getContractManufacturer() {
        return contractManufacturer;
    }

    public void setContractManufacturer(java.lang.String contractManufacturer) {
        this.contractManufacturer = contractManufacturer;
    }

    public java.lang.String getContractState() {
        return contractState;
    }

    public void setContractState(java.lang.String contractState) {
        this.contractState = contractState;
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

    public java.lang.String getIsDerive() {
        return isDerive;
    }

    public void setIsDerive(java.lang.String isDerive) {
        this.isDerive = isDerive;
    }


    public String getLogFormName() {
        if (super.logFormName == null || super.logFormName.equals("")) {
            return "ASSETS_APPLY_MODULE";
        } else {
            return super.logFormName;
        }
    }

    public String getLogTitle() {
        if (super.logTitle == null || super.logTitle.equals("")) {
            return "ASSETS_APPLY_MODULE";
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

    @Override
    public String toString() {
        return "AssetsApplyModuleDTO{" +
                "id='" + id + '\'' +
                ", creationDateBegin=" + creationDateBegin +
                ", creationDateEnd=" + creationDateEnd +
                ", lastUpdateDateBegin=" + lastUpdateDateBegin +
                ", lastUpdateDateEnd=" + lastUpdateDateEnd +
                ", isContractRelated='" + isContractRelated + '\'' +
                ", applyType='" + applyType + '\'' +
                ", applyId='" + applyId + '\'' +
                ", applyDeviceName='" + applyDeviceName + '\'' +
                ", applyNum=" + applyNum +
                ", applyPrice=" + applyPrice +
                ", applySpec='" + applySpec + '\'' +
                ", applyModel='" + applyModel + '\'' +
                ", applyManufacturer='" + applyManufacturer + '\'' +
                ", contractId='" + contractId + '\'' +
                ", contractNum='" + contractNum + '\'' +
                ", contractName='" + contractName + '\'' +
                ", contractTotalPrice='" + contractTotalPrice + '\'' +
                ", contractSupplier='" + contractSupplier + '\'' +
                ", contractOperator='" + contractOperator + '\'' +
                ", contractDeviceName='" + contractDeviceName + '\'' +
                ", contractDeviceNum=" + contractDeviceNum +
                ", contractDevicePrice=" + contractDevicePrice +
                ", contractDeviceTotalPrice=" + contractDeviceTotalPrice +
                ", contractSpec='" + contractSpec + '\'' +
                ", contractModel='" + contractModel + '\'' +
                ", contractManufacturer='" + contractManufacturer + '\'' +
                ", contractState='" + contractState + '\'' +
                ", attribute01='" + attribute01 + '\'' +
                ", attribute02='" + attribute02 + '\'' +
                ", attribute03='" + attribute03 + '\'' +
                ", attribute04='" + attribute04 + '\'' +
                ", attribute05='" + attribute05 + '\'' +
                ", attribute06='" + attribute06 + '\'' +
                ", attribute07='" + attribute07 + '\'' +
                ", attribute08='" + attribute08 + '\'' +
                ", attribute09='" + attribute09 + '\'' +
                ", attribute10='" + attribute10 + '\'' +
                ", attribute11='" + attribute11 + '\'' +
                ", attribute12='" + attribute12 + '\'' +
                ", attribute13='" + attribute13 + '\'' +
                ", attribute14='" + attribute14 + '\'' +
                ", attribute15=" + attribute15 +
                ", attribute15Begin=" + attribute15Begin +
                ", attribute15End=" + attribute15End +
                ", attribute16=" + attribute16 +
                ", attribute16Begin=" + attribute16Begin +
                ", attribute16End=" + attribute16End +
                ", attribute17=" + attribute17 +
                ", attribute17Begin=" + attribute17Begin +
                ", attribute17End=" + attribute17End +
                ", attribute18=" + attribute18 +
                ", attribute19=" + attribute19 +
                ", attribute20=" + attribute20 +
                ", isDerive='" + isDerive + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", creationDate=" + creationDate +
                ", lastUpdateDate=" + lastUpdateDate +
                ", lastUpdatedBy='" + lastUpdatedBy + '\'' +
                ", lastUpdateIp='" + lastUpdateIp + '\'' +
                ", logFormName='" + logFormName + '\'' +
                ", logTitle='" + logTitle + '\'' +
                ", logType=" + logType +
                ", version=" + version +
                '}';
    }
}