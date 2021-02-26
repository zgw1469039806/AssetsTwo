package avicit.assets.device.assetsdevicemcheckproc.rest;

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

import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckProcDTO;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;
import avicit.assets.device.assetsdevicemcheckproc.service.AssetsDeviceMcheckProcService;
import avicit.assets.device.assetsdevicemcheckproc.service.AssetsDeviceMcheckPlanService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdevicemcheckproc/AssetsDeviceMcheckProcRest")
public class AssetsDeviceMcheckProcRest {

	@Autowired
	private AssetsDeviceMcheckProcService assetsDeviceMcheckProcService;

	@Autowired
	private AssetsDeviceMcheckPlanService assetsDeviceMcheckPlanService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceMcheckProcDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceMcheckProcDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceMcheckProcDTO> responseMsg = new ResponseMsg<AssetsDeviceMcheckProcDTO>();
		AssetsDeviceMcheckProcDTO dto = assetsDeviceMcheckProcService.queryAssetsDeviceMcheckProcByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsDeviceMcheckProcDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceMcheckProcService.insertAssetsDeviceMcheckProc(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsDeviceMcheckProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMcheckProcService.updateAssetsDeviceMcheckProcSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsDeviceMcheckProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMcheckProcService.updateAssetsDeviceMcheckProc(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceMcheckProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceMcheckProcDTO>> searchMainByPage(
			QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceMcheckProcDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceMcheckProcDTO>>();
		QueryRespBean<AssetsDeviceMcheckProcDTO> queryRespBean = assetsDeviceMcheckProcService
				.searchAssetsDeviceMcheckProcByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsDeviceMcheckProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceMcheckProcDTO>> searchMain(QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsDeviceMcheckProcDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceMcheckProcDTO>>();
		List<AssetsDeviceMcheckProcDTO> queryRespBean = assetsDeviceMcheckProcService
				.searchAssetsDeviceMcheckProc(queryReqBean);
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
		int count = assetsDeviceMcheckProcService.deleteAssetsDeviceMcheckProcById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsDeviceMcheckPlanDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceMcheckPlanDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsDeviceMcheckPlanDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceMcheckPlanDTO>>();
		List<AssetsDeviceMcheckPlanDTO> dto = assetsDeviceMcheckPlanService.queryAssetsDeviceMcheckPlanByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceMcheckPlanDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceMcheckPlanDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceMcheckPlanDTO> responseMsg = new ResponseMsg<AssetsDeviceMcheckPlanDTO>();
		AssetsDeviceMcheckPlanDTO dto = assetsDeviceMcheckPlanService.queryAssetsDeviceMcheckPlanByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMcheckPlanService.updateAssetsDeviceMcheckPlan(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceMcheckPlanService.updateAssetsDeviceMcheckPlanSensitive(dto);
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
		int count = assetsDeviceMcheckPlanService.deleteAssetsDeviceMcheckPlanById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
