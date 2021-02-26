package avicit.assets.furniture.furniturecollect.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectDTO;
import avicit.assets.furniture.furniturecollect.service.FurnitureCollectService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-11 11:13
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/demo/baseinfo/furnitureCollect/FurnitureCollectRest")
public class FurnitureCollectRest{
    private static final Logger LOGGER =  LoggerFactory.getLogger(FurnitureCollectRest.class);
    
	@Autowired
	private FurnitureCollectService furnitureCollectService;
	
	/**
	 * 通过主键查询单条记录
	 * @return ResponseMsg<UserCollectDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<FurnitureCollectDTO> get(@PathParam("userId") String userId, @PathParam("nodeId") String nodeId) throws Exception {
		ResponseMsg<FurnitureCollectDTO> responseMsg = new ResponseMsg<FurnitureCollectDTO>();
		FurnitureCollectDTO dto = furnitureCollectService.queryUserCollectByPrimaryKey(userId, nodeId);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	
	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return ResponseMsg<String>
	 * @throws Exception
	 */
	@POST
	@Path("/save/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> save(FurnitureCollectDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = furnitureCollectService.insertUserCollect(dto);
		responseMsg.setResponseBody(id);
		return responseMsg;
	}
	
	/**
	 * 修改部分对象字段
	 * @param dto 修改对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateSensitive/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSensitive(FurnitureCollectDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = furnitureCollectService.updateUserCollect(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按主键单条删除
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/deleteById/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteById(String userId, String nodeId) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = furnitureCollectService.deleteUserCollectById(userId, nodeId);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}	
}
