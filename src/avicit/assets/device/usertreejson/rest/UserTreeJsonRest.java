package avicit.assets.device.usertreejson.rest;

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

import avicit.assets.device.usertreejson.dto.UserTreeJsonDTO;
import avicit.assets.device.usertreejson.service.UserTreeJsonService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-05 10:55
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/demo/baseinfo/usertreejson/UserTreeJsonRest")
public class UserTreeJsonRest{
    private static final Logger LOGGER =  LoggerFactory.getLogger(UserTreeJsonRest.class);
    
	@Autowired
	private UserTreeJsonService userTreeJsonService;
	
	
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<UserTreeJsonDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UserTreeJsonDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UserTreeJsonDTO> responseMsg = new ResponseMsg<UserTreeJsonDTO>();
		UserTreeJsonDTO dto = userTreeJsonService.queryUserTreeJsonByPrimaryKey(id);
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
	public ResponseMsg<String> save(UserTreeJsonDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = userTreeJsonService.insertUserTreeJson(dto);
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
	public ResponseMsg<Integer> updateSensitive(UserTreeJsonDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = userTreeJsonService.updateUserTreeJsonSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改全部对象字段
	 * @param dto 修改对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateAll/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateAll(UserTreeJsonDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = userTreeJsonService.updateUserTreeJson(dto);
		responseMsg.setResponseBody(count);
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
		int count = userTreeJsonService.deleteUserTreeJsonById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<QueryRespBean<UserTreeJsonDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<UserTreeJsonDTO>> searchByPage(QueryReqBean<UserTreeJsonDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UserTreeJsonDTO>> responseMsg = new ResponseMsg<QueryRespBean<UserTreeJsonDTO>>();
			    		    	    		    	    		    	    		    	    		    	    	    	    QueryRespBean<UserTreeJsonDTO> queryRespBean = userTreeJsonService.searchUserTreeJsonByPage(queryReqBean,"");
	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	/**
	 * 按条件不分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<List<UserTreeJsonDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/search/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<UserTreeJsonDTO>> search(QueryReqBean<UserTreeJsonDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UserTreeJsonDTO>> responseMsg = new ResponseMsg<List<UserTreeJsonDTO>>();
		List<UserTreeJsonDTO> queryRespBean = userTreeJsonService.searchUserTreeJson(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
