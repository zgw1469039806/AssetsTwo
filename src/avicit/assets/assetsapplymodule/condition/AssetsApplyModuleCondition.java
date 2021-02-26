package avicit.assets.assetsapplymodule.condition;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.assets.assetsapplymodule.service.AssetsApplyModuleService;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.Muti3Bean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;

import javax.ws.rs.core.GenericType;

public class AssetsApplyModuleCondition implements EventListener {
    private static Logger log;

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        AssetsApplyModuleService applyModuleService = SpringFactory.getBean("assetsApplyModuleService");
        AssetsApplyModuleDTO applyModuleDTO = new AssetsApplyModuleDTO();
        String avicit_bpm_formCode = eventListenerExecution.getVariable("avicit_bpm_formCode").toString();
        System.out.println(eventListenerExecution.toString());
        Muti3Bean<AssetsApplyModuleDTO, Void, Void> parameterbean = new Muti3Bean();
        String a = eventListenerExecution.getId();
        int i = a.indexOf(".");
        String dbId = a.substring(i + 1, a.length());
        if (avicit_bpm_formCode == "assetsStdtempapplyProc" || avicit_bpm_formCode.equals("assetsStdtempapplyProc")) {
            applyModuleDTO.setApplyType("标准设备临时申购单");
            applyModuleDTO.setApplyId(dbId);
            applyModuleDTO.setApplyDeviceName(eventListenerExecution.getVariable("deviceName").toString());
            applyModuleDTO.setApplyNum(Long.valueOf(eventListenerExecution.getVariable("deviceNum").toString()));
            applyModuleDTO.setApplyPrice(java.math.BigDecimal.valueOf(Double.valueOf(eventListenerExecution.getVariable("unitPrice").toString())));
            applyModuleDTO.setApplySpec(eventListenerExecution.getVariable("deviceSpec").toString());
            applyModuleDTO.setApplyModel(eventListenerExecution.getVariable("deviceModel").toString());
            applyModuleDTO.setApplyManufacturer("613研究所");
            int ret = applyModuleService.insertAssetsApplyModule(applyModuleDTO);
            System.err.println(ret);

        }else if (avicit_bpm_formCode == "assetsUstdtempapplyProc") {
            applyModuleDTO.setApplyType("非标准设备临时申购单");
            applyModuleDTO.setApplyId(dbId);
            applyModuleDTO.setApplyDeviceName(eventListenerExecution.getVariable("deviceName").toString());
            applyModuleDTO.setApplyNum(Long.valueOf(1));
            applyModuleDTO.setApplyPrice(java.math.BigDecimal.valueOf(Double.valueOf(eventListenerExecution.getVariable("unitPrice").toString())));
            applyModuleDTO.setApplySpec(eventListenerExecution.getVariable("financialEstimate").toString());
//            applyModuleDTO.setApplyModel(eventListenerExecution.getVariable("deviceModel").toString());
            applyModuleDTO.setApplyManufacturer("manufactureUnit");
            int ret = applyModuleService.insertAssetsApplyModule(applyModuleDTO);
            System.err.println(ret);
        }

    }
}
