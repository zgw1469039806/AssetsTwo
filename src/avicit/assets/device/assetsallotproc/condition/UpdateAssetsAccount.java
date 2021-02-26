package avicit.assets.device.assetsallotproc.condition;

import avicit.assets.device.assetsallotproc.dto.AllotAssetsDTO;
import avicit.assets.device.assetsallotproc.service.AllotAssetsService;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class UpdateAssetsAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        //获取设备调拨子表的service
        AllotAssetsService allotAssetsService = SpringFactory.getBean("allotAssetsService");

        //获取台账管理的service
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取流程id
        String allotProcId = eventListenerExecution.getVariable("id").toString();

        //获取调入部门id
        String callInDept = eventListenerExecution.getVariable("callinDept").toString();

        //根据调拨流程id获取被调拨的设备列表
        List<AllotAssetsDTO> allotAssetsList = allotAssetsService.queryAllotAssetsByPid(allotProcId);

        if((allotAssetsList != null) && (allotAssetsList.size()>0)){
            for(AllotAssetsDTO dto : allotAssetsList){
                AssetsDeviceAccountDTO accountDTO = assetsDeviceAccountService.queryAssetsDeviceAccountByUnifiedId(dto.getUnifiedId());
                accountDTO.setUserDept(callInDept);

                //更新设备台账
                assetsDeviceAccountService.updateAssetsDeviceAccountSensitive(accountDTO);
            }
        }
    }
}
