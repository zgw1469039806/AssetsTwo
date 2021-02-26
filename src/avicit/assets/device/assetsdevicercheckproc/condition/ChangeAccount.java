package avicit.assets.device.assetsdevicercheckproc.condition;

import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;
import avicit.assets.device.assetsdevicercheckproc.service.AssetsDeviceRcheckPlanService;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
import avicit.assets.device.assetsdeviceregularcheck.service.AssetsDeviceRegularCheckService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Calendar;
import java.util.List;
/**
 * 流程结束前修改对应台账的时间信息
 */
public class ChangeAccount implements EventListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceRcheckPlanService.class);

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();
        /* 需要调用assetsDeviceRcheckPlanService里面的方法，必须建立SpringFactory */
        AssetsDeviceRcheckPlanService assetsDeviceRcheckPlanService = SpringFactory.getBean("assetsDeviceRcheckPlanService");
        /*按计划id获取子表定检时间最大的书记列表*/
        List<AssetsDeviceRcheckPlanDTO> planList = assetsDeviceRcheckPlanService.searchAssetsDeviceRcheckPlanMax(id);

        for (AssetsDeviceRcheckPlanDTO item : planList) {
            Calendar cal = Calendar.getInstance();
            /* 需要调用assetsDeviceRegularCheckService里面的方法，必须建立SpringFactory */
            AssetsDeviceRegularCheckService assetsDeviceRegularCheckService = SpringFactory.getBean("assetsDeviceRegularCheckService");
            /*根据ID查询台账定检信息*/
            AssetsDeviceRegularCheckDTO regularCheck = assetsDeviceRegularCheckService.findById(item.getCheckId());
            /*赋值上次定检时间*/
            regularCheck.setLastRegularCheckDate(item.getRegularCheckDate());
            /*计算下次定检时间*/
            cal.setTime(item.getRegularCheckDate());
            cal.add(Calendar.DAY_OF_MONTH, item.getRegularCheckCycle().intValue());
            /*赋值下次定检时间*/
            regularCheck.setNextRegularCheckDate(cal.getTime());
            /*修改台账信息*/
            assetsDeviceRegularCheckService.updateAssetsDeviceRegularCheckAll(regularCheck);
        }

    }
}
