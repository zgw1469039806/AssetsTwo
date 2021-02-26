package avicit.assets.device.assetsdevicereuse.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicereuse.dto.AssetsDeviceReuseDTO;
import avicit.assets.device.assetsdevicereuse.dto.AssetsDeviceReusesubDTO;
import avicit.assets.device.assetsdevicereuse.service.AssetsDeviceReuseService;
import avicit.assets.device.assetsdevicereuse.service.AssetsDeviceReusesubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class ReuseChangeAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();
        AssetsDeviceReuseService deviceReuseService = SpringFactory.getBean("assetsDeviceReuseService");

        /* 从eventListenerExecution中获取主表ID */
        AssetsDeviceReuseDTO deviceReuseDTO = deviceReuseService.queryAssetsDeviceReuseByPrimaryKey(id);
        String createbyperson = deviceReuseDTO.getCreatedByPerson();    /* 修获取创建人ID */
        String createbydept = deviceReuseDTO.getCreatedByDept();        /* 修获取创建人部门ID */

        AssetsDeviceReusesubService deviceReusesubService =SpringFactory.getBean("assetsDeviceReusesubService");
        List<AssetsDeviceReusesubDTO> DeviceReusesubDTOS = deviceReusesubService.queryAssetsDeviceReusesubByPid(id);

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
        for (AssetsDeviceReusesubDTO assetsDto : DeviceReusesubDTOS){
            /* 通过资产ID在设备台账中查询该台账信息，返回该条台账的实体DTO */
            AssetsDeviceAccountDTO deviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(assetsDto.getUnifiedId());

            deviceAccountDTO.setOwnerId(createbyperson);        /* 修改台账的责任人ID为申请人的ID */
            deviceAccountDTO.setUserId(createbyperson);         /* 修改台账的使用人ID为申请人的ID */
            deviceAccountDTO.setOwnerDept(createbydept);        /* 修改台账的责任人部门为申请人部门 */
            deviceAccountDTO.setUserDept(createbydept);         /* 修改台账的使用人部门为申请人部门 */
            deviceAccountDTO.setDeviceState("1");               /* 修改台账的设备状态为在用，在用的通用代码为：1 */

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功的数量 */
            int count = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(deviceAccountDTO,"",formId,"设备再用",flowId);
            /* 如果count值为1则表示更改台账成功，统计成功更改数量updateNum+1 */
            if(1==count){
                updateNum++;
            }
        }
    }
}
