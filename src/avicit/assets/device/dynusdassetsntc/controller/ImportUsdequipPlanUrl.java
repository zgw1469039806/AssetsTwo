package avicit.assets.device.dynusdassetsntc.controller;
import avicit.platform6.core.excel.imp.inf.IExcelImportUrl;
import org.springframework.stereotype.Component;

@Component(value="importUsdequipPlan")
public class ImportUsdequipPlanUrl implements IExcelImportUrl {
    public ImportUsdequipPlanUrl() {
    }
    public String getUrl() {
        return "platform/assets/device/dynusdassetsntc/controller/ImportUsdequipPlanController/importUsdequipPlan";
    }
}
