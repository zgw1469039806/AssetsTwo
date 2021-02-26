package avicit.assets.device.assetsdevicerchecktemporary.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
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
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
import avicit.assets.device.assetsdevicerchecktemporary.service.AssetsDeviceRcheckTemporaryService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-01 19:37
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdevicerchecktemporary/assetsDeviceRcheckTemporaryController")
public class AssetsDeviceRcheckTemporaryController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceRcheckTemporaryController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceRcheckTemporaryService assetsDeviceRcheckTemporaryService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceRcheckTemporaryManage")
	public ModelAndView toAssetsDeviceRcheckTemporaryManage(HttpServletRequest request, HttpServletResponse reponse) {
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
		mav.setViewName("avicit/assets/device/assetsdevicerchecktemporary/AssetsDeviceRcheckTemporaryManage");
		mav.addObject("url",
				"platform/assets/device/assetsdevicerchecktemporary/assetsDeviceRcheckTemporaryController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsDeviceRcheckTemporarysByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsDeviceRcheckTemporaryByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceRcheckTemporaryDTO> queryReqBean = new QueryReqBean<AssetsDeviceRcheckTemporaryDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceRcheckTemporaryDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceRcheckTemporaryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceRcheckTemporaryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceRcheckTemporaryDTO param = null;
	
		QueryRespBean<AssetsDeviceRcheckTemporaryDTO> result = null;
		if (json != null && !"".equals(json)) {
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsDeviceRcheckTemporaryDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceRcheckTemporaryService.searchAssetsDeviceRcheckTemporaryByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsDeviceRcheckTemporaryService.searchAssetsDeviceRcheckTemporaryByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceRcheckTemporaryDTO dto : result.getResult()) {

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
		LOGGER.info("成功获取AssetsDeviceRcheckTemporaryDTO分页数据");
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
			AssetsDeviceRcheckTemporaryDTO dto = assetsDeviceRcheckTemporaryService
					.queryAssetsDeviceRcheckTemporaryByPrimaryKey(id);

		//	dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

			//dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			mav.addObject("assetsDeviceRcheckTemporaryDTO", dto);
		}
		mav.setViewName("avicit/assets/device/assetsdevicerchecktemporary/" + "AssetsDeviceRcheckTemporary" + type);
		return mav;
	}

	/**
	 * 保存数据
	 *
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsDeviceRcheckTemporaryDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsDeviceRcheckTemporaryDTO>() {
					});
			if (StringUtils.isEmpty(assetsDeviceRcheckTemporaryDTO.getId())) {//新增
				assetsDeviceRcheckTemporaryService.insertAssetsDeviceRcheckTemporary(assetsDeviceRcheckTemporaryDTO);
			} else {//修改
				assetsDeviceRcheckTemporaryService
						.updateAssetsDeviceRcheckTemporarySensitive(assetsDeviceRcheckTemporaryDTO);
			}
			mav.addObject("flag", OpResult.success);
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
	public ModelAndView toDeleteAssetsDeviceRcheckTemporaryDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceRcheckTemporaryService.deleteAssetsDeviceRcheckTemporaryByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 情况数据表
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/deleteAll",method = RequestMethod.POST)
	public ModelAndView tpDeleteAllAssetsDeviceRcheckTemporaryDTO(){
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceRcheckTemporaryService.deleteAssetsDeviceRcheckTemporaryAll();
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return  mav;
	}

	/**
	 * 生成定检计划临时表数据
	 *
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/saveOrSelect", method = RequestMethod.POST)
	public ModelAndView toSaveorSelectAssetsDeviceRcheckTemporaryDTO(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String id = ServletRequestUtils.getStringParameter(request, "ids","");
		String time = ServletRequestUtils.getStringParameter(request, "endDate","");
		Date endDate = null;
		try {
			endDate=dateFormat.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		id = id.replace("[","");
		 id= id.replace("]","");
		 String []ids= id.split(",");
		try {
			assetsDeviceRcheckTemporaryService.saveAssetsDeviceRcheckTemporary(ids,endDate);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
