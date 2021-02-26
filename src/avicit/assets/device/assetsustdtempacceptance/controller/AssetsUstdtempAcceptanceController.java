package avicit.assets.device.assetsustdtempacceptance.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.assets.assetsapplymodule.service.AssetsApplyModuleService;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsustdtempapplyproc.dto.AssetsUstdtempapplyProcDTO;
import avicit.assets.device.assetsustdtempapplyproc.service.AssetsUstdtempapplyProcService;
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

import avicit.assets.device.assetsustdtempacceptance.service.AssetsUstdtempAcceptanceService;
import avicit.assets.device.assetsustdtempacceptance.service.AcceptanceDeviceComponentService;
import avicit.assets.device.assetsustdtempacceptance.dto.AcceptanceDeviceComponentDTO;
import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 11:13
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController")
public class AssetsUstdtempAcceptanceController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsUstdtempAcceptanceController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsUstdtempAcceptanceService assetsUstdtempAcceptanceService;

    @Autowired
    private AcceptanceDeviceComponentService acceptanceDeviceComponentServiceSub;

    @Autowired
    private UserTableModelService userTableModelService;

    @Autowired
    private AssetsUstdtempapplyProcService assetsUstdtempapplyProcService;

    @Autowired
    private AssetsApplyModuleService assetsApplyModuleService;

    @Autowired
    private ClassifyDataService classifyDataService;

    @Autowired
    private AssetsDeviceAccountService assetsDeviceAccountService;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsUstdtempAcceptanceManage")
    public ModelAndView toAssetsUstdtempAcceptanceManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsustdtempacceptance/AssetsUstdtempAcceptanceManage");
        mav.addObject("url",
                "platform/assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/");
        mav.addObject("surl",
                "platform/assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/sub/");

        /*用户视图、默认表头获取代码——开始*/
        SysUser user = SessionHelper.getLoginSysUser(request);   //获取当前登录用户
        List<String> viewList = new ArrayList<>();  //获取用户视图列表

        //获取非标验收表头字段
        try {
            viewList = userTableModelService.getUserViewList(user.getId(),"AssetsUstdtempAcceptance");
            mav.addObject("viewList", viewList);

            StringBuffer assetsUstdtempAcceptanceGridColModel = new StringBuffer();
            assetsUstdtempAcceptanceGridColModel.append("[");

            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AssetsUstdtempAcceptance", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "AssetsUstdtempAcceptance", "系统默认视图", "Y");
            }

            for(int i=0; i<modelList.size(); i++){
                if(i == 0){
                    assetsUstdtempAcceptanceGridColModel.append(modelList.get(i).getFieldModel());
                }
                else{
                    assetsUstdtempAcceptanceGridColModel.append("," + modelList.get(i).getFieldModel());
                }
            }
            assetsUstdtempAcceptanceGridColModel.append("]");

            mav.addObject("assetsUstdtempAcceptanceGridColModel", assetsUstdtempAcceptanceGridColModel.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

        //获取非标验收设备组件表头字段
        try {
            StringBuffer acceptanceDeviceComponentGridColModel = new StringBuffer();
            acceptanceDeviceComponentGridColModel.append("[");

            viewList = userTableModelService.getUserViewList(user.getId(),"AcceptanceDeviceComponent");
            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AcceptanceDeviceComponent", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "AcceptanceDeviceComponent", "系统默认视图", "Y");
            }

            for(int i=0; i<modelList.size(); i++){
                if(i == 0){
                    acceptanceDeviceComponentGridColModel.append(modelList.get(i).getFieldModel());
                }
                else{
                    acceptanceDeviceComponentGridColModel.append("," + modelList.get(i).getFieldModel());
                }
            }
            acceptanceDeviceComponentGridColModel.append("]");

            mav.addObject("acceptanceDeviceComponentGridColModel", acceptanceDeviceComponentGridColModel.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*用户视图、默认表头获取代码——结束*/

        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsUstdtempAcceptancesByPage")
    @ResponseBody
    public Map<String, Object> toGetAssetsUstdtempAcceptanceByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsUstdtempAcceptanceDTO> queryReqBean = new QueryReqBean<AssetsUstdtempAcceptanceDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsUstdtempAcceptanceDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempAcceptanceDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                }
                else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdtempAcceptanceDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsUstdtempAcceptanceDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsUstdtempAcceptanceDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat,
                    new TypeReference<AssetsUstdtempAcceptanceDTO>() {
                    });
        } else {
            param = new AssetsUstdtempAcceptanceDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = assetsUstdtempAcceptanceService.searchAssetsUstdtempAcceptanceByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsUstdtempAcceptanceService.searchAssetsUstdtempAcceptanceByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        for (AssetsUstdtempAcceptanceDTO dto : result.getResult()) {
            dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
            dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));
            dto.setSecretLevel(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL", dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));

            dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));
            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

            if(dto.getDeviceCategory() != null){
                ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(dto.getDeviceCategory());
                if(classifyDataDTO != null){
                    dto.setDeviceCategory(classifyDataDTO.getName());
                }
            }

            dto.setIfRegularCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfRegularCheck(), sysApplicationAPI.getCurrentAppId()));
            dto.setIfSpotCheck(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfSpotCheck(), sysApplicationAPI.getCurrentAppId()));
            dto.setIfPrecisionInspection(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfPrecisionInspection(), sysApplicationAPI.getCurrentAppId()));

            dto.setIfUpkeep(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfUpkeep(), sysApplicationAPI.getCurrentAppId()));
            dto.setIfMeasure(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfMeasure(), sysApplicationAPI.getCurrentAppId()));
            dto.setIfInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfInstall(), sysApplicationAPI.getCurrentAppId()));
            dto.setIfMeasureOnsite(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfMeasureOnsite(), sysApplicationAPI.getCurrentAppId()));

            dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));
            dto.setIfHasComputer(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIfHasComputer(), sysApplicationAPI.getCurrentAppId()));
            dto.setIsSafetyProduction(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));
            dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));

            dto.setAbcCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY", dto.getAbcCategory(), sysApplicationAPI.getCurrentAppId()));
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsUstdtempAcceptanceDTO分页数据");
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
            AssetsUstdtempAcceptanceDTO dto = assetsUstdtempAcceptanceService.queryAssetsUstdtempAcceptanceByPrimaryKey(id);

            dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
            dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));
            dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));

            dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(), SessionHelper.getCurrentLanguageCode()));
            dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
            dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));

            mav.addObject("assetsUstdtempAcceptanceDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsustdtempacceptance/" + "AssetsUstdtempAcceptance" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsUstdtempAcceptanceDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO = JsonHelper.getInstance().readValue(jsonData,
                    dateFormat, new TypeReference<AssetsUstdtempAcceptanceDTO>() {});

            List<AcceptanceDeviceComponentDTO> acceptanceDeviceComponentList = JsonHelper.getInstance()
                    .readValue(jsonDataSub, dateFormat, new TypeReference<List<AcceptanceDeviceComponentDTO>>() {});

            AssetsApplyModuleDTO moduleDto = null;
            //申购单号不为空
            if((assetsUstdtempAcceptanceDTO.getSubscribeNo() != null) && (!"".equals(assetsUstdtempAcceptanceDTO.getSubscribeNo()))){
                //获取对应的申购单数据
                AssetsUstdtempapplyProcDTO applyDto = assetsUstdtempapplyProcService.getAssetsUstdtempapplyProcBySubscribeNo(assetsUstdtempAcceptanceDTO.getSubscribeNo());

                //获取合同数据
                moduleDto = assetsApplyModuleService.getAssetsApplyModulesByApplyId(applyDto.getId());
                if(moduleDto == null){
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("msg", "该验收缺少相应的合同数据，暂时不能提交！");
                    return mav;
                }
                else{
                    assetsUstdtempAcceptanceDTO.setDeviceName(moduleDto.getContractDeviceName());   //设备名称
                    assetsUstdtempAcceptanceDTO.setSetsCount(1L);   //台套数：1
                    assetsUstdtempAcceptanceDTO.setUnitPrice(moduleDto.getApplyPrice());    //单价
                    assetsUstdtempAcceptanceDTO.setManufacturerId(moduleDto.getApplyManufacturer());    //生产厂家

                    assetsUstdtempAcceptanceDTO.setContractNum(moduleDto.getContractNum()); //合同编号
                }
            }

            //验证统一编号
            AssetsUstdtempAcceptanceDTO oldAcceptanceDTO = assetsUstdtempAcceptanceService.queryAssetsUstdtempAcceptanceByPrimaryKey(assetsUstdtempAcceptanceDTO.getId());
            if((oldAcceptanceDTO.getUnifiedId() != null) && (!"".equals(oldAcceptanceDTO.getUnifiedId()))
                    && (!oldAcceptanceDTO.getUnifiedId().equals(assetsUstdtempAcceptanceDTO.getUnifiedId()))){
                String unifiedId = assetsUstdtempAcceptanceDTO.getUnifiedId();

                ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(assetsUstdtempAcceptanceDTO.getDeviceCategory());
                String classifyCode = classifyDataDTO.getCode();
                if(unifiedId.startsWith(classifyCode)){
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("msg", "统一编号应以相应的设备分类代码开头！");
                    return mav;
                }
                else{
                    unifiedId = unifiedId.replace(classifyCode, "");
                    Long serialNumber = Long.parseLong(unifiedId);

                    List<AssetsDeviceAccountDTO> assetsDeviceAccountDTOList = assetsDeviceAccountService.getAssetsDeviceAccountBySerialNumber(serialNumber);
                    if((assetsDeviceAccountDTOList != null) && (assetsDeviceAccountDTOList.size()>0)){
                        mav.addObject("flag", OpResult.failure);
                        mav.addObject("msg", "当前流水号已存在！");
                        return mav;
                    }
                }
            }

            if (StringUtils.isEmpty(assetsUstdtempAcceptanceDTO.getId())) {//新增
                assetsUstdtempAcceptanceService.insertAssetsUstdtempAcceptance(assetsUstdtempAcceptanceDTO);
            }
            else {//修改
                assetsUstdtempAcceptanceService.updateAssetsUstdtempAcceptanceSensitive(assetsUstdtempAcceptanceDTO);
            }

            //子表业务操作
            acceptanceDeviceComponentServiceSub.insertOrUpdateAcceptanceDeviceComponent(acceptanceDeviceComponentList, assetsUstdtempAcceptanceDTO.getId());

            //更新合同的是否已派生字段
            if(moduleDto != null){
                moduleDto.setIsDerive("Y");
                assetsApplyModuleService.updateAssetsApplyModule(moduleDto);
            }

            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", assetsUstdtempAcceptanceDTO.getId());
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
    public ModelAndView toDeleteAssetsUstdtempAcceptanceDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsUstdtempAcceptanceService.deleteAssetsUstdtempAcceptanceByIds(ids);
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
        //主表数据
        String data = ServletRequestUtils.getStringParameter(request, "data", "");

        //子表数据
        String dataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptance = JsonHelper.getInstance().readValue(data, dateFormat,
                    new TypeReference<AssetsUstdtempAcceptanceDTO>() {});
            List<AcceptanceDeviceComponentDTO> acceptanceDeviceComponentList = JsonHelper.getInstance()
                    .readValue(dataSub, dateFormat, new TypeReference<List<AcceptanceDeviceComponentDTO>>() {});

            String userId = SessionHelper.getLoginSysUserId(request);
            String deptId = SessionHelper.getCurrentDeptId(request);

            /////////////////启动流程所需要的参数///////////////////
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("processDefId", processDefId);
            parameter.put("formCode", formCode);
            parameter.put("jsonString", jsonString);
            parameter.put("userId", userId);
            parameter.put("deptId", deptId);

            AssetsApplyModuleDTO moduleDto = null;
            //申购单号不为空
            if((assetsUstdtempAcceptance.getSubscribeNo() != null) && (!"".equals(assetsUstdtempAcceptance.getSubscribeNo()))){
                //获取对应的申购单数据
                AssetsUstdtempapplyProcDTO applyDto = assetsUstdtempapplyProcService.getAssetsUstdtempapplyProcBySubscribeNo(assetsUstdtempAcceptance.getSubscribeNo());

                //获取合同数据
                moduleDto = assetsApplyModuleService.getAssetsApplyModulesByApplyId(applyDto.getId());
                if(moduleDto == null){
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("msg", "该验收缺少相应的合同数据，暂时不能提交！");
                    return mav;
                }
                else{
                    assetsUstdtempAcceptance.setDeviceName(moduleDto.getContractDeviceName());   //设备名称
                    assetsUstdtempAcceptance.setSetsCount(1L);   //台套数：1
                    assetsUstdtempAcceptance.setUnitPrice(moduleDto.getApplyPrice());    //单价
                    assetsUstdtempAcceptance.setManufacturerId(moduleDto.getApplyManufacturer());    //生产厂家

                    assetsUstdtempAcceptance.setContractNum(moduleDto.getContractNum()); //合同编号
                }
            }

            StartResultBean result = assetsUstdtempAcceptanceService.insertAssetsUstdtempAcceptanceAndStartProcess(
                    assetsUstdtempAcceptance, acceptanceDeviceComponentList, parameter);

            //更新合同的是否已派生字段
            if(moduleDto != null){
                moduleDto.setIsDerive("Y");
                assetsApplyModuleService.updateAssetsApplyModule(moduleDto);
            }

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
        AssetsUstdtempAcceptanceDTO dto = assetsUstdtempAcceptanceService.queryAssetsUstdtempAcceptanceByPrimaryKey(id);

        dto.setApplyByAlias(sysUserLoader.getSysUserNameById(dto.getApplyBy()));
        dto.setApplyByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getApplyByDept(), SessionHelper.getCurrentLanguageCode()));
        dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));
        dto.setCompetentChiefEngineerAlias(sysUserLoader.getSysUserNameById(dto.getCompetentChiefEngineer()));

        dto.setOwnerDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getOwnerDept(), SessionHelper.getCurrentLanguageCode()));
        dto.setOwnerIdAlias(sysUserLoader.getSysUserNameById(dto.getOwnerId()));
        dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));
        dto.setMeasureByAlias(sysUserLoader.getSysUserNameById(dto.getMeasureBy()));

        //申购单号不为空
        if((dto.getSubscribeNo() != null) && (!"".equals(dto.getSubscribeNo()))){
            //获取对应的申购单数据
            AssetsUstdtempapplyProcDTO applyDto = assetsUstdtempapplyProcService.getAssetsUstdtempapplyProcBySubscribeNo(dto.getSubscribeNo());

            //获取合同数据
            AssetsApplyModuleDTO moduleDto = assetsApplyModuleService.getAssetsApplyModulesByApplyId(applyDto.getId());
            if(moduleDto == null){
                mav.addObject("flag", OpResult.failure);
                mav.addObject("msg", "该验收缺少相应的合同数据，暂时不能提交！");
                return mav;
            }
            else{
                dto.setDeviceName(moduleDto.getContractDeviceName());   //设备名称
                dto.setSetsCount(1L);   //台套数：1
                dto.setUnitPrice(moduleDto.getApplyPrice());    //单价
                dto.setManufacturerId(moduleDto.getApplyManufacturer());    //生产厂家

                dto.setContractNum(moduleDto.getContractNum()); //合同编号
            }
        }

        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsUstdtempAcceptanceDTO", dto);

        return mav;
    }

    /****************************子表操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/sub/getAcceptanceDeviceComponent", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAcceptanceDeviceComponentByPid(PageParameter pageParameter,
                                                                   HttpServletRequest request) {
        QueryReqBean<AcceptanceDeviceComponentDTO> queryReqBean = new QueryReqBean<AcceptanceDeviceComponentDTO>();
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
            cloumnName = ComUtil.getColumn(AcceptanceDeviceComponentDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AcceptanceDeviceComponentDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AcceptanceDeviceComponentDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AcceptanceDeviceComponentDTO param = null;
        QueryRespBean<AcceptanceDeviceComponentDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AcceptanceDeviceComponentDTO>() {
            });
            param.setAcceptanceId(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AcceptanceDeviceComponentDTO();
            param.setAcceptanceId(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = acceptanceDeviceComponentServiceSub.searchAcceptanceDeviceComponentByPageOr(queryReqBean, orderBy);
            } else {
                result = acceptanceDeviceComponentServiceSub.searchAcceptanceDeviceComponentByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AcceptanceDeviceComponentDTO dto : result.getResult()) {
            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));

            if(dto.getComponentCategory() != null){
                ClassifyDataDTO classifyDataDTO = classifyDataService.queryClassifyDataById(dto.getComponentCategory());
                if(classifyDataDTO != null){
                    dto.setComponentCategoryName(classifyDataDTO.getName());
                }
            }
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AcceptanceDeviceComponentDTO分页数据");
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
    public ModelAndView toOpertionSubPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AcceptanceDeviceComponentDTO dto = acceptanceDeviceComponentServiceSub.queryAcceptanceDeviceComponentByPrimaryKey(id);

            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setLastUpdatedByAlias(sysUserLoader.getSysUserNameById(dto.getLastUpdatedBy()));
            mav.addObject("acceptanceDeviceComponentDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/assetsustdtempacceptance/" + "AcceptanceDeviceComponent" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAcceptanceDeviceComponentDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AcceptanceDeviceComponentDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
                    new TypeReference<List<AcceptanceDeviceComponentDTO>>() {});

            acceptanceDeviceComponentServiceSub.insertOrUpdateAcceptanceDeviceComponent(list, pid);
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
    public ModelAndView toDeleteAcceptanceDeviceComponentDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            acceptanceDeviceComponentServiceSub.deleteAcceptanceDeviceComponentByIds(ids);
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
            Collection<SysLookupSimpleVo> componentCategoryList = sysLookupLoader.getLookUpListByTypeByAppId("DEVICE_CATEGORY", appId);

            HashMap<String, String> componentCategoryMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : componentCategoryList) {
                componentCategoryMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("componentCategoryData", JsonHelper.getInstance().writeValueAsString(componentCategoryMap));
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}