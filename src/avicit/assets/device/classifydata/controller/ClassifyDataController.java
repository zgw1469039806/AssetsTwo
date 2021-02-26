package avicit.assets.device.classifydata.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.classifydata.dto.ClassifyTreeDTO;
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

import avicit.assets.device.classifydata.dto.ClassifyDataDTO;
import avicit.assets.device.classifydata.service.ClassifyDataService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.alibaba.fastjson.JSON;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-21 17:02
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/classifydata/classifyDataController")
public class ClassifyDataController implements LoaderConstant {

    @Autowired
    private ClassifyDataService classifyDataService;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toClassifyDataManage")
    public ModelAndView toClassifyDataManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        String url = "platform/assets/device/classifydata/classifyDataController";

        //获取国标分类树
        try {
            List<ClassifyTreeDTO> classifyTreeList = classifyDataService.getClassifyTree("NationalStandard");

            if((classifyTreeList != null) && (classifyTreeList.size() > 0)){
                mav.addObject("classifyJson", JSON.toJSONString(classifyTreeList));
            }
            else{
                mav.addObject("classifyJson", "[]");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        mav.setViewName("avicit/assets/device/classifydata/ClassifyDataManage");
        mav.addObject("url", url);
        return mav;
    }

    /**
     * 获取分类树
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/getClassifyTree", method = RequestMethod.POST)
    public ModelAndView getClassifyTree(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String belongCategory = ServletRequestUtils.getStringParameter(request, "belongCategory", "");

        //获取分类树
        try {
            List<ClassifyTreeDTO> classifyTreeList = classifyDataService.getClassifyTree(belongCategory);

            if((classifyTreeList != null) && (classifyTreeList.size() > 0)){
                mav.addObject("classifyJson", JSON.toJSONString(classifyTreeList));
            }
            else{
                mav.addObject("classifyJson", "[]");
            }
            mav.addObject("flag", OpResult.success);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    /**
     * 保存数据
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveClassifyDataDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            String result = "";
            ClassifyDataDTO classifyDataDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<ClassifyDataDTO>() {});

            if (StringUtils.isEmpty(classifyDataDTO.getId())) {//新增
                result = classifyDataService.insertClassifyData(classifyDataDTO);
                mav.addObject("id", result);
            }
            else {//修改
                result = classifyDataService.updateClassifyDataSensitive(classifyDataDTO);
            }

            if(result.startsWith("Fail:")){
                mav.addObject("flag", OpResult.failure);
                mav.addObject("msg", result.replace("Fail:", ""));
            }
            else{
                mav.addObject("flag", OpResult.success);
            }
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            mav.addObject("msg", "后台处理错误，请联系管理员！");
        }
        return mav;

    }

    /**
     * 按照id批量删除数据
     * @param ids id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteNationalClassifyDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String currentCategory = ids[0];

            for(int i = (ids.length-1); i>0; i--){
                long childrenCount = classifyDataService.getValidChildrenCountByPid(ids[i], currentCategory);
                ClassifyDataDTO dto = classifyDataService.queryClassifyDataById(ids[i]);

                if(childrenCount == 0){
                    dto.setClassifyState("N");
                    classifyDataService.updateClassifyDataSensitive(dto);
                }
                else{
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("msg", "请先删除分类“" + dto.getName() + "”的子分类！");
                    return mav;
                }
            }

            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            mav.addObject("msg", "后台处理错误，请联系管理员！");
        }
        return mav;
    }

    /**
     * 上下移动节点
     * @param request  请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/upDownNode", method = RequestMethod.POST)
    public ModelAndView upDownNodeUserCollectDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            String sourceId = ServletRequestUtils.getStringParameter(request, "sourceId", "");
            ClassifyDataDTO sourceDto = classifyDataService.queryClassifyDataById(sourceId);

            String targetId = ServletRequestUtils.getStringParameter(request, "targetId", "");
            ClassifyDataDTO targetDto = classifyDataService.queryClassifyDataById(targetId);

            //交换节点的序号
            long temp = sourceDto.getSn();
            sourceDto.setSn(targetDto.getSn());
            targetDto.setSn(temp);

            classifyDataService.updateClassifyDataSensitive(sourceDto);
            classifyDataService.updateClassifyDataSensitive(targetDto);
            mav.addObject("flag", OpResult.success);
        }
        catch (Exception ex) {
            mav.addObject("msg", "后台处理错误，请联系管理员！");
            mav.addObject("flag", OpResult.failure);
        }
        return mav;
    }
}