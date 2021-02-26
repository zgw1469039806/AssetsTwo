package avicit.assets.device.assetsdevicemetering.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;

import java.util.Calendar;
import java.util.Date;

public class UpdateAccount implements EventListener {

    public Date calcNextMeteringDate(Date meteringFinishTime, Long meteringCycle){
        if(meteringCycle != null && meteringFinishTime != null){
            Calendar cal = Calendar.getInstance();
            cal.setTime(meteringFinishTime);
            cal.add(Calendar.DATE, meteringCycle.intValue());
            return cal.getTime();
        }
        return null;
    }

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        String id = eventListenerExecution.getVariable("id").toString();

        AssetsDeviceMeteringService meteringService = SpringFactory.getBean(AssetsDeviceMeteringService.class);
        AssetsDeviceMeteringDTO assetsDeviceMeteringDTO = meteringService.queryAssetsDeviceMeteringByPrimaryKey(id);
        String unifiedId = assetsDeviceMeteringDTO.getUnifiedId();

        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(unifiedId);

        String meteringConclude = assetsDeviceMeteringDTO.getMeterConclusion(); //计量结论
        Date meteringFinishDate = assetsDeviceMeteringDTO.getMeterFinishDate(); // 计量完成日期
        Long meteringCycle = assetsDeviceMeteringDTO.getMeterCycle(); //计量周期
        Date meteringNextDate = calcNextMeteringDate(meteringFinishDate, meteringCycle); //下次计量日期

        assetsDeviceAccountDTO.setNextMeteringDate(meteringNextDate);
        assetsDeviceAccountDTO.setMeteringConclution(meteringConclude);
        assetsDeviceAccountDTO.setLastMeteringDate(meteringFinishDate);

        String createdBy = assetsDeviceMeteringDTO.getCreatedBy();
        //获取流程的formId
        String formId=eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId=eventListenerExecution.getProcessDefinitionId();
        int updateNum = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO, createdBy, formId,"设备计量", flowId);

    }
}
