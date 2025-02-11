package avicit.assets.device.assetsshiftproc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import avicit.assets.device.assetsshiftproc.dto.AssetsShiftProcDTO;
import avicit.assets.device.assetsshiftproc.service.AssetsShiftProcService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-15 16:10
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsshiftproc/assetsShiftProcController")
public class AssetsShiftProcController implements LoaderConstant {
    private static final Logger logger = LoggerFactory.getLogger(AssetsShiftProcController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsShiftProcService assetsShiftProcService;

    @Autowired
    private SysUserAPI sysUserAPI;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsShiftProcManage")
    public ModelAndView toAssetsShiftProcManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsshiftproc/AssetsShiftProcManage");
        mav.addObject("url", "platform/assets/device/assetsshiftproc/assetsShiftProcController/operation/");
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
    @RequestMapping(value = "/operation/getAssetsShiftProcsByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsShiftProcByPage(PageParameter pageParameter, HttpServletRequest request)
            throws Exception {
        QueryReqBean<AssetsShiftProcDTO> queryReqBean = new QueryReqBean<AssetsShiftProcDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsShiftProcDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsShiftProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsShiftProcDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }

        AssetsShiftProcDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsShiftProcDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsShiftProcDTO>() {
            });
        } else {
            param = new AssetsShiftProcDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);

        try {
            if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
                result = assetsShiftProcService.searchAssetsShiftProcByPageOr(queryReqBean, orderBy);
            } else {
                result = assetsShiftProcService.searchAssetsShiftProcByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsShiftProcDTO dto : result.getResult()) {

            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));

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

            dto.setHasNoise(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getHasNoise(), sysApplicationAPI.getCurrentAppId()));

            dto.setNoiseInfluence(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getNoiseInfluence(), sysApplicationAPI.getCurrentAppId()));

        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        logger.info("成功获取AssetsShiftProcDTO分页数据");
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
            AssetsShiftProcDTO dto = assetsShiftProcService.queryAssetsShiftProcByPrimaryKey(id);

            dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));
            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                    SessionHelper.getCurrentLanguageCode()));

            mav.addObject("assetsShiftProcDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/assetsshiftproc/" + "AssetsShiftProc" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsShiftProcDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        String returnId = "";
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsShiftProcDTO assetsShiftProcDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<AssetsShiftProcDTO>() {
                    });
            if (StringUtils.isEmpty(assetsShiftProcDTO.getId())) {//新增
                returnId = assetsShiftProcService.insertAssetsShiftProc(assetsShiftProcDTO);
            } else {//修改
                returnId = assetsShiftProcDTO.getId();
                assetsShiftProcService.updateAssetsShiftProcSensitive(assetsShiftProcDTO);
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
    public ModelAndView toDeleteAssetsShiftProcDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsShiftProcService.deleteAssetsShiftProcByIds(ids);
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
            AssetsShiftProcDTO assetsShiftProc = JsonHelper.getInstance().readValue(data, dateFormat,
                    new TypeReference<AssetsShiftProcDTO>() {
                    });
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

            assetsShiftProc.setCreatedByDept(deptId);
            assetsShiftProc.setCreatedByTel(user.getMobile());

            StartResultBean result = assetsShiftProcService.insertAssetsShiftProcAndStartProcess(assetsShiftProc, parameter);

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
        AssetsShiftProcDTO dto = assetsShiftProcService.queryAssetsShiftProcByPrimaryKey(id);

        dto.setCreatedByAlias(sysUserLoader.getSysUserNameById(dto.getCreatedBy()));

        dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(),
                SessionHelper.getCurrentLanguageCode()));

        mav.addObject("flag", OpResult.success);
        mav.addObject("assetsShiftProcDTO", dto);
        return mav;
    }
}