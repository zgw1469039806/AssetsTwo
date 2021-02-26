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
 * @类说明：ATT_INVENTORY
 * @修改记录： 
 */
 @PojoRemark(table="att_inventory",object="AttInventoryDTO",name="ATT_INVENTORY")
 public class AttInventoryDTO extends BeanDTO{
    private static final long serialVersionUID = 1L;
	
						@Id
							@LogField
				
				 	@FieldRemark(column="id",field="id",name="ID")
		 	/*
			 *ID
			 */
		 	private String id;
												
				 	@FieldRemark(column="device_model",field="deviceModel",name="DEVICE_MODEL")
		 	/*
			 *DEVICE_MODEL
			 */
		 	private String deviceModel;
												
				 	@FieldRemark(column="device_name",field="deviceName",name="DEVICE_NAME")
		 	/*
			 *DEVICE_NAME
			 */
		 	private String deviceName;
				    		    		 	/*
				 *LAST_UPDATE_DATE开始时间
				 */
    		 	private java.util.Date lastUpdateDateBegin;
    		 	/*
				 *LAST_UPDATE_DATE截止时间
				 */
    		 	private java.util.Date lastUpdateDateEnd;
    				    		    		 	/*
				 *CREATION_DATE开始时间
				 */
    		 	private java.util.Date creationDateBegin;
    		 	/*
				 *CREATION_DATE截止时间
				 */
    		 	private java.util.Date creationDateEnd;
    												
				 	@FieldRemark(column="device_category",field="deviceCategory",name="DEVICE_CATEGORY")
		 	/*
			 *DEVICE_CATEGORY
			 */
		 	private String deviceCategory;
																
				 	@FieldRemark(column="device_spec",field="deviceSpec",name="DEVICE_SPEC")
		 	/*
			 *DEVICE_SPEC
			 */
		 	private String deviceSpec;
												
				 	@FieldRemark(column="device_num",field="deviceNum",name="DEVICE_NUM")
		 	/*
			 *DEVICE_NUM
			 */
		 	private String deviceNum;
												
				 	@FieldRemark(column="fk_sub_col_id",field="fkSubColId",name="FK_SUB_COL_ID")
		 	/*
			 *FK_SUB_COL_ID
			 */
		 	private String fkSubColId;
												
				 	@FieldRemark(column="org_identity",field="orgIdentity",name="ORG_IDENTITY")
		 	/*
			 *ORG_IDENTITY
			 */
		 	private String orgIdentity;
			

  							
							public String getId(){
		  			return id;
				}
			
				public void setId(String id){
		  			this.id = id;
				}
											
							public String getDeviceModel(){
		  			return deviceModel;
				}
			
				public void setDeviceModel(String deviceModel){
		  			this.deviceModel = deviceModel;
				}
											
							public String getDeviceName(){
		  			return deviceName;
				}
			
				public void setDeviceName(String deviceName){
		  			this.deviceName = deviceName;
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
											
							public String getDeviceCategory(){
		  			return deviceCategory;
				}
			
				public void setDeviceCategory(String deviceCategory){
		  			this.deviceCategory = deviceCategory;
				}
																							
							public String getDeviceSpec(){
		  			return deviceSpec;
				}
			
				public void setDeviceSpec(String deviceSpec){
		  			this.deviceSpec = deviceSpec;
				}
											
							public String getDeviceNum(){
		  			return deviceNum;
				}
			
				public void setDeviceNum(String deviceNum){
		  			this.deviceNum = deviceNum;
				}
											
							public String getFkSubColId(){
		  			return fkSubColId;
				}
			
				public void setFkSubColId(String fkSubColId){
		  			this.fkSubColId = fkSubColId;
				}
											
							public String getOrgIdentity(){
		  			return orgIdentity;
				}
			
				public void setOrgIdentity(String orgIdentity){
		  			this.orgIdentity = orgIdentity;
				}
						
       
	
	public String getLogFormName() {
		if(super.logFormName==null||super.logFormName.equals("")){
			return "ATT_INVENTORY";
		}else{
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if(super.logTitle==null||super.logTitle.equals("")){
			return "ATT_INVENTORY";
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