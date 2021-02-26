package avicit.assets.device.assetsstdtempacceptance.dto;

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
 * @创建时间： 2020-07-19 20:37 
 * @类说明：标准设备验收
 * @修改记录： 
 */
 @PojoRemark(table="assets_stdtemp_acceptance",object="AssetsStdtempAcceptanceDTO",name="标准设备验收")
 public class AssetsStdtempAcceptanceDTO extends BeanDTO{
    private static final long serialVersionUID = 1L;
    private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
    private String bpmState;
	
						@Id
							@LogField
				
				 	@FieldRemark(column="id",field="id",name="ID")
		 	/*
			 *ID
			 */
		 	private String id;
					    		    		 	/*
				 *CREATION_DATE开始时间
				 */
    		 	private java.util.Date creationDateBegin;
    		 	/*
				 *CREATION_DATE截止时间
				 */
    		 	private java.util.Date creationDateEnd;
    					    		    		 	/*
				 *LAST_UPDATE_DATE开始时间
				 */
    		 	private java.util.Date lastUpdateDateBegin;
    		 	/*
				 *LAST_UPDATE_DATE截止时间
				 */
    		 	private java.util.Date lastUpdateDateEnd;
    														
				 	@FieldRemark(column="attribute_01",field="attribute01",name="ATTRIBUTE_01")
		 	/*
			 *ATTRIBUTE_01
			 */
		 	private String attribute01;
												
				 	@FieldRemark(column="attribute_02",field="attribute02",name="ATTRIBUTE_02")
		 	/*
			 *ATTRIBUTE_02
			 */
		 	private String attribute02;
												
				 	@FieldRemark(column="attribute_03",field="attribute03",name="ATTRIBUTE_03")
		 	/*
			 *ATTRIBUTE_03
			 */
		 	private String attribute03;
												
				 	@FieldRemark(column="attribute_04",field="attribute04",name="ATTRIBUTE_04")
		 	/*
			 *ATTRIBUTE_04
			 */
		 	private String attribute04;
												
				 	@FieldRemark(column="attribute_05",field="attribute05",name="ATTRIBUTE_05")
		 	/*
			 *ATTRIBUTE_05
			 */
		 	private String attribute05;
												
				 	@FieldRemark(column="attribute_06",field="attribute06",name="ATTRIBUTE_06")
		 	/*
			 *ATTRIBUTE_06
			 */
		 	private String attribute06;
												
				 	@FieldRemark(column="attribute_07",field="attribute07",name="ATTRIBUTE_07")
		 	/*
			 *ATTRIBUTE_07
			 */
		 	private String attribute07;
												
				 	@FieldRemark(column="attribute_08",field="attribute08",name="ATTRIBUTE_08")
		 	/*
			 *ATTRIBUTE_08
			 */
		 	private String attribute08;
												
				 	@FieldRemark(column="attribute_09",field="attribute09",name="ATTRIBUTE_09")
		 	/*
			 *ATTRIBUTE_09
			 */
		 	private String attribute09;
												
				 	@FieldRemark(column="attribute_10",field="attribute10",name="ATTRIBUTE_10")
		 	/*
			 *ATTRIBUTE_10
			 */
		 	private String attribute10;
												
				 	@FieldRemark(column="attribute_11",field="attribute11",name="ATTRIBUTE_11")
		 	/*
			 *ATTRIBUTE_11
			 */
		 	private String attribute11;
												
				 	@FieldRemark(column="attribute_12",field="attribute12",name="ATTRIBUTE_12")
		 	/*
			 *ATTRIBUTE_12
			 */
		 	private String attribute12;
												
				 	@FieldRemark(column="attribute_13",field="attribute13",name="ATTRIBUTE_13")
		 	/*
			 *ATTRIBUTE_13
			 */
		 	private String attribute13;
												
				 	@FieldRemark(column="attribute_14",field="attribute14",name="ATTRIBUTE_14")
		 	/*
			 *ATTRIBUTE_14
			 */
		 	private String attribute14;
												
		    	    @FieldRemark(column="attribute_15",field="attribute15",name="ATTRIBUTE_15")
    	    /*
			 *ATTRIBUTE_15
			 */
    		private java.util.Date attribute15;
    		/*
			 *ATTRIBUTE_15开始时间
			 */
    		private java.util.Date attribute15Begin;
    		/*
			 *ATTRIBUTE_15截止时间
			 */
    		private java.util.Date attribute15End;
        										
		    	    @FieldRemark(column="attribute_16",field="attribute16",name="ATTRIBUTE_16")
    	    /*
			 *ATTRIBUTE_16
			 */
    		private java.util.Date attribute16;
    		/*
			 *ATTRIBUTE_16开始时间
			 */
    		private java.util.Date attribute16Begin;
    		/*
			 *ATTRIBUTE_16截止时间
			 */
    		private java.util.Date attribute16End;
        										
		    	    @FieldRemark(column="attribute_17",field="attribute17",name="ATTRIBUTE_17")
    	    /*
			 *ATTRIBUTE_17
			 */
    		private java.util.Date attribute17;
    		/*
			 *ATTRIBUTE_17开始时间
			 */
    		private java.util.Date attribute17Begin;
    		/*
			 *ATTRIBUTE_17截止时间
			 */
    		private java.util.Date attribute17End;
        										
				 	@FieldRemark(column="attribute_18",field="attribute18",name="ATTRIBUTE_18")
		 	/*
			 *ATTRIBUTE_18
			 */
		 	private Long attribute18;
												
				 	@FieldRemark(column="attribute_19",field="attribute19",name="ATTRIBUTE_19")
		 	/*
			 *ATTRIBUTE_19
			 */
		 	private Long attribute19;
												
				 	@FieldRemark(column="attribute_20",field="attribute20",name="ATTRIBUTE_20")
		 	/*
			 *ATTRIBUTE_20
			 */
		 	private Long attribute20;
												
				 	@FieldRemark(column="acceptance_id",field="acceptanceId",name="验收单号 ")
		 	/*
			 *验收单号 
			 */
		 	private String acceptanceId;
												
				 	@FieldRemark(column="created_by_persion",field="createdByPersion",name="申请人")
		 	/*
			 *申请人
			 */
		 	private String createdByPersion;
												
				 	@FieldRemark(column="created_by_dept",field="createdByDept",name="申请人部门")
		 	/*
			 *申请人部门
			 */
		 	private String createdByDept;
												
				 	@FieldRemark(column="form_state",field="formState",name="单据状态 ")
		 	/*
			 *单据状态 
			 */
		 	private String formState;
												
				 	@FieldRemark(column="contract_num",field="contractNum",name="合同号")
		 	/*
			 *合同号
			 */
		 	private String contractNum;
												
				 	@FieldRemark(column="buyer_dept",field="buyerDept",name="采购部门")
		 	/*
			 *采购部门
			 */
		 	private String buyerDept;
												
				 	@FieldRemark(column="buyer",field="buyer",name="采购员")
		 	/*
			 *采购员
			 */
		 	private String buyer;
												
				 	@FieldRemark(column="std_id",field="stdId",name="申购单号")
		 	/*
			 *申购单号
			 */
		 	private String stdId;
												
				 	@FieldRemark(column="charge_person",field="chargePerson",name="责任人 ")
		 	/*
			 *责任人 
			 */
		 	private String chargePerson;
												
				 	@FieldRemark(column="charge_dept",field="chargeDept",name="责任部门 ")
		 	/*
			 *责任部门 
			 */
		 	private String chargeDept;
												
				 	@FieldRemark(column="charge_person_tel",field="chargePersonTel",name="责任人联系方式 ")
		 	/*
			 *责任人联系方式 
			 */
		 	private String chargePersonTel;
												
				 	@FieldRemark(column="device_name",field="deviceName",name="设备名称")
		 	/*
			 *设备名称
			 */
		 	private String deviceName;
												
				 	@FieldRemark(column="unify_id",field="unifyId",name="统一编号")
		 	/*
			 *统一编号
			 */
		 	private String unifyId;
												
				 	@FieldRemark(column="device_type",field="deviceType",name="设备类型 ")
		 	/*
			 *设备类型 
			 */
		 	private String deviceType;
												
				 	@FieldRemark(column="device_category",field="deviceCategory",name="设备类别")
		 	/*
			 *设备类别
			 */
		 	private String deviceCategory;
												
				 	@FieldRemark(column="device_model",field="deviceModel",name="设备型号")
		 	/*
			 *设备型号
			 */
		 	private String deviceModel;
												
				 	@FieldRemark(column="device_spec",field="deviceSpec",name="设备规格")
		 	/*
			 *设备规格
			 */
		 	private String deviceSpec;
												
				 	@FieldRemark(column="manufacturing_number",field="manufacturingNumber",name="出厂编号")
		 	/*
			 *出厂编号
			 */
		 	private String manufacturingNumber;
												
				 	@FieldRemark(column="producing_countries",field="producingCountries",name="生产国家和地区")
		 	/*
			 *生产国家和地区
			 */
		 	private String producingCountries;
												
				 	@FieldRemark(column="production_manufacturer",field="productionManufacturer",name="生产厂家")
		 	/*
			 *生产厂家
			 */
		 	private String productionManufacturer;
												
		    	    @FieldRemark(column="delivery_time",field="deliveryTime",name="出厂时间")
    	    /*
			 *出厂时间
			 */
    		private java.util.Date deliveryTime;
    		/*
			 *出厂时间开始时间
			 */
    		private java.util.Date deliveryTimeBegin;
    		/*
			 *出厂时间截止时间
			 */
    		private java.util.Date deliveryTimeEnd;
        										
				 	@FieldRemark(column="contract_supplier",field="contractSupplier",name="供应商")
		 	/*
			 *供应商
			 */
		 	private String contractSupplier;
												
				 	@FieldRemark(column="unit_price",field="unitPrice",name="采购单价 ")
		 	/*
			 *采购单价 
			 */
		 	private java.math.BigDecimal unitPrice;
												
				 	@FieldRemark(column="total_price",field="totalPrice",name="采购金额")
		 	/*
			 *采购金额
			 */
		 	private java.math.BigDecimal totalPrice;
												
				 	@FieldRemark(column="is_accuracy_check",field="isAccuracyCheck",name="是否精度检查")
		 	/*
			 *是否精度检查
			 */
		 	private String isAccuracyCheck;
												
				 	@FieldRemark(column="is_regular_check",field="isRegularCheck",name="是否定检")
		 	/*
			 *是否定检
			 */
		 	private String isRegularCheck;
												
				 	@FieldRemark(column="is_install",field="isInstall",name="是否安装")
		 	/*
			 *是否安装
			 */
		 	private String isInstall;
												
				 	@FieldRemark(column="employ_user",field="employUser",name="使用人 ")
		 	/*
			 *使用人 
			 */
		 	private String employUser;
												
				 	@FieldRemark(column="employ_dept",field="employDept",name="使用人部门 ")
		 	/*
			 *使用人部门 
			 */
		 	private String employDept;
												
				 	@FieldRemark(column="measuring_tag",field="measuringTag",name="计量标识")
		 	/*
			 *计量标识
			 */
		 	private String measuringTag;
												
				 	@FieldRemark(column="measuring_user",field="measuringUser",name="计量人员")
		 	/*
			 *计量人员
			 */
		 	private String measuringUser;
												
				 	@FieldRemark(column="plan_measuring",field="planMeasuring",name="计量计划员")
		 	/*
			 *计量计划员
			 */
		 	private String planMeasuring;
												
		    	    @FieldRemark(column="measuring_time",field="measuringTime",name="计量时间")
    	    /*
			 *计量时间
			 */
    		private java.util.Date measuringTime;
    		/*
			 *计量时间开始时间
			 */
    		private java.util.Date measuringTimeBegin;
    		/*
			 *计量时间截止时间
			 */
    		private java.util.Date measuringTimeEnd;
        										
				 	@FieldRemark(column="measuring_period",field="measuringPeriod",name="计量周期")
		 	/*
			 *计量周期
			 */
		 	private Long measuringPeriod;
												
				 	@FieldRemark(column="is_measuring",field="isMeasuring",name="是否计量")
		 	/*
			 *是否计量
			 */
		 	private String isMeasuring;
												
				 	@FieldRemark(column="is_scene_measuring",field="isSceneMeasuring",name="是否现场计量")
		 	/*
			 *是否现场计量
			 */
		 	private String isSceneMeasuring;
												
				 	@FieldRemark(column="is_spot_check",field="isSpotCheck",name="是否点检")
		 	/*
			 *是否点检
			 */
		 	private String isSpotCheck;
												
				 	@FieldRemark(column="is_pc",field="isPc",name="是否是计算机")
		 	/*
			 *是否是计算机
			 */
		 	private String isPc;
												
				 	@FieldRemark(column="secret_level",field="secretLevel",name="密级 ")
		 	/*
			 *密级 
			 */
		 	private String secretLevel;
												
				 	@FieldRemark(column="is_safety_production",field="isSafetyProduction",name="是否涉及安全生产")
		 	/*
			 *是否涉及安全生产
			 */
		 	private String isSafetyProduction;
												
				 	@FieldRemark(column="is_maintain",field="isMaintain",name="是否保养")
		 	/*
			 *是否保养
			 */
		 	private String isMaintain;
												
				 	@FieldRemark(column="accuracy_check_result",field="accuracyCheckResult",name="精度检查结果 ")
		 	/*
			 *精度检查结果 
			 */
		 	private String accuracyCheckResult;
												
				 	@FieldRemark(column="maintain_result",field="maintainResult",name="保养结果 ")
		 	/*
			 *保养结果 
			 */
		 	private String maintainResult;
												
				 	@FieldRemark(column="install_result",field="installResult",name="安装结果 ")
		 	/*
			 *安装结果 
			 */
		 	private String installResult;
												
				 	@FieldRemark(column="quality_result",field="qualityResult",name="质量审查结果 ")
		 	/*
			 *质量审查结果 
			 */
		 	private String qualityResult;
												
				 	@FieldRemark(column="abarbeitung_result",field="abarbeitungResult",name="整改结果 ")
		 	/*
			 *整改结果 
			 */
		 	private String abarbeitungResult;
												
				 	@FieldRemark(column="created_by_tel",field="createdByTel",name="联系电话")
		 	/*
			 *联系电话
			 */
		 	private String createdByTel;
												
				 	@FieldRemark(column="fid",field="fid",name="申购父ID")
		 	/*
			 *申购父ID
			 */
		 	private String fid;
			

  							
							public String getId(){
		  			return id;
				}
			
				public void setId(String id){
		  			this.id = id;
				}
											    		    		 	
    		 	public java.util.Date getCreationDateBegin(){
		  			return creationDateBegin;
				}
			
				public void setCreationDateBegin(java.util.Date creationDateBegin){
		  			this.creationDateBegin = creationDateBegin;
				}
				
				public java.util.Date getCreationDateEnd(){
		  			return creationDateEnd;
				}
			
				public void setCreationDateEnd(java.util.Date creationDateEnd){
		  			this.creationDateEnd = creationDateEnd;
				}
											    		    		 	
    		 	public java.util.Date getLastUpdateDateBegin(){
		  			return lastUpdateDateBegin;
				}
			
				public void setLastUpdateDateBegin(java.util.Date lastUpdateDateBegin){
		  			this.lastUpdateDateBegin = lastUpdateDateBegin;
				}
				
				public java.util.Date getLastUpdateDateEnd(){
		  			return lastUpdateDateEnd;
				}
			
				public void setLastUpdateDateEnd(java.util.Date lastUpdateDateEnd){
		  			this.lastUpdateDateEnd = lastUpdateDateEnd;
				}
																	
							public String getAttribute01(){
		  			return attribute01;
				}
			
				public void setAttribute01(String attribute01){
		  			this.attribute01 = attribute01;
				}
											
							public String getAttribute02(){
		  			return attribute02;
				}
			
				public void setAttribute02(String attribute02){
		  			this.attribute02 = attribute02;
				}
											
							public String getAttribute03(){
		  			return attribute03;
				}
			
				public void setAttribute03(String attribute03){
		  			this.attribute03 = attribute03;
				}
											
							public String getAttribute04(){
		  			return attribute04;
				}
			
				public void setAttribute04(String attribute04){
		  			this.attribute04 = attribute04;
				}
											
							public String getAttribute05(){
		  			return attribute05;
				}
			
				public void setAttribute05(String attribute05){
		  			this.attribute05 = attribute05;
				}
											
							public String getAttribute06(){
		  			return attribute06;
				}
			
				public void setAttribute06(String attribute06){
		  			this.attribute06 = attribute06;
				}
											
							public String getAttribute07(){
		  			return attribute07;
				}
			
				public void setAttribute07(String attribute07){
		  			this.attribute07 = attribute07;
				}
											
							public String getAttribute08(){
		  			return attribute08;
				}
			
				public void setAttribute08(String attribute08){
		  			this.attribute08 = attribute08;
				}
											
							public String getAttribute09(){
		  			return attribute09;
				}
			
				public void setAttribute09(String attribute09){
		  			this.attribute09 = attribute09;
				}
											
							public String getAttribute10(){
		  			return attribute10;
				}
			
				public void setAttribute10(String attribute10){
		  			this.attribute10 = attribute10;
				}
											
							public String getAttribute11(){
		  			return attribute11;
				}
			
				public void setAttribute11(String attribute11){
		  			this.attribute11 = attribute11;
				}
											
							public String getAttribute12(){
		  			return attribute12;
				}
			
				public void setAttribute12(String attribute12){
		  			this.attribute12 = attribute12;
				}
											
							public String getAttribute13(){
		  			return attribute13;
				}
			
				public void setAttribute13(String attribute13){
		  			this.attribute13 = attribute13;
				}
											
							public String getAttribute14(){
		  			return attribute14;
				}
			
				public void setAttribute14(String attribute14){
		  			this.attribute14 = attribute14;
				}
											
							public java.util.Date getAttribute15(){
		  			return attribute15;
				}
			
				public void setAttribute15(java.util.Date attribute15){
		  			this.attribute15 = attribute15;
				}
				
				public java.util.Date getAttribute15Begin(){
		  			return attribute15Begin;
				}
			
				public void setAttribute15Begin(java.util.Date attribute15Begin){
		  			this.attribute15Begin = attribute15Begin;
				}
				
				public java.util.Date getAttribute15End(){
		  			return attribute15End;
				}
			
				public void setAttribute15End(java.util.Date attribute15End){
		  			this.attribute15End = attribute15End;
				}
											
							public java.util.Date getAttribute16(){
		  			return attribute16;
				}
			
				public void setAttribute16(java.util.Date attribute16){
		  			this.attribute16 = attribute16;
				}
				
				public java.util.Date getAttribute16Begin(){
		  			return attribute16Begin;
				}
			
				public void setAttribute16Begin(java.util.Date attribute16Begin){
		  			this.attribute16Begin = attribute16Begin;
				}
				
				public java.util.Date getAttribute16End(){
		  			return attribute16End;
				}
			
				public void setAttribute16End(java.util.Date attribute16End){
		  			this.attribute16End = attribute16End;
				}
											
							public java.util.Date getAttribute17(){
		  			return attribute17;
				}
			
				public void setAttribute17(java.util.Date attribute17){
		  			this.attribute17 = attribute17;
				}
				
				public java.util.Date getAttribute17Begin(){
		  			return attribute17Begin;
				}
			
				public void setAttribute17Begin(java.util.Date attribute17Begin){
		  			this.attribute17Begin = attribute17Begin;
				}
				
				public java.util.Date getAttribute17End(){
		  			return attribute17End;
				}
			
				public void setAttribute17End(java.util.Date attribute17End){
		  			this.attribute17End = attribute17End;
				}
											
							public Long getAttribute18(){
		  			return attribute18;
				}
			
				public void setAttribute18(Long attribute18){
		  			this.attribute18 = attribute18;
				}
											
							public Long getAttribute19(){
		  			return attribute19;
				}
			
				public void setAttribute19(Long attribute19){
		  			this.attribute19 = attribute19;
				}
											
							public Long getAttribute20(){
		  			return attribute20;
				}
			
				public void setAttribute20(Long attribute20){
		  			this.attribute20 = attribute20;
				}
											
							public String getAcceptanceId(){
		  			return acceptanceId;
				}
			
				public void setAcceptanceId(String acceptanceId){
		  			this.acceptanceId = acceptanceId;
				}
											
							public String getCreatedByPersion(){
		  			return createdByPersion;
				}
			
				public void setCreatedByPersion(String createdByPersion){
		  			this.createdByPersion = createdByPersion;
				}
											
							public String getCreatedByDept(){
		  			return createdByDept;
				}
			
				public void setCreatedByDept(String createdByDept){
		  			this.createdByDept = createdByDept;
				}
											
							public String getFormState(){
		  			return formState;
				}
			
				public void setFormState(String formState){
		  			this.formState = formState;
				}
											
							public String getContractNum(){
		  			return contractNum;
				}
			
				public void setContractNum(String contractNum){
		  			this.contractNum = contractNum;
				}
											
							public String getBuyerDept(){
		  			return buyerDept;
				}
			
				public void setBuyerDept(String buyerDept){
		  			this.buyerDept = buyerDept;
				}
											
							public String getBuyer(){
		  			return buyer;
				}
			
				public void setBuyer(String buyer){
		  			this.buyer = buyer;
				}
											
							public String getStdId(){
		  			return stdId;
				}
			
				public void setStdId(String stdId){
		  			this.stdId = stdId;
				}
											
							public String getChargePerson(){
		  			return chargePerson;
				}
			
				public void setChargePerson(String chargePerson){
		  			this.chargePerson = chargePerson;
				}
											
							public String getChargeDept(){
		  			return chargeDept;
				}
			
				public void setChargeDept(String chargeDept){
		  			this.chargeDept = chargeDept;
				}
											
							public String getChargePersonTel(){
		  			return chargePersonTel;
				}
			
				public void setChargePersonTel(String chargePersonTel){
		  			this.chargePersonTel = chargePersonTel;
				}
											
							public String getDeviceName(){
		  			return deviceName;
				}
			
				public void setDeviceName(String deviceName){
		  			this.deviceName = deviceName;
				}
											
							public String getUnifyId(){
		  			return unifyId;
				}
			
				public void setUnifyId(String unifyId){
		  			this.unifyId = unifyId;
				}
											
							public String getDeviceType(){
		  			return deviceType;
				}
			
				public void setDeviceType(String deviceType){
		  			this.deviceType = deviceType;
				}
											
							public String getDeviceCategory(){
		  			return deviceCategory;
				}
			
				public void setDeviceCategory(String deviceCategory){
		  			this.deviceCategory = deviceCategory;
				}
											
							public String getDeviceModel(){
		  			return deviceModel;
				}
			
				public void setDeviceModel(String deviceModel){
		  			this.deviceModel = deviceModel;
				}
											
							public String getDeviceSpec(){
		  			return deviceSpec;
				}
			
				public void setDeviceSpec(String deviceSpec){
		  			this.deviceSpec = deviceSpec;
				}
											
							public String getManufacturingNumber(){
		  			return manufacturingNumber;
				}
			
				public void setManufacturingNumber(String manufacturingNumber){
		  			this.manufacturingNumber = manufacturingNumber;
				}
											
							public String getProducingCountries(){
		  			return producingCountries;
				}
			
				public void setProducingCountries(String producingCountries){
		  			this.producingCountries = producingCountries;
				}
											
							public String getProductionManufacturer(){
		  			return productionManufacturer;
				}
			
				public void setProductionManufacturer(String productionManufacturer){
		  			this.productionManufacturer = productionManufacturer;
				}
											
							public java.util.Date getDeliveryTime(){
		  			return deliveryTime;
				}
			
				public void setDeliveryTime(java.util.Date deliveryTime){
		  			this.deliveryTime = deliveryTime;
				}
				
				public java.util.Date getDeliveryTimeBegin(){
		  			return deliveryTimeBegin;
				}
			
				public void setDeliveryTimeBegin(java.util.Date deliveryTimeBegin){
		  			this.deliveryTimeBegin = deliveryTimeBegin;
				}
				
				public java.util.Date getDeliveryTimeEnd(){
		  			return deliveryTimeEnd;
				}
			
				public void setDeliveryTimeEnd(java.util.Date deliveryTimeEnd){
		  			this.deliveryTimeEnd = deliveryTimeEnd;
				}
											
							public String getContractSupplier(){
		  			return contractSupplier;
				}
			
				public void setContractSupplier(String contractSupplier){
		  			this.contractSupplier = contractSupplier;
				}
											
							public java.math.BigDecimal getUnitPrice(){
		  			return unitPrice;
				}
			
				public void setUnitPrice(java.math.BigDecimal unitPrice){
		  			this.unitPrice = unitPrice;
				}
											
							public java.math.BigDecimal getTotalPrice(){
		  			return totalPrice;
				}
			
				public void setTotalPrice(java.math.BigDecimal totalPrice){
		  			this.totalPrice = totalPrice;
				}
											
							public String getIsAccuracyCheck(){
		  			return isAccuracyCheck;
				}
			
				public void setIsAccuracyCheck(String isAccuracyCheck){
		  			this.isAccuracyCheck = isAccuracyCheck;
				}
											
							public String getIsRegularCheck(){
		  			return isRegularCheck;
				}
			
				public void setIsRegularCheck(String isRegularCheck){
		  			this.isRegularCheck = isRegularCheck;
				}
											
							public String getIsInstall(){
		  			return isInstall;
				}
			
				public void setIsInstall(String isInstall){
		  			this.isInstall = isInstall;
				}
											
							public String getEmployUser(){
		  			return employUser;
				}
			
				public void setEmployUser(String employUser){
		  			this.employUser = employUser;
				}
											
							public String getEmployDept(){
		  			return employDept;
				}
			
				public void setEmployDept(String employDept){
		  			this.employDept = employDept;
				}
											
							public String getMeasuringTag(){
		  			return measuringTag;
				}
			
				public void setMeasuringTag(String measuringTag){
		  			this.measuringTag = measuringTag;
				}
											
							public String getMeasuringUser(){
		  			return measuringUser;
				}
			
				public void setMeasuringUser(String measuringUser){
		  			this.measuringUser = measuringUser;
				}
											
							public String getPlanMeasuring(){
		  			return planMeasuring;
				}
			
				public void setPlanMeasuring(String planMeasuring){
		  			this.planMeasuring = planMeasuring;
				}
											
							public java.util.Date getMeasuringTime(){
		  			return measuringTime;
				}
			
				public void setMeasuringTime(java.util.Date measuringTime){
		  			this.measuringTime = measuringTime;
				}
				
				public java.util.Date getMeasuringTimeBegin(){
		  			return measuringTimeBegin;
				}
			
				public void setMeasuringTimeBegin(java.util.Date measuringTimeBegin){
		  			this.measuringTimeBegin = measuringTimeBegin;
				}
				
				public java.util.Date getMeasuringTimeEnd(){
		  			return measuringTimeEnd;
				}
			
				public void setMeasuringTimeEnd(java.util.Date measuringTimeEnd){
		  			this.measuringTimeEnd = measuringTimeEnd;
				}
											
							public Long getMeasuringPeriod(){
		  			return measuringPeriod;
				}
			
				public void setMeasuringPeriod(Long measuringPeriod){
		  			this.measuringPeriod = measuringPeriod;
				}
											
							public String getIsMeasuring(){
		  			return isMeasuring;
				}
			
				public void setIsMeasuring(String isMeasuring){
		  			this.isMeasuring = isMeasuring;
				}
											
							public String getIsSceneMeasuring(){
		  			return isSceneMeasuring;
				}
			
				public void setIsSceneMeasuring(String isSceneMeasuring){
		  			this.isSceneMeasuring = isSceneMeasuring;
				}
											
							public String getIsSpotCheck(){
		  			return isSpotCheck;
				}
			
				public void setIsSpotCheck(String isSpotCheck){
		  			this.isSpotCheck = isSpotCheck;
				}
											
							public String getIsPc(){
		  			return isPc;
				}
			
				public void setIsPc(String isPc){
		  			this.isPc = isPc;
				}
											
							public String getSecretLevel(){
		  			return secretLevel;
				}
			
				public void setSecretLevel(String secretLevel){
		  			this.secretLevel = secretLevel;
				}
											
							public String getIsSafetyProduction(){
		  			return isSafetyProduction;
				}
			
				public void setIsSafetyProduction(String isSafetyProduction){
		  			this.isSafetyProduction = isSafetyProduction;
				}
											
							public String getIsMaintain(){
		  			return isMaintain;
				}
			
				public void setIsMaintain(String isMaintain){
		  			this.isMaintain = isMaintain;
				}
											
							public String getAccuracyCheckResult(){
		  			return accuracyCheckResult;
				}
			
				public void setAccuracyCheckResult(String accuracyCheckResult){
		  			this.accuracyCheckResult = accuracyCheckResult;
				}
											
							public String getMaintainResult(){
		  			return maintainResult;
				}
			
				public void setMaintainResult(String maintainResult){
		  			this.maintainResult = maintainResult;
				}
											
							public String getInstallResult(){
		  			return installResult;
				}
			
				public void setInstallResult(String installResult){
		  			this.installResult = installResult;
				}
											
							public String getQualityResult(){
		  			return qualityResult;
				}
			
				public void setQualityResult(String qualityResult){
		  			this.qualityResult = qualityResult;
				}
											
							public String getAbarbeitungResult(){
		  			return abarbeitungResult;
				}
			
				public void setAbarbeitungResult(String abarbeitungResult){
		  			this.abarbeitungResult = abarbeitungResult;
				}
											
							public String getCreatedByTel(){
		  			return createdByTel;
				}
			
				public void setCreatedByTel(String createdByTel){
		  			this.createdByTel = createdByTel;
				}
											
							public String getFid(){
		  			return fid;
				}
			
				public void setFid(String fid){
		  			this.fid = fid;
				}
						
       
  public String getActivityalias_() {
		return activityalias_;
	}

	public void setActivityalias_(String activityalias_) {
		this.activityalias_ = activityalias_;
	}

	public String getActivityname_() {
		return activityname_;
	}

	public void setActivityname_(String activityname_) {
		this.activityname_ = activityname_;
	}

	public String getBusinessstate_() {
		return businessstate_;
	}

	public void setBusinessstate_(String businessstate_) {
		this.businessstate_ = businessstate_;
	}
	
	public String getBpmType() {
        return bpmType;
    }

    public void setBpmType(String bpmType) {
        this.bpmType = bpmType;
    }

    public String getBpmState() {
        return bpmState;
    }

    public void setBpmState(String bpmState) {
        this.bpmState = bpmState;
    }
    
    public String getCurrUserId() {
        return currUserId;
    }

    public void setCurrUserId(String currUserId) {
        this.currUserId = currUserId;
    }
	
	public String getLogFormName() {
		if(super.logFormName==null||super.logFormName.equals("")){
			return "标准设备验收";
		}else{
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if(super.logTitle==null||super.logTitle.equals("")){
			return "标准设备验收";
		}else{
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