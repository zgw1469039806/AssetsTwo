package avicit.assets.device.assetsdeviceregularcheck.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.web.AvicitResponseBody;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.commons.utils.ComUtil;

import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
import avicit.assets.device.assetsdeviceregularcheck.service.AssetsDeviceRegularCheckService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-03 15:41
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController")
public class AssetsDeviceRegularCheckController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceRegularCheckController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceRegularCheckService assetsDeviceRegularCheckService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceRegularCheckManage")
	public ModelAndView toAssetsDeviceRegularCheckManage(HttpServletRequest request, HttpServletResponse reponse) {
		String appId = sysApplicationAPI.getCurrentAppId();
		ModelAndView mav = new ModelAndView();

		Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY",
				appId);
		HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : deviceCategoryList) {
			deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
		Collection<SysLookupSimpleVo> regularCheckModeList = sysLookupLoader
				.getLookUpListByTypeByAppId("REGULAR_CHECK_MODE", appId);
		HashMap<String, String> regularCheckModeMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : regularCheckModeList) {
			regularCheckModeMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("regularCheckModeData", JsonHelper.getInstance().writeValueAsString(regularCheckModeMap));
		Collection<SysLookupSimpleVo> regularCheckConclutionList = sysLookupLoader
				.getLookUpListByTypeByAppId("REGULAR_CHECK_CONCLUTION", appId);
		HashMap<String, String> regularCheckConclutionMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : regularCheckConclutionList) {
			regularCheckConclutionMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("regularCheckConclutionData",
				JsonHelper.getInstance().writeValueAsString(regularCheckConclutionMap));
		mav.setViewName("avicit/assets/device/assetsdeviceregularcheck/AssetsDeviceRegularCheckManage");
		mav.addObject("url",
				"platform/assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController/operation/");

		mav.addObject("unifiedId", "''");//将''字符串传递给详情页的Tab页，保证给unifiedId的赋值不报错

		return mav;
	}

	/**
	 * 跳转到管理页面（跳转时向后台传递统一编号参数）
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceRegularCheckManage/{unifiedId}")
	public ModelAndView toAssetsDeviceRegularCheckManage(HttpServletRequest request, HttpServletResponse reponse, @PathVariable String unifiedId) {
		String appId = sysApplicationAPI.getCurrentAppId();
		ModelAndView mav = new ModelAndView();

		Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY",
				appId);
		HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : deviceCategoryList) {
			deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
		Collection<SysLookupSimpleVo> regularCheckModeList = sysLookupLoader
				.getLookUpListByTypeByAppId("REGULAR_CHECK_MODE", appId);
		HashMap<String, String> regularCheckModeMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : regularCheckModeList) {
			regularCheckModeMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("regularCheckModeData", JsonHelper.getInstance().writeValueAsString(regularCheckModeMap));
		Collection<SysLookupSimpleVo> regularCheckConclutionList = sysLookupLoader
				.getLookUpListByTypeByAppId("REGULAR_CHECK_CONCLUTION", appId);
		HashMap<String, String> regularCheckConclutionMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : regularCheckConclutionList) {
			regularCheckConclutionMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("regularCheckConclutionData",
				JsonHelper.getInstance().writeValueAsString(regularCheckConclutionMap));
		mav.setViewName("avicit/assets/device/assetsdeviceregularcheck/AssetsDeviceRegularCheckManage");
		mav.addObject("url",
				"platform/assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController/operation/");

		mav.addObject("unifiedId", unifiedId);//将统一编号传递给详情页的Tab页

		return mav;
	}

	/**
	* 分页查询方法
	* @param pageParameter 查询条件
	* @param request 请求
	* @return Map<String,Object>
	*/
	@RequestMapping(value = "/operation/getAssetsDeviceRegularChecksByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsDeviceRegularCheckByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceRegularCheckDTO> queryReqBean = new QueryReqBean<AssetsDeviceRegularCheckDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");//字段查询条件
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");//排序方式
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");//排序字段
		if (!StringUtils.isEmpty(keyWord)) {
			json = keyWord;
		}
		String orderBy = "";
		String cloumnName = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			cloumnName = ComUtil.getColumn(AssetsDeviceRegularCheckDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceRegularCheckDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceRegularCheckDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceRegularCheckDTO param = null;
		QueryRespBean<AssetsDeviceRegularCheckDTO> result = null;
		if (json != null && !"".equals(json)) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsDeviceRegularCheckDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceRegularCheckService.searchAssetsDeviceRegularCheckByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsDeviceRegularCheckService.searchAssetsDeviceRegularCheckByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceRegularCheckDTO dto : result.getResult()) {

			dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
					dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setRegularCheckModeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("REGULAR_CHECK_MODE",
					dto.getRegularCheckMode(), sysApplicationAPI.getCurrentAppId()));

			dto.setRegularCheckConclutionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
					"REGULAR_CHECK_CONCLUTION", dto.getRegularCheckConclution(), sysApplicationAPI.getCurrentAppId()));

		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsDeviceRegularCheckDTO分页数据");
		return map;
	}

	/**
	* 新增或修改对象
	* @param request 请求
	* @return AvicitResponseBody
	*/
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	@ResponseBody
	public AvicitResponseBody saveOrUpdateAssetsDeviceRegularCheck(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsDeviceRegularCheckDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsDeviceRegularCheckDTO>>() {
					});
			assetsDeviceRegularCheckService.insertOrUpdateAssetsDeviceRegularCheck(list);
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
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView deleteAssetsDeviceRegularCheck(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceRegularCheckService.deleteAssetsDeviceRegularCheckByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
