package avicit.assets.device.dynsdcollecmain.controller;

import java.io.ByteArrayOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;
import avicit.assets.device.assetsstdtempacceptance.service.AssetsStdtempAcceptanceService;
import avicit.assets.device.assetsuserlog.controller.AssetsUserLogController;
import avicit.assets.device.dynsdcollecmain.dao.AssetsSdequipCollectCmDao;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectCmDTO;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectCmService;
import avicit.platform6.api.application.dto.SysApplication;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.excel.export.ServerExcelExport;
import avicit.platform6.core.excel.export.datasource.DefaultTypeReferenceDataSource;
import avicit.platform6.core.excel.export.entity.DataGridHeader;
import avicit.platform6.core.excel.export.headersource.JqExportDataGridHeaderSource;
import avicit.platform6.core.excel.export.inf.IFormatField;
import avicit.platform6.core.spring.SpringFactory;
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

import avicit.assets.device.dynsdcollecmain.service.DynSdCollecMainService;
import avicit.assets.device.dynsdcollecmain.service.AssetsSdequipCollectService;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynsdcollecmain.dto.DynSdCollecMainDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 18:57
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynsdcollecmain/dynSdCollecMainController")
public class DynSdCollecMainController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(DynSdCollecMainController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private DynSdCollecMainService dynSdCollecMainService;
    @Autowired

    private AssetsSdequipCollectService assetsSdequipCollectServiceSub;
    @Autowired

    private AssetsSdequipCollectCmService assetsSdequipCollectCmServiceSub;
    @Autowired
    private SysApplicationAPI appAPI;
    private AssetsSdequipCollectCmDao assetsSdequipCollectCmDao;


    private DynSdCollecMainController.FormateAppId _formateApp = new DynSdCollecMainController.FormateAppId();
    private DynSdCollecMainController.Formate _formate = new DynSdCollecMainController.Formate();

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toDynSdCollecMainManage")
    public ModelAndView toDynSdCollecMainManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/dynsdcollecmain/DynSdCollecMainManage");
        mav.addObject("url", "platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/");
        mav.addObject("surl", "platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/sub/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String                               ,                               Object>
     */
    @RequestMapping(value = "/operation/getDynSdCollecMainsByPage")
    @ResponseBody
    public Map<String, Object> toGetDynSdCollecMainByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<DynSdCollecMainDTO> queryReqBean = new QueryReqBean<DynSdCollecMainDTO>();
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
            cloumnName = ComUtil.getColumn(DynSdCollecMainDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(DynSdCollecMainDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(DynSdCollecMainDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        DynSdCollecMainDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<DynSdCollecMainDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynSdCollecMainDTO>() {
            });
        } else {
            param = new DynSdCollecMainDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = dynSdCollecMainService.searchDynSdCollecMainByPageOr(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            } else {
                result = dynSdCollecMainService.searchDynSdCollecMainByPage(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        for (DynSdCollecMainDTO dto : result.getResult()) {
            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取DynSdCollecMainDTO分页数据");
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
        if (!"Add".equals(type) && !"sub".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            DynSdCollecMainDTO dto = dynSdCollecMainService.queryDynSdCollecMainByPrimaryKey(id);
            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));
            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));

            String appId = sysApplicationAPI.getCurrentAppId();
            Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL", appId);
            HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : secretLevelList) {
                secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
            Collection<SysLookupSimpleVo> deviceTypeList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_TYPE", appId);
            HashMap<String, String> deviceTypeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceTypeList) {
                deviceTypeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceTypeData", JsonHelper.getInstance().writeValueAsString(deviceTypeMap));
            Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
            HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceCategoryList) {
                deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
            Collection<SysLookupSimpleVo> isMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMeteringList) {
                isMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMeteringData", JsonHelper.getInstance().writeValueAsString(isMeteringMap));
            Collection<SysLookupSimpleVo> isSceneMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSceneMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSceneMeteringList) {
                isSceneMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSceneMeteringData", JsonHelper.getInstance().writeValueAsString(isSceneMeteringMap));
            Collection<SysLookupSimpleVo> isMaintainList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMaintainMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMaintainList) {
                isMaintainMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMaintainData", JsonHelper.getInstance().writeValueAsString(isMaintainMap));
            Collection<SysLookupSimpleVo> isAccuracyCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAccuracyCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAccuracyCheckList) {
                isAccuracyCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAccuracyCheckData", JsonHelper.getInstance().writeValueAsString(isAccuracyCheckMap));
            Collection<SysLookupSimpleVo> isRegularCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isRegularCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isRegularCheckList) {
                isRegularCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isRegularCheckData", JsonHelper.getInstance().writeValueAsString(isRegularCheckMap));
            Collection<SysLookupSimpleVo> isSpotCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSpotCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSpotCheckList) {
                isSpotCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSpotCheckData", JsonHelper.getInstance().writeValueAsString(isSpotCheckMap));
            Collection<SysLookupSimpleVo> isSpecialDeviceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSpecialDeviceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSpecialDeviceList) {
                isSpecialDeviceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSpecialDeviceData", JsonHelper.getInstance().writeValueAsString(isSpecialDeviceMap));
            Collection<SysLookupSimpleVo> isPrecisionIndexList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isPrecisionIndexMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isPrecisionIndexList) {
                isPrecisionIndexMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isPrecisionIndexData", JsonHelper.getInstance().writeValueAsString(isPrecisionIndexMap));
            Collection<SysLookupSimpleVo> isNeedInstallList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedInstallMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedInstallList) {
                isNeedInstallMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedInstallData", JsonHelper.getInstance().writeValueAsString(isNeedInstallMap));
            Collection<SysLookupSimpleVo> isFoundationList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isFoundationMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isFoundationList) {
                isFoundationMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isFoundationData", JsonHelper.getInstance().writeValueAsString(isFoundationMap));
            Collection<SysLookupSimpleVo> isSafetyProductionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSafetyProductionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSafetyProductionList) {
                isSafetyProductionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSafetyProductionData", JsonHelper.getInstance().writeValueAsString(isSafetyProductionMap));
            Collection<SysLookupSimpleVo> financialResourcesList = sysLookupLoader.getLookUpListByTypeByAppId("FINANCIAL_RESOURCES", appId);
            HashMap<String, String> financialResourcesMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : financialResourcesList) {
                financialResourcesMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("financialResourcesData", JsonHelper.getInstance().writeValueAsString(financialResourcesMap));
            Collection<SysLookupSimpleVo> demandUrgencyDegreeList = sysLookupLoader.getLookUpListByTypeByAppId("DEMAND_URGENCY_DEGREE", appId);
            HashMap<String, String> demandUrgencyDegreeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : demandUrgencyDegreeList) {
                demandUrgencyDegreeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("demandUrgencyDegreeData", JsonHelper.getInstance().writeValueAsString(demandUrgencyDegreeMap));
            Collection<SysLookupSimpleVo> isTrainList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isTrainMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isTrainList) {
                isTrainMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isTrainData", JsonHelper.getInstance().writeValueAsString(isTrainMap));
            Collection<SysLookupSimpleVo> isPcList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isPcMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isPcList) {
                isPcMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isPcData", JsonHelper.getInstance().writeValueAsString(isPcMap));
            Collection<SysLookupSimpleVo> isWirelessList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isWirelessMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isWirelessList) {
                isWirelessMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isWirelessData", JsonHelper.getInstance().writeValueAsString(isWirelessMap));
            Collection<SysLookupSimpleVo> isBearingMeetList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isBearingMeetMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isBearingMeetList) {
                isBearingMeetMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isBearingMeetData", JsonHelper.getInstance().writeValueAsString(isBearingMeetMap));
            Collection<SysLookupSimpleVo> isOutdoorUnitList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isOutdoorUnitMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isOutdoorUnitList) {
                isOutdoorUnitMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isOutdoorUnitData", JsonHelper.getInstance().writeValueAsString(isOutdoorUnitMap));
            Collection<SysLookupSimpleVo> isAllowOutdoorUnitList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAllowOutdoorUnitMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAllowOutdoorUnitList) {
                isAllowOutdoorUnitMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAllowOutdoorUnitData", JsonHelper.getInstance().writeValueAsString(isAllowOutdoorUnitMap));
            Collection<SysLookupSimpleVo> isNeedFoundationList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedFoundationMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedFoundationList) {
                isNeedFoundationMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedFoundationData", JsonHelper.getInstance().writeValueAsString(isNeedFoundationMap));
            Collection<SysLookupSimpleVo> isFoundationConditionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isFoundationConditionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isFoundationConditionList) {
                isFoundationConditionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isFoundationConditionData", JsonHelper.getInstance().writeValueAsString(isFoundationConditionMap));
            Collection<SysLookupSimpleVo> isVoltageConditionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isVoltageConditionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isVoltageConditionList) {
                isVoltageConditionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isVoltageConditionData", JsonHelper.getInstance().writeValueAsString(isVoltageConditionMap));
            Collection<SysLookupSimpleVo> isHumidityNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isHumidityNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isHumidityNeedList) {
                isHumidityNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isHumidityNeedData", JsonHelper.getInstance().writeValueAsString(isHumidityNeedMap));
            Collection<SysLookupSimpleVo> isCleanlinessNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isCleanlinessNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isCleanlinessNeedList) {
                isCleanlinessNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isCleanlinessNeedData", JsonHelper.getInstance().writeValueAsString(isCleanlinessNeedMap));
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
            Collection<SysLookupSimpleVo> isNoiseList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNoiseMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNoiseList) {
                isNoiseMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNoiseData", JsonHelper.getInstance().writeValueAsString(isNoiseMap));
            Collection<SysLookupSimpleVo> isNoiseInfluenceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNoiseInfluenceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNoiseInfluenceList) {
                isNoiseInfluenceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNoiseInfluenceData", JsonHelper.getInstance().writeValueAsString(isNoiseInfluenceMap));
            Collection<SysLookupSimpleVo> largeDeviceTypeList = sysLookupLoader.getLookUpListByTypeByAppId("SIMPLE_LARGE_SCALE", appId);
            HashMap<String, String> largeDeviceTypeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : largeDeviceTypeList) {
                largeDeviceTypeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("largeDeviceTypeData", JsonHelper.getInstance().writeValueAsString(largeDeviceTypeMap));
            Collection<SysLookupSimpleVo> instituteOrCompanyList = sysLookupLoader.getLookUpListByTypeByAppId("INSTITUTE_OR_COMPANY", appId);
            HashMap<String, String> instituteOrCompanyMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : instituteOrCompanyList) {
                instituteOrCompanyMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("instituteOrCompanyData", JsonHelper.getInstance().writeValueAsString(instituteOrCompanyMap));
            mav.addObject("dynSdCollecMainDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/dynsdcollecmain/" + "DynSdCollecMain" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveDynSdCollecMainDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            DynSdCollecMainDTO dynSdCollecMainDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<DynSdCollecMainDTO>() {
            });
            if (StringUtils.isEmpty(dynSdCollecMainDTO.getId())) {//新增
                dynSdCollecMainDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
                dynSdCollecMainService.insertDynSdCollecMain(dynSdCollecMainDTO);
            } else {//修改
                dynSdCollecMainService.updateDynSdCollecMainSensitive(dynSdCollecMainDTO);
            }
            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", dynSdCollecMainDTO.getId());
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
    public ModelAndView toDeleteDynSdCollecMainDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            dynSdCollecMainService.deleteDynSdCollecMainByIds(ids);
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
            DynSdCollecMainDTO dynSdCollecMain = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<DynSdCollecMainDTO>() {
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
            dynSdCollecMain.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
            StartResultBean result = dynSdCollecMainService.insertDynSdCollecMainAndStartProcess(dynSdCollecMain, parameter);

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
        DynSdCollecMainDTO dto = dynSdCollecMainService.queryDynSdCollecMainByPrimaryKey(id);


        dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


        dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode()));


        mav.addObject("flag", OpResult.success);
        mav.addObject("dynSdCollecMainDTO", dto);

        return mav;
    }

    /****************************子表操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String               ,               Object>
     */
    @RequestMapping(value = "/operation/sub/getAssetsSdequipCollect", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAssetsSdequipCollectByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsSdequipCollectDTO> queryReqBean = new QueryReqBean<AssetsSdequipCollectDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsSdequipCollectDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSdequipCollectDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSdequipCollectDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsSdequipCollectDTO param = null;
        QueryRespBean<AssetsSdequipCollectDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsSdequipCollectDTO>() {
            });
            param.setAttribute01(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsSdequipCollectDTO();
            param.setAttribute01(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsSdequipCollectServiceSub.searchAssetsSdequipCollectByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsSdequipCollectServiceSub.searchAssetsSdequipCollectByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsSdequipCollectDTO dto : result.getResult()) {


            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));

            dto.setAttribute02(sysUserLoader.getSysUserLoginNameById(dto.getCreatedByPersion()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));


            dto.setSecretLevelName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL", dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));


            dto.setDeviceTypeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE", dto.getDeviceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMeteringName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSceneMeteringName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMaintainName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMaintain(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAccuracyCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsRegularCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpotCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpecialDeviceName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsPrecisionIndexName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPrecisionIndex(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedInstallName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsFoundationName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundation(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSafetyProductionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));

            dto.setFinancialResourcesName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));


            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));


            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

            dto.setDemandUrgencyDegreeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEMAND_URGENCY_DEGREE", dto.getDemandUrgencyDegree(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsTrainName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTrain(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsPcName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPc(), sysApplicationAPI.getCurrentAppId()));


            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));

            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));

            dto.setIsWirelessName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWireless(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsBearingMeetName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsBearingMeet(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsOutdoorUnitName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAllowOutdoorUnitName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAllowOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedFoundationName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedFoundation(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsFoundationConditionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundationCondition(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsVoltageConditionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsVoltageCondition(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsHumidityNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsCleanlinessNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsCleanlinessNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsWaterNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsGasNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsLetName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsOtherNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsNoiseName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoise(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNoiseInfluenceName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoiseInfluence(), sysApplicationAPI.getCurrentAppId()));


            dto.setLargeDeviceTypeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SIMPLE_LARGE_SCALE", dto.getLargeDeviceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setInstituteOrCompanyName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY", dto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId()));


        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsSdequipCollectDTO分页数据");
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
            AssetsSdequipCollectDTO dto = assetsSdequipCollectServiceSub.queryAssetsSdequipCollectByPrimaryKey(id);

            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));
            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));
            mav.addObject("assetsSdequipCollectDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/dynsdcollecmain/" + "AssetsSdequipCollect" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAssetsSdequipCollectDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AssetsSdequipCollectDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat, new TypeReference<List<AssetsSdequipCollectDTO>>() {
            });
            assetsSdequipCollectServiceSub.insertOrUpdateAssetsSdequipCollect(list, pid);
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
    public ModelAndView toDeleteAssetsSdequipCollectDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsSdequipCollectServiceSub.deleteAssetsSdequipCollectByIds(ids);
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
            Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL", appId);
            HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : secretLevelList) {
                secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
            Collection<SysLookupSimpleVo> deviceTypeList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_TYPE", appId);
            HashMap<String, String> deviceTypeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceTypeList) {
                deviceTypeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceTypeData", JsonHelper.getInstance().writeValueAsString(deviceTypeMap));
            Collection<SysLookupSimpleVo> deviceCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);
            HashMap<String, String> deviceCategoryMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : deviceCategoryList) {
                deviceCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("deviceCategoryData", JsonHelper.getInstance().writeValueAsString(deviceCategoryMap));
            Collection<SysLookupSimpleVo> isMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMeteringList) {
                isMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMeteringData", JsonHelper.getInstance().writeValueAsString(isMeteringMap));
            Collection<SysLookupSimpleVo> isSceneMeteringList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSceneMeteringMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSceneMeteringList) {
                isSceneMeteringMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSceneMeteringData", JsonHelper.getInstance().writeValueAsString(isSceneMeteringMap));
            Collection<SysLookupSimpleVo> isMaintainList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isMaintainMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isMaintainList) {
                isMaintainMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isMaintainData", JsonHelper.getInstance().writeValueAsString(isMaintainMap));
            Collection<SysLookupSimpleVo> isAccuracyCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAccuracyCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAccuracyCheckList) {
                isAccuracyCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAccuracyCheckData", JsonHelper.getInstance().writeValueAsString(isAccuracyCheckMap));
            Collection<SysLookupSimpleVo> isRegularCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isRegularCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isRegularCheckList) {
                isRegularCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isRegularCheckData", JsonHelper.getInstance().writeValueAsString(isRegularCheckMap));
            Collection<SysLookupSimpleVo> isSpotCheckList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSpotCheckMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSpotCheckList) {
                isSpotCheckMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSpotCheckData", JsonHelper.getInstance().writeValueAsString(isSpotCheckMap));
            Collection<SysLookupSimpleVo> isSpecialDeviceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSpecialDeviceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSpecialDeviceList) {
                isSpecialDeviceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSpecialDeviceData", JsonHelper.getInstance().writeValueAsString(isSpecialDeviceMap));
            Collection<SysLookupSimpleVo> isPrecisionIndexList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isPrecisionIndexMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isPrecisionIndexList) {
                isPrecisionIndexMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isPrecisionIndexData", JsonHelper.getInstance().writeValueAsString(isPrecisionIndexMap));
            Collection<SysLookupSimpleVo> isNeedInstallList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedInstallMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedInstallList) {
                isNeedInstallMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedInstallData", JsonHelper.getInstance().writeValueAsString(isNeedInstallMap));
            Collection<SysLookupSimpleVo> isFoundationList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isFoundationMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isFoundationList) {
                isFoundationMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isFoundationData", JsonHelper.getInstance().writeValueAsString(isFoundationMap));
            Collection<SysLookupSimpleVo> isSafetyProductionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSafetyProductionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSafetyProductionList) {
                isSafetyProductionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSafetyProductionData", JsonHelper.getInstance().writeValueAsString(isSafetyProductionMap));
            Collection<SysLookupSimpleVo> financialResourcesList = sysLookupLoader.getLookUpListByTypeByAppId("FINANCIAL_RESOURCES", appId);
            HashMap<String, String> financialResourcesMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : financialResourcesList) {
                financialResourcesMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("financialResourcesData", JsonHelper.getInstance().writeValueAsString(financialResourcesMap));
            Collection<SysLookupSimpleVo> demandUrgencyDegreeList = sysLookupLoader.getLookUpListByTypeByAppId("DEMAND_URGENCY_DEGREE", appId);
            HashMap<String, String> demandUrgencyDegreeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : demandUrgencyDegreeList) {
                demandUrgencyDegreeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("demandUrgencyDegreeData", JsonHelper.getInstance().writeValueAsString(demandUrgencyDegreeMap));
            Collection<SysLookupSimpleVo> isTrainList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isTrainMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isTrainList) {
                isTrainMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isTrainData", JsonHelper.getInstance().writeValueAsString(isTrainMap));
            Collection<SysLookupSimpleVo> isPcList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isPcMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isPcList) {
                isPcMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isPcData", JsonHelper.getInstance().writeValueAsString(isPcMap));
            Collection<SysLookupSimpleVo> isWirelessList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isWirelessMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isWirelessList) {
                isWirelessMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isWirelessData", JsonHelper.getInstance().writeValueAsString(isWirelessMap));
            Collection<SysLookupSimpleVo> isBearingMeetList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isBearingMeetMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isBearingMeetList) {
                isBearingMeetMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isBearingMeetData", JsonHelper.getInstance().writeValueAsString(isBearingMeetMap));
            Collection<SysLookupSimpleVo> isOutdoorUnitList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isOutdoorUnitMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isOutdoorUnitList) {
                isOutdoorUnitMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isOutdoorUnitData", JsonHelper.getInstance().writeValueAsString(isOutdoorUnitMap));
            Collection<SysLookupSimpleVo> isAllowOutdoorUnitList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isAllowOutdoorUnitMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isAllowOutdoorUnitList) {
                isAllowOutdoorUnitMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isAllowOutdoorUnitData", JsonHelper.getInstance().writeValueAsString(isAllowOutdoorUnitMap));
            Collection<SysLookupSimpleVo> isNeedFoundationList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNeedFoundationMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNeedFoundationList) {
                isNeedFoundationMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNeedFoundationData", JsonHelper.getInstance().writeValueAsString(isNeedFoundationMap));
            Collection<SysLookupSimpleVo> isFoundationConditionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isFoundationConditionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isFoundationConditionList) {
                isFoundationConditionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isFoundationConditionData", JsonHelper.getInstance().writeValueAsString(isFoundationConditionMap));
            Collection<SysLookupSimpleVo> isVoltageConditionList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isVoltageConditionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isVoltageConditionList) {
                isVoltageConditionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isVoltageConditionData", JsonHelper.getInstance().writeValueAsString(isVoltageConditionMap));
            Collection<SysLookupSimpleVo> isHumidityNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isHumidityNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isHumidityNeedList) {
                isHumidityNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isHumidityNeedData", JsonHelper.getInstance().writeValueAsString(isHumidityNeedMap));
            Collection<SysLookupSimpleVo> isCleanlinessNeedList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isCleanlinessNeedMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isCleanlinessNeedList) {
                isCleanlinessNeedMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isCleanlinessNeedData", JsonHelper.getInstance().writeValueAsString(isCleanlinessNeedMap));
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
            Collection<SysLookupSimpleVo> isNoiseList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNoiseMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNoiseList) {
                isNoiseMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNoiseData", JsonHelper.getInstance().writeValueAsString(isNoiseMap));
            Collection<SysLookupSimpleVo> isNoiseInfluenceList = sysLookupLoader.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isNoiseInfluenceMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isNoiseInfluenceList) {
                isNoiseInfluenceMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isNoiseInfluenceData", JsonHelper.getInstance().writeValueAsString(isNoiseInfluenceMap));
            Collection<SysLookupSimpleVo> largeDeviceTypeList = sysLookupLoader.getLookUpListByTypeByAppId("SIMPLE_LARGE_SCALE", appId);
            HashMap<String, String> largeDeviceTypeMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : largeDeviceTypeList) {
                largeDeviceTypeMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("largeDeviceTypeData", JsonHelper.getInstance().writeValueAsString(largeDeviceTypeMap));
            Collection<SysLookupSimpleVo> instituteOrCompanyList = sysLookupLoader.getLookUpListByTypeByAppId("INSTITUTE_OR_COMPANY", appId);
            HashMap<String, String> instituteOrCompanyMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : instituteOrCompanyList) {
                instituteOrCompanyMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("instituteOrCompanyData", JsonHelper.getInstance().writeValueAsString(instituteOrCompanyMap));
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
     * @return Map<String , Object>
     */
    @RequestMapping(value = "/operation/sub/getAssetsSdequipCollectCm", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAssetsSdequipCollectCmByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsSdequipCollectCmDTO> queryReqBean = new QueryReqBean<AssetsSdequipCollectCmDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsSdequipCollectCmDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSdequipCollectCmDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsSdequipCollectCmDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsSdequipCollectCmDTO param = null;
        QueryRespBean<AssetsSdequipCollectCmDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AssetsSdequipCollectCmDTO>() {
            });
            param.setAttribute01(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AssetsSdequipCollectCmDTO();
            param.setParentId(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsSdequipCollectCmServiceSub.searchAssetsSdequipCollectCmByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsSdequipCollectCmServiceSub.searchAssetsSdequipCollectCmByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsSdequipCollectCmDTO dto : result.getResult()) {


            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getCreatedByPersion()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode()));


            dto.setSecretLevelName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL", dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));


            dto.setDeviceTypeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE", dto.getDeviceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setDeviceCategoryName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMeteringName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSceneMeteringName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMaintainName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMaintain(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAccuracyCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsRegularCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpotCheckName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpecialDeviceName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsPrecisionIndexName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPrecisionIndex(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedInstallName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsFoundationName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundation(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSafetyProductionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));

            dto.setFinancialResourcesName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));


            dto.setChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getChiefEngineer()));


            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

            dto.setDemandUrgencyDegreeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEMAND_URGENCY_DEGREE", dto.getDemandUrgencyDegree(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsTrainName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTrain(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsPcName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPc(), sysApplicationAPI.getCurrentAppId()));


            dto.setBuyerAlias(sysUserLoader.getSysUserNameById(dto.getBuyer()));

            dto.setPlanBuyerAlias(sysUserLoader.getSysUserNameById(dto.getPlanBuyer()));

            dto.setIsWirelessName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWireless(), sysApplicationAPI.getCurrentAppId()));

            dto.setDevicePurchaseTypeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_PURCHASE_TYPE", dto.getDevicePurchaseType(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsWeedOutName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWeedOut(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsBearingMeetName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsBearingMeet(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsOutdoorUnitName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAllowOutdoorUnitName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAllowOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedFoundationName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedFoundation(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsFoundationConditionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsFoundationCondition(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsVoltageConditionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsVoltageCondition(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsHumidityNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsCleanlinessNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsCleanlinessNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsWaterNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsGasNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsLetName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsOtherNeedName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));


            dto.setIsNoiseName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoise(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNoiseInfluenceName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNoiseInfluence(), sysApplicationAPI.getCurrentAppId()));


            dto.setExamineApproveEngineerAlias(sysUserLoader.getSysUserNameById(dto.getExamineApproveEngineer()));

            dto.setProfessionalAuditorAlias(sysUserLoader.getSysUserNameById(dto.getProfessionalAuditor()));

            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));


            dto.setLargeDeviceTypeName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SIMPLE_LARGE_SCALE", dto.getLargeDeviceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setInstituteOrCompanyName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY", dto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId()));


        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsSdequipCollectCmDTO分页数据");
        return map;
    }






    /**
     * 按照id批量删除数据
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/deletecm", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsSdequipCollectCmDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsSdequipCollectCmServiceSub.deleteAssetsSdequipCollectCmByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
    /**
     * 批量下发
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/submit", method = RequestMethod.POST)
    public ModelAndView submitAssetsSdequipCollectCmDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {

           for(int i = 0; i < ids.length; i++)
           {
               AssetsStdtempAcceptanceService stdtempAcceptanceService = SpringFactory.getBean("assetsStdtempAcceptanceService");
               AssetsSdequipCollectCmDTO dto = assetsSdequipCollectCmDao.findAssetsSdequipCollectCmById(ids[i]);
               Integer deviceNum = Integer.parseInt(dto.getDeviceNum().toString());
               BpmOperateService bpmOperateService = SpringFactory.getBean("bpmOperateService");
               AssetsStdtempAcceptanceDTO acceptanceDTO = new AssetsStdtempAcceptanceDTO();
               for (int j = 0;  j<deviceNum; j++) {
                   Map<String, Object> variables = new HashMap<String, Object>();
                   acceptanceDTO.setDeviceName(dto.getDeviceName());
                   acceptanceDTO.setStdId(dto.getStdId());
                   acceptanceDTO.setCreatedByTel(dto.getCreatedByTel());
                   acceptanceDTO.setBuyerDept(dto.getCreatedByDept());
                   acceptanceDTO.setBuyer(dto.getBuyer());
                   acceptanceDTO.setDeviceCategory(dto.getDeviceCategory());
                   acceptanceDTO.setDeviceModel(dto.getDeviceModel());
                   acceptanceDTO.setDeviceSpec(dto.getDeviceSpec());
                   acceptanceDTO.setIsRegularCheck(dto.getIsRegularCheck());
                   acceptanceDTO.setIsSpotCheck(dto.getIsSpotCheck());
                   acceptanceDTO.setIsMeasuring(dto.getIsMetering());
                   acceptanceDTO.setIsSceneMeasuring(dto.getIsSceneMetering());
                   acceptanceDTO.setIsAccuracyCheck(dto.getIsAccuracyCheck());
                   acceptanceDTO.setIsInstall(dto.getIsNeedInstall());
                   acceptanceDTO.setIsMaintain(dto.getIsMaintain());
                   acceptanceDTO.setIsPc(dto.getIsPc());
                   acceptanceDTO.setIsSafetyProduction(dto.getIsSafetyProduction());
                   String stdtId = stdtempAcceptanceService.insertAssetsStdtempAcceptance(acceptanceDTO);
                   System.err.println(stdtId);
                   AssetsStdtempAcceptanceDTO bean = stdtempAcceptanceService.queryAssetsStdtempAcceptanceByPrimaryKey(stdtId);
                   Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
                   variables.putAll(pojoMap);
                   bpmOperateService.startProcessInstanceById("297eb3b07356cbfe01735a7e60bf048e-1", "assetsStdempAcceptance", dto.getBuyer(), dto.getCreatedByDept(), variables);
               }
           }
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
                rst = this.toGetAssetsSdequipCollectByPid(pp, request);
            } catch (Exception var27) {
                this.logger.error("数据查询异常:" + var27.getMessage(), var27);
                return "excel.down";
            }

            ArrayList<AssetsStdtempAcceptanceDTO> aa = (ArrayList)rst.get("rows");
            DefaultTypeReferenceDataSource<AssetsStdtempAcceptanceDTO> dt = new DefaultTypeReferenceDataSource();
            dt.setData(aa);
            serverExp.setExportDataSource(dt);
            serverExp.setFormatField(this._formateApp);
            this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
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
                    rst = this.toGetAssetsSdequipCollectByPid(pp, request);
                } catch (Exception var28) {
                    this.logger.error("数据查询异常:" + var28.getMessage(), var28);
                    return "excel.down";
                }

                ArrayList<AssetsSdequipCollectDTO> aa = (ArrayList)rst.get("rows");
                DefaultTypeReferenceDataSource<AssetsSdequipCollectDTO> dt = new DefaultTypeReferenceDataSource();
                dt.setData(aa);
                serverExp.setExportDataSource(dt);
                serverExp.setFormatField(this._formateApp);
                this._formateApp.setAppList(this.appAPI.getAllSysApplicationList());
                Workbook workbook = serverExp.exportData();
                ZipEntry entry = new ZipEntry("ExportSysLog-from[" + first + "]to[" + end + "].xls");
                out.putNextEntry(entry);
                workbook.write(out);
            }

            out.close();
            map.addAttribute("byte", baps.toByteArray());
            map.addAttribute("name", fileName + ".rar");
            return "byte.down";
        }
    }


}
