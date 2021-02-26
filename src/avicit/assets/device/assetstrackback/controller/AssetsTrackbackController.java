package avicit.assets.device.assetstrackback.controller;

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
import avicit.assets.device.assetstrackback.dto.AssetsTrackbackDTO;
import avicit.assets.device.assetstrackback.service.AssetsTrackbackService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:35
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetstrackback/assetsTrackbackController")
public class AssetsTrackbackController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsTrackbackController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsTrackbackService assetsTrackbackService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsTrackbackManage")
	public ModelAndView toAssetsTrackbackManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetstrackback/AssetsTrackbackManage");
		mav.addObject("url", "platform/assets/device/assetstrackback/assetsTrackbackController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getAssetsTrackbacksByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsTrackbackByPage(PageParameter pageParameter, HttpServletRequest request)
			throws Exception {
		QueryReqBean<AssetsTrackbackDTO> queryReqBean = new QueryReqBean<AssetsTrackbackDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsTrackbackDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTrackbackDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTrackbackDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsTrackbackDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsTrackbackDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsTrackbackDTO>() {
			});
		} else {
			param = new AssetsTrackbackDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);

		try {
			if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
				result = assetsTrackbackService.searchAssetsTrackbackByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsTrackbackService.searchAssetsTrackbackByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsTrackbackDTO dto : result.getResult()) {

			dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));

			dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setDeviceUserIdAlias(sysUserLoader.getSysUserNameById(dto.getDeviceUserId()));

			dto.setDeviceUserDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeviceUserDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
					dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));

			dto.setMeterConclusion(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
					dto.getMeterConclusion(), sysApplicationAPI.getCurrentAppId()));

			dto.setHasEffection(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("HAS_EFFECTION",
					dto.getHasEffection(), sysApplicationAPI.getCurrentAppId()));

		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsTrackbackDTO分页数据");
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
			AssetsTrackbackDTO dto = assetsTrackbackService.queryAssetsTrackbackByPrimaryKey(id);

			dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));
			dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setDeviceUserIdAlias(sysUserLoader.getSysUserNameById(dto.getDeviceUserId()));
			dto.setDeviceUserDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeviceUserDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));

			mav.addObject("assetsTrackbackDTO", dto);
			mav.addObject("id", id);
		}
		mav.setViewName("avicit/assets/device/assetstrackback/" + "AssetsTrackback" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param id 主键id
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsTrackbackDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		String returnId = "";
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsTrackbackDTO assetsTrackbackDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsTrackbackDTO>() {
					});
			if (StringUtils.isEmpty(assetsTrackbackDTO.getId())) {//新增
				returnId = assetsTrackbackService.insertAssetsTrackback(assetsTrackbackDTO);
			} else {//修改
				returnId = assetsTrackbackDTO.getId();
				assetsTrackbackService.updateAssetsTrackbackSensitive(assetsTrackbackDTO);
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
	public ModelAndView toDeleteAssetsTrackbackDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsTrackbackService.deleteAssetsTrackbackByIds(ids);
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
			AssetsTrackbackDTO assetsTrackback = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsTrackbackDTO>() {
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
			StartResultBean result = assetsTrackbackService.insertAssetsTrackbackAndStartProcess(assetsTrackback,
					parameter);

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
		AssetsTrackbackDTO dto = assetsTrackbackService.queryAssetsTrackbackByPrimaryKey(id);

		dto.setApplicantIdAlias(sysUserLoader.getSysUserNameById(dto.getApplicantId()));

		dto.setApplicantDepartAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplicantDepart(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setDeviceUserIdAlias(sysUserLoader.getSysUserNameById(dto.getDeviceUserId()));

		dto.setDeviceUserDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDeviceUserDept(),
				SessionHelper.getCurrentLanguageCode()));

		dto.setMeterPersonAlias(sysUserLoader.getSysUserNameById(dto.getMeterPerson()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsTrackbackDTO", dto);
		return mav;
	}
}
