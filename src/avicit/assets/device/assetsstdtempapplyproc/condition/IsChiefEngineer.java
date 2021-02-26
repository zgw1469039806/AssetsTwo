package avicit.assets.device.assetsstdtempapplyproc.condition;

import avicit.assets.device.assetsstdtempacceptance.controller.AssetsStdtempAcceptanceController;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsStdtempapplyProcDTO;
import avicit.assets.device.assetsstdtempapplyproc.service.AssetsStdtempapplyProcService;
import avicit.platform6.bpm.api.model.OpenExecution;
import avicit.platform6.bpm.pvm.internal.model.RouteConditionInterface;
import avicit.platform6.core.jdbc.JdbcAvicit;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

public class IsChiefEngineer implements RouteConditionInterface {
    private static final Logger logger =  LoggerFactory.getLogger( AssetsStdtempAcceptanceController.class);

    @Override
    public boolean evaluate(OpenExecution arg0) {
        Double totalPrice = Double.valueOf(arg0.getVariable("totalPrice").toString());
        AssetsStdtempapplyProcService stdtempapplyProcService = SpringFactory.getBean("assetsStdtempapplyProcService");
        AssetsStdtempapplyProcDTO stdtempapplyProcDTO = new AssetsStdtempapplyProcDTO();
        try {
             stdtempapplyProcDTO = stdtempapplyProcService.queryAssetsStdtempapplyProcByPrimaryKey(arg0.getVariable("id").toString());


        }catch (Exception e){
            logger.info(e+"标准设备申购没有数据！");
        }
        if(totalPrice==0.00){
            totalPrice = Double.valueOf(stdtempapplyProcDTO.getTotalPrice().toString());

        }
       String chiefEngineer = stdtempapplyProcDTO.getChiefEngineer();
        if(chiefEngineer!=null||totalPrice>30000.0){
            return false;
        }else {
            return true;
        }
    }


}
