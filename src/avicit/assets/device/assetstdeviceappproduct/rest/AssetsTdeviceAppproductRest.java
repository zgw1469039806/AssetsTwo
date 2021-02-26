package avicit.assets.device.assetstdeviceappproduct.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.assetstdeviceappproduct.dto.AssetsTdeviceAppproductDTO;
import avicit.assets.device.assetstdeviceappproduct.service.AssetsTdeviceAppproductService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 17:31
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetstdeviceappproduct/AssetsTdeviceAppproductRest")
public class AssetsTdeviceAppproductRest {

	@Autowired
	private AssetsTdeviceAppproductService assetsTdeviceAppproductService;

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
	public ResponseMsg<Integer> updateAll(AssetsTdeviceAppproductDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsTdeviceAppproductService.updateAssetsTdeviceAppproduct(dto);
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
		int count = assetsTdeviceAppproductService.deleteAssetsTdeviceAppproductById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @param orderBy 排序
	 * @return ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>> searchByPage(
			QueryReqBean<AssetsTdeviceAppproductDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>>();
		QueryRespBean<AssetsTdeviceAppproductDTO> queryRespBean = assetsTdeviceAppproductService
				.searchAssetsTdeviceAppproductByPage(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件Or分页查询
	 * @param queryReqBean 查询条件
	 * @param orderBy 排序
	 * @return ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPageOr/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>> searchByPageOr(
			QueryReqBean<AssetsTdeviceAppproductDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsTdeviceAppproductDTO>>();
		QueryRespBean<AssetsTdeviceAppproductDTO> queryRespBean = assetsTdeviceAppproductService
				.searchAssetsTdeviceAppproductByPageOr(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

}
