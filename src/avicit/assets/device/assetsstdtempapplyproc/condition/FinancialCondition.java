package avicit.assets.device.assetsstdtempapplyproc.condition;

import avicit.platform6.bpm.api.model.OpenExecution;
import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
import avicit.platform6.core.jdbc.JdbcAvicit;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Map;


public class FinancialCondition implements RouteConditionInterface {
    private static Logger log;

    @Override
    public boolean evaluate(OpenExecution arg0) {

        Double totalPrice = Double.valueOf(arg0.getVariable("totalPrice").toString());

        if(totalPrice>30000.0){
            return true;
        }else {
            return false;
        }
    }
}
