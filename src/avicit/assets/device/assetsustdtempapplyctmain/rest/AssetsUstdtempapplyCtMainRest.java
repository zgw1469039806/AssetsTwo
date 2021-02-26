package avicit.assets.device.assetsustdtempapplyctmain.rest;

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

import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCtMainDTO;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCtMainService;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCollectService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 16:24
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/device/assetsustdtempapplyctmain/AssetsUstdtempapplyCtMainRest")
public class AssetsUstdtempapplyCtMainRest{
    
	@Autowired
	private AssetsUstdtempapplyCtMainService assetsUstdtempapplyCtMainService;
	
	@Autowired
	private AssetsUstdtempapplyCollectService assetsUstdtempapplyCollectService;
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return ResponseMsg<AssetsUstdtempapplyCtMainDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsUstdtempapplyCtMainDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsUstdtempapplyCtMainDTO> responseMsg = new ResponseMsg<AssetsUstdtempapplyCtMainDTO>();
		AssetsUstdtempapplyCtMainDTO dto = assetsUstdtempapplyCtMainService.queryAssetsUstdtempapplyCtMainByPrimaryKey(id);
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
	public ResponseMsg<String> saveMain(AssetsUstdtempapplyCtMainDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id =  assetsUstdtempapplyCtMainService.insertAssetsUstdtempapplyCtMain(dto);
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
	public ResponseMsg<Integer> updateMainSensitive(AssetsUstdtempapplyCtMainDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempapplyCtMainService.updateAssetsUstdtempapplyCtMainSensitive(dto);
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
	public ResponseMsg<Integer> updateMainAll(AssetsUstdtempapplyCtMainDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempapplyCtMainService.updateAssetsUstdtempapplyCtMain(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean 分页
	 * @param sfnConditions 查询条件
	 * @return ResponseMsg<QueryRespBean<AssetsUstdtempapplyCtMainDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsUstdtempapplyCtMainDTO>> searchMainByPage(QueryReqBean<AssetsUstdtempapplyCtMainDTO> queryReqBean,String sfnConditions) throws Exception {
		ResponseMsg<QueryRespBean<AssetsUstdtempapplyCtMainDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsUstdtempapplyCtMainDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    		QueryRespBean<AssetsUstdtempapplyCtMainDTO> queryRespBean = assetsUstdtempapplyCtMainService.searchAssetsUstdtempapplyCtMainByPage(queryReqBean,sfnConditions,SessionHelper.getCurrentOrgIdentity());
					    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean 分页
	 * @return ResponseMsg<List<AssetsUstdtempapplyCtMainDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsUstdtempapplyCtMainDTO>> searchMain(QueryReqBean<AssetsUstdtempapplyCtMainDTO> queryReqBean) throws Exception {
		ResponseMsg<List<AssetsUstdtempapplyCtMainDTO>> responseMsg = new ResponseMsg<List<AssetsUstdtempapplyCtMainDTO>>();
		List<AssetsUstdtempapplyCtMainDTO> queryRespBean = assetsUstdtempapplyCtMainService.searchAssetsUstdtempapplyCtMain(queryReqBean);
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
		int count = assetsUstdtempapplyCtMainService.deleteAssetsUstdtempapplyCtMainById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	//*********************************子表操作*********************************************

	/**
	 * 按照父id获得子表数据
	 * @param pid 父id
	 * @return ResponseMsg<List<AssetsUstdtempapplyCollectDTO>>
	 * @throws Exception
	 */
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<AssetsUstdtempapplyCollectDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<AssetsUstdtempapplyCollectDTO>> responseMsg = new ResponseMsg<List<AssetsUstdtempapplyCollectDTO>>();
		List<AssetsUstdtempapplyCollectDTO> dto = assetsUstdtempapplyCollectService.queryAssetsUstdtempapplyCollectByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	/**
	 * 通过子表id获得数据
	 * @param id 主键id
	 * @return ResponseMsg<AssetsUstdtempapplyCollectDTO>
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<AssetsUstdtempapplyCollectDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<AssetsUstdtempapplyCollectDTO> responseMsg = new ResponseMsg<AssetsUstdtempapplyCollectDTO>();
		AssetsUstdtempapplyCollectDTO dto = assetsUstdtempapplyCollectService.queryAssetsUstdtempapplyCollectByPrimaryKey(id);
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
	public ResponseMsg<Integer> updateSubSensitive(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempapplyCollectService.updateAssetsUstdtempapplyCollect(dto);
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
	public ResponseMsg<Integer> updateSubAll(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsUstdtempapplyCollectService.updateAssetsUstdtempapplyCollectSensitive(dto);
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
		int count = assetsUstdtempapplyCollectService.deleteAssetsUstdtempapplyCollectById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
