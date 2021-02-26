package avicit.assets.device.assetsdevicescrap.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicescrap.dto.AssetsDeviceScrapDTO;
import avicit.assets.device.assetsdevicescrap.service.AssetsDeviceScrapService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class ScrapChangeAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取表单ID */
        String id = eventListenerExecution.getVariable("id").toString();

        AssetsDeviceScrapService deviceScrapService = SpringFactory.getBean("assetsDeviceScrapService");

        /* 通过表单ID从主表中查出对应的 deviceScrapDTO */
        AssetsDeviceScrapDTO deviceScrapDTO = deviceScrapService.queryAssetsDeviceScrapByPrimaryKey(id);

        String deviceId = deviceScrapDTO.getDeviceId();      /* 从deviceScrapDTO中获取设备ID */

        //获取流程创建人
//        String createdBy=eventListenerExecution.getVariable("CREATED_BY_PERSON").toString();
        //获取流程的formId
        String formId=eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId=eventListenerExecution.getProcessDefinitionId();

        /* 需要调assetsDeviceAccountService里面的方法，必须建立SpringFactory */
        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        /* 通过设备ID 查询到设备台账的对应实体 */
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByPrimaryKey(deviceId);

        /* 将设备台账实体的统管设备状态设置为 待报废：3 （从通用代码管理里面查询闲置的代码） */
        assetsDeviceAccountDTO.setDeviceState("3");

        /* 调用修改台账的函数，将修改后的DDEVICE_STATETO传给台账的修改方法，成功后返回修改成功的数量 */
        int updateNum = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO,"",formId,"设备报废",flowId);

    }
}
