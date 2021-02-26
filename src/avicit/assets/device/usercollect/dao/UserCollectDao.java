package avicit.assets.device.usercollect.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.nationalclassify.dto.NationalClassifyDTO;
import avicit.assets.device.usercollect.dto.UserCollectDTO;
import avicit.assets.device.usercollect.dto.UserCollectTreeDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-11 11:13
 * @类说明：请填写 @修改记录：
 */
@MyBatisRepository
public interface UserCollectDao {
	
	/**
	 * 根据用户id获取其收藏
	 * @param userId 用户id
	 * @return List<UserCollectTreeDTO>
	 * @throws Exception
	 */
	public List<UserCollectTreeDTO> getMyCollectList(@Param("userId")String userId);

	/**
	 * 主键查询对象 USER_COLLECT
	 * @param：userId(用户id)、nodeId(节点id)
	 * @return UserCollectDTO
	 */
	public UserCollectDTO findUserCollectById(@Param("userId")String userId, @Param("nodeId")String nodeId);
	
	/**
	 * 根据父节点id获取其排序最后一个直接子节点
	 * @param parentId 父节点id
	 * @return List<NationalClassifyDTO>
	 * @throws Exception
	 */
	public List<UserCollectDTO> getLastChildNodeByPID(@Param("userId")String userId, @Param("parentId")String parentId);

	/**
	 * 新增USER_COLLECT
	 * @param userCollectDTO   保存对象
	 * @return int
	 */
	public int insertUserCollect(UserCollectDTO userCollectDTO);

	/**
	 * 批量新增 USER_COLLECT
	 * @param userCollectDTOList   保存对象集合
	 * @return int
	 */
	public int insertUserCollectList(List<UserCollectDTO> userCollectDTOList);

	/**
	 * 更新部分对象 USER_COLLECT
	 * @param userCollectDTO  更新对象
	 * @return int
	 */
	public int updateUserCollect(UserCollectDTO userCollectDTO);

	/**
	 * 按主键删除 USER_COLLECT
	 * @param：userId(用户id)、nodeId(节点id)
	 * @return int
	 */
	public int deleteUserCollectById(@Param("userId")String userId, @Param("nodeId")String nodeId);
}
