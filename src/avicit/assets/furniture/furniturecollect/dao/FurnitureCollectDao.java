package avicit.assets.furniture.furniturecollect.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyDTO;
import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectDTO;
import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectTreeDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-11 11:13
 * @类说明：请填写 @修改记录：
 */
@MyBatisRepository
public interface FurnitureCollectDao {

    /**
     * 根据用户id获取其收藏
     *
     * @param userId 用户id
     * @return List<FurnitureCollectctTreeDTO>
     * @throws Exception
     */
    public List<FurnitureCollectTreeDTO> getMyCollectList(@Param("userId") String userId);

    /**
     * 主键查询对象 USER_COLLECT
     *
     * @return FurnitureCollectDTO
     * @param：userId(用户id)、nodeId(节点id)
     */
    public FurnitureCollectDTO findUserCollectById(@Param("userId") String userId, @Param("nodeId") String nodeId);

    /**
     * 根据父节点id获取其排序最后一个直接子节点
     *
     * @param parentId 父节点id
     * @return List<NationalClassifyDTO>
     * @throws Exception
     */
    public List<FurnitureCollectDTO> getLastChildNodeByPID(@Param("userId") String userId, @Param("parentId") String parentId);

    /**
     * 新增USER_COLLECT
     *
     * @param userCollectDTO 保存对象
     * @return int
     */
    public int insertUserCollect(FurnitureCollectDTO userCollectDTO);

    /**
     * 批量新增 USER_COLLECT
     *
     * @param userCollectDTOList 保存对象集合
     * @return int
     */
    public int insertUserCollectList(List<FurnitureCollectDTO> userCollectDTOList);

    /**
     * 更新部分对象 USER_COLLECT
     *
     * @param userCollectDTO 更新对象
     * @return int
     */
    public int updateUserCollect(FurnitureCollectDTO userCollectDTO);

    /**
     * 按主键删除 USER_COLLECT
     *
     * @return int
     * @param：userId(用户id)、nodeId(节点id)
     */
    public int deleteUserCollectById(@Param("userId") String userId, @Param("nodeId") String nodeId);
}
