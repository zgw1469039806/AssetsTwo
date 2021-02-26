package avicit.assets.lab.assetslaborder.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.lab.assetslaborder.dto.AssetsLabOrderDTO;
import avicit.assets.lab.assetslaborder.service.AssetsLabOrderService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 15:34
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/lab/assetslaborder/AssetsLabOrderRest")
public class AssetsLabOrderRest {

	@Autowired
	private AssetsLabOrderService assetsLabOrderService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsLabOrderDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsLabOrderDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsLabOrderDTO> responseMsg = new ResponseMsg<AssetsLabOrderDTO>();
		AssetsLabOrderDTO dto = assetsLabOrderService.queryAssetsLabOrderByPrimaryKey(id);
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
	public ResponseMsg<String> save(AssetsLabOrderDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsLabOrderService.insertAssetsLabOrder(dto);
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
	public ResponseMsg<Integer> updateSensitive(AssetsLabOrderDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsLabOrderService.updateAssetsLabOrderSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(AssetsLabOrderDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsLabOrderService.updateAssetsLabOrder(dto);
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
		int count = assetsLabOrderService.deleteAssetsLabOrderById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param sfnConditions 条件
	* @return ResponseMsg<QueryRespBean<AssetsLabOrderDTO>>
	* @throws Exception
	*/
	@POST
	@Path("/searchByPage/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsLabOrderDTO>> searchByPage(QueryReqBean<AssetsLabOrderDTO> queryReqBean,
			String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsLabOrderDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsLabOrderDTO>>();
		QueryRespBean<AssetsLabOrderDTO> queryRespBean = assetsLabOrderService.searchAssetsLabOrderByPage(queryReqBean,
				sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
}
