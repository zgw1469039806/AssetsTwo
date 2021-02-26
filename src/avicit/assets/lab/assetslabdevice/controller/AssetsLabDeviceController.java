package avicit.assets.lab.assetslabdevice.controller;

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

import avicit.assets.lab.assetslabdevice.dto.AssetsLabDeviceDTO;
import avicit.assets.lab.assetslabdevice.service.AssetsLabDeviceService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 15:47
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/lab/assetslabdevice/assetsLabDeviceController")
public class AssetsLabDeviceController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsLabDeviceController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsLabDeviceService assetsLabDeviceService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsLabDeviceManage")
	public ModelAndView toAssetsLabDeviceManage(HttpServletRequest request, HttpServletResponse reponse) {
		String appId = sysApplicationAPI.getCurrentAppId();
		ModelAndView mav = new ModelAndView();

		Collection<SysLookupSimpleVo> deviceStateList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_STATE",
				appId);
		HashMap<String, String> deviceStateMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : deviceStateList) {
			deviceStateMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("deviceStateData", JsonHelper.getInstance().writeValueAsString(deviceStateMap));
		Collection<SysLookupSimpleVo> orderStateList = sysLookupLoader.getLookUpListByTypeByAppId("ORDER_STATE", appId);
		HashMap<String, String> orderStateMap = new LinkedHashMap<String, String>();
		for (SysLookupSimpleVo vo : orderStateList) {
			orderStateMap.put(vo.getLookupCode(), vo.getLookupName());
		}
		mav.addObject("orderStateData", JsonHelper.getInstance().writeValueAsString(orderStateMap));
		mav.setViewName("avicit/assets/lab/assetslabdevice/AssetsLabDeviceManage");
		mav.addObject("url", "platform/assets/lab/assetslabdevice/assetsLabDeviceController/operation/");
		return mav;
	}

	/**
	* 分页查询方法
	* @param pageParameter 查询条件
	* @param request 请求
	* @return Map<String,Object>
	*/
	@RequestMapping(value = "/operation/getAssetsLabDevicesByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsLabDeviceByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<AssetsLabDeviceDTO> queryReqBean = new QueryReqBean<AssetsLabDeviceDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsLabDeviceDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsLabDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsLabDeviceDTO param = null;
		QueryRespBean<AssetsLabDeviceDTO> result = null;
		if (json != null && !"".equals(json)) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsLabDeviceDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsLabDeviceService.searchAssetsLabDeviceByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsLabDeviceService.searchAssetsLabDeviceByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}
		int index = 0;//列表序号
		for (AssetsLabDeviceDTO dto : result.getResult()) {

			index++;//列表序号遍历
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			dto.setDeviceStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
					dto.getDeviceState(), sysApplicationAPI.getCurrentAppId()));

			dto.setOrderStateName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ORDER_STATE",
					dto.getOrderState(), sysApplicationAPI.getCurrentAppId()));

			result.getResult().get(index - 1).setSerialNumber("" + index);//序号SerialNumber赋值
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsLabDeviceDTO分页数据");
		return map;
	}

	/**
	* 新增或修改对象
	* @param request 请求
	* @return AvicitResponseBody
	*/
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	@ResponseBody
	public AvicitResponseBody saveOrUpdateAssetsLabDevice(HttpServletRequest request) {
		String datas = ServletRequestUtils.getStringParameter(request, "data", "");
		if ("".equals(datas)) {
			return new AvicitResponseBody(OpResult.success);
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			List<AssetsLabDeviceDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
					new TypeReference<List<AssetsLabDeviceDTO>>() {
					});
			assetsLabDeviceService.insertOrUpdateAssetsLabDevice(list);
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
	public ModelAndView deleteAssetsLabDevice(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsLabDeviceService.deleteAssetsLabDeviceByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
