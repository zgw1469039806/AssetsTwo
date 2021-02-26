package avicit.assets.device.assetstdeviceupgradesub.condition;

import avicit.assets.device.assetstdevicesoftware.dto.AssetsTdeviceSoftwareDTO;
import avicit.assets.device.assetstdevicesoftware.service.AssetsTdeviceSoftwareService;
import avicit.assets.device.assetstdeviceupgradesub.dto.AssetsTdeviceUpgradeSubDTO;
import avicit.assets.device.assetstdeviceupgradesub.service.AssetsTdeviceUpgradeSubService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.List;

public class UpgradeChangeAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        /* 获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();

        /* 创建软件台账的service */
        AssetsTdeviceSoftwareService tdeviceSoftwareService = SpringFactory.getBean("assetsTdeviceSoftwareService");

        /* 创建软件升级子表的serivce */
        AssetsTdeviceUpgradeSubService tdeviceUpgradeSubService = SpringFactory.getBean("assetsTdeviceUpgradeSubService");
        /* 通过主表的ID查询子表的DTO集合 */
        List<AssetsTdeviceUpgradeSubDTO> tdeviceUpgradeSubDTOS = tdeviceUpgradeSubService.queryAssetsTdeviceUpgradeSubByForeignKey(id);

        int updateNum = 0;
        for(AssetsTdeviceUpgradeSubDTO tdeviceUpgradeSubDTO:tdeviceUpgradeSubDTOS){
            /* 获取子表的软件唯一ID，并通过软件唯一ID查询软件台账对应的DTO */
            AssetsTdeviceSoftwareDTO tdeviceSoftwareDTO = tdeviceSoftwareService.findById(tdeviceUpgradeSubDTO.getTdeviceSoftwareId());

            /* 将设备升级子表的字段写入测试设备软件台账对应的字段 */
            tdeviceSoftwareDTO.setSoftwareName(tdeviceUpgradeSubDTO.getSoftwareName());                 /* 软件名称 */
            tdeviceSoftwareDTO.setSoftwareBasicName(tdeviceUpgradeSubDTO.getSoftwareBasicName());       /* 软件简称 */
            tdeviceSoftwareDTO.setSoftwareId(tdeviceUpgradeSubDTO.getSoftwareId());                     /* CSCI标识 */
            tdeviceSoftwareDTO.setSoftwareCode(tdeviceUpgradeSubDTO.getSoftwareCode());                 /* 软件代号 */
            tdeviceSoftwareDTO.setSoftwareVersion(tdeviceUpgradeSubDTO.getSoftwareVersionNew());        /* 软件版本 */
            tdeviceSoftwareDTO.setSoftwareReleaseNum(tdeviceUpgradeSubDTO.getSoftwareReleaseNum());     /* 软件发布号 */
            tdeviceSoftwareDTO.setSoftwarePeriod(tdeviceUpgradeSubDTO.getSoftwarePeriod());             /* 研制阶段 */
            tdeviceSoftwareDTO.setSoftwareCodeSize(tdeviceUpgradeSubDTO.getSoftwareCodeSize());         /* 代码规模 */
            tdeviceSoftwareDTO.setSoftwareLeader(tdeviceUpgradeSubDTO.getSoftwareLeader());             /* 软件负责人 */
            tdeviceSoftwareDTO.setSoftwareLanguage(tdeviceUpgradeSubDTO.getSoftwareLanguage());         /* 编码语言 */
            tdeviceSoftwareDTO.setSoftwareRunEnvironment(tdeviceUpgradeSubDTO.getSoftwareRunEnvironment()); /* 运行环境 */
            tdeviceSoftwareDTO.setSoftwareDevEnvironment(tdeviceUpgradeSubDTO.getSoftwareDevEnvironment()); /* 开发环境 */
            tdeviceSoftwareDTO.setRemarks(tdeviceUpgradeSubDTO.getRemarks());                           /* 备注 */

            /* 调用修改软件台账的函数，将修改后的DTO传给软件台账的修改方法，成功后返回修改成功数量 */
            int count = tdeviceSoftwareService.updateAssetsTdeviceSoftware(tdeviceSoftwareDTO);
            /* 如果count值为1则表示更改台账成功，统计成功更改数量updateNum+1 */
            if(1==count){
                updateNum++;
            }
        }

    }
}
