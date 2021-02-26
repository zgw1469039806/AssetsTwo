package avicit.assets.device.assetsreconstructionproc.condition;

import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;

public class AssetsReconstructionCondition implements EventListener {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private static Logger log;
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService = SpringFactory.getBean("assetsUstdtempAcceptanceService");
        String avicit_bpm_formCode = eventListenerExecution.getVariable("avicit_bpm_formCode").toString();
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");


    }
}
