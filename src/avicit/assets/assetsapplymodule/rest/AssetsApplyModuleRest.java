package avicit.assets.assetsapplymodule.rest;


import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.assets.assetsapplymodule.service.AssetsApplyModuleService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 14:22
 * @类说明：请填写
 * @修改记录： 
 */
@RestEasyController
@Path("/api/assets/assetsapplymodule/AssetsApplyModuleRest")
public class AssetsApplyModuleRest{
    private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsApplyModuleRest.class);
    
	@Autowired
	private AssetsApplyModuleService assetsApplyModuleService;
	
	
	
	
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
	public ResponseMsg<Integer> updateAll(AssetsApplyModuleDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = assetsApplyModuleService.updateAssetsApplyModule(dto);
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
		int count = assetsApplyModuleService.deleteAssetsApplyModuleById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 查询条件
	 * @param oderby 排序
	 * @return ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>> searchByPage(QueryReqBean<AssetsApplyModuleDTO> queryReqBean, String oderby) throws Exception {
		ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    	    	    QueryRespBean<AssetsApplyModuleDTO> queryRespBean = assetsApplyModuleService.searchAssetsApplyModuleByPage(queryReqBean,oderby);
	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按条件Or分页查询
	 * @param queryReqBean 查询条件
	 * @param oderby 排序
	 * @return ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>>
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPageOr/v1")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>> searchByPageOr(QueryReqBean<AssetsApplyModuleDTO> queryReqBean, String oderby) throws Exception {
		ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>> responseMsg = new ResponseMsg<QueryRespBean<AssetsApplyModuleDTO>>();
			    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    	    	    QueryRespBean<AssetsApplyModuleDTO> queryRespBean = assetsApplyModuleService.searchAssetsApplyModuleByPageOr(queryReqBean,oderby);
	    		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	
}
