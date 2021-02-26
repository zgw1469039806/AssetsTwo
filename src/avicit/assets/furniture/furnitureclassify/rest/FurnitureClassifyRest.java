package avicit.assets.furniture.furnitureclassify.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import avicit.platform6.api.session.SessionHelper;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyDTO;
import avicit.assets.furniture.furnitureclassify.service.FurnitureClassifyService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-05-28 09:07
 * @类说明：请填写
 * @修改记录：
 */
@RestEasyController
@Path("/api/demo/baseinfo/furnitureclassify/FurnitureClassifyRest")
public class FurnitureClassifyRest {
    private static final Logger LOGGER = LoggerFactory.getLogger(FurnitureClassifyRest.class);

    @Autowired
    private FurnitureClassifyService furnitureClassifyService;


    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return ResponseMsg<FurnitureClassifyDTO>
     * @throws Exception
     */
    @GET
    @Path("/get/v1/{id}")
    @Produces("application/json;charset=UTF-8")
    public ResponseMsg<FurnitureClassifyDTO> get(@PathParam("id") String id) throws Exception {
        ResponseMsg<FurnitureClassifyDTO> responseMsg = new ResponseMsg<FurnitureClassifyDTO>();
        FurnitureClassifyDTO dto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(id);
        responseMsg.setResponseBody(dto);
        return responseMsg;
    }


    /**
     * 新增对象
     *
     * @param dto 保存对象
     * @return ResponseMsg<String>
     * @throws Exception
     */
    @POST
    @Path("/save/v1")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<String> save(FurnitureClassifyDTO dto) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg<String>();
        dto = furnitureClassifyService.insertFurnitureClassify(dto);
        responseMsg.setResponseBody(dto.getId());
        return responseMsg;
    }

    /**
     * 修改部分对象字段
     *
     * @param dto 修改对象
     * @return ResponseMsg<Integer>
     * @throws Exception
     */
    @POST
    @Path("/updateSensitive/v1")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<Integer> updateSensitive(FurnitureClassifyDTO dto) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
        int count = furnitureClassifyService.updateFurnitureClassifySensitive(dto);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    /**
     * 修改全部对象字段
     *
     * @param dto 修改对象
     * @return ResponseMsg<Integer>
     * @throws Exception
     */
    @POST
    @Path("/updateAll/v1")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<Integer> updateAll(FurnitureClassifyDTO dto) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
        int count = furnitureClassifyService.updateFurnitureClassify(dto);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    /**
     * 按主键单条删除
     *
     * @param id 主键id
     * @return ResponseMsg<Integer>
     * @throws Exception
     */
    @POST
    @Path("/deleteById/v1")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<Integer> deleteById(String id) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
        int count = furnitureClassifyService.deleteFurnitureClassifyById(id);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    /**
     * 按条件分页查询
     *
     * @param queryReqBean 查询条件
     * @return ResponseMsg<QueryRespBean   <   FurnitureClassifyDTO>>
     * @throws Exception
     */
    @POST
    @Path("/searchByPage/v1")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<QueryRespBean<FurnitureClassifyDTO>> searchByPage(QueryReqBean<FurnitureClassifyDTO> queryReqBean) throws Exception {
        ResponseMsg<QueryRespBean<FurnitureClassifyDTO>> responseMsg = new ResponseMsg<QueryRespBean<FurnitureClassifyDTO>>();
        QueryRespBean<FurnitureClassifyDTO> queryRespBean = furnitureClassifyService.searchFurnitureClassifyByPage(queryReqBean, "");
        responseMsg.setResponseBody(queryRespBean);
        return responseMsg;
    }

    /**
     * 按条件不分页查询
     *
     * @param queryReqBean 查询条件
     * @return ResponseMsg<List   <   FurnitureClassifyDTO>>
     * @throws Exception
     */
    @POST
    @Path("/search/v1/")
    @Produces("application/json;charset=UTF-8")
    @Consumes("application/json;charset=UTF-8")
    public ResponseMsg<List<FurnitureClassifyDTO>> search(QueryReqBean<FurnitureClassifyDTO> queryReqBean) throws Exception {
        ResponseMsg<List<FurnitureClassifyDTO>> responseMsg = new ResponseMsg<List<FurnitureClassifyDTO>>();
        List<FurnitureClassifyDTO> queryRespBean = furnitureClassifyService.searchFurnitureClassify(queryReqBean);
        responseMsg.setResponseBody(queryRespBean);
        return responseMsg;
    }

}
