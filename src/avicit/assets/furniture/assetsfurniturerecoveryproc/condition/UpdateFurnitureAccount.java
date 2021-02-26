package avicit.assets.furniture.assetsfurniturerecoveryproc.condition;

import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;
import avicit.assets.furniture.assetsfurnitureaccount.service.AssetsFurnitureAccountService;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoverySubDTO;
import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoveryProcService;
import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoverySubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class UpdateFurnitureAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();

        /* 建立家具台账的SpringFactory */
        AssetsFurnitureAccountService furnitureAccountService = SpringFactory.getBean("assetsFurnitureAccountService");
        /* 建立家具回收主表的SpringFactory */
        AssetsFurnitureRecoveryProcService furnitureRecoveryProcService = SpringFactory.getBean("assetsFurnitureRecoveryProcService");
        /* 建立家具回收子表的SpringFactory */
        AssetsFurnitureRecoverySubService furnitureRecoverySubService = SpringFactory.getBean("assetsFurnitureRecoverySubService");

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，子表furnitureRecoverySubDTOS */
        List<AssetsFurnitureRecoverySubDTO> furnitureRecoverySubDTOS = furnitureRecoverySubService.queryAssetsFurnitureRecoverySubByPid(id);

        int updateNum = 0;
        /* 循环修改台账 */
        for(AssetsFurnitureRecoverySubDTO furnitureRecoverySubDTO:furnitureRecoverySubDTOS){
            String unifiedId = furnitureRecoverySubDTO.getUnifiedId();  /* 获取子表记录中一条数据的unifiedId */
            /* 通过unifiedId在家具台账中查询unifiedId对应的一条DTO数据 */
            AssetsFurnitureAccountDTO assetsFurnitureAccountDTO = furnitureAccountService.queryAssetsFurnitureAccountByUnifiedId(unifiedId);
            assetsFurnitureAccountDTO.setOwnerId("");               /* 将台账责任人设置为 空 */
            assetsFurnitureAccountDTO.setOwnerDept("402880f273ea5beb0173ebab7c7306b4");    /* 将台账责任部门设置为 瑞信公司 */
            assetsFurnitureAccountDTO.setUserId("");                /* 将台账使用人设置为 空 */
            assetsFurnitureAccountDTO.setUserDept("402880f273ea5beb0173ebab7c7306b4");   /* 将台账使用人部门设置为接 瑞信公司 */
            assetsFurnitureAccountDTO.setFurnitureState("2");       /* 将台账家具状态设置为 闲置 */
            assetsFurnitureAccountDTO.setPositionId("");            /* 将台账安装位置设置为空 */

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功数量 */
            int count = furnitureAccountService.updateAssetsFurnitureAccountSensitive(assetsFurnitureAccountDTO);
            if(1==count){
                updateNum++;
            }

        }

    }
}
