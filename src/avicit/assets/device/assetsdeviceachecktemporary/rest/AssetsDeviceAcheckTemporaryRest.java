package avicit.assets.device.assetsdeviceachecktemporary.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.assets.device.assetsdeviceachecktemporary.service.AssetsDeviceAcheckTemporaryService;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 08:40
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdeviceachecktemporary/AssetsDeviceAcheckTemporaryRest")
public class AssetsDeviceAcheckTemporaryRest {

	@Autowired
	private AssetsDeviceAcheckTemporaryService assetsDeviceAcheckTemporaryService;

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
	public ResponseMsg<Integer> updateAll(AssetsDeviceAcheckTemporaryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceAcheckTemporaryService.updateAssetsDeviceAcheckTemporary(dto);
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
		int count = assetsDeviceAcheckTemporaryService.deleteAssetsDeviceAcheckTemporaryById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @param orderBy 排序
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>> searchByPage(
			QueryReqBean<AssetsDeviceAcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>>();
		QueryRespBean<AssetsDeviceAcheckTemporaryDTO> queryRespBean = assetsDeviceAcheckTemporaryService
				.searchAssetsDeviceAcheckTemporaryByPage(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件Or分页查询
	 * @param queryReqBean 查询条件
	 * @param orderBy 排序
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPageOr/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>> searchByPageOr(
			QueryReqBean<AssetsDeviceAcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceAcheckTemporaryDTO>>();
		QueryRespBean<AssetsDeviceAcheckTemporaryDTO> queryRespBean = assetsDeviceAcheckTemporaryService
				.searchAssetsDeviceAcheckTemporaryByPageOr(queryReqBean, orderBy);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

}
