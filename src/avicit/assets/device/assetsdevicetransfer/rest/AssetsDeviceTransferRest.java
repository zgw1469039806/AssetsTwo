package avicit.assets.device.assetsdevicetransfer.rest;

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

import avicit.assets.device.assetsdevicetransfer.dto.AssetsDeviceTransferDTO;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;
import avicit.assets.device.assetsdevicetransfer.service.AssetsDeviceTransferService;
import avicit.assets.device.assetsdevicetransfer.service.AssetsTransferprocDeviceService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsdevicetransfer/AssetsDeviceTransferRest")
public class AssetsDeviceTransferRest {

	@Autowired
	private AssetsDeviceTransferService assetsDeviceTransferService;

	@Autowired
	private AssetsTransferprocDeviceService assetsTransferprocDeviceService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsDeviceTransferDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsDeviceTransferDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsDeviceTransferDTO> responseMsg = new ResponseMsg<AssetsDeviceTransferDTO>();
		AssetsDeviceTransferDTO dto = assetsDeviceTransferService.queryAssetsDeviceTransferByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsDeviceTransferDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsDeviceTransferService.insertAssetsDeviceTransfer(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsDeviceTransferDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceTransferService.updateAssetsDeviceTransferSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsDeviceTransferDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsDeviceTransferService.updateAssetsDeviceTransfer(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsDeviceTransferDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsDeviceTransferDTO>> searchMainByPage(
			QueryReqBean<AssetsDeviceTransferDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsDeviceTransferDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsDeviceTransferDTO>>();
		QueryRespBean<AssetsDeviceTransferDTO> queryRespBean = assetsDeviceTransferService
				.searchAssetsDeviceTransferByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsDeviceTransferDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsDeviceTransferDTO>> searchMain(QueryReqBean<AssetsDeviceTransferDTO> queryReqBean)
			throws Exception {
		ResponseMsg<List<AssetsDeviceTransferDTO>> responseMsg = new ResponseMsg<List<AssetsDeviceTransferDTO>>();
		List<AssetsDeviceTransferDTO> queryRespBean = assetsDeviceTransferService
				.searchAssetsDeviceTransfer(queryReqBean);
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
		int count = assetsDeviceTransferService.deleteAssetsDeviceTransferById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsTransferprocDeviceDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsTransferprocDeviceDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsTransferprocDeviceDTO>> responseMsg = new ResponseMsg<List<AssetsTransferprocDeviceDTO>>();
		List<AssetsTransferprocDeviceDTO> dto = assetsTransferprocDeviceService.queryAssetsTransferprocDeviceByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsTransferprocDeviceDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsTransferprocDeviceDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsTransferprocDeviceDTO> responseMsg = new ResponseMsg<AssetsTransferprocDeviceDTO>();
		AssetsTransferprocDeviceDTO dto = assetsTransferprocDeviceService.queryAssetsTransferprocDeviceByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsTransferprocDeviceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsTransferprocDeviceService.updateAssetsTransferprocDevice(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsTransferprocDeviceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsTransferprocDeviceService.updateAssetsTransferprocDeviceSensitive(dto);
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
		int count = assetsTransferprocDeviceService.deleteAssetsTransferprocDeviceById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
