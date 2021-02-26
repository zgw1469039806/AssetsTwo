package avicit.assets.device.assetsdevicemetering.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import avicit.assets.device.assetsdevicemetering.dto.DynDeviceToolDTO;
import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.assets.device.assetsdevicemetering.service.DynDeviceToolService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 16:14
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdevicemetering/AssetsDeviceMeteringRest")
public class AssetsDeviceMeteringRest {

	@Autowired
	private AssetsDeviceMeteringService assetsDeviceMeteringService;

	@Autowired
	private DynDeviceToolService dynDeviceToolService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceMeteringDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceMeteringDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceMeteringDTO> responseMsg = new ResponseMsg<AssetsDeviceMeteringDTO>();
		AssetsDeviceMeteringDTO dto = assetsDeviceMeteringService.queryAssetsDeviceMeteringByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 新增主表对象
	 * @param dto 保存对象
	 * @return ResponseMsg<String>
	 * @throws Exception
	 */
	@POST
	@Path("/saveMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> saveMain(AssetsDeviceMeteringDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceMeteringService.insertAssetsDeviceMetering(dto);
		responseMsg.setResponseBody(id);
		return responseMsg;
	}

	/**
	 * 更新主表数据
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainSensitive(AssetsDeviceMeteringDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMeteringService.updateAssetsDeviceMeteringSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 修改主表全部对象字段
	 * @param dto 修改对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateMainAll/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainAll(AssetsDeviceMeteringDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMeteringService.updateAssetsDeviceMetering(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceMeteringDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceMeteringDTO>> searchMainByPage(
			QueryReqBean<AssetsDeviceMeteringDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceMeteringDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceMeteringDTO>>();
		QueryRespBean<AssetsDeviceMeteringDTO> queryRespBean = assetsDeviceMeteringService
				.searchAssetsDeviceMeteringByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsDeviceMeteringDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceMeteringDTO>> searchMain(QueryReqBean<AssetsDeviceMeteringDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsDeviceMeteringDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceMeteringDTO>>();
		List<AssetsDeviceMeteringDTO> queryRespBean = assetsDeviceMeteringService
				.searchAssetsDeviceMetering(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按照ID删除一条主表记录
	 * @param id 主键id
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/deleteMainById/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteMainById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMeteringService.deleteAssetsDeviceMeteringById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<DynDeviceToolDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<DynDeviceToolDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<DynDeviceToolDTO>> responseMsg = new ResponseMsg<List<DynDeviceToolDTO>>();
		List<DynDeviceToolDTO> dto = dynDeviceToolService.queryDynDeviceToolByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<DynDeviceToolDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<DynDeviceToolDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<DynDeviceToolDTO> responseMsg = new ResponseMsg<DynDeviceToolDTO>();
		DynDeviceToolDTO dto = dynDeviceToolService.queryDynDeviceToolByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 更新子表数据
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateSub/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubSensitive(DynDeviceToolDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynDeviceToolService.updateDynDeviceTool(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 修改子表一条记录的全部字段
	 * @param dto 更新对象
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/updateSubAll/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubAll(DynDeviceToolDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynDeviceToolService.updateDynDeviceToolSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按照ID删除一条子表记录
	 * @param id 主键id
	 * @return ResponseMsg<Integer>
	 * @throws Exception
	 */
	@POST
	@Path("/deleteSubById/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteSubById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynDeviceToolService.deleteDynDeviceToolById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
