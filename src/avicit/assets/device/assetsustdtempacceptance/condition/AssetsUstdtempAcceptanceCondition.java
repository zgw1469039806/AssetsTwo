package avicit.assets.device.assetsustdtempacceptance.condition;

import java.util.Map;

import org.slf4j.Logger;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class AssetsUstdtempAcceptanceCondition implements EventListener {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static Logger log;

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
    	AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService = SpringFactory.getBean("assetsUstdtempAcceptanceService");
        String avicit_bpm_formCode = eventListenerExecution.getVariable("avicit_bpm_formCode").toString();
        AssetsDeviceAccountService assetsDeviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = new AssetsDeviceAccountDTO();
        String id = eventListenerExecution.getVariable("id").toString();
        SysAutoCodeAPI sysAutoCodeAPI = SpringFactory.getBean("sysAutoCodeAPI");
        String activityName = eventListenerExecution.getActivityName();
        AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO = assetsUstdtempAcceptanceService.queryAssetsUstdtempAcceptanceByPrimaryKey(id);
        if ("assetsUstdtempAcceptance".equals(avicit_bpm_formCode) && "task24".equals(activityName)) {
        	//生成统一编号
        	Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "ASSETS_USTDTEMP_ACCEPTANCE", assetsUstdtempAcceptanceDTO.getAttribute05(), assetsUstdtempAcceptanceDTO.getId(), false);
            if(map.get("result").equals("success")){
            	assetsUstdtempAcceptanceDTO.setUnifiedId(map.get("autoCodeValue"));
            	assetsUstdtempAcceptanceDTO.setAttribute05("/");
            }
            assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptanceSensitive(assetsUstdtempAcceptanceDTO);
        }
        if ("assetsUstdtempAcceptance".equals(avicit_bpm_formCode) && "end2".equals(activityName)) {
        	//验收完成设备信息入台账表
        	Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "ASSETS_DEVICE_ACCOUNT", assetsUstdtempAcceptanceDTO.getAttribute10(), assetsUstdtempAcceptanceDTO.getId(), false);
            if(map.get("result").equals("success")){
            	//资产编号
            	assetsDeviceAccountDTO.setAssetId(map.get("autoCodeValue"));
            	assetsUstdtempAcceptanceDTO.setAttribute10("/");
            	assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptanceSensitive(assetsUstdtempAcceptanceDTO);
            }
        	assetsDeviceAccountDTO.setUnifiedId(assetsUstdtempAcceptanceDTO.getUnifiedId());					//统一编号
        	assetsDeviceAccountDTO.setDeviceCategory(assetsUstdtempAcceptanceDTO.getDeviceCategory());			//设备类别
        	assetsDeviceAccountDTO.setDeviceName(assetsUstdtempAcceptanceDTO.getDeviceName());					//设备名称
//        	assetsDeviceAccountDTO.setOwnerId(assetsUstdtempAcceptanceDTO.getChargePerson());					//责任人
//        	assetsDeviceAccountDTO.setOwnerDept(assetsUstdtempAcceptanceDTO.getChargeDept());					//责任人部门
//        	assetsDeviceAccountDTO.setManufacturerId(assetsUstdtempAcceptanceDTO.getManufacturerId());			//生产厂家
//        	assetsDeviceAccountDTO.setAbcCategory(assetsUstdtempAcceptanceDTO.getAbcCategory());				//ABC分类
//        	assetsDeviceAccountDTO.setContractNum(assetsUstdtempAcceptanceDTO.getContractNum());				//合同号
//        	assetsDeviceAccountDTO.setApplyNum(assetsUstdtempAcceptanceDTO.getStdId());							//申购单号
//        	assetsDeviceAccountDTO.setCheckNum(assetsUstdtempAcceptanceDTO.getAcceptanceId());					//验收单号
//        	assetsDeviceAccountDTO.setSecretLevel(assetsUstdtempAcceptanceDTO.getSecretLevel());				//密级
//        	assetsDeviceAccountDTO.setIsMetering(assetsUstdtempAcceptanceDTO.getIsMetering());					//是否计量
//        	assetsDeviceAccountDTO.setIsMaintain(assetsUstdtempAcceptanceDTO.getIsMaintain());					//是否保养
//        	assetsDeviceAccountDTO.setIsAccuracyCheck(assetsUstdtempAcceptanceDTO.getIsAccuracyCheck());		//是否精度检查
//        	assetsDeviceAccountDTO.setIsRegularCheck(assetsUstdtempAcceptanceDTO.getIsRegularCheck());			//是否定检
//        	assetsDeviceAccountDTO.setIsSpotCheck(assetsUstdtempAcceptanceDTO.getIsSpotCheck());				//是否点检
//        	assetsDeviceAccountDTO.setIsSafetyProduction(assetsUstdtempAcceptanceDTO.getIsSafetyProduction());	//是否涉及安全生产
//        	assetsDeviceAccountDTO.setIsNeedInstall(assetsUstdtempAcceptanceDTO.getIsNeedInstall());			//是否安装
        	
        	assetsDeviceAccountService.insertAssetsDeviceAccount(assetsDeviceAccountDTO);
        }
    }
}
