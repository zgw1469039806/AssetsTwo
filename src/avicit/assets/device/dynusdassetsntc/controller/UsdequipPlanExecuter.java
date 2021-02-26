package avicit.assets.device.dynusdassetsntc.controller;

import avicit.platform6.core.excel.imp.entity.ExcelHeader;
import avicit.platform6.core.excel.imp.executor.AbstractExcutor;

public class UsdequipPlanExecuter extends AbstractExcutor {
        private String name;
    public UsdequipPlanExecuter(String name) {
        this.name = name;
        this.initHeader();
    }
    private void initHeader() {
        this.headers.add(new ExcelHeader("xuhao", "序号"));
        this.headers.add(new ExcelHeader("stdIdCm", "申购单号"));
        this.headers.add(new ExcelHeader("attribute05", "申请人"));
        this.headers.add(new ExcelHeader("createdByDept", "申请人部门"));
        this.headers.add(new ExcelHeader("attribute02", "申请人账号"));
        this.headers.add(new ExcelHeader("deviceNameCm", "设备名称"));
        this.headers.add(new ExcelHeader("deviceCategoryCm", "设备类别"));

        this.headers.add(new ExcelHeader("belongProjectCm", "所属项目"));
        this.headers.add(new ExcelHeader("financialResourcesCm", "经费来源"));
        this.headers.add(new ExcelHeader("financialEstimateCm", "经费概算"));
        this.headers.add(new ExcelHeader("replyNameCm", "批复名称"));
        this.headers.add(new ExcelHeader("approvalFormNumberCm", "立项单号"));

    }

    public void addHeader(ExcelHeader header) {
        this.headers.add(header);
    }

    public String getName() {
        return this.name;
    }
}
