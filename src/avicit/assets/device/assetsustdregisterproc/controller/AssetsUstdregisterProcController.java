package avicit.assets.device.assetsustdregisterproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;
import avicit.platform6.api.sysuser.SysUserAPI;
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
import avicit.assets.device.assetsustdregisterproc.dto.AssetsUstdregisterProcDTO;
import avicit.assets.device.assetsustdregisterproc.service.AssetsUstdregisterProcService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-11 12:56
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsustdregisterproc/assetsUstdregisterProcController")
public class AssetsUstdregisterProcController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsUstdregisterProcController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsUstdregisterProcService assetsUstdregisterProcService;

    @Autowired
    private SysUserAPI sysUserAPI;

    @Autowired
    private UserTableModelService userTableModelService;


    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsUstdregisterProcManage")
    public ModelAndView toAssetsUstdregisterProcManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsustdregisterproc/AssetsUstdregisterProcManage");
        mav.addObject("url",
                "platform/assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/");

        /*用户视图、默认表头获取代码——开始*/
        SysUser user = SessionHelper.getLoginSysUser(request);	//获取当前登录用户

        //获取用户视图列表
        List<String> viewList = new ArrayList<>();
        try {
            viewList = userTableModelService.getUserViewList(user.getId(),"AssetsUstdregisterProc");
            mav.addObject("viewList", viewList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //获取表头字段
        try {
            StringBuffer dataGridColModelJson = new StringBuffer();
            dataGridColModelJson.append("[");

            List<UserTableModelDTO> modelList = userTableModelService.searchUserTableModel(user.getId(),"AssetsUstdregisterProc", viewList.get(0), "Y");
            if((modelList == null) || (modelList.size() == 0)){
                modelList = userTableModelService.searchUserTableModel("系统默认",  "AssetsUstdregisterProc", "系统默认视图", "Y");
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
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     * @throws Exception
     */
    @RequestMapping(value = "/operation/getAssetsUstdregisterProcsByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsUstdregisterProcByPage(PageParameter pageParameter,
                                                                 HttpServletRequest request) throws Exception {
        QueryReqBean<AssetsUstdregisterProcDTO> queryReqBean = new QueryReqBean<AssetsUstdregisterProcDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsUstdregisterProcDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdregisterProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsUstdregisterProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }

        AssetsUstdregisterProcDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsUstdregisterProcDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat,
                    new TypeReference<AssetsUstdregisterProcDTO>() {
                    });
        } else {
            param = new AssetsUstdregisterProcDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);

        try {
            if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
                result = assetsUstdregisterProcService.searchAssetsUstdregisterProcByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsUstdregisterProcService.searchAssetsUstdregisterProcByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsUstdregisterProcDTO dto : result.getResult()) {
            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                    dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setTechInchargeAlias(sysUserLoader.getSysUserNameById(dto.getTechIncharge()));

            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

            dto.setSingleOrSet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SINGLE_OR_SET",
                    dto.getSingleOrSet(), sysApplicationAPI.getCurrentAppId()));

            dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES",
                    dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));

            dto.setSimpleOrLarge(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SIMPLE_LARGE_SCALE",
                    dto.getSimpleOrLarge(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSatisfyBearing(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsSatisfyBearing(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasOutdoorUnit(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasOutdoorUnit(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAllowOutdoorunit(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsAllowOutdoorunit(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasFoundation(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasFoundation(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasVoltageCondition(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasVoltageCondition(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasHumidityNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasHumidityNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasCleanlinessNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasCleanlinessNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasWaterNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasWaterNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasGasNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasGasNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasLetNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasLetNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasOtherNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasOtherNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setHasAboveConditions(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasAboveConditions(), sysApplicationAPI.getCurrentAppId()));

        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsUstdregisterProcDTO分页数据");
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
            AssetsUstdregisterProcDTO dto = assetsUstdregisterProcService.queryAssetsUstdregisterProcByPrimaryKey(id);

            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));

            dto.setTechInchargeAlias(sysUserLoader.getSysUserNameById(dto.getTechIncharge()));
            dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

            mav.addObject("assetsUstdregisterProcDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsustdregisterproc/" + "AssetsUstdregisterProc" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsUstdregisterProcDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        String returnId = "";
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsUstdregisterProcDTO assetsUstdregisterProcDTO = JsonHelper.getInstance().readValue(jsonData,
                    dateFormat, new TypeReference<AssetsUstdregisterProcDTO>() {});

            if (StringUtils.isEmpty(assetsUstdregisterProcDTO.getId())) {//新增
                returnId = assetsUstdregisterProcService.insertAssetsUstdregisterProc(assetsUstdregisterProcDTO);
            }
            else {//修改
                returnId = assetsUstdregisterProcDTO.getId();
                assetsUstdregisterProcService.updateAssetsUstdregisterProcSensitive(assetsUstdregisterProcDTO);
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
     *
     * @param ids     id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteAssetsUstdregisterProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsUstdregisterProcService.deleteAssetsUstdregisterProcByIds(ids);
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
            AssetsUstdregisterProcDTO assetsUstdregisterProc = JsonHelper.getInstance().readValue(data, dateFormat,
                    new TypeReference<AssetsUstdregisterProcDTO>() {});

            String userId = SessionHelper.getLoginSysUserId(request);
            String deptId = SessionHelper.getCurrentDeptId(request);
            SysUser user = sysUserAPI.getSysUserById(userId);

            /////////////////启动流程所需要的参数///////////////////
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("processDefId", processDefId);
            parameter.put("formCode", formCode);
            parameter.put("jsonString", jsonString);
            parameter.put("userId", userId);
            parameter.put("deptId", deptId);

            assetsUstdregisterProc.setCreatedByDept(deptId);
            assetsUstdregisterProc.setCreatedByTel(user.getMobile());

            StartResultBean result = assetsUstdregisterProcService.insertAssetsUstdregisterProcAndStartProcess(assetsUstdregisterProc, parameter);

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
        AssetsUstdregisterProcDTO dto = assetsUstdregisterProcService.queryAssetsUstdregisterProcByPrimaryKey(id);

        dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

        dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                SessionHelper.getCurrentLanguageCode()));

        dto.setTechInchargeAlias(sysUserLoader.getSysUserNameById(dto.getTechIncharge()));

        dto.setProjectDirectorAlias(sysUserLoader.getSysUserNameById(dto.getProjectDirector()));

        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsUstdregisterProcDTO", dto);
        return mav;
    }
}