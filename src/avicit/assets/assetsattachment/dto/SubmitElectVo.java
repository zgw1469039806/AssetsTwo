package avicit.assets.assetsattachment.dto;

import avicit.elect.dynelectlog.dto.DynElectLogDTO;

import java.util.List;

public class SubmitElectVo {

    private  String electId;

    private  String numPlate;

    public String getElectId() {
        return electId;
    }

    public void setElectId(String electId) {
        this.electId = electId;
    }

    public String getNumPlate() {
        return numPlate;
    }

    public void setNumPlate(String numPlate) {
        this.numPlate = numPlate;
    }

    public List<DynElectLogDTO> getDynElectLogDTOS() {
        return dynElectLogDTOS;
    }

    public void setDynElectLogDTOS(List<DynElectLogDTO> dynElectLogDTOS) {
        this.dynElectLogDTOS = dynElectLogDTOS;
    }

    private List<DynElectLogDTO> dynElectLogDTOS;

}
