package avicit.assets.device.assetsustdtempapplyproc.condition;

import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.assets.device.assetsustdtempapplyproc.dto.AssetsUstdtempapplyProcDTO;
import avicit.assets.device.assetsustdtempapplyproc.service.AssetsUstdtempapplyProcService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.spring.SpringFactory;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class DeriveAcceptance implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        //获取非标验收的service
        AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService = SpringFactory.getBean("assetsUstdtempAcceptanceService");

        //获取非标申购的service
        AssetsUstdtempapplyProcService assetsUstdtempapplyProcService = SpringFactory.getBean("assetsUstdtempapplyProcService");

        //获取申购单号
        String subscribeNo = eventListenerExecution.getVariable("subscribeNo").toString();
        AssetsUstdtempapplyProcDTO applyDto = assetsUstdtempapplyProcService.getAssetsUstdtempapplyProcBySubscribeNo(subscribeNo);

        AssetsUstdtempAcceptanceDTO acceptanceDTO = new AssetsUstdtempAcceptanceDTO();
        acceptanceDTO.setCreatedBy(applyDto.getCreatedBy());    //创建人
        acceptanceDTO.setCreatedByDept(applyDto.getCreatedByDept());    //创建部门
        acceptanceDTO.setCreationDate(new Date());  //创建时间

//        acceptanceDTO.setApplyBy(applyDto.getApplyBy());    //申请人
//        acceptanceDTO.setApplyByDept(applyDto.getApplyByDept());    //申请人部门

        acceptanceDTO.setLastUpdatedBy(applyDto.getCreatedBy());    //最后更新人
        acceptanceDTO.setLastUpdateDate(new Date());    //最后更新时间
        acceptanceDTO.setLastUpdateIp(applyDto.getLastUpdateIp());  //最后更新IP
        acceptanceDTO.setVersion(0L);   //版本

        acceptanceDTO.setSubscribeNo(subscribeNo);  //申购单号
        acceptanceDTO.setDeviceName(applyDto.getDeviceName());  //设备名称
        acceptanceDTO.setDeviceCategory(applyDto.getDeviceCategory());  //设备类别
        //acceptanceDTO.setManufacturerId(applyDto.getManufactureUnit()); //生产厂家——承制单位
        acceptanceDTO.setIfMeasure(applyDto.getIsMetering());   //是否计量

        acceptanceDTO.setIfInstall(applyDto.getIsNeedInstall());    //是否安装
        acceptanceDTO.setPositionId(applyDto.getPositionId());  //安装地点
        acceptanceDTO.setFinancialResources(applyDto.getFinancialResources());  //经费来源
        acceptanceDTO.setBelongProject(applyDto.getBelongProject());    //所属项目

        acceptanceDTO.setProjectNo(applyDto.getProjectNo());    //项目序号
        acceptanceDTO.setReplyName(applyDto.getReplyName());    //批复名称
        acceptanceDTO.setProjectApprovalNo(applyDto.getApprovalFormNumber());   //立项单号
        acceptanceDTO.setSetsCount(1L); //台套数默认1

        assetsUstdtempAcceptanceService.insertAssetsUstdtempAcceptance(acceptanceDTO);

        BpmOperateService bpmOperateService = SpringFactory.getBean(BpmOperateService.class);
        //web表单传递过来(除表单对象外)的变量，可以为空
        Map<String, Object> variables = new HashMap<String, Object>();

        //把表单对象转换成map,传递给流程变量
        Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(acceptanceDTO);
        variables.putAll(pojoMap);

        bpmOperateService.startProcessInstanceById("402880127330fcf70173310c8dd40156-1", "assetsUstdtempAcceptance", applyDto.getCreatedBy(), applyDto.getCreatedByDept(), variables);
    }
}
