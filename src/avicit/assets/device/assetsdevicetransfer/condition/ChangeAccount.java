package avicit.assets.device.assetsdevicetransfer.condition;


import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsDeviceTransferDTO;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;
import avicit.assets.device.assetsdevicetransfer.service.AssetsDeviceTransferService;
import avicit.assets.device.assetsdevicetransfer.service.AssetsTransferprocDeviceService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class ChangeAccount implements EventListener {

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中几乎包含了页面表单的全部数据，获取接收人的ID */
        String receiver = eventListenerExecution.getVariable("receiver").toString();

        /* 从eventListenerExecution中获取接受人部门ID */
        String receiverdept = eventListenerExecution.getVariable("receiverDept").toString();

        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();

        /* 需要调用assetsTransferprocDeviceService里面的方法，必须建立SpringFactory */
        AssetsTransferprocDeviceService transferprocDeviceService = SpringFactory.getBean("assetsTransferprocDeviceService");

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，放入assetsTransferprocDeviceDTOS中 */
        List<AssetsTransferprocDeviceDTO> assetsTransferprocDeviceDTOS = transferprocDeviceService.queryAssetsTransferprocDeviceByPid(id);

        /* 需要调assetsDeviceAccountService里面的方法，必须建立SpringFactory */
        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取流程创建人
        String createdBy = eventListenerExecution.getVariable("createdBy").toString();
        //获取流程的formId
        String formId = eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId = eventListenerExecution.getProcessDefinitionId();


        int updateNum = 0;
        /* 循环修改台账 */
        for (AssetsTransferprocDeviceDTO assetsDto : assetsTransferprocDeviceDTOS) {
            AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(assetsDto.getUnifiedId());    /* 通过资产ID在设备台账中查询该台账信息，返回该条台账的实体DTO */
            assetsDeviceAccountDTO.setOwnerId(receiver);        /* 修改台账的责任人ID为移交接收人的ID */
            assetsDeviceAccountDTO.setUserId(receiver);         /* 修改台账的使用人ID为移交接收人的ID */
            assetsDeviceAccountDTO.setOwnerDept(receiverdept);  /* 修改台账的责任人部门为移交接收人的责任人部门 */
            assetsDeviceAccountDTO.setUserDept(receiverdept);   /* 修改台账的使用人部门为移交接收人的责任人部门 */

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功数量 */
            int count = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO,createdBy,formId,"设备移交",flowId);
            /* 如果count值为1则表示更改台账成功，统计成功更改数量updateNum+1 */
            if(1==count){
                updateNum++;
            }

        }

    }
}
