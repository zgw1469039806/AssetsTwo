package avicit.assets.device.assetstdevicesoftware.dto;

import javax.persistence.Id;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-07-14 17:24 
 * @类说明：测试设备软件
 * @修改记录： 
 */
@PojoRemark(table = "assets_tdevice_software", object = "AssetsTdeviceSoftwareDTO", name = "测试设备软件")
public class AssetsTdeviceSoftwareDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 *ID
	 */
	private String id;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *CREATION_DATE开始时间
	 */
	private java.util.Date creationDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *CREATION_DATE截止时间
	 */
	private java.util.Date creationDateEnd;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *LAST_UPDATE_DATE开始时间
	 */
	private java.util.Date lastUpdateDateBegin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *LAST_UPDATE_DATE截止时间
	 */
	private java.util.Date lastUpdateDateEnd;
	@LogField

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;
	@LogField

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称")
	/*
	 *设备名称
	 */
	private String deviceName;
	@LogField

	@FieldRemark(column = "software_name", field = "softwareName", name = "软件名称")
	/*
	 *软件名称
	 */
	private String softwareName;

	@FieldRemark(column = "software_basic_name", field = "softwareBasicName", name = "软件简称")
	/*
	 *软件简称
	 */
	private String softwareBasicName;

	@FieldRemark(column = "software_id", field = "softwareId", name = "CSCI标识")
	/*
	 *CSCI标识
	 */
	private String softwareId;

	@FieldRemark(column = "software_code", field = "softwareCode", name = "软件代号")
	/*
	 *软件代号
	 */
	private String softwareCode;

	@FieldRemark(column = "software_version", field = "softwareVersion", name = "软件版本")
	/*
	 *软件版本
	 */
	private String softwareVersion;

	@FieldRemark(column = "software_release_num", field = "softwareReleaseNum", name = "软件发布号")
	/*
	 *软件发布号
	 */
	private String softwareReleaseNum;

	@FieldRemark(column = "software_period", field = "softwarePeriod", name = "研制阶段")
	/*
	 *研制阶段
	 */
	private String softwarePeriod;
	/*
	 *研制阶段显示名称
	 */
	private String softwarePeriodName;

	@FieldRemark(column = "software_code_size", field = "softwareCodeSize", name = "代码规模")
	/*
	 *代码规模
	 */
	private Long softwareCodeSize;

	@FieldRemark(column = "software_leader", field = "softwareLeader", name = "软件负责人")
	/*
	 *软件负责人
	 */
	private String softwareLeader;
	/*
	 *软件负责人显示字段
	 */
	private String softwareLeaderAlias;

	@FieldRemark(column = "software_language", field = "softwareLanguage", name = "编码语言")
	/*
	 *编码语言
	 */
	private String softwareLanguage;

	@FieldRemark(column = "software_run_environment", field = "softwareRunEnvironment", name = "运行环境")
	/*
	 *运行环境
	 */
	private String softwareRunEnvironment;

	@FieldRemark(column = "software_dev_environment", field = "softwareDevEnvironment", name = "开发环境")
	/*
	 *开发环境
	 */
	private String softwareDevEnvironment;

	@FieldRemark(column = "remarks", field = "remarks", name = "备注")
	/*
	 *备注
	 */
	private String remarks;

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
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段18
	 */
	private java.util.Date attribute18;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段18开始时间
	 */
	private java.util.Date attribute18Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段18截止时间
	 */
	private java.util.Date attribute18End;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "扩展字段19")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段19
	 */
	private java.util.Date attribute19;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段19开始时间
	 */
	private java.util.Date attribute19Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段19截止时间
	 */
	private java.util.Date attribute19End;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "扩展字段20")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段20
	 */
	private java.util.Date attribute20;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段20开始时间
	 */
	private java.util.Date attribute20Begin;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	/*
	 *扩展字段20截止时间
	 */
	private java.util.Date attribute20End;

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

	public String getSoftwareName() {
		return softwareName;
	}

	public void setSoftwareName(String softwareName) {
		this.softwareName = softwareName;
	}

	public String getSoftwareBasicName() {
		return softwareBasicName;
	}

	public void setSoftwareBasicName(String softwareBasicName) {
		this.softwareBasicName = softwareBasicName;
	}

	public String getSoftwareId() {
		return softwareId;
	}

	public void setSoftwareId(String softwareId) {
		this.softwareId = softwareId;
	}

	public String getSoftwareCode() {
		return softwareCode;
	}

	public void setSoftwareCode(String softwareCode) {
		this.softwareCode = softwareCode;
	}

	public String getSoftwareVersion() {
		return softwareVersion;
	}

	public void setSoftwareVersion(String softwareVersion) {
		this.softwareVersion = softwareVersion;
	}

	public String getSoftwareReleaseNum() {
		return softwareReleaseNum;
	}

	public void setSoftwareReleaseNum(String softwareReleaseNum) {
		this.softwareReleaseNum = softwareReleaseNum;
	}

	public String getSoftwarePeriod() {
		return softwarePeriod;
	}

	public void setSoftwarePeriod(String softwarePeriod) {
		this.softwarePeriod = softwarePeriod;
	}

	public String getSoftwarePeriodName() {
		return softwarePeriodName;
	}

	public void setSoftwarePeriodName(String softwarePeriodName) {
		this.softwarePeriodName = softwarePeriodName;
	}

	public Long getSoftwareCodeSize() {
		return softwareCodeSize;
	}

	public void setSoftwareCodeSize(Long softwareCodeSize) {
		this.softwareCodeSize = softwareCodeSize;
	}

	public String getSoftwareLeader() {
		return softwareLeader;
	}

	public void setSoftwareLeader(String softwareLeader) {
		this.softwareLeader = softwareLeader;
	}

	public String getSoftwareLeaderAlias() {
		return softwareLeaderAlias;
	}

	public void setSoftwareLeaderAlias(String softwareLeaderAlias) {
		this.softwareLeaderAlias = softwareLeaderAlias;
	}

	public String getSoftwareLanguage() {
		return softwareLanguage;
	}

	public void setSoftwareLanguage(String softwareLanguage) {
		this.softwareLanguage = softwareLanguage;
	}

	public String getSoftwareRunEnvironment() {
		return softwareRunEnvironment;
	}

	public void setSoftwareRunEnvironment(String softwareRunEnvironment) {
		this.softwareRunEnvironment = softwareRunEnvironment;
	}

	public String getSoftwareDevEnvironment() {
		return softwareDevEnvironment;
	}

	public void setSoftwareDevEnvironment(String softwareDevEnvironment) {
		this.softwareDevEnvironment = softwareDevEnvironment;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "测试设备软件";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "测试设备软件";
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