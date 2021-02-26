package avicit.assets.assetsapplymodule.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.web.AvicitResponseBody;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.commons.utils.ComUtil;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.assets.assetsapplymodule.service.AssetsApplyModuleService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 14:22
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/assetsapplymodule/assetsApplyModuleController")
public class AssetsApplyModuleController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsApplyModuleController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsApplyModuleService assetsApplyModuleService;


    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsApplyModuleManage")
    public ModelAndView toAssetsApplyModuleManage(HttpServletRequest request, HttpServletResponse reponse) {
        String appId = sysApplicationAPI.getCurrentAppId();
        ModelAndView mav = new ModelAndView();

        mav.setViewName("avicit/assets/assetsapplymodule/AssetsApplyModuleManage");
        request.setAttribute("url", "platform/assets/assetsapplymodule/assetsApplyModuleController/operation/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsApplyModulesByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsApplyModuleByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsApplyModuleDTO> queryReqBean = new QueryReqBean<AssetsApplyModuleDTO>();
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
            String cloumnName = ComUtil.getColumn(AssetsApplyModuleDTO.class, sidx);
            if (cloumnName != null) {
                oderby = " " + cloumnName + " " + sord;
            }
        }
        AssetsApplyModuleDTO param = null;
        QueryRespBean<AssetsApplyModuleDTO> result = null;
        if (json != null && !"".equals(json)) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<AssetsApplyModuleDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsApplyModuleService.searchAssetsApplyModuleByPageOr(queryReqBean, oderby);
            } else {
                result = assetsApplyModuleService.searchAssetsApplyModuleByPage(queryReqBean, oderby);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsApplyModuleDTO dto : result.getResult()) {


        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsApplyModuleDTO分页数据");
        return map;
    }

    /**
     * 新增或修改对象
     *
     * @param request 请求
     * @return AvicitResponseBody
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    @ResponseBody
    public AvicitResponseBody saveOrUpdateAssetsApplyModule(HttpServletRequest request) {
        String datas = ServletRequestUtils.getStringParameter(request, "data", "");
        if ("".equals(datas)) {
            return new AvicitResponseBody(OpResult.success);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            List<AssetsApplyModuleDTO> list = JsonHelper.getInstance().readValue(datas, dateFormat, new TypeReference<List<AssetsApplyModuleDTO>>() {
            });
            assetsApplyModuleService.insertOrUpdateAssetsApplyModule(list);
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
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView deleteAssetsApplyModule(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsApplyModuleService.deleteAssetsApplyModuleByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}
