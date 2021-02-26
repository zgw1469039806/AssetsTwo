package avicit.assets.furniture.assetsfurniturescrapproc.rest;

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

import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapProcDTO;
import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapSubDTO;
import avicit.assets.furniture.assetsfurniturescrapproc.service.AssetsFurnitureScrapProcService;
import avicit.assets.furniture.assetsfurniturescrapproc.service.AssetsFurnitureScrapSubService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-20 17:18
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/furniture/assetsfurniturescrapproc/AssetsFurnitureScrapProcRest")
public class AssetsFurnitureScrapProcRest {

	@Autowired
	private AssetsFurnitureScrapProcService assetsFurnitureScrapProcService;

	@Autowired
	private AssetsFurnitureScrapSubService assetsFurnitureScrapSubService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureScrapProcDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureScrapProcDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureScrapProcDTO> responseMsg = new ResponseMsg<AssetsFurnitureScrapProcDTO>();
		AssetsFurnitureScrapProcDTO dto = assetsFurnitureScrapProcService.queryAssetsFurnitureScrapProcByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsFurnitureScrapProcDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsFurnitureScrapProcService.insertAssetsFurnitureScrapProc(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsFurnitureScrapProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureScrapProcService.updateAssetsFurnitureScrapProcSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsFurnitureScrapProcDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureScrapProcService.updateAssetsFurnitureScrapProc(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsFurnitureScrapProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsFurnitureScrapProcDTO>> searchMainByPage(
			QueryReqBean<AssetsFurnitureScrapProcDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsFurnitureScrapProcDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsFurnitureScrapProcDTO>>();
		QueryRespBean<AssetsFurnitureScrapProcDTO> queryRespBean = assetsFurnitureScrapProcService
				.searchAssetsFurnitureScrapProcByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsFurnitureScrapProcDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureScrapProcDTO>> searchMain(
			QueryReqBean<AssetsFurnitureScrapProcDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsFurnitureScrapProcDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureScrapProcDTO>>();
		List<AssetsFurnitureScrapProcDTO> queryRespBean = assetsFurnitureScrapProcService
				.searchAssetsFurnitureScrapProc(queryReqBean);
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
		int count = assetsFurnitureScrapProcService.deleteAssetsFurnitureScrapProcById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsFurnitureScrapSubDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureScrapSubDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsFurnitureScrapSubDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureScrapSubDTO>>();
		List<AssetsFurnitureScrapSubDTO> dto = assetsFurnitureScrapSubService.queryAssetsFurnitureScrapSubByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureScrapSubDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureScrapSubDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureScrapSubDTO> responseMsg = new ResponseMsg<AssetsFurnitureScrapSubDTO>();
		AssetsFurnitureScrapSubDTO dto = assetsFurnitureScrapSubService.queryAssetsFurnitureScrapSubByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsFurnitureScrapSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureScrapSubService.updateAssetsFurnitureScrapSub(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsFurnitureScrapSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureScrapSubService.updateAssetsFurnitureScrapSubSensitive(dto);
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
		int count = assetsFurnitureScrapSubService.deleteAssetsFurnitureScrapSubById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
