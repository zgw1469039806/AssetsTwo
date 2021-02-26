package avicit.assets.device.assetsdeviceaccount.ws;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import java.util.List;

/**
 * @Auther: yangxd
 * @Date: 2020/9/2
 */

@WebService
public interface AssetsDeviceAccountWebService {

    /**
     * 财务记账完毕，推送信息到本系统 Interface5
     * @param accountList
     * @return
     */
    @WebMethod(operationName = "finishAccount")
    @WebResult(name = "result")
    String finishAccount(@WebParam(name="accountList")List<AssetsDeviceAccountDTO> accountList);


    /**
     * 准备定时任务
     * @return
     */
    @WebMethod(operationName = "readyExecute")
    @WebResult(name = "result")
    String readyExecute();

}
