package avicit.elect.dynelect.dto;


import avicit.elect.dynelectlog.dto.DynElectLogDTO;
import avicit.elect.dynelectperson.dto.DynElectPersonDTO;

import java.util.List;

public class DynElectInfoVo {

    // 号码牌
    private String numPlate;

    // 活动规则
    private DynElectDTO dynElectDTO;

    // 候选人列表
    private List<DynElectPersonDTO> dynElectPersonDTOS;

    // 投票结果
    private List<DynElectLogDTO> dynElectLogDTOList;

    public String getNumPlate() {
        return numPlate;
    }

    public void setNumPlate(String numPlate) {
        this.numPlate = numPlate;
    }

    public DynElectDTO getDynElectDTO() {
        return dynElectDTO;
    }

    public void setDynElectDTO(DynElectDTO dynElectDTO) {
        this.dynElectDTO = dynElectDTO;
    }

    public List<DynElectPersonDTO> getDynElectPersonDTOS() {
        return dynElectPersonDTOS;
    }

    public void setDynElectPersonDTOS(List<DynElectPersonDTO> dynElectPersonDTOS) {
        this.dynElectPersonDTOS = dynElectPersonDTOS;
    }

    public List<DynElectLogDTO> getDynElectLogDTOList() {
        return dynElectLogDTOList;
    }

    public void setDynElectLogDTOList(List<DynElectLogDTO> dynElectLogDTOList) {
        this.dynElectLogDTOList = dynElectLogDTOList;
    }
}
