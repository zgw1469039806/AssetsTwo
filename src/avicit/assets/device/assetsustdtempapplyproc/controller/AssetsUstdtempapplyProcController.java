package avicit.assets.device.assetsustdtempapplyproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.classifydata.dto.ClassifyDataDTO;
import avicit.assets.device.classifydata.service.ClassifyDataService;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;
import avicit.platform6.api.sysuser.dto.SysUser;
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
import avicit.assets.device.assetsustdtempapplyproc.dto.AssetsUstdtempapplyProcDTO;
import avicit.assets.device.assetsustdtempapplyproc.service.AssetsUstdtempapplyProcService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-23 16:56
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsustdtempapplyproc/assetsUstdtempapplyProcController")
public class AssetsUstdtempapplyProcController implements LoaderConstant {
	private static final Logger logger = LoggerFactory.getLogger(AssetsUstdtempapplyProcController.class);

	@Autowired
	private SysApplicationAPI sysApplicationAPI;

	@Autowired
	private AssetsUstdtempapplyProcService assetsUstdtempapplyProcService;

	@Autowired
	private UserTableModelService userTableModelService;

	@Autowired
	private ClassifyDataService classifyDataService;

	/**
	 * 跳转到管理页面
	 * @param request 请求
	 * @param reponse 响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toAssetsUstdtempapplyProcManage")
	public ModelAndView toAssetsUstdtempapplyProcManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/assets/device/assetsustdtempapplyproc/AssetsUstdtempapplyProcManage");
		mav.addObject("url","platform/assets/device/assetsustdtempapplyproc/assetsUstdtempapplyProcController/operation/");

		/*用户视图、默认表头获取代码——开始*/
		SysUser user = SessionHelper.getLoginSysUser(request);	//获取当前登录用户

		//获取用户视图列表
		List<String> viewList = new ArrayList<>();
		try {
			viewList = userTableModelService.getUserViewList(user.getId(),"AssetsUstdtempapplyProc");
			mav.addObject("viewList", viewList);
		} catch (Exception e) {
			e.printStackTrace();
		}

        //获取表头字段
        try {
			StringBuffer dataGridColModelJson = new StringBuffer();
			dataGridColModelJson.append("[");

            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AssetsUstdtempapplyProc", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "AssetsUstdtempapplyProc", "系统默认视图", "Y");
            }

