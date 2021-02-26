package avicit.assets.device.assetsdeviceaccount.rest;

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

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 17:59
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdeviceaccount/AssetsDeviceAccountRest")
public class AssetsDeviceAccountRest {

	@Autowired
	private AssetsDeviceAccountService assetsDeviceAccountService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceAccountDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceAccountDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceAccountDTO> responseMsg = new ResponseMsg<AssetsDeviceAccountDTO>();
		AssetsDeviceAccountDTO dto = assetsDeviceAccountService.queryAssetsDeviceAccountByPrimaryKey(id);
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
	public ResponseMsg<String> save(AssetsDeviceAccountDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceAccountService.insertAssetsDeviceAccount(dto);
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
	public ResponseMsg<Integer> updateSensitive(AssetsDeviceAccountDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAccountService.updateAssetsDeviceAccountSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(AssetsDeviceAccountDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAccountService.updateAssetsDeviceAccount(dto);
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
		int count = assetsDeviceAccountService.deleteAssetsDeviceAccountById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceAccountDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceAccountDTO>> searchByPage(
			QueryReqBean<AssetsDeviceAccountDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceAccountDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceAccountDTO>>();
		QueryRespBean<AssetsDeviceAccountDTO> queryRespBean = assetsDeviceAccountService
				.searchAssetsDeviceAccountByPage(queryReqBean, "");
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<List<AssetsDeviceAccountDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/search/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceAccountDTO>> search(QueryReqBean<AssetsDeviceAccountDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsDeviceAccountDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceAccountDTO>>();
		List<AssetsDeviceAccountDTO> queryRespBean = assetsDeviceAccountService.searchAssetsDeviceAccount(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

}
