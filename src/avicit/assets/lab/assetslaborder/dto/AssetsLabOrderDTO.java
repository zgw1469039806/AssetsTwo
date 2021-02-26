package avicit.assets.lab.assetslaborder.dto;

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
 * @创建时间： 2020-08-26 15:34 
 * @类说明：实验室预约流程
 * @修改记录： 
 */
@PojoRemark(table = "assets_lab_order", object = "AssetsLabOrderDTO", name = "实验室预约流程")
public class AssetsLabOrderDTO extends BeanDTO {
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

	@FieldRemark(column = "order_number", field = "orderNumber", name = "预约单号")
	/*
	 *预约单号
	 */
	private String orderNumber;

	@FieldRemark(column = "apply_id", field = "applyId", name = "申请人")
	/*
	 *申请人
	 */
	private String applyId;
	/*
	 *申请人显示字段
	 */
	private String applyIdAlias;

	@FieldRemark(column = "apply_dept", field = "applyDept", name = "申请部门")
	/*
	 *申请部门
	 */
	private String applyDept;
	/*
	 *申请部门显示字段
	 */
	private String applyDeptAlias;

	@FieldRemark(column = "telephone", field = "telephone", name = "联系电话")
	/*
	 *联系电话
	 */
	private String telephone;

	@FieldRemark(column = "tdevice_name", field = "tdeviceName", name = "试件名称")
	/*
	 *试件名称
	 */
	private String tdeviceName;

	@FieldRemark(column = "tdevice_code", field = "tdeviceCode", name = "试件代号")
	/*
	 *试件代号
	 */
	private String tdeviceCode;

	@FieldRemark(column = "tdevice_model", field = "tdeviceModel", name = "试件型号")
	/*
	 *试件型号
	 */
	private String tdeviceModel;

	@FieldRemark(column = "tdevice_num", field = "tdeviceNum", name = "试件编号")
	/*
	 *试件编号
	 */
	private String tdeviceNum;

	@FieldRemark(column = "belong_model", field = "belongModel", name = "所属机型")
	/*
	 *所属机型
	 */
	private String belongModel;

	@FieldRemark(column = "test_type", field = "testType", name = "试验类型")
	/*
	 *试验类型
	 */
	private String testType;

	@FieldRemark(column = "test_nature", field = "testNature", name = "试验性质")
	/*
	 *试验性质
	 */
	private String testNature;

	@FieldRemark(column = "test_condition", field = "testCondition", name = "试验条件")
	/*
	 *试验条件
	 */
	private String testCondition;

	@FieldRemark(column = "support_tool", field = "supportTool", name = "配套工装")
	/*
	 *配套工装
	 */
	private String supportTool;

	@FieldRemark(column = "order_start_time", field = "orderStartTime", name = "预约开始时间")
	/*
	 *预约开始时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date orderStartTime;
	/*
	 *预约开始时间开始时间
	 */
	private java.util.Date orderStartTimeBegin;
	/*
	 *预约开始时间截止时间
	 */
	private java.util.Date orderStartTimeEnd;

	@FieldRemark(column = "order_finish_time", field = "orderFinishTime", name = "预约结束时间")
	/*
	 *预约结束时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date orderFinishTime;
	/*
	 *预约结束时间开始时间
	 */
	private java.util.Date orderFinishTimeBegin;
	/*
	 *预约结束时间截止时间
	 */
	private java.util.Date orderFinishTimeEnd;

	@FieldRemark(column = "lab_device_id", field = "labDeviceId", name = "实验设备ID")
	/*
	 *实验设备ID
	 */
	private String labDeviceId;

	@FieldRemark(column = "lab_device_uid", field = "labDeviceUid", name = "实验设备统一编号")
	/*
	 *实验设备统一编号
	 */
	private String labDeviceUid;

	@FieldRemark(column = "lab_device_name", field = "labDeviceName", name = "实验设备名称")
	/*
	 *实验设备名称
	 */
	private String labDeviceName;

	@FieldRemark(column = "approval_start_time", field = "approvalStartTime", name = "审核开始时间")
	/*
	 *审核开始时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date approvalStartTime;
	/*
	 *审核开始时间开始时间
	 */
	private java.util.Date approvalStartTimeBegin;
	/*
	 *审核开始时间截止时间
	 */
	private java.util.Date approvalStartTimeEnd;

