package avicit.assets.device.assetsdevicerepair.conditon;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.assets.device.assetsdevicerepair.dto.AssetsDeviceRepairDTO;
import avicit.assets.device.assetsdevicerepair.service.AssetsDeviceRepairService;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.spring.SpringFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class DeriveMeteringWorkflow implements EventListener {

    SysUserAPI sysUserLoader = (SysUserAPI)SpringFactory.getBean(SysUserAPI.class);
    SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI)SpringFactory.getBean(SysUserDeptPositionAPI.class);
    SysDeptAPI sysDeptLoader = (SysDeptAPI)SpringFactory.getBean(SysDeptAPI.class);
    BpmOperateService bpmOperateService = SpringFactory.getBean(BpmOperateService.class);

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        AssetsDeviceRepairService repairService = SpringFactory.getBean("assetsDeviceRepairService");
        AssetsDeviceMeteringService meteringService = SpringFactory.getBean("assetsDeviceMeteringService");
        AssetsDeviceAccountService accountService = SpringFactory.getBean("assetsDeviceAccountService");

        String id = eventListenerExecution.getVariable("id").toString();
        String isFork = eventListenerExecution.getVariable("IS_FORK_SUBPROCESS").toString(); // 是否派生计量
        String meteringPlanPersonId = eventListenerExecution.getVariable("METER_PLAN_STAFF").toString(); // 计量计划员

        if("Y".equals(isFork)){
            AssetsDeviceRepairDTO repairDTO =  repairService.queryAssetsDeviceRepairByPrimaryKey(id);
            String unifiedId = repairDTO.getUnifiedId(); // 资产统一编号
            AssetsDeviceAccountDTO accountDTO = accountService.queryAssetsDeviceAccountByUnifiedId(unifiedId);

            Map<String, Object> variables = new HashMap<String, Object>();
            String processDefId = "4028808e745cd8f601745d0aace80dba-1"; // 计量流程模板ID
            String formCode = "deviceMetering1"; //计量流程FORMCODE
            String userId = meteringPlanPersonId;
            String deptId = sysUserDeptPositionLoader.getChiefDeptIdBySysUserId(meteringPlanPersonId).toString();

            SysDept sysDept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(userId);

            AssetsDeviceMeteringDTO bean = new AssetsDeviceMeteringDTO();
            bean.setUnifiedId(unifiedId);  // 资产编号
            bean.setDeviceName(accountDTO.getDeviceName()); //资产名称
            bean.setDeviceCategory(accountDTO.getDeviceCategory()); //资产类别
            bean.setDeviceModel(accountDTO.getDeviceModel()); //资产型号
            bean.setDeviceSpec(accountDTO.getDeviceSpec()); //资产规格
            bean.setPositionId(accountDTO.getPositionId()); // 安装地点
            bean.setSecretLevel(accountDTO.getSecretLevel()); // 密集
            bean.setManufacturer(accountDTO.getMeteringDept()); // 生产厂家
            bean.setMeterMode(accountDTO.getIsSceneMetering()); // 计量方式
            bean.setMeterPlanPerson(accountDTO.getPlanMeterman()); // 计量计划员
            bean.setMeterPlanPersonAlias(accountDTO.getPlanMetermanAlias());
            bean.setMeterPersonAlias(accountDTO.getMetermanAlias());
            bean.setMeterPerson(accountDTO.getMeterman()); // 计量员
            bean.setLastMeteringDate(accountDTO.getLastMeteringDate());
            bean.setMeterCycle(accountDTO.getMeteringCycle());
            bean.setIsMetering(accountDTO.getIsMetering());
            bean.setOwnerId(accountDTO.getOwnerId());
            bean.setOwnerIdAlias(accountDTO.getOwnerIdAlias());
            bean.setOwnerDept(accountDTO.getOwnerDept());
            bean.setOwnerDeptAlias(accountDTO.getOwnerDeptAlias());

            bean.setApplicantId(userId);
            bean.setApplicantIdAlias(sysUserLoader.getSysUserNameById(userId));
            bean.setApplicantDepart(sysDept.getId());
            bean.setApplicantDepartAlias(sysDept.getDeptName());

            bean.setCreatedBy(userId);
            bean.setCreationDate(new Date());
            bean.setLastUpdateDate(new Date());
            bean.setLastUpdatedBy(userId);
            bean.setLastUpdateIp("127.0.0.1");
            bean.setVersion(Long.valueOf(0));

            bean.setIsDeliveryAllowed("N");
            bean.setMeterConclusion("4");
            bean.setIsDeriveOftName("N");
            bean.setFormCheckConclude("N");
            bean.setManagerConclude("N");

            meteringService.insertAssetsDeviceMetering(bean);

            //把表单对象转换成map,传递给流程变量
            Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
            variables.putAll(pojoMap);
            String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId, variables);
        }

    }
}
