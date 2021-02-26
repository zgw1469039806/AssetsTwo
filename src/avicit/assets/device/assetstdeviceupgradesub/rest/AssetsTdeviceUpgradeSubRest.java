package avicit.assets.device.assetstdeviceupgradesub.rest;

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

import avicit.assets.device.assetstdeviceupgradesub.dto.AssetsTdeviceUpgradeSubDTO;
import avicit.assets.device.assetstdeviceupgradesub.service.AssetsTdeviceUpgradeSubService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 08:43
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetstdeviceupgradesub/AssetsTdeviceUpgradeSubRest")
public class AssetsTdeviceUpgradeSubRest {

	@Autowired
	private AssetsTdeviceUpgradeSubService assetsTdeviceUpgradeSubService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsTdeviceUpgradeSubDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsTdeviceUpgradeSubDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsTdeviceUpgradeSubDTO> responseMsg = new ResponseMsg<AssetsTdeviceUpgradeSubDTO>();
		AssetsTdeviceUpgradeSubDTO dto = assetsTdeviceUpgradeSubService.queryAssetsTdeviceUpgradeSubByPrimaryKey(id);
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
	public ResponseMsg<String> save(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsTdeviceUpgradeSubService.insertAssetsTdeviceUpgradeSub(dto);
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
	public ResponseMsg<Integer> updateSensitive(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsTdeviceUpgradeSubService.updateAssetsTdeviceUpgradeSubSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsTdeviceUpgradeSubService.updateAssetsTdeviceUpgradeSub(dto);
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
		int count = assetsTdeviceUpgradeSubService.deleteAssetsTdeviceUpgradeSubById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 查询条件
	* @param orderBy 排序
	* @return ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>>
	* @throws Exception
	*/
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>> searchByPage(
			QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>>();
		QueryRespBean<AssetsTdeviceUpgradeSubDTO> queryRespBean = assetsTdeviceUpgradeSubService
				.searchAssetsTdeviceUpgradeSubByPage(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件分页查询or
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPageOr/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>> searchByPageOr(
			QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsTdeviceUpgradeSubDTO>>();
		QueryRespBean<AssetsTdeviceUpgradeSubDTO> queryRespBean = assetsTdeviceUpgradeSubService
				.searchAssetsTdeviceUpgradeSubByPageOr(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询
	 * @param queryReqBean 查询条件
	 * @return ResponseMsg<List<AssetsTdeviceUpgradeSubDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/search/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsTdeviceUpgradeSubDTO>> search(QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsTdeviceUpgradeSubDTO>> responseMsg = new ResponseMsg<List<AssetsTdeviceUpgradeSubDTO>>();
		List<AssetsTdeviceUpgradeSubDTO> queryRespBean = assetsTdeviceUpgradeSubService
				.searchAssetsTdeviceUpgradeSub(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

}
