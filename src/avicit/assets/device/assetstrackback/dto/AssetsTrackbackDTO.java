package avicit.assets.device.assetstrackback.dto;

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
 * @创建时间： 2020-09-08 17:35 
 * @类说明：超差追溯
 * @修改记录： 
 */
@PojoRemark(table = "assets_trackback", object = "AssetsTrackbackDTO", name = "超差追溯")
public class AssetsTrackbackDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private String activityalias_; // 节点中文名称
	private String activityname_; // 当前节点id
	private String businessstate_; // 流程当前状态
	private String currUserId; // 当前登录人ID
	private String bpmType;
	private String bpmState;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private String id;
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
	@LogField

	@FieldRemark(column = "metering_id", field = "meteringId", name = "关联计量单号")
	/*
	 *关联计量单号
	 */
	private String meteringId;
	@LogField

	@FieldRemark(column = "applicant_id", field = "applicantId", name = "申请人ID")
	/*
	 *申请人ID
	 */
	private String applicantId;
	/*
	 *申请人ID显示字段
	 */
	private String applicantIdAlias;
	@LogField

	@FieldRemark(column = "applicant_depart", field = "applicantDepart", name = "APPLICANT_DEPART")
	/*
	 *APPLICANT_DEPART
	 */
	private String applicantDepart;
	/*
	 *APPLICANT_DEPART显示字段
	 */
	private String applicantDepartAlias;

	@FieldRemark(column = "device_user_id", field = "deviceUserId", name = "DEVICE_USER_ID")
	/*
	 *DEVICE_USER_ID
	 */
	private String deviceUserId;
	/*
	 *DEVICE_USER_ID显示字段
	 */
	private String deviceUserIdAlias;

	@FieldRemark(column = "device_user_dept", field = "deviceUserDept", name = "DEVICE_USER_DEPT")
	/*
	 *DEVICE_USER_DEPT
	 */
	private String deviceUserDept;
	/*
	 *DEVICE_USER_DEPT显示字段
	 */
	private String deviceUserDeptAlias;

	@FieldRemark(column = "form_state", field = "formState", name = "表单状态")
	/*
	 *表单状态
	 */
	private String formState;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;

	@FieldRemark(column = "device_category", field = "deviceCategory", name = "设备类别")
	/*
	 *设备类别
	 */
	private String deviceCategory;

	@FieldRemark(column = "device_spec", field = "deviceSpec", name = "DEVICE_SPEC")
	/*
	 *DEVICE_SPEC
	 */
	private String deviceSpec;

	@FieldRemark(column = "device_model", field = "deviceModel", name = "DEVICE_MODEL")
	/*
	 *DEVICE_MODEL
	 */
	private String deviceModel;

	@FieldRemark(column = "manufacturer_id", field = "manufacturerId", name = "MANUFACTURER_ID")
	/*
	 *MANUFACTURER_ID
	 */
	private String manufacturerId;

	@FieldRemark(column = "last_metering_date", field = "lastMeteringDate", name = "LAST_METERING_DATE")
	/*
	 *LAST_METERING_DATE
	 */
	private java.util.Date lastMeteringDate;
	/*
	 *LAST_METERING_DATE开始时间
	 */
	private java.util.Date lastMeteringDateBegin;
	/*
	 *LAST_METERING_DATE截止时间
	 */
	private java.util.Date lastMeteringDateEnd;

	@FieldRemark(column = "meter_person", field = "meterPerson", name = "METER_PERSON")
	/*
	 *METER_PERSON
	 */
	private String meterPerson;
	/*
	 *METER_PERSON显示字段
	 */
	private String meterPersonAlias;

	@FieldRemark(column = "meter_conclusion", field = "meterConclusion", name = "METER_CONCLUSION")
	/*
	 *METER_CONCLUSION
	 */
	private String meterConclusion;

	@FieldRemark(column = "device_metrics", field = "deviceMetrics", name = "DEVICE_METRICS")
	/*
	 *DEVICE_METRICS
	 */
	private String deviceMetrics;

	@FieldRemark(column = "calibration_result", field = "calibrationResult", name = "CALIBRATION_RESULT")
	/*
	 *CALIBRATION_RESULT
	 */
	private String calibrationResult;

	@FieldRemark(column = "effect_analyse", field = "effectAnalyse", name = "EFFECT_ANALYSE")
	/*
	 *EFFECT_ANALYSE
	 */
	private String effectAnalyse;

	@FieldRemark(column = "quality_safe_opinion", field = "qualitySafeOpinion", name = "QUALITY_SAFE_OPINION")
	/*
	 *QUALITY_SAFE_OPINION
	 */
	private String qualitySafeOpinion;

	@FieldRemark(column = "chief_opinion", field = "chiefOpinion", name = "CHIEF_OPINION")
	/*
	 *CHIEF_OPINION
	 */
	private String chiefOpinion;

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
	private Long attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "扩展字段12")
	/*
	 *扩展字段12
	 */
	private Long attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "扩展字段13")
	/*
	 *扩展字段13
	 */
	private Long attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "扩展字段14")
	/*
	 *扩展字段14
	 */
	private java.math.BigDecimal attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "扩展字段15")
	/*
	 *扩展字段15
	 */
	private java.math.BigDecimal attribute15;

	@FieldRemark(column = "attribute_16", field = "attribute16", name = "扩展字段16")
	/*
	 *扩展字段16
	 */
	private java.math.BigDecimal attribute16;

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
	private java.util.Date attribute18;
	/*
	 *扩展字段18开始时间
	 */
	private java.util.Date attribute18Begin;
	/*
	 *扩展字段18截止时间
	 */
	private java.util.Date attribute18End;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
	/*
	 *扩展字段19
	 */
	private java.util.Date attribute19;
	/*
	 *扩展字段19开始时间
	 */
	private java.util.Date attribute19Begin;
	/*
	 *扩展字段19截止时间
	 */
	private java.util.Date attribute19End;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
	/*
	 *扩展字段20
	 */
	private java.util.Date attribute20;
	/*
	 *扩展字段20开始时间
	 */
	private java.util.Date attribute20Begin;
	/*
	 *扩展字段20截止时间
	 */
	private java.util.Date attribute20End;

	@FieldRemark(column = "proc_id", field = "procId", name = "超差追溯单编号")
	/*
	 *超差追溯单编号
	 */
	private String procId;

	@FieldRemark(column = "data_24", field = "data24", name = "字段_24")
	/*
	 *字段_24
	 */
	private String data24;

	@FieldRemark(column = "has_effection", field = "hasEffection", name = "对产品是否有影响")
	/*
	 *对产品是否有影响
	 */
	private String hasEffection;

	public String getId() {
		return id;
	}

	public void setId(String id) {
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

	public String getMeteringId() {
		return meteringId;
	}

	public void setMeteringId(String meteringId) {
		this.meteringId = meteringId;
	}

	public String getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(String applicantId) {
		this.applicantId = applicantId;
	}

	public String getApplicantIdAlias() {
		return applicantIdAlias;
	}

	public void setApplicantIdAlias(String applicantIdAlias) {
		this.applicantIdAlias = applicantIdAlias;
	}

	public String getApplicantDepart() {
		return applicantDepart;
	}

	public void setApplicantDepart(String applicantDepart) {
		this.applicantDepart = applicantDepart;
	}

	public String getApplicantDepartAlias() {
		return applicantDepartAlias;
	}

	public void setApplicantDepartAlias(String applicantDepartAlias) {
		this.applicantDepartAlias = applicantDepartAlias;
	}

	public String getDeviceUserId() {
		return deviceUserId;
	}

	public void setDeviceUserId(String deviceUserId) {
		this.deviceUserId = deviceUserId;
	}

	public String getDeviceUserIdAlias() {
		return deviceUserIdAlias;
	}

	public void setDeviceUserIdAlias(String deviceUserIdAlias) {
		this.deviceUserIdAlias = deviceUserIdAlias;
	}

	public String getDeviceUserDept() {
		return deviceUserDept;
	}

	public void setDeviceUserDept(String deviceUserDept) {
		this.deviceUserDept = deviceUserDept;
	}

	public String getDeviceUserDeptAlias() {
		return deviceUserDeptAlias;
	}

	public void setDeviceUserDeptAlias(String deviceUserDeptAlias) {
		this.deviceUserDeptAlias = deviceUserDeptAlias;
	}

	public String getFormState() {
		return formState;
	}

	public void setFormState(String formState) {
		this.formState = formState;
	}

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceCategory() {
		return deviceCategory;
	}

	public void setDeviceCategory(String deviceCategory) {
		this.deviceCategory = deviceCategory;
	}

	public String getDeviceSpec() {
		return deviceSpec;
	}

	public void setDeviceSpec(String deviceSpec) {
		this.deviceSpec = deviceSpec;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public java.util.Date getLastMeteringDate() {
		return lastMeteringDate;
	}

	public void setLastMeteringDate(java.util.Date lastMeteringDate) {
		this.lastMeteringDate = lastMeteringDate;
	}

	public java.util.Date getLastMeteringDateBegin() {
		return lastMeteringDateBegin;
	}

	public void setLastMeteringDateBegin(java.util.Date lastMeteringDateBegin) {
		this.lastMeteringDateBegin = lastMeteringDateBegin;
	}

	public java.util.Date getLastMeteringDateEnd() {
		return lastMeteringDateEnd;
	}

	public void setLastMeteringDateEnd(java.util.Date lastMeteringDateEnd) {
		this.lastMeteringDateEnd = lastMeteringDateEnd;
	}

	public String getMeterPerson() {
		return meterPerson;
	}

	public void setMeterPerson(String meterPerson) {
		this.meterPerson = meterPerson;
	}

	public String getMeterPersonAlias() {
		return meterPersonAlias;
	}

	public void setMeterPersonAlias(String meterPersonAlias) {
		this.meterPersonAlias = meterPersonAlias;
	}

	public String getMeterConclusion() {
		return meterConclusion;
	}

	public void setMeterConclusion(String meterConclusion) {
		this.meterConclusion = meterConclusion;
	}

	public String getDeviceMetrics() {
		return deviceMetrics;
	}

	public void setDeviceMetrics(String deviceMetrics) {
		this.deviceMetrics = deviceMetrics;
	}

	public String getCalibrationResult() {
		return calibrationResult;
	}

	public void setCalibrationResult(String calibrationResult) {
		this.calibrationResult = calibrationResult;
	}

	public String getEffectAnalyse() {
		return effectAnalyse;
	}

	public void setEffectAnalyse(String effectAnalyse) {
		this.effectAnalyse = effectAnalyse;
	}

	public String getQualitySafeOpinion() {
		return qualitySafeOpinion;
	}

	public void setQualitySafeOpinion(String qualitySafeOpinion) {
		this.qualitySafeOpinion = qualitySafeOpinion;
	}

	public String getChiefOpinion() {
		return chiefOpinion;
	}

	public void setChiefOpinion(String chiefOpinion) {
		this.chiefOpinion = chiefOpinion;
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

	public Long getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(Long attribute11) {
		this.attribute11 = attribute11;
	}

	public Long getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(Long attribute12) {
		this.attribute12 = attribute12;
	}

	public Long getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(Long attribute13) {
		this.attribute13 = attribute13;
	}

	public java.math.BigDecimal getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(java.math.BigDecimal attribute14) {
		this.attribute14 = attribute14;
	}

	public java.math.BigDecimal getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(java.math.BigDecimal attribute15) {
		this.attribute15 = attribute15;
	}

	public java.math.BigDecimal getAttribute16() {
		return attribute16;
	}

	public void setAttribute16(java.math.BigDecimal attribute16) {
		this.attribute16 = attribute16;
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

	public java.util.Date getAttribute18() {
		return attribute18;
	}

	public void setAttribute18(java.util.Date attribute18) {
		this.attribute18 = attribute18;
	}

	public java.util.Date getAttribute18Begin() {
		return attribute18Begin;
	}

	public void setAttribute18Begin(java.util.Date attribute18Begin) {
		this.attribute18Begin = attribute18Begin;
	}

	public java.util.Date getAttribute18End() {
		return attribute18End;
	}

	public void setAttribute18End(java.util.Date attribute18End) {
		this.attribute18End = attribute18End;
	}

	public java.util.Date getAttribute19() {
		return attribute19;
	}

	public void setAttribute19(java.util.Date attribute19) {
		this.attribute19 = attribute19;
	}

	public java.util.Date getAttribute19Begin() {
		return attribute19Begin;
	}

	public void setAttribute19Begin(java.util.Date attribute19Begin) {
		this.attribute19Begin = attribute19Begin;
	}

	public java.util.Date getAttribute19End() {
		return attribute19End;
	}

	public void setAttribute19End(java.util.Date attribute19End) {
		this.attribute19End = attribute19End;
	}

	public java.util.Date getAttribute20() {
		return attribute20;
	}

	public void setAttribute20(java.util.Date attribute20) {
		this.attribute20 = attribute20;
	}

	public java.util.Date getAttribute20Begin() {
		return attribute20Begin;
	}

	public void setAttribute20Begin(java.util.Date attribute20Begin) {
		this.attribute20Begin = attribute20Begin;
	}

	public java.util.Date getAttribute20End() {
		return attribute20End;
	}

	public void setAttribute20End(java.util.Date attribute20End) {
		this.attribute20End = attribute20End;
	}

	public String getProcId() {
		return procId;
	}

	public void setProcId(String procId) {
		this.procId = procId;
	}

	public String getData24() {
		return data24;
	}

	public void setData24(String data24) {
		this.data24 = data24;
	}

	public String getHasEffection() {
		return hasEffection;
	}

	public void setHasEffection(String hasEffection) {
		this.hasEffection = hasEffection;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "超差追溯";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "超差追溯";
		} else {
			return super.logTitle;
		}
	}

	public String getCurrUserId() {
		return currUserId;
	}

	public void setCurrUserId(String currUserId) {
		this.currUserId = currUserId;
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

	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}