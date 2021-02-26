package avicit.assets.device.assetsdevicerepair.rest;

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

import avicit.assets.device.assetsdevicerepair.dto.AssetsDeviceRepairDTO;
import avicit.assets.device.assetsdevicerepair.service.AssetsDeviceRepairService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 14:08
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdevicerepair/AssetsDeviceRepairRest")
public class AssetsDeviceRepairRest {

	@Autowired
	private AssetsDeviceRepairService assetsDeviceRepairService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceRepairDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceRepairDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceRepairDTO> responseMsg = new ResponseMsg<AssetsDeviceRepairDTO>();
		AssetsDeviceRepairDTO dto = assetsDeviceRepairService.queryAssetsDeviceRepairByPrimaryKey(id);
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
	public ResponseMsg<String> save(AssetsDeviceRepairDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceRepairService.insertAssetsDeviceRepair(dto);
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
	public ResponseMsg<Integer> updateSensitive(AssetsDeviceRepairDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceRepairService.updateAssetsDeviceRepairSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(AssetsDeviceRepairDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceRepairService.updateAssetsDeviceRepair(dto);
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
		int count = assetsDeviceRepairService.deleteAssetsDeviceRepairById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param sfnConditions 条件
	* @return ResponseMsg<QueryRespBean<AssetsDeviceRepairDTO>>
	* @throws Exception
	*/
	@POST
	@Path("/searchByPage/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceRepairDTO>> searchByPage(
			QueryReqBean<AssetsDeviceRepairDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceRepairDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceRepairDTO>>();
		QueryRespBean<AssetsDeviceRepairDTO> queryRespBean = assetsDeviceRepairService
				.searchAssetsDeviceRepairByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
}
