package avicit.assets.device.assetsustdtempapplyctmain.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import avicit.assets.device.dynsdcollecmain.controller.DynSdCollecMainController;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.excelutil.ExcelSheetPO;
import avicit.assets.device.excelutil.ExcelUtil;
import avicit.assets.device.excelutil.ExcelVersion;
import avicit.platform6.api.application.dto.SysApplication;
import avicit.platform6.core.excel.export.ServerExcelExport;
import avicit.platform6.core.excel.export.datasource.DefaultTypeReferenceDataSource;
import avicit.platform6.core.excel.export.entity.DataGridHeader;
import avicit.platform6.core.excel.export.headersource.JqExportDataGridHeaderSource;
import avicit.platform6.core.excel.export.inf.IFormatField;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import avicit.platform6.api.session.SessionHelper;
import org.springframework.ui.ModelMap;
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

import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCtMainService;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCollectService;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCtMainDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 16:24
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController")
public class AssetsUstdtempapplyCtMainController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsUstdtempapplyCtMainController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsUstdtempapplyCtMainService assetsUstdtempapplyCtMainService;
    @Autowired
    private AssetsUstdtempapplyCollectService assetsUstdtempapplyCollectServiceSub;


    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsUstdtempapplyCtMainManage")
    public ModelAndView toAssetsUstdtempapplyCtMainManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsustdtempapplyctmain/AssetsUstdtempapplyCtMainManage");
        mav.addObject("url", "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/");
        mav.addObject("surl", "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/sub/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String       ,        O b j e c t>
     */
    @RequestMapping(value = "/operation/getAssetsUstdtempapplyCtMainsByPage")
    @ResponseBody
    public Map<String, Object> toGetAssetsUstdtempapplyCtMainByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsUstdtempapplyCtMainDTO> queryReqBean = new QueryReqBean<AssetsUstdtempapplyCtMainDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCtMainDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCtMainDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCtMainDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsUstdtempapplyCtMainDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsUstdtempapplyCtMainDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsUstdtempapplyCtMainDTO>() {
            });
        } else {
            param = new AssetsUstdtempapplyCtMainDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = assetsUstdtempapplyCtMainService.searchAssetsUstdtempapplyCtMainByPageOr(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            } else {
                result = assetsUstdtempapplyCtMainService.searchAssetsUstdtempapplyCtMainByPage(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        for (AssetsUstdtempapplyCtMainDTO dto : result.getResult()) {
            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsUstdtempapplyCtMainDTO分页数据");
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
            AssetsUstdtempapplyCtMainDTO dto = assetsUstdtempapplyCtMainService.queryAssetsUstdtempapplyCtMainByPrimaryKey(id);
            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

            String appId = sysApplicationAPI.getCurrentAppId();
            Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
            HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceCategoryList) {
                deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
            Collection<SysLookupSimpleVo> isNeedInstallList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedInstallMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedInstallList) {
                isNeedInstallMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedInstallData", JsonHelper.getInstance().writeValueAsString(isNeedInstallMap));
            Collection<SysLookupSimpleVo> isHumidityNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isHumidityNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isHumidityNeedList) {
                isHumidityNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isHumidityNeedData", JsonHelper.getInstance().writeValueAsString(isHumidityNeedMap));
            Collection<SysLookupSimpleVo> isWaterNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isWaterNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isWaterNeedList) {
                isWaterNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isWaterNeedData", JsonHelper.getInstance().writeValueAsString(isWaterNeedMap));
            Collection<SysLookupSimpleVo> isGasNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isGasNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isGasNeedList) {
                isGasNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isGasNeedData", JsonHelper.getInstance().writeValueAsString(isGasNeedMap));
            Collection<SysLookupSimpleVo> isLetList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isLetMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isLetList) {
                isLetMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isLetData", JsonHelper.getInstance().writeValueAsString(isLetMap));
            Collection<SysLookupSimpleVo> isOtherNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isOtherNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isOtherNeedList) {
                isOtherNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isOtherNeedData", JsonHelper.getInstance().writeValueAsString(isOtherNeedMap));
            Collection<SysLookupSimpleVo> isAboveConditionsList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAboveConditionsMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAboveConditionsList) {
                isAboveConditionsMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAboveConditionsData", JsonHelper.getInstance().writeValueAsString(isAboveConditionsMap));
            Collection<SysLookupSimpleVo> financialResourcesList = sysLookupLoader.getLookUpListByTypeByAppId("FINANCIAL_RESOURCES", appId);
            HashMap<String, String> financialResourcesMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : financialResourcesList) {
                financialResourcesMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("financialResourcesData", JsonHelper.getInstance().writeValueAsString(financialResourcesMap));
            Collection<SysLookupSimpleVo> isTestDeviceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isTestDeviceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isTestDeviceList) {
                isTestDeviceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isTestDeviceData", JsonHelper.getInstance().writeValueAsString(isTestDeviceMap));
            mav.addObject("assetsUstdtempapplyCtMainDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsustdtempapplyctmain/" + "AssetsUstdtempapplyCtMain" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsUstdtempapplyCtMainDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<AssetsUstdtempapplyCtMainDTO>() {
            });
            if (StringUtils.isEmpty(assetsUstdtempapplyCtMainDTO.getId())) {//新增
                assetsUstdtempapplyCtMainDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
           assetsUstdtempapplyCtMainService.insertAssetsUstdtempapplyCtMain(assetsUstdtempapplyCtMainDTO);
            } else {//修改
                assetsUstdtempapplyCtMainService.updateAssetsUstdtempapplyCtMainSensitive(assetsUstdtempapplyCtMainDTO);
            }
            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", assetsUstdtempapplyCtMainDTO.getId());
        } catch (Exception ex) {
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
    public ModelAndView toDeleteAssetsUstdtempapplyCtMainDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsUstdtempapplyCtMainService.deleteAssetsUstdtempapplyCtMainByIds(ids);
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
            AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMain = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<AssetsUstdtempapplyCtMainDTO>() {
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
            assetsUstdtempapplyCtMain.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
            StartResultBean result = assetsUstdtempapplyCtMainService.insertAssetsUstdtempapplyCtMainAndStartProcess(assetsUstdtempapplyCtMain, parameter);

            mav.addObject("flag", OpResult.success);
            mav.addObject("startResult", result);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
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
        AssetsUstdtempapplyCtMainDTO dto = assetsUstdtempapplyCtMainService.queryAssetsUstdtempapplyCtMainByPrimaryKey(id);


        dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


        dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));


        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsUstdtempapplyCtMainDTO", dto);

        return mav;
    }

    /****************************子表操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String   ,   O b j e c t>
     */
    @RequestMapping(value = "/operation/sub/getAssetsUstdtempapplyCollect", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAssetsUstdtempapplyCollectByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsUstdtempapplyCollectDTO> queryReqBean = new QueryReqBean<AssetsUstdtempapplyCollectDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCollectDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCollectDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCollectDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsUstdtempapplyCollectDTO param = null;
        QueryRespBean<AssetsUstdtempapplyCollectDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsUstdtempapplyCollectDTO>() {
            });
            param.setHeaderId(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsUstdtempapplyCollectDTO();
            param.setHeaderId(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsUstdtempapplyCollectServiceSub.searchAssetsUstdtempapplyCollectByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsUstdtempapplyCollectServiceSub.searchAssetsUstdtempapplyCollectByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsUstdtempapplyCollectDTO dto : result.getResult()) {


            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getAttribute05()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));

            dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));


            dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));

            dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));

            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));


            dto.setIsNeedInstallName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsHumidityNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsWaterNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsGasNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsLetName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsOtherNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsAboveConditionsName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAboveConditions(), sysApplicationAPI.getCurrentAppId()));


            dto.setFinancialResourcesName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsTestDeviceName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));


        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsUstdtempapplyCollectDTO分页数据");
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
            AssetsUstdtempapplyCollectDTO dto = assetsUstdtempapplyCollectServiceSub.queryAssetsUstdtempapplyCollectByPrimaryKey(id);

            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getAttribute05()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));
            dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));
            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
            dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));
            mav.addObject("assetsUstdtempapplyCollectDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/assetsustdtempapplyctmain/" + "AssetsUstdtempapplyCollect" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAssetsUstdtempapplyCollectDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AssetsUstdtempapplyCollectDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat, new TypeReference<List<AssetsUstdtempapplyCollectDTO>>() {
            });
            assetsUstdtempapplyCollectServiceSub.insertOrUpdateAssetsUstdtempapplyCollect(list, pid);
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
    public ModelAndView toDeleteAssetsUstdtempapplyCollectDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsUstdtempapplyCollectServiceSub.deleteAssetsUstdtempapplyCollectByIds(ids);
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
            Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
            HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceCategoryList) {
                deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));

            Collection<SysLookupSimpleVo> isNeedInstallList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedInstallMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedInstallList) {
                isNeedInstallMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedInstallData", JsonHelper.getInstance().writeValueAsString(isNeedInstallMap));
            Collection<SysLookupSimpleVo> isHumidityNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isHumidityNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isHumidityNeedList) {
                isHumidityNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isHumidityNeedData", JsonHelper.getInstance().writeValueAsString(isHumidityNeedMap));
            Collection<SysLookupSimpleVo> isWaterNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isWaterNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isWaterNeedList) {
                isWaterNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isWaterNeedData", JsonHelper.getInstance().writeValueAsString(isWaterNeedMap));
            Collection<SysLookupSimpleVo> isGasNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isGasNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isGasNeedList) {
                isGasNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isGasNeedData", JsonHelper.getInstance().writeValueAsString(isGasNeedMap));
            Collection<SysLookupSimpleVo> isLetList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isLetMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isLetList) {
                isLetMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isLetData", JsonHelper.getInstance().writeValueAsString(isLetMap));
            Collection<SysLookupSimpleVo> isOtherNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isOtherNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isOtherNeedList) {
                isOtherNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isOtherNeedData", JsonHelper.getInstance().writeValueAsString(isOtherNeedMap));
            Collection<SysLookupSimpleVo> isAboveConditionsList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAboveConditionsMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAboveConditionsList) {
                isAboveConditionsMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAboveConditionsData", JsonHelper.getInstance().writeValueAsString(isAboveConditionsMap));
            Collection<SysLookupSimpleVo> financialResourcesList = sysLookupLoader.getLookUpListByTypeByAppId("FINANCIAL_RESOURCES", appId);
            HashMap<String, String> financialResourcesMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : financialResourcesList) {
                financialResourcesMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("financialResourcesData", JsonHelper.getInstance().writeValueAsString(financialResourcesMap));
            Collection<SysLookupSimpleVo> isTestDeviceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isTestDeviceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isTestDeviceList) {
                isTestDeviceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isTestDeviceData", JsonHelper.getInstance().writeValueAsString(isTestDeviceMap));
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }





























}

