package avicit.assets.device.assetsshiftproc.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class UpdateAssetsAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        //获取台账管理的service
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取设备统一编号
        String unifiedId = eventListenerExecution.getVariable("unifiedId").toString();

        //移位位置
        String newPositon = eventListenerExecution.getVariable("shiftPosition").toString();

        AssetsDeviceAccountDTO accountDTO = assetsDeviceAccountService.queryAssetsDeviceAccountByUnifiedId(unifiedId);
        accountDTO.setPositionId(newPositon);

        //更新台账
        assetsDeviceAccountService.updateAssetsDeviceAccountSensitive(accountDTO);
    }
}
