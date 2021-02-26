package avicit.assets.device.assetsallotproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Collection;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
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

import avicit.assets.device.assetsallotproc.service.AssetsAllotProcService;
import avicit.assets.device.assetsallotproc.service.AllotAssetsService;
import avicit.assets.device.assetsallotproc.dto.AllotAssetsDTO;
import avicit.assets.device.assetsallotproc.dto.AssetsAllotProcDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-17 09:02
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsallotproc/assetsAllotProcController")
public class AssetsAllotProcController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsAllotProcController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsAllotProcService assetsAllotProcService;

    @Autowired
    private AllotAssetsService allotAssetsServiceSub;

    @Autowired
    private SysUserDeptPositionAPI sysUserDeptPositionAPI;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsAllotProcManage")
    public ModelAndView toAssetsAllotProcManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsallotproc/AssetsAllotProcManage");
        mav.addObject("url", "platform/assets/device/assetsallotproc/assetsAllotProcController/operation/");
        mav.addObject("surl", "platform/assets/device/assetsallotproc/assetsAllotProcController/operation/sub/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsAllotProcsByPage")
    @ResponseBody
    public Map<String, Object> toGetAssetsAllotProcByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsAllotProcDTO> queryReqBean = new QueryReqBean<AssetsAllotProcDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsAllotProcDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsAllotProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsAllotProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsAllotProcDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsAllotProcDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsAllotProcDTO>() {
            });
        } else {
            param = new AssetsAllotProcDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);
        try {
            if (!"".equals(keyWord)) {
                result = assetsAllotProcService.searchAssetsAllotProcByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsAllotProcService.searchAssetsAllotProcByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }
        for (AssetsAllotProcDTO dto : result.getResult()) {
            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));
            dto.setCallinDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCallinDept(),
                    SessionHelper.getCurrentLanguageCode()));
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsAllotProcDTO分页数据");
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
            AssetsAllotProcDTO dto = assetsAllotProcService.queryAssetsAllotProcByPrimaryKey(id);
            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));
            dto.setCallinDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCallinDept(),
                    SessionHelper.getCurrentLanguageCode()));

            String appId = sysApplicationAPI.getCurrentAppId();
            Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL",
                    appId);
            HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : secretLevelList) {
                secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
            Collection<SysLookupSimpleVo> isSafetyProductionList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSafetyProductionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSafetyProductionList) {
                isSafetyProductionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSafetyProductionData", JsonHelper.getInstance().writeValueAsString(isSafetyProductionMap));
            mav.addObject("assetsAllotProcDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsallotproc/" + "AssetsAllotProc" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsAllotProcDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
            String jsonDataSub = ServletRequestUtils.getStringParameter(request, "dataSub", "");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            AssetsAllotProcDTO assetsAllotProcDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<AssetsAllotProcDTO>() {});

            List<AllotAssetsDTO> allotAssetsList = JsonHelper.getInstance().readValue(jsonDataSub, dateFormat,
                    new TypeReference<List<AllotAssetsDTO>>() {});

            if (StringUtils.isEmpty(assetsAllotProcDTO.getId())) {//新增
                assetsAllotProcService.insertAssetsAllotProc(assetsAllotProcDTO);
            }
            else {//修改
                assetsAllotProcService.updateAssetsAllotProcSensitive(assetsAllotProcDTO);
            }

            //子表业务操作
            allotAssetsServiceSub.insertOrUpdateAllotAssets(allotAssetsList, assetsAllotProcDTO.getId());
            mav.addObject("flag", OpResult.success);
            mav.addObject("pid", assetsAllotProcDTO.getId());
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
    public ModelAndView toDeleteAssetsAllotProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsAllotProcService.deleteAssetsAllotProcByIds(ids);
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
            AssetsAllotProcDTO assetsAllotProc = JsonHelper.getInstance().readValue(data, dateFormat,
                    new TypeReference<AssetsAllotProcDTO>() {});

            List<AllotAssetsDTO> allotAssetsList = JsonHelper.getInstance().readValue(dataSub, dateFormat,
                    new TypeReference<List<AllotAssetsDTO>>() {});

            String userId = SessionHelper.getLoginSysUserId(request);
            String deptId = SessionHelper.getCurrentDeptId(request);

            /////////////////启动流程所需要的参数///////////////////
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("processDefId", processDefId);
            parameter.put("formCode", formCode);
            parameter.put("jsonString", jsonString);
            parameter.put("userId", userId);
            parameter.put("deptId", deptId);

            /*获取调拨员数据——开始  402880e8736b3b3401736b3ef6200245 */
            List<SysUser> alloterList = sysUserDeptPositionAPI.getSysUserListBySysDeptIdAndSysPositionCode(assetsAllotProc.getCallinDept(), "300");
            if((alloterList != null) && (alloterList.size()>0)){
//                String alloterIdStr = "";
//                for(SysUser alloter : alloterList){
//                    if("".equals(alloterIdStr)){
//                        alloterIdStr = alloter.getId();
//                    }
//                    else{
//                        alloterIdStr += "," + alloter.getId();
//                    }
//                }
//                assetsAllotProc.setAttribute09(alloterIdStr);
                assetsAllotProc.setAttribute09(alloterList.get(0).getId());

                StartResultBean result = assetsAllotProcService.insertAssetsAllotProcAndStartProcess(assetsAllotProc, allotAssetsList, parameter);

                mav.addObject("flag", OpResult.success);
                mav.addObject("startResult", result);
            }
            else{
                mav.addObject("flag", OpResult.failure);
                mav.addObject("msg", "调入部门缺少设备调拨员");
            }
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
        AssetsAllotProcDTO dto = assetsAllotProcService.queryAssetsAllotProcByPrimaryKey(id);

        dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

        dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                SessionHelper.getCurrentLanguageCode()));

        dto.setCallinDeptAlias(
                sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCallinDept(), SessionHelper.getCurrentLanguageCode()));

        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsAllotProcDTO", dto);

        return mav;
    }

    /****************************子表操作*****************************
     /**
     * 按照pid查找子表数据
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/sub/getAllotAssets", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toGetAllotAssetsByPid(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AllotAssetsDTO> queryReqBean = new QueryReqBean<AllotAssetsDTO>();
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
            cloumnName = ComUtil.getColumn(AllotAssetsDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AllotAssetsDTO.class, sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AllotAssetsDTO.class, sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AllotAssetsDTO param = null;
        QueryRespBean<AllotAssetsDTO> result = null;

        if (pid == null || "".equals(pid)) {
            pid = "-1";
        }
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, new TypeReference<AllotAssetsDTO>() {
            });
            param.setAllotProcId(pid);
            queryReqBean.setSearchParams(param);
        } else {
            param = new AllotAssetsDTO();
            param.setAllotProcId(pid);
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = allotAssetsServiceSub.searchAllotAssetsByPageOr(queryReqBean, orderBy);
            } else {
                result = allotAssetsServiceSub.searchAllotAssetsByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AllotAssetsDTO dto : result.getResult()) {

            dto.setSecretLevelName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                    dto.getSecretLevel(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsSafetyProductionName(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId(
                    "PLATFORM_YES_NO_FLAG", dto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId()));

        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AllotAssetsDTO分页数据");
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
    public ModelAndView toOpertionSubPage(@PathVariable String type, @PathVariable String id,
                                          HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AllotAssetsDTO dto = allotAssetsServiceSub.queryAllotAssetsByPrimaryKey(id);

            mav.addObject("allotAssetsDTO", dto);
        } else {
            mav.addObject("pid", id);
        }
        mav.setViewName("avicit/assets/device/assetsallotproc/" + "AllotAssets" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
    public AvicitResponseBody toSaveAllotAssetsDTO(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        String pid = ServletRequestUtils.getStringParameter(request, "pid", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AllotAssetsDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat,
                    new TypeReference<List<AllotAssetsDTO>>() {
                    });
            allotAssetsServiceSub.insertOrUpdateAllotAssets(list, pid);
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
    public ModelAndView toDeleteAllotAssetsDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            allotAssetsServiceSub.deleteAllotAssetsByIds(ids);
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
            Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL",
                    appId);
            HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : secretLevelList) {
                secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("secretLevelData", JsonHelper.getInstance().writeValueAsString(secretLevelMap));
            Collection<SysLookupSimpleVo> isSafetyProductionList = sysLookupLoader
                    .getLookUpListByTypeByAppId("PLATFORM_YES_NO_FLAG", appId);
            HashMap<String, String> isSafetyProductionMap = new LinkedHashMap<String, String>();
            for (SysLookupSimpleVo vo : isSafetyProductionList) {
                isSafetyProductionMap.put(vo.getLookupCode(), vo.getLookupName());
            }
            mav.addObject("isSafetyProductionData", JsonHelper.getInstance().writeValueAsString(isSafetyProductionMap));
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}