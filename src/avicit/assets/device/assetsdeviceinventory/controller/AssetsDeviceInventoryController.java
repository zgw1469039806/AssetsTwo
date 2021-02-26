package avicit.assets.device.assetsdeviceinventory.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
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

import avicit.assets.device.assetsdeviceinventory.service.AssetsDeviceInventoryService;
import avicit.assets.device.assetsdeviceinventory.service.AssetsDeviceInventorySubService;
import avicit.assets.device.assetsdeviceinventory.dto.AssetsDeviceInventorySubDTO;
import avicit.assets.device.assetsdeviceinventory.dto.AssetsDeviceInventoryDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 14:32
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdeviceinventory/assetsDeviceInventoryController")
public class AssetsDeviceInventoryController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceInventoryController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceInventoryService assetsDeviceInventoryService;
	@Autowired
	private AssetsDeviceInventorySubService assetsDeviceInventorySubServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceInventoryManage")
	public ModelAndView toAssetsDeviceInventoryManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsdeviceinventory/AssetsDeviceInventoryManage");
		mav.addObject("url", "platform/assets/device/assetsdeviceinventory/assetsDeviceInventoryController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsdeviceinventory/assetsDeviceInventoryController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsDeviceInventorysByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceInventoryByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceInventoryDTO> queryReqBean = new QueryReqBean<AssetsDeviceInventoryDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceInventoryDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceInventoryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceInventoryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceInventoryDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsDeviceInventoryDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsDeviceInventoryDTO>() {
			});
		} else {
			param = new AssetsDeviceInventoryDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceInventoryService.searchAssetsDeviceInventoryByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceInventoryService.searchAssetsDeviceInventoryByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsDeviceInventoryDTO dto : result.getResult()) {
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceInventoryDTO分页数据");
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
			AssetsDeviceInventoryDTO dto = assetsDeviceInventoryService.queryAssetsDeviceInventoryByPrimaryKey(id);
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> deviceStateList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_STATE",
					appId);
			HashMap<String, String> deviceStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceStateList) {
				deviceStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceStateData", JsonHelper.getInstance().writeValueAsString(deviceStateMap));
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
			mav.addObject("assetsDeviceInventoryDTO", dto);
			mav.addObject("id", id);
			mav.setViewName("avicit/assets/device/assetsdeviceinventory/" + "AssetsDeviceInventory" + type);
		}else{
			AssetsDeviceInventoryDTO dto = new AssetsDeviceInventoryDTO();
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsDeviceInventoryDTO", dto);
			mav.setViewName("avicit/assets/device/assetsdeviceinventory/AssetsDeviceInventoryAdd.jsp");
		}
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceInventoryDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceInventoryDTO assetsDeviceInventoryDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsDeviceInventoryDTO>() {
					});
			List<AssetsDeviceInventorySubDTO> assetsDeviceInventorySubDTOList=JsonHelper.getInstance().readValue(jsonDataSub,dateFormat,new TypeReference<List<AssetsDeviceInventorySubDTO>>() {
			});
			if(assetsDeviceInventorySubDTOList==null||assetsDeviceInventorySubDTOList.size()<=0){
				mav.addObject("flag", OpResult.failure);
				return mav;
			}
			if (StringUtils.isEmpty(assetsDeviceInventoryDTO.getId())) {//新增
				assetsDeviceInventoryService.insertAssetsDeviceInventory(assetsDeviceInventoryDTO);
			} else {//修改
				assetsDeviceInventoryService.updateAssetsDeviceInventorySensitive(assetsDeviceInventoryDTO);
			}
			//子表业务操作
			assetsDeviceInventorySubServiceSub.insertOrUpdateAssetsDeviceInventorySub(assetsDeviceInventorySubDTOList,
					assetsDeviceInventoryDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceInventoryDTO.getId());
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 保存数据(生成盘点清单)
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save01", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceInventoryDTO01(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceInventoryDTO assetsDeviceInventoryDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsDeviceInventoryDTO>() {
					});
			List<AssetsDeviceInventorySubDTO> assetsDeviceInventorySubDTOList=JsonHelper.getInstance().readValue(jsonDataSub,dateFormat,new TypeReference<List<AssetsDeviceInventorySubDTO>>() {
			});
			if(assetsDeviceInventorySubDTOList==null||assetsDeviceInventorySubDTOList.size()<=0){
				mav.addObject("flag", OpResult.failure);
				return mav;
			}
			if (StringUtils.isEmpty(assetsDeviceInventoryDTO.getId())) {//新增
				assetsDeviceInventoryService.insertAssetsDeviceInventory(assetsDeviceInventoryDTO);
			} else {//修改
				assetsDeviceInventoryService.updateAssetsDeviceInventorySensitive(assetsDeviceInventoryDTO);
			}
			//子表业务操作
			assetsDeviceInventorySubServiceSub.insertOrUpdateAssetsDeviceInventorySub01(assetsDeviceInventorySubDTOList,
					assetsDeviceInventoryDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceInventoryDTO.getId());
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
	public ModelAndView toDeleteAssetsDeviceInventoryDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceInventoryService.deleteAssetsDeviceInventoryByIds(ids);
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
			AssetsDeviceInventoryDTO assetsDeviceInventory = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsDeviceInventoryDTO>() {
					});
			List<AssetsDeviceInventorySubDTO> assetsDeviceInventorySubList = JsonHelper.getInstance().readValue(dataSub,
					dateFormat, new TypeReference<List<AssetsDeviceInventorySubDTO>>() {
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
			StartResultBean result = assetsDeviceInventoryService.insertAssetsDeviceInventoryAndStartProcess(
					assetsDeviceInventory, assetsDeviceInventorySubList, parameter);

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
		AssetsDeviceInventoryDTO dto = assetsDeviceInventoryService.queryAssetsDeviceInventoryByPrimaryKey(id);

		dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

		dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
				SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsDeviceInventoryDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsDeviceInventorySub", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceInventorySubByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceInventorySubDTO> queryReqBean = new QueryReqBean<AssetsDeviceInventorySubDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceInventorySubDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceInventorySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceInventorySubDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceInventorySubDTO param = null;
		QueryRespBean<AssetsDeviceInventorySubDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsDeviceInventorySubDTO>() {
			});
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsDeviceInventorySubDTO();
			param.setParentId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceInventorySubServiceSub.searchAssetsDeviceInventorySubByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsDeviceInventorySubServiceSub.searchAssetsDeviceInventorySubByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceInventorySubDTO dto : result.getResult()) {

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setDeviceStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
					dto.getDeviceState(), sysApplicationAPI.getCurrentAppId()));

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
		logger.info("成功获取AssetsDeviceInventorySubDTO分页数据");
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
			AssetsDeviceInventorySubDTO dto = assetsDeviceInventorySubServiceSub
					.queryAssetsDeviceInventorySubByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setInventoryPersonAlias(sysUserLoader.getSysUserNameById(dto.getInventoryPerson()));
			dto.setInventoryDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getInventoryDept(),
					SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsDeviceInventorySubDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsdeviceinventory/" + "AssetsDeviceInventorySub" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsDeviceInventorySubDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsDeviceInventorySubDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsDeviceInventorySubDTO>>() {
					});
			assetsDeviceInventorySubServiceSub.insertOrUpdateAssetsDeviceInventorySub(list, pid);
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
	public ModelAndView toDeleteAssetsDeviceInventorySubDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceInventorySubServiceSub.deleteAssetsDeviceInventorySubByIds(ids);
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
			Collection<SysLookupSimpleVo> deviceStateList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_STATE",
					appId);
			HashMap<String, String> deviceStateMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceStateList) {
				deviceStateMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceStateData", JsonHelper.getInstance().writeValueAsString(deviceStateMap));
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
