package avicit.assets.device.assetsallotproc.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;
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
import avicit.assets.device.assetsallotproc.dto.AllotAssetsDTO;
import avicit.assets.device.assetsallotproc.dao.AllotAssetsDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-17 09:02
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AllotAssetsService implements Serializable {

    private static final Logger LOGGER = LoggerFactory.getLogger(AllotAssetsService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private AllotAssetsDao allotAssetsDao;

    /**
     * 按条件分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AllotAssetsDTO>
     * @throws Exception
     */
    public QueryRespBean<AllotAssetsDTO> searchAllotAssetsByPage(QueryReqBean<AllotAssetsDTO> queryReqBean,
                                                                 String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AllotAssetsDTO searchParams = queryReqBean.getSearchParams();
            Page<AllotAssetsDTO> dataList = allotAssetsDao.searchAllotAssetsByPage(searchParams, orderBy);
            QueryRespBean<AllotAssetsDTO> queryRespBean = new QueryRespBean<AllotAssetsDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            LOGGER.error("searchAllotAssetsByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件or查询的分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AllotAssetsDTO>
     * @throws Exception
     */
    public QueryRespBean<AllotAssetsDTO> searchAllotAssetsByPageOr(QueryReqBean<AllotAssetsDTO> queryReqBean,
                                                                   String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AllotAssetsDTO searchParams = queryReqBean.getSearchParams();
            Page<AllotAssetsDTO> dataList = allotAssetsDao.searchAllotAssetsByPageOr(searchParams, orderBy);
            QueryRespBean<AllotAssetsDTO> queryRespBean = new QueryRespBean<AllotAssetsDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            LOGGER.error("searchAllotAssetsByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return AllotAssetsDTO
     * @throws Exception
     */
    public AllotAssetsDTO queryAllotAssetsByPrimaryKey(String id) throws Exception {
        try {
            AllotAssetsDTO dto = allotAssetsDao.findAllotAssetsById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            LOGGER.error("queryAllotAssetsByPrimaryKey出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过父键查询单条记录
     *
     * @param pid 父id
     * @return List<AllotAssetsDTO>
     * @throws Exception
     */
    public List<AllotAssetsDTO> queryAllotAssetsByPid(String pid) throws Exception {
        try {
            List<AllotAssetsDTO> dto = allotAssetsDao.findAllotAssetsByPid(pid);
            return dto;
        } catch (Exception e) {
            LOGGER.error("queryAllotAssetsByPid出错：", e);
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
    public String insertAllotAssets(AllotAssetsDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            allotAssetsDao.insertAllotAssets(dto);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            LOGGER.error("insertAllotAssets出错：", e);
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
    public int insertAllotAssetsList(List<AllotAssetsDTO> dtoList, String pid) throws Exception {
        List<AllotAssetsDTO> beanList = new ArrayList<AllotAssetsDTO>();
        for (AllotAssetsDTO dto : dtoList) {
            String id = ComUtil.getId();
            dto.setId(id);
            dto.setAllotProcId(pid);
            PojoUtil.setSysProperties(dto, OpType.insert);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            beanList.add(dto);
        }
        try {
            return allotAssetsDao.insertAllotAssetsList(beanList);
        } catch (Exception e) {
            LOGGER.error("insertAllotAssetsList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 新增或修改对象
     *
     * @param dtos 对象集合
     * @return void
     * @throws Exception
     */
    public void insertOrUpdateAllotAssets(List<AllotAssetsDTO> dtos, String pid) throws Exception {
        for (AllotAssetsDTO dto : dtos) {
            if ("".equals(dto.getId()) || null == dto.getId()) {
                dto.setAllotProcId(pid);
                this.insertAllotAssets(dto);
            } else {
                this.updateAllotAssets(dto);
            }
        }
    }

    /**
     * 修改对象全部字段
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateAllotAssets(AllotAssetsDTO dto) throws Exception {
        try {
            //记录日志
            AllotAssetsDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = allotAssetsDao.updateAllotAssetsAll(old);
//            if (count == 0) {
//                throw new DaoException("数据失效，请重新更新");
//            }
            return count;
        } catch (Exception e) {
            LOGGER.error("updateAllotAssets出错：", e);
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
    public int updateAllotAssetsSensitive(AllotAssetsDTO dto) throws Exception {
        try {
            //记录日志
            AllotAssetsDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = allotAssetsDao.updateAllotAssetsSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            LOGGER.error("updateAllotAssetsSensitive出错：", e);
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
    public int updateAllotAssetsList(List<AllotAssetsDTO> dtoList) throws Exception {
        try {
            return allotAssetsDao.updateAllotAssetsList(dtoList);
        } catch (Exception e) {
            LOGGER.error("updateAllotAssetsList出错：", e);
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
    public int deleteAllotAssetsById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            //记录日志
            AllotAssetsDTO obje = findById(id);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return allotAssetsDao.deleteAllotAssetsById(id);
        } catch (Exception e) {
            LOGGER.error("deleteAllotAssetsById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件删除数据
     *
     * @param dto 对象条件
     * @return int
     * @throws Exception
     */
    public int deleteAllotAssets(AllotAssetsDTO dto) throws Exception {
        try {
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Delete(dto);
            }
            return allotAssetsDao.deleteAllotAssetsById(dto.getId());
        } catch (Exception e) {
            LOGGER.error("deleteAllotAssets出错：", e);
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
    public int deleteAllotAssetsByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteAllotAssetsById(id);
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
    public int deleteAllotAssetsList(List<String> idList) throws Exception {
        try {
            return allotAssetsDao.deleteAllotAssetsList(idList);
        } catch (Exception e) {
            LOGGER.error("deleteAllotAssetsList出错：", e);
            throw e;
        }
    }

    /**
     * 日志专用，内部方法，不再记录日志
     *
     * @param id 主键id
     * @return AllotAssetsDTO
     * @throws Exception
     */
    private AllotAssetsDTO findById(String id) throws Exception {
        try {
            AllotAssetsDTO dto = allotAssetsDao.findAllotAssetsById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            LOGGER.error("findById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

}
