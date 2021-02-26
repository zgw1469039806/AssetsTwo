package avicit.assets.device.assetsdeviceaccount.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
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
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import com.fasterxml.jackson.core.type.TypeReference;

import avicit.platform6.api.syslookup.SysLookupAPI;



/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 17:59
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsdeviceaccount/assetsDeviceAccountController")
public class AssetsDeviceAccountController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceAccountController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsDeviceAccountService assetsDeviceAccountService;

    @Autowired
    private SysLookupAPI lookup;


    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsDeviceAccountManage")
    public ModelAndView toAssetsDeviceAccountManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountManage");
        mav.addObject("url", "platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/");

        mav.addObject("deviceCategory", "'N'");//将'N'字符串传递给详情页的Tab页，deviceCategory

        return mav;
    }

    /**
     * 跳转到管理页面（跳转时向后台传递设备类别参数）
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsDeviceAccountManage/{deviceCategory}")
    public ModelAndView toAssetsDeviceAccountManage(HttpServletRequest request, HttpServletResponse reponse, @PathVariable String deviceCategory) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountManage");
        mav.addObject("url", "platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/");

        mav.addObject("deviceCategory", deviceCategory);//将资产类别传递给前台

        return mav;
    }
    /**
     * 跳转到弹出页面
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value="toAssetsDeviceAccountSelect")
    public ModelAndView toAssetsDeviceAccountSelect(HttpServletRequest request,HttpServletResponse reponse){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountSelect");
        request.setAttribute("url", "platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/");
        return mav;
    }
    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String ,   Object>
     */
    @RequestMapping(value = "/operation/getAssetsDeviceAccountsByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsDeviceAccountByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsDeviceAccountDTO> queryReqBean = new QueryReqBean<AssetsDeviceAccountDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsDeviceAccountDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsDeviceAccountDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsDeviceAccountDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsDeviceAccountService.searchAssetsDeviceAccountByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsDeviceAccountService.searchAssetsDeviceAccountByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        int index = 0;//列表序号
        for (AssetsDeviceAccountDTO dto : result.getResult()) {

            index++;//列表序号遍历
            dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                    dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));

            dto.setUserDeptAlias(
                    sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));

            dto.setIsManage(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsManage(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsInWorkflow(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsInWorkflow(), sysApplicationAPI.getCurrentAppId()));

            dto.setManageState(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                    dto.getManageState(), sysApplicationAPI.getCurrentAppId()));

            dto.setDeviceState(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                    dto.getDeviceState(), sysApplicationAPI.getCurrentAppId()));

            dto.setAbcCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
                    dto.getAbcCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsKeyDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsKeyDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsResearch(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsResearch(), sysApplicationAPI.getCurrentAppId()));

            dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                    dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMaintain(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsMaintain(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAccuracyCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsRegularCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpotCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSpecialDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSafetyProduction(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsPc(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsPc(),
                    sysApplicationAPI.getCurrentAppId()));

            dto.setDeviceType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE",
                    dto.getDeviceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setMetermanAlias(sysUserLoader.getSysUserNameById(dto.getMeterman()));

            dto.setPlanMetermanAlias(sysUserLoader.getSysUserNameById(dto.getPlanMeterman()));

            dto.setMeteringDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getMeteringDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setIsSceneMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setMeteringConclution(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
                    dto.getMeteringConclution(), sysApplicationAPI.getCurrentAppId()));

            dto.setRepairDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getRepairDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setDeviceRelatedManAlias(sysUserLoader.getSysUserNameById(dto.getDeviceRelatedMan()));

            dto.setIsLabDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsLabDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsFixedAssets(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsFixedAssets(), sysApplicationAPI.getCurrentAppId()));

            dto.setAssetsFinanceType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_TYPE",
                    dto.getAssetsFinanceType(), sysApplicationAPI.getCurrentAppId()));

            dto.setAssetsSource(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_SOURCE",
                    dto.getAssetsSource(), sysApplicationAPI.getCurrentAppId()));

            dto.setAssetsFinanceState(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_STATE",
                    dto.getAssetsFinanceState(), sysApplicationAPI.getCurrentAppId()));

            dto.setInstituteOrCompany(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY",
                    dto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsTransFixed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsTransFixed(), sysApplicationAPI.getCurrentAppId()));

            dto.setMeteringOuterAlias(sysUserLoader.getSysUserNameById(dto.getMeteringOuter()));

            dto.setMajorType(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", dto.getMajorType(),
                    sysApplicationAPI.getCurrentAppId()));

            dto.setDeviceNature(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_NATURE",
                    dto.getDeviceNature(), sysApplicationAPI.getCurrentAppId()));

            dto.setSoftwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getSoftwareDesigner()));

            dto.setHardwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getHardwareDesigner()));

            dto.setIsTestDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsNeedCertificate(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsNeedCertificate(), sysApplicationAPI.getCurrentAppId()));

            result.getResult().get(index - 1).setAttribute01("" + index);//用备用字段attribute01赋值并传递到前台
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsDeviceAccountDTO分页数据");
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
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
            throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsDeviceAccountDTO dto = assetsDeviceAccountService.queryAssetsDeviceAccountByPrimaryKey(id);

            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));

            dto.setUserDeptAlias(
                    sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));

            dto.setMetermanAlias(sysUserLoader.getSysUserNameById(dto.getMeterman()));

            dto.setPlanMetermanAlias(sysUserLoader.getSysUserNameById(dto.getPlanMeterman()));

            dto.setMeteringDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getMeteringDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setRepairDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getRepairDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setDeviceRelatedManAlias(sysUserLoader.getSysUserNameById(dto.getDeviceRelatedMan()));

            dto.setMeteringOuterAlias(sysUserLoader.getSysUserNameById(dto.getMeteringOuter()));

            dto.setSoftwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getSoftwareDesigner()));

            dto.setHardwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getHardwareDesigner()));

            mav.addObject("assetsDeviceAccountDTO", dto);
        }
        mav.setViewName("avicit/assets/device/assetsdeviceaccount/" + "AssetsDeviceAccount" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsDeviceAccountDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsDeviceAccountDTO assetsDeviceAccountDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<AssetsDeviceAccountDTO>() {
                    });
            if (StringUtils.isEmpty(assetsDeviceAccountDTO.getId())) {//新增
                assetsDeviceAccountService.insertAssetsDeviceAccount(assetsDeviceAccountDTO);
            } else {//修改
                assetsDeviceAccountService.updateAssetsDeviceAccountSensitive(assetsDeviceAccountDTO);
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
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsDeviceAccountDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsDeviceAccountService.deleteAssetsDeviceAccountByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 根据id获取台账详情，改造AssetsDeviceAccountDTO并返回Map
     *
     * @return Map<String ,   Object>
     * @throws Exception
     */
    @RequestMapping(value = "/operation/getAccountDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAccountDetail(@RequestBody Map<String, String> map) throws Exception {
        AssetsDeviceAccountDTO dto = new AssetsDeviceAccountDTO();
        Map<String, Object> assetsDeviceAccountDTOMap = new HashMap<String, Object>();
        Collection<SysLookupSimpleVo> lookupList;
        if(map.get("id")==""||map.get("id").equals("")){
            return assetsDeviceAccountDTOMap;
        }
        //Alias字段赋值
        dto = assetsDeviceAccountService.queryAssetsDeviceAccountByPrimaryKey(map.get("id"));
        if(dto != null){
            dto.setMetermanAlias(sysUserLoader.getSysUserNameById(dto.getMeterman()));
            dto.setPlanMetermanAlias(sysUserLoader.getSysUserNameById(dto.getPlanMeterman()));
            dto.setMeteringDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getMeteringDept(),SessionHelper.getCurrentLanguageCode()));
            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),SessionHelper.getCurrentLanguageCode()));
            dto.setUserIdAlias(sysUserLoader.getSysUserNameById(dto.getUserId()));
            dto.setUserDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setMetermanAlias(sysUserLoader.getSysUserNameById(dto.getMeterman()));
            dto.setPlanMetermanAlias(sysUserLoader.getSysUserNameById(dto.getPlanMeterman()));
            dto.setMeteringDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getMeteringDept(),SessionHelper.getCurrentLanguageCode()));
            dto.setRepairDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getRepairDept(),SessionHelper.getCurrentLanguageCode()));
            dto.setDeviceRelatedManAlias(sysUserLoader.getSysUserNameById(dto.getDeviceRelatedMan()));
            dto.setMeteringOuterAlias(sysUserLoader.getSysUserNameById(dto.getMeteringOuter()));
            dto.setSoftwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getSoftwareDesigner()));
            dto.setHardwareDesignerAlias(sysUserLoader.getSysUserNameById(dto.getHardwareDesigner()));
        }

        //主表DTO数据
        assetsDeviceAccountDTOMap.put("assetsAccountDTO", dto);

        //平台公用是否下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("yesNoList", lookupList);
        //设备类别下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("DEVICE_CATEGORY", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("deviceCategoryList", lookupList);
        //统管设备状态下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("MANAGE_STATE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("manageStateList", lookupList);
        //设备状态下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("DEVICE_STATE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("deviceStateList", lookupList);
        //ABC分类下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("ABC_CATEGORY", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("abcCategoryList", lookupList);

        //设备类型
        //专业类别
        //设备性质

        //资产财务类别下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("ASSETS_FINANCE_TYPE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("assetsFinanceTypeList", lookupList);
        //资产来源下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("ASSETS_SOURCE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("assetsSourceList", lookupList);
        //资产财务状态下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("ASSETS_FINANCE_STATE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("assetsFinanceStateList", lookupList);
        //研究所/公司下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("INSTITUTE_OR_COMPANY", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("instituteOrCompanyList", lookupList);
        //计量结论下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("METERING_CONCLUTION", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("meteringConclusionList", lookupList);
        //计量方式下拉列表
        lookupList = lookup.getLookUpListByTypeByAppId("METERING_MODE", SessionHelper.getApplicationId());
        assetsDeviceAccountDTOMap.put("meteringModeList", lookupList);

        return assetsDeviceAccountDTOMap;
    }

    /**
     * 根据id获取台账下附件列表，给Map添加附件列表并返回Map
     *
     * @return Map<String ,   Object>
     * @throws Exception
     */
    @RequestMapping(value = "/operation/getAttachmentList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAttachmentList(@RequestBody Map<String, String> map) throws Exception {
        AssetsDeviceAccountDTO dto = new AssetsDeviceAccountDTO();
        Map<String, Object> assetsDeviceAccountDTOMap = new HashMap<String, Object>();
        if(map.get("id")==""||map.get("id").equals("")){
            return assetsDeviceAccountDTOMap;
        }
        else{
            List<AssetsDeviceAccountDTO> attachmentList;
            QueryReqBean<AssetsDeviceAccountDTO> queryReqBean = new QueryReqBean<AssetsDeviceAccountDTO>();
            dto.setParentId(map.get("id"));
            queryReqBean.setSearchParams(dto);
            attachmentList = assetsDeviceAccountService.searchAssetsDeviceAccount(queryReqBean);
            for(AssetsDeviceAccountDTO accountDTO:attachmentList){
                accountDTO.setOwnerIdAlias(sysUserLoader.getSysUserNameById(accountDTO.getOwnerId()));
            }
            assetsDeviceAccountDTOMap.put("attachmentList", attachmentList);
            return assetsDeviceAccountDTOMap;
        }
    }
    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String ,   Object>
     */
    @RequestMapping(value = "/operation/getAssetsDeviceAccountsSelect")
    @ResponseBody
    public Map<String, Object> togetAssetsDeviceAccountSelect(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsDeviceAccountDTO> queryReqBean = new QueryReqBean<AssetsDeviceAccountDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsDeviceAccountDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsDeviceAccountDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsDeviceAccountDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsDeviceAccountDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsDeviceAccountService.searchAssetsDeviceAccountByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsDeviceAccountService.searchAssetsDeviceAccountByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        int index = 0;//列表序号
        for (AssetsDeviceAccountDTO dto : result.getResult()) {

            index++;//列表序号遍历
            dto.setDeviceCategoryId(dto.getDeviceCategory());
            dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                    dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));

            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(),
                    SessionHelper.getCurrentLanguageCode()));



            result.getResult().get(index - 1).setAttribute01("" + index);//用备用字段attribute01赋值并传递到前台
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsDeviceAccountDTO分页数据");
        return map;
    }
}




