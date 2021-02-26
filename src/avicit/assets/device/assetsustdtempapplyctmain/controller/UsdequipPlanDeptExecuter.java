package avicit.assets.device.assetsustdtempapplyctmain.controller;

import avicit.platform6.core.excel.imp.entity.ExcelHeader;
import avicit.platform6.core.excel.imp.executor.AbstractExcutor;

public class UsdequipPlanDeptExecuter extends AbstractExcutor {
        private String name;
    public UsdequipPlanDeptExecuter(String name) {
        this.name = name;
        this.initHeader();
    }
    private void initHeader() {
        this.headers.add(new ExcelHeader("xuhao", "序号"));
        this.headers.add(new ExcelHeader("attribute05", "申请人"));
        this.headers.add(new ExcelHeader("createdByDeptAlias", "申请人部门"));
        this.headers.add(new ExcelHeader("attribute02", "申请人账号"));
        this.headers.add(new ExcelHeader("deviceName", "设备名称"));
        this.headers.add(new ExcelHeader("deviceCategory", "设备类别"));

        this.headers.add(new ExcelHeader("belongProject", "所属项目"));
        this.headers.add(new ExcelHeader("financialResourcesName", "经费来源"));
        this.headers.add(new ExcelHeader("financialEstimate", "经费概算"));
        this.headers.add(new ExcelHeader("replyName", "批复名称"));
        this.headers.add(new ExcelHeader("approvalFormNumber", "立项单号"));

    }

    public void addHeader(ExcelHeader header) {
        this.headers.add(header);
    }

    public String getName() {
        return this.name;
    }
}
