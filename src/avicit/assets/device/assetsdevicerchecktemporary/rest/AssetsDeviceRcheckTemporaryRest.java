package avicit.assets.device.assetsdevicerchecktemporary.rest;

import java.util.List;

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

import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
import avicit.assets.device.assetsdevicerchecktemporary.service.AssetsDeviceRcheckTemporaryService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-01 19:37
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdevicerchecktemporary/AssetsDeviceRcheckTemporaryRest")
public class AssetsDeviceRcheckTemporaryRest {

	@Autowired
	private AssetsDeviceRcheckTemporaryService assetsDeviceRcheckTemporaryService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceRcheckTemporaryDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceRcheckTemporaryDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceRcheckTemporaryDTO> responseMsg = new ResponseMsg<AssetsDeviceRcheckTemporaryDTO>();
		AssetsDeviceRcheckTemporaryDTO dto = assetsDeviceRcheckTemporaryService
				.queryAssetsDeviceRcheckTemporaryByPrimaryKey(id);
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
	public ResponseMsg<String> save(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceRcheckTemporaryService.insertAssetsDeviceRcheckTemporary(dto);
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
	public ResponseMsg<Integer> updateSensitive(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceRcheckTemporaryService.updateAssetsDeviceRcheckTemporarySensitive(dto);
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
	public ResponseMsg<Integer> updateAll(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceRcheckTemporaryService.updateAssetsDeviceRcheckTemporary(dto);
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
		int count = assetsDeviceRcheckTemporaryService.deleteAssetsDeviceRcheckTemporaryById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceRcheckTemporaryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceRcheckTemporaryDTO>> searchByPage(
			QueryReqBean<AssetsDeviceRcheckTemporaryDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceRcheckTemporaryDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceRcheckTemporaryDTO>>();
		QueryRespBean<AssetsDeviceRcheckTemporaryDTO> queryRespBean = assetsDeviceRcheckTemporaryService
				.searchAssetsDeviceRcheckTemporaryByPage(queryReqBean, "");
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<List<AssetsDeviceRcheckTemporaryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/search/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceRcheckTemporaryDTO>> search(
			QueryReqBean<AssetsDeviceRcheckTemporaryDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsDeviceRcheckTemporaryDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceRcheckTemporaryDTO>>();
		List<AssetsDeviceRcheckTemporaryDTO> queryRespBean = assetsDeviceRcheckTemporaryService
				.searchAssetsDeviceRcheckTemporary();
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

}
