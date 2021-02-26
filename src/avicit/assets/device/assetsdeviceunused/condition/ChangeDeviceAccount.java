package avicit.assets.device.assetsdeviceunused.condition;


import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdeviceunused.dto.AssetsDeviceUnusedsubDTO;
import avicit.assets.device.assetsdeviceunused.service.AssetsDeviceUnusedsubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class ChangeDeviceAccount  implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

       /* 从eventListenerExecution中获取主表ID */
       String id =  eventListenerExecution.getVariable("id").toString();

        AssetsDeviceUnusedsubService assetsDeviceUnusedsubService = SpringFactory.getBean("assetsDeviceUnusedsubService");

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，放入assetsDeviceUnusedsubDTOS中 */
        List<AssetsDeviceUnusedsubDTO> assetsDeviceUnusedsubDTOS = assetsDeviceUnusedsubService.queryAssetsDeviceUnusedsubByPid(id);
        
        /* 需要调assetsDeviceAccountService里面的方法，必须建立SpringFactory */
        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取流程创建人
        //String createdBy=eventListenerExecution.getVariable("createdBy").toString();
        //获取流程的formId
        String formId=eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId=eventListenerExecution.getProcessDefinitionId();

        int updateNum = 0;

        /* 循环修改台账 */
        for (AssetsDeviceUnusedsubDTO unusedDTO: assetsDeviceUnusedsubDTOS){
            /* 通过资产ID在设备台账中查询该台账信息，返回该条台账的实体DTO */
            AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(unusedDTO.getUnifiedId());

            /* 将设备台账实体的设备状态设置为 闲置：2 （从通用代码管理里面查询闲置的代码） */
            assetsDeviceAccountDTO.setDeviceState("2");

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功的数量 */
            int count = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO,"",formId,"设备闲置",flowId);
            /* 如果count值为1则表示更改台账成功，统计成功更改数量updateNum+1 */
            if(1==count){
                updateNum++;
            }
        }

    }
}
