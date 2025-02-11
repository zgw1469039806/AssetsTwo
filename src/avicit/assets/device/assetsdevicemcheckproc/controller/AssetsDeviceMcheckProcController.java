package avicit.assets.device.assetsdevicemcheckproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.assets.device.assetsdeviceacccheck.service.AssetsDeviceAccCheckService;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;
import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.assets.device.assetsdevicemaintain.dto.AssetsDeviceMaintainDTO;
import avicit.assets.device.assetsdevicemaintain.service.AssetsDeviceMaintainService;
import avicit.assets.device.assetsdevicemchecktemporary.dto.AssetsDeviceMcheckTemporaryDTO;
import avicit.assets.device.assetsdevicemchecktemporary.service.AssetsDeviceMcheckTemporaryService;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;
import avicit.platform6.api.sysuser.dto.SysUser;
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

import avicit.assets.device.assetsdevicemcheckproc.service.AssetsDeviceMcheckProcService;
import avicit.assets.device.assetsdevicemcheckproc.service.AssetsDeviceMcheckPlanService;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckProcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController")
public class AssetsDeviceMcheckProcController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMcheckProcController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceMcheckProcService assetsDeviceMcheckProcService;
	@Autowired

	private AssetsDeviceMcheckPlanService assetsDeviceMcheckPlanServiceSub;
	@Autowired
	private AssetsDeviceMcheckTemporaryService assetsDeviceMcheckTemporaryService;

	@Autowired
	private UserTableModelService userTableModelService;
	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceMcheckProcManage")
	public ModelAndView toAssetsDeviceMcheckProcManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsdevicemcheckproc/AssetsDeviceMcheckProcManage");
		mav.addObject("url",
				"platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/sub/");
		/*用户视图、默认表头获取代码——开始*/
		SysUser user = SessionHelper.getLoginSysUser(request); //获取当前登录用户

		//获取用户视图列表
		List<String> viewList = new ArrayList<>();
		try {
			viewList = userTableModelService.getUserViewList(user.getId(),"AssetsDeviceMcheckProc");
			mav.addObject("viewList", viewList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		//获取表头字段
		try {
			StringBuffer dataGridColModelJson = new StringBuffer();
			dataGridColModelJson.append("[");

			List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AssetsDeviceMcheckProc", viewList.get(0), "Y");
			if((modelList == null) || (modelList.size() == 0)){
				modelList = userTableModelService.searchUserTableModel("系统默认",  "AssetsDeviceMcheckProc", "系统默认视图", "Y");
			}

			for(int i=0; i<modelList.size(); i++){
				if(i == 0){
					dataGridColModelJson.append(modelList.get(i).getFieldModel());
				}
				else{
					dataGridColModelJson.append("," + modelList.get(i).getFieldModel());
				}
			}
			dataGridColModelJson.append("]");
			mav.addObject("dataGridColModelJson", dataGridColModelJson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*用户视图、默认表头获取代码——结束*/

		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsDeviceMcheckProcsByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceMcheckProcByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean = new QueryReqBean<AssetsDeviceMcheckProcDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceMcheckProcDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceMcheckProcDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsDeviceMcheckProcDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsDeviceMcheckProcDTO>() {
					});
		} else {
			param = new AssetsDeviceMcheckProcDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceMcheckProcService.searchAssetsDeviceMcheckProcByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceMcheckProcService.searchAssetsDeviceMcheckProcByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsDeviceMcheckProcDTO dto : result.getResult()) {
			dto.setImplementationDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(
					dto.getImplementationDepartment(), SessionHelper.getCurrentLanguageCode()));
			dto.setGenerateByAlias(sysUserLoader.getSysUserNameById(dto.getGenerateBy()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceMcheckProcDTO分页数据");
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
			AssetsDeviceMcheckProcDTO dto = assetsDeviceMcheckProcService.queryAssetsDeviceMcheckProcByPrimaryKey(id);
			dto.setImplementationDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(
					dto.getImplementationDepartment(), SessionHelper.getCurrentLanguageCode()));
			dto.setGenerateByAlias(sysUserLoader.getSysUserNameById(dto.getGenerateBy()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
			HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceCategoryList) {
				deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
			Collection<SysLookupSimpleVo> maintainItemList = sysLookupLoader.getLookUpListByTypeByAppId("MAINTAIN_ITEM",
					appId);
			HashMap<String, String> maintainItemMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : maintainItemList) {
				maintainItemMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("maintainItemData", JsonHelper.getInstance().writeValueAsString(maintainItemMap));
			Collection<SysLookupSimpleVo> maintainModeList = sysLookupLoader.getLookUpListByTypeByAppId("MAINTAIN_MODE",
					appId);
			HashMap<String, String> maintainModeMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : maintainModeList) {
				maintainModeMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("maintainModeData", JsonHelper.getInstance().writeValueAsString(maintainModeMap));
			mav.addObject("assetsDeviceMcheckProcDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicemcheckproc/" + "AssetsDeviceMcheckProc" + type);
		return mav;
	}

	/**
	 * 保存数据

	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceMcheckProcDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsDeviceMcheckProcDTO>() {
					});
			List<AssetsDeviceMcheckPlanDTO> assetsDeviceMcheckPlanList = JsonHelper.getInstance().readValue(jsonDataSub,
					dateFormat, new TypeReference<List<AssetsDeviceMcheckPlanDTO>>() {
					});
			if (StringUtils.isEmpty(assetsDeviceMcheckProcDTO.getId())) {//新增
				assetsDeviceMcheckProcService.insertAssetsDeviceMcheckProc(assetsDeviceMcheckProcDTO);
			} else {//修改
				assetsDeviceMcheckProcService.updateAssetsDeviceMcheckProcSensitive(assetsDeviceMcheckProcDTO);
			}
			//子表业务操作
			assetsDeviceMcheckPlanServiceSub.insertOrUpdateAssetsDeviceMcheckPlan(assetsDeviceMcheckPlanList,
					assetsDeviceMcheckProcDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceMcheckProcDTO.getId());
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
	public ModelAndView toDeleteAssetsDeviceMcheckProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceMcheckProcService.deleteAssetsDeviceMcheckProcByIds(ids);
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
			AssetsDeviceMcheckProcDTO assetsDeviceMcheckProc = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsDeviceMcheckProcDTO>() {
					});
			AssetsDeviceMcheckTemporaryDTO temp= new AssetsDeviceMcheckTemporaryDTO();
			List<AssetsDeviceMcheckTemporaryDTO> mcheck=	assetsDeviceMcheckTemporaryService.searchAssetsDeviceMcheckTemporary();
//			List<AssetsDeviceMcheckPlanDTO> assetsDeviceMcheckPlanList = JsonHelper.getInstance().readValue(dataSub,
//					dateFormat, new TypeReference<List<AssetsDeviceMcheckPlanDTO>>() {
//					});
			List<AssetsDeviceMcheckPlanDTO> assetsDeviceMcheckPlanList =new ArrayList<>();
			for (AssetsDeviceMcheckTemporaryDTO dto : mcheck) {
				AssetsDeviceMcheckPlanDTO planDTO=new AssetsDeviceMcheckPlanDTO();
				planDTO.setMaintainId(dto.getMaintainId());
				planDTO.setUnifiedId(dto.getUnifiedId());
				planDTO.setDeviceName(dto.getDeviceName());
				planDTO.setDeviceCategory(dto.getDeviceCategory());
				planDTO.setDeviceModel(dto.getDeviceModel());
				planDTO.setPositionId(dto.getPositionId());
				planDTO.setMaintainPosition(dto.getMaintainPosition());
				planDTO.setMaintainContent(dto.getMaintainContent());
				planDTO.setMaintainItem(dto.getMaintainItem());
				planDTO.setMaintainMode(dto.getMaintainMode());
				planDTO.setOwnerId(dto.getOwnerId());
				planDTO.setOwnerDept(dto.getOwnerDept());
				planDTO.setMaintainCycle(dto.getMaintainCycle());
				planDTO.setMaintainDate(dto.getMaintainDate());

				assetsDeviceMcheckPlanList.add(planDTO);
			}


			String userId = SessionHelper.getLoginSysUserId(request);
			String deptId = SessionHelper.getCurrentDeptId(request);
			/////////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);
			assetsDeviceMcheckProc.setMaintainNumber((long) mcheck.size());
			assetsDeviceMcheckProc.setGenerateDate(new Date());
			StartResultBean result = assetsDeviceMcheckProcService.insertAssetsDeviceMcheckProcAndStartProcess(
					assetsDeviceMcheckProc, assetsDeviceMcheckPlanList, parameter);


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
		AssetsDeviceMcheckProcDTO dto = assetsDeviceMcheckProcService.queryAssetsDeviceMcheckProcByPrimaryKey(id);

		dto.setImplementationDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getImplementationDepartment(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setGenerateByAlias(sysUserLoader.getSysUserNameById(dto.getGenerateBy()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsDeviceMcheckProcDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsDeviceMcheckPlan", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceMcheckPlanByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceMcheckPlanDTO> queryReqBean = new QueryReqBean<AssetsDeviceMcheckPlanDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceMcheckPlanDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckPlanDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckPlanDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceMcheckPlanDTO param = null;
		QueryRespBean<AssetsDeviceMcheckPlanDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsDeviceMcheckPlanDTO>() {
			});
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsDeviceMcheckPlanDTO();
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceMcheckPlanServiceSub.searchAssetsDeviceMcheckPlanByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceMcheckPlanServiceSub.searchAssetsDeviceMcheckPlanByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceMcheckPlanDTO dto : result.getResult()) {

			dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
					dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setMaintainItemName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAINTAIN_ITEM",
					dto.getMaintainItem(), sysApplicationAPI.getCurrentAppId()));

			dto.setMaintainModeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAINTAIN_MODE",
					dto.getMaintainMode(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceMcheckPlanDTO分页数据");
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
			AssetsDeviceMcheckPlanDTO dto = assetsDeviceMcheckPlanServiceSub
					.queryAssetsDeviceMcheckPlanByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsDeviceMcheckPlanDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicemcheckproc/" + "AssetsDeviceMcheckPlan" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsDeviceMcheckPlanDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsDeviceMcheckPlanDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsDeviceMcheckPlanDTO>>() {
					});
			assetsDeviceMcheckPlanServiceSub.insertOrUpdateAssetsDeviceMcheckPlan(list, pid);
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
	public ModelAndView toDeleteAssetsDeviceMcheckPlanDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceMcheckPlanServiceSub.deleteAssetsDeviceMcheckPlanByIds(ids);
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
			Collection<SysLookupSimpleVo> maintainItemList = sysLookupLoader.getLookUpListByTypeByAppId("MAINTAIN_ITEM",
					appId);
			HashMap<String, String> maintainItemMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : maintainItemList) {
				maintainItemMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("maintainItemData", JsonHelper.getInstance().writeValueAsString(maintainItemMap));
			Collection<SysLookupSimpleVo> maintainModeList = sysLookupLoader.getLookUpListByTypeByAppId("MAINTAIN_MODE",
					appId);
			HashMap<String, String> maintainModeMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : maintainModeList) {
				maintainModeMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("maintainModeData", JsonHelper.getInstance().writeValueAsString(maintainModeMap));
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
