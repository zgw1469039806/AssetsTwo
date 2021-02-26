package avicit.assets.device.assetstrackback.condition;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.assets.device.assetstrackback.dto.AssetsTrackbackDTO;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.spring.SpringFactory;
import avicit.assets.device.assetstrackback.service.AssetsTrackbackService;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class DeriveTrackBackWorkflow implements EventListener {

    SysUserAPI sysUserLoader = (SysUserAPI)SpringFactory.getBean(SysUserAPI.class);
    SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI)SpringFactory.getBean(SysUserDeptPositionAPI.class);
    SysDeptAPI sysDeptLoader = (SysDeptAPI)SpringFactory.getBean(SysDeptAPI.class);
    BpmOperateService bpmOperateService = SpringFactory.getBean(BpmOperateService.class);

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {

        AssetsDeviceMeteringService meteringService = SpringFactory.getBean("assetsDeviceMeteringService");
        AssetsDeviceAccountService accountService = SpringFactory.getBean("assetsDeviceAccountService");
        AssetsTrackbackService trackbackService = SpringFactory.getBean("assetsTrackbackService");

        String id = eventListenerExecution.getVariable("id").toString();
        AssetsDeviceMeteringDTO deviceMeteringDTO = meteringService.queryAssetsDeviceMeteringByPrimaryKey(id);
        String isFork = deviceMeteringDTO.getIsDeriveOft();
        String meteringPersonId = deviceMeteringDTO.getMeterPerson();

        if("Y".equals(isFork)){

            String unifiedId = deviceMeteringDTO.getUnifiedId(); // 资产统一编号

            AssetsDeviceAccountDTO accountDTO = accountService.queryAssetsDeviceAccountByUnifiedId(unifiedId);

            Map<String, Object> variables = new HashMap<String, Object>();
            String processDefId = "4028808e746c471301746c535a171066-1"; // 超差追溯流程模板ID
            String formCode = "assetsTrackback"; //计量流程FORMCODE
            String userId = meteringPersonId;
            String deptId = sysUserDeptPositionLoader.getChiefDeptIdBySysUserId(meteringPersonId).toString();
            SysDept sysDept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(userId);

            AssetsTrackbackDTO bean = new AssetsTrackbackDTO();

            bean.setUnifiedId(unifiedId);  // 资产编号
            bean.setDeviceName(accountDTO.getDeviceName()); //资产名称
            bean.setDeviceCategory(accountDTO.getDeviceCategory()); //资产类别
            bean.setDeviceModel(accountDTO.getDeviceModel()); //资产型号
            bean.setDeviceSpec(accountDTO.getDeviceSpec()); //资产规格
            bean.setMeterPersonAlias(accountDTO.getMetermanAlias());
            bean.setMeterPerson(accountDTO.getMeterman()); // 计量员
            bean.setLastMeteringDate(accountDTO.getLastMeteringDate()); // 上次计量时间
            bean.setMeteringId(deviceMeteringDTO.getProcId()); // 关联计量单号

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

            bean.setMeterConclusion(deviceMeteringDTO.getMeterConclusion());

            trackbackService.insertAssetsTrackback(bean);

            //把表单对象转换成map,传递给流程变量
            Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
            variables.putAll(pojoMap);
            String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId, variables);
        }

    }
}
