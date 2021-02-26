package avicit.assets.furniture.furniturecollect.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.assets.furniture.furniturecollect.dao.FurnitureCollectDao;
import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectDTO;
import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectTreeDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-11 11:13
 * @类说明：请填写 @修改记录：
 */
@Service
public class FurnitureCollectService implements Serializable {

    private static final Logger LOGGER = LoggerFactory.getLogger(FurnitureCollectService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private FurnitureCollectDao furnitureCollectDao;

    /**
     * 根据用户id获取其收藏
     *
     * @param userId 用户id
     * @return List<FurnitureCollectTreeDTO>
     * @throws Exception
     */
    public List<FurnitureCollectTreeDTO> getMyCollectList(String userId) throws Exception {
        try {
            List<FurnitureCollectTreeDTO> dataList = furnitureCollectDao.getMyCollectList(userId);
            return dataList;
        } catch (Exception e) {
            LOGGER.error("getMyCollectList出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 通过主键查询单条记录
     *
     * @return UserCollectDTO
     * @throws Exception
     * @param：userId(用户id)、nodeId(节点id)
     */
    public FurnitureCollectDTO queryUserCollectByPrimaryKey(String userId, String nodeId) throws Exception {
        try {
            FurnitureCollectDTO dto = furnitureCollectDao.findUserCollectById(userId, nodeId);
            // 记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            LOGGER.error("queryUserCollectByPrimaryKey出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 根据父节点id获取其排序最后一个直接子节点
     *
     * @param parentId 父节点id
     * @return UserCollectDTO
     * @throws Exception
     */
    public FurnitureCollectDTO getLastChildNodeByPID(String userId, String parentId) throws Exception {
        try {
            List<FurnitureCollectDTO> dataList = furnitureCollectDao.getLastChildNodeByPID(userId, parentId);

            if ((dataList != null) && (dataList.size() > 0)) {
                return dataList.get(0);
            }
            return null;
        } catch (Exception e) {
            LOGGER.error("getLastChildNodeByPID出错：", e);
            e.printStackTrace();
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
    public String insertUserCollect(FurnitureCollectDTO dto) throws Exception {
        try {
            PojoUtil.setSysProperties(dto, OpType.insert);
            furnitureCollectDao.insertUserCollect(dto);
            // 记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return "Success";
        } catch (Exception e) {
            LOGGER.error("insertUserCollect出错：", e);
            e.printStackTrace();
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
    public int insertUserCollectList(List<FurnitureCollectDTO> dtoList) throws Exception {
        List<FurnitureCollectDTO> demo = new ArrayList<FurnitureCollectDTO>();
        for (FurnitureCollectDTO dto : dtoList) {
            PojoUtil.setSysProperties(dto, OpType.insert);

            // 记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            demo.add(dto);
        }
        try {
            return furnitureCollectDao.insertUserCollectList(demo);
        } catch (Exception e) {
            LOGGER.error("insertUserCollectList出错：", e);
            e.printStackTrace();
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
    public int updateUserCollect(FurnitureCollectDTO dto) throws Exception {
        try {
            // 记录日志
            FurnitureCollectDTO old = findById(dto.getUserId(), dto.getNodeId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = furnitureCollectDao.updateUserCollect(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            LOGGER.error("updateUserCollectSensitive出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 按主键单条删除
     *
     * @return int
     * @throws Exception
     */
    public int deleteUserCollectById(String userId, String nodeId) throws Exception {
        if (StringUtils.isEmpty(userId) || StringUtils.isEmpty(nodeId)) {
            throw new Exception("删除失败！传入的参数主键为null");
        }
        try {
            // 记录日志
            FurnitureCollectDTO obje = findById(userId, nodeId);
            if (obje != null) {
                SysLogUtil.log4Delete(obje);
            }
            return furnitureCollectDao.deleteUserCollectById(userId, nodeId);
        } catch (Exception e) {
            LOGGER.error("deleteUserCollectById出错：", e);
            e.printStackTrace();
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
    public int deleteUserCollectByIds(String[] ids, String userId) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteUserCollectById(userId, id);
            result++;
        }
        return result;
    }

    /**
     * 日志专用，内部方法，不再记录日志
     *
     * @param userId(用户id)、nodeId(节点id)
     * @return UserCollectDTO
     * @throws Exception
     */
    public FurnitureCollectDTO findById(String userId, String nodeId) throws Exception {
        try {
            FurnitureCollectDTO dto = furnitureCollectDao.findUserCollectById(userId, nodeId);

            // 记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            LOGGER.error("findById出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(), e);
        }
    }
}
