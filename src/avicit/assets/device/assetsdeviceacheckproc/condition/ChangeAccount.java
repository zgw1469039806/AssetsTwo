package avicit.assets.device.assetsdeviceacheckproc.condition;

import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.assets.device.assetsdeviceacccheck.service.AssetsDeviceAccCheckService;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;
import avicit.assets.device.assetsdeviceacheckproc.service.AssetsDeviceAcheckPlanService;
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
public class ChangeAccount  implements EventListener {

    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceAcheckPlanService.class);

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();
        /* 需要调用assetsDeviceAcheckPlanService里面的方法，必须建立SpringFactory */
        AssetsDeviceAcheckPlanService assetsDeviceAcheckPlanService = SpringFactory.getBean("assetsDeviceAcheckPlanService");
        /*按计划id获取子表精度检查时间最大的书记列表*/
        List<AssetsDeviceAcheckPlanDTO> planList = assetsDeviceAcheckPlanService.searchAssetsDeviceAcheckPlanMax(id);

        for (AssetsDeviceAcheckPlanDTO item : planList) {
            Calendar cal = Calendar.getInstance();
            /* 需要调用assetsDeviceAccCheckService里面的方法，必须建立SpringFactory */
            AssetsDeviceAccCheckService assetsDeviceAccCheckService = SpringFactory.getBean("assetsDeviceAccCheckService");
            /*根据ID查询台账精度检查信息*/
            AssetsDeviceAccCheckDTO accCheck =	assetsDeviceAccCheckService.findById(item.getCheckId());
            /*赋值上次精度检查时间*/
            accCheck.setLastAccCheckDate(item.getAccCheckDate());
            /*计算下次精度检查时间*/
            cal.setTime(item.getAccCheckDate());
            cal.add(Calendar.DAY_OF_MONTH, item.getAccCheckCycle().intValue());
            /*赋值下次精度检查时间*/
            accCheck.setNextAccCheckDate(cal.getTime());
            /*修改台账信息*/
            assetsDeviceAccCheckService.updateAssetsDeviceAccCheckAll(accCheck);
        }


    }
}
