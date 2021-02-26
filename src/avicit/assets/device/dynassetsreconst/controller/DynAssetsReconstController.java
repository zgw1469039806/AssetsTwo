package avicit.assets.device.dynassetsreconst.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Collection;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsreconstructioncheck.dto.AssetsReconstructionCheckDTO;
import avicit.assets.device.assetsreconstructioncheck.service.AssetsReconstructionCheckService;
import avicit.assets.device.dynassetsreconst.dto.AssetsReconstructionRDTO;
import avicit.assets.device.dynassetsreconst.service.AssetsReconstructionRService;
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

import avicit.assets.device.dynassetsreconst.service.DynAssetsReconstService;
import avicit.assets.device.dynassetsreconst.dto.DynAssetsReconstDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:03
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynassetsreconst/dynAssetsReconstController")
public class DynAssetsReconstController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(DynAssetsReconstController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private DynAssetsReconstService dynAssetsReconstService;
	@Autowired

	private AssetsReconstructionCheckService assetsReconstructionCheckServiceSub;

	@Autowired

	private AssetsReconstructionRService assetsReconstructionRServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toDynAssetsReconstManage")
	public ModelAndView toDynAssetsReconstManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/dynassetsreconst/DynAssetsReconstManage");
		mav.addObject("url", "platform/assets/device/dynassetsreconst/dynAssetsReconstController/operation/");
		mav.addObject("surl", "platform/assets/device/dynassetsreconst/dynAssetsReconstController/operation/sub/");
		mav.addObject("surl2", "platform/assets/device/dynassetsreconst/dynAssetsReconstController/operation/sub2/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getDynAssetsReconstsByPage")
	@ResponseBody
	public Map<String, Object> toGetDynAssetsReconstByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DynAssetsReconstDTO> queryReqBean = new QueryReqBean<DynAssetsReconstDTO>();
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
			cloumnName = ComUtil.getColumn(DynAssetsReconstDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynAssetsReconstDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynAssetsReconstDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		DynAssetsReconstDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<DynAssetsReconstDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynAssetsReconstDTO>() {
			});
		} else {
			param = new DynAssetsReconstDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = dynAssetsReconstService.searchDynAssetsReconstByPageOr(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			} else {
				result = dynAssetsReconstService.searchDynAssetsReconstByPage(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (DynAssetsReconstDTO dto : result.getResult()) {
			dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
			dto.setDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DynAssetsReconstDTO分页数据");
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
			DynAssetsReconstDTO dto = dynAssetsReconstService.queryDynAssetsReconstByPrimaryKey(id);
			dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
			dto.setDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
			HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceCategoryList) {
				deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
			mav.addObject("dynAssetsReconstDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/dynassetsreconst/" + "DynAssetsReconst" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveDynAssetsReconstDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			DynAssetsReconstDTO dynAssetsReconstDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<DynAssetsReconstDTO>() {
					});
			List<AssetsReconstructionCheckDTO> assetsReconstructionCheckList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsReconstructionCheckDTO>>() {
					});
			if (StringUtils.isEmpty(dynAssetsReconstDTO.getId())) {//新增
				dynAssetsReconstDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
				dynAssetsReconstService.insertDynAssetsReconst(dynAssetsReconstDTO);
			} else {//修改
				dynAssetsReconstService.updateDynAssetsReconstSensitive(dynAssetsReconstDTO);
			}
			//子表业务操作
			assetsReconstructionCheckServiceSub.insertOrUpdateAssetsReconstructionCheck(assetsReconstructionCheckList,
					dynAssetsReconstDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", dynAssetsReconstDTO.getId());
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
	public ModelAndView toDeleteDynAssetsReconstDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			dynAssetsReconstService.deleteDynAssetsReconstByIds(ids);
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
			DynAssetsReconstDTO dynAssetsReconst = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<DynAssetsReconstDTO>() {
					});
			List<AssetsReconstructionCheckDTO> assetsReconstructionCheckList = JsonHelper.getInstance()
					.readValue(dataSub, dateFormat, new TypeReference<List<AssetsReconstructionCheckDTO>>() {
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
			dynAssetsReconst.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
			StartResultBean result = dynAssetsReconstService.insertDynAssetsReconstAndStartProcess(dynAssetsReconst,
					assetsReconstructionCheckList, parameter);

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
		DynAssetsReconstDTO dto = dynAssetsReconstService.queryDynAssetsReconstByPrimaryKey(id);

		dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));

		dto.setDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("dynAssetsReconstDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsReconstructionCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsReconstructionCheckByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsReconstructionCheckDTO> queryReqBean = new QueryReqBean<AssetsReconstructionCheckDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsReconstructionCheckDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconstructionCheckDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconstructionCheckDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsReconstructionCheckDTO param = null;
		QueryRespBean<AssetsReconstructionCheckDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsReconstructionCheckDTO>() {
			});
			param.setAttribute01(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsReconstructionCheckDTO();
			param.setAttribute01(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsReconstructionCheckServiceSub.searchAssetsReconstructionCheckByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsReconstructionCheckServiceSub.searchAssetsReconstructionCheckByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsReconstructionCheckDTO dto : result.getResult()) {

			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
					dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsReconstructionCheckDTO分页数据");
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
			AssetsReconstructionCheckDTO dto = assetsReconstructionCheckServiceSub
					.queryAssetsReconstructionCheckByPrimaryKey(id);

			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			mav.addObject("assetsReconstructionCheckDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/dynassetsreconst/" + "AssetsReconstructionCheck" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsReconstructionCheckDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsReconstructionCheckDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsReconstructionCheckDTO>>() {
					});
			assetsReconstructionCheckServiceSub.insertOrUpdateAssetsReconstructionCheck(list, pid);
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
	public ModelAndView toDeleteAssetsReconstructionCheckDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsReconstructionCheckServiceSub.deleteAssetsReconstructionCheckByIds(ids);
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
			Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
			HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceCategoryList) {
				deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub2/getAssetsReconstructionR", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsReconstructionRByPid(PageParameter pageParameter,
															   HttpServletRequest request) {
		QueryReqBean<AssetsReconstructionRDTO> queryReqBean = new QueryReqBean<AssetsReconstructionRDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsReconstructionRDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconstructionRDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconstructionRDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsReconstructionRDTO param = null;
		QueryRespBean<AssetsReconstructionRDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsReconstructionRDTO>() {
			});
			param.setAttribute01(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsReconstructionRDTO();
			param.setAttribute01(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsReconstructionRServiceSub.searchAssetsReconstructionRByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsReconstructionRServiceSub.searchAssetsReconstructionRByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsReconstructionRDTO dto : result.getResult()) {

			dto.setCreatedByDeptRAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDeptR(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setOwnerDeptRAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDeptR(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setOwnerIdRAlias(sysUserLoader.getSysUserNameById(dto.getOwnerIdR()));

			dto.setSecretLevelRName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
					dto.getSecretLevelR(), sysApplicationAPI.getCurrentAppId()));

			dto.setCreatedByPersonRAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersonR()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsReconstructionRDTO分页数据");
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
	@RequestMapping(value = "/operation/sub2/{type}/{id}")
	public ModelAndView toOpertionSubPage2(@PathVariable String type, @PathVariable String id,
										  HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//主表数据
			AssetsReconstructionRDTO dto = assetsReconstructionRServiceSub.queryAssetsReconstructionRByPrimaryKey(id);

			dto.setCreatedByDeptRAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDeptR(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerDeptRAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDeptR(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerIdRAlias(sysUserLoader.getSysUserNameById(dto.getOwnerIdR()));
			dto.setCreatedByPersonRAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersonR()));
			mav.addObject("assetsReconstructionRDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/dynassetsreconst/" + "AssetsReconstructionR" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub2/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsReconstructionRDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsReconstructionRDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsReconstructionRDTO>>() {
					});
			assetsReconstructionRServiceSub.insertOrUpdateAssetsReconstructionR(list, pid);
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
	@RequestMapping(value = "/operation/sub2/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsReconstructionRDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsReconstructionRServiceSub.deleteAssetsReconstructionRByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}




}
