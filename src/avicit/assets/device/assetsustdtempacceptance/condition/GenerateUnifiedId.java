package avicit.assets.device.assetsustdtempacceptance.condition;

import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.assets.device.classifydata.dto.ClassifyDataDTO;
import avicit.assets.device.classifydata.service.ClassifyDataService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class GenerateUnifiedId implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        //获取非标验收的service
        AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService = SpringFactory.getBean("assetsUstdtempAcceptanceService");

        //获取台账的service
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取分类的service
        ClassifyDataService classifyDataService = SpringFactory.getBean("classifyDataService");

        //获取验收单号
        String acceptanceNo = eventListenerExecution.getVariable("acceptanceNo").toString();
        AssetsUstdtempAcceptanceDTO acceptanceDTO = assetsUstdtempAcceptanceService.getAssetsUstdtempAcceptanceByAcceptanceNo(acceptanceNo);

        //获取分类编码
        ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(acceptanceDTO.getDeviceCategory());
        String classifyCode = classifyDataDTO.getCode();

        //获取当前台账最大的流水号
        Long maxSerialNumber = assetsDeviceAccountService.getMaxSerialNumber();
        maxSerialNumber = maxSerialNumber + 1;

        //统一编号：分类编号+流水号
        acceptanceDTO.setUnifiedId(classifyCode + maxSerialNumber);

        assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptanceSensitive(acceptanceDTO);
    }
}
