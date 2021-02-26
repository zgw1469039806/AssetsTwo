package avicit.assets.device.assetsstdtempacceptance.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import avicit.platform6.api.session.SessionHelper;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import avicit.assets.device.assetsstdtempacceptance.dto.AttInventoryDTO;
import avicit.assets.device.assetsstdtempacceptance.service.AssetsStdtempAcceptanceService;
import avicit.assets.device.assetsstdtempacceptance.service.AttInventoryService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-19 20:37
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsstdtempacceptance/AssetsStdtempAcceptanceRest")
public class AssetsStdtempAcceptanceRest{
    
	@Autowired
	private AssetsStdtempAcceptanceService assetsStdtempAcceptanceService;
	
	@Autowired
	private AttInventoryService attInventoryService;
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsStdtempAcceptanceDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsStdtempAcceptanceDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsStdtempAcceptanceDTO> responseMsg = new ResponseMsg<AssetsStdtempAcceptanceDTO>();
		AssetsStdtempAcceptanceDTO dto = assetsStdtempAcceptanceService.queryAssetsStdtempAcceptanceByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsStdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id =  assetsStdtempAcceptanceService.insertAssetsStdtempAcceptance(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsStdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsStdtempAcceptanceService.updateAssetsStdtempAcceptanceSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsStdtempAcceptanceDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsStdtempAcceptanceService.updateAssetsStdtempAcceptance(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsStdtempAcceptanceDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsStdtempAcceptanceDTO>> searchMainByPage(QueryReqBean<AssetsStdtempAcceptanceDTO> queryReqBean,String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsStdtempAcceptanceDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsStdtempAcceptanceDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    	    	    QueryRespBean<AssetsStdtempAcceptanceDTO> queryRespBean = assetsStdtempAcceptanceService.searchAssetsStdtempAcceptanceByPage(queryReqBean,sfnConditions);
	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsStdtempAcceptanceDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsStdtempAcceptanceDTO>> searchMain(QueryReqBean<AssetsStdtempAcceptanceDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsStdtempAcceptanceDTO>> responseMsg = new ResponseMsg<List<AssetsStdtempAcceptanceDTO>>();
		List<AssetsStdtempAcceptanceDTO> queryRespBean = assetsStdtempAcceptanceService.searchAssetsStdtempAcceptance(queryReqBean);
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
		int count = assetsStdtempAcceptanceService.deleteAssetsStdtempAcceptanceById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AttInventoryDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AttInventoryDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AttInventoryDTO>> responseMsg = new ResponseMsg<List<AttInventoryDTO>>();
		List<AttInventoryDTO> dto = attInventoryService.queryAttInventoryByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AttInventoryDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AttInventoryDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AttInventoryDTO> responseMsg = new ResponseMsg<AttInventoryDTO>();
		AttInventoryDTO dto = attInventoryService.queryAttInventoryByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AttInventoryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = attInventoryService.updateAttInventory(dto);
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
	public ResponseMsg<Integer> updateSubAll(AttInventoryDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = attInventoryService.updateAttInventorySensitive(dto);
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
		int count = attInventoryService.deleteAttInventoryById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
