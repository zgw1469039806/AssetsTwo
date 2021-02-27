package avicit.cadreselect.dynvote.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.cadreselect.dynvote.bo.SendVoteBO;
import avicit.cadreselect.dynvote.dto.QueryVoteByIdDTO;
import avicit.cadreselect.util.ResponseData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang.StringUtils;
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

import avicit.cadreselect.dynvote.dto.DynVoteDTO;
import avicit.cadreselect.dynvote.service.DynVoteService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:58
 * @类说明：投票业务
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("avicit/cadreselect/dynVote/dynVoteController")
public class DynVoteController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(DynVoteController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private DynVoteService dynVoteService;

    //region 后台接口

    /**
     * 跳转到列表页面
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "toDynVoteManage")
    public ModelAndView toDynVoteManage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/cadreselect/dynvote/DynVoteManage");
        mav.addObject("url", "platform/avicit/cadreselect/dynVote/dynVoteController/operation/");
        return mav;
    }

    /**
     * 列表页面分页查询
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getDynVotesByPage")
    @ResponseBody
    public Map<String, Object> togetDynVoteByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<DynVoteDTO> queryReqBean = new QueryReqBean<DynVoteDTO>();
        queryReqBean.setPageParameter(pageParameter);
        //表单数据
        String json = ServletRequestUtils.getStringParameter(request, "param", "");
        //字段查询条件
        String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
        //排序方式
        String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
        //排序字段
        String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
        if (StringUtils.isNotEmpty(keyWord)) {
            json = keyWord;
        }
        String orderBy = "";
        String cloumnName = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            cloumnName = ComUtil.getColumn(DynVoteDTO.class, sidx);
            //这里先进行判断是否有对应的数据库字段
            if (cloumnName != null) {
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(DynVoteDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(DynVoteDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        HashMap<String, Object> map = new HashMap<String, Object>();
        DynVoteDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<DynVoteDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynVoteDTO>() {
            });
        } else {
            param = new DynVoteDTO();
        }
        queryReqBean.setSearchParams(param);
        param.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
        try {
            result = dynVoteService.searchDynVoteByPage(queryReqBean, orderBy, keyWord);
        } catch (Exception ex) {
            return map;
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取DynVoteDTO分页数据");
        return map;
    }

    /**
     * 根据传入的的类型跳转到对应页面
     *
     * @param type，包括三个值，分别是Add:新建；Edit：编辑；Detail：详情
     * @param id                                     数据的id
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/{type}/{id}")
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id)
            throws Exception {
        ModelAndView mav = new ModelAndView();
        //编辑窗口或者详细页窗口
        if (!"Add".equals(type)) {
            DynVoteDTO dto = dynVoteService.queryDynVoteByPrimaryKey(id);
            mav.addObject("dynVoteDTO", dto);
        }
        mav.setViewName("avicit/cadreselect/dynvote/DynVote" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveDynVote(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            DynVoteDTO dynVoteDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<DynVoteDTO>() {
                    });
            if (StringUtils.isEmpty(dynVoteDTO.getId())) {
                //新增
                dynVoteDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
                String id = dynVoteService.insertDynVote(dynVoteDTO);
                mav.addObject("id", id);
            } else {
                //修改
                dynVoteService.updateDynVoteSensitive(dynVoteDTO);
                mav.addObject("id", dynVoteDTO.getId());
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
     * @param ids id数组
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteDynVote(@RequestBody String[] ids) {
        ModelAndView mav = new ModelAndView();
        try {
            dynVoteService.deleteDynVoteByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
    //endregion

	//region 前端接口

    /**
     * 根据扫码id查询投票信息
     * @param id : 标识
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryVoteById")
    public ResponseData<QueryVoteByIdDTO> toSaveDynPerson(@RequestBody String id) {
        QueryVoteByIdDTO dto = dynVoteService.queryVoteById(id);
        return new ResponseData<>(dto);
    }

    /**
     * 投票
     * @param bo : 投票list
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "sendVote")
    public ResponseData<Void> sendVote(@RequestBody SendVoteBO bo) {
        dynVoteService.sendVote(bo);
        return new ResponseData<>();
    }


    //endregion
}

