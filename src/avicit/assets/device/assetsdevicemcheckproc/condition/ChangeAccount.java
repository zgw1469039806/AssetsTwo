package avicit.assets.device.assetsdevicemcheckproc.condition;

import avicit.assets.device.assetsdevicemaintain.dto.AssetsDeviceMaintainDTO;
import avicit.assets.device.assetsdevicemaintain.service.AssetsDeviceMaintainService;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;
import avicit.assets.device.assetsdevicemcheckproc.service.AssetsDeviceMcheckPlanService;
import avicit.assets.device.assetsdevicemchecktemporary.dto.AssetsDeviceMcheckTemporaryDTO;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Calendar;
import java.util.List;
/**
 * 流程结束前修改对应台账的时间信息
 */
public class ChangeAccount implements EventListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceMcheckPlanService.class);

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();
        /* 需要调用assetsDeviceMcheckPlanService里面的方法，必须建立SpringFactory */
        AssetsDeviceMcheckPlanService assetsDeviceMcheckPlanService = SpringFactory.getBean("assetsDeviceMcheckPlanService");
        /*按计划id获取子表定检时间最大的书记列表*/
        List<AssetsDeviceMcheckPlanDTO> planList = assetsDeviceMcheckPlanService.searchAssetsDeviceMcheckPlanMax(id);

        for (AssetsDeviceMcheckPlanDTO item : planList) {
            Calendar cal = Calendar.getInstance();
            /* 需要调用assetsDeviceMaintainService里面的方法，必须建立SpringFactory */
            AssetsDeviceMaintainService assetsDeviceMaintainService = SpringFactory.getBean("assetsDeviceMaintainService");
            /*根据ID查询台账保养信息*/
            AssetsDeviceMaintainDTO maintain = assetsDeviceMaintainService.findById(item.getMaintainId());
            /*赋值上次保养时间*/
            maintain.setLastMaintainDate(item.getMaintainDate());
            /*计算下次保养时间*/
            cal.setTime(item.getMaintainDate());
            cal.add(Calendar.DAY_OF_MONTH, Integer.parseInt(item.getMaintainCycle()));
            /*赋值下次保养时间*/
            maintain.setNextMaintainDate(cal.getTime());
            /*修改台账信息*/
            assetsDeviceMaintainService.updateAssetsDeviceMaintainAll(maintain);
        }

    }
}
