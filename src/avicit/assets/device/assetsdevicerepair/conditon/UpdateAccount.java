package avicit.assets.device.assetsdevicerepair.conditon;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicerepair.service.AssetsDeviceRepairService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

public class UpdateAccount implements EventListener {

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        String unified_id = eventListenerExecution.getVariable("UNIFIED_ID").toString();
        String isRepairable = eventListenerExecution.getVariable("IS_REPAIRABLE").toString();
        AssetsDeviceRepairService repairService = SpringFactory.getBean("assetsDeviceRepairService");
        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(unified_id);

        String activityName = eventListenerExecution.getActivityName();

        if(activityName.equals("task1")){
            assetsDeviceAccountDTO.setDeviceState("0"); // set to 在用
        }else if(activityName.equals("task2")){
            assetsDeviceAccountDTO.setDeviceState("7"); // set to 维修中
        }else if(activityName.equals("end1") && isRepairable.equals("Y")){
            assetsDeviceAccountDTO.setDeviceState("0"); // set to 在用
        }else if(activityName.equals("end1") && isRepairable.equals("N")){
            assetsDeviceAccountDTO.setDeviceState("7"); // set to 维修中
        }

        String createdBy = eventListenerExecution.getVariable("APPLICANT_ID").toString();
        //获取流程的formId
        String formId=eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId=eventListenerExecution.getProcessDefinitionId();
        int updateNum = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO, createdBy, formId,"设备维修", flowId);
    }
}
