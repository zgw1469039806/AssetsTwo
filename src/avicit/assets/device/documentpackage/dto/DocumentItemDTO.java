package avicit.assets.device.documentpackage.dto;

import javax.persistence.Id;
import avicit.platform6.core.domain.BeanDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.properties.PlatformConstant.LogType;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-08-26 20:01 
 * @类说明：DOCUMENT_ITEM
 * @修改记录： 
 */
@PojoRemark(table = "document_item", object = "DocumentItemDTO", name = "DOCUMENT_ITEM")
public class DocumentItemDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField

	@FieldRemark(column = "id", field = "id", name = "主键")
	/*
	 *主键
	 */
	private java.lang.String id;
	@LogField

	@FieldRemark(column = "package_id", field = "packageId", name = "文档包ID")
	/*
	 *文档包ID
	 */
	private java.lang.String packageId;
	@LogField

	@FieldRemark(column = "created_by", field = "createdBy", name = "创建人")
	/*
	 *创建人
	 */
	private java.lang.String createdBy;
	/*
	 *创建人显示字段
	 */
	private java.lang.String createdByAlias;

	@FieldRemark(column = "created_by_dept", field = "createdByDept", name = "创建部门")
	/*
	 *创建部门
	 */
	private java.lang.String createdByDept;
	/*
	 *创建部门显示字段
	 */
	private java.lang.String createdByDeptAlias;

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

	@FieldRemark(column = "document_name", field = "documentName", name = "文档名称")
	/*
	 *文档名称
	 */
	private java.lang.String documentName;

	@FieldRemark(column = "document_type", field = "documentType", name = "文档类型")
	/*
	 *文档类型
	 */
	private java.lang.String documentType;

	@FieldRemark(column = "document_category", field = "documentCategory", name = "文档分类")
	/*
	 *文档分类
	 */
	private java.lang.String documentCategory;

	@FieldRemark(column = "life_stage", field = "lifeStage", name = "生命阶段")
	/*
	 *生命阶段
	 */
	private java.lang.String lifeStage;

	@FieldRemark(column = "document_author", field = "documentAuthor", name = "作者")
	/*
	 *作者
	 */
	private java.lang.String documentAuthor;
	/*
	 *作者显示字段
	 */
	private java.lang.String documentAuthorAlias;

	@FieldRemark(column = "author_dept", field = "authorDept", name = "作者所在部门")
	/*
	 *作者所在部门
	 */
	private java.lang.String authorDept;
	/*
	 *作者所在部门显示字段
	 */
	private java.lang.String authorDeptAlias;

	@FieldRemark(column = "key_word", field = "keyWord", name = "关键字")
	/*
	 *关键字
	 */
	private java.lang.String keyWord;

	@FieldRemark(column = "current_version", field = "currentVersion", name = "文档版本")
	/*
	 *文档版本
	 */
	private java.lang.String currentVersion;

	@FieldRemark(column = "last_version", field = "lastVersion", name = "更新前版本")
	/*
	 *更新前版本
	 */
	private java.lang.String lastVersion;

	@FieldRemark(column = "document_state", field = "documentState", name = "文档状态")
	/*
	 *文档状态
	 */
	private java.lang.String documentState;

	@FieldRemark(column = "language_category", field = "languageCategory", name = "语言类别")
	/*
	 *语言类别
	 */
	private java.lang.String languageCategory;

	@FieldRemark(column = "secret_level", field = "secretLevel", name = "文档密级")
	/*
	 *文档密级
	 */
	private java.lang.String secretLevel;

	@FieldRemark(column = "document_abstract", field = "documentAbstract", name = "文档摘要")
	/*
	 *文档摘要
	 */
	private java.lang.String documentAbstract;

	@FieldRemark(column = "document_describe", field = "documentDescribe", name = "文档描述")
	/*
	 *文档描述
	 */
	private java.lang.String documentDescribe;

	@FieldRemark(column = "person_liable", field = "personLiable", name = "责任人")
	/*
	 *责任人
	 */
	private java.lang.String personLiable;
	/*
	 *责任人显示字段
	 */
	private java.lang.String personLiableAlias;

	@FieldRemark(column = "participants", field = "participants", name = "参与人")
	/*
	 *参与人
	 */
	private java.lang.String participants;
	/*
	 *参与人显示字段
	 */
	private java.lang.String participantsAlias;

	@FieldRemark(column = "document_update_by", field = "documentUpdateBy", name = "更新人")
	/*
	 *更新人
	 */
	private java.lang.String documentUpdateBy;
	/*
	 *更新人显示字段
	 */
	private java.lang.String documentUpdateByAlias;

	@FieldRemark(column = "document_update_date", field = "documentUpdateDate", name = "更新时间")
	/*
	 *更新时间
	 */
	private java.util.Date documentUpdateDate;
	/*
	 *更新时间开始时间
	 */
	private java.util.Date documentUpdateDateBegin;
	/*
	 *更新时间截止时间
	 */
	private java.util.Date documentUpdateDateEnd;

	@FieldRemark(column = "belong_project", field = "belongProject", name = "所属项目")
	/*
	 *所属项目
	 */
	private java.lang.String belongProject;

	@FieldRemark(column = "warehouse_catelog", field = "warehouseCatelog", name = "文档仓库目录")
	/*
	 *文档仓库目录
	 */
	private java.lang.String warehouseCatelog;

	@FieldRemark(column = "know_scope", field = "knowScope", name = "知悉范围")
	/*
	 *知悉范围
	 */
	private java.lang.String knowScope;
	/*
	 *知悉范围显示字段
	 */
	private java.lang.String knowScopeAlias;

	@FieldRemark(column = "document_label", field = "documentLabel", name = "文档标签")
	/*
	 *文档标签
	 */
	private java.lang.String documentLabel;

	@FieldRemark(column = "click_count", field = "clickCount", name = "点击数量")
	/*
	 *点击数量
	 */
	private Long clickCount;

	@FieldRemark(column = "download_count", field = "downloadCount", name = "下载数量")
	/*
	 *下载数量
	 */
	private Long downloadCount;

	@FieldRemark(column = "comment_count", field = "commentCount", name = "评论数量")
	/*
	 *评论数量
	 */
	private Long commentCount;

	@FieldRemark(column = "evaluate_score", field = "evaluateScore", name = "评价分数")
	/*
	 *评价分数
	 */
	private java.math.BigDecimal evaluateScore;

	@FieldRemark(column = "share_count", field = "shareCount", name = "分享数量")
	/*
	 *分享数量
	 */
	private Long shareCount;

	@FieldRemark(column = "liked_count", field = "likedCount", name = "点赞数量")
	/*
	 *点赞数量
	 */
	private Long likedCount;

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

	@FieldRemark(column = "document_url", field = "documentUrl", name = "文档链接")
	/*
	 *文档链接
	 */
	private java.lang.String documentUrl;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getPackageId() {
		return packageId;
	}

	public void setPackageId(java.lang.String packageId) {
		this.packageId = packageId;
	}

	public java.lang.String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(java.lang.String createdBy) {
		this.createdBy = createdBy;
	}

	public java.lang.String getCreatedByAlias() {
		return createdByAlias;
	}

	public void setCreatedByAlias(java.lang.String createdByAlias) {
		this.createdByAlias = createdByAlias;
	}

	public java.lang.String getCreatedByDept() {
		return createdByDept;
	}

	public void setCreatedByDept(java.lang.String createdByDept) {
		this.createdByDept = createdByDept;
	}

	public java.lang.String getCreatedByDeptAlias() {
		return createdByDeptAlias;
	}

	public void setCreatedByDeptAlias(java.lang.String createdByDeptAlias) {
		this.createdByDeptAlias = createdByDeptAlias;
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

	public java.lang.String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(java.lang.String documentName) {
		this.documentName = documentName;
	}

	public java.lang.String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(java.lang.String documentType) {
		this.documentType = documentType;
	}

	public java.lang.String getDocumentCategory() {
		return documentCategory;
	}

	public void setDocumentCategory(java.lang.String documentCategory) {
		this.documentCategory = documentCategory;
	}

	public java.lang.String getLifeStage() {
		return lifeStage;
	}

	public void setLifeStage(java.lang.String lifeStage) {
		this.lifeStage = lifeStage;
	}

	public java.lang.String getDocumentAuthor() {
		return documentAuthor;
	}

	public void setDocumentAuthor(java.lang.String documentAuthor) {
		this.documentAuthor = documentAuthor;
	}

	public java.lang.String getDocumentAuthorAlias() {
		return documentAuthorAlias;
	}

	public void setDocumentAuthorAlias(java.lang.String documentAuthorAlias) {
		this.documentAuthorAlias = documentAuthorAlias;
	}

	public java.lang.String getAuthorDept() {
		return authorDept;
	}

	public void setAuthorDept(java.lang.String authorDept) {
		this.authorDept = authorDept;
	}

	public java.lang.String getAuthorDeptAlias() {
		return authorDeptAlias;
	}

	public void setAuthorDeptAlias(java.lang.String authorDeptAlias) {
		this.authorDeptAlias = authorDeptAlias;
	}

	public java.lang.String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(java.lang.String keyWord) {
		this.keyWord = keyWord;
	}

	public java.lang.String getCurrentVersion() {
		return currentVersion;
	}

	public void setCurrentVersion(java.lang.String currentVersion) {
		this.currentVersion = currentVersion;
	}

	public java.lang.String getLastVersion() {
		return lastVersion;
	}

	public void setLastVersion(java.lang.String lastVersion) {
		this.lastVersion = lastVersion;
	}

	public java.lang.String getDocumentState() {
		return documentState;
	}

	public void setDocumentState(java.lang.String documentState) {
		this.documentState = documentState;
	}

	public java.lang.String getLanguageCategory() {
		return languageCategory;
	}

	public void setLanguageCategory(java.lang.String languageCategory) {
		this.languageCategory = languageCategory;
	}

	public java.lang.String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(java.lang.String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public java.lang.String getDocumentAbstract() {
		return documentAbstract;
	}

	public void setDocumentAbstract(java.lang.String documentAbstract) {
		this.documentAbstract = documentAbstract;
	}

	public java.lang.String getDocumentDescribe() {
		return documentDescribe;
	}

	public void setDocumentDescribe(java.lang.String documentDescribe) {
		this.documentDescribe = documentDescribe;
	}

	public java.lang.String getPersonLiable() {
		return personLiable;
	}

	public void setPersonLiable(java.lang.String personLiable) {
		this.personLiable = personLiable;
	}

	public java.lang.String getPersonLiableAlias() {
		return personLiableAlias;
	}

	public void setPersonLiableAlias(java.lang.String personLiableAlias) {
		this.personLiableAlias = personLiableAlias;
	}

	public java.lang.String getParticipants() {
		return participants;
	}

	public void setParticipants(java.lang.String participants) {
		this.participants = participants;
	}

	public java.lang.String getParticipantsAlias() {
		return participantsAlias;
	}

	public void setParticipantsAlias(java.lang.String participantsAlias) {
		this.participantsAlias = participantsAlias;
	}

	public java.lang.String getDocumentUpdateBy() {
		return documentUpdateBy;
	}

	public void setDocumentUpdateBy(java.lang.String documentUpdateBy) {
		this.documentUpdateBy = documentUpdateBy;
	}

	public java.lang.String getDocumentUpdateByAlias() {
		return documentUpdateByAlias;
	}

	public void setDocumentUpdateByAlias(java.lang.String documentUpdateByAlias) {
		this.documentUpdateByAlias = documentUpdateByAlias;
	}

	public java.util.Date getDocumentUpdateDate() {
		return documentUpdateDate;
	}

	public void setDocumentUpdateDate(java.util.Date documentUpdateDate) {
		this.documentUpdateDate = documentUpdateDate;
	}

	public java.util.Date getDocumentUpdateDateBegin() {
		return documentUpdateDateBegin;
	}

	public void setDocumentUpdateDateBegin(java.util.Date documentUpdateDateBegin) {
		this.documentUpdateDateBegin = documentUpdateDateBegin;
	}

	public java.util.Date getDocumentUpdateDateEnd() {
		return documentUpdateDateEnd;
	}

	public void setDocumentUpdateDateEnd(java.util.Date documentUpdateDateEnd) {
		this.documentUpdateDateEnd = documentUpdateDateEnd;
	}

	public java.lang.String getBelongProject() {
		return belongProject;
	}

	public void setBelongProject(java.lang.String belongProject) {
		this.belongProject = belongProject;
	}

	public java.lang.String getWarehouseCatelog() {
		return warehouseCatelog;
	}

	public void setWarehouseCatelog(java.lang.String warehouseCatelog) {
		this.warehouseCatelog = warehouseCatelog;
	}

	public java.lang.String getKnowScope() {
		return knowScope;
	}

	public void setKnowScope(java.lang.String knowScope) {
		this.knowScope = knowScope;
	}

	public java.lang.String getKnowScopeAlias() {
		return knowScopeAlias;
	}

	public void setKnowScopeAlias(java.lang.String knowScopeAlias) {
		this.knowScopeAlias = knowScopeAlias;
	}

	public java.lang.String getDocumentLabel() {
		return documentLabel;
	}

	public void setDocumentLabel(java.lang.String documentLabel) {
		this.documentLabel = documentLabel;
	}

	public Long getClickCount() {
		return clickCount;
	}

	public void setClickCount(Long clickCount) {
		this.clickCount = clickCount;
	}

	public Long getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(Long downloadCount) {
		this.downloadCount = downloadCount;
	}

	public Long getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(Long commentCount) {
		this.commentCount = commentCount;
	}

	public java.math.BigDecimal getEvaluateScore() {
		return evaluateScore;
	}

	public void setEvaluateScore(java.math.BigDecimal evaluateScore) {
		this.evaluateScore = evaluateScore;
	}

	public Long getShareCount() {
		return shareCount;
	}

	public void setShareCount(Long shareCount) {
		this.shareCount = shareCount;
	}

	public Long getLikedCount() {
		return likedCount;
	}

	public void setLikedCount(Long likedCount) {
		this.likedCount = likedCount;
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

	public java.lang.String getDocumentUrl() {
		return documentUrl;
	}

	public void setDocumentUrl(java.lang.String documentUrl) {
		this.documentUrl = documentUrl;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "DOCUMENT_ITEM";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "DOCUMENT_ITEM";
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