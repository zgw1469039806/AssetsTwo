package avicit.assets.device.assetsuserlog.service;

import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.sysmessage.SysMessageAPI;
import avicit.platform6.api.syspermissionresource.SysPermissionResourceAPI;
import avicit.platform6.api.sysprofile.SysProfileAPI;
import avicit.platform6.api.sysuser.*;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.core.shiroSecurity.contextThread.MobileContextHoder;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.modules.system.syslookup.service.SysLookupLoader;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.apache.cxf.common.util.CompressionUtils;
import org.drools.marshalling.impl.ProtobufMessages;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsuserlog.dao.AssetsUserLogDao;
import avicit.assets.device.assetsuserlog.dto.AssetsUserLogDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import avicit.platform6.api.syslookup.SysLookupAPI;
import org.springframework.util.Assert;
import springfox.documentation.spring.web.json.Json;

import javax.servlet.http.HttpServletRequest;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 10:07
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsUserLogService implements Serializable {
    SysPermissionResourceAPI sysPermisLoader = (SysPermissionResourceAPI)SpringFactory.getBean(SysPermissionResourceAPI.class);
    SysDeptAPI sysDeptLoader = (SysDeptAPI)SpringFactory.getBean(SysDeptAPI.class);
    SysUserDeptPositionAPI sysUserDeptPositionLoader = (SysUserDeptPositionAPI)SpringFactory.getBean(SysUserDeptPositionAPI.class);
    SysUserGroupAPI sysUserGroupLoader = (SysUserGroupAPI)SpringFactory.getBean(SysUserGroupAPI.class);
    SysUserRoleAPI sysUserRoleLoader = (SysUserRoleAPI)SpringFactory.getBean(SysUserRoleAPI.class);
    SysUserAPI sysUserLoader = (SysUserAPI)SpringFactory.getBean(SysUserAPI.class);
    SysOrgAPI sysOrgLoader = (SysOrgAPI)SpringFactory.getBean(SysOrgAPI.class);
    SysGroupAPI sysGroupLoader = (SysGroupAPI)SpringFactory.getBean(SysGroupAPI.class);
    SysLookupAPI sysLookupLoader = (SysLookupAPI)SpringFactory.getBean(SysLookupAPI.class);
    SysPositionAPI sysPositionLoader = (SysPositionAPI)SpringFactory.getBean(SysPositionAPI.class);
    SysRoleAPI sysRoleLoader = (SysRoleAPI)SpringFactory.getBean(SysRoleAPI.class);
    SysProfileAPI sysProfileAPI = (SysProfileAPI)SpringFactory.getBean(SysProfileAPI.class);
    SysMessageAPI sysMessageAPI = (SysMessageAPI)SpringFactory.getBean(SysMessageAPI.class);
    SysUserRelationAPI sysUserRelationAPI = (SysUserRelationAPI)SpringFactory.getBean(SysUserRelationAPI.class);
    private static final Logger logger = LoggerFactory.getLogger(AssetsUserLogService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private  AssetsUserLogDao assetsUserLogDao;

    @Autowired
    private SysApplicationAPI sysApplicationAPI;


    @Autowired
    private SysLookupAPI lookup;

    /**
     * 按条件分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsUserLogDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsUserLogDTO> searchAssetsUserLogByPage(QueryReqBean<AssetsUserLogDTO> queryReqBean,
                                                                     String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsUserLogDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsUserLogDTO> dataList = assetsUserLogDao.searchAssetsUserLogByPage(searchParams, orderBy);
            QueryRespBean<AssetsUserLogDTO> queryRespBean = new QueryRespBean<AssetsUserLogDTO>();
            for (AssetsUserLogDTO assetsDto:dataList) {
                if(assetsDto.getSource()==null||assetsDto.getSource().equals("")){
                    assetsDto.setUserid(assetsDto.getLastUpdatedBy());
                   // updateAssetsUserLog(assetsDto);
                }
            }
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsUserLogByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件or查询的分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsUserLogDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsUserLogDTO> searchAssetsUserLogByPageOr(QueryReqBean<AssetsUserLogDTO> queryReqBean,
                                                                       String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsUserLogDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsUserLogDTO> dataList = assetsUserLogDao.searchAssetsUserLogByPageOr(searchParams, orderBy);
            QueryRespBean<AssetsUserLogDTO> queryRespBean = new QueryRespBean<AssetsUserLogDTO>();
            for (AssetsUserLogDTO assetsDto:dataList) {
                if(assetsDto.getSource()==null||assetsDto.getSource().equals("")){
                    assetsDto.setUserid(assetsDto.getLastUpdatedBy());
//                    updateAssetsUserLog(assetsDto);
                }
            }
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsUserLogByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件查询
     *
     * @param queryReqBean 条件
     * @return List<AssetsUserLogDTO>
     * @throws Exception
     */
    public List<AssetsUserLogDTO> searchAssetsUserLog(QueryReqBean<AssetsUserLogDTO> queryReqBean) throws Exception {
        try {
            AssetsUserLogDTO searchParams = queryReqBean.getSearchParams();
            List<AssetsUserLogDTO> dataList = assetsUserLogDao.searchAssetsUserLog(searchParams);
            for (AssetsUserLogDTO assetsDto:dataList) {
                if(assetsDto.getSource()==null||assetsDto.getSource().equals("")){
                    assetsDto.setUserid(assetsDto.getLastUpdatedBy());
                    updateAssetsUserLog(assetsDto);
                }
            }
            return dataList;
        } catch (Exception e) {
            logger.error("searchAssetsUserLog出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return AssetsUserLogDTO
     * @throws Exception
     */
    public AssetsUserLogDTO queryAssetsUserLogByPrimaryKey(String id) throws Exception {
        try {
            AssetsUserLogDTO dto = assetsUserLogDao.findAssetsUserLogById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            logger.error("queryAssetsUserLogByPrimaryKey出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 新增对象
     *
     * @param dto 保存对象
     * @return String
     * @throws Exception
     */
    public String insertAssetsUserLog(AssetsUserLogDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();//id是dto的id
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            assetsUserLogDao.insertAssetsUserLog(dto);
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertAssetsUserLog出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量新增对象
     *
     * @param dtoList 保存对象集合
     * @return int
     * @throws Exception
     */
    public int insertAssetsUserLogList(List<AssetsUserLogDTO> dtoList) throws Exception {
        List<AssetsUserLogDTO> beanList = new ArrayList<AssetsUserLogDTO>();
        for (AssetsUserLogDTO dto : dtoList) {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            beanList.add(dto);
        }
        try {
            return assetsUserLogDao.insertAssetsUserLogList(beanList);
        } catch (Exception e) {
            logger.error("insertAssetsUserLogList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 修改对象全部字段
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateAssetsUserLog(AssetsUserLogDTO dto) throws Exception {
        //记录日志
        AssetsUserLogDTO old = findById(dto.getId());
        if (old != null) {
            SysLogUtil.log4Update(dto, old);
        }
        PojoUtil.setSysProperties(dto, OpType.update);
        PojoUtil.copyProperties(old, dto, true);
        int ret = assetsUserLogDao.updateAssetsUserLogAll(old);
        if (ret == 0) {
            throw new DaoException("数据失效，请重新更新");
        }
        return ret;
    }

    /**
     * 修改对象部分字段
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateAssetsUserLogSensitive(AssetsUserLogDTO dto) throws Exception {
        try {
            //记录日志
            AssetsUserLogDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = assetsUserLogDao.updateAssetsUserLogSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            logger.error("updateAssetsUserLogSensitive出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量更新对象
     *
     * @param dtoList 修改对象集合
     * @return int
     * @throws Exception
     */
    public int updateAssetsUserLogList(List<AssetsUserLogDTO> dtoList) throws Exception {
        try {
            return assetsUserLogDao.updateAssetsUserLogList(dtoList);
        } catch (Exception e) {
            logger.error("updateAssetsUserLogList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }

    }

    /**
     * 按主键单条删除
     *
     * @param id 主键id
     * @return int
     * @throws Exception
     */
    public int deleteAssetsUserLogById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            //记录日志
            AssetsUserLogDTO obje = findById(id);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return assetsUserLogDao.deleteAssetsUserLogById(id);
        } catch (Exception e) {
            logger.error("deleteAssetsUserLogById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量删除数据
     *
     * @param ids id的数组
     * @return int
     * @throws Exception
     */
    public int deleteAssetsUserLogByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteAssetsUserLogById(id);
            result++;
        }
        return result;
    }

    /**
     * 批量删除数据2
     *
     * @param idList 主键集合
     * @return int
     * @throws Exception
     */
    public int deleteAssetsUserLogList(List<String> idList) throws Exception {
        try {
            return assetsUserLogDao.deleteAssetsUserLogList(idList);
        } catch (Exception e) {
            logger.error("deleteAssetsUserLogList出错：", e);
            throw e;
        }
    }

    /**
     * 日志专用，内部方法，不再记录日志
     *
     * @param id 主键id
     * @return AssetsUserLogDTO
     * @throws Exception
     */
    private AssetsUserLogDTO findById(String id) throws Exception {
        try {
            AssetsUserLogDTO dto = assetsUserLogDao.findAssetsUserLogById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            logger.error("findById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    //台账插入记录
    public  String log4Insert(AssetsDeviceAccountDTO dto) {
		AssetsUserLogDTO userLogDTO = new AssetsUserLogDTO();
        try {
            String id = ComUtil.getId();
            userLogDTO.setId(id);
            //System.out.println(JSONObject.toJSON(dto));  获取到全部的Json串信息，但是顺序不是自己想要的
            userLogDTO.setUserid("1");//操作人ID
            //userLogDTO.setIp(dto.getLastUpdateIp());//操作人IP
            //userLogDTO.setTime(dto.getLastUpdateDate());//操作时间
            userLogDTO.setModuleName(dto.getLogFormName());//模块名称
            //模块ID
            //日志内容
            String str = "";
            str = "新增记录:{主键:'" + dto.getId() + "';资产编号:'" + dto.getAssetId() + "';统一编号:'" + dto.getUnifiedId() + "';}";
            userLogDTO.setLogContent(str);
            userLogDTO.setOpType("新增");//操作类型
            userLogDTO.setDeviceName(dto.getDeviceName());//设备名称
            userLogDTO.setDeviceid(dto.getId());//设备ID
            userLogDTO.setSecretLevel(dto.getSecretLevel());//密级
            userLogDTO.setFormid(dto.getId());//履历卡ID
            userLogDTO.setAttribute01("详情");
            userLogDTO.setUnifiedId(dto.getUnifiedId());//统一编号
            PojoUtil.setSysProperties(userLogDTO, OpType.insert);
            assetsUserLogDao.insertAssetsUserLog(userLogDTO);
            //记录日志
            if (userLogDTO != null) {
                SysLogUtil.log4Insert(userLogDTO);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertAssetsUserLog出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    //台账更新记录
    public String log4Update(AssetsDeviceAccountDTO newDto, AssetsDeviceAccountDTO oldDto) {
        //System.out.println(JSONObject.toJSON(dto));  获取到全部的Json串信息，但是顺序不是自己想要的
        AssetsUserLogDTO userLogDTO = new AssetsUserLogDTO();
        StringBuilder str=new StringBuilder();
        try {
            String id = ComUtil.getId();//id是dto的id
            userLogDTO.setId(id);
            JSONObject newjsonObject = new JSONObject(newDto); //newDto 为str
            JSONObject oldjsonObject = new JSONObject(oldDto);
            Iterator<String> newkeys = newjsonObject.keys();
            Iterator<String> oldkeys = newjsonObject.keys();
            while (newkeys.hasNext()) {
                String newteams = newkeys.next();//获取的是KEY
                String newteamsInfo = newjsonObject.optString(newteams);//获取的是VALUE
                while (oldkeys.hasNext()){
                    String oldteams = oldkeys.next();//获取的是KEY
                    String oldteamsInfo = oldjsonObject.optString(oldteams);//获取的是VALUE
                        if (newteams.equals(oldteams)) {
                                if (!newteamsInfo.equals(oldteamsInfo)) {
                                    if ((newteamsInfo != "") && (oldteamsInfo != null)) {
                                        //old
                                        if(newteams.equals("deviceCategory")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                                                    oldDto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                                                    newDto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if (newteams.equals("ownerIdAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getOwnerId());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getOwnerId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("ownerDeptAlias")){
                                            oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getOwnerDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getOwnerDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("userIdAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getUserId());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getUserId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("userDeptAlias")){
                                            oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getUserDept(), SessionHelper.getCurrentLanguageCode());
                                            newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getUserDept(), SessionHelper.getCurrentLanguageCode());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isManage")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsManage(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsManage(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isInWorkflow")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsInWorkflow(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsInWorkflow(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("manageState")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                                    oldDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                                    newDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                        }
                                        if(newteams.equals("manageState")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                                    oldDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                                    newDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("deviceState")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                                    oldDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                                    newDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("deviceState")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                                    oldDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                                    newDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("abcCategory")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
                                                    oldDto.getAbcCategory(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
                                                    newDto.getAbcCategory(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isKeyDevice")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsKeyDevice(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsKeyDevice(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isResearch")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsResearch(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsResearch(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("secretLevel")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                                                    oldDto.getSecretLevel(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                                                    newDto.getSecretLevel(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isMetering")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsMetering(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsMetering(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isMaintain")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsMaintain(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsMaintain(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isAccuracyCheck")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isRegularCheck")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isSpotCheck")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isSpecialDevice")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isSafetyProduction")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isNeedInstall")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isPc")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", oldDto.getIsPc(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", newDto.getIsPc(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("deviceType")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE",
                                                    oldDto.getDeviceType(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE",
                                                    newDto.getDeviceType(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("metermanAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getMeterman());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getMeterman());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("planMetermanAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getPlanMeterman());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getPlanMeterman());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("meteringDeptAlias")){
                                            oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getMeteringDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getMeteringDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isSceneMetering")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("meteringConclution")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
                                                    oldDto.getMeteringConclution(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
                                                    newDto.getMeteringConclution(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("repairDeptAlias")){
                                            oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getRepairDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getRepairDept(),
                                                    SessionHelper.getCurrentLanguageCode());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("deviceRelatedManAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getDeviceRelatedMan());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getDeviceRelatedMan());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isLabDevice")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsLabDevice(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsLabDevice(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isFixedAssets")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsFixedAssets(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsFixedAssets(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("assetsFinanceType")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_TYPE",
                                                    oldDto.getAssetsFinanceType(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_TYPE",
                                                    newDto.getAssetsFinanceType(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("assetsSource")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_SOURCE",
                                                    oldDto.getAssetsSource(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_SOURCE",
                                                    newDto.getAssetsSource(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("assetsFinanceState")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_STATE",
                                                    oldDto.getAssetsFinanceState(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_STATE",
                                                    newDto.getAssetsFinanceState(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("instituteOrCompany")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY",
                                                    oldDto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY",
                                                    newDto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isTransFixed")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsTransFixed(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsTransFixed(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("meteringOuterAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getMeteringOuter());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getMeteringOuter());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("majorType")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", oldDto.getMajorType(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", newDto.getMajorType(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("majorType")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", oldDto.getMajorType(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", newDto.getMajorType(),
                                                    sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("deviceNature")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_NATURE",
                                                    oldDto.getDeviceNature(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_NATURE",
                                                    newDto.getDeviceNature(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("softwareDesignerAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getSoftwareDesigner());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getSoftwareDesigner());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                        }
                                        if(newteams.equals("hardwareDesignerAlias")){
                                            oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getHardwareDesigner());
                                            newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getHardwareDesigner());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                        }
                                        if(newteams.equals("isTestDevice")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        if(newteams.equals("isNeedCertificate")){
                                            oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    oldDto.getIsNeedCertificate(), sysApplicationAPI.getCurrentAppId());
                                            newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                                    newDto.getIsNeedCertificate(), sysApplicationAPI.getCurrentAppId());
                                            str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                        }
                                        str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                    }
                                }
                                break;
                        }
                }
            }
            if (str.length()==0){
                userLogDTO.setLogContent("未修改内容");
            }else{
                String logContent= "修改记录:{"+str+"}";
                userLogDTO.setLogContent(logContent);
            }
            userLogDTO.setUserid("1");//操作人ID
            userLogDTO.setAttribute01("详情");
            //操作人姓名
            //操作人部门ID
            //操作人部门
            //userLogDTO.setIp(userLogDTO.getLastUpdateIp());//操作人IP
            //userLogDTO.setTime(userLogDTO.getLastUpdateDate());//操作时间
            userLogDTO.setModuleName(newDto.getLogFormName());//模块名称
            //模块ID
            //模块ID
            userLogDTO.setOpType("修改");//操作类型
            //操作结果
            userLogDTO.setDeviceName(newDto.getDeviceName());//设备名称
            userLogDTO.setDeviceid(newDto.getId());//设备ID
            userLogDTO.setSecretLevel(newDto.getSecretLevel());//密级
            //业务来源
            //业务来源ID
            userLogDTO.setFormid(newDto.getId());//履历卡ID
            userLogDTO.setUnifiedId(newDto.getUnifiedId());//统一编号
            PojoUtil.setSysProperties(userLogDTO, OpType.insert);
            assetsUserLogDao.insertAssetsUserLog(userLogDTO);
            if (userLogDTO != null) {
                SysLogUtil.log4Insert(userLogDTO);
            }

            return id;
        } catch (Exception e) {
            logger.error("insertAssetsUserLog出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    //流程台账更新记录
    public String log4FlowUpdate(AssetsDeviceAccountDTO newDto, AssetsDeviceAccountDTO oldDto,String created_by,String formId,String flowName,String flowID) {
        //System.out.println(JSONObject.toJSON(dto));  获取到全部的Json串信息，但是顺序不是自己想要的
        AssetsUserLogDTO userLogDTO = new AssetsUserLogDTO();
        StringBuilder str=new StringBuilder();
        try {
            String id = ComUtil.getId();//id是dto的id
            userLogDTO.setId(id);
            JSONObject newjsonObject = new JSONObject(newDto); //newDto 为str
            JSONObject oldjsonObject = new JSONObject(oldDto);
            Iterator<String> newkeys = newjsonObject.keys();
            Iterator<String> oldkeys = newjsonObject.keys();
            while (newkeys.hasNext()) {
                String newteams = newkeys.next();//获取的是KEY
                String newteamsInfo = newjsonObject.optString(newteams);//获取的是VALUE
                while (oldkeys.hasNext()){
                    String oldteams = oldkeys.next();//获取的是KEY
                    String oldteamsInfo = oldjsonObject.optString(oldteams);//获取的是VALUE
                    if (newteams.equals(oldteams)) {
                        if (!newteamsInfo.equals(oldteamsInfo)) {
                            if ((newteamsInfo != "") && (oldteamsInfo != null)) {
                                if(newteams.equals("deviceCategory")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                                            oldDto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_CATEGORY",
                                            newDto.getDeviceCategory(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if (newteams.equals("ownerIdAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getOwnerId());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getOwnerId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("ownerDeptAlias")){
                                    oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getOwnerDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getOwnerDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("userIdAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getUserId());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getUserId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("userDeptAlias")){
                                    oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getUserDept(), SessionHelper.getCurrentLanguageCode());
                                    newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getUserDept(), SessionHelper.getCurrentLanguageCode());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isManage")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsManage(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsManage(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isInWorkflow")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsInWorkflow(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsInWorkflow(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("manageState")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                            oldDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                            newDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                }
                                if(newteams.equals("manageState")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                            oldDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MANAGE_STATE",
                                            newDto.getManageState(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("deviceState")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                            oldDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                            newDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("deviceState")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                            oldDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_STATE",
                                            newDto.getDeviceState(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("abcCategory")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
                                            oldDto.getAbcCategory(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ABC_CATEGORY",
                                            newDto.getAbcCategory(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isKeyDevice")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsKeyDevice(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsKeyDevice(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isResearch")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsResearch(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsResearch(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("secretLevel")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                                            oldDto.getSecretLevel(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("SECRET_LEVEL",
                                            newDto.getSecretLevel(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isMetering")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsMetering(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsMetering(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isMaintain")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsMaintain(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsMaintain(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isAccuracyCheck")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsAccuracyCheck(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isRegularCheck")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsRegularCheck(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isSpotCheck")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsSpotCheck(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isSpecialDevice")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsSpecialDevice(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isSafetyProduction")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsSafetyProduction(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isNeedInstall")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsNeedInstall(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isPc")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", oldDto.getIsPc(),
                                            sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG", newDto.getIsPc(),
                                            sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("deviceType")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE",
                                            oldDto.getDeviceType(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_TYPE",
                                            newDto.getDeviceType(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("metermanAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getMeterman());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getMeterman());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("planMetermanAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getPlanMeterman());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getPlanMeterman());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("meteringDeptAlias")){
                                    oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getMeteringDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getMeteringDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isSceneMetering")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsSceneMetering(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("meteringConclution")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
                                            oldDto.getMeteringConclution(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("METERING_CONCLUTION",
                                            newDto.getMeteringConclution(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("repairDeptAlias")){
                                    oldteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(oldDto.getRepairDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    newteamsInfo=sysDeptLoader.getSysDeptNameBySysDeptId(newDto.getRepairDept(),
                                            SessionHelper.getCurrentLanguageCode());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("deviceRelatedManAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getDeviceRelatedMan());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getDeviceRelatedMan());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isLabDevice")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsLabDevice(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsLabDevice(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isFixedAssets")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsFixedAssets(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsFixedAssets(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("assetsFinanceType")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_TYPE",
                                            oldDto.getAssetsFinanceType(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_TYPE",
                                            newDto.getAssetsFinanceType(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("assetsSource")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_SOURCE",
                                            oldDto.getAssetsSource(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_SOURCE",
                                            newDto.getAssetsSource(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("assetsFinanceState")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_STATE",
                                            oldDto.getAssetsFinanceState(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("ASSETS_FINANCE_STATE",
                                            newDto.getAssetsFinanceState(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("instituteOrCompany")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY",
                                            oldDto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("INSTITUTE_OR_COMPANY",
                                            newDto.getInstituteOrCompany(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isTransFixed")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsTransFixed(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsTransFixed(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("meteringOuterAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getMeteringOuter());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getMeteringOuter());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("majorType")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", oldDto.getMajorType(),
                                            sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", newDto.getMajorType(),
                                            sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("majorType")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", oldDto.getMajorType(),
                                            sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("MAJOR_TYPE", newDto.getMajorType(),
                                            sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("deviceNature")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_NATURE",
                                            oldDto.getDeviceNature(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("DEVICE_NATURE",
                                            newDto.getDeviceNature(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("softwareDesignerAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getSoftwareDesigner());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getSoftwareDesigner());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                }
                                if(newteams.equals("hardwareDesignerAlias")){
                                    oldteamsInfo=sysUserLoader.getSysUserNameById(oldDto.getHardwareDesigner());
                                    newteamsInfo=sysUserLoader.getSysUserNameById(newDto.getHardwareDesigner());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");

                                }
                                if(newteams.equals("isTestDevice")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsTestDevice(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                if(newteams.equals("isNeedCertificate")){
                                    oldteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            oldDto.getIsNeedCertificate(), sysApplicationAPI.getCurrentAppId());
                                    newteamsInfo=sysLookupLoader.getNameByLooupTypeCodeAndLooupCodeByAppId("PLATFORM_YES_NO_FLAG",
                                            newDto.getIsNeedCertificate(), sysApplicationAPI.getCurrentAppId());
                                    str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                                }
                                str.append(newteams + ":'" + oldteamsInfo + "' 修改为 '" + newteamsInfo + "';  ");
                            }
                        }
                        break;
                    }
                }
            }
            if (str.length()==0){
                userLogDTO.setLogContent("未修改内容");
            }else{
                String logContent= "修改记录:{"+str+"}";
                userLogDTO.setLogContent(logContent);
            }
            if(created_by==null||("").equals(created_by)){
                if (MobileContextHoder.MOBILE.get() != null && (Boolean)MobileContextHoder.MOBILE.get()) {
                    MobileContextHoder.MobileLogInfo info = (MobileContextHoder.MobileLogInfo)MobileContextHoder.MOBILE_LOGINFO.get();
                    userLogDTO.setUserid(info.getUserId());
                }
            }else{
                userLogDTO.setUserid(created_by);
            }
            //操作人IP
            //userLogDTO.setTime(newDto.getLastUpdateDate());//操作时间
            userLogDTO.setModuleName(newDto.getLogFormName());//模块名称
            //模块ID
            userLogDTO.setOpType("修改");//操作类型
            userLogDTO.setAttribute01("详情");
            userLogDTO.setDeviceName(newDto.getDeviceName());//设备名称
            userLogDTO.setDeviceid(newDto.getId());//设备ID
            userLogDTO.setSecretLevel(newDto.getSecretLevel());//密级
            userLogDTO.setSource(flowName);//业务来源
            userLogDTO.setSourceid(flowID);//业务来源ID
            userLogDTO.setFormid(formId);//履历卡ID
            userLogDTO.setUnifiedId(newDto.getUnifiedId());//统一编号
            PojoUtil.setSysProperties(userLogDTO, OpType.insert);
            assetsUserLogDao.insertAssetsUserLog(userLogDTO);
            if (userLogDTO != null) {
                SysLogUtil.log4Insert(userLogDTO);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertAssetsUserLog出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }
}

