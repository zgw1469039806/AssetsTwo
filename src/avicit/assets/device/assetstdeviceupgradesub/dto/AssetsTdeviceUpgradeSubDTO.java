package avicit.assets.device.assetstdeviceupgradesub.dto;

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
 * @创建时间： 2020-07-28 08:43 
 * @类说明：测试设备升级子表
 * @修改记录： 
 */
@PojoRemark(table = "assets_tdevice_upgrade_sub", object = "AssetsTdeviceUpgradeSubDTO", name = "测试设备升级子表")
public class AssetsTdeviceUpgradeSubDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "ID")
	/*
	 *ID
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

	@FieldRemark(column = "software_version", field = "softwareVersion", name = "原软件版本")
	/*
	 *原软件版本
	 */
	private String softwareVersion;

	@FieldRemark(column = "software_version_new", field = "softwareVersionNew", name = "升级软件版本")
	/*
	 *升级软件版本
	 */
	private String softwareVersionNew;

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

	@FieldRemark(column = "tdevice_foreign", field = "tdeviceForeign", name = "子表外键")
	/*
	 *子表外键
	 */
	private String tdeviceForeign;
	@LogField

	@FieldRemark(column = "tdevice_software_id", field = "tdeviceSoftwareId", name = "软件台账ID")
	/*
	 *软件台账ID
	 */
	private String tdeviceSoftwareId;

	@FieldRemark(column = "upgrade_info", field = "upgradeInfo", name = "升级说明")
	/*
	 *升级说明
	 */
	private String upgradeInfo;

	@FieldRemark(column = "attachement_url", field = "attachementUrl", name = "附件地址")
	/*
	 *附件地址
	 */
	private String attachementUrl;

	@FieldRemark(column = "attachement_name", field = "attachementName", name = "附件名称")
	/*
	 *附件名称
	 */
	private String attachementName;

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

	public String getSoftwareVersionNew() {
		return softwareVersionNew;
	}

	public void setSoftwareVersionNew(String softwareVersionNew) {
		this.softwareVersionNew = softwareVersionNew;
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

	public String getTdeviceForeign() {
		return tdeviceForeign;
	}

	public void setTdeviceForeign(String tdeviceForeign) {
		this.tdeviceForeign = tdeviceForeign;
	}

	public String getTdeviceSoftwareId() {
		return tdeviceSoftwareId;
	}

	public void setTdeviceSoftwareId(String tdeviceSoftwareId) {
		this.tdeviceSoftwareId = tdeviceSoftwareId;
	}

	public String getUpgradeInfo() {
		return upgradeInfo;
	}

	public void setUpgradeInfo(String upgradeInfo) {
		this.upgradeInfo = upgradeInfo;
	}

	public String getAttachementUrl() {
		return attachementUrl;
	}

	public void setAttachementUrl(String attachementUrl) {
		this.attachementUrl = attachementUrl;
	}

	public String getAttachementName() {
		return attachementName;
	}

	public void setAttachementName(String attachementName) {
		this.attachementName = attachementName;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "测试设备升级子表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "测试设备升级子表";
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