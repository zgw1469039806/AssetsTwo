package avicit.assets.device.usertablemodel.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 10:01
 * @类说明：请填写
 * @修改记录：
 */
@RestEasyController
@Path("/api/assets/device/usertablemodel/UserTableModelRest")
public class UserTableModelRest {

    @Autowired
    private UserTableModelService userTableModelService;

    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return ResponseMsg<UserTableModelDTO>
     * @throws Exception
     */
    @GET
    @Path("/get/v1/{id}")
    @Produces("application/json;charset=UTF-8")
    public ResponseMsg<UserTableModelDTO> get(@PathParam("id") String id) throws Exception {
        ResponseMsg<UserTableModelDTO> responseMsg = new ResponseMsg<UserTableModelDTO>();
        UserTableModelDTO dto = userTableModelService.queryUserTableModelByPrimaryKey(id);
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
    public ResponseMsg<String> save(UserTableModelDTO dto) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg<String>();
        String id = userTableModelService.insertUserTableModel(dto);
        responseMsg.setResponseBody(id);
        return responseMsg;
    }


    /**
     * 按主键单条删除
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
        int count = userTableModelService.deleteUserTableModelById(id);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }
}
