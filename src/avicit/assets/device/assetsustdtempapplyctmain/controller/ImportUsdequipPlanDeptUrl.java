package avicit.assets.device.assetsustdtempapplyctmain.controller;
import avicit.platform6.core.excel.imp.inf.IExcelImportUrl;
import org.springframework.stereotype.Component;

@Component(value="importUsdequipPlanDept")
public class ImportUsdequipPlanDeptUrl implements IExcelImportUrl {
    public ImportUsdequipPlanDeptUrl() {
    }
    public String getUrl() {
        return "platform/assets/device/dynsdcollecupld/ImportUsdequipPlanDeptController/importUsdequipPlanDept";
    }
}
