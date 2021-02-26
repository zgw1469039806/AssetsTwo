package avicit.elect.dynelectlog.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.elect.dynelectlog.dto.DynElectLogDTO;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:36
 * @类说明：选举记录表Dao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynElectLogDAO {

	/**
	* 分页查询
	* @param dynElectLogDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynElectLogDTO>
	*/
	public Page<DynElectLogDTO> searchDynElectLogByPage(@Param("bean") DynElectLogDTO dynElectLogDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynElectLogDTO 查询对象
	* @return List<DynElectLogDTO>
	*/
	public List<DynElectLogDTO> searchDynElectLog(@Param("bean") DynElectLogDTO dynElectLogDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectLogDTO
	 */
	public DynElectLogDTO findDynElectLogById(String id);

	/**
	* 新增
	* @param dynElectLogDTO 保存对象
	* @return int
	*/
	public int insertDynElectLog(DynElectLogDTO dynElectLogDTO);

	/**
	 * 批量新增
	 * @param dynElectLogDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynElectLogList(@Param("dtoList") List<DynElectLogDTO> dynElectLogDTOList);

	/**
	 * 部分更新
	 * @param dynElectLogDTO 更新对象
	 * @return int
	 */
	public int updateDynElectLogSensitive(DynElectLogDTO dynElectLogDTO);

	/**
	 * 全部更新
	 * @param dynElectLogDTO 更新对象
	 * @return int
	 */
	public int updateDynElectLogAll(DynElectLogDTO dynElectLogDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynElectLogList(@Param("dtoList") List<DynElectLogDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynElectLogById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	//public int deleteDynElectLogList(List<String> idList);

	public Integer searchByElectId(String electId);
}

