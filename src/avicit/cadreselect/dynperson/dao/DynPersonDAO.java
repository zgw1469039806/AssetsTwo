package avicit.cadreselect.dynperson.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.cadreselect.dynperson.dto.DynPersonDTO;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 11:44
 * @类说明：DYN_PERSONDao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynPersonDAO {

	/**
	* 分页查询
	* @param dynPersonDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynPersonDTO>
	*/
	public Page<DynPersonDTO> searchDynPersonByPage(@Param("bean") DynPersonDTO dynPersonDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynPersonDTO 查询对象
	* @return List<DynPersonDTO>
	*/
	public List<DynPersonDTO> searchDynPerson(@Param("bean") DynPersonDTO dynPersonDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynPersonDTO
	 */
	public DynPersonDTO findDynPersonById(String id);

	/**
	* 新增
	* @param dynPersonDTO 保存对象
	* @return int
	*/
	public int insertDynPerson(DynPersonDTO dynPersonDTO);

	/**
	 * 批量新增
	 * @param dynPersonDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynPersonList(List<DynPersonDTO> dynPersonDTOList);

	/**
	 * 部分更新
	 * @param dynPersonDTO 更新对象
	 * @return int
	 */
	public int updateDynPersonSensitive(DynPersonDTO dynPersonDTO);

	/**
	 * 全部更新
	 * @param dynPersonDTO 更新对象
	 * @return int
	 */
	public int updateDynPersonAll(DynPersonDTO dynPersonDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynPersonList(@Param("dtoList") List<DynPersonDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynPersonById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynPersonList(List<String> idList);
}

