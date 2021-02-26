package avicit.elect.dynelectperson.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.elect.dynelectperson.dto.DynElectPersonDTO;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:18
 * @类说明：
 * @修改记录： 
 */
@MyBatisRepository
public interface DynElectPersonDAO {

	/**
	* 分页查询
	* @param dynElectPersonDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynElectPersonDTO>
	*/
	public Page<DynElectPersonDTO> searchDynElectPersonByPage(@Param("bean") DynElectPersonDTO dynElectPersonDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynElectPersonDTO 查询对象
	* @return List<DynElectPersonDTO>
	*/
	public List<DynElectPersonDTO> searchDynElectPerson(@Param("bean") DynElectPersonDTO dynElectPersonDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectPersonDTO
	 */
	public DynElectPersonDTO findDynElectPersonById(String id);

	/**
	* 新增
	* @param dynElectPersonDTO 保存对象
	* @return int
	*/
	public int insertDynElectPerson(DynElectPersonDTO dynElectPersonDTO);

	/**
	 * 批量新增
	 * @param dynElectPersonDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynElectPersonList(List<DynElectPersonDTO> dynElectPersonDTOList);

	/**
	 * 部分更新
	 * @param dynElectPersonDTO 更新对象
	 * @return int
	 */
	public int updateDynElectPersonSensitive(DynElectPersonDTO dynElectPersonDTO);

	/**
	 * 全部更新
	 * @param dynElectPersonDTO 更新对象
	 * @return int
	 */
	public int updateDynElectPersonAll(DynElectPersonDTO dynElectPersonDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynElectPersonList(@Param("dtoList") List<DynElectPersonDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynElectPersonById(String id);

	public int queryEPNum();

	/**
	 * 通过活动ID取得当前候选人
	 *
	 * @param electId
	 * @return
	 */
	public List<DynElectPersonDTO> getElectPersonByElectId(String electId);
}

