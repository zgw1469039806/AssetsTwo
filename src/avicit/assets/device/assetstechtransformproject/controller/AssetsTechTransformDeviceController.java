package avicit.assets.device.assetstechtransformproject.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformDeviceDTO;
import avicit.assets.device.assetstechtransformproject.service.AssetsTechTransformDeviceService;
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
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 20:43
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/device/assetstechtransformdevice/assetsTechTransformDeviceController")
public class AssetsTechTransformDeviceController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetsTechTransformDeviceController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private AssetsTechTransformDeviceService assetsTechTransformDeviceService;

    /**
     * 跳转到管理页面
     *
     * @param request 请求
     * @param reponse 响应
     * @return ModelAndView
     */
    @RequestMapping(value = "toAssetsTechTransformDeviceManage")
    public ModelAndView toAssetsTechTransformDeviceManage(HttpServletRequest request, HttpServletResponse reponse) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/assets/device/assetstechtransformproject/assetstechtransformdevice/AssetsTechTransformDeviceManage");
        mav.addObject("url","platform/assets/device/assetstechtransformdevice/assetsTechTransformDeviceController/operation/");
        return mav;
    }

    /**
     * 分页查询方法
     *
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getAssetsTechTransformDevices")
    @ResponseBody
    public Map<String, Object> togetAssetsTechTransformDevice(HttpServletRequest request) {
        QueryReqBean<AssetsTechTransformDeviceDTO> queryReqBean = new QueryReqBean<AssetsTechTransformDeviceDTO>();
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
            cloumnName = ComUtil.getColumn(AssetsTechTransformDeviceDTO.class, sidx);
            if (cloumnName != null) {//这里先进行判断是否有对应的数据库字段
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsTechTransformDeviceDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(AssetsTechTransformDeviceDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        AssetsTechTransformDeviceDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<AssetsTechTransformDeviceDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat,
                    new TypeReference<AssetsTechTransformDeviceDTO>() {
                    });
            queryReqBean.setSearchParams(param);
        }
        try {
            if (!"".equals(keyWord)) {
                result = assetsTechTransformDeviceService.searchAssetsTechTransformDeviceByPageOr(queryReqBean, orderBy);
            }
            else {
                result = assetsTechTransformDeviceService.searchAssetsTechTransformDeviceByPage(queryReqBean, orderBy);
            }
        } catch (Exception ex) {
            return map;
        }

        for (AssetsTechTransformDeviceDTO dto : result.getResult()) {
            dto.setIsEntity(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                    dto.getIsEntity(), sysApplicationAPI.getCurrentAppId()));

            dto.setSingleOrSet(sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SINGLE_OR_SET",
                    dto.getSingleOrSet(), sysApplicationAPI.getCurrentAppId()));
        }

        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取AssetsTechTransformDeviceDTO分页数据");
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
    @RequestMapping(value = "/operation/{type}/{projectId}/{parentId}/{id}")
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String projectId, @PathVariable String parentId,
                                       @PathVariable String id, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (!"Add".equals(type)) {//编辑窗口或者详细页窗口
            //主表数据
            AssetsTechTransformDeviceDTO dto = assetsTechTransformDeviceService.queryAssetsTechTransformDeviceByPrimaryKey(id);

            mav.addObject("assetsTechTransformDeviceDTO", dto);
        }

        //传入技改项目id参数
        mav.addObject("projectId", projectId);

        //传入父节点id参数
        mav.addObject("parentId", parentId);

        mav.setViewName("avicit/assets/device/assetstechtransformproject/assetstechtransformdevice/" + "AssetsTechTransformDevice" + type);
        return mav;
    }

    /**
     * 保存数据
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveAssetsTechTransformDeviceDTO(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO = JsonHelper.getInstance().readValue(jsonData,
                    dateFormat, new TypeReference<AssetsTechTransformDeviceDTO>() {});

            if (StringUtils.isEmpty(assetsTechTransformDeviceDTO.getId())) {//新增
                //是否为叶子节点设为"true"
                assetsTechTransformDeviceDTO.setIsLeaf("true");

                //创建根设备
                if("null".equals(assetsTechTransformDeviceDTO.getParentId())){
                    //将父设备id设为空字符串
                    assetsTechTransformDeviceDTO.setParentId("");

                    //将treePath设为空字符串
                    assetsTechTransformDeviceDTO.setTreePath("");

                    //获取同为根设备的排序号最大的设备
                    AssetsTechTransformDeviceDTO lastChild = assetsTechTransformDeviceService.getLastChildTechTransformDeviceByPid("");

                    //添加的为第一个设备
                    if(lastChild == null){
                        //序号设为1
                        assetsTechTransformDeviceDTO.setPointNo("1");

                        //层级设为1
                        assetsTechTransformDeviceDTO.setPointLevel(1L);

                        //排序号设为1
                        assetsTechTransformDeviceDTO.setDeviceSn(1L);
                    }
                    //添加的不为第一个设备
                    else{
                        //序号为最后一个兄弟节点的序号+1
                        String deviceNoStr = lastChild.getPointNo();
                        Long deviceNo = Long.parseLong(deviceNoStr);
                        deviceNo = deviceNo + 1;
                        assetsTechTransformDeviceDTO.setPointNo("" + deviceNo);

                        //层级与兄弟节点一致
                        assetsTechTransformDeviceDTO.setPointLevel(lastChild.getPointLevel());

                        Long maxSn = assetsTechTransformDeviceService.getMaxSnByTreepath(lastChild.getTreePath(), assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceService.increaseAssetsTechTransformDeviceSn(maxSn, assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceDTO.setDeviceSn(maxSn + 1);
                    }

                    assetsTechTransformDeviceService.insertAssetsTechTransformDevice(assetsTechTransformDeviceDTO);
                }
                //创建子设备
                else{
                    //获取同为根设备的排序号最大的设备
                    AssetsTechTransformDeviceDTO lastChild = assetsTechTransformDeviceService.getLastChildTechTransformDeviceByPid(assetsTechTransformDeviceDTO.getParentId());

                    //获取父设备
                    AssetsTechTransformDeviceDTO parentDto = assetsTechTransformDeviceService.queryAssetsTechTransformDeviceByPrimaryKey(assetsTechTransformDeviceDTO.getParentId());

                    //设置treePath
                    assetsTechTransformDeviceDTO.setTreePath(parentDto.getTreePath());

                    if(lastChild != null){
                        //序号为最后一个兄弟设备的序号+1
                        String deviceNoStr = lastChild.getPointNo();
                        Long deviceNo = Long.parseLong(deviceNoStr.substring(deviceNoStr.lastIndexOf(".") + 1));
                        deviceNoStr = deviceNoStr.substring(0, deviceNoStr.lastIndexOf(".")+1);
                        deviceNo = deviceNo + 1;
                        assetsTechTransformDeviceDTO.setPointNo(deviceNoStr + deviceNo);

                        //层级与兄弟设备一致
                        assetsTechTransformDeviceDTO.setPointLevel(lastChild.getPointLevel());

                        //获取新增设备之前设备的最大排序号
                        Long maxSn = assetsTechTransformDeviceService.getMaxSnByTreepath(lastChild.getTreePath(), assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceService.increaseAssetsTechTransformDeviceSn(maxSn, assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceDTO.setDeviceSn(maxSn + 1);
                    }
                    else{
                        //序号为父设备序号+“.1”
                        assetsTechTransformDeviceDTO.setPointNo(parentDto.getPointNo() + ".1");

                        //层级为父设备层级+1
                        assetsTechTransformDeviceDTO.setPointLevel(parentDto.getPointLevel() + 1);

                        //获取新增设备之前设备的最大排序号
                        Long maxSn = assetsTechTransformDeviceService.getMaxSnByTreepath(parentDto.getTreePath(), assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceService.increaseAssetsTechTransformDeviceSn(maxSn, assetsTechTransformDeviceDTO.getProjectId());
                        assetsTechTransformDeviceDTO.setDeviceSn(maxSn + 1);
                    }

                    assetsTechTransformDeviceService.insertAssetsTechTransformDevice(assetsTechTransformDeviceDTO);

                    parentDto.setIsLeaf("false");
                    assetsTechTransformDeviceService.updateAssetsTechTransformDeviceSensitive(parentDto);
                }
            }
            else {//修改
                assetsTechTransformDeviceService.updateAssetsTechTransformDeviceSensitive(assetsTechTransformDeviceDTO);
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
    public ModelAndView toDeleteAssetsTechTransformDeviceDTO(@RequestBody String[] ids, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        List<AssetsTechTransformDeviceDTO> childList = new ArrayList<>();
        try {
            for(String id : ids){
                childList = assetsTechTransformDeviceService.getChildsTechTransformDeviceByPid(id);
                if((childList == null) || (childList.size() == 0)){
                    AssetsTechTransformDeviceDTO dto = assetsTechTransformDeviceService.queryAssetsTechTransformDeviceByPrimaryKey(id);
                    assetsTechTransformDeviceService.deleteAssetsTechTransformDeviceById(id);

                    childList = assetsTechTransformDeviceService.getChildsTechTransformDeviceByPid(dto.getParentId());
                    for(int i=0; i<childList.size(); i++){
                        if(childList.get(i).getDeviceSn() < dto.getDeviceSn()){
                            continue;
                        }

                        String deviceNo = childList.get(i).getPointNo();
                        deviceNo = deviceNo.substring(0, deviceNo.lastIndexOf(".")+1);
                        deviceNo = deviceNo + ( childList.size() - i);
                        childList.get(i).setPointNo(deviceNo);

                        assetsTechTransformDeviceService.updateAssetsTechTransformDeviceSensitive(childList.get(i));
                    }
                }
                else{
                    AssetsTechTransformDeviceDTO dto = assetsTechTransformDeviceService.queryAssetsTechTransformDeviceByPrimaryKey(id);
                    mav.addObject("flag", OpResult.failure);
                    mav.addObject("message", "“" + dto.getDeviceName() + "”存在子设备，请先删除子设备！");
                    return mav;
                }
            }

            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            mav.addObject("message",  "程序错误，请联系管理员！");
            return mav;
        }
        return mav;
    }
}
