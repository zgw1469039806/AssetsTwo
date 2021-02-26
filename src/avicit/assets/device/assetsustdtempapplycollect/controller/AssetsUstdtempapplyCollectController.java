package avicit.assets.device.assetsustdtempapplycollect.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCollectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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


import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-27 08:52
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController")
public class AssetsUstdtempapplyCollectController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsUstdtempapplyCollectController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsUstdtempapplyCollectService assetsUstdtempapplyCollectService;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsUstdtempapplyCollectManage")
    public ModelAndView toAssetsUstdtempapplyCollectManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetsustdtempapplycollect/AssetsUstdtempapplyCollectManage");
        request.setAttribute("url", "platform/assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/operation/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String   ,   Object>
     */
    @RequestMapping(value = "/operation/getAssetsUstdtempapplyCollectsByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsUstdtempapplyCollectByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsUstdtempapplyCollectDTO> queryReqBean = new QueryReqBean<AssetsUstdtempapplyCollectDTO>();
        queryReqBean.setPageParameter(pageParameter);
        HashMap<String, Object> map = new HashMap<String, Object>();
        String json = ServletRequestUtils.getStringParameter(request, "param", "");
        String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");//字段查询条件
        String sord = ServletRequestUtils.getStringParameter(request, "sord", "");//排序方式
        String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");//排序字段
        if (!"".equals(keyWord)) {
            json = keyWord;
        }
        String oderby = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            String cloumnName = ComUtil.getColumn(AssetsUstdtempapplyCollectDTO.class, sidx);
            if (cloumnName != null) {
                oderby = " " + cloumnName + " " + sord;
            }
        }

        AssetsUstdtempapplyCollectDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsUstdtempapplyCollectDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsUstdtempapplyCollectDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsUstdtempapplyCollectService.searchAssetsUstdtempapplyCollectByPageOr(queryReqBean, oderby);
            } else {
                result = assetsUstdtempapplyCollectService.searchAssetsUstdtempapplyCollectByPage(queryReqBean, oderby);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsUstdtempapplyCollectDTO dto : result.getResult()) {

            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode(request)));

            dto.setDeviceCategory(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY", dto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId()));

            dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode(request)));

            dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));

            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));

            dto.setIsNeedInstall(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsHumidityNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsHumidityNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsWaterNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsWaterNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsGasNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsGasNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsLet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsLet(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsOtherNeed(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsOtherNeed(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsAboveConditions(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsAboveConditions(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsMetering(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsMetering(), sysApplicationAPI.getCurrentAppId()));

            dto.setFinancialResources(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("FINANCIAL_RESOURCES", dto.getFinancialResources(), sysApplicationAPI.getCurrentAppId()));

            dto.setIsTestDevice(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", dto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId()));

            dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));

        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsUstdtempapplyCollectDTO分页数据");
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
//  		LogBase logBase = LogBaseFactory.getLogBase(request);
            AssetsUstdtempapplyCollectDTO dto = assetsUstdtempapplyCollectService.queryAssetsUstdtempapplyCollectByPrimaryKey(id);



            dto.setCreatedByDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCreatedByDept(), SessionHelper.getCurrentLanguageCode(request)));

            dto.setCompetentAuthorityAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getCompetentAuthority(), SessionHelper.getCurrentLanguageCode(request)));

            dto.setModelDirectorAlias(sysUserLoader.getSysUserNameById(dto.getModelDirector()));

            dto.setCompetentLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentLeader()));


            dto.setCompetentDeviceLeaderAlias(sysUserLoader.getSysUserNameById(dto.getCompetentDeviceLeader()));
            dto.setCreatedByPersionAlias(sysUserLoader.getSysUserNameById(dto.getAttribute05()));

            mav.addObject("assetsUstdtempapplyCollectDTO", dto);
        }
        mav.setViewName("avicit/assets/device/assetsustdtempapplycollect/" + "AssetsUstdtempapplyCollect" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsUstdtempapplyCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<AssetsUstdtempapplyCollectDTO>() {
            });
            if ("".equals(assetsUstdtempapplyCollectDTO.getId())) {//新增
                assetsUstdtempapplyCollectService.insertAssetsUstdtempapplyCollect(assetsUstdtempapplyCollectDTO);
            } else {//修改
                assetsUstdtempapplyCollectService.updateAssetsUstdtempapplyCollectSensitive(assetsUstdtempapplyCollectDTO);
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
    public ModelAndView toDeleteAssetsUstdtempapplyCollectDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
//  		LogBase logBase = LogBaseFactory.getLogBase( request);
            assetsUstdtempapplyCollectService.deleteAssetsUstdtempapplyCollectByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}
