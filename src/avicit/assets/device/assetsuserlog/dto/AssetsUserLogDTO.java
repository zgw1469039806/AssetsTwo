package avicit.assets.device.assetsuserlog.dto;

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
 * @创建时间： 2020-07-13 10:07 
 * @类说明：资产用户日志表
 * @修改记录： 
 */
@PojoRemark(table = "assets_user_log", object = "AssetsUserLogDTO", name = "资产用户日志表")
public class AssetsUserLogDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;


	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键ID")
	/*
	 *主键ID
	 */
	private String id;

	@FieldRemark(column = "userid", field = "userid", name = "操作用户ID  ")
	/*
	 *操作用户ID  
	 */
	private String userid;

	@FieldRemark(column = "user_name", field = "userName", name = "操作用户姓名    ")
	/*
	 *操作用户姓名    
	 */
	private String userName;

	@FieldRemark(column = "deptid", field = "deptid", name = "操作用户部门ID ")
	/*
	 *操作用户部门ID 
	 */
	private String deptid;

	@FieldRemark(column = "dept_name", field = "deptName", name = "操作用户部门名称")
	/*
	 *操作用户部门名称
	 */
	private String deptName;

	@FieldRemark(column = "time", field = "time", name = "操作时间  ")
	/*
	 *操作时间  
	 */
	private java.util.Date time;
	/*
	 *操作时间  开始时间
	 */
	private java.util.Date timeBegin;
	/*
	 *操作时间  截止时间
	 */
	private java.util.Date timeEnd;

	@FieldRemark(column = "ip", field = "ip", name = "操作IP   ")
	/*
	 *操作IP   
	 */
	private String ip;

	@FieldRemark(column = "op_type", field = "opType", name = "操作类型")
	/*
	 *操作类型
	 */
	private String opType;

	@FieldRemark(column = "module_name", field = "moduleName", name = "模块名称  ")
	/*
	 *模块名称  
	 */
	private String moduleName;

	@FieldRemark(column = "module_id", field = "moduleId", name = "模块ID  ")
	/*
	 *模块ID  
	 */
	private String moduleId;

	@FieldRemark(column = "device_name", field = "deviceName", name = "设备名称 ")
	/*
	 *设备名称 
	 */
	private String deviceName;

	@FieldRemark(column = "deviceid", field = "deviceid", name = "设备ID ")
	/*
	 *设备ID 
	 */
	private String deviceid;

	@FieldRemark(column = "log_content", field = "logContent", name = "日志内容")
	/*
	 *日志内容
	 */
	private String logContent;

	@FieldRemark(column = "op_result", field = "opResult", name = "操作结果 ")
	/*
	 *操作结果 
	 */
	private String opResult;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "密级")
	/*
	 *密级
	 */
	private String secretLevel;

	@FieldRemark(column = "source", field = "source", name = "业务来源（流程名称）")
	/*
	 *业务来源（流程名称）
	 */
	private String source;

	@FieldRemark(column = "sourceid", field = "sourceid", name = "业务来源的ID （流程名称的ID）  ")
	/*
	 *业务来源的ID （流程名称的ID）  
	 */
	private String sourceid;

	@FieldRemark(column = "formid", field = "formid", name = "履历卡")
	/*
	 *履历卡
	 */
	private String formid;

	@FieldRemark(column = "attribute_01", field = "attribute01", name = "ATTRIBUTE_01")
	/*
	 *ATTRIBUTE_01
	 */
	private String attribute01;

	@FieldRemark(column = "attribute_02", field = "attribute02", name = "ATTRIBUTE_02")
	/*
	 *ATTRIBUTE_02
	 */
	private String attribute02;

	@FieldRemark(column = "attribute_03", field = "attribute03", name = "ATTRIBUTE_03")
	/*
	 *ATTRIBUTE_03
	 */
	private String attribute03;

	@FieldRemark(column = "attribute_04", field = "attribute04", name = "ATTRIBUTE_04")
	/*
	 *ATTRIBUTE_04
	 */
	private String attribute04;

	@FieldRemark(column = "attribute_05", field = "attribute05", name = "ATTRIBUTE_05")
	/*
	 *ATTRIBUTE_05
	 */
	private String attribute05;

	@FieldRemark(column = "attribute_06", field = "attribute06", name = "ATTRIBUTE_06")
	/*
	 *ATTRIBUTE_06
	 */
	private String attribute06;

	@FieldRemark(column = "attribute_07", field = "attribute07", name = "ATTRIBUTE_07")
	/*
	 *ATTRIBUTE_07
	 */
	private String attribute07;

	@FieldRemark(column = "attribute_08", field = "attribute08", name = "ATTRIBUTE_08")
	/*
	 *ATTRIBUTE_08
	 */
	private String attribute08;

	@FieldRemark(column = "attribute_09", field = "attribute09", name = "ATTRIBUTE_09")
	/*
	 *ATTRIBUTE_09
	 */
	private String attribute09;

	@FieldRemark(column = "attribute_10", field = "attribute10", name = "ATTRIBUTE_10")
	/*
	 *ATTRIBUTE_10
	 */
	private String attribute10;
	/*
	*最后修改时间开始时间
	*/
	private java.util.Date lastUpdateDateBegin;
	/*
	 *最后修改时间截止时间
	 */
	private java.util.Date lastUpdateDateEnd;
	/*
	*创建时间开始时间
	*/
	private java.util.Date creationDateBegin;
	/*
	 *创建时间截止时间
	 */
	private java.util.Date creationDateEnd;

	@FieldRemark(column = "unified_id", field = "unifiedId", name = "统一编号")
	/*
	 *统一编号
	 */
	private String unifiedId;

	@FieldRemark(column = "attribute_11", field = "attribute11", name = "ATTRIBUTE_11")
	/*
	 *ATTRIBUTE_11
	 */
	private String attribute11;

	@FieldRemark(column = "attribute_12", field = "attribute12", name = "ATTRIBUTE_12")
	/*
	 *ATTRIBUTE_12
	 */
	private String attribute12;

	@FieldRemark(column = "attribute_13", field = "attribute13", name = "ATTRIBUTE_13")
	/*
	 *ATTRIBUTE_13
	 */
	private String attribute13;

	@FieldRemark(column = "attribute_14", field = "attribute14", name = "ATTRIBUTE_14")
	/*
	 *ATTRIBUTE_14
	 */
	private String attribute14;

	@FieldRemark(column = "attribute_15", field = "attribute15", name = "ATTRIBUTE_15")
	/*
	 *ATTRIBUTE_15
	 */
	private String attribute15;

	@FieldRemark(column = "attribute_16", field = "attribute16", name = "ATTRIBUTE_16")
	/*
	 *ATTRIBUTE_16
	 */
	private String attribute16;

	@FieldRemark(column = "attribute_17", field = "attribute17", name = "ATTRIBUTE_17")
	/*
	 *ATTRIBUTE_17
	 */
	private String attribute17;

	@FieldRemark(column = "attribute_18", field = "attribute18", name = "ATTRIBUTE_18")
	/*
	 *ATTRIBUTE_18
	 */
	private String attribute18;

	@FieldRemark(column = "attribute_19", field = "attribute19", name = "ATTRIBUTE_19")
	/*
	 *ATTRIBUTE_19
	 */
	private String attribute19;

	@FieldRemark(column = "attribute_20", field = "attribute20", name = "ATTRIBUTE_20")
	/*
	 *ATTRIBUTE_20
	 */
	private String attribute20;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public java.util.Date getTime() {
		return time;
	}

	public void setTime(java.util.Date time) {
		this.time = time;
	}

	public java.util.Date getTimeBegin() {
		return timeBegin;
	}

	public void setTimeBegin(java.util.Date timeBegin) {
		this.timeBegin = timeBegin;
	}

	public java.util.Date getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(java.util.Date timeEnd) {
		this.timeEnd = timeEnd;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getOpType() {
		return opType;
	}

	public void setOpType(String opType) {
		this.opType = opType;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceid() {
		return deviceid;
	}

	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}

	public String getLogContent() {
		return logContent;
	}

	public void setLogContent(String logContent) {
		this.logContent = logContent;
	}

	public String getOpResult() {
		return opResult;
	}

	public void setOpResult(String opResult) {
		this.opResult = opResult;
	}

	public String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getSourceid() {
		return sourceid;
	}

	public void setSourceid(String sourceid) {
		this.sourceid = sourceid;
	}

	public String getFormid() {
		return formid;
	}

	public void setFormid(String formid) {
		this.formid = formid;
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

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unifiedId) {
		this.unifiedId = unifiedId;
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

	public String getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(String attribute15) {
		this.attribute15 = attribute15;
	}

	public String getAttribute16() {
		return attribute16;
	}

	public void setAttribute16(String attribute16) {
		this.attribute16 = attribute16;
	}

	public String getAttribute17() {
		return attribute17;
	}

	public void setAttribute17(String attribute17) {
		this.attribute17 = attribute17;
	}

	public String getAttribute18() {
		return attribute18;
	}

	public void setAttribute18(String attribute18) {
		this.attribute18 = attribute18;
	}

	public String getAttribute19() {
		return attribute19;
	}

	public void setAttribute19(String attribute19) {
		this.attribute19 = attribute19;
	}

	public String getAttribute20() {
		return attribute20;
	}

	public void setAttribute20(String attribute20) {
		this.attribute20 = attribute20;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "资产用户日志表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "资产用户日志表";
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