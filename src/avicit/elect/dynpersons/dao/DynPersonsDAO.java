package avicit.elect.dynpersons.dao;

import java.util.List;

import avicit.assets.assetsattachment.dto.GetPersonDTO;
import avicit.assets.assetsattachment.dto.PersonLogVo;
import avicit.assets.assetsattachment.dto.PersonTotalVo;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.elect.dynpersons.dto.DynPersonsDTO;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:05
 * @类说明：候选人表Dao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynPersonsDAO {

	/**
	* 分页查询
	* @param dynPersonsDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynPersonsDTO>
	*/
	public Page<DynPersonsDTO> searchDynPersonsByPage(@Param("bean") DynPersonsDTO dynPersonsDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynPersonsDTO 查询对象
	* @return List<DynPersonsDTO>
	*/
	public List<DynPersonsDTO> searchDynPersons(@Param("bean") DynPersonsDTO dynPersonsDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynPersonsDTO
	 */
	public DynPersonsDTO findDynPersonsById(String id);

	/**
	* 新增
	* @param dynPersonsDTO 保存对象
	* @return int
	*/
	public int insertDynPersons(DynPersonsDTO dynPersonsDTO);

	/**
	 * 批量新增
	 * @param dynPersonsDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynPersonsList(List<DynPersonsDTO> dynPersonsDTOList);

	/**
	 * 部分更新
	 * @param dynPersonsDTO 更新对象
	 * @return int
	 */
	public int updateDynPersonsSensitive(DynPersonsDTO dynPersonsDTO);

	/**
	 * 全部更新
	 * @param dynPersonsDTO 更新对象
	 * @return int
	 */
	public int updateDynPersonsAll(DynPersonsDTO dynPersonsDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynPersonsList(@Param("dtoList") List<DynPersonsDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynPersonsById(String id);

	/**
	 * 根据排序查询
	 * @param getPersonDTO 查询对象
	 * @return List<DynPersonsDTO>
	 */
	public List<PersonLogVo> searchDynPersonsBySort(@Param("bean")GetPersonDTO getPersonDTO);

	public int searchByElectID(String electId);

	public List<PersonTotalVo> searchPersonsTotalGroupByDept();

	public List<PersonTotalVo> searchPersonsTotalGroupByMajor();
}