            for(int i=0; i<modelList.size(); i++){
                if(i == 0){
                    dataGridColModelJson.append(modelList.get(i).getFieldModel());
                }
                else{
                    dataGridColModelJson.append("," + modelList.get(i).getFieldModel());
                }
            }
			dataGridColModelJson.append("]");
            mav.addObject("dataGridColModelJson", dataGridColModelJson.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
		/*用户视图、默认表头获取代码——结束*/

		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter 查询条件
	 * @param request 请求
	 * @return Map<String,Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/getAssetsUstdtempapplyProcsByPage")
	@ResponseBody
	public Map<String, Object> togetAssetsUstdtempapplyProcByPage(PageParameter pageParameter,
																  HttpServletRequest request) throws Exception {
		QueryReqBean<AssetsUstdtempapplyProcDTO> queryReqBean = new QueryReqBean<AssetsUstdtempapplyProcDTO>();
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
			cloumnName = ComUtil.getColumn(AssetsUstdtempapplyProcDTO.class, sidx);
			if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
				orderBy = " " + cloumnName + " " + sord;
			} else {
				//判断是否为特殊控件导致字段无法匹配
				if (sidx.indexOf("Alias") != -1) {
					cloumnName = ComUtil.getColumn(AssetsUstdtempapplyProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Alias")));
				} else if (sidx.indexOf("Name") != -1) {
					cloumnName = ComUtil.getColumn(AssetsUstdtempapplyProcDTO.class,
							sidx.substring(0, sidx.lastIndexOf("Name")));
				}
				if (cloumnName != null) {
					orderBy = " " + cloumnName + " " + sord;
				}
			}
		}

		AssetsUstdtempapplyProcDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<AssetsUstdtempapplyProcDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<AssetsUstdtempapplyProcDTO>() {
					});
		} else {
			param = new AssetsUstdtempapplyProcDTO();
		}
		param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
		param.setBpmType("my");
		queryReqBean.setSearchParams(param);

		try {
			if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
				result = assetsUstdtempapplyProcService.searchAssetsUstdtempapplyProcByPageOr(queryReqBean, orderBy);
			} else {
				result = assetsUstdtempapplyProcService.searchAssetsUstdtempapplyProcByPage(queryReqBean, orderBy);
			}
		} catch (Exception ex) {
			return map;
		}

		for (AssetsUstdtempapplyProcDTO dto : result.getResult()) {
			dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
			dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));

			if(dto.getDeviceCategory() != null){
				ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(dto.getDeviceCategory());
				if(classifyDataDTO != null){
					dto.setDeviceCategory(classifyDataDTO.getName());
				}
			}

			dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));

			dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));
			dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
			dto.setIsNeedInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsHumidityNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));

			dto.setIsWaterNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsGasNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsLet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsOtherNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));

			dto.setIsAboveConditions(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAboveConditions(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));
			dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));
			dto.setIsTestDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId()));

			dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));
		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		logger.info("成功获取AssetsUstdtempapplyProcDTO分页数据");
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
			AssetsUstdtempapplyProcDTO dto = assetsUstdtempapplyProcService.queryAssetsUstdtempapplyProcByPrimaryKey(id);

			dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
			dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));
			dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));
			dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));

			dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
			dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));

			mav.addObject("assetsUstdtempapplyProcDTO", dto);
			mav.addObject("id", id);
		}

		mav.setViewName("avicit/assets/device/assetsustdtempapplyproc/" + "AssetsUstdtempapplyProc" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveAssetsUstdtempapplyProcDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		String returnId = "";
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO = JsonHelper.getInstance().readValue(jsonData,
					dateFormat, new TypeReference<AssetsUstdtempapplyProcDTO>() {
					});
			if (StringUtils.isEmpty(assetsUstdtempapplyProcDTO.getId())) {//新增
				returnId = assetsUstdtempapplyProcService.insertAssetsUstdtempapplyProc(assetsUstdtempapplyProcDTO);
			}
			else {//修改
				returnId = assetsUstdtempapplyProcDTO.getId();
				assetsUstdtempapplyProcService.updateAssetsUstdtempapplyProcSensitive(assetsUstdtempapplyProcDTO);
			}
			mav.addObject("flag", OpResult.success);
			mav.addObject("id", returnId);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			mav.addObject("msg", ex.getMessage());
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
	public ModelAndView toDeleteAssetsUstdtempapplyProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			assetsUstdtempapplyProcService.deleteAssetsUstdtempapplyProcByIds(ids);
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
			AssetsUstdtempapplyProcDTO assetsUstdtempapplyProc = JsonHelper.getInstance().readValue(data, dateFormat,
					new TypeReference<AssetsUstdtempapplyProcDTO>() {});

			String userId = SessionHelper.getLoginSysUserId(request);
			String deptId = SessionHelper.getCurrentDeptId(request);

			/////////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);

			StartResultBean result = assetsUstdtempapplyProcService.insertAssetsUstdtempapplyProcAndStartProcess(assetsUstdtempapplyProc, parameter);
			mav.addObject("flag", OpResult.success);
			mav.addObject("startResult", result);
		} catch (Exception ex) {
			mav.addObject("flag", OpResult.failure);
			mav.addObject("msg", ex.getMessage());
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
		AssetsUstdtempapplyProcDTO dto = assetsUstdtempapplyProcService.queryAssetsUstdtempapplyProcByPrimaryKey(id);

		dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
		dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));
		dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));
		dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));

		dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
		dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));

		mav.addObject("flag", OpResult.success);
		mav.addObject("assetsUstdtempapplyProcDTO", dto);
		return mav;
	}
}
