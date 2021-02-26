package avicit.assets.device.assetsdevicemchecktemporary.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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

import avicit.assets.device.assetsdevicemchecktemporary.dto.AssetsDeviceMcheckTemporaryDTO;
import avicit.assets.device.assetsdevicemchecktemporary.service.AssetsDeviceMcheckTemporaryService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 16:09
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdevicemchecktemporary/assetsDeviceMcheckTemporaryController")
public class AssetsDeviceMcheckTemporaryController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMcheckTemporaryController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsDeviceMcheckTemporaryService assetsDeviceMcheckTemporaryService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsDeviceMcheckTemporaryManage")
	public ModelAndView toAssetsDeviceMcheckTemporaryManage(HttpServletRequest request, HttpServletResponse reponse) {
		String appId = sysApplicationAPI.getCurrentAppId();
		ModelAndView mav = new ModelAndView();

		Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY",
				appId);
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
		mav.setViewName("avicit/assets/device/assetsdevicemchecktemporary/AssetsDeviceMcheckTemporaryManage");
		mav.addObject("url",
				"platform/assets/device/assetsdevicemchecktemporary/assetsDeviceMcheckTemporaryController/operation/");
		return mav;
	}

	/**
	* 分页查询方法
	* @param pageParameter 查询条件
	* @param request 请求
	* @return Map<String,Object>
	*/
	@RequestMapping(value = "/operation/getAssetsDeviceMcheckTemporarysByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsDeviceMcheckTemporaryByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsDeviceMcheckTemporaryDTO> queryReqBean = new QueryReqBean<AssetsDeviceMcheckTemporaryDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsDeviceMcheckTemporaryDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckTemporaryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsDeviceMcheckTemporaryDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsDeviceMcheckTemporaryDTO param = null;
		QueryRespBean<AssetsDeviceMcheckTemporaryDTO> result = null;
		if (json != null && !"".equals(json)) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsDeviceMcheckTemporaryDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsDeviceMcheckTemporaryService.searchAssetsDeviceMcheckTemporaryByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsDeviceMcheckTemporaryService.searchAssetsDeviceMcheckTemporaryByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsDeviceMcheckTemporaryDTO dto : result.getResult()) {

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
		logger.info("成功获取AssetsDeviceMcheckTemporaryDTO分页数据");
		return map;
	}

	/**
	* 新增或修改对象
	* @param request 请求
	* @return AvicitResponseBody
	*/
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	@ResponseBody
	public AvicitResponseBody saveOrUpdateAssetsDeviceMcheckTemporary(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsDeviceMcheckTemporaryDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsDeviceMcheckTemporaryDTO>>() {
					});
			assetsDeviceMcheckTemporaryService.insertOrUpdateAssetsDeviceMcheckTemporary(list);
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
	public ModelAndView deleteAssetsDeviceMcheckTemporary(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceMcheckTemporaryService.deleteAssetsDeviceMcheckTemporaryByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 清空数据表
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/deleteAll",method = RequestMethod.POST)
	public ModelAndView tpDeleteAllAssetsDeviceAcheckTemporaryDTO(){
		ModelAndView mav = new ModelAndView();
		try {
			assetsDeviceMcheckTemporaryService.deleteAssetsDeviceMcheckTemporaryAll();
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
	public ModelAndView toSaveorSelectAssetsDevicAMcheckTemporaryDTO(HttpServletRequest request){
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
			assetsDeviceMcheckTemporaryService.saveAssetsDeviceMcheckTemporary(ids,endDate);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
