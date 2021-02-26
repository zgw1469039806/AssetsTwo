package avicit.assets.furniture.assetsfurniturerepairproc.rest;

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

import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairProcDTO;
import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairSubDTO;
import avicit.assets.furniture.assetsfurniturerepairproc.service.AssetsFurnitureRepairProcService;
import avicit.assets.furniture.assetsfurniturerepairproc.service.AssetsFurnitureRepairSubService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-19 09:30
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/furniture/assetsfurniturerepairproc/AssetsFurnitureRepairProcRest")
public class AssetsFurnitureRepairProcRest {

	@Autowired
	private AssetsFurnitureRepairProcService assetsFurnitureRepairProcService;

	@Autowired
	private AssetsFurnitureRepairSubService assetsFurnitureRepairSubService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureRepairProcDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureRepairProcDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureRepairProcDTO> responseMsg = new ResponseMsg<AssetsFurnitureRepairProcDTO>();
		AssetsFurnitureRepairProcDTO dto = assetsFurnitureRepairProcService
				.queryAssetsFurnitureRepairProcByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsFurnitureRepairProcDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsFurnitureRepairProcService.insertAssetsFurnitureRepairProc(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsFurnitureRepairProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRepairProcService.updateAssetsFurnitureRepairProcSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsFurnitureRepairProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRepairProcService.updateAssetsFurnitureRepairProc(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsFurnitureRepairProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsFurnitureRepairProcDTO>> searchMainByPage(
			QueryReqBean<AssetsFurnitureRepairProcDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsFurnitureRepairProcDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsFurnitureRepairProcDTO>>();
		QueryRespBean<AssetsFurnitureRepairProcDTO> queryRespBean = assetsFurnitureRepairProcService
				.searchAssetsFurnitureRepairProcByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsFurnitureRepairProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureRepairProcDTO>> searchMain(
			QueryReqBean<AssetsFurnitureRepairProcDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsFurnitureRepairProcDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureRepairProcDTO>>();
		List<AssetsFurnitureRepairProcDTO> queryRespBean = assetsFurnitureRepairProcService
				.searchAssetsFurnitureRepairProc(queryReqBean);
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
		int count = assetsFurnitureRepairProcService.deleteAssetsFurnitureRepairProcById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsFurnitureRepairSubDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureRepairSubDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsFurnitureRepairSubDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureRepairSubDTO>>();
		List<AssetsFurnitureRepairSubDTO> dto = assetsFurnitureRepairSubService.queryAssetsFurnitureRepairSubByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureRepairSubDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureRepairSubDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureRepairSubDTO> responseMsg = new ResponseMsg<AssetsFurnitureRepairSubDTO>();
		AssetsFurnitureRepairSubDTO dto = assetsFurnitureRepairSubService.queryAssetsFurnitureRepairSubByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsFurnitureRepairSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRepairSubService.updateAssetsFurnitureRepairSub(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsFurnitureRepairSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureRepairSubService.updateAssetsFurnitureRepairSubSensitive(dto);
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
		int count = assetsFurnitureRepairSubService.deleteAssetsFurnitureRepairSubById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
