package avicit.assets.furniture.assetsfurniturerecoveryproc.controller;

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

import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoveryProcService;
import avicit.assets.furniture.assetsfurniturerecoveryproc.service.AssetsFurnitureRecoverySubService;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoverySubDTO;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoveryProcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-18 08:50
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/furniture/assetsfurniturerecoveryproc/assetsFurnitureRecoveryProcController")
public class AssetsFurnitureRecoveryProcController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsFurnitureRecoveryProcController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsFurnitureRecoveryProcService assetsFurnitureRecoveryProcService;
	@Autowired

	private AssetsFurnitureRecoverySubService assetsFurnitureRecoverySubServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsFurnitureRecoveryProcManage")
	public ModelAndView toAssetsFurnitureRecoveryProcManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/furniture/assetsfurniturerecoveryproc/AssetsFurnitureRecoveryProcManage");
		mav.addObject("url",
				"platform/assets/furniture/assetsfurniturerecoveryproc/assetsFurnitureRecoveryProcController/operation/");
		mav.addObject("surl",
				"platform/assets/furniture/assetsfurniturerecoveryproc/assetsFurnitureRecoveryProcController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsFurnitureRecoveryProcsByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsFurnitureRecoveryProcByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsFurnitureRecoveryProcDTO> queryReqBean = new QueryReqBean<AssetsFurnitureRecoveryProcDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsFurnitureRecoveryProcDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureRecoveryProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureRecoveryProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsFurnitureRecoveryProcDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsFurnitureRecoveryProcDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsFurnitureRecoveryProcDTO>() {
					});
		} else {
			param = new AssetsFurnitureRecoveryProcDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsFurnitureRecoveryProcService.searchAssetsFurnitureRecoveryProcByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsFurnitureRecoveryProcService.searchAssetsFurnitureRecoveryProcByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsFurnitureRecoveryProcDTO dto : result.getResult()) {
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsFurnitureRecoveryProcDTO分页数据");
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
			AssetsFurnitureRecoveryProcDTO dto = assetsFurnitureRecoveryProcService
					.queryAssetsFurnitureRecoveryProcByPrimaryKey(id);
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
			mav.addObject("assetsFurnitureRecoveryProcDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/furniture/assetsfurniturerecoveryproc/" + "AssetsFurnitureRecoveryProc" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsFurnitureRecoveryProcDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsFurnitureRecoveryProcDTO>() {
					});
			List<AssetsFurnitureRecoverySubDTO> assetsFurnitureRecoverySubList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsFurnitureRecoverySubDTO>>() {
					});
			if (StringUtils.isEmpty(assetsFurnitureRecoveryProcDTO.getId())) {//新增
				assetsFurnitureRecoveryProcService.insertAssetsFurnitureRecoveryProc(assetsFurnitureRecoveryProcDTO);
			} else {//修改
				assetsFurnitureRecoveryProcService
						.updateAssetsFurnitureRecoveryProcSensitive(assetsFurnitureRecoveryProcDTO);
			}
			//子表业务操作
			assetsFurnitureRecoverySubServiceSub.insertOrUpdateAssetsFurnitureRecoverySub(
					assetsFurnitureRecoverySubList, assetsFurnitureRecoveryProcDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsFurnitureRecoveryProcDTO.getId());
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
	public ModelAndView toDeleteAssetsFurnitureRecoveryProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsFurnitureRecoveryProcService.deleteAssetsFurnitureRecoveryProcByIds(ids);
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
			AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProc = JsonHelper.getInstance().readValue(data,
					dateFormat, new TypeReference<AssetsFurnitureRecoveryProcDTO>() {
					});
			List<AssetsFurnitureRecoverySubDTO> assetsFurnitureRecoverySubList = JsonHelper.getInstance()
					.readValue(dataSub, dateFormat, new TypeReference<List<AssetsFurnitureRecoverySubDTO>>() {
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
			StartResultBean result = assetsFurnitureRecoveryProcService
					.insertAssetsFurnitureRecoveryProcAndStartProcess(assetsFurnitureRecoveryProc,
							assetsFurnitureRecoverySubList, parameter);

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
		AssetsFurnitureRecoveryProcDTO dto = assetsFurnitureRecoveryProcService
				.queryAssetsFurnitureRecoveryProcByPrimaryKey(id);

		dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

		dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
				SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsFurnitureRecoveryProcDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsFurnitureRecoverySub", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsFurnitureRecoverySubByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsFurnitureRecoverySubDTO> queryReqBean = new QueryReqBean<AssetsFurnitureRecoverySubDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsFurnitureRecoverySubDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureRecoverySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsFurnitureRecoverySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsFurnitureRecoverySubDTO param = null;
		QueryRespBean<AssetsFurnitureRecoverySubDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsFurnitureRecoverySubDTO>() {
			});
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsFurnitureRecoverySubDTO();
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsFurnitureRecoverySubServiceSub.searchAssetsFurnitureRecoverySubByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsFurnitureRecoverySubServiceSub.searchAssetsFurnitureRecoverySubByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsFurnitureRecoverySubDTO dto : result.getResult()) {

			dto.setFurnitureCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FURNITURE_CATEGORY",
					dto.getFurnitureCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));

			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));

			dto.setFurnitureStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FURNITURE_STATE",
					dto.getFurnitureState(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsFurnitureRecoverySubDTO分页数据");
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
			AssetsFurnitureRecoverySubDTO dto = assetsFurnitureRecoverySubServiceSub
					.queryAssetsFurnitureRecoverySubByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));
			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsFurnitureRecoverySubDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/furniture/assetsfurniturerecoveryproc/" + "AssetsFurnitureRecoverySub" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsFurnitureRecoverySubDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsFurnitureRecoverySubDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsFurnitureRecoverySubDTO>>() {
					});
			assetsFurnitureRecoverySubServiceSub.insertOrUpdateAssetsFurnitureRecoverySub(list, pid);
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
	public ModelAndView toDeleteAssetsFurnitureRecoverySubDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsFurnitureRecoverySubServiceSub.deleteAssetsFurnitureRecoverySubByIds(ids);
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
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
