package avicit.assets.device.assetstechtransformproject.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import avicit.assets.device.assetstechtransformproject.dao.AssetsTechTransformPersonDao;
import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformPersonDTO;
import avicit.platform6.core.mybatis.pagehelper.Page;
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
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-09 10:25
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsTechTransformPersonService implements Serializable {

    private static final Logger logger = LoggerFactory.getLogger(AssetsTechTransformPersonService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private AssetsTechTransformPersonDao assetsTechTransformPersonDao;

    /**
     * 按条件分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsTechTransformPersonDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsTechTransformPersonDTO> searchAssetsTechTransformPersonByPage(
            QueryReqBean<AssetsTechTransformPersonDTO> queryReqBean, String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsTechTransformPersonDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsTechTransformPersonDTO> dataList = assetsTechTransformPersonDao
                    .searchAssetsTechTransformPersonByPage(searchParams, orderBy);
            QueryRespBean<AssetsTechTransformPersonDTO> queryRespBean = new QueryRespBean<AssetsTechTransformPersonDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsTechTransformPersonByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件or查询的分页查询
     *
     * @param queryReqBean 分页
     * @param orderBy      排序
     * @return QueryRespBean<AssetsTechTransformPersonDTO>
     * @throws Exception
     */
    public QueryRespBean<AssetsTechTransformPersonDTO> searchAssetsTechTransformPersonByPageOr(
            QueryReqBean<AssetsTechTransformPersonDTO> queryReqBean, String orderBy) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            AssetsTechTransformPersonDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsTechTransformPersonDTO> dataList = assetsTechTransformPersonDao
                    .searchAssetsTechTransformPersonByPageOr(searchParams, orderBy);
            QueryRespBean<AssetsTechTransformPersonDTO> queryRespBean = new QueryRespBean<AssetsTechTransformPersonDTO>();

            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            logger.error("searchAssetsTechTransformPersonByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按条件查询
     *
     * @param queryReqBean 条件
     * @return List<AssetsTechTransformPersonDTO>
     * @throws Exception
     */
    public List<AssetsTechTransformPersonDTO> searchAssetsTechTransformPerson(
            QueryReqBean<AssetsTechTransformPersonDTO> queryReqBean) throws Exception {
        try {
            AssetsTechTransformPersonDTO searchParams = queryReqBean.getSearchParams();
            List<AssetsTechTransformPersonDTO> dataList = assetsTechTransformPersonDao
                    .searchAssetsTechTransformPerson(searchParams);
            return dataList;
        } catch (Exception e) {
            logger.error("searchAssetsTechTransformPerson出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     *
     * @param id 主键id
     * @return AssetsTechTransformPersonDTO
     * @throws Exception
     */
    public AssetsTechTransformPersonDTO queryAssetsTechTransformPersonByPrimaryKey(String id) throws Exception {
        try {
            AssetsTechTransformPersonDTO dto = assetsTechTransformPersonDao.findAssetsTechTransformPersonById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            logger.error("queryAssetsTechTransformPersonByPrimaryKey出错：", e);
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
    public String insertAssetsTechTransformPerson(AssetsTechTransformPersonDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            assetsTechTransformPersonDao.insertAssetsTechTransformPerson(dto);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            logger.error("insertAssetsTechTransformPerson出错：", e);
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
    public int insertAssetsTechTransformPersonList(List<AssetsTechTransformPersonDTO> dtoList) throws Exception {
        List<AssetsTechTransformPersonDTO> beanList = new ArrayList<AssetsTechTransformPersonDTO>();
        for (AssetsTechTransformPersonDTO dto : dtoList) {
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
            return assetsTechTransformPersonDao.insertAssetsTechTransformPersonList(beanList);
        } catch (Exception e) {
            logger.error("insertAssetsTechTransformPersonList出错：", e);
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
    public int updateAssetsTechTransformPerson(AssetsTechTransformPersonDTO dto) throws Exception {
        //记录日志
        AssetsTechTransformPersonDTO old = findById(dto.getId());
        if (old != null) {
            SysLogUtil.log4Update(dto, old);
        }
        PojoUtil.setSysProperties(dto, OpType.update);
        PojoUtil.copyProperties(old, dto, true);
        int ret = assetsTechTransformPersonDao.updateAssetsTechTransformPersonAll(old);
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
    public int updateAssetsTechTransformPersonSensitive(AssetsTechTransformPersonDTO dto) throws Exception {
        try {
            //记录日志
            AssetsTechTransformPersonDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = assetsTechTransformPersonDao.updateAssetsTechTransformPersonSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            logger.error("updateAssetsTechTransformPersonSensitive出错：", e);
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
    public int updateAssetsTechTransformPersonList(List<AssetsTechTransformPersonDTO> dtoList) throws Exception {
        try {
            return assetsTechTransformPersonDao.updateAssetsTechTransformPersonList(dtoList);
        } catch (Exception e) {
            logger.error("updateAssetsTechTransformPersonList出错：", e);
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
    public int deleteAssetsTechTransformPersonById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            //记录日志
            AssetsTechTransformPersonDTO obje = findById(id);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return assetsTechTransformPersonDao.deleteAssetsTechTransformPersonById(id);
        } catch (Exception e) {
            logger.error("deleteAssetsTechTransformPersonById出错：", e);
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
    public int deleteAssetsTechTransformPersonByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteAssetsTechTransformPersonById(id);
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
    public int deleteAssetsTechTransformPersonList(List<String> idList) throws Exception {
        try {
            return assetsTechTransformPersonDao.deleteAssetsTechTransformPersonList(idList);
        } catch (Exception e) {
            logger.error("deleteAssetsTechTransformPersonList出错：", e);
            throw e;
        }
    }

    /**
     * 按技改项目id批量删除 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param projectId 技改项目id
     * @return int
     * @throws Exception
     */
    public int deleteAssetsTechTransformPersonByProjectId(String projectId) throws Exception {
        if (StringUtils.isEmpty(projectId)) {
            throw new Exception("删除失败！传入的技改项目id为null");
        }
        try {
            return assetsTechTransformPersonDao.deleteAssetsTechTransformPersonByProjectId(projectId);
        } catch (Exception e) {
            logger.error("deleteAssetsTechTransformPersonByProjectId出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 日志专用，内部方法，不再记录日志
     *
     * @param id 主键id
     * @return AssetsTechTransformPersonDTO
     * @throws Exception
     */
    private AssetsTechTransformPersonDTO findById(String id) throws Exception {
        try {
            AssetsTechTransformPersonDTO dto = assetsTechTransformPersonDao.findAssetsTechTransformPersonById(id);
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
}

