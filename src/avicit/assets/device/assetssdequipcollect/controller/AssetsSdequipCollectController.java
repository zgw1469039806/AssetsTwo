package avicit.assets.device.assetssdequipcollect.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;
import avicit.assets.device.assetsstdtempapplyproc.service.AssetsSupplierService;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-22 15:34
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetssdequipcollect/assetsSdequipCollectController")
public class AssetsSdequipCollectController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsSdequipCollectController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsSdequipCollectService assetsSdequipCollectService;
    @Autowired

    private AssetsSupplierService assetsSupplierServiceSub;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsSdequipCollectManage")
    public ModelAndView toAssetsSdequipCollectManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetssdequipcollect/AssetsSdequipCollectManage");
        request.setAttribute("url", "platform/assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/");
        request.setAttribute("surl", "platform/assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/sub/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String   ,   Object>
     */
    @RequestMapping(value = "/operation/getAssetsSdequipCollectsByPage")
    @ResponseBody
    public Map<String, Object> toGetAssetsSdequipCollectByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsSdequipCollectDTO> queryReqBean = new QueryReqBean<AssetsSdequipCollectDTO>();
        queryReqBean.setPageParameter(pageParameter);
        HashMap<String, Object> map = new HashMap<String, Object>();
        String json = ServletRequestUtils.getStringParameter(request, "param", "");
        String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
        String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
        String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");

        if (!"".equals(keyWord)) {
            json = keyWord;
        }
        String oderby = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            String cloumnName = ComUtil.getColumn(AssetsSdequipCollectDTO.class, sidx);
            if (cloumnName != null) {
                oderby = " " + cloumnName + " " + sord;
            }
        }
        AssetsSdequipCollectDTO param = null;
        QueryRespBean<AssetsSdequipCollectDTO> result = null;
        if (json != null && !"".equals(json)) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsSdequipCollectDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsSdequipCollectService.searchAssetsSdequipCollectByPageOr(queryReqBean, oderby);
            } else {
                result = assetsSdequipCollectService.searchAssetsSdequipCollectByPage(queryReqBean, oderby);
            }
        } catch (Exception ex) {
            return map;
        }
        for (AssetsSdequipCollectDTO dto : result.getResult()) {
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode(request)));
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
            dto.setDevicePurchaseType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_PURCHASE_TYPE", dto.getDevicePurchaseType(), sysApplicationAPI.getCurrentAppId()));
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
            dto.setAboveNeedHave(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getAboveNeedHave(), sysApplicationAPI.getCurrentAppId()));
            dto.setExamineApproveEngineerAlias(sysUserLoader.getSysUserNameById(dto.getExamineApproveEngineer()));
            dto.setProfessionalAuditorAlias(sysUserLoader.getSysUserNameById(dto.getProfessionalAuditor()));
            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
            dto.setLargeDeviceType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("LARGE_DEVICE_TYPE", dto.getLargeDeviceType(), sysApplicationAPI.getCurrentAppId()));
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsSdequipCollectDTO分页数据");
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
        if (!"null".equals(id)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsSdequipCollectDTO dto = assetsSdequipCollectService.queryAssetsSdequipCollectByPrimaryKey(id);
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode(request)));
            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));
            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));
            dto.setExamineApproveEngineerAlias(sysUserLoader.getSysUserNameById(dto.getExamineApproveEngineer()));
            dto.setProfessionalAuditorAlias(sysUserLoader.getSysUserNameById(dto.getProfessionalAuditor()));
            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
            mav.addObject("assetsSdequipCollectDTO", dto);
        }
        mav.setViewName("avicit/assets/device/assetssdequipcollect/" + "AssetsSdequipCollect" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsSdequipCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            AssetsSdequipCollectDTO assetsSdequipCollectDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<AssetsSdequipCollectDTO>() {
            });
            if ("".equals(assetsSdequipCollectDTO.getId())) {//新增
                assetsSdequipCollectService.insertAssetsSdequipCollect(assetsSdequipCollectDTO);
            } else {//修改
                assetsSdequipCollectService.updateAssetsSdequipCollectSensitive(assetsSdequipCollectDTO);
            }
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
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
    public ModelAndView toDeleteAssetsSdequipCollectDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsSdequipCollectService.deleteAssetsSdequipCollectByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
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
     * @return Map<String , Object>
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

        String oderby = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            String cloumnName = ComUtil.getColumn(AssetsSupplierDTO.class, sidx);
            if (cloumnName != null) {
                oderby = " " + cloumnName + " " + sord;
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
                result = assetsSupplierServiceSub.searchAssetsSupplierByPageOr(queryReqBean, oderby);
            } else {
                result = assetsSupplierServiceSub.searchAssetsSupplierByPage(queryReqBean, oderby);
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
        LOGGER.info("成功获取AssetsSupplierDTO分页数据");
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

            request.setAttribute("assetsSupplierDTO", dto);
        } else {
            request.setAttribute("pid", id);
        }
        mav.setViewName("avicit/assets/device/assetssdequipcollect/" + "AssetsSupplier" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsSupplierDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsSupplierDTO assetsSupplierDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<AssetsSupplierDTO>() {
            });
            if ("".equals(assetsSupplierDTO.getId())) {//新增
                assetsSupplierServiceSub.insertAssetsSupplier(assetsSupplierDTO);
            } else {//修改
                assetsSupplierServiceSub.updateAssetsSupplierSensitive(assetsSupplierDTO);
            }
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
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
    @RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsSupplierDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsSupplierServiceSub.deleteAssetsSupplierByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

}
