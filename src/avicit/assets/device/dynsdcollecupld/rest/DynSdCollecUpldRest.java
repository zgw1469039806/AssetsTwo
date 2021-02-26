package avicit.assets.device.dynsdcollecupld.rest;

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

import avicit.assets.device.dynsdcollecupld.dto.DynSdCollecUpldDTO;
import avicit.assets.device.dynsdcollecupld.service.DynSdCollecUpldService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 15:42
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/dynsdcollecupld/DynSdCollecUpldRest")
public class DynSdCollecUpldRest{
	private static final Logger LOGGER =  LoggerFactory.getLogger(DynSdCollecUpldRest.class);
	
	@Autowired
	private DynSdCollecUpldService dynSdCollecUpldService;
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<DynSdCollecUpldDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<DynSdCollecUpldDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<DynSdCollecUpldDTO> responseMsg = new ResponseMsg<DynSdCollecUpldDTO>();
		DynSdCollecUpldDTO dto = dynSdCollecUpldService.queryDynSdCollecUpldByPrimaryKey(id);
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
	@Path("/save/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> save(DynSdCollecUpldDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = dynSdCollecUpldService.insertDynSdCollecUpld(dto);
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
	@Path("/updateSensitive/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSensitive(DynSdCollecUpldDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynSdCollecUpldService.updateDynSdCollecUpldSensitive(dto);
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
	@Path("/updateAll/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateAll(DynSdCollecUpldDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynSdCollecUpldService.updateDynSdCollecUpld(dto);
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
	@Path("/deleteById/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynSdCollecUpldService.deleteDynSdCollecUpldById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
		/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param sfnConditions 条件
	 * @return ResponseMsg<QueryRespBean<DynSdCollecUpldDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<DynSdCollecUpldDTO>> searchByPage(QueryReqBean<DynSdCollecUpldDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<DynSdCollecUpldDTO>> responseMsg = new ResponseMsg<QueryRespBean<DynSdCollecUpldDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    		QueryRespBean<DynSdCollecUpldDTO> queryRespBean = dynSdCollecUpldService.searchDynSdCollecUpldByPage(queryReqBean, sfnConditions, SessionHelper.getCurrentOrgIdentity());
					    	    	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
}
