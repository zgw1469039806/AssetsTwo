package avicit.assets.device.usertreejson.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.usertreejson.dto.TreeJsonDTO;
import avicit.assets.device.usertreejson.dto.UserTreeJsonDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-05 10:55
 * @类说明：请填写 @修改记录：
 */
@MyBatisRepository
public interface UserTreeJsonDao {

	/**
	 * 分页查询 USER_TREE_JSON
	 * @param userTreeJsonDTO   查询对象
	 * @param orderBy   排序条件
	 * @return Page<UserTreeJsonDTO>
	 */
	public Page<UserTreeJsonDTO> searchUserTreeJsonByPage(@Param("bean") UserTreeJsonDTO userTreeJsonDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 USER_TREE_JSON
	 * @param userTreeJsonDTO   查询对象
	 * @param orderBy   排序条件
	 * @return Page<UserTreeJsonDTO>
	 */
	public Page<UserTreeJsonDTO> searchUserTreeJsonByPageOr(@Param("bean") UserTreeJsonDTO userTreeJsonDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询USER_TREE_JSON
	 * @param userTreeJsonDTO   查询对象
	 * @return List<UserTreeJsonDTO>
	 */
	public List<UserTreeJsonDTO> searchUserTreeJson(UserTreeJsonDTO userTreeJsonDTO);
	
	/**
	 * 通过所属对象的id、所属对象的类型、树对象的表名获取TreeJson
	 * @param：objectId(所属对象的id)、obejctType(所属对象的类型)、treeName(树对象的表名)
	 * @return List<TreeJsonDTO>
	 */
	public List<UserTreeJsonDTO> getTreeJson(@Param("objectId") String objectId, @Param("obejctType") String obejctType, @Param("treeName") String treeName);

	/**
	 * 查询 USER_TREE_JSON
	 * @param id   主键id
	 * @return UserTreeJsonDTO
	 */
	public UserTreeJsonDTO findUserTreeJsonById(String id);

	/**
	 * 新增USER_TREE_JSON
	 * @param userTreeJsonDTO   保存对象
	 * @return int
	 */
	public int insertUserTreeJson(UserTreeJsonDTO userTreeJsonDTO);

	/**
	 * 批量新增 USER_TREE_JSON
	 * @param userTreeJsonDTOList   保存对象集合
	 * @return int
	 */
	public int insertUserTreeJsonList(List<UserTreeJsonDTO> userTreeJsonDTOList);

	/**
	 * 更新部分对象 USER_TREE_JSON
	 * @param userTreeJsonDTO   更新对象
	 * @return int
	 */
	public int updateUserTreeJsonSensitive(UserTreeJsonDTO userTreeJsonDTO);

	/**
	 * 更新全部对象 USER_TREE_JSON
	 * @param userTreeJsonDTO  更新对象
	 * @return int
	 */
	public int updateUserTreeJsonAll(UserTreeJsonDTO userTreeJsonDTO);

	/**
	 * 批量更新对象 USER_TREE_JSON
	 * @param dtoList  批量更新对象集合
	 * @return int
	 */
	public int updateUserTreeJsonList(@Param("dtoList") List<UserTreeJsonDTO> dtoList);

	/**
	 * 按主键删除 USER_TREE_JSON
	 * @param id  主键id
	 * @return int
	 */
	public int deleteUserTreeJsonById(String id);

	/**
	 * 按主键批量删除 USER_TREE_JSON
	 * @param idList  主键集合
	 * @return int
	 */
	public int deleteUserTreeJsonList(List<String> idList);
}
