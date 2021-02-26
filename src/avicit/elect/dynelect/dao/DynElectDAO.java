package avicit.elect.dynelect.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.elect.dynelect.dto.DynElectDTO;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:18
 * @类说明：
 * @修改记录： 
 */
@MyBatisRepository
public interface DynElectDAO {

	/**
	* 分页查询
	* @param dynElectDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynElectDTO>
	*/
	public Page<DynElectDTO> searchDynElectByPage(@Param("bean") DynElectDTO dynElectDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynElectDTO 查询对象
	* @return List<DynElectDTO>
	*/
	public List<DynElectDTO> searchDynElect(@Param("bean") DynElectDTO dynElectDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectDTO
	 */
	public DynElectDTO findDynElectById(String id);

	/**
	* 新增
	* @param dynElectDTO 保存对象
	* @return int
	*/
	public int insertDynElect(DynElectDTO dynElectDTO);

	/**
	 * 批量新增
	 * @param dynElectDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynElectList(List<DynElectDTO> dynElectDTOList);

	/**
	 * 部分更新
	 * @param dynElectDTO 更新对象
	 * @return int
	 */
	public int updateDynElectSensitive(DynElectDTO dynElectDTO);

	/**
	 * 全部更新
	 * @param dynElectDTO 更新对象
	 * @return int
	 */
	public int updateDynElectAll(DynElectDTO dynElectDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynElectList(@Param("dtoList") List<DynElectDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynElectById(String id);

	public  int updateDynElectInvestNum(String id);

	public List<DynElectDTO> getCurrentElectDTO();

	public List<DynElectDTO> searchDynElectByStatus();
}

