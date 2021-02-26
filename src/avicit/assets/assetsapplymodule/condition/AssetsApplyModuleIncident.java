package avicit.assets.assetsapplymodule.condition;


import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;

public class AssetsApplyModuleIncident implements EventListener {

    @Override
    public void notify(EventListenerExecution event) throws Exception {
    System.err.println("+++++++++++++++++++++++++++++++++++++++++++++");
    }
}
