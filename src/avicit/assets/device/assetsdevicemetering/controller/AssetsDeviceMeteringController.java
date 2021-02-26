package avicit.assets.device.assetsdevicemetering.controller;

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

import avicit.assets.device.assetsdevicemetering.service.AssetsDeviceMeteringService;
import avicit.assets.device.assetsdevicemetering.service.DynDeviceToolService;
import avicit.assets.device.assetsdevicemetering.dto.DynDeviceToolDTO;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 16:14
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdevicemetering/assetsDeviceMeteringController")
public class AssetsDeviceMeteringController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMeteringController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceMeteringService assetsDeviceMeteringService;
	@Autowired

	private DynDeviceToolService dynDeviceToolServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceMeteringManage")
	public ModelAndView toAssetsDeviceMeteringManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsdevicemetering/AssetsDeviceMeteringManage");
		mav.addObject("url", "platform/assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsDeviceMeteringsByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceMeteringByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceMeteringDTO> queryReqBean = new QueryReqBean<AssetsDeviceMeteringDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceMeteringDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMeteringDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMeteringDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceMeteringDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsDeviceMeteringDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsDeviceMeteringDTO>() {
			});
		} else {
			param = new AssetsDeviceMeteringDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceMeteringService.searchAssetsDeviceMeteringByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceMeteringService.searchAssetsDeviceMeteringByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsDeviceMeteringDTO dto : result.getResult()) {
			dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));
			dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setSenddevicePidAlias(sysUserLoader.getSysUserNameById(dto.getSenddevicePid()));
			dto.setSenddeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getSenddeviceDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setTakedevicePidAlias(sysUserLoader.getSysUserNameById(dto.getTakedevicePid()));
			dto.setTakedeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getTakedeviceDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setDeliveryPidAlias(sysUserLoader.getSysUserNameById(dto.getDeliveryPid()));
			dto.setDeliveryDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeliveryDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
					dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));
			dto.setMeterMode(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_MODE",
					dto.getMeterMode(), sysApplicationAPI.getCurrentAppId()));
			dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));
			dto.setMeterPlanPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPlanPerson()));
			dto.setMeterTakeawayPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterTakeawayPerson()));
			dto.setMeterConclusion(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
					dto.getMeterConclusion(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsDeriveOft(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIsDeriveOft(), sysApplicationAPI.getCurrentAppId()));
			dto.setMeteringOrigin(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_ORIGIN_TYPE",
					dto.getMeteringOrigin(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsDeliveryAllowed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIsDeliveryAllowed(), sysApplicationAPI.getCurrentAppId()));
			dto.setFormCheckConclude(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("conclusion",
					dto.getFormCheckConclude(), sysApplicationAPI.getCurrentAppId()));
			dto.setManagerConclude(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("conclusion",
					dto.getManagerConclude(), sysApplicationAPI.getCurrentAppId()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceMeteringDTO分页数据");
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
			AssetsDeviceMeteringDTO dto = assetsDeviceMeteringService.queryAssetsDeviceMeteringByPrimaryKey(id);
			dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));
			dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setSenddevicePidAlias(sysUserLoader.getSysUserNameById(dto.getSenddevicePid()));
			dto.setSenddeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getSenddeviceDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setTakedevicePidAlias(sysUserLoader.getSysUserNameById(dto.getTakedevicePid()));
			dto.setTakedeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getTakedeviceDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setDeliveryPidAlias(sysUserLoader.getSysUserNameById(dto.getDeliveryPid()));
			dto.setDeliveryDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeliveryDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));
			dto.setMeterPlanPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPlanPerson()));
			dto.setMeterTakeawayPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterTakeawayPerson()));

			String appId = sysApplicationAPI.getCurrentAppId();
			mav.addObject("assetsDeviceMeteringDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicemetering/" + "AssetsDeviceMetering" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceMeteringDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceMeteringDTO assetsDeviceMeteringDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsDeviceMeteringDTO>() {
					});
			List<DynDeviceToolDTO> dynDeviceToolList = JsonHelper.getInstance().readValue(jsonDataSub, dateFormat,
					new TypeReference<List<DynDeviceToolDTO>>() {
					});
			if (StringUtils.isEmpty(assetsDeviceMeteringDTO.getId())) {//新增
				assetsDeviceMeteringService.insertAssetsDeviceMetering(assetsDeviceMeteringDTO);
			} else {//修改
				assetsDeviceMeteringService.updateAssetsDeviceMeteringSensitive(assetsDeviceMeteringDTO);
			}
			//子表业务操作
			dynDeviceToolServiceSub.insertOrUpdateDynDeviceTool(dynDeviceToolList, assetsDeviceMeteringDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceMeteringDTO.getId());
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
	public ModelAndView toDeleteAssetsDeviceMeteringDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceMeteringService.deleteAssetsDeviceMeteringByIds(ids);
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
			AssetsDeviceMeteringDTO assetsDeviceMetering = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsDeviceMeteringDTO>() {
					});
			List<DynDeviceToolDTO> dynDeviceToolList = JsonHelper.getInstance().readValue(dataSub, dateFormat,
					new TypeReference<List<DynDeviceToolDTO>>() {
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
			StartResultBean result = assetsDeviceMeteringService
					.insertAssetsDeviceMeteringAndStartProcess(assetsDeviceMetering, dynDeviceToolList, parameter);

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
		AssetsDeviceMeteringDTO dto = assetsDeviceMeteringService.queryAssetsDeviceMeteringByPrimaryKey(id);

		dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));

		dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

		dto.setOwnerDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(), SessionHelper.getCurrentLanguageCode()));

		dto.setSenddevicePidAlias(sysUserLoader.getSysUserNameById(dto.getSenddevicePid()));

		dto.setSenddeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getSenddeviceDept(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setTakedevicePidAlias(sysUserLoader.getSysUserNameById(dto.getTakedevicePid()));

		dto.setTakedeviceDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getTakedeviceDept(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setDeliveryPidAlias(sysUserLoader.getSysUserNameById(dto.getDeliveryPid()));

		dto.setDeliveryDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeliveryDept(), SessionHelper.getCurrentLanguageCode()));

		dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));

		dto.setMeterPlanPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPlanPerson()));

		dto.setMeterTakeawayPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterTakeawayPerson()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsDeviceMeteringDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getDynDeviceTool", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetDynDeviceToolByPid(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DynDeviceToolDTO> queryReqBean = new QueryReqBean<DynDeviceToolDTO>();
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
			cloumnName = ComUtil.getColumn(DynDeviceToolDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynDeviceToolDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynDeviceToolDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		DynDeviceToolDTO param = null;
		QueryRespBean<DynDeviceToolDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<DynDeviceToolDTO>() {
			});
			param.setFkSubColId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new DynDeviceToolDTO();
			param.setFkSubColId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = dynDeviceToolServiceSub.searchDynDeviceToolByPageOr(queryReqBean, orderBy);
			} else {
				result = dynDeviceToolServiceSub.searchDynDeviceToolByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (DynDeviceToolDTO dto : result.getResult()) {

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DynDeviceToolDTO分页数据");
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
			DynDeviceToolDTO dto = dynDeviceToolServiceSub.queryDynDeviceToolByPrimaryKey(id);

			mav.addObject("dynDeviceToolDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicemetering/" + "DynDeviceTool" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveDynDeviceToolDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<DynDeviceToolDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<DynDeviceToolDTO>>() {
					});
			dynDeviceToolServiceSub.insertOrUpdateDynDeviceTool(list, pid);
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
	public ModelAndView toDeleteDynDeviceToolDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			dynDeviceToolServiceSub.deleteDynDeviceToolByIds(ids);
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
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
