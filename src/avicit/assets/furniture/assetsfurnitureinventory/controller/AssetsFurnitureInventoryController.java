package avicit.assets.furniture.assetsfurnitureinventory.controller;

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

import avicit.assets.furniture.assetsfurnitureinventory.service.AssetsFurnitureInventoryService;
import avicit.assets.furniture.assetsfurnitureinventory.service.AssetsFurnitureInventorySubService;
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventorySubDTO;
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventoryDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:15
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController")
public class AssetsFurnitureInventoryController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsFurnitureInventoryController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsFurnitureInventoryService assetsFurnitureInventoryService;
	@Autowired

	private AssetsFurnitureInventorySubService assetsFurnitureInventorySubServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsFurnitureInventoryManage")
	public ModelAndView toAssetsFurnitureInventoryManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/furniture/assetsfurnitureinventory/AssetsFurnitureInventoryManage");
		mav.addObject("url",
				"platform/assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/");
		mav.addObject("surl",
				"platform/assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsFurnitureInventorysByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsFurnitureInventoryByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsFurnitureInventoryDTO> queryReqBean = new QueryReqBean<AssetsFurnitureInventoryDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsFurnitureInventoryDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureInventoryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureInventoryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsFurnitureInventoryDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsFurnitureInventoryDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsFurnitureInventoryDTO>() {
					});
		} else {
			param = new AssetsFurnitureInventoryDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsFurnitureInventoryService.searchAssetsFurnitureInventoryByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsFurnitureInventoryService.searchAssetsFurnitureInventoryByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsFurnitureInventoryDTO dto : result.getResult()) {
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsFurnitureInventoryDTO分页数据");
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
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//主表数据
			AssetsFurnitureInventoryDTO dto = assetsFurnitureInventoryService
					.queryAssetsFurnitureInventoryByPrimaryKey(id);
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> furnitureCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("FURNITURE_CATEGORY", appId);
			HashMap<String, String> furnitureCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : furnitureCategoryList) {
				furnitureCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("furnitureCategoryData", JsonHelper.getInstance().writeValueAsString(furnitureCategoryMap));
			Collection<SysLookupSimpleVo> furnitureStateList = sysLookupLoader
					.getLookUpListByTypeByAppId("FURNITURE_STATE", appId);
			HashMap<String, String> furnitureStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : furnitureStateList) {
				furnitureStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("furnitureStateData", JsonHelper.getInstance().writeValueAsString(furnitureStateMap));
			Collection<SysLookupSimpleVo> inventoryStateList = sysLookupLoader
					.getLookUpListByTypeByAppId("INVENTORY_STATE", appId);
			HashMap<String, String> inventoryStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : inventoryStateList) {
				inventoryStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("inventoryStateData", JsonHelper.getInstance().writeValueAsString(inventoryStateMap));
			Collection<SysLookupSimpleVo> inventoryResultList = sysLookupLoader
					.getLookUpListByTypeByAppId("INVENTORY_RESULT", appId);
			HashMap<String, String> inventoryResultMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : inventoryResultList) {
				inventoryResultMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("inventoryResultData", JsonHelper.getInstance().writeValueAsString(inventoryResultMap));
			mav.addObject("assetsFurnitureInventoryDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/furniture/assetsfurnitureinventory/" + "AssetsFurnitureInventory" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsFurnitureInventoryDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsFurnitureInventoryDTO>() {
					});
			List<AssetsFurnitureInventorySubDTO> assetsFurnitureInventorySubList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsFurnitureInventorySubDTO>>() {
					});
			if(assetsFurnitureInventorySubList==null||assetsFurnitureInventorySubList.size()<=0){
				mav.addObject("flag", OpResult.failure);
				return mav;
			}
			if (StringUtils.isEmpty(assetsFurnitureInventoryDTO.getId())) {//新增
				assetsFurnitureInventoryService.insertAssetsFurnitureInventory(assetsFurnitureInventoryDTO);
			} else {//修改
				assetsFurnitureInventoryService.updateAssetsFurnitureInventorySensitive(assetsFurnitureInventoryDTO);
			}
			//子表业务操作
			assetsFurnitureInventorySubServiceSub.insertOrUpdateAssetsFurnitureInventorySub(
					assetsFurnitureInventorySubList, assetsFurnitureInventoryDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsFurnitureInventoryDTO.getId());
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 保存数据（生成表单）
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save01", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsFurnitureInventoryDTO01(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsFurnitureInventoryDTO>() {
					});
			List<AssetsFurnitureInventorySubDTO> assetsFurnitureInventorySubList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsFurnitureInventorySubDTO>>() {
					});
			if(assetsFurnitureInventorySubList==null||assetsFurnitureInventorySubList.size()<=0){
				mav.addObject("flag", OpResult.failure);
				return mav;
			}
			if (StringUtils.isEmpty(assetsFurnitureInventoryDTO.getId())) {//新增
				assetsFurnitureInventoryService.insertAssetsFurnitureInventory(assetsFurnitureInventoryDTO);
			} else {//修改
				assetsFurnitureInventoryService.updateAssetsFurnitureInventorySensitive(assetsFurnitureInventoryDTO);
			}
			//子表业务操作
			assetsFurnitureInventorySubServiceSub.insertOrUpdateAssetsFurnitureInventorySub01(
					assetsFurnitureInventorySubList, assetsFurnitureInventoryDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsFurnitureInventoryDTO.getId());
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
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsFurnitureInventoryDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsFurnitureInventoryService.deleteAssetsFurnitureInventoryByIds(ids);
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
	@RequestMapping(value = "/operation/saveAndStartProcess", method = RequestMethod.POST)
	public ModelAndView saveAndStartProcess(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		String processDefId = ServletRequestUtils.getStringParameter(request, "processDefId", "");
		String formCode = ServletRequestUtils.getStringParameter(request, "formCode", "");
		String jsonString = ServletRequestUtils.getStringParameter(request, "jsonString", "");
		//主表数据
		String data = ServletRequestUtils.getStringParameter(request, "data", "");
		//子表数据
		String dataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsFurnitureInventoryDTO assetsFurnitureInventory = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsFurnitureInventoryDTO>() {
					});
			List<AssetsFurnitureInventorySubDTO> assetsFurnitureInventorySubList = JsonHelper.getInstance()
					.readValue(dataSub, dateFormat, new TypeReference<List<AssetsFurnitureInventorySubDTO>>() {
					});
			String userId = SessionHelper.getLoginSysUserId(request);
			String deptId = SessionHelper.getCurrentDeptId(request);
			/////////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);
			StartResultBean result = assetsFurnitureInventoryService.insertAssetsFurnitureInventoryAndStartProcess(
					assetsFurnitureInventory, assetsFurnitureInventorySubList, parameter);

			mav.addObject("flag", OpResult.success);
			mav.addObject("startResult", result);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
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
		AssetsFurnitureInventoryDTO dto = assetsFurnitureInventoryService.queryAssetsFurnitureInventoryByPrimaryKey(id);

		dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

		dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
				SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsFurnitureInventoryDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsFurnitureInventorySub", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsFurnitureInventorySubByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsFurnitureInventorySubDTO> queryReqBean = new QueryReqBean<AssetsFurnitureInventorySubDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");

		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!"".equals(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsFurnitureInventorySubDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureInventorySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureInventorySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsFurnitureInventorySubDTO param = null;
		QueryRespBean<AssetsFurnitureInventorySubDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsFurnitureInventorySubDTO>() {
			});
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsFurnitureInventorySubDTO();
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsFurnitureInventorySubServiceSub.searchAssetsFurnitureInventorySubByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsFurnitureInventorySubServiceSub.searchAssetsFurnitureInventorySubByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsFurnitureInventorySubDTO dto : result.getResult()) {

			dto.setFurnitureCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FURNITURE_CATEGORY",
					dto.getFurnitureCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setFurnitureStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FURNITURE_STATE",
					dto.getFurnitureState(), sysApplicationAPI.getCurrentAppId()));

			dto.setInventoryPersonAlias(sysUserLoader.getSysUserNameById(dto.getInventoryPerson()));

			dto.setInventoryDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getInventoryDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setInventoryStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INVENTORY_STATE",
					dto.getInventoryState(), sysApplicationAPI.getCurrentAppId()));

			dto.setInventoryResultName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INVENTORY_RESULT",
					dto.getInventoryResult(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsFurnitureInventorySubDTO分页数据");
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
	@RequestMapping(value = "/operation/sub/{type}/{id}")
	public ModelAndView toOpertionSubPage(@PathVariable String type, @PathVariable String id,
			HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//主表数据
			AssetsFurnitureInventorySubDTO dto = assetsFurnitureInventorySubServiceSub
					.queryAssetsFurnitureInventorySubByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setInventoryPersonAlias(sysUserLoader.getSysUserNameById(dto.getInventoryPerson()));
			dto.setInventoryDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getInventoryDept(),
					SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsFurnitureInventorySubDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/furniture/assetsfurnitureinventory/" + "AssetsFurnitureInventorySub" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsFurnitureInventorySubDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsFurnitureInventorySubDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsFurnitureInventorySubDTO>>() {
					});
			assetsFurnitureInventorySubServiceSub.insertOrUpdateAssetsFurnitureInventorySub(list, pid);
			return new AvicitResponseBody(OpResult.success);
		} catch (Exception ex) {
			return new AvicitResponseBody(OpResult.failure, ex.getMessage());
		}
	}

	/**
	 * 按照id批量删除数据
	 * @param ids id数组
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsFurnitureInventorySubDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsFurnitureInventorySubServiceSub.deleteAssetsFurnitureInventorySubByIds(ids);
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
			Collection<SysLookupSimpleVo> furnitureCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("FURNITURE_CATEGORY", appId);
			HashMap<String, String> furnitureCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : furnitureCategoryList) {
				furnitureCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("furnitureCategoryData", JsonHelper.getInstance().writeValueAsString(furnitureCategoryMap));
			Collection<SysLookupSimpleVo> furnitureStateList = sysLookupLoader
					.getLookUpListByTypeByAppId("FURNITURE_STATE", appId);
			HashMap<String, String> furnitureStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : furnitureStateList) {
				furnitureStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("furnitureStateData", JsonHelper.getInstance().writeValueAsString(furnitureStateMap));
			Collection<SysLookupSimpleVo> inventoryStateList = sysLookupLoader
					.getLookUpListByTypeByAppId("INVENTORY_STATE", appId);
			HashMap<String, String> inventoryStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : inventoryStateList) {
				inventoryStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("inventoryStateData", JsonHelper.getInstance().writeValueAsString(inventoryStateMap));
			Collection<SysLookupSimpleVo> inventoryResultList = sysLookupLoader
					.getLookUpListByTypeByAppId("INVENTORY_RESULT", appId);
			HashMap<String, String> inventoryResultMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : inventoryResultList) {
				inventoryResultMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("inventoryResultData", JsonHelper.getInstance().writeValueAsString(inventoryResultMap));
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
