package avicit.cadreselect.dyntemitem.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:54
 * @类说明：DYN_TEM_ITEMDao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynTemItemDAO {

	/**
	* 分页查询
	* @param dynTemItemDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynTemItemDTO>
	*/
	public Page<DynTemItemDTO> searchDynTemItemByPage(@Param("bean") DynTemItemDTO dynTemItemDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynTemItemDTO 查询对象
	* @return List<DynTemItemDTO>
	*/
	public List<DynTemItemDTO> searchDynTemItem(@Param("bean") DynTemItemDTO dynTemItemDTO);


	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynTemItemDTO
	 */
	public DynTemItemDTO findDynTemItemById(String id);

	/**
	* 新增
	* @param dynTemItemDTO 保存对象
	* @return int
	*/
	public int insertDynTemItem(DynTemItemDTO dynTemItemDTO);

	/**
	 * 批量新增
	 * @param dynTemItemDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynTemItemList(List<DynTemItemDTO> dynTemItemDTOList);

	/**
	 * 部分更新
	 * @param dynTemItemDTO 更新对象
	 * @return int
	 */
	public int updateDynTemItemSensitive(DynTemItemDTO dynTemItemDTO);

	/**
	 * 全部更新
	 * @param dynTemItemDTO 更新对象
	 * @return int
	 */
	public int updateDynTemItemAll(DynTemItemDTO dynTemItemDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynTemItemList(@Param("dtoList") List<DynTemItemDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynTemItemById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynTemItemList(List<String> idList);
}

