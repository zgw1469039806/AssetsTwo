package avicit.assets.device.assetsstdtempapplyproc.controller;

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

import avicit.assets.device.assetsstdtempapplyproc.service.AssetsStdtempapplyProcService;
import avicit.assets.device.assetsstdtempapplyproc.service.AssetsSupplierService;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsStdtempapplyProcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 16:59
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController")
public class AssetsStdtempapplyProcController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsStdtempapplyProcController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsStdtempapplyProcService assetsStdtempapplyProcService;
    @Autowired

    private AssetsSupplierService assetsSupplierServiceSub;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsStdtempapplyProcManage")
    public ModelAndView toAssetsStdtempapplyProcManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsstdtempapplyproc/AssetsStdtempapplyProcManage");
        mav.addObject("url", "platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/");
        mav.addObject("surl", "platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/sub/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsStdtempapplyProcsByPage")
    @ResponseBody
    public Map<String, Object> toGetAssetsStdtempapplyProcByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsStdtempapplyProcDTO> queryReqBean = new QueryReqBean<AssetsStdtempapplyProcDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsStdtempapplyProcDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsStdtempapplyProcDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsStdtempapplyProcDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsStdtempapplyProcDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsStdtempapplyProcDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsStdtempapplyProcDTO>() {
            });
        } else {
            param = new AssetsStdtempapplyProcDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = assetsStdtempapplyProcService.searchAssetsStdtempapplyProcByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsStdtempapplyProcService.searchAssetsStdtempapplyProcByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        int num =0;
        for (AssetsStdtempapplyProcDTO dto : result.getResult()) {
            num++;
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL", dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));
            dto.setDeviceType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE", dto.getDeviceType(), sysApplicationAPI.getCurrentAppId()));
            dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsSceneMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsMaintain(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMaintain(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsAccuracyCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsRegularCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsSpotCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsSpecialDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsPrecisionIndex(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPrecisionIndex(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsNeedInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsFoundation(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundation(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsSafetyProduction(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));
            dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));
            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
            dto.setDemandUrgencyDegree(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEMAND_URGENCY_DEGREE", dto.getDemandUrgencyDegree(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsTrain(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTrain(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsPc(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPc(), sysApplicationAPI.getCurrentAppId()));
            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));
            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));
            dto.setIsWireless(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWireless(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsWeedOut(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWeedOut(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsBearingMeet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsBearingMeet(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsOutdoorUnit(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsAllowOutdoorUnit(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAllowOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsNeedFoundation(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedFoundation(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsFoundationCondition(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundationCondition(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsVoltageCondition(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsVoltageCondition(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsHumidityNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsCleanlinessNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsCleanlinessNeed(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsWaterNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsGasNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsLet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsOtherNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsNoise(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoise(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsNoiseInfluence(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoiseInfluence(), sysApplicationAPI.getCurrentAppId()));
            dto.setLargeDeviceType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("simple_large_scale", dto.getLargeDeviceType(), sysApplicationAPI.getCurrentAppId()));
            dto.setInstituteOrCompany(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("LARGE_DEVICE_TYPE", dto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId()));
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));
            result.getResult().get(num-1).setAttribute18((long)num);
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsStdtempapplyProcDTO分页数据");
        return map;
    }

    /**
     * 根据id选择跳转到新建页还是编辑页
     *
     * @param type    操作类型新建还是编辑
     * @param id      编辑数据的id
     * @param request 请求
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/{type}/{id}")
    public ModelAndView toOpertionPage(@PathVariable String type,
                                       @PathVariable String id,
                                       HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsStdtempapplyProcDTO dto = assetsStdtempapplyProcService.queryAssetsStdtempapplyProcByPrimaryKey(id);
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));
            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));

            String appId = sysApplicationAPI.getCurrentAppId();
            mav.addObject("assetsStdtempapplyProcDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsstdtempapplyproc/" + "AssetsStdtempapplyProc" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsStdtempapplyProcDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<AssetsStdtempapplyProcDTO>() {
            });
            if (StringUtils.isEmpty(assetsStdtempapplyProcDTO.getId())) {//新增
                assetsStdtempapplyProcService.insertAssetsStdtempapplyProc(assetsStdtempapplyProcDTO);
            } else {//修改
                assetsStdtempapplyProcService.updateAssetsStdtempapplyProcSensitive(assetsStdtempapplyProcDTO);
            }
            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", assetsStdtempapplyProcDTO.getId());
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            mav.addObject("msg", ex.getMessage());
            return mav;
        }
        return mav;
    }

    /**
     * 按照id批量删除数据
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsStdtempapplyProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsStdtempapplyProcService.deleteAssetsStdtempapplyProcByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 新增并启动流程
     *
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
            AssetsStdtempapplyProcDTO assetsStdtempapplyProc = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<AssetsStdtempapplyProcDTO>() {
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
            StartResultBean result = assetsStdtempapplyProcService.insertAssetsStdtempapplyProcAndStartProcess(assetsStdtempapplyProc, parameter);

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
     *
     * @param request 求情
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/toDetailJsp")
    public ModelAndView toDetailJsp(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        String id = request.getParameter("id");
        AssetsStdtempapplyProcDTO dto = assetsStdtempapplyProcService.queryAssetsStdtempapplyProcByPrimaryKey(id);


        dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));


        dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));


        dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));


        dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));

        dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));


        dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));

        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsStdtempapplyProcDTO", dto);

        return mav;
    }

    /****************************子表操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/sub/getAssetsSupplier", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAssetsSupplierByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsSupplierDTO> queryReqBean = new QueryReqBean<AssetsSupplierDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsSupplierDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSupplierDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSupplierDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsSupplierDTO param = null;
        QueryRespBean<AssetsSupplierDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsSupplierDTO>() {
            });
            param.setLevelUpId(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsSupplierDTO();
            param.setLevelUpId(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsSupplierServiceSub.searchAssetsSupplierByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsSupplierServiceSub.searchAssetsSupplierByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsSupplierDTO dto : result.getResult()) {


        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsSupplierDTO分页数据");
        return map;
    }

    /**
     * 根据id选择跳转到新建页还是编辑页
     *
     * @param type    操作类型新建还是编辑
     * @param id      编辑数据的id
     * @param request 请求
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/sub/{type}/{id}")
    public ModelAndView toOpertionSubPage(@PathVariable String type,
                                          @PathVariable String id,
                                          HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsSupplierDTO dto = assetsSupplierServiceSub.queryAssetsSupplierByPrimaryKey(id);

            mav.addObject("assetsSupplierDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/assetsstdtempapplyproc/" + "AssetsSupplier" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAssetsSupplierDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AssetsSupplierDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat, new TypeReference<List<AssetsSupplierDTO>>() {
            });
            assetsSupplierServiceSub.insertOrUpdateAssetsSupplier(list, pid);
            return new AvicitResponseBody(OpResult.success);
        } catch (Exception ex) {
            return new AvicitResponseBody(OpResult.failure, ex.getMessage());
        }
    }

    /**
     * 按照id批量删除数据
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsSupplierDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsSupplierServiceSub.deleteAssetsSupplierByIds(ids);
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
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

}
