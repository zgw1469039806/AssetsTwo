package avicit.assets.furniture.assetsfurniturescrapproc.condition;

import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;
import avicit.assets.furniture.assetsfurnitureaccount.service.AssetsFurnitureAccountService;
import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapSubDTO;
import avicit.assets.furniture.assetsfurniturescrapproc.service.AssetsFurnitureScrapProcService;
import avicit.assets.furniture.assetsfurniturescrapproc.service.AssetsFurnitureScrapSubService;
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
        /* 建立家具报废主表的SpringFactory */
        AssetsFurnitureScrapProcService furnitureScrapProcService = SpringFactory.getBean("assetsFurnitureScrapProcService");
        /* 建立家具报废子表的SpringFactory */
        AssetsFurnitureScrapSubService furnitureScrapSubService = SpringFactory.getBean("assetsFurnitureScrapSubService");

        /* 通过父表ID在子表中查询父表ID相关联的数据集合，子表furnitureRecoverySubDTOS */
        List<AssetsFurnitureScrapSubDTO> furnitureScrapSubDTOS = furnitureScrapSubService.queryAssetsFurnitureScrapSubByPid(id);

        int updateNum = 0;
        /* 循环修改台账 */
        for(AssetsFurnitureScrapSubDTO furnitureScrapSubDTO:furnitureScrapSubDTOS){
            String unifiedId = furnitureScrapSubDTO.getUnifiedId();  /* 获取子表记录中一条数据的unifiedId */
            /* 通过unifiedId在家具台账中查询unifiedId对应的一条DTO数据 */
            AssetsFurnitureAccountDTO assetsFurnitureAccountDTO = furnitureAccountService.queryAssetsFurnitureAccountByUnifiedId(unifiedId);
            assetsFurnitureAccountDTO.setFurnitureState("4");       /* 将台账家具状态设置为 报废 */
            assetsFurnitureAccountDTO.setPositionId("");            /* 将台账安装位置设置为空 */

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功数量 */
            int count = furnitureAccountService.updateAssetsFurnitureAccountSensitive(assetsFurnitureAccountDTO);
            if(1==count){
                updateNum++;
            }
        }
    }
}
