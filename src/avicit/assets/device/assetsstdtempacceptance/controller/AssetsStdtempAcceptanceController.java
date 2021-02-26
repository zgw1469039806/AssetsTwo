package avicit.assets.device.assetsstdtempacceptance.controller;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Collection;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import avicit.platform6.api.session.SessionHelper;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.core.web.AvicitResponseBody;

import avicit.assets.device.assetsstdtempacceptance.service.AssetsStdtempAcceptanceService;
import avicit.assets.device.assetsstdtempacceptance.service.AttInventoryService;
import avicit.assets.device.assetsstdtempacceptance.dto.AttInventoryDTO;
import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-19 20:37
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController")
public class AssetsStdtempAcceptanceController  implements LoaderConstant{
    private static final Logger logger =  LoggerFactory.getLogger( AssetsStdtempAcceptanceController.class);
    
    @Autowired
	private  SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsStdtempAcceptanceService  assetsStdtempAcceptanceService;
    @Autowired

    private AttInventoryService attInventoryServiceSub;	
    /**
     * 跳转到管理页面
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value="toAssetsStdtempAcceptanceManage")
	public ModelAndView toAssetsStdtempAcceptanceManage(HttpServletRequest request,HttpServletResponse reponse){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsstdtempacceptance/AssetsStdtempAcceptanceManage");
		mav.addObject("url", "platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/");
		mav.addObject("surl", "platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/sub/");
		return mav;
	}
	    
    /**
  	 * 分页查询方法
  	 * @param pageParameter 查询条件
  	 * @param request 请求
  	 * @return Map<String,Object>
  	 */
    @RequestMapping(value="/operation/getAssetsStdtempAcceptancesByPage")    
	@ResponseBody
	public Map<String,Object> toGetAssetsStdtempAcceptanceByPage(PageParameter pageParameter,HttpServletRequest request){
		QueryReqBean<AssetsStdtempAcceptanceDTO> queryReqBean = new QueryReqBean<AssetsStdtempAcceptanceDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String,Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if(!StringUtils.isEmpty(keyWord)){
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if(sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)){
		    cloumnName = ComUtil.getColumn(AssetsStdtempAcceptanceDTO.class, sidx);
			if(cloumnName != null){//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			}else{
				//判断是否为特殊控件导致字段无法匹配
				if(sidx.indexOf("Alias")!=-1){
					cloumnName = ComUtil.getColumn(AssetsStdtempAcceptanceDTO.class, sidx.substring(0,sidx.lastIndexOf("Alias")));
				}else if(sidx.indexOf("Name")!=-1){
					cloumnName = ComUtil.getColumn(AssetsStdtempAcceptanceDTO.class, sidx.substring(0,sidx.lastIndexOf("Name")));
				}
				if(cloumnName != null){
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsStdtempAcceptanceDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsStdtempAcceptanceDTO> result =null;
		if(json!= null && !"".equals(json)){
			param = JsonHelper.getInstance().readValue(json,dateFormat, new TypeReference<AssetsStdtempAcceptanceDTO>(){});
		}else{
			param = new AssetsStdtempAcceptanceDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
																																																																																																																																																																																																																																																																																																																																																																																																																																																																															if(!"".equals(keyWord)){
				  	  result = assetsStdtempAcceptanceService.searchAssetsStdtempAcceptanceByPageOr(queryReqBean, orderBy); 
				  }else{
				  	  result = assetsStdtempAcceptanceService.searchAssetsStdtempAcceptanceByPage(queryReqBean, orderBy); 
				  }
		 			} catch (Exception ex) {
			return map;  
		}
		for(AssetsStdtempAcceptanceDTO dto :result.getResult()){
					  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  		    				  			}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsStdtempAcceptanceDTO分页数据");
		return map;
	}    
    
    /**
     * 根据id选择跳转到新建页还是编辑页
     * @param type 操作类型新建还是编辑
     * @param id 编辑数据的id
     * @param request 请求
     * @return ModelAndView
     * @throws Exception
     */
  	@RequestMapping(value="/operation/{type}/{id}")
  	public ModelAndView toOpertionPage(@PathVariable String type,
  										@PathVariable String id,
  										HttpServletRequest request)throws Exception{
  		ModelAndView mav= new ModelAndView();
  		if(!"Add".equals(type)){//编辑窗口或者详细页窗口
  			//主表数据
  			AssetsStdtempAcceptanceDTO dto = assetsStdtempAcceptanceService.queryAssetsStdtempAcceptanceByPrimaryKey(id);
  					  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  			  	
		  	  			String appId = sysApplicationAPI.getCurrentAppId();
  				  	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	  			mav.addObject("assetsStdtempAcceptanceDTO", dto);
  			mav.addObject("id", id);
  		}
  		mav.setViewName("avicit/assets/device/assetsstdtempacceptance/"+"AssetsStdtempAcceptance"+type);
  		return mav;
  	} 
  	   
  	/**
  	 * 保存数据
  	 * @param request 请求
  	 * @return ModelAndView
  	 */
  	@RequestMapping(value="/operation/save",method=RequestMethod.POST)
	public ModelAndView toSaveAssetsStdtempAcceptanceDTO(HttpServletRequest request){
		ModelAndView mav= new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO = JsonHelper.getInstance().readValue(jsonData,dateFormat,new TypeReference<AssetsStdtempAcceptanceDTO>(){});
			if(StringUtils.isEmpty(assetsStdtempAcceptanceDTO.getId())){//新增
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																															assetsStdtempAcceptanceService.insertAssetsStdtempAcceptance(assetsStdtempAcceptanceDTO);
			}else{//修改
				assetsStdtempAcceptanceService.updateAssetsStdtempAcceptanceSensitive(assetsStdtempAcceptanceDTO);
			}
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsStdtempAcceptanceDTO.getId());
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;  
		}
		return mav;
	}
		
  	/**
  	 * 按照id批量删除数据
  	 * @param ids id数组
  	 * @param request 请求
  	 * @return ModelAndView
  	 */
  	@RequestMapping(value="/operation/delete",method=RequestMethod.POST)
	public ModelAndView toDeleteAssetsStdtempAcceptanceDTO(@RequestBody String[] ids,HttpServletRequest request){
		ModelAndView mav= new ModelAndView();
		try {
			assetsStdtempAcceptanceService.deleteAssetsStdtempAcceptanceByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	/**
  	 * 新增并启动流程
  	 * @param request 请求
  	 * @return ModelAndView
  	 */
  	@RequestMapping(value="/operation/saveAndStartProcess",method=RequestMethod.POST)
  	public ModelAndView saveAndStartProcess(HttpServletRequest request){
  		ModelAndView mav= new ModelAndView();
  		
		String processDefId = ServletRequestUtils.getStringParameter(request, "processDefId", "");
		String formCode = ServletRequestUtils.getStringParameter(request, "formCode", "");
		String jsonString = ServletRequestUtils.getStringParameter(request, "jsonString", "");
		String data = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsStdtempAcceptanceDTO assetsStdtempAcceptance = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<AssetsStdtempAcceptanceDTO>(){});
			String userId = SessionHelper.getLoginSysUserId(request);
			String deptId = SessionHelper.getCurrentDeptId(request);
			/////////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String,Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		StartResultBean result = assetsStdtempAcceptanceService.insertAssetsStdtempAcceptanceAndStartProcess(assetsStdtempAcceptance,  parameter);
			
			mav.addObject("flag",OpResult.success);
			mav.addObject("startResult", result);
		} catch (Exception ex) {
			mav.addObject("flag",OpResult.failure);
		}
  		return mav;
  	}
  	
  	  	/**
	 * 跳转detail页面
	 * @param request 求情
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/toDetailJsp")
	public ModelAndView toDetailJsp(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		AssetsStdtempAcceptanceDTO dto = assetsStdtempAcceptanceService.queryAssetsStdtempAcceptanceByPrimaryKey(id);
        	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	    					
    			    		
	  	        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsStdtempAcceptanceDTO", dto);
        
		return mav;
	}
		
  	/****************************子表操作*****************************
  	/**
  	 * 按照pid查找子表数据
  	 * @param pageParameter 查询条件
  	 * @param request 请求
  	 * @return Map<String,Object>
  	 */
      	@RequestMapping(value="/operation/sub/getAttInventory",method=RequestMethod.POST)
  	@ResponseBody
	public Map<String,Object> toGetAttInventoryByPid(PageParameter pageParameter, HttpServletRequest request){
		QueryReqBean<AttInventoryDTO> queryReqBean = new QueryReqBean<AttInventoryDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String,Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if(!"".equals(keyWord)){
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if(sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)){
		    cloumnName = ComUtil.getColumn(AttInventoryDTO.class, sidx);
			if(cloumnName != null){//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			}else{
				//判断是否为特殊控件导致字段无法匹配
				if(sidx.indexOf("Alias")!=-1){
					cloumnName = ComUtil.getColumn(AttInventoryDTO.class, sidx.substring(0,sidx.lastIndexOf("Alias")));
				}else if(sidx.indexOf("Name")!=-1){
					cloumnName = ComUtil.getColumn(AttInventoryDTO.class, sidx.substring(0,sidx.lastIndexOf("Name")));
				}
				if(cloumnName != null){
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AttInventoryDTO param = null;
		QueryRespBean<AttInventoryDTO> result =null;
		
		if(pid == null || "".equals(pid)){
			pid = "-1";
		}
		if(json!= null && !"".equals(json)){
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AttInventoryDTO>(){});
			param.setFkSubColId(pid);
			queryReqBean.setSearchParams(param);
		}else{
			param = new AttInventoryDTO();
			param.setFkSubColId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if(!"".equals(keyWord)){
				result = attInventoryServiceSub.searchAttInventoryByPageOr(queryReqBean, orderBy);
			}else{
				result = attInventoryServiceSub.searchAttInventoryByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;  
		}
		
		for(AttInventoryDTO dto :result.getResult()){
					  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  		    				    		
		  			}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AttInventoryDTO分页数据");
		return map;
	}	
	
  	/**
     * 根据id选择跳转到新建页还是编辑页
     * @param type 操作类型新建还是编辑
     * @param id 编辑数据的id
     * @param request 请求
     * @return ModelAndView
     * @throws Exception
     */
  	@RequestMapping(value="/operation/sub/{type}/{id}")
  	public ModelAndView toOpertionSubPage(@PathVariable String type,
  										@PathVariable String id,
  										HttpServletRequest request)throws Exception{
  		ModelAndView mav= new ModelAndView();
  		if(!"Add".equals(type)){//编辑窗口或者详细页窗口
  			//主表数据
  			AttInventoryDTO dto = attInventoryServiceSub.queryAttInventoryByPrimaryKey(id);
  			
  					  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  		    			    				  	  			mav.addObject("attInventoryDTO", dto);
  		}else{
  			mav.addObject("pid", id);
  		}
  		mav.setViewName("avicit/assets/device/assetsstdtempacceptance/"+"AttInventory"+type);
  		return mav;
  	}	
  	
  	/**
  	 * 保存数据
  	 * @param request 请求
  	 * @return ModelAndView
  	 */
  	@RequestMapping(value="/operation/sub/save",method=RequestMethod.POST)
	public AvicitResponseBody toSaveAttInventoryDTO(HttpServletRequest request){  		
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if("".equals(datas)){
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AttInventoryDTO> list = JsonHelper.getInstance().readValue(datas,dateFormat, new TypeReference<List<AttInventoryDTO>>(){});
			attInventoryServiceSub.insertOrUpdateAttInventory(list, pid);
			return new AvicitResponseBody(OpResult.success);
		} catch (Exception ex) {
			return new AvicitResponseBody(OpResult.failure,ex.getMessage());
		}
	}
		
  	/**
  	 * 按照id批量删除数据
  	 * @param ids id数组
  	 * @param request 请求
  	 * @return ModelAndView
  	 */
  	@RequestMapping(value="/operation/sub/delete",method=RequestMethod.POST)
	public ModelAndView toDeleteAttInventoryDTO(@RequestBody String[] ids,HttpServletRequest request){
		ModelAndView mav= new ModelAndView();
		try {
			attInventoryServiceSub.deleteAttInventoryByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	/*
	 * 通用代码  radio checkbox
	 * @param request请求
	 * @return ModelAndView
	 * */
	@RequestMapping(value = "/getLookUpCode")
	public ModelAndView getLookUpCode(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
	 try {		
		   		 String appId = sysApplicationAPI.getCurrentAppId();
  				  	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    	    		    			mav.addObject("flag", OpResult.success);
	 }catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}	

}
