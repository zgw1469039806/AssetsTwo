package avicit.assets.device.assetsstdtempacceptance.condition;

import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import avicit.assets.device.assetsstdtempacceptance.service.AssetsStdtempAcceptanceService;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsStdtempapplyProcDTO;
import avicit.assets.device.assetsstdtempapplyproc.service.AssetsStdtempapplyProcService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.spring.SpringFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StdtempacceptanceCondition implements EventListener {

    @Override
    public void notify(EventListenerExecution event) throws Exception {
        //注入标准设备申购和验收的的service
        AssetsStdtempapplyProcService assetsStdtempapplyProcService = SpringFactory.getBean("assetsStdtempapplyProcService");
        AssetsStdtempAcceptanceService stdtempAcceptanceService = SpringFactory.getBean("assetsStdtempAcceptanceService");
        BpmOperateService bpmOperateService = SpringFactory.getBean(BpmOperateService.class);
        //获取当前申购单的业务数据
        AssetsStdtempapplyProcDTO stdtempapplyProcDTO = assetsStdtempapplyProcService.queryAssetsStdtempapplyProcByPrimaryKey(event.getVariable("id").toString());
        //获取设备数量，用来循环派生验收流程
        Integer deviceNum =Integer.parseInt(stdtempapplyProcDTO.getDeviceNum().toString()) ;
        AssetsStdtempAcceptanceDTO acceptanceDTO = new AssetsStdtempAcceptanceDTO();
        for(int i=0;i<deviceNum;i++){
            acceptanceDTO.setDeviceName(stdtempapplyProcDTO.getDeviceName());
        acceptanceDTO.setStdId(stdtempapplyProcDTO.getStdId());
        acceptanceDTO.setCreatedByTel(stdtempapplyProcDTO.getCreatedByTel());
        acceptanceDTO.setBuyerDept(stdtempapplyProcDTO.getCreatedByDept());
        acceptanceDTO.setBuyer(stdtempapplyProcDTO.getBuyer());
        acceptanceDTO.setDeviceCategory(stdtempapplyProcDTO.getDeviceCategory());
        acceptanceDTO.setDeviceModel(stdtempapplyProcDTO.getDeviceModel());
        acceptanceDTO.setDeviceSpec(stdtempapplyProcDTO.getDeviceSpec());
        acceptanceDTO.setIsRegularCheck(stdtempapplyProcDTO.getIsRegularCheck());
        acceptanceDTO.setIsSpotCheck(stdtempapplyProcDTO.getIsSpotCheck());
        acceptanceDTO.setIsMeasuring(stdtempapplyProcDTO.getIsMetering());
        acceptanceDTO.setIsSceneMeasuring(stdtempapplyProcDTO.getIsSceneMetering());
        acceptanceDTO.setIsAccuracyCheck(stdtempapplyProcDTO.getIsAccuracyCheck());
        acceptanceDTO.setIsInstall(stdtempapplyProcDTO.getIsNeedInstall());
        acceptanceDTO.setIsMaintain(stdtempapplyProcDTO.getIsMaintain());
        acceptanceDTO.setIsPc(stdtempapplyProcDTO.getIsPc());
        acceptanceDTO.setIsSafetyProduction(stdtempapplyProcDTO.getIsSafetyProduction());
            acceptanceDTO.setChargePerson(stdtempapplyProcDTO.getCreatedByPersion());
        String stdtId = stdtempAcceptanceService.insertAssetsStdtempAcceptance(acceptanceDTO);

        System.err.println(stdtId);
//        acceptanceDTOList.add(acceptanceDTO);
            //把表单对象转换成map,传递给流程变量
            Map<String, Object> variables = new HashMap<String, Object>();
            Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(acceptanceDTO);
            variables.putAll(pojoMap);
            bpmOperateService.startProcessInstanceById("297eb3b07356cbfe01735a7e60bf048e-1", "assetsStdempAcceptance", stdtempapplyProcDTO.getBuyer(), stdtempapplyProcDTO.getCreatedByDept(), variables);
    }
//        stdtempAcceptanceService.insertAssetsStdtempAcceptanceList(acceptanceDTOList);
    }
}
