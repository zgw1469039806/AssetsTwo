package avicit.assets.device.usertablemodel.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.core.properties.PlatformConstant.OpResult;

import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.assets.device.usertablemodel.service.UserTableModelService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-30 16:21
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/usertablemodel/userTableModelController")
public class UserTableModelController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserTableModelController.class);

    @Autowired
    private UserTableModelService userTableModelService;

    /**
     * 跳转到管理页面
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toUserTableModelManage")
    public ModelAndView toUserTableModelManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/usertablemodel/UserTableModelManage");
        mav.addObject("url", "platform/assets/device/usertablemodel/userTableModelController/operation/");
        return mav;
    }

    /**
     * 分页查询方法
     * @param pageParameter 查询条件
     * @param request 请求
     * @return Map<String,Object>
     */
    @RequestMapping(value = "/operation/getUserTableModelsByPage")
    @ResponseBody
    public Map<String, Object> togetUserTableModelByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<UserTableModelDTO> queryReqBean = new QueryReqBean<UserTableModelDTO>();
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
            cloumnName = ComUtil.getColumn(UserTableModelDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(UserTableModelDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(UserTableModelDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        UserTableModelDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<UserTableModelDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<UserTableModelDTO>() {
            });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = userTableModelService.searchUserTableModelByPageOr(queryReqBean, orderBy);
            } else {
                result = userTableModelService.searchUserTableModelByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (UserTableModelDTO dto : result.getResult()) {

        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取UserTableModelDTO分页数据");
        return map;
    }

    /**
     * 获取列表视图数据
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/get", method = RequestMethod.POST)
    public ModelAndView toGetUserTableModelDTO(@RequestBody String[] paramList, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        List<UserTableModelDTO> dtoList = new ArrayList<>();

        //获取当前登录用户
        SysUser user = SessionHelper.getLoginSysUser(request);

        String userId = user.getId();
        String belongTable = paramList[0];
        String viewName = paramList[1];

        try {
            if("系统默认视图".equals(viewName)){
                userId = "系统默认";
            }

            List<UserTableModelDTO> myModelList = userTableModelService.searchUserTableModel(userId, belongTable, viewName, "Y");

            if(myModelList == null){
                mav.addObject("flag", OpResult.failure);
                mav.addObject("message", "未获取到视图相应的表头信息！");
                return mav;
            }
            else{
                StringBuffer dataGridColModelJson = new StringBuffer();
                dataGridColModelJson.append("[");

                for(int i=0; i<myModelList.size(); i++){
                    if(i == 0){
                        dataGridColModelJson.append(myModelList.get(i).getFieldModel());
                    }
                    else{
                        dataGridColModelJson.append("," + myModelList.get(i).getFieldModel());
                    }
                    LOGGER.info(myModelList.get(i).getFieldModel());
                }
                dataGridColModelJson.append("]");

                mav.addObject("dataGridColModelJson", dataGridColModelJson);
                mav.addObject("flag", OpResult.success);
            }
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 根据id选择跳转到新建页还是编辑页
     * @param type 操作类型新建还是编辑
     * @param belongTable 视图所属表
     * @param viewName 编辑数据的视图名称
     * @param request 请求
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/{type}/{belongTable}/{viewName}")
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String belongTable, @PathVariable String viewName, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();

        //获取当前登录用户
        SysUser user = SessionHelper.getLoginSysUser(request);

        if(user == null){
            mav.addObject("flag", OpResult.failure);
            mav.addObject("message", "用户未登录！");
            return mav;
        }

        //批量添加系统默认视图
        if("AddBatch".equals(type)){
            //配置跳转页面
            mav.setViewName("avicit/assets/device/usertablemodel/" + "UserTableModel" + type);
            return mav;
        }

        //编辑窗口或者详细页窗口
        if ("Edit".equals(type)) {
            //获取用户待编辑的视图列表
            List<UserTableModelDTO> myModelList = userTableModelService.searchUserTableModel(user.getId(), belongTable, viewName, null);
            mav.addObject("myModelList", myModelList);

            //构建系统默认表头json
            StringBuffer myModelJson = new StringBuffer();
            myModelJson.append("[");

            for(int i=0; i<myModelList.size(); i++){
                if(i == 0){
                    myModelJson.append(myModelList.get(i).getFieldModel());
                }
                else{
                    myModelJson.append("," + myModelList.get(i).getFieldModel());
                }
            }
            myModelJson.append("]");

            String myModelJsonStr = myModelJson.toString();
            myModelJsonStr = myModelJsonStr.replaceAll(":formatValue", ":'formatValue'");

            //传入待修改的表头json参数
            mav.addObject("myModelJson", myModelJsonStr);

            //传入视图名称参数
            mav.addObject("orignViewName", viewName);
        }

        //获取系统默认视图
        List<UserTableModelDTO> sysModelList = userTableModelService.searchUserTableModel("系统默认", belongTable, "系统默认视图", null);
        mav.addObject("sysModelList", sysModelList);

        //构建系统默认表头json
        String sysModelJson = "[";
        for(int i=0; i<sysModelList.size(); i++){
            if(i == 0){
                sysModelJson += sysModelList.get(i).getFieldModel();
            }
            else{
                sysModelJson += "," + sysModelList.get(i).getFieldModel();
            }
        }
        sysModelJson += "]";
        sysModelJson = sysModelJson.replaceAll(":formatValue", ":'formatValue'");

        //传入系统默认表头json参数
        mav.addObject("sysModelJson", sysModelJson);

        //传入产生所属列表参数
        mav.addObject("belongTable", belongTable);

        //配置跳转页面
        mav.setViewName("avicit/assets/device/usertablemodel/" + "UserTableModel" + type);
        return mav;
    }

    /**
     * 保存视图变更
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/batchSave", method = RequestMethod.POST)
    public ModelAndView toBatchSave(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            UserTableModelDTO userTableModelDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<UserTableModelDTO>() {});

            String modelJson = userTableModelDTO.getFieldModel();
            modelJson = modelJson.replaceAll(" ", "");
            modelJson = modelJson.replaceAll("\r", "");
            modelJson = modelJson.replaceAll("\n", "");
            modelJson = modelJson.replaceAll("\t", "");
            modelJson = modelJson.replaceAll("'", "\"");
            modelJson = modelJson.replaceAll("label:", "\"label\":");
            modelJson = modelJson.replaceAll("name:", "\"name\":");
            modelJson = modelJson.replaceAll("key:", "\"key\":");
            modelJson = modelJson.replaceAll("width:", "\"width\":");
            modelJson = modelJson.replaceAll("hidden:", "\"hidden\":");
            modelJson = modelJson.replaceAll("formatter:", "\"formatter\":");
            modelJson = modelJson.replaceAll(":formatValue", ":\"formatValue\"");
            modelJson = modelJson.replaceAll(":format", ":\"format\"");
            modelJson = modelJson.replace("[", "");
            modelJson = modelJson.replace("]", "");

            String[] modelList = modelJson.split("}");
            Long sn = 3L;
            for(String str : modelList){
                if(str.startsWith("</sec")){
                    continue;
                }

                if(!str.endsWith("}")){
                    str = str + "}";
                }

                UserTableModelDTO dto = new UserTableModelDTO();
                dto.setUserId("系统默认");
                dto.setBelongTable(userTableModelDTO.getBelongTable());
                dto.setViewName("系统默认视图");
                dto.setSn(sn++);
                dto.setIsValid("Y");

                if(str.startsWith("<sec")){
                    String tempStr = str.substring(str.indexOf('{'));
                    str = str + "</sec:accesscontrollist>";

                    JSONObject strJson = JSONObject.parseObject(tempStr);

                    dto.setFieldName(strJson.get("label").toString());
                    dto.setFieldIdentify(strJson.get("name").toString());
                }
                else if(str.startsWith(",{") || str.startsWith("{")){
                    str = str.replace(",{", "{");

                    JSONObject strJson = JSONObject.parseObject(str);

                    dto.setFieldName(strJson.get("label").toString());
                    dto.setFieldIdentify(strJson.get("name").toString());
                }
                else{
                    continue;
                }

                //非id字段
                if(!"id".equals(dto.getFieldIdentify())){
                    if(str.indexOf("\"hidden\":true") > -1){
                        str = str.replaceAll(",\"hidden\":true", "");
                        dto.setIsValid("N");
                    }
                }
                dto.setFieldModel(str);
                userTableModelService.insertUserTableModel(dto);
            }
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            System.out.println(ex.getMessage());
            return mav;
        }
        return mav;

    }

    /**
     * 按照id批量删除数据
     * @param ids id数组
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/deleteModel", method = RequestMethod.POST)
    public ModelAndView toDeleteTableModelDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            userTableModelService.deleteUserTableModelByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 保存视图变更
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveUserTableModelDTO(@RequestBody String[] modelList, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        List<UserTableModelDTO> dtoList = new ArrayList<>();

        //获取当前登录用户
        SysUser user = SessionHelper.getLoginSysUser(request);
        String belongTable = modelList[0];
        String viewName = modelList[1];

        try {
            if("系统默认视图".equals(viewName)){
                mav.addObject("flag", OpResult.failure);
                mav.addObject("message", "不可保存系统默认视图变更！");
                return mav;
            }
            else{
                userTableModelService.deleteUserTableModelList(user.getId(), belongTable, viewName);

                for(int sn = 2; sn<modelList.length; sn++){
                    UserTableModelDTO dto = new UserTableModelDTO();

                    dto.setFieldModel(modelList[sn]);
                    dto.setSn(Long.parseLong(""+sn));
                    dto.setBelongTable(belongTable);
                    dto.setViewName(viewName);

                    JSONObject modelJson = JSONObject.parseObject(modelList[sn]);
                    dto.setFieldIdentify(modelJson.get("name").toString());
                    dto.setFieldName(modelJson.get("label").toString());
                    dto.setUserId(user.getId());
                    dto.setIsValid("Y");

                    dtoList.add(dto);
                }

                userTableModelService.insertUserTableModelList(dtoList);
                mav.addObject("flag", OpResult.success);
                mav.addObject("viewName", viewName);
            }
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 创建新数据
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/create", method = RequestMethod.POST)
    public ModelAndView toCreateUserTableModelDTO(@RequestBody String[] modelList, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        List<UserTableModelDTO> dtoList = new ArrayList<>();

        //获取当前登录用户
        SysUser user = SessionHelper.getLoginSysUser(request);

        if(user == null){
            mav.addObject("flag", OpResult.failure);
            mav.addObject("message", "用户未登录！");
            return mav;
        }
        String userId = user.getId();

        try {
            String type = modelList[0];

            //创建新视图
            if("insert".equals(type)){
                String viewName = modelList[1];
                String belongTable = modelList[2];

                //判断该名称的视图是否已存在
                dtoList = userTableModelService.searchUserTableModel(userId, belongTable, viewName, "Y");
                if((dtoList != null) && (dtoList.size()>0)){
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("message", "该视图已存在，请修改视图名称！");
                    return mav;
                }
                else{
                    for(int sn = 3; sn<modelList.length; sn++){
                        UserTableModelDTO dto = new UserTableModelDTO();
                        String fieldModel = modelList[sn];
                        fieldModel = fieldModel.replaceAll("\"", "'");

                        dto.setFieldModel(modelList[sn]);
                        dto.setSn(Long.parseLong(""+sn));
                        dto.setBelongTable(belongTable);
                        dto.setViewName(viewName);

                        JSONObject modelJson = JSONObject.parseObject(fieldModel);
                        dto.setFieldIdentify(modelJson.get("name").toString());
                        dto.setFieldName(modelJson.get("label").toString());
                        dto.setUserId(user.getId());
                        dto.setIsValid("Y");

                        dtoList.add(dto);
                    }

                    if((dtoList != null) && (dtoList.size()>0)){
                        userTableModelService.insertUserTableModelList(dtoList);
                        mav.addObject("flag", OpResult.success);
                    }
                    else{
                        mav.addObject("flag", OpResult.failure);
                        mav.addObject("msg", "请先为视图选择字段！");
                    }
                    return mav;
                }
            }

            //更新新视图
            if("modify".equals(type)){
                String viewName = modelList[1];
                String orignViewName = modelList[2];
                String belongTable = modelList[3];
                belongTable = belongTable.replaceAll("\"","");

                //删除原视图数据
                userTableModelService.deleteUserTableModelList(userId, belongTable, orignViewName);

                //重新创建该视图的数据
                for(int sn = 4; sn<modelList.length; sn++){
                    UserTableModelDTO dto = new UserTableModelDTO();
                    String fieldModel = modelList[sn];
                    fieldModel.replaceAll("\"", "'");

                    dto.setFieldModel(modelList[sn]);
                    dto.setSn(Long.parseLong(""+sn));
                    dto.setBelongTable(belongTable);
                    dto.setViewName(viewName);

                    JSONObject modelJson = JSONObject.parseObject(fieldModel);
                    dto.setFieldIdentify(modelJson.get("name").toString());
                    dto.setFieldName(modelJson.get("label").toString());
                    dto.setUserId(user.getId());
                    dto.setIsValid("Y");

                    dtoList.add(dto);
                }

                if((dtoList != null) && (dtoList.size()>0)){
                    userTableModelService.insertUserTableModelList(dtoList);
                    mav.addObject("flag", OpResult.success);
                }
                else{
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("msg", "请先为视图选择字段！");
                }
                return mav;
            }
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 按照id批量删除数据
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteUserTableModelDTO(@RequestBody String[] params, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        //获取当前登录用户
        SysUser user = SessionHelper.getLoginSysUser(request);

        if(user == null){
            mav.addObject("flag", OpResult.failure);
            mav.addObject("message", "用户未登录！");
            return mav;
        }

        try {
            userTableModelService.deleteUserTableModelList(user.getId(), params[0], params[1]);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}
