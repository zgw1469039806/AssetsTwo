package avicit.assets.assetsapplymodule.condition;

import avicit.platform6.bpm.api.model.OpenExecution;
import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
import avicit.platform6.core.jdbc.JdbcAvicit;
import avicit.platform6.core.spring.SpringFactory;
import org.springframework.jdbc.core.JdbcTemplate;

public class AssetsApplyModuleIncident2 implements RouteConditionInterface {

    @Override
    public boolean evaluate(OpenExecution arg0) {

        Double totalPrice = Double.valueOf(arg0.getVariable("totalPrice").toString());
        if(totalPrice==0.00){

        }
        if(totalPrice>30000.0){
            return true;
        }

        return false;
    }
}
