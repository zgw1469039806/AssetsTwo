package avicit.assets.device.assetsustdtempacceptance.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.assets.device.classifydata.dto.ClassifyDataDTO;
import avicit.assets.device.classifydata.service.ClassifyDataService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class DeriveAccount implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        //获取非标验收的service
        AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService = SpringFactory.getBean("assetsUstdtempAcceptanceService");

        //获取台账的service
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        //获取分类的service
        ClassifyDataService classifyDataService = SpringFactory.getBean("classifyDataService");

        //获取验收单号
        String acceptanceNo = eventListenerExecution.getVariable("acceptanceNo").toString();
        AssetsUstdtempAcceptanceDTO acceptanceDTO = assetsUstdtempAcceptanceService.getAssetsUstdtempAcceptanceByAcceptanceNo(acceptanceNo);

        //创建台账数据
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = new AssetsDeviceAccountDTO();

        assetsDeviceAccountDTO.setUnifiedId(acceptanceDTO.getUnifiedId());					//统一编号
        assetsDeviceAccountDTO.setDeviceCategory(acceptanceDTO.getDeviceCategory());			//设备类别
        assetsDeviceAccountDTO.setDeviceName(acceptanceDTO.getDeviceName());					//设备名称
        assetsDeviceAccountDTO.setOwnerId(acceptanceDTO.getOwnerId());					//责任人
        assetsDeviceAccountDTO.setOwnerDept(acceptanceDTO.getOwnerDept());					//责任人部门
        assetsDeviceAccountDTO.setManufacturerId(acceptanceDTO.getManufacturerId());			//生产厂家
        assetsDeviceAccountDTO.setAbcCategory(acceptanceDTO.getAbcCategory());				//ABC分类
        assetsDeviceAccountDTO.setContractNum(acceptanceDTO.getContractNum());				//合同号
        assetsDeviceAccountDTO.setApplyNum(acceptanceDTO.getSubscribeNo());							//申购单号
        assetsDeviceAccountDTO.setCheckNum(acceptanceDTO.getAcceptanceNo());					//验收单号
        assetsDeviceAccountDTO.setSecretLevel(acceptanceDTO.getSecretLevel());				//密级
        assetsDeviceAccountDTO.setIsMetering(acceptanceDTO.getIfMeasure());					//是否计量
        assetsDeviceAccountDTO.setIsMaintain(acceptanceDTO.getIfUpkeep());					//是否保养
        assetsDeviceAccountDTO.setIsAccuracyCheck(acceptanceDTO.getIfPrecisionInspection());		//是否精度检查
        assetsDeviceAccountDTO.setIsRegularCheck(acceptanceDTO.getIfRegularCheck());			//是否定检
        assetsDeviceAccountDTO.setIsSpotCheck(acceptanceDTO.getIfSpotCheck());				//是否点检
        assetsDeviceAccountDTO.setIsSafetyProduction(acceptanceDTO.getIsSafetyProduction());	//是否涉及安全生产
        assetsDeviceAccountDTO.setIsNeedInstall(acceptanceDTO.getIfInstall());			//是否安装

        //计算流水号
        ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(acceptanceDTO.getDeviceCategory());
        String classifyCode = classifyDataDTO.getCode();

        String unifiedId = acceptanceDTO.getUnifiedId();
        unifiedId = unifiedId.replace(classifyCode, "");
        Long serialNumber = Long.parseLong(unifiedId);
        assetsDeviceAccountDTO.setAttribute19(serialNumber);

        assetsDeviceAccountService.insertAssetsDeviceAccount(assetsDeviceAccountDTO);
    }
}
