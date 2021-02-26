package avicit.assets.device.dynsdcollecmain.controller;
import avicit.platform6.core.excel.imp.inf.IExcelImportUrl;
import org.springframework.stereotype.Component;
@Component(value="importSdequipPlan")
public class ImportSdequipPlanUrl implements IExcelImportUrl {
    public ImportSdequipPlanUrl() {
    }
    public String getUrl() {
        return "platform/assets/device/dynsdcollecmain/ImportSdequipPlanController/importSdequipPlan";
    }
}
