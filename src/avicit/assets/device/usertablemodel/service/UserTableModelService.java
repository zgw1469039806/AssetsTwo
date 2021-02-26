package avicit.assets.device.usertablemodel.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.assets.device.usertablemodel.dao.UserTableModelDao;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 10:01
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class UserTableModelService implements Serializable {

    private static final Logger logger = LoggerFactory.getLogger(UserTableModelService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private UserTableModelDao userTableModelDao;

    /**
     * 按条件分页查询
     * @param queryReqBean 分页
     * @param orderBy 排序
     * @return QueryRespBean<UserTableModelDTO>
     * @throws Exception
     */
    public QueryRespBean<UserTableModelDTO> searchUserTableModelByPage(QueryReqBean<UserTableModelDTO> queryReqBean,
                                                                       String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            UserTableModelDTO searchParams = queryReqBean.getSearchParams();
            Page<UserTableModelDTO> dataList = userTableModelDao.searchUserTableModelByPage(searchParams, orderBy);
            QueryRespBean<UserTableModelDTO> queryRespBean = new QueryRespBean<UserTableModelDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchUserTableModelByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件or查询的分页查询
     * @param queryReqBean 分页
     * @param orderBy 排序
     * @return QueryRespBean<UserTableModelDTO>
     * @throws Exception
     */
    public QueryRespBean<UserTableModelDTO> searchUserTableModelByPageOr(QueryReqBean<UserTableModelDTO> queryReqBean,
                                                                         String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            UserTableModelDTO searchParams = queryReqBean.getSearchParams();
            Page<UserTableModelDTO> dataList = userTableModelDao.searchUserTableModelByPageOr(searchParams, orderBy);
            QueryRespBean<UserTableModelDTO> queryRespBean = new QueryRespBean<UserTableModelDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchUserTableModelByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件查询
     * @param userId(用户id)、belongTable(所属表)、viewName(视图名称)、isValid(是否可用)
     * @return List<UserTableModelDTO>
     * @throws Exception
     */
    public List<UserTableModelDTO> searchUserTableModel(String userId, String belongTable, String viewName, String isValid) throws Exception {
        try {
            List<UserTableModelDTO> dataList = userTableModelDao.searchUserTableModel(userId, belongTable, viewName, isValid);
            return dataList;
        } catch (Exception e) {
            logger.error("searchUserTableModel出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     * @param id 主键id
     * @return UserTableModelDTO
     * @throws Exception
     */
    public UserTableModelDTO queryUserTableModelByPrimaryKey(String id) throws Exception {
        try {
            UserTableModelDTO dto = userTableModelDao.findUserTableModelById(id);

            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            logger.error("queryUserTableModelByPrimaryKey出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 新增对象
     * @param dto 保存对象
     * @return String
     * @throws Exception
     */
    public String insertUserTableModel(UserTableModelDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            userTableModelDao.insertUserTableModel(dto);

            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertUserTableModel出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量新增对象
     * @param dtoList 保存对象集合
     * @return int
     * @throws Exception
     */
    public int insertUserTableModelList(List<UserTableModelDTO> dtoList) throws Exception {
        List<UserTableModelDTO> beanList = new ArrayList<UserTableModelDTO>();
        for (UserTableModelDTO dto : dtoList) {
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
            return userTableModelDao.insertUserTableModelList(beanList);
        } catch (Exception e) {
            logger.error("insertUserTableModelList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按主键单条删除
     * @param id 主键id
     * @return int
     * @throws Exception
     */
    public int deleteUserTableModelById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            //记录日志
            UserTableModelDTO obje = findById(id);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return userTableModelDao.deleteUserTableModelById(id);
        } catch (Exception e) {
            logger.error("deleteUserTableModelById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 根据“用户id”、“所属表”、“视图名称”批量删除数据
     * @param userId(用户id)、belongTable(所属表)、viewName(视图名称)
     * @return int
     * @throws Exception
     */
    public int deleteUserTableModelList(String userId, String belongTable, String viewName) throws Exception {
        if(userId == null){
            throw new Exception("删除失败！传入的参数“当前用户id”为null");
        }

        if(belongTable == null){
            throw new Exception("删除失败！传入的参数“所属表”为null");
        }

        if(viewName == null){
            throw new Exception("删除失败！传入的参数“视图名称”为null");
        }

        try {
            return userTableModelDao.deleteUserTableModelList(userId, belongTable, viewName);
        } catch (Exception e) {
            logger.error("deleteUserTableModelList出错：", e);
            throw e;
        }
    }

    /**
     * 日志专用，内部方法，不再记录日志
     * @param id 主键id
     * @return UserTableModelDTO
     * @throws Exception
     */
    private UserTableModelDTO findById(String id) throws Exception {
        try {
            UserTableModelDTO dto = userTableModelDao.findUserTableModelById(id);
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
     * 根据用户id、所属表获取用户拥有的该表的视图
     * @param userId(用户id)、belongTable(所属表)
     * @return List<String>
     * @throws Exception
     */
    public List<String> getUserViewList(String userId, String belongTable) throws Exception {
        try {
            List<String> viewList = userTableModelDao.getUserViewList(userId, belongTable);
            viewList.add("系统默认视图");
            return viewList;
        } catch (Exception e) {
            logger.error("getUserViewList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量删除数据
     * @param ids id的数组
     * @return int
     * @throws Exception
     */
    public int deleteUserTableModelByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteUserTableModelById(id);
            result++;
        }
        return result;
    }
}
