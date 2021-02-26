package avicit.assets.furniture.assetsfurniturerecoveryproc.rest;

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

import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoveryProcDTO;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoverySubDTO;
import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoveryProcService;
import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoverySubService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-18 08:50
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/furniture/assetsfurniturerecoveryproc/AssetsFurnitureRecoveryProcRest")
public class AssetsFurnitureRecoveryProcRest {

	@Autowired
	private AssetsFurnitureRecoveryProcService assetsFurnitureRecoveryProcService;

	@Autowired
	private AssetsFurnitureRecoverySubService assetsFurnitureRecoverySubService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureRecoveryProcDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureRecoveryProcDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureRecoveryProcDTO> responseMsg = new ResponseMsg<AssetsFurnitureRecoveryProcDTO>();
		AssetsFurnitureRecoveryProcDTO dto = assetsFurnitureRecoveryProcService
				.queryAssetsFurnitureRecoveryProcByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsFurnitureRecoveryProcDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsFurnitureRecoveryProcService.insertAssetsFurnitureRecoveryProc(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsFurnitureRecoveryProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRecoveryProcService.updateAssetsFurnitureRecoveryProcSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsFurnitureRecoveryProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRecoveryProcService.updateAssetsFurnitureRecoveryProc(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsFurnitureRecoveryProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsFurnitureRecoveryProcDTO>> searchMainByPage(
			QueryReqBean<AssetsFurnitureRecoveryProcDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsFurnitureRecoveryProcDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsFurnitureRecoveryProcDTO>>();
		QueryRespBean<AssetsFurnitureRecoveryProcDTO> queryRespBean = assetsFurnitureRecoveryProcService
				.searchAssetsFurnitureRecoveryProcByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsFurnitureRecoveryProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureRecoveryProcDTO>> searchMain(
			QueryReqBean<AssetsFurnitureRecoveryProcDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsFurnitureRecoveryProcDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureRecoveryProcDTO>>();
		List<AssetsFurnitureRecoveryProcDTO> queryRespBean = assetsFurnitureRecoveryProcService
				.searchAssetsFurnitureRecoveryProc(queryReqBean);
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
		int count = assetsFurnitureRecoveryProcService.deleteAssetsFurnitureRecoveryProcById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsFurnitureRecoverySubDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureRecoverySubDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsFurnitureRecoverySubDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureRecoverySubDTO>>();
		List<AssetsFurnitureRecoverySubDTO> dto = assetsFurnitureRecoverySubService
				.queryAssetsFurnitureRecoverySubByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureRecoverySubDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureRecoverySubDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureRecoverySubDTO> responseMsg = new ResponseMsg<AssetsFurnitureRecoverySubDTO>();
		AssetsFurnitureRecoverySubDTO dto = assetsFurnitureRecoverySubService
				.queryAssetsFurnitureRecoverySubByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRecoverySubService.updateAssetsFurnitureRecoverySub(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRecoverySubService.updateAssetsFurnitureRecoverySubSensitive(dto);
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
		int count = assetsFurnitureRecoverySubService.deleteAssetsFurnitureRecoverySubById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
