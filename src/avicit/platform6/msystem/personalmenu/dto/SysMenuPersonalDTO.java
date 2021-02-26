//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package avicit.platform6.msystem.personalmenu.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;

import javax.persistence.Id;
import java.util.Date;

@PojoRemark(
        table = "sys_menu_personal",
        object = "SysMenuPersonalDTO",
        name = "个人常用菜单"
)
public class SysMenuPersonalDTO extends BeanDTO {
    private static final long serialVersionUID = 1L;
    private static final String SYSPERSONALMENU = "SYS_PERSONAL_MENU";
    @Id
    @LogField
    @FieldRemark(
            column = "id",
            field = "id",
            name = "唯一标识"
    )
    private String id;
    @FieldRemark(
            column = "user_id",
            field = "userId",
            name = "用户id"
    )
    private String userId;
    @FieldRemark(
            column = "menu_id",
            field = "menuId",
            name = "菜单id"
    )
    private String menuId;
    private Date lastUpdateDateBegin;
    private Date lastUpdateDateEnd;
    private Date creationDateBegin;
    private Date creationDateEnd;
    @FieldRemark(
            column = "attribute_01",
            field = "attribute01",
            name = "ATTRIBUTE_01"
    )
    private String attribute01;
    @FieldRemark(
            column = "attribute_02",
            field = "attribute02",
            name = "ATTRIBUTE_02"
    )
    private String attribute02;
    @FieldRemark(
            column = "attribute_03",
            field = "attribute03",
            name = "ATTRIBUTE_03"
    )
    private String attribute03;
    @FieldRemark(
            column = "attribute_04",
            field = "attribute04",
            name = "ATTRIBUTE_04"
    )
    private String attribute04;
    @FieldRemark(
            column = "attribute_05",
            field = "attribute05",
            name = "ATTRIBUTE_05"
    )
    private String attribute05;
    @FieldRemark(
            column = "attribute_06",
            field = "attribute06",
            name = "ATTRIBUTE_06"
    )
    private String attribute06;
    @FieldRemark(
            column = "attribute_07",
            field = "attribute07",
            name = "ATTRIBUTE_07"
    )
    private String attribute07;
    @FieldRemark(
            column = "attribute_08",
            field = "attribute08",
            name = "ATTRIBUTE_08"
    )
    private String attribute08;
    @FieldRemark(
            column = "attribute_09",
            field = "attribute09",
            name = "ATTRIBUTE_09"
    )
    private String attribute09;
    @FieldRemark(
            column = "attribute_10",
            field = "attribute10",
            name = "ATTRIBUTE_10"
    )
    private String attribute10;
    @FieldRemark(
            column = "orderBy",
            field = "orderBy",
            name = "排序"
    )
    private Long orderBy;
    @FieldRemark(
            column = "module_Id",
            field = "moduleId",
            name = "模块Id"
    )
    private String moduleId;


    public SysMenuPersonalDTO() {
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMenuId() {
        return this.menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public Date getLastUpdateDateBegin() {
        return this.lastUpdateDateBegin;
    }

    public void setLastUpdateDateBegin(Date lastUpdateDateBegin) {
        this.lastUpdateDateBegin = lastUpdateDateBegin;
    }

    public Date getLastUpdateDateEnd() {
        return this.lastUpdateDateEnd;
    }

    public void setLastUpdateDateEnd(Date lastUpdateDateEnd) {
        this.lastUpdateDateEnd = lastUpdateDateEnd;
    }

    public Date getCreationDateBegin() {
        return this.creationDateBegin;
    }

    public void setCreationDateBegin(Date creationDateBegin) {
        this.creationDateBegin = creationDateBegin;
    }

    public Date getCreationDateEnd() {
        return this.creationDateEnd;
    }

    public void setCreationDateEnd(Date creationDateEnd) {
        this.creationDateEnd = creationDateEnd;
    }

    public String getAttribute01() {
        return this.attribute01;
    }

    public void setAttribute01(String attribute01) {
        this.attribute01 = attribute01;
    }

    public String getAttribute02() {
        return this.attribute02;
    }

    public void setAttribute02(String attribute02) {
        this.attribute02 = attribute02;
    }

    public String getAttribute03() {
        return this.attribute03;
    }

    public void setAttribute03(String attribute03) {
        this.attribute03 = attribute03;
    }

    public String getAttribute04() {
        return this.attribute04;
    }

    public void setAttribute04(String attribute04) {
        this.attribute04 = attribute04;
    }

    public String getAttribute05() {
        return this.attribute05;
    }

    public void setAttribute05(String attribute05) {
        this.attribute05 = attribute05;
    }

    public String getAttribute06() {
        return this.attribute06;
    }

    public void setAttribute06(String attribute06) {
        this.attribute06 = attribute06;
    }

    public String getAttribute07() {
        return this.attribute07;
    }

    public void setAttribute07(String attribute07) {
        this.attribute07 = attribute07;
    }

    public String getAttribute08() {
        return this.attribute08;
    }

    public void setAttribute08(String attribute08) {
        this.attribute08 = attribute08;
    }

    public String getAttribute09() {
        return this.attribute09;
    }

    public void setAttribute09(String attribute09) {
        this.attribute09 = attribute09;
    }

    public String getAttribute10() {
        return this.attribute10;
    }

    public void setAttribute10(String attribute10) {
        this.attribute10 = attribute10;
    }

    public Long getOrderBy() {
        return this.orderBy;
    }

    public void setOrderBy(Long orderBy) {
        this.orderBy = orderBy;
    }

    public String getLogFormName() {
        return super.logFormName != null && !super.logFormName.equals("") ? super.logFormName : "个人常用菜单";
    }

    public String getLogTitle() {
        return super.logTitle != null && !super.logTitle.equals("") ? super.logTitle : "个人常用菜单";
    }

    public LogType getLogType() {
        return super.logType != null && !super.logType.equals("") ? super.logType : LogType.module_operate;
    }
}