	@FieldRemark(column = "approval_finish_time", field = "approvalFinishTime", name = "审核结束时间")
	/*
	 *审核结束时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date approvalFinishTime;
	/*
	 *审核结束时间开始时间
	 */
	private java.util.Date approvalFinishTimeBegin;
	/*
	 *审核结束时间截止时间
	 */
	private java.util.Date approvalFinishTimeEnd;

	@FieldRemark(column = "actual_start_time", field = "actualStartTime", name = "实际开始时间")
	/*
	 *实际开始时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date actualStartTime;
	/*
	 *实际开始时间开始时间
	 */
	private java.util.Date actualStartTimeBegin;
	/*
	 *实际开始时间截止时间
	 */
	private java.util.Date actualStartTimeEnd;

	@FieldRemark(column = "actual_finish_time", field = "actualFinishTime", name = "实际结束时间")
	/*
	 *实际结束时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone= "GMT+8")
	private java.util.Date actualFinishTime;
	/*
	 *实际结束时间开始时间
	 */
	private java.util.Date actualFinishTimeBegin;
	/*
	 *实际结束时间截止时间
	 */
	private java.util.Date actualFinishTimeEnd;

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
	private String attribute15;

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

	//编码管理：加入编码值属性
	private java.lang.String autoCodeValue;
	public String getAutoCodeValue() {
		return autoCodeValue;
	}

	public void setAutoCodeValue(String autoCodeValue) {
		this.autoCodeValue = autoCodeValue;
	}

	private java.util.Date attribute30End;

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

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getApplyIdAlias() {
		return applyIdAlias;
	}

	public void setApplyIdAlias(String applyIdAlias) {
		this.applyIdAlias = applyIdAlias;
	}

	public String getApplyDept() {
		return applyDept;
	}

	public void setApplyDept(String applyDept) {
		this.applyDept = applyDept;
	}

	public String getApplyDeptAlias() {
		return applyDeptAlias;
	}

	public void setApplyDeptAlias(String applyDeptAlias) {
		this.applyDeptAlias = applyDeptAlias;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getTdeviceName() {
		return tdeviceName;
	}

	public void setTdeviceName(String tdeviceName) {
		this.tdeviceName = tdeviceName;
	}

	public String getTdeviceCode() {
		return tdeviceCode;
	}

	public void setTdeviceCode(String tdeviceCode) {
		this.tdeviceCode = tdeviceCode;
	}

	public String getTdeviceModel() {
		return tdeviceModel;
	}

	public void setTdeviceModel(String tdeviceModel) {
		this.tdeviceModel = tdeviceModel;
	}

	public String getTdeviceNum() {
		return tdeviceNum;
	}

	public void setTdeviceNum(String tdeviceNum) {
		this.tdeviceNum = tdeviceNum;
	}

	public String getBelongModel() {
		return belongModel;
	}

	public void setBelongModel(String belongModel) {
		this.belongModel = belongModel;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

	public String getTestNature() {
		return testNature;
	}

	public void setTestNature(String testNature) {
		this.testNature = testNature;
	}

	public String getTestCondition() {
		return testCondition;
	}

	public void setTestCondition(String testCondition) {
		this.testCondition = testCondition;
	}

	public String getSupportTool() {
		return supportTool;
	}

	public void setSupportTool(String supportTool) {
		this.supportTool = supportTool;
	}

	public java.util.Date getOrderStartTime() {
		return orderStartTime;
	}

	public void setOrderStartTime(java.util.Date orderStartTime) {
		this.orderStartTime = orderStartTime;
	}

	public java.util.Date getOrderStartTimeBegin() {
		return orderStartTimeBegin;
	}

	public void setOrderStartTimeBegin(java.util.Date orderStartTimeBegin) {
		this.orderStartTimeBegin = orderStartTimeBegin;
	}

	public java.util.Date getOrderStartTimeEnd() {
		return orderStartTimeEnd;
	}

	public void setOrderStartTimeEnd(java.util.Date orderStartTimeEnd) {
		this.orderStartTimeEnd = orderStartTimeEnd;
	}

	public java.util.Date getOrderFinishTime() {
		return orderFinishTime;
	}

	public void setOrderFinishTime(java.util.Date orderFinishTime) {
		this.orderFinishTime = orderFinishTime;
	}

	public java.util.Date getOrderFinishTimeBegin() {
		return orderFinishTimeBegin;
	}

	public void setOrderFinishTimeBegin(java.util.Date orderFinishTimeBegin) {
		this.orderFinishTimeBegin = orderFinishTimeBegin;
	}

	public java.util.Date getOrderFinishTimeEnd() {
		return orderFinishTimeEnd;
	}

	public void setOrderFinishTimeEnd(java.util.Date orderFinishTimeEnd) {
		this.orderFinishTimeEnd = orderFinishTimeEnd;
	}

	public String getLabDeviceId() {
		return labDeviceId;
	}

	public void setLabDeviceId(String labDeviceId) {
		this.labDeviceId = labDeviceId;
	}

	public String getLabDeviceUid() {
		return labDeviceUid;
	}

	public void setLabDeviceUid(String labDeviceUid) {
		this.labDeviceUid = labDeviceUid;
	}

	public String getLabDeviceName() {
		return labDeviceName;
	}

	public void setLabDeviceName(String labDeviceName) {
		this.labDeviceName = labDeviceName;
	}

	public java.util.Date getApprovalStartTime() {
		return approvalStartTime;
	}

	public void setApprovalStartTime(java.util.Date approvalStartTime) {
		this.approvalStartTime = approvalStartTime;
	}

	public java.util.Date getApprovalStartTimeBegin() {
		return approvalStartTimeBegin;
	}

	public void setApprovalStartTimeBegin(java.util.Date approvalStartTimeBegin) {
		this.approvalStartTimeBegin = approvalStartTimeBegin;
	}

	public java.util.Date getApprovalStartTimeEnd() {
		return approvalStartTimeEnd;
	}

	public void setApprovalStartTimeEnd(java.util.Date approvalStartTimeEnd) {
		this.approvalStartTimeEnd = approvalStartTimeEnd;
	}

	public java.util.Date getApprovalFinishTime() {
		return approvalFinishTime;
	}

	public void setApprovalFinishTime(java.util.Date approvalFinishTime) {
		this.approvalFinishTime = approvalFinishTime;
	}

	public java.util.Date getApprovalFinishTimeBegin() {
		return approvalFinishTimeBegin;
	}

	public void setApprovalFinishTimeBegin(java.util.Date approvalFinishTimeBegin) {
		this.approvalFinishTimeBegin = approvalFinishTimeBegin;
	}

	public java.util.Date getApprovalFinishTimeEnd() {
		return approvalFinishTimeEnd;
	}

	public void setApprovalFinishTimeEnd(java.util.Date approvalFinishTimeEnd) {
		this.approvalFinishTimeEnd = approvalFinishTimeEnd;
	}

	public java.util.Date getActualStartTime() {
		return actualStartTime;
	}

	public void setActualStartTime(java.util.Date actualStartTime) {
		this.actualStartTime = actualStartTime;
	}

	public java.util.Date getActualStartTimeBegin() {
		return actualStartTimeBegin;
	}

	public void setActualStartTimeBegin(java.util.Date actualStartTimeBegin) {
		this.actualStartTimeBegin = actualStartTimeBegin;
	}

	public java.util.Date getActualStartTimeEnd() {
		return actualStartTimeEnd;
	}

	public void setActualStartTimeEnd(java.util.Date actualStartTimeEnd) {
		this.actualStartTimeEnd = actualStartTimeEnd;
	}

	public java.util.Date getActualFinishTime() {
		return actualFinishTime;
	}

	public void setActualFinishTime(java.util.Date actualFinishTime) {
		this.actualFinishTime = actualFinishTime;
	}

	public java.util.Date getActualFinishTimeBegin() {
		return actualFinishTimeBegin;
	}

	public void setActualFinishTimeBegin(java.util.Date actualFinishTimeBegin) {
		this.actualFinishTimeBegin = actualFinishTimeBegin;
	}

	public java.util.Date getActualFinishTimeEnd() {
		return actualFinishTimeEnd;
	}

	public void setActualFinishTimeEnd(java.util.Date actualFinishTimeEnd) {
		this.actualFinishTimeEnd = actualFinishTimeEnd;
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

	public String getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(String attribute15) {
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
			return "实验室预约流程";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "实验室预约流程";
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