package avicit.assets.device.dynsdcollecupld.controller;

import avicit.platform6.core.excel.imp.entity.ExcelHeader;
import avicit.platform6.core.excel.imp.executor.AbstractExcutor;

public class SdequipPlanDeptExecuter extends AbstractExcutor {
        private String name;
    public SdequipPlanDeptExecuter(String name) {
        this.name = name;
        this.initHeader();
    }
    private void initHeader() {
        this.headers.add(new ExcelHeader("xuhao", "序号"));
        this.headers.add(new ExcelHeader("createdByPersionAlias", "申请人"));
        this.headers.add(new ExcelHeader("createdByDeptAlias", "申请人部门"));
        this.headers.add(new ExcelHeader("attribute02", "申请人账号"));
        this.headers.add(new ExcelHeader("deviceName", "设备名称"));
        this.headers.add(new ExcelHeader("deviceType", "设备类型"));
        this.headers.add(new ExcelHeader("deviceSpec", "设备规格"));
        this.headers.add(new ExcelHeader("deviceModel", "设备型号"));
        this.headers.add(new ExcelHeader("referencePlant", "参考厂家"));
        this.headers.add(new ExcelHeader("deviceNum", "台（套）数"));
        this.headers.add(new ExcelHeader("unitPrice", "单价"));
        this.headers.add(new ExcelHeader("totalPrice", "总金额"));
    }

    public void addHeader(ExcelHeader header) {
        this.headers.add(header);
    }

    public String getName() {
        return this.name;
    }
}
