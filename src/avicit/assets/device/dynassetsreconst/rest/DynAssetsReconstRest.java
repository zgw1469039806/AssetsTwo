package avicit.assets.device.dynassetsreconst.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import avicit.assets.device.assetsreconstructioncheck.dto.AssetsReconstructionCheckDTO;
import avicit.assets.device.assetsreconstructioncheck.service.AssetsReconstructionCheckService;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.dynassetsreconst.dto.DynAssetsReconstDTO;
import avicit.assets.device.dynassetsreconst.service.DynAssetsReconstService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:03
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/dynassetsreconst/DynAssetsReconstRest")
public class DynAssetsReconstRest {

	@Autowired
	private DynAssetsReconstService dynAssetsReconstService;

	@Autowired
	private AssetsReconstructionCheckService assetsReconstructionCheckService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<DynAssetsReconstDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<DynAssetsReconstDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<DynAssetsReconstDTO> responseMsg = new ResponseMsg<DynAssetsReconstDTO>();
		DynAssetsReconstDTO dto = dynAssetsReconstService.queryDynAssetsReconstByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(DynAssetsReconstDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = dynAssetsReconstService.insertDynAssetsReconst(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(DynAssetsReconstDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynAssetsReconstService.updateDynAssetsReconstSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(DynAssetsReconstDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = dynAssetsReconstService.updateDynAssetsReconst(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<DynAssetsReconstDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<DynAssetsReconstDTO>> searchMainByPage(
			QueryReqBean<DynAssetsReconstDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<DynAssetsReconstDTO>> responseMsg = new ResponseMsg<QueryRespBean<DynAssetsReconstDTO>>();
		String orgId = (String) ContextCommonHolder.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_ORG);
		QueryRespBean<DynAssetsReconstDTO> queryRespBean = dynAssetsReconstService
				.searchDynAssetsReconstByPage(queryReqBean, sfnConditions, orgId);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<DynAssetsReconstDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<DynAssetsReconstDTO>> searchMain(QueryReqBean<DynAssetsReconstDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<DynAssetsReconstDTO>> responseMsg = new ResponseMsg<List<DynAssetsReconstDTO>>();
		List<DynAssetsReconstDTO> queryRespBean = dynAssetsReconstService.searchDynAssetsReconst(queryReqBean);
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
		int count = dynAssetsReconstService.deleteDynAssetsReconstById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsReconstructionCheckDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsReconstructionCheckDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsReconstructionCheckDTO>> responseMsg = new ResponseMsg<List<AssetsReconstructionCheckDTO>>();
		List<AssetsReconstructionCheckDTO> dto = assetsReconstructionCheckService
				.queryAssetsReconstructionCheckByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsReconstructionCheckDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsReconstructionCheckDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsReconstructionCheckDTO> responseMsg = new ResponseMsg<AssetsReconstructionCheckDTO>();
		AssetsReconstructionCheckDTO dto = assetsReconstructionCheckService
				.queryAssetsReconstructionCheckByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsReconstructionCheckDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsReconstructionCheckService.updateAssetsReconstructionCheck(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsReconstructionCheckDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsReconstructionCheckService.updateAssetsReconstructionCheckSensitive(dto);
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
		int count = assetsReconstructionCheckService.deleteAssetsReconstructionCheckById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
