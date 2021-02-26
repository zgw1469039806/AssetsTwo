package avicit.assets.device.dynassetsreconst.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynassetsreconst.dto.DynAssetsReconstDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:03
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DynAssetsReconstDao {

	/**
	* 分页查询  DYN_ASSETS_RECONST
	* @param dynAssetsReconstDTO 查询对象
	* @param orgIdentity 组织id
	* @param orderBy 排序条件
	* @return Page<DynAssetsReconstDTO>
	*/
	public Page<DynAssetsReconstDTO> searchDynAssetsReconstByPage(
            @Param("bean") DynAssetsReconstDTO dynAssetsReconstDTO, @Param("org") String orgIdentity,
            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 DYN_ASSETS_RECONST
	* @param dynAssetsReconstDTO 查询对象
	* @param orgIdentity 组织id
	* @param orderBy 排序条件
	* @return Page<DynAssetsReconstDTO>
	*/
	public Page<DynAssetsReconstDTO> searchDynAssetsReconstByPageOr(
            @Param("bean") DynAssetsReconstDTO dynAssetsReconstDTO, @Param("org") String orgIdentity,
            @Param("pOrderBy") String orderBy);

	/**
	* 查询 DYN_ASSETS_RECONST
	* @param dynAssetsReconstDTO 查询对象
	* @return List<DynAssetsReconstDTO>
	*/
	public List<DynAssetsReconstDTO> searchDynAssetsReconst(DynAssetsReconstDTO dynAssetsReconstDTO);

	/**
	 * 查询 DYN_ASSETS_RECONST
	 * @param id 主键id
	 * @return DynAssetsReconstDTO
	 */
	public DynAssetsReconstDTO findDynAssetsReconstById(String id);

	/**
	 * 新增DYN_ASSETS_RECONST
	 * @param dynAssetsReconstDTO 保存对象
	 * @return int
	 */
	public int insertDynAssetsReconst(DynAssetsReconstDTO dynAssetsReconstDTO);

	/**
	 * 批量新增 DYN_ASSETS_RECONST
	 * @param dynAssetsReconstDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynAssetsReconstList(List<DynAssetsReconstDTO> dynAssetsReconstDTOList);

	/**
	* 更新部分对象 DYN_ASSETS_RECONST
	* @param dynAssetsReconstDTO 更新对象
	* @return int
	*/
	public int updateDynAssetsReconstSensitive(DynAssetsReconstDTO dynAssetsReconstDTO);

	/**
	 * 更新全部对象 DYN_ASSETS_RECONST
	 * @param dynAssetsReconstDTO 更新对象
	 * @return int
	 */
	public int updateDynAssetsReconstAll(DynAssetsReconstDTO dynAssetsReconstDTO);

	/**
	 * 批量更新对象 DYN_ASSETS_RECONST
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynAssetsReconstList(@Param("dtoList") List<DynAssetsReconstDTO> dtoList);

	/**
	 * 按主键删除 DYN_ASSETS_RECONST
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynAssetsReconstById(String id);

	/**
	 * 按主键批量删除 DYN_ASSETS_RECONST
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynAssetsReconstList(List<String> idList);
}
