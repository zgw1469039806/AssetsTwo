package avicit.assets.device.assetsustdtempapplyproc.event;

import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import com.alibaba.fastjson.JSON;

public class SyncDataToGs implements EventListener {
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
         System.out.println(JSON.toJSONString(eventListenerExecution.getVariables()));
    }
}
