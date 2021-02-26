package avicit.assets.furniture.assetsfurnituretransferproc.condition;

import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;
import avicit.assets.furniture.assetsfurnitureaccount.service.AssetsFurnitureAccountService;
import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferProcDTO;
import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferSubDTO;
import avicit.assets.furniture.assetsfurnituretransferproc.service.AssetsFurnitureTransferProcService;
import avicit.assets.furniture.assetsfurnituretransferproc.service.AssetsFurnitureTransferSubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class UpdateFurnitureAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中几乎包含了页面表单的全部数据，获取接收人的ID */
        String receiver = eventListenerExecution.getVariable("RECEIVER").toString();

        /* 从eventListenerExecution中获取接受人部门ID */
        String receiverdept = eventListenerExecution.getVariable("RECEIVER_DEPT").toString();

        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();

        /* 建立家具台账的SpringFactory */
        AssetsFurnitureAccountService furnitureAccountService = SpringFactory.getBean("assetsFurnitureAccountService");
        /* 建立设备移交主表的SpringFactory */
        AssetsFurnitureTransferProcService furnitureTransferProcService = SpringFactory.getBean("assetsFurnitureTransferProcService");
        /* 建立设备移交子表的SpringFactory */
        AssetsFurnitureTransferSubService furnitureTransferSubService = SpringFactory.getBean("assetsFurnitureTransferSubService");

        AssetsFurnitureTransferProcDTO furnitureTransferProcDTO = furnitureTransferProcService.queryAssetsFurnitureTransferProcByPrimaryKey(id);

        /* 获取接收安装地点的id */
        String receivePositionId = furnitureTransferProcDTO.getReceivePositionId();

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，子表furnitureTransferSubDTOS */
        List<AssetsFurnitureTransferSubDTO> furnitureTransferSubDTOS = furnitureTransferSubService.queryAssetsFurnitureTransferSubByPid(id);

        int updateNum = 0;
        /* 循环修改台账 */
        for(AssetsFurnitureTransferSubDTO furnitureTransferSubDTO:furnitureTransferSubDTOS){
            String unifiedId = furnitureTransferSubDTO.getUnifiedId();  /* 获取子表记录中一条数据的unifiedId */
            /* 通过unifiedId在家具台账中查询unifiedId对应的一条DTO数据 */
            AssetsFurnitureAccountDTO assetsFurnitureAccountDTO = furnitureAccountService.queryAssetsFurnitureAccountByUnifiedId(unifiedId);
            assetsFurnitureAccountDTO.setOwnerId(receiver);         /* 将台账责任人设置为接收人 */
            assetsFurnitureAccountDTO.setOwnerDept(receiverdept);   /* 将台账责任部门设置为接收人部门 */
            assetsFurnitureAccountDTO.setUserId(receiver);          /* 将台账使用人设置为接收人 */
            assetsFurnitureAccountDTO.setUserDept(receiverdept);    /* 将台账使用人部门设置为接收人部门 */
            assetsFurnitureAccountDTO.setPositionId(receivePositionId);

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功数量 */
            int count = furnitureAccountService.updateAssetsFurnitureAccountSensitive(assetsFurnitureAccountDTO);
            if(1==count){
                updateNum++;
            }

        }
    }
}
