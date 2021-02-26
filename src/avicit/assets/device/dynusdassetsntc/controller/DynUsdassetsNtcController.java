package avicit.assets.device.dynusdassetsntc.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import avicit.assets.device.assetsustdtempapplyctmain.controller.AssetsUstdtempapplyCtMainController;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;
import avicit.assets.device.dynusdassetsntc.service.AssetsUstdCollectCmService;
import avicit.assets.device.excelutil.ExcelSheetPO;
import avicit.assets.device.excelutil.ExcelUtil;
import avicit.assets.device.excelutil.ExcelVersion;
import avicit.platform6.api.application.dto.SysApplication;
import avicit.platform6.core.excel.export.ServerExcelExport;
import avicit.platform6.core.excel.export.datasource.DefaultTypeReferenceDataSource;
import avicit.platform6.core.excel.export.entity.DataGridHeader;
import avicit.platform6.core.excel.export.headersource.JqExportDataGridHeaderSource;
import avicit.platform6.core.excel.export.inf.IFormatField;
import javassist.bytecode.ExceptionsAttribute;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.ss.util.WorkbookUtil;
import org.hibernate.jdbc.Work;
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

import avicit.assets.device.dynusdassetsntc.service.DynUsdassetsNtcService;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCollectService;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.dynusdassetsntc.dto.DynUsdassetsNtcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 18:51
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynusdassetsntc/dynUsdassetsNtcController")
public class DynUsdassetsNtcController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(DynUsdassetsNtcController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private DynUsdassetsNtcService dynUsdassetsNtcService;
    @Autowired

    private AssetsUstdtempapplyCollectService assetsUstdtempapplyCollectServiceSub;
    @Autowired
    private AssetsUstdCollectCmService assetsUstdCollectCmServiceSub;
    @Autowired
    private SysApplicationAPI appAPI;

    private DynUsdassetsNtcController.FormateAppId _formateApp = new DynUsdassetsNtcController.FormateAppId();
    private DynUsdassetsNtcController.Formate _formate = new DynUsdassetsNtcController.Formate();

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toDynUsdassetsNtcManage")
    public ModelAndView toDynUsdassetsNtcManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/dynusdassetsntc/DynUsdassetsNtcManage");
        mav.addObject("url", "platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/");
        mav.addObject("surl", "platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/sub/");
        mav.addObject("surl2", "platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/sub2/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String   ,   Object>
     */
    @RequestMapping(value = "/operation/getDynUsdassetsNtcsByPage")
    @ResponseBody
    public Map<String, Object> toGetDynUsdassetsNtcByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<DynUsdassetsNtcDTO> queryReqBean = new QueryReqBean<DynUsdassetsNtcDTO>();
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
            cloumnName = ComUtil.getColumn(DynUsdassetsNtcDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(DynUsdassetsNtcDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(DynUsdassetsNtcDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        DynUsdassetsNtcDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<DynUsdassetsNtcDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynUsdassetsNtcDTO>() {
            });
        } else {
            param = new DynUsdassetsNtcDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = dynUsdassetsNtcService.searchDynUsdassetsNtcByPageOr(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            } else {
                result = dynUsdassetsNtcService.searchDynUsdassetsNtcByPage(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        for (DynUsdassetsNtcDTO dto : result.getResult()) {
            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取DynUsdassetsNtcDTO分页数据");
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
            DynUsdassetsNtcDTO dto = dynUsdassetsNtcService.queryDynUsdassetsNtcByPrimaryKey(id);
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
            Collection<SysLookupSimpleVo> isMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMeteringList) {
                isMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMeteringData", JsonHelper.getInstance().writeValueAsString(isMeteringMap));
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
            mav.addObject("dynUsdassetsNtcDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/dynusdassetsntc/" + "DynUsdassetsNtc" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveDynUsdassetsNtcDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            DynUsdassetsNtcDTO dynUsdassetsNtcDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<DynUsdassetsNtcDTO>() {
            });
            if (StringUtils.isEmpty(dynUsdassetsNtcDTO.getId())) {//新增
                dynUsdassetsNtcDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
                dynUsdassetsNtcService.insertDynUsdassetsNtc(dynUsdassetsNtcDTO);
            } else {//修改
                dynUsdassetsNtcService.updateDynUsdassetsNtcSensitive(dynUsdassetsNtcDTO);
            }
            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", dynUsdassetsNtcDTO.getId());
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
    public ModelAndView toDeleteDynUsdassetsNtcDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            dynUsdassetsNtcService.deleteDynUsdassetsNtcByIds(ids);
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
            DynUsdassetsNtcDTO dynUsdassetsNtc = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<DynUsdassetsNtcDTO>() {
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
            dynUsdassetsNtc.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
            StartResultBean result = dynUsdassetsNtcService.insertDynUsdassetsNtcAndStartProcess(dynUsdassetsNtc, parameter);

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
        DynUsdassetsNtcDTO dto = dynUsdassetsNtcService.queryDynUsdassetsNtcByPrimaryKey(id);


        dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


        dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));


        mav.addObject("flag", OpResult.success);
        mav.addObject("dynUsdassetsNtcDTO", dto);

        return mav;
    }

    /****************************子表一操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String , Object>
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
            param.setAttribute01(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsUstdtempapplyCollectDTO();
            param.setAttribute01(pid);
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


            dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getAttribute05()));
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

            dto.setIsMeteringName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));


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

            dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode()));
            dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));
            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));
            dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));
            mav.addObject("assetsUstdtempapplyCollectDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/dynusdassetsntc/" + "AssetsUstdtempapplyCollect" + type);
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


    /***************************** 子表二操作***************************** /** 按照pid查找子表数据
     *
     * @param pageParameter
     *            查询条件
     * @param request
     *            请求
     * @return Map<String,Object>
     */
    @RequestMapping(value = "/operation/sub2/getAssetsUstdCollectCm", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAssetsUstdCollectCmByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsUstdCollectCmDTO> queryReqBean = new QueryReqBean<AssetsUstdCollectCmDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsUstdCollectCmDTO.class, sidx);
            if (cloumnName != null) {// 这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                // 判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdCollectCmDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdCollectCmDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsUstdCollectCmDTO param = null;
        QueryRespBean<AssetsUstdCollectCmDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsUstdCollectCmDTO>() {
            });
            param.setHeaderIdCm(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsUstdCollectCmDTO();
            param.setHeaderIdCm(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsUstdCollectCmServiceSub.searchAssetsUstdCollectCmByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsUstdCollectCmServiceSub.searchAssetsUstdCollectCmByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsUstdCollectCmDTO dto : result.getResult()) {

            dto.setDeviceCategoryCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                    dto.getDeviceCategoryCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setManufactureUnitCmAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManufactureUnitCm(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setCreatedByPersionAliasCm(sysUserLoader.getSysUserNameById(dto.getAttribute05()));
            dto.setCreatedByDeptAliasCm(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setCompetentAuthorityCmAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthorityCm(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setDeviceCategoryCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                    dto.getDeviceCategoryCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setModelDirectorCmAlias(sysUserLoader.getSysUserNameById(dto.getModelDirectorCm()));

            dto.setCompetentLeaderCmAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeaderCm()));

            dto.setIsNeedInstallCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsNeedInstallCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsHumidityNeedCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
                    "PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeedCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsWaterNeedCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsWaterNeedCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsGasNeedCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsGasNeedCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsLetCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsLetCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsOtherNeedCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsOtherNeedCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAboveConditionsCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
                    "PLATFORM_YES_NO_FLAG", dto.getIsAboveConditionsCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMeteringCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsMeteringCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setFinancialResourcesCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
                    "FINANCIAL_RESOURCES", dto.getFinancialResourcesCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsTestDeviceCmName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsTestDeviceCm(), sysApplicationAPI.getCurrentAppId()));

            dto.setCompetentDeviceLeaderCmAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeaderCm()));

        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsUstdCollectCmDTO分页数据");
        return map;
    }

    /**
     * 根据id选择跳转到新建页还是编辑页
     *
     * @param type
     *            操作类型新建还是编辑
     * @param id
     *            编辑数据的id
     * @param request
     *            请求
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/sub2/{type}/{id}")
    public ModelAndView toOpertionSubPage2(@PathVariable String type, @PathVariable String id,
                                          HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {// 编辑窗口或者详细页窗口
            // 主表数据
            AssetsUstdCollectCmDTO dto = assetsUstdCollectCmServiceSub.queryAssetsUstdCollectCmByPrimaryKey(id);

            dto.setManufactureUnitCmAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getManufactureUnitCm(),
                    SessionHelper.getCurrentLanguageCode()));
            dto.setCompetentAuthorityCmAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthorityCm(),
                    SessionHelper.getCurrentLanguageCode()));
            dto.setModelDirectorCmAlias(sysUserLoader.getSysUserNameById(dto.getModelDirectorCm()));
            dto.setCompetentLeaderCmAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeaderCm()));
            dto.setCompetentDeviceLeaderCmAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeaderCm()));
            mav.addObject("assetsUstdCollectCmDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/asstes/device/dynusdassetsntc/" + "AssetsUstdCollectCm" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request
     *            请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub2/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAssetsUstdCollectCmDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AssetsUstdCollectCmDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
                    new TypeReference<List<AssetsUstdCollectCmDTO>>() {
                    });
            assetsUstdCollectCmServiceSub.insertOrUpdateAssetsUstdCollectCm(list, pid);
            return new AvicitResponseBody(OpResult.success);
        } catch (Exception ex) {
            return new AvicitResponseBody(OpResult.failure, ex.getMessage());
        }
    }

    /**
     * 按照id批量删除数据
     *
     * @param ids
     *            id数组
     * @param request
     *            请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub2/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsUstdCollectCmDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsUstdCollectCmServiceSub.deleteAssetsUstdCollectCmByIds(ids);
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
            Collection<SysLookupSimpleVo> isMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMeteringList) {
                isMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMeteringData", JsonHelper.getInstance().writeValueAsString(isMeteringMap));
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





/***************************************************子表二lookup*******************************************************************/
            Collection<SysLookupSimpleVo> deviceCategoryCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
            HashMap<String, String> deviceCategoryCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceCategoryCmList) {
                deviceCategoryCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceCategoryCmData", JsonHelper.getInstance().writeValueAsString(deviceCategoryCmMap));
            Collection<SysLookupSimpleVo> isNeedInstallCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedInstallCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedInstallCmList) {
                isNeedInstallCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedInstallCmData", JsonHelper.getInstance().writeValueAsString(isNeedInstallCmMap));
            Collection<SysLookupSimpleVo> isHumidityNeedCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isHumidityNeedCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isHumidityNeedCmList) {
                isHumidityNeedCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isHumidityNeedCmData", JsonHelper.getInstance().writeValueAsString(isHumidityNeedCmMap));
            Collection<SysLookupSimpleVo> isWaterNeedCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isWaterNeedCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isWaterNeedCmList) {
                isWaterNeedCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isWaterNeedCmData", JsonHelper.getInstance().writeValueAsString(isWaterNeedCmMap));
            Collection<SysLookupSimpleVo> isGasNeedCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isGasNeedCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isGasNeedCmList) {
                isGasNeedCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isGasNeedCmData", JsonHelper.getInstance().writeValueAsString(isGasNeedCmMap));
            Collection<SysLookupSimpleVo> isLetCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isLetCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isLetCmList) {
                isLetCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isLetCmData", JsonHelper.getInstance().writeValueAsString(isLetCmMap));
            Collection<SysLookupSimpleVo> isOtherNeedCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isOtherNeedCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isOtherNeedCmList) {
                isOtherNeedCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isOtherNeedCmData", JsonHelper.getInstance().writeValueAsString(isOtherNeedCmMap));
            Collection<SysLookupSimpleVo> isAboveConditionsCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAboveConditionsCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAboveConditionsCmList) {
                isAboveConditionsCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAboveConditionsCmData",
                    JsonHelper.getInstance().writeValueAsString(isAboveConditionsCmMap));
            Collection<SysLookupSimpleVo> isMeteringCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMeteringCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMeteringCmList) {
                isMeteringCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMeteringCmData", JsonHelper.getInstance().writeValueAsString(isMeteringCmMap));
            Collection<SysLookupSimpleVo> financialResourcesCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("FINANCIAL_RESOURCES", appId);
            HashMap<String, String> financialResourcesCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : financialResourcesCmList) {
                financialResourcesCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("financialResourcesCmData",
                    JsonHelper.getInstance().writeValueAsString(financialResourcesCmMap));
            Collection<SysLookupSimpleVo> isTestDeviceCmList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isTestDeviceCmMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isTestDeviceCmList) {
                isTestDeviceCmMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isTestDeviceCmData", JsonHelper.getInstance().writeValueAsString(isTestDeviceCmMap));
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    private class FormateAppId implements IFormatField {
        private List<SysApplication> appList;

        private FormateAppId() {
        }

        public void setAppList(List<SysApplication> appList) {
            this.appList = appList;
        }

        public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
            if ("syslogTime".equalsIgnoreCase(field)) {
                return data.get(field).toString();
            } else if ("sysApplicationId".equalsIgnoreCase(field)) {
                Iterator var4 = this.appList.iterator();

                SysApplication app;
                do {
                    if (!var4.hasNext()) {
                        return "没有系统应用名称";
                    }

                    app = (SysApplication)var4.next();
                } while(!app.getId().equals(data.get(field)));

                return app.getApplicationName();
            } else {
                return data.get(field);
            }
        }
    }

    private class Formate implements IFormatField {
        private final SimpleDateFormat sdf;
        private List<SysApplication> appList;

        private Formate() {
            this.sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }

        public Object formatField(DataGridHeader header, Map<String, Object> data, String field) {
            if ("syslogTime".equalsIgnoreCase(field)) {
                return this.sdf.format(new Date(Long.parseLong(data.get(field).toString())));
            } else if ("sysApplicationId".equalsIgnoreCase(field)) {
                Iterator var4 = this.appList.iterator();

                SysApplication app;
                do {
                    if (!var4.hasNext()) {
                        return "没有系统应用名称";
                    }

                    app = (SysApplication)var4.next();
                } while(!app.getId().equals(data.get(field)));

                return app.getApplicationName();
            } else {
                return data.get(field);
            }
        }

        public void setAppList(List<SysApplication> appList) {
            this.appList = appList;
        }
    }



    private static DataValidation setDataValidation(Sheet sheet, String[] textList, int firstRow, int endRow, int firstCol, int endCol) {

        DataValidationHelper helper = sheet.getDataValidationHelper();
        //加载下拉列表内容
        DataValidationConstraint constraint = helper.createExplicitListConstraint(textList);
        //DVConstraint constraint = new DVConstraint();
        constraint.setExplicitListValues(textList);

        //设置数据有效性加载在哪个单元格上。四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList((short) firstRow, (short) endRow, (short) firstCol, (short) endCol);

        //数据有效性对象
        DataValidation data_validation = helper.createValidation(constraint, regions);
        //DataValidation data_validation = new DataValidation(regions, constraint);

        return data_validation;
    }


    @RequestMapping({"/exportList"})
    public String toServerExport(HttpServletRequest request, ModelMap map) throws Exception {
        String fileName = ServletRequestUtils.getStringParameter(request, "fileName", "导出excel");
        String dataGridheaders = ServletRequestUtils.getStringParameter(request, "dataGridFields", "");
        boolean hasRowNum = ServletRequestUtils.getBooleanParameter(request, "hasRowNum", true);
        String unContainFields = ServletRequestUtils.getStringParameter(request, "unContainFields", "");
        String sheetName = ServletRequestUtils.getStringParameter(request, "sheetName", "sheet1");
        String appId = ServletRequestUtils.getStringParameter(request, "appid", "1");
        String logTable = ServletRequestUtils.getStringParameter(request, "logTable", "-1");
        String total = ServletRequestUtils.getStringParameter(request, "total", "65500");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        ServerExcelExport serverExp = new ServerExcelExport();
        serverExp.setFileName(fileName);
        serverExp.setSheetName(sheetName);
        JqExportDataGridHeaderSource header = new JqExportDataGridHeaderSource(dataGridheaders);
        //header.setUnexportColumn(unContainFields);
        header.setUnexportColumn("id,cb");
        header.setHasRowNum(hasRowNum);
        serverExp.setUserDefinedGridHeader(header);
        int totalcount = Integer.parseInt(total);
        if (totalcount <= 65500) {
            PageParameter pp = new PageParameter(1, 65500);
            Map rst = null;

            try {
                rst = this.toGetAssetsUstdtempapplyCollectByPid(pp, request);
            } catch (Exception var27) {
                this.logger.error("数据查询异常:" + var27.getMessage(), var27);
                return "excel.down";
            }

            ArrayList<AssetsUstdtempapplyCollectDTO> aa = (ArrayList)rst.get("rows");
            DefaultTypeReferenceDataSource<AssetsUstdtempapplyCollectDTO> dt = new DefaultTypeReferenceDataSource();
            dt.setData(aa);
            serverExp.setExportDataSource(dt);
            serverExp.setFormatField(this._formateApp);
            this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
            Workbook workbook = serverExp.exportData();
           // String dlData[] = {"1","2"};
           // workbook.getSheet("sheet1").addValidationData(setDataValidation(workbook.getSheet("sheet1"), dlData, 1, 5000, 2 ,2)); //超过255个
            map.addAttribute("export", serverExp);
            return "excel.down";
        } else {
            int size = 'ￜ';
            int page = totalcount / size;
            if (totalcount % size != 0) {
                ++page;
            }

            ByteArrayOutputStream baps = new ByteArrayOutputStream();
            ZipOutputStream out = new ZipOutputStream(baps);

            for(int i = 1; i <= page; ++i) {
                int first;
                int end;
                if (i * size > totalcount) {
                    first = (i - 1) * size + 1;
                    end = totalcount;
                } else {
                    first = (i - 1) * size + 1;
                    end = i * size;
                }

                PageParameter pp = new PageParameter(i, size);
                Map rst = null;

                try {
                    rst = this.toGetAssetsUstdtempapplyCollectByPid(pp, request);
                } catch (Exception var28) {
                    this.logger.error("数据查询异常:" + var28.getMessage(), var28);
                    return "excel.down";
                }

                ArrayList<AssetsUstdtempapplyCollectDTO> aa = (ArrayList)rst.get("rows");
                DefaultTypeReferenceDataSource<AssetsUstdtempapplyCollectDTO> dt = new DefaultTypeReferenceDataSource();
                dt.setData(aa);
                serverExp.setExportDataSource(dt);
                serverExp.setFormatField(this._formateApp);
                this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
                Workbook workbook = serverExp.exportData();
                ZipEntry entry = new ZipEntry("ExportSysLog-from[" + first + "]to[" + end + "].xls");
                out.putNextEntry(entry);
                //Sheet sheetTempl = workbook.getSheet("sheet1");
               // String dlData[] = {"1","2"};
               // workbook.getSheet("sheet1").addValidationData(setDataValidation(workbook.getSheet("sheet1"), dlData, 1, 5000, 2 ,2)); //超过255个
                //workbook.write(out);
            }

            out.close();
            map.addAttribute("byte", baps.toByteArray());
            map.addAttribute("name", fileName + ".rar");
             map.addAttribute("export", serverExp);
           return "byte.down";
        }
    }


//    @RequestMapping({"/exportList"})
//    public void toServerExport2(HttpServletRequest request, ModelMap map,HttpServletResponse response) throws Exception {
//        String fileName = ServletRequestUtils.getStringParameter(request, "fileName", "导出excel");
//        String dataGridheaders = ServletRequestUtils.getStringParameter(request, "dataGridFields", "");
//        boolean hasRowNum = ServletRequestUtils.getBooleanParameter(request, "hasRowNum", true);
//        String unContainFields = ServletRequestUtils.getStringParameter(request, "unContainFields", "");
//        String sheetName = ServletRequestUtils.getStringParameter(request, "sheetName", "sheet1");
//        String appId = ServletRequestUtils.getStringParameter(request, "appid", "1");
//        String logTable = ServletRequestUtils.getStringParameter(request, "logTable", "-1");
//        String total = ServletRequestUtils.getStringParameter(request, "total", "65500");
//        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
//        ServerExcelExport serverExp = new ServerExcelExport();
//        serverExp.setFileName(fileName);
//        serverExp.setSheetName(sheetName);
//        JqExportDataGridHeaderSource header = new JqExportDataGridHeaderSource(dataGridheaders);
//        //header.setUnexportColumn(unContainFields);
//        header.setUnexportColumn("id,cb");
//        header.setHasRowNum(hasRowNum);
//        serverExp.setUserDefinedGridHeader(header);
//        int totalcount = Integer.parseInt(total);
//        if (totalcount <= 65500) {
//            PageParameter pp = new PageParameter(1, 65500);
//            Map rst = null;
//
//            try {
//                rst = this.toGetAssetsUstdtempapplyCollectByPid(pp, request);
//            } catch (Exception var27) {
//                this.logger.error("数据查询异常:" + var27.getMessage(), var27);
//            }
//
//            ArrayList<AssetsUstdtempapplyCollectDTO> aa = (ArrayList)rst.get("rows");
//            DefaultTypeReferenceDataSource<AssetsUstdtempapplyCollectDTO> dt = new DefaultTypeReferenceDataSource();
//            dt.setData(aa);
//            serverExp.setExportDataSource(dt);
//            serverExp.setFormatField(this._formateApp);
//            this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
//            Workbook workbook = serverExp.exportData();
//            String dlData[] = {"1","2"};
//            workbook.getSheet("sheet1").addValidationData(setDataValidation(workbook.getSheet("sheet1"), dlData, 1, 5000, 2 ,2)); //超过255个
//            OutputStream os = null;
//            os = response.getOutputStream();
//            workbook.write(os);
//
//           // String downData[]={"1","2"};
//           // String downRows[]={"3"};
//           // List<ExcelSheetPO> excelSheets = new ArrayList<>();
//           // ExcelSheetPO temple_sheet =new ExcelSheetPO();
//
//            //ExcelUtil.createWorkbookAtOutStream(ExcelVersion.V2007,temple_sheet,os,false,null,null);
//////            try {
////            os = response.getOutputStream();
////            response.reset();
////            response.setCharacterEncoding("UTF-8");
////// Content-disposition 告诉浏览器以下载的形式打开
////            String selfheader = request.getHeader("User-Agent").toUpperCase();
////            if (selfheader.contains("MSIE") || selfheader.contains("TRIDENT") || selfheader.contains("EDGE")) {
////                fileName = URLEncoder.encode(fileName, "utf-8");
////                fileName = fileName.replace("+", "%20"); // IE下载文件名空格变+号问题
////            } else {
////                fileName = new String(fileName.getBytes(), "ISO8859-1");
////            }
////            response.setHeader("Content-Disposition", "attachment; filename=" + fileName+".xls");// 要保存的文件名
////            response.setContentType("application/vnd.ms-excel");
////            workbook.write(os);
////                FileOutputStream
////        } catch (Exception e) {
////            e.printStackTrace();
////        } finally {
////            try {
////                os.close();
////            } catch (IOException e) {
////                e.printStackTrace();
////            }
////        }
//    }
//    }

}
