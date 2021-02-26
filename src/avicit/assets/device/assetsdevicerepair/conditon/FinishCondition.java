package avicit.assets.device.assetsdevicerepair.conditon;


import avicit.assets.device.assetsdevicerepair.dto.AssetsDeviceRepairDTO;
import avicit.assets.device.assetsdevicerepair.service.AssetsDeviceRepairService;
import avicit.platform6.bpm.api.model.OpenExecution;
import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;


public class FinishCondition implements RouteConditionInterface {

    private static Logger log;
    
    @Override
    public boolean evaluate(OpenExecution arg0) {
        String id = arg0.getVariable("id").toString();
        String isRepairable = arg0.getVariable("IS_REPAIRABLE").toString();
        AssetsDeviceRepairService repairService = SpringFactory.getBean("assetsDeviceRepairService");
        try {
            AssetsDeviceRepairDTO repairDTO = repairService.queryAssetsDeviceRepairByPrimaryKey(id);
            if(isRepairable.equals("Y") && repairDTO.getIsMetering().equals("N")){
                return true;
            } else {
              return false;
            }
        } catch (Exception e) {
            log.error("queryAssetsDeviceRepairByPrimaryKey出错：", e);
        }

        return false;
    }
}
