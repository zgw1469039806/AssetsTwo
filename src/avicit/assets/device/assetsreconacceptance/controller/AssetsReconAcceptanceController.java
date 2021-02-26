package avicit.assets.device.assetsreconacceptance.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsreconacceptance.dto.AssetsReconAcceptanceDTO;
import avicit.assets.device.assetsreconacceptance.service.AssetsReconAcceptanceService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-11 17:21
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsreconacceptance/assetsReconAcceptanceController")
public class AssetsReconAcceptanceController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsReconAcceptanceController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsReconAcceptanceService assetsReconAcceptanceService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsReconAcceptanceManage")
	public ModelAndView toAssetsReconAcceptanceManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsreconacceptance/AssetsReconAcceptanceManage");
		mav.addObject("url", "platform/assets/device/assetsreconacceptance/assetsReconAcceptanceController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getAssetsReconAcceptancesByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsReconAcceptanceByPage(PageParameter pageParameter, HttpServletRequest request)
			throws Exception {
		QueryReqBean<AssetsReconAcceptanceDTO> queryReqBean = new QueryReqBean<AssetsReconAcceptanceDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}

		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsReconAcceptanceDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconAcceptanceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsReconAcceptanceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsReconAcceptanceDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsReconAcceptanceDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsReconAcceptanceDTO>() {
			});
		} else {
			param = new AssetsReconAcceptanceDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);

		try {
			if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
				result = assetsReconAcceptanceService.searchAssetsReconAcceptanceByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsReconAcceptanceService.searchAssetsReconAcceptanceByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsReconAcceptanceDTO dto : result.getResult()) {

			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));

			dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
					dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));

			dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

			dto.setIfRegularCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfRegularCheck(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfSpotCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfSpotCheck(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfPrecisionInspection(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
					"PLATFORM_YES_NO_FLAG", dto.getIfPrecisionInspection(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfUpkeep(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfUpkeep(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfMeasure(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfMeasure(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfInstall(), sysApplicationAPI.getCurrentAppId()));

			dto.setIfMeasureOnsite(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
					dto.getIfMeasureOnsite(), sysApplicationAPI.getCurrentAppId()));

			dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));

			dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES",
					dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));

			dto.setAbcCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
					dto.getAbcCategory(), sysApplicationAPI.getCurrentAppId()));

		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsReconAcceptanceDTO分页数据");
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
			AssetsReconAcceptanceDTO dto = assetsReconAcceptanceService.queryAssetsReconAcceptanceByPrimaryKey(id);

			dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
			dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

			dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));

			mav.addObject("assetsReconAcceptanceDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetsreconacceptance/" + "AssetsReconAcceptance" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsReconAcceptanceDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		String returnId = "";
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsReconAcceptanceDTO assetsReconAcceptanceDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsReconAcceptanceDTO>() {
					});
			if (StringUtils.isEmpty(assetsReconAcceptanceDTO.getId())) {//新增
				returnId = assetsReconAcceptanceService.insertAssetsReconAcceptance(assetsReconAcceptanceDTO);
			} else {//修改
				returnId = assetsReconAcceptanceDTO.getId();
				assetsReconAcceptanceService.updateAssetsReconAcceptanceSensitive(assetsReconAcceptanceDTO);
			}
			mav.addObject("flag", OpResult.success);
			mav.addObject("id", returnId);
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
	public ModelAndView toDeleteAssetsReconAcceptanceDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsReconAcceptanceService.deleteAssetsReconAcceptanceByIds(ids);
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
		String data = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsReconAcceptanceDTO assetsReconAcceptance = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsReconAcceptanceDTO>() {
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
			StartResultBean result = assetsReconAcceptanceService
					.insertAssetsReconAcceptanceAndStartProcess(assetsReconAcceptance, parameter);

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
		AssetsReconAcceptanceDTO dto = assetsReconAcceptanceService.queryAssetsReconAcceptanceByPrimaryKey(id);

		dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));

		dto.setApplyByDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));

		dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));

		dto.setOwnerDeptAlias(
				sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(), SessionHelper.getCurrentLanguageCode()));

		dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

		dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

		dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsReconAcceptanceDTO", dto);
		return mav;
	}
}
