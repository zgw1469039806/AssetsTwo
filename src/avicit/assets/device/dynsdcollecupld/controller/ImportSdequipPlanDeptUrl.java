package avicit.assets.device.dynsdcollecupld.controller;
import avicit.platform6.core.excel.imp.inf.IExcelImportUrl;
import org.springframework.stereotype.Component;
@Component(value="importSdequipPlanDept")
public class ImportSdequipPlanDeptUrl implements IExcelImportUrl {
    public ImportSdequipPlanDeptUrl() {
    }
    public String getUrl() {
        return "platform/assets/device/dynsdcollecupld/ImportSdequipPlanDeptController/importSdequipPlanDept";
    }
}
