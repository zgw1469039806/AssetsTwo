package avicit.assets.furniture.assetsfurnitureinventory.rest;

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

import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventoryDTO;
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventorySubDTO;
import avicit.assets.furniture.assetsfurnitureinventory.service.AssetsFurnitureInventoryService;
import avicit.assets.furniture.assetsfurnitureinventory.service.AssetsFurnitureInventorySubService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:15
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/furniture/assetsfurnitureinventory/AssetsFurnitureInventoryRest")
public class AssetsFurnitureInventoryRest {

	@Autowired
	private AssetsFurnitureInventoryService assetsFurnitureInventoryService;

	@Autowired
	private AssetsFurnitureInventorySubService assetsFurnitureInventorySubService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureInventoryDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureInventoryDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureInventoryDTO> responseMsg = new ResponseMsg<AssetsFurnitureInventoryDTO>();
		AssetsFurnitureInventoryDTO dto = assetsFurnitureInventoryService.queryAssetsFurnitureInventoryByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsFurnitureInventoryDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsFurnitureInventoryService.insertAssetsFurnitureInventory(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsFurnitureInventoryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureInventoryService.updateAssetsFurnitureInventorySensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsFurnitureInventoryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureInventoryService.updateAssetsFurnitureInventory(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsFurnitureInventoryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsFurnitureInventoryDTO>> searchMainByPage(
			QueryReqBean<AssetsFurnitureInventoryDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsFurnitureInventoryDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsFurnitureInventoryDTO>>();
		QueryRespBean<AssetsFurnitureInventoryDTO> queryRespBean = assetsFurnitureInventoryService
				.searchAssetsFurnitureInventoryByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsFurnitureInventoryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureInventoryDTO>> searchMain(
			QueryReqBean<AssetsFurnitureInventoryDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsFurnitureInventoryDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureInventoryDTO>>();
		List<AssetsFurnitureInventoryDTO> queryRespBean = assetsFurnitureInventoryService
				.searchAssetsFurnitureInventory(queryReqBean);
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
		int count = assetsFurnitureInventoryService.deleteAssetsFurnitureInventoryById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsFurnitureInventorySubDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsFurnitureInventorySubDTO>> getSubByPid(@PathParam("pid") String pid)
			throws Exception {
		ResponseMsg<List<AssetsFurnitureInventorySubDTO>> responseMsg = new ResponseMsg<List<AssetsFurnitureInventorySubDTO>>();
		List<AssetsFurnitureInventorySubDTO> dto = assetsFurnitureInventorySubService
				.queryAssetsFurnitureInventorySubByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsFurnitureInventorySubDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsFurnitureInventorySubDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsFurnitureInventorySubDTO> responseMsg = new ResponseMsg<AssetsFurnitureInventorySubDTO>();
		AssetsFurnitureInventorySubDTO dto = assetsFurnitureInventorySubService
				.queryAssetsFurnitureInventorySubByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsFurnitureInventorySubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureInventorySubService.updateAssetsFurnitureInventorySub(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsFurnitureInventorySubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsFurnitureInventorySubService.updateAssetsFurnitureInventorySubSensitive(dto);
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
		int count = assetsFurnitureInventorySubService.deleteAssetsFurnitureInventorySubById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
