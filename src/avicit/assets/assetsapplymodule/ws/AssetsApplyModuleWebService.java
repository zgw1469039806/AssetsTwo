package avicit.assets.assetsapplymodule.ws;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import java.util.List;

@WebService
public interface AssetsApplyModuleWebService {

    /*
    外部调用查询方法 Interface1
    */
    @WebMethod(operationName = "findAssetsApplyModules")
    @WebResult(name = "result")
    QueryRespBean<AssetsApplyModuleDTO> findAssetsApplyModules(@WebParam(name="applyModuleDTO") QueryReqBean<AssetsApplyModuleDTO> queryReqBean,String orderBy);

    /*
     关联合同系统 Interface2
    */
    @WebMethod(operationName = "relateGS")
    @WebResult(name = "result")
    String  relateGS(@WebParam(name="applyList")List<AssetsApplyModuleDTO> applyList );



    /*
     合同系统审批结束 Interface3
    */
    @WebMethod(operationName = "approvalFinish")
    @WebResult(name = "result")
    String  approvalFinish(@WebParam(name="applyList")List<AssetsApplyModuleDTO> applyList );










}
