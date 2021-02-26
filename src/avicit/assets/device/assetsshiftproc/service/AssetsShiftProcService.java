package avicit.assets.device.assetsshiftproc.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import org.springframework.util.Assert;

import avicit.platform6.bpm.api.listener.InstanceDeleteEventListener;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.bpmreform.bpmbusiness.service.BusinessService;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.assets.device.assetsshiftproc.dto.AssetsShiftProcDTO;
import avicit.assets.device.assetsshiftproc.dao.AssetsShiftProcDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-15 16:10
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsShiftProcService implements Serializable, InstanceDeleteEventListener {

    private static final Logger logger = LoggerFactory.getLogger(AssetsShiftProcService.class);

    @Autowired
    private BpmOperateService bpmOperateService;

    private static final long serialVersionUID = 1L;

    @Autowired
    private AssetsShiftProcDao assetsShiftProcDao;

    @Autowired
    private SwfUploadService sysAttachmentAPI;

    @Autowired
    private BusinessService businessService;

    @Autowired
    private SysAutoCodeAPI sysAutoCodeAPI;

    /**
     * 可注册为流程的删除事件
     *
     * @param processInstanceId 流程实例id
     * @param executionId
     * @param formId            表单id
     * @throws Exception
     */
    @Override
    public void notify(String processInstanceId, String executionId, String formId) throws Exception {
        AssetsShiftProcDao assetsShiftProcDao = SpringFactory.getBean(AssetsShiftProcDao.class);
        assetsShiftProcDao.deleteAssetsShiftProcById(formId);
    }

    /**
     * 按条件分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsShiftProcDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsShiftProcDTO> searchAssetsShiftProcByPage(QueryReqBean<AssetsShiftProcDTO> queryReqBean,
                                                                         String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsShiftProcDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsShiftProcDTO> dataList = assetsShiftProcDao.searchAssetsShiftProcByPage(searchParams, orderBy);
            QueryRespBean<AssetsShiftProcDTO> queryRespBean = new QueryRespBean<AssetsShiftProcDTO>();
            for (AssetsShiftProcDTO dto : dataList.getResult()) {
                dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
            }
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsShiftProcByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件or查询的分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsShiftProcDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsShiftProcDTO> searchAssetsShiftProcByPageOr(
            QueryReqBean<AssetsShiftProcDTO> queryReqBean, String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsShiftProcDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsShiftProcDTO> dataList = assetsShiftProcDao.searchAssetsShiftProcByPageOr(searchParams, orderBy);
            QueryRespBean<AssetsShiftProcDTO> queryRespBean = new QueryRespBean<AssetsShiftProcDTO>();
            for (AssetsShiftProcDTO dto : dataList.getResult()) {
                dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
            }
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsShiftProcByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 流程的编码转换成名称
     *
     * @param stateCode 编码
     * @return String
     */
    private String processStateCode2StateName(String stateCode) {
        String stateName = "";
        if (stateCode != null && "active".equals(stateCode)) {
            stateName = "流转中";
        } else if (stateCode != null && "ended".equals(stateCode)) {
            stateName = "结束";
        } else if (stateCode != null && "start".equals(stateCode)) {
            stateName = "草稿";
        }
        return stateName;
    }

    /**
     * 按条件查询，不分页
     *
     * @param queryReqBean 查询条件
     * @return List<AssetsShiftProcDTO>
     * @throws Exception
     */
    public List<AssetsShiftProcDTO> searchAssetsShiftProc(QueryReqBean<AssetsShiftProcDTO> queryReqBean)
            throws Exception {
        try {
            AssetsShiftProcDTO searchParams = queryReqBean.getSearchParams();
            List<AssetsShiftProcDTO> dataList = assetsShiftProcDao.searchAssetsShiftProc(searchParams);
            return dataList;
        } catch (Exception e) {
            logger.error("searchAssetsShiftProc出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return AssetsShiftProcDTO
     * @throws Exception
     */
    public AssetsShiftProcDTO queryAssetsShiftProcByPrimaryKey(String id) throws Exception {
        try {
            AssetsShiftProcDTO dto = assetsShiftProcDao.findAssetsShiftProcById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            logger.error("queryAssetsShiftProcByPrimaryKey出错：", e);
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
    public String insertAssetsShiftProc(AssetsShiftProcDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);

            //设置移位申请单编号
            Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "ASSETS_SHIFT_PROC", dto.getAutoCodeValue(), dto.getId(), false);
            if (map.get("result").equals("success")) {
                dto.setShiftNo(map.get("autoCodeValue"));
            }

            assetsShiftProcDao.insertAssetsShiftProc(dto);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertAssetsShiftProc出错：", e);
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
    public int insertAssetsShiftProcList(List<AssetsShiftProcDTO> dtoList) throws Exception {
        List<AssetsShiftProcDTO> beanList = new ArrayList<AssetsShiftProcDTO>();
        for (AssetsShiftProcDTO dto : dtoList) {
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
            return assetsShiftProcDao.insertAssetsShiftProcList(beanList);
        } catch (Exception e) {
            logger.error("insertAssetsShiftProcList出错：", e);
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
    public int updateAssetsShiftProc(AssetsShiftProcDTO dto) throws Exception {
        try {
            //记录日志
            AssetsShiftProcDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int ret = assetsShiftProcDao.updateAssetsShiftProcAll(old);
            if (ret == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return ret;
        } catch (Exception e) {
            logger.error("updateAssetsShiftProc出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 修改对象部分字段
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateAssetsShiftProcSensitive(AssetsShiftProcDTO dto) throws Exception {
        try {
            //记录日志
            AssetsShiftProcDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int ret = assetsShiftProcDao.updateAssetsShiftProcSensitive(old);
            if (ret == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return ret;
        } catch (Exception e) {
            logger.error("updateAssetsShiftProcSensitive出错：", e);
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
    public int updateAssetsShiftProcList(List<AssetsShiftProcDTO> dtoList) throws Exception {
        try {
            return assetsShiftProcDao.updateAssetsShiftProcList(dtoList);
        } catch (Exception e) {
            logger.error("updateAssetsShiftProcList出错：", e);
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
    public int deleteAssetsShiftProcById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            //记录日志
            AssetsShiftProcDTO obje = findById(id);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return assetsShiftProcDao.deleteAssetsShiftProcById(id);
        } catch (Exception e) {
            logger.error("deleteAssetsShiftProcById出错：", e);
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
    public int deleteAssetsShiftProcByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            sysAttachmentAPI.deleteAttachByFormId(id);
            deleteAssetsShiftProcById(id);
            String flowInstanceId = bpmOperateService.getInstanceIdByFormid(id);
            if (flowInstanceId != null && !"".equals(flowInstanceId)) {
                bpmOperateService.deleteProcessInstanceCascade(flowInstanceId);
            }
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
    public int deleteAssetsShiftProcList(List<String> idList) throws Exception {
        try {
            return assetsShiftProcDao.deleteAssetsShiftProcList(idList);
        } catch (Exception e) {
            logger.error("deleteAssetsShiftProcList出错：", e);
            throw e;
        }
    }

    /**
     * 日志专用，内部方法，不再记录日志
     *
     * @param id 主键id
     * @return AssetsShiftProcDTO
     * @throws Exception
     */
    private AssetsShiftProcDTO findById(String id) throws Exception {
        try {
            AssetsShiftProcDTO dto = assetsShiftProcDao.findAssetsShiftProcById(id);
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

    /**
     * 保存表单并启动流程
     *
     * @param bean      表单对象
     * @param parameter 启动流程所需要的参数
     * @return StartResultBean
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public StartResultBean insertAssetsShiftProcAndStartProcess(AssetsShiftProcDTO bean, Map<String, Object> parameter)
            throws Exception {
        Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
        String processDefId = (String) parameter.get("processDefId");
        String formCode = (String) parameter.get("formCode");
        String jsonString = (String) parameter.get("jsonString");
        String userId = (String) parameter.get("userId");
        String deptId = (String) parameter.get("deptId");
        Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
        //业务操作
        this.insertAssetsShiftProc(bean);
        //
        Map<String, Object> variables = new HashMap<String, Object>();
        //web表单传递过来(除表单对象外)的变量，可以为空
        if (jsonString != null && !"".equals(jsonString)) {
            Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String) jsonString);
            variables.putAll(extVariables);
        }
        //把表单对象转换成map,传递给流程变量
        Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
        variables.putAll(pojoMap);
        String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId,
                variables);
        // 返回对象
        return businessService.getStartResultBean(processInstanceId, bean.getId(), userId);
    }
}