package avicit.assets.device.dynreconmsg.controller;

import java.io.ByteArrayOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsreconstructioncheck.dto.AssetsReconstructionCheckDTO;
import avicit.assets.device.assetsreconstructioncheck.service.AssetsReconstructionCheckService;
import avicit.assets.device.assetsuserlog.controller.AssetsUserLogController;
import avicit.assets.device.assetsuserlog.dto.AssetsUserLogDTO;
import avicit.assets.device.dynassetsreconst.dto.AssetsReconstructionRDTO;
import avicit.assets.device.dynassetsreconst.service.AssetsReconstructionRService;
import avicit.platform6.api.application.dto.SysApplication;
import avicit.platform6.core.excel.export.ServerExcelExport;
import avicit.platform6.core.excel.export.datasource.DefaultTypeReferenceDataSource;
import avicit.platform6.core.excel.export.entity.DataGridHeader;
import avicit.platform6.core.excel.export.headersource.JqExportDataGridHeaderSource;
import avicit.platform6.core.excel.export.inf.IFormatField;
import avicit.platform6.core.spring.SpringMVCFactory;
import avicit.platform6.modules.system.sysorguser.sysdept.action.SysDeptController;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import avicit.platform6.api.session.SessionHelper;
import org.springframework.ui.ModelMap;
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

