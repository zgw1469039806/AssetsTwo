package avicit.assets.device.assetstechtransformproject.controller;

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
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.api.application.SysApplicationAPI;

import avicit.assets.device.assetstechtransformproject.service.AssetsTechTransformProjectService;
import avicit.assets.device.assetstechtransformproject.service.AssetsTechTransformDeviceService;
import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformProjectDTO;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 09:54
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetstechtransformproject/assetsTechTransformProjectController")
public class AssetsTechTransformProjectController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsTechTransformProjectController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;

	@Autowired
	private AssetsTechTransformProjectService assetsTechTransformProjectService;

	@Autowired
	private AssetsTechTransformDeviceService assetsTechTransformDeviceService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsTechTransformProjectManage")
	public ModelAndView toAssetsTechTransformProjectManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetstechtransformproject/AssetsTechTransformProjectManage");
		mav.addObject("url", "platform/assets/device/assetstechtransformproject/assetsTechTransformProjectController/operation/");
		mav.addObject("urlDevice","platform/assets/device/assetstechtransformdevice/assetsTechTransformDeviceController/operation/");
		mav.addObject("urlTeam","platform/assets/device/assetstechtransformperson/assetsTechTransformPersonController/operation/");
		return mav;
	}

	/**
	 * 跳转到关联技改项目页面
	 *
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toRelateTechTransformProject")
	public ModelAndView toRelateTechTransformProject(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("url", "platform/assets/device/assetstechtransformproject/assetsTechTransformProjectController/operation/");
		mav.setViewName("avicit/assets/device/assetstechtransformproject/RelateTechTransformProject");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getAssetsTechTransformProjectsByPage")
	@ResponseBody
	public Map<String, Object> toGetAssetsTechTransformProjectByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<AssetsTechTransformProjectDTO> queryReqBean = new QueryReqBean<AssetsTechTransformProjectDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsTechTransformProjectDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTechTransformProjectDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsTechTransformProjectDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}
		AssetsTechTransformProjectDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsTechTransformProjectDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsTechTransformProjectDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = assetsTechTransformProjectService.searchAssetsTechTransformProjectByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsTechTransformProjectService.searchAssetsTechTransformProjectByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsTechTransformProjectDTO dto : result.getResult()) {
			dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));
			dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsTechTransformProjectDTO分页数据");
		return map;
	}

	/**
	 * 根据id选择跳转到技改项目新建页还是编辑页
	 * @param type 操作类型新建还是编辑
	 * @param id 编辑数据的id
	 * @param request 请求
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
			//主表数据
			AssetsTechTransformProjectDTO dto = assetsTechTransformProjectService.queryAssetsTechTransformProjectByPrimaryKey(id);

			dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));

			dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

			mav.addObject("assetsTechTransformProjectDTO", dto);
		}
		mav.setViewName("avicit/assets/device/assetstechtransformproject/" + "AssetsTechTransformProject" + type);
		return mav;
	}

	/**
	 * 保存技改项目数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsTechTransformProjectDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsTechTransformProjectDTO assetsTechTransformProjectDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsTechTransformProjectDTO>() {});

			if (StringUtils.isEmpty(assetsTechTransformProjectDTO.getId())) {//新增
				Integer projectCount = assetsTechTransformProjectService.getTechTransformProjectCount(assetsTechTransformProjectDTO.getProjectNo(), null);

				if(projectCount == 0){
					assetsTechTransformProjectService.insertAssetsTechTransformProject(assetsTechTransformProjectDTO);
				}
				else{
					mav.addObject("flag", OpResult.failure);
					mav.addObject("msg", "该项目序号已存在，请修改项目序号！");
					return mav;
				}
			}
			else {//修改
				Integer projectCount = assetsTechTransformProjectService.getTechTransformProjectCount(assetsTechTransformProjectDTO.getProjectNo(), assetsTechTransformProjectDTO.getId());

				if(projectCount == 0){
					assetsTechTransformProjectService.updateAssetsTechTransformProjectSensitive(assetsTechTransformProjectDTO);
				}
				else{
					mav.addObject("flag", OpResult.failure);
					mav.addObject("msg", "该项目序号已存在，请修改项目序号！");
					return mav;
				}
			}
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			mav.addObject("msg", ex.getMessage());
			return mav;
		}
		return mav;
	}

	/**
	 * 按照id批量删除技改项目数据
	 * @param ids id数组
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteAssetsTechTransformProjectDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			for(String id : ids){
				assetsTechTransformProjectService.deleteAssetsTechTransformProjectById(id);
				assetsTechTransformDeviceService.deleteAssetsTechTransformDeviceByProjectId(id);
			}

			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
