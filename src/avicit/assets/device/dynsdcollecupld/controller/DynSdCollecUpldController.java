package avicit.assets.device.dynsdcollecupld.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.domain.BeanProcess;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.dynsdcollecupld.dto.DynSdCollecUpldDTO;
import avicit.assets.device.dynsdcollecupld.service.DynSdCollecUpldService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 15:42
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/dynsdcollecupld/dynSdCollecUpldController")
public class DynSdCollecUpldController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(DynSdCollecUpldController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private DynSdCollecUpldService dynSdCollecUpldService;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toDynSdCollecUpldManage")
    public ModelAndView toDynSdCollecUpldManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/dynsdcollecupld/DynSdCollecUpldManage");
        request.setAttribute("url", "platform/assets/device/dynsdcollecupld/dynSdCollecUpldController/operation/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String   ,   Object>
     * @throws Exception
     */
    @RequestMapping(value = "/operation/getDynSdCollecUpldsByPage")
    @ResponseBody
    public Map<String, Object> togetDynSdCollecUpldByPage(PageParameter pageParameter, HttpServletRequest request) throws Exception {
        QueryReqBean<DynSdCollecUpldDTO> queryReqBean = new QueryReqBean<DynSdCollecUpldDTO>();
        queryReqBean.setPageParameter(pageParameter);
        HashMap<String, Object> map = new HashMap<String, Object>();
        String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
        String json = ServletRequestUtils.getStringParameter(request, "param", "");
        String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
        String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");

        if (!"".equals(keyWord)) {
            json = keyWord;
        }

        String oderby = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            String cloumnName = ComUtil.getColumn(DynSdCollecUpldDTO.class, sidx);
            if (cloumnName != null) {
                oderby = " " + cloumnName + " " + sord;
            }
        }

        DynSdCollecUpldDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<DynSdCollecUpldDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynSdCollecUpldDTO>() {
            });
        } else {
            param = new DynSdCollecUpldDTO();
        }
        param.setCurrUserId(SessionHelper.getLoginSysUserId(request));
        param.setBpmType("my");
        queryReqBean.setSearchParams(param);

        try {
            if (!"".equals(keyWord)) {//根据keyWord条件查询时走or
                result = dynSdCollecUpldService.searchDynSdCollecUpldByPageOr(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), oderby);
            } else {
                result = dynSdCollecUpldService.searchDynSdCollecUpldByPage(queryReqBean, SessionHelper.getCurrentOrgIdentity(request), oderby);
            }
        } catch (Exception ex) {
            return map;
        }

        for (DynSdCollecUpldDTO dto : result.getResult()) {


            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode(request)));


        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取DynSdCollecUpldDTO分页数据");
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
//  		LogBase logBase = LogBaseFactory.getLogBase( request);
            DynSdCollecUpldDTO dto = dynSdCollecUpldService.queryDynSdCollecUpldByPrimaryKey(id);


            dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


            dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode(request)));


            mav.addObject("dynSdCollecUpldDTO", dto);
            mav.addObject("id", id);
        }
        mav.setViewName("avicit/assets/device/dynsdcollecupld/" + "DynSdCollecUpld" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param id      主键id
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveDynSdCollecUpldDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        String returnId = "";
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            DynSdCollecUpldDTO dynSdCollecUpldDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<DynSdCollecUpldDTO>() {
            });
            if ("".equals(dynSdCollecUpldDTO.getId())) {//新增
                returnId = dynSdCollecUpldService.insertDynSdCollecUpld(dynSdCollecUpldDTO);
            } else {//修改
                returnId = dynSdCollecUpldDTO.getId();
                dynSdCollecUpldService.updateDynSdCollecUpldSensitive(dynSdCollecUpldDTO);
            }
            mav.addObject("flag", OpResult.success);
            mav.addObject("id", returnId);
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
    public ModelAndView toDeleteDynSdCollecUpldDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
//  		LogBase logBase = LogBaseFactory.getLogBase( request);
            dynSdCollecUpldService.deleteDynSdCollecUpldByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("error", ex.getMessage());
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
            DynSdCollecUpldDTO dynSdCollecUpld = JsonHelper.getInstance().readValue(data, dateFormat, new TypeReference<DynSdCollecUpldDTO>() {
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
            dynSdCollecUpld.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
            StartResultBean result = dynSdCollecUpldService.insertDynSdCollecUpldAndStartProcess(dynSdCollecUpld, parameter);

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
        DynSdCollecUpldDTO dto = dynSdCollecUpldService.queryDynSdCollecUpldByPrimaryKey(id);


        dto.setAuthorAlias(sysUserLoader.getSysUserNameById(dto.getAuthor()));


        dto.setDeptAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getDept(), SessionHelper.getCurrentLanguageCode(request)));


        mav.addObject("flag", OpResult.success);
        mav.addObject("dynSdCollecUpldDTO", dto);
        return mav;
    }
}
