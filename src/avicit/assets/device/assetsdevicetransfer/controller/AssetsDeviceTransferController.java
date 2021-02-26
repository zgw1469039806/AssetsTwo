package avicit.assets.device.assetsdevicetransfer.controller;

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

import avicit.assets.device.assetsdevicetransfer.service.AssetsDeviceTransferService;
import avicit.assets.device.assetsdevicetransfer.service.AssetsTransferprocDeviceService;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsDeviceTransferDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdevicetransfer/assetsDeviceTransferController")
public class AssetsDeviceTransferController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceTransferController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceTransferService assetsDeviceTransferService;
	@Autowired

	private AssetsTransferprocDeviceService assetsTransferprocDeviceServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceTransferManage")
	public ModelAndView toAssetsDeviceTransferManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsdevicetransfer/AssetsDeviceTransferManage");
		mav.addObject("url", "platform/assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsDeviceTransfersByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsDeviceTransferByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceTransferDTO> queryReqBean = new QueryReqBean<AssetsDeviceTransferDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceTransferDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceTransferDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceTransferDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceTransferDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsDeviceTransferDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsDeviceTransferDTO>() {
			});
		} else {
			param = new AssetsDeviceTransferDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceTransferService.searchAssetsDeviceTransferByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceTransferService.searchAssetsDeviceTransferByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		for (AssetsDeviceTransferDTO dto : result.getResult()) {
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setReceiverAlias(sysUserLoader.getSysUserNameById(dto.getReceiver()));
			dto.setReceiverDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getReceiverDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceTransferDTO分页数据");
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
			AssetsDeviceTransferDTO dto = assetsDeviceTransferService.queryAssetsDeviceTransferByPrimaryKey(id);
			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setReceiverAlias(sysUserLoader.getSysUserNameById(dto.getReceiver()));
			dto.setReceiverDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getReceiverDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

			String appId = sysApplicationAPI.getCurrentAppId();
			Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL",
					appId);
			HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
			for (SysLookupSimpleVo vo : secretLevelList) {
				secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
			}
			mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
			mav.addObject("assetsDeviceTransferDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicetransfer/" + "AssetsDeviceTransfer" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceTransferDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsDeviceTransferDTO assetsDeviceTransferDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsDeviceTransferDTO>() {
					});
			List<AssetsTransferprocDeviceDTO> assetsTransferprocDeviceList = JsonHelper.getInstance()
					.readValue(jsonDataSub, dateFormat, new TypeReference<List<AssetsTransferprocDeviceDTO>>() {
					});
			if (StringUtils.isEmpty(assetsDeviceTransferDTO.getId())) {//新增
				assetsDeviceTransferService.insertAssetsDeviceTransfer(assetsDeviceTransferDTO);
			} else {//修改
				assetsDeviceTransferService.updateAssetsDeviceTransferSensitive(assetsDeviceTransferDTO);
			}
			//子表业务操作
			assetsTransferprocDeviceServiceSub.insertOrUpdateAssetsTransferprocDevice(assetsTransferprocDeviceList,
					assetsDeviceTransferDTO.getId());
			mav.addObject("flag", OpResult.success);
			mav.addObject("pid", assetsDeviceTransferDTO.getId());
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
	public ModelAndView toDeleteAssetsDeviceTransferDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceTransferService.deleteAssetsDeviceTransferByIds(ids);
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
			AssetsDeviceTransferDTO assetsDeviceTransfer = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsDeviceTransferDTO>() {
					});
			List<AssetsTransferprocDeviceDTO> assetsTransferprocDeviceList = JsonHelper.getInstance().readValue(dataSub,
					dateFormat, new TypeReference<List<AssetsTransferprocDeviceDTO>>() {
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
			StartResultBean result = assetsDeviceTransferService.insertAssetsDeviceTransferAndStartProcess(
					assetsDeviceTransfer, assetsTransferprocDeviceList, parameter);

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
		AssetsDeviceTransferDTO dto = assetsDeviceTransferService.queryAssetsDeviceTransferByPrimaryKey(id);

		dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setReceiverAlias(sysUserLoader.getSysUserNameById(dto.getReceiver()));

		dto.setReceiverDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getReceiverDept(), SessionHelper.getCurrentLanguageCode()));

		dto.setCreatedByPersonAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPerson()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsDeviceTransferDTO", dto);

		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsTransferprocDevice", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsTransferprocDeviceByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsTransferprocDeviceDTO> queryReqBean = new QueryReqBean<AssetsTransferprocDeviceDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsTransferprocDeviceDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTransferprocDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTransferprocDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsTransferprocDeviceDTO param = null;
		QueryRespBean<AssetsTransferprocDeviceDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsTransferprocDeviceDTO>() {
			});
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsTransferprocDeviceDTO();
			param.setProcId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsTransferprocDeviceServiceSub.searchAssetsTransferprocDeviceByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsTransferprocDeviceServiceSub.searchAssetsTransferprocDeviceByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsTransferprocDeviceDTO dto : result.getResult()) {

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));

			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));

			dto.setSecretLevelName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
					dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsTransferprocDeviceDTO分页数据");
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
			AssetsTransferprocDeviceDTO dto = assetsTransferprocDeviceServiceSub
					.queryAssetsTransferprocDeviceByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));
			dto.setUserDeptAlias(
					sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsTransferprocDeviceDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsdevicetransfer/" + "AssetsTransferprocDevice" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public AvicitResponseBody toSaveAssetsTransferprocDeviceDTO(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsTransferprocDeviceDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsTransferprocDeviceDTO>>() {
					});
			assetsTransferprocDeviceServiceSub.insertOrUpdateAssetsTransferprocDevice(list, pid);
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
	public ModelAndView toDeleteAssetsTransferprocDeviceDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsTransferprocDeviceServiceSub.deleteAssetsTransferprocDeviceByIds(ids);
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
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
