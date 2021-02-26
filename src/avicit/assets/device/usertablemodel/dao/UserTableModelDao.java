package avicit.assets.device.usertablemodel.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.assets.device.usertablemodel.dto.UserTableModelDTO;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 10:01
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface UserTableModelDao {
    /**
     * 分页查询  USER_TABLE_MODEL
     * @param userTableModelDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<UserTableModelDTO>
     */
    public Page<UserTableModelDTO> searchUserTableModelByPage(@Param("bean") UserTableModelDTO userTableModelDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 USER_TABLE_MODEL
     * @param userTableModelDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<UserTableModelDTO>
     */
    public Page<UserTableModelDTO> searchUserTableModelByPageOr(@Param("bean") UserTableModelDTO userTableModelDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询USER_TABLE_MODEL
     * @param userId(用户id)、belongTable(所属表)、viewName(视图名称)、isValid(是否可用)
     * @return List<UserTableModelDTO>
     */
    public List<UserTableModelDTO> searchUserTableModel(@Param("userId") String userId, @Param("belongTable") String belongTable, @Param("viewName") String viewName, @Param("isValid") String isValid);

    /**
     * 查询 USER_TABLE_MODEL
     * @param id 主键id
     * @return UserTableModelDTO
     */
    public UserTableModelDTO findUserTableModelById(String id);

    /**
     * 新增USER_TABLE_MODEL
     * @param userTableModelDTO 保存对象
     * @return int
     */
    public int insertUserTableModel(UserTableModelDTO userTableModelDTO);

    /**
     * 批量新增 USER_TABLE_MODEL
     * @param userTableModelDTOList 保存对象集合
     * @return int
     */
    public int insertUserTableModelList(List<UserTableModelDTO> userTableModelDTOList);

    /**
     * 按主键删除 USER_TABLE_MODEL
     * @param id 主键id
     * @return int
     */
    public int deleteUserTableModelById(String id);

    /**
     * 根据“用户id”、“所属表”、“视图名称”批量删除数据
     * @param userId(用户id)、belongTable(所属表)、viewName(视图名称)
     * @return int
     */
    public int deleteUserTableModelList(@Param("userId") String userId, @Param("belongTable") String belongTable, @Param("viewName") String viewName);

    /**
     * 根据用户id、所属表获取用户拥有的该表的视图
     * @param userId(用户id)、belongTable(所属表)
     * @return List<String>
     * @throws Exception
     */
    public List<String> getUserViewList(@Param("userId") String userId, @Param("belongTable") String belongTable);
}
