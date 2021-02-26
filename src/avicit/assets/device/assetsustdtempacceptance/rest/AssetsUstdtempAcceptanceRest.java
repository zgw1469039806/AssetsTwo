package avicit.assets.device.assetsustdtempacceptance.rest;

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

import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempacceptance.dto.AcceptanceDeviceComponentDTO;
import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.assets.device.assetsustdtempacceptance.service.AcceptanceDeviceComponentService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-02 14:46
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsustdtempacceptance/AssetsUstdtempAcceptanceRest")
public class AssetsUstdtempAcceptanceRest {

	@Autowired
	private AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService;

	@Autowired
	private AcceptanceDeviceComponentService acceptanceDeviceComponentService;

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsUstdtempAcceptanceDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsUstdtempAcceptanceDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsUstdtempAcceptanceDTO> responseMsg = new ResponseMsg<AssetsUstdtempAcceptanceDTO>();
		AssetsUstdtempAcceptanceDTO dto = assetsUstdtempAcceptanceService.queryAssetsUstdtempAcceptanceByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsUstdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = assetsUstdtempAcceptanceService.insertAssetsUstdtempAcceptance(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsUstdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptanceSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsUstdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptance(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsUstdtempAcceptanceDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsUstdtempAcceptanceDTO>> searchMainByPage(
			QueryReqBean<AssetsUstdtempAcceptanceDTO> queryReqBean, String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsUstdtempAcceptanceDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsUstdtempAcceptanceDTO>>();
		QueryRespBean<AssetsUstdtempAcceptanceDTO> queryRespBean = assetsUstdtempAcceptanceService
				.searchAssetsUstdtempAcceptanceByPage(queryReqBean, sfnConditions);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}

	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsUstdtempAcceptanceDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsUstdtempAcceptanceDTO>> searchMain(
			QueryReqBean<AssetsUstdtempAcceptanceDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsUstdtempAcceptanceDTO>> responseMsg = new ResponseMsg<List<AssetsUstdtempAcceptanceDTO>>();
		List<AssetsUstdtempAcceptanceDTO> queryRespBean = assetsUstdtempAcceptanceService
				.searchAssetsUstdtempAcceptance(queryReqBean);
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
		int count = assetsUstdtempAcceptanceService.deleteAssetsUstdtempAcceptanceById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}

	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AcceptanceDeviceComponentDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AcceptanceDeviceComponentDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AcceptanceDeviceComponentDTO>> responseMsg = new ResponseMsg<List<AcceptanceDeviceComponentDTO>>();
		List<AcceptanceDeviceComponentDTO> dto = acceptanceDeviceComponentService
				.queryAcceptanceDeviceComponentByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}

	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AcceptanceDeviceComponentDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AcceptanceDeviceComponentDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AcceptanceDeviceComponentDTO> responseMsg = new ResponseMsg<AcceptanceDeviceComponentDTO>();
		AcceptanceDeviceComponentDTO dto = acceptanceDeviceComponentService
				.queryAcceptanceDeviceComponentByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AcceptanceDeviceComponentDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = acceptanceDeviceComponentService.updateAcceptanceDeviceComponent(dto);
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
	public ResponseMsg<Integer> updateSubAll(AcceptanceDeviceComponentDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = acceptanceDeviceComponentService.updateAcceptanceDeviceComponentSensitive(dto);
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
		int count = acceptanceDeviceComponentService.deleteAcceptanceDeviceComponentById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
