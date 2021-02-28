package avicit.cadreselect.dynvote.dao;

import java.util.List;
import java.util.Map;

import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;
import avicit.cadreselect.dyntemplate.dto.PrintingDTO;
import avicit.cadreselect.dyntemplate.dto.QueryDetailsDTO;
import avicit.cadreselect.dynvote.bo.SendVoteBO;
import avicit.cadreselect.dynvote.dto.QueryVoteByIdDTO;
import avicit.cadreselect.dynvote.dto.VoteItem;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.cadreselect.dynvote.dto.DynVoteDTO;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:58
 * @类说明：DYN_VOTEDao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynVoteDAO {

	/**
	* 分页查询
	* @param dynVoteDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynVoteDTO>
	*/
	public Page<DynVoteDTO> searchDynVoteByPage(@Param("bean") DynVoteDTO dynVoteDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynVoteDTO 查询对象
	* @return List<DynVoteDTO>
	*/
	public List<DynVoteDTO> searchDynVote(@Param("bean") DynVoteDTO dynVoteDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynVoteDTO
	 */
	public DynVoteDTO findDynVoteById(String id);

	/**
	* 新增
	* @param dynVoteDTO 保存对象
	* @return int
	*/
	public int insertDynVote(DynVoteDTO dynVoteDTO);

	/**
	 * 批量新增
	 * @param dynVoteDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynVoteList(List<DynVoteDTO> dynVoteDTOList);

	/**
	 * 部分更新
	 * @param dynVoteDTO 更新对象
	 * @return int
	 */
	public int updateDynVoteSensitive(DynVoteDTO dynVoteDTO);

	/**
	 * 全部更新
	 * @param dynVoteDTO 更新对象
	 * @return int
	 */
	public int updateDynVoteAll(DynVoteDTO dynVoteDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynVoteList(@Param("dtoList") List<DynVoteDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynVoteById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynVoteList(List<String> idList);

	/**
	 * 根据扫码id查询投票信息
	 * @param id
	 * @return
	 */
	QueryVoteByIdDTO queryVoteById(String id);

	/**
	 * 候选人投票
	 * @param bo
	 */
	void sendVote(@Param("bo") SendVoteBO bo);

	/**
	 * 推荐人投票
	 * @param bo
	 */
	Map<String,String> queryItemByName(@Param("bo") VoteItem bo);

	/**
	 * 推荐人投票
	 * @param bo
	 */
	void sendVoteRecommends(@Param("bo") VoteItem bo);

	/**
	 * 存储候选人
	 * @param i
	 */
	void sendTemItem(@Param("bo") VoteItem i,@Param("name")String name);

	/**
	 * 查询详情
	 * @param id
	 * @return
	 */
	QueryDetailsDTO queryDetails(@Param("id") String id);

	PrintingDTO printing(@Param("id") String id);

	int findByVoteId(@Param("id") String id);
}