import avicit.assets.device.dynreconmsg.service.DynReconMsgService;
import avicit.assets.device.dynreconmsg.dto.DynReconMsgDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 19:14
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynreconmsg/dynReconMsgController")
public class DynReconMsgController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(DynReconMsgController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private DynReconMsgService dynReconMsgService;
	@Autowired
	private SysApplicationAPI appAPI;
	@Autowired

	private AssetsReconstructionCheckService assetsReconstructionCheckServiceSub;
	@Autowired

	private AssetsReconstructionRService assetsReconstructionRServiceSub;
	private DynReconMsgController.FormateAppId _formateApp = new DynReconMsgController.FormateAppId();
	private DynReconMsgController.Formate _formate = new DynReconMsgController.Formate();

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toDynReconMsgManage")
	public ModelAndView toDynReconMsgManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/dynreconmsg/DynReconMsgManage");
		mav.addObject("url", "platform/assets/device/dynreconmsg/dynReconMsgController/operation/");
		mav.addObject("surl", "platform/assets/device/dynreconmsg/dynReconMsgController/operation/sub/");
		mav.addObject("surl2", "platform/assets/device/dynreconmsg/dynReconMsgController/operation/sub2/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getDynReconMsgsByPage")
	@ResponseBody
	public Map<String, Object> toGetDynReconMsgByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<DynReconMsgDTO> queryReqBean = new QueryReqBean<DynReconMsgDTO>();
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
			cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		DynReconMsgDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<DynReconMsgDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynReconMsgDTO>() {
			});
		} else {
			param = new DynReconMsgDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = dynReconMsgService.searchDynReconMsgByPageOr(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			} else {
				result = dynReconMsgService.searchDynReconMsgByPage(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (DynReconMsgDTO dto : result.getResult()) {
			dto.setDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DynReconMsgDTO分页数据");
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
			DynReconMsgDTO dto = dynReconMsgService.queryDynReconMsgByPrimaryKey(id);
			dto.setDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL",
					appId);
			HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : secretLevelList) {
				secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
			Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader
					.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
			HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : deviceCategoryList) {
				deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
			mav.addObject("dynReconMsgDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/dynreconmsg/" + "DynReconMsg" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveDynReconMsgDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			DynReconMsgDTO dynReconMsgDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<DynReconMsgDTO>() {
					});
			List<AssetsReconstructionCheckDTO> assetsReconstructionCheckList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsReconstructionCheckDTO>>() {
					});
			if (StringUtils.isEmpty(dynReconMsgDTO.getId())) {//新增
				dynReconMsgDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
				dynReconMsgService.insertDynReconMsg(dynReconMsgDTO);
			} else {//修改
				dynReconMsgService.updateDynReconMsgSensitive(dynReconMsgDTO);
			}
			//子表业务操作
			assetsReconstructionCheckServiceSub.insertOrUpdateAssetsReconstructionCheck(assetsReconstructionCheckList,
					dynReconMsgDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", dynReconMsgDTO.getId());
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
	public ModelAndView toDeleteDynReconMsgDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			dynReconMsgService.deleteDynReconMsgByIds(ids);
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
			DynReconMsgDTO dynReconMsg = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<DynReconMsgDTO>() {
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
			dynReconMsg.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
			StartResultBean result = dynReconMsgService.insertDynReconMsgAndStartProcess(dynReconMsg,
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
		DynReconMsgDTO dto = dynReconMsgService.queryDynReconMsgByPrimaryKey(id);

		dto.setDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("dynReconMsgDTO", dto);

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
			param.setAttribute02(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsReconstructionCheckDTO();
			param.setAttribute02(pid);
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

			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

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
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
			mav.addObject("assetsReconstructionCheckDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/dynreconmsg/" + "AssetsReconstructionCheck" + type);
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
			Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL",
					appId);
			HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : secretLevelList) {
				secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
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
			mav.addObject("assetsReconstructionRDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/dynreconmsg/" + "AssetsReconstructionR" + type);
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

	@RequestMapping(value = "/operation2/getDynReconMsgsByPage")
	@ResponseBody
	public Map<String, Object> findDynReconMsgByPage(PageParameter pageParameter, HttpServletRequest request, @PathVariable("appId") String appid, @PathVariable("logTable") String logTable, boolean isExport){
		QueryReqBean<DynReconMsgDTO> queryReqBean = new QueryReqBean<DynReconMsgDTO>();
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
			cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(DynReconMsgDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		DynReconMsgDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<DynReconMsgDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynReconMsgDTO>() {
			});
		} else {
			param = new DynReconMsgDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = dynReconMsgService.searchDynReconMsgByPageOr(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			} else {
				result = dynReconMsgService.searchDynReconMsgByPage(queryReqBean,
						SessionHelper.getCurrentOrgIdentity(request), orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (DynReconMsgDTO dto : result.getResult()) {
			dto.setDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取DynReconMsgDTO分页数据");
		return map;
	}


	@RequestMapping(value = "/operation/excel/exp", method = RequestMethod.POST)
	public String toServerExport(HttpServletRequest request , ModelMap map) throws
			Exception {
		String fileName = ServletRequestUtils.getStringParameter(request, "fileName", "导出excel");
		String dataGridheaders = ServletRequestUtils.getStringParameter(request, "dataGridFields", "");
		boolean hasRowNum = ServletRequestUtils.getBooleanParameter(request, "hasRowNum", true);
		String unContainFields = ServletRequestUtils.getStringParameter(request, "unContainFields", "");
		String sheetName = ServletRequestUtils.getStringParameter(request, "sheetName", "sheet1");
		String appId = ServletRequestUtils.getStringParameter(request, "appid", "1");
		String logTable = ServletRequestUtils.getStringParameter(request, "logTable", "-1");
		String total = ServletRequestUtils.getStringParameter(request, "total", "65500");
		ServerExcelExport serverExp = new ServerExcelExport();
		serverExp.setFileName(fileName);
		serverExp.setSheetName(sheetName);
		JqExportDataGridHeaderSource header = new JqExportDataGridHeaderSource(dataGridheaders);
		header.setUnexportColumn(unContainFields);
		header.setHasRowNum(hasRowNum);
		serverExp.setUserDefinedGridHeader(header);
		int totalcount = Integer.parseInt(total);
		if (totalcount <= 65500) {
			PageParameter pp = new PageParameter(1, 65500);
			Map rst = null;

			try {
				rst = this.toGetAssetsReconstructionCheckByPid(pp, request);
			} catch (Exception var27) {
				this.logger.error("数据查询异常:" + var27.getMessage(), var27);
				return "excel.down";
			}

			ArrayList<AssetsUserLogDTO> aa = (ArrayList)rst.get("rows");
			DefaultTypeReferenceDataSource<AssetsUserLogDTO> dt = new DefaultTypeReferenceDataSource();
			dt.setData(aa);
			serverExp.setExportDataSource(dt);
			serverExp.setFormatField(this._formateApp);
			this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
			map.addAttribute("export", serverExp);
			return "excel.down";
		} else {
			int size = 'ￜ';
			int page = totalcount / size;
			if (totalcount % size != 0) {
				++page;
			}

			ByteArrayOutputStream baps = new ByteArrayOutputStream();
			ZipOutputStream out = new ZipOutputStream(baps);

			for(int i = 1; i <= page; ++i) {
				int first;
				int end;
				if (i * size > totalcount) {
					first = (i - 1) * size + 1;
					end = totalcount;
				} else {
					first = (i - 1) * size + 1;
					end = i * size;
				}

				PageParameter pp = new PageParameter(i, size);
				Map rst = null;

				try {
					rst = this.findDynReconMsgByPage(pp, request, appId, logTable, true);
				} catch (Exception var28) {
					this.logger.error("数据查询异常:" + var28.getMessage(), var28);
					return "excel.down";
				}

				ArrayList<AssetsUserLogDTO> aa = (ArrayList)rst.get("rows");
				DefaultTypeReferenceDataSource<AssetsUserLogDTO> dt = new DefaultTypeReferenceDataSource();
				dt.setData(aa);
				serverExp.setExportDataSource(dt);
				serverExp.setFormatField(this._formateApp);
				this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
				Workbook workbook = serverExp.exportData();
				ZipEntry entry = new ZipEntry("ExportSysLog-from[" + first + "]to[" + end + "].xls");
				out.putNextEntry(entry);
				workbook.write(out);
			}

			out.close();
			map.addAttribute("byte", baps.toByteArray());
			map.addAttribute("name", fileName + ".rar");
			return "byte.down";
		}
	}
	private class Formate implements IFormatField {
		private final SimpleDateFormat sdf;
		private List<SysApplication> appList;

		private Formate() {
			this.sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}

		public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
			if ("syslogTime".equalsIgnoreCase(field)) {
				return this.sdf.format(new Date(Long.parseLong(data.get(field).toString())));
			} else if ("sysApplicationId".equalsIgnoreCase(field)) {
				Iterator var4 = this.appList.iterator();

				SysApplication app;
				do {
					if (!var4.hasNext()) {
						return "没有系统应用名称";
					}

					app = (SysApplication)var4.next();
				} while(!app.getId().equals(data.get(field)));

				return app.getApplicationName();
			} else {
				return data.get(field);
			}
		}

		public void setAppList(List<SysApplication> appList) {
			this.appList = appList;
		}
	}

	private class FormateAppId implements IFormatField {
		private List<SysApplication> appList;

		private FormateAppId() {
		}

		public void setAppList(List<SysApplication> appList) {
			this.appList = appList;
		}

		public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
			if ("syslogTime".equalsIgnoreCase(field)) {
				return data.get(field).toString();
			} else if ("sysApplicationId".equalsIgnoreCase(field)) {
				Iterator var4 = this.appList.iterator();

				SysApplication app;
				do {
					if (!var4.hasNext()) {
						return "没有系统应用名称";
					}

					app = (SysApplication)var4.next();
				} while(!app.getId().equals(data.get(field)));

				return app.getApplicationName();
			} else {
				return data.get(field);
			}
		}
	}
}
