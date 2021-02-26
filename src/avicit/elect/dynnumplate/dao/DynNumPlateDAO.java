package avicit.elect.dynnumplate.dao;

import java.math.BigDecimal;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.elect.dynnumplate.dto.DynNumPlateDTO;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 09:30
 * @类说明：号码牌表Dao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynNumPlateDAO {

	/**
	* 分页查询
	* @param dynNumPlateDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynNumPlateDTO>
	*/
	public Page<DynNumPlateDTO> searchDynNumPlateByPage(@Param("bean") DynNumPlateDTO dynNumPlateDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynNumPlateDTO 查询对象
	* @return List<DynNumPlateDTO>
	*/
	public List<DynNumPlateDTO> searchDynNumPlate(@Param("bean") DynNumPlateDTO dynNumPlateDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynNumPlateDTO
	 */
	public DynNumPlateDTO findDynNumPlateById(String id);

	/**
	* 新增
	* @param dynNumPlateDTO 保存对象
	* @return int
	*/
	public int insertDynNumPlate(DynNumPlateDTO dynNumPlateDTO);

	/**
	 * 批量新增
	 * @param dynNumPlateDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynNumPlateList(List<DynNumPlateDTO> dynNumPlateDTOList);

	/**
	 * 部分更新
	 * @param dynNumPlateDTO 更新对象
	 * @return int
	 */
	public int updateDynNumPlateSensitive(DynNumPlateDTO dynNumPlateDTO);

	/**
	 * 全部更新
	 * @param dynNumPlateDTO 更新对象
	 * @return int
	 */
	public int updateDynNumPlateAll(DynNumPlateDTO dynNumPlateDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynNumPlateList(@Param("dtoList") List<DynNumPlateDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynNumPlateById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynNumPlateList(List<String> idList);

	public int searchLoginNum(String loginStatus);

	/*修改所有号码牌的登录状态*/
	public int updateAllDynNumPlateLoginStatus(String status);

	public int updateNumPlateLoginStatus(@Param("id") String id, @Param("maxCtn") BigDecimal maxCtn);
}

