package avicit.assets.device.assetstechtransformproject.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
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
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformPersonDTO;
import avicit.assets.device.assetstechtransformproject.service.AssetsTechTransformPersonService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-09 10:25
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetstechtransformperson/assetsTechTransformPersonController")
public class AssetsTechTransformPersonController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsTechTransformPersonController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;

    @Autowired
    private AssetsTechTransformPersonService assetsTechTransformPersonService;

    @Autowired
    private SysUserAPI sysUserAPI;

    /**
     * 分页查询方法
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsTechTransformPersonsByPage")
    @ResponseBody
    public Map<String, Object> togetAssetsTechTransformPersonByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<AssetsTechTransformPersonDTO> queryReqBean = new QueryReqBean<AssetsTechTransformPersonDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsTechTransformPersonDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsTechTransformPersonDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsTechTransformPersonDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsTechTransformPersonDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsTechTransformPersonDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat,
                    new TypeReference<AssetsTechTransformPersonDTO>() {
                    });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsTechTransformPersonService.searchAssetsTechTransformPersonByPageOr(queryReqBean,
                        orderBy);
            } else {
                result = assetsTechTransformPersonService.searchAssetsTechTransformPersonByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsTechTransformPersonDTO dto : result.getResult()) {
            dto.setProjectRole(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PROJECT_ROLE", dto.getProjectRole(), sysApplicationAPI.getCurrentAppId()));
            dto.setUserNameAlias(dto.getUserName());
            dto.setSex(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_SEX", dto.getSex(), sysApplicationAPI.getCurrentAppId()));
            dto.setUserDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDepartment(), SessionHelper.getCurrentLanguageCode()));
            dto.setUserTitle(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_USER_TITLE", dto.getUserTitle(), sysApplicationAPI.getCurrentAppId()));
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsTechTransformPersonDTO分页数据");
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
    @RequestMapping(value = "/operation/{type}/{projectId}/{id}")
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String projectId, @PathVariable String id, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsTechTransformPersonDTO dto = assetsTechTransformPersonService.queryAssetsTechTransformPersonByPrimaryKey(id);

            dto.setUserNameAlias(dto.getUserName());

            dto.setUserDepartmentAlias(sysDeptLoader.getSysDeptNameBySysDeptId(dto.getUserDepartment(), SessionHelper.getCurrentLanguageCode()));

            mav.addObject("assetsTechTransformPersonDTO", dto);
        }

        //传入技改项目id参数
        mav.addObject("projectId", projectId);

        mav.setViewName("avicit/assets/device/assetstechtransformproject/assetstechtransformperson/" + "AssetsTechTransformPerson" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsTechTransformPersonDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsTechTransformPersonDTO assetsTechTransformPersonDTO = JsonHelper.getInstance().readValue(jsonData,
                    dateFormat, new TypeReference<AssetsTechTransformPersonDTO>() {});

            if (StringUtils.isEmpty(assetsTechTransformPersonDTO.getId())) {//新增
                assetsTechTransformPersonService.insertAssetsTechTransformPerson(assetsTechTransformPersonDTO);
            }
            else {//修改
                assetsTechTransformPersonService.updateAssetsTechTransformPersonSensitive(assetsTechTransformPersonDTO);
            }
            mav.addObject("flag", OpResult.success);
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
    public ModelAndView toDeleteAssetsTechTransformPersonDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            assetsTechTransformPersonService.deleteAssetsTechTransformPersonByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }

    /**
     * 根据用户id获取用户信息
     *
     * @param userId  用户id
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/userInfo", method = RequestMethod.POST)
    public ModelAndView getUserInfo(@RequestBody String userId, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        try {
            SysUser userDto = sysUserAPI.getSysUserById(userId);

            //获取部门信息
            List<SysDept> deptList = sysUserAPI.getDeptsBySysUser(userId);
            for(SysDept dept : deptList){
                if(userDto.getDeptName() == null){
                    userDto.setDeptName(dept.getDeptName());
                    userDto.setDeptId(dept.getId());
                }
                else{
                    userDto.setDeptName(userDto.getDeptName() + "," + dept.getDeptName());
                    userDto.setDeptId(userDto.getDeptId() + "," + dept.getId());
                }
            }

            mav.addObject("flag", OpResult.success);
            mav.addObject("userDto", userDto);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
}