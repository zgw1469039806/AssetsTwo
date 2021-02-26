package avicit.assets.device.assetsdevicerepair.conditon;

import avicit.platform6.bpm.api.model.OpenExecution;
import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
import org.slf4j.Logger;


public class NotRepairableCondition implements RouteConditionInterface {

    private static Logger log;

    @Override
    public boolean evaluate(OpenExecution arg0) {
        String isRepairable = arg0.getVariable("IS_REPAIRABLE").toString();
        if(isRepairable.equals("N")) {
            return true;
        }
        return false;
    }
}
