package avicit.assets.furniture.assetsfurniturerepairproc.condition;

import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;
import avicit.assets.furniture.assetsfurnitureaccount.service.AssetsFurnitureAccountService;
import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairSubDTO;
import avicit.assets.furniture.assetsfurniturerepairproc.service.AssetsFurnitureRepairProcService;
import avicit.assets.furniture.assetsfurniturerepairproc.service.AssetsFurnitureRepairSubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class UpdateFurnitureAccount  implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();

        /* 获取节点的名称，赋值给activityName*/
        String activityName = eventListenerExecution.getActivityName();

        /* 建立家具台账的SpringFactory */
        AssetsFurnitureAccountService furnitureAccountService = SpringFactory.getBean("assetsFurnitureAccountService");
        /* 建立家具维修主表的SpringFactory */
        AssetsFurnitureRepairProcService furnitureRepairProcService = SpringFactory.getBean("assetsFurnitureRepairProcService");
        /* 建立家具维修子表的SpringFactory */
        AssetsFurnitureRepairSubService furnitureRepairSubService = SpringFactory.getBean("assetsFurnitureRepairSubService");

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，子表furnitureRecoverySubDTOS */
        List<AssetsFurnitureRepairSubDTO> furnitureRepairSubDTOS = furnitureRepairSubService.queryAssetsFurnitureRepairSubByPid(id);

        int updateNum = 0;  /* 统计成功更新的数量 */
        for(AssetsFurnitureRepairSubDTO furnitureRepairSubDTO:furnitureRepairSubDTOS){
            String unifiedId = furnitureRepairSubDTO.getUnifiedId();
            /* 通过unifiedId在家具台账中查询unifiedId对应的一条DTO数据 */
            AssetsFurnitureAccountDTO assetsFurnitureAccountDTO = furnitureAccountService.queryAssetsFurnitureAccountByUnifiedId(unifiedId);

            if ("task2".equals(activityName)){
                assetsFurnitureAccountDTO.setFurnitureState("3");   /* 将家具的状态设置为 维修中 */
            }else if ("end1".equals(activityName)) {
                assetsFurnitureAccountDTO.setFurnitureState("1");   /* 将家具的状态设置为 在用 */
            }else {
                System.out.println("后置事件节点状态异常");
            }

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功数量 */
            int count = furnitureAccountService.updateAssetsFurnitureAccountSensitive(assetsFurnitureAccountDTO);
            /* 如果count值为1则表示更改台账成功，统计成功更改数量updateNum+1 */
            if(1==count){
                updateNum++;
            }
        }
    }
}
