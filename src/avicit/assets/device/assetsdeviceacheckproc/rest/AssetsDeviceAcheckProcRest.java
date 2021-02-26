package avicit.assets.device.assetsdeviceacheckproc.rest;

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

import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckProcDTO;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;
import avicit.assets.device.assetsdeviceacheckproc.service.AssetsDeviceAcheckProcService;
import avicit.assets.device.assetsdeviceacheckproc.service.AssetsDeviceAcheckPlanService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdeviceacheckproc/AssetsDeviceAcheckProcRest")
public class AssetsDeviceAcheckProcRest {

	@Autowired
	private AssetsDeviceAcheckProcService assetsDeviceAcheckProcService;

	@Autowired
	private AssetsDeviceAcheckPlanService assetsDeviceAcheckPlanService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceAcheckProcDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceAcheckProcDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceAcheckProcDTO> responseMsg = new ResponseMsg<AssetsDeviceAcheckProcDTO>();
		AssetsDeviceAcheckProcDTO dto = assetsDeviceAcheckProcService.queryAssetsDeviceAcheckProcByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsDeviceAcheckProcDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceAcheckProcService.insertAssetsDeviceAcheckProc(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsDeviceAcheckProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAcheckProcService.updateAssetsDeviceAcheckProcSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsDeviceAcheckProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAcheckProcService.updateAssetsDeviceAcheckProc(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceAcheckProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceAcheckProcDTO>> searchMainByPage(
			QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceAcheckProcDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceAcheckProcDTO>>();
		QueryRespBean<AssetsDeviceAcheckProcDTO> queryRespBean = assetsDeviceAcheckProcService
				.searchAssetsDeviceAcheckProcByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsDeviceAcheckProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceAcheckProcDTO>> searchMain(QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsDeviceAcheckProcDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceAcheckProcDTO>>();
		List<AssetsDeviceAcheckProcDTO> queryRespBean = assetsDeviceAcheckProcService
				.searchAssetsDeviceAcheckProc(queryReqBean);
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
		int count = assetsDeviceAcheckProcService.deleteAssetsDeviceAcheckProcById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsDeviceAcheckPlanDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceAcheckPlanDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsDeviceAcheckPlanDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceAcheckPlanDTO>>();
		List<AssetsDeviceAcheckPlanDTO> dto = assetsDeviceAcheckPlanService.queryAssetsDeviceAcheckPlanByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceAcheckPlanDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceAcheckPlanDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceAcheckPlanDTO> responseMsg = new ResponseMsg<AssetsDeviceAcheckPlanDTO>();
		AssetsDeviceAcheckPlanDTO dto = assetsDeviceAcheckPlanService.queryAssetsDeviceAcheckPlanByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAcheckPlanService.updateAssetsDeviceAcheckPlan(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAcheckPlanService.updateAssetsDeviceAcheckPlanSensitive(dto);
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
		int count = assetsDeviceAcheckPlanService.deleteAssetsDeviceAcheckPlanById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
