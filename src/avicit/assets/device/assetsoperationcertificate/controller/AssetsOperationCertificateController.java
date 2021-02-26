package avicit.assets.device.assetsoperationcertificate.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
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
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.application.SysApplicationAPI;

import avicit.assets.device.assetsoperationcertificate.service.AssetsOperationCertificateService;
import avicit.assets.device.assetsoperationcertificate.service.AssetsOperationDeviceService;
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationDeviceDTO;
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationCertificateDTO;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 14:05
 * @类说明：请填写
 * @修改记录： 
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsoperationcertificate/assetsOperationCertificateController")
public class AssetsOperationCertificateController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsOperationCertificateController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;
	@Autowired
	private AssetsOperationCertificateService assetsOperationCertificateService;
	@Autowired

	private AssetsOperationDeviceService assetsOperationDeviceServiceSub;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsOperationCertificateManage")
	public ModelAndView toAssetsOperationCertificateManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsoperationcertificate/AssetsOperationCertificateManage");
		mav.addObject("url",
				"platform/assets/device/assetsoperationcertificate/assetsOperationCertificateController/operation/");
		mav.addObject("surl",
				"platform/assets/device/assetsoperationcertificate/assetsOperationCertificateController/operation/sub/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsOperationCertificatesByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsOperationCertificateByPage(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsOperationCertificateDTO> queryReqBean = new QueryReqBean<AssetsOperationCertificateDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsOperationCertificateDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsOperationCertificateDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsOperationCertificateDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsOperationCertificateDTO param = null;
		QueryRespBean<AssetsOperationCertificateDTO> result = null;
		if (json != null && !"".equals(json)) {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsOperationCertificateDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsOperationCertificateService.searchAssetsOperationCertificateByPageOr(queryReqBean,
						orderBy);
			} else {
				result = assetsOperationCertificateService.searchAssetsOperationCertificateByPage(queryReqBean,
						orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		int index = 0;//列表序号
		for (AssetsOperationCertificateDTO dto : result.getResult()) {
			index++;//列表序号遍历
			dto.setCertificateType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("CERTIFICATE_TYPE",
					dto.getCertificateType(), sysApplicationAPI.getCurrentAppId()));
			dto.setCertificateStatus(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("CERTIFICATE_STATUS",
					dto.getCertificateStatus(), sysApplicationAPI.getCurrentAppId()));
			dto.setHolderIdAlias(sysUserLoader.getSysUserNameById(dto.getHolderId()));
			dto.setHolderDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getHolderDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManagerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerIdAlias(sysUserLoader.getSysUserNameById(dto.getManagerId()));

			result.getResult().get(index - 1).setSerialNumber("" + index);//序号赋值并传递到前台
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsOperationCertificateDTO分页数据");
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
			AssetsOperationCertificateDTO dto = assetsOperationCertificateService
					.queryAssetsOperationCertificateByPrimaryKey(id);
			dto.setHolderIdAlias(sysUserLoader.getSysUserNameById(dto.getHolderId()));
			dto.setHolderDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getHolderDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManagerDept(),
					SessionHelper.getCurrentLanguageCode()));
			dto.setManagerIdAlias(sysUserLoader.getSysUserNameById(dto.getManagerId()));
			mav.addObject("assetsOperationCertificateDTO", dto);
		}
		mav.setViewName("avicit/assets/device/assetsoperationcertificate/" + "AssetsOperationCertificate" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsOperationCertificateDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			AssetsOperationCertificateDTO assetsOperationCertificateDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsOperationCertificateDTO>() {
					});
			if (StringUtils.isEmpty(assetsOperationCertificateDTO.getId())) {//新增
				assetsOperationCertificateService.insertAssetsOperationCertificate(assetsOperationCertificateDTO);
			} else {//修改
				assetsOperationCertificateService
						.updateAssetsOperationCertificateSensitive(assetsOperationCertificateDTO);
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
	public ModelAndView toDeleteAssetsOperationCertificateDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsOperationCertificateService.deleteAssetsOperationCertificateByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/****************************子表操作*****************************
	/**
	 * 按照pid查找子表数据
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/sub/getAssetsOperationDevice", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toGetAssetsOperationDeviceByPid(PageParameter pageParameter,
			HttpServletRequest request) {
		QueryReqBean<AssetsOperationDeviceDTO> queryReqBean = new QueryReqBean<AssetsOperationDeviceDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsOperationDeviceDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsOperationDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsOperationDeviceDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsOperationDeviceDTO param = null;
		QueryRespBean<AssetsOperationDeviceDTO> result = null;

		if (pid == null || "".equals(pid)) {
			pid = "-1";
		}
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsOperationDeviceDTO>() {
			});
			param.setCertificateId(pid);
			queryReqBean.setSearchParams(param);
		} else {
			param = new AssetsOperationDeviceDTO();
			param.setCertificateId(pid);
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsOperationDeviceServiceSub.searchAssetsOperationDeviceByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsOperationDeviceServiceSub.searchAssetsOperationDeviceByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		int index = 0;//列表序号
		for (AssetsOperationDeviceDTO dto : result.getResult()) {
			index++;//列表序号遍历
			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));

			result.getResult().get(index - 1).setSerialNumber("" + index);//序号赋值并传递到前台
		}
		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsOperationDeviceDTO分页数据");
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
			AssetsOperationDeviceDTO dto = assetsOperationDeviceServiceSub.queryAssetsOperationDeviceByPrimaryKey(id);

			dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
			dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
					SessionHelper.getCurrentLanguageCode()));
			mav.addObject("assetsOperationDeviceDTO", dto);
		} else {
			mav.addObject("pid", id);
		}
		mav.setViewName("avicit/assets/device/assetsoperationcertificate/" + "AssetsOperationDevice" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsOperationDeviceDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsOperationDeviceDTO assetsOperationDeviceDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
					new TypeReference<AssetsOperationDeviceDTO>() {
					});
			if ("".equals(assetsOperationDeviceDTO.getId())) {//新增
				assetsOperationDeviceServiceSub.insertAssetsOperationDevice(assetsOperationDeviceDTO);
			} else {//修改
				assetsOperationDeviceServiceSub.updateAssetsOperationDeviceSensitive(assetsOperationDeviceDTO);
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
	@RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsOperationDeviceDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsOperationDeviceServiceSub.deleteAssetsOperationDeviceByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

}
