package avicit.assets.device.assetsdeviceacheckproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.assets.device.assetsdeviceacccheck.service.AssetsDeviceAccCheckService;
import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.assets.device.assetsdeviceachecktemporary.service.AssetsDeviceAcheckTemporaryService;
import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;
import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.core.exception.DaoException;
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

import avicit.assets.device.assetsdeviceacheckproc.service.AssetsDeviceAcheckProcService;
import avicit.assets.device.assetsdeviceacheckproc.service.AssetsDeviceAcheckPlanService;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckProcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController")
public class AssetsDeviceAcheckProcController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceAcheckProcController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceAcheckProcService assetsDeviceAcheckProcService;
	@Autowired

	private AssetsDeviceAcheckPlanService assetsDeviceAcheckPlanServiceSub;
	@Autowired
	private AssetsDeviceAcheckTemporaryService assetsDeviceAcheckTemporaryService;

	@Autowired
	private UserTableModelService userTableModelService;
	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceAcheckProcManage")
	public ModelAndView toAssetsDeviceAcheckProcManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsdeviceacheckproc/AssetsDeviceAcheckProcManage");
		mav.addObject("url",
				"platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/sub/");

		/*用户视图、默认表头获取代码——开始*/
		SysUser user = SessionHelper.getLoginSysUser(request); //获取当前登录用户

		//获取用户视图列表
		List<String> viewList = new ArrayList<>();
		try {
			viewList = userTableModelService.getUserViewList(user.getId(),"AssetsDeviceAcheckProc");
			mav.addObject("viewList", viewList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		//获取表头字段
		try {
			StringBuffer dataGridColModelJson = new StringBuffer();
			dataGridColModelJson.append("[");

			List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AssetsDeviceAcheckProc", viewList.get(0), "Y");
			if((modelList == null) || (modelList.size() == 0)){
				modelList = userTableModelService.searchUserTableModel("系统默认",  "AssetsDeviceAcheckProc", "系统默认视图", "Y");
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
	@RequestMapping(value = "/operation/getAssetsDeviceAcheckProcsByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceAcheckProcByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceAcheckProcDTO> queryReqBean = new QueryReqBean<AssetsDeviceAcheckProcDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceAcheckProcDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceAcheckProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceAcheckProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceAcheckProcDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsDeviceAcheckProcDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsDeviceAcheckProcDTO>() {
					});
		} else {
			param = new AssetsDeviceAcheckProcDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceAcheckProcService.searchAssetsDeviceAcheckProcByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceAcheckProcService.searchAssetsDeviceAcheckProcByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsDeviceAcheckProcDTO dto : result.getResult()) {
			dto.setImplementationDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(
					dto.getImplementationDepartment(), SessionHelper.getCurrentLanguageCode()));
			dto.setGenerateByAlias(sysUserLoader.getSysUserNameById(dto.getGenerateBy()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceAcheckProcDTO分页数据");
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
			AssetsDeviceAcheckProcDTO dto = assetsDeviceAcheckProcService.queryAssetsDeviceAcheckProcByPrimaryKey(id);
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
			mav.addObject("assetsDeviceAcheckProcDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetsdeviceacheckproc/" + "AssetsDeviceAcheckProc" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceAcheckProcDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsDeviceAcheckProcDTO>() {
					});
			List<AssetsDeviceAcheckPlanDTO> assetsDeviceAcheckPlanList = JsonHelper.getInstance().readValue(jsonDataSub,
					dateFormat, new TypeReference<List<AssetsDeviceAcheckPlanDTO>>() {
					});
			if (StringUtils.isEmpty(assetsDeviceAcheckProcDTO.getId())) {//新增
				assetsDeviceAcheckProcService.insertAssetsDeviceAcheckProc(assetsDeviceAcheckProcDTO);
			} else {//修改
				assetsDeviceAcheckProcService.updateAssetsDeviceAcheckProcSensitive(assetsDeviceAcheckProcDTO);
			}
			//子表业务操作
			assetsDeviceAcheckPlanServiceSub.insertOrUpdateAssetsDeviceAcheckPlan(assetsDeviceAcheckPlanList,
					assetsDeviceAcheckProcDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceAcheckProcDTO.getId());
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
	public ModelAndView toDeleteAssetsDeviceAcheckProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceAcheckProcService.deleteAssetsDeviceAcheckProcByIds(ids);
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
			AssetsDeviceAcheckProcDTO assetsDeviceAcheckProc = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsDeviceAcheckProcDTO>() {
					});

			AssetsDeviceAcheckTemporaryDTO temp= new AssetsDeviceAcheckTemporaryDTO();
			List<AssetsDeviceAcheckTemporaryDTO> rcheck=	assetsDeviceAcheckTemporaryService.searchAssetsDeviceAcheckTemporary();
//			List<AssetsDeviceAcheckPlanDTO> assetsDeviceAcheckPlanList = JsonHelper.getInstance().readValue(dataSub,
//					dateFormat, new TypeReference<List<AssetsDeviceAcheckPlanDTO>>() {
//					});
			List<AssetsDeviceAcheckPlanDTO> assetsDeviceAcheckPlanList =new ArrayList<>();
			for (AssetsDeviceAcheckTemporaryDTO dto : rcheck) {
				AssetsDeviceAcheckPlanDTO planDTO=new AssetsDeviceAcheckPlanDTO();
				planDTO.setCheckId(dto.getCheckId());
				planDTO.setUnifiedId(dto.getUnifiedId());
				planDTO.setDeviceName(dto.getDeviceName());
				planDTO.setDeviceCategory(dto.getDeviceCategory());
				planDTO.setDeviceModel(dto.getDeviceModel());;
				planDTO.setPositionId(dto.getPositionId());
				planDTO.setProductArea(dto.getProductArea());
				planDTO.setProductDate(dto.getProductDate());
				planDTO.setUserId(dto.getUserId());
				planDTO.setUserDept(dto.getUserDept());
				planDTO.setAccCheckCycle(dto.getAccCheckCycle());
				planDTO.setAttachment(dto.getAttachment());
				planDTO.setAccCheckDate(dto.getAccCheckDate());

				assetsDeviceAcheckPlanList.add(planDTO);
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
			assetsDeviceAcheckProc.setAcheckNumber((long) rcheck.size());


			StartResultBean result = assetsDeviceAcheckProcService.insertAssetsDeviceAcheckProcAndStartProcess(
					assetsDeviceAcheckProc, assetsDeviceAcheckPlanList, parameter);


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
		AssetsDeviceAcheckProcDTO dto = assetsDeviceAcheckProcService.queryAssetsDeviceAcheckProcByPrimaryKey(id);

		dto.setImplementationDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getImplementationDepartment(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setGenerateByAlias(sysUserLoader.getSysUserNameById(dto.getGenerateBy()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsDeviceAcheckProcDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsDeviceAcheckPlan", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceAcheckPlanByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceAcheckPlanDTO> queryReqBean = new QueryReqBean<AssetsDeviceAcheckPlanDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceAcheckPlanDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceAcheckPlanDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceAcheckPlanDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceAcheckPlanDTO param = null;
		QueryRespBean<AssetsDeviceAcheckPlanDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsDeviceAcheckPlanDTO>() {
			});
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsDeviceAcheckPlanDTO();
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceAcheckPlanServiceSub.searchAssetsDeviceAcheckPlanByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceAcheckPlanServiceSub.searchAssetsDeviceAcheckPlanByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceAcheckPlanDTO dto : result.getResult()) {

			dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
					dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));

			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceAcheckPlanDTO分页数据");
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
			AssetsDeviceAcheckPlanDTO dto = assetsDeviceAcheckPlanServiceSub
					.queryAssetsDeviceAcheckPlanByPrimaryKey(id);

			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));
			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsDeviceAcheckPlanDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsdeviceacheckproc/" + "AssetsDeviceAcheckPlan" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsDeviceAcheckPlanDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsDeviceAcheckPlanDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsDeviceAcheckPlanDTO>>() {
					});
			assetsDeviceAcheckPlanServiceSub.insertOrUpdateAssetsDeviceAcheckPlan(list, pid);
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
	public ModelAndView toDeleteAssetsDeviceAcheckPlanDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceAcheckPlanServiceSub.deleteAssetsDeviceAcheckPlanByIds(ids);
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



}
