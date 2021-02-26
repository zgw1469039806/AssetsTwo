package avicit.assets.furniture.assetsfurniturerecoveryproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoveryProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-18 08:50
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureRecoveryProcDao {

	/**
	* 分页查询  家具回收
	* @param assetsFurnitureRecoveryProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureRecoveryProcDTO>
	*/
	public Page<AssetsFurnitureRecoveryProcDTO> searchAssetsFurnitureRecoveryProcByPage(
            @Param("bean") AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 家具回收
	* @param assetsFurnitureRecoveryProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureRecoveryProcDTO>
	*/
	public Page<AssetsFurnitureRecoveryProcDTO> searchAssetsFurnitureRecoveryProcByPageOr(
            @Param("bean") AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 查询 家具回收
	* @param assetsFurnitureRecoveryProcDTO 查询对象
	* @return List<AssetsFurnitureRecoveryProcDTO>
	*/
	public List<AssetsFurnitureRecoveryProcDTO> searchAssetsFurnitureRecoveryProc(
            AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO);

	/**
	 * 查询 家具回收
	 * @param id 主键id
	 * @return AssetsFurnitureRecoveryProcDTO
	 */
	public AssetsFurnitureRecoveryProcDTO findAssetsFurnitureRecoveryProcById(String id);

	/**
	 * 新增家具回收
	 * @param assetsFurnitureRecoveryProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureRecoveryProc(AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO);

	/**
	 * 批量新增 家具回收
	 * @param assetsFurnitureRecoveryProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureRecoveryProcList(
            List<AssetsFurnitureRecoveryProcDTO> assetsFurnitureRecoveryProcDTOList);

	/**
	* 更新部分对象 家具回收
	* @param assetsFurnitureRecoveryProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureRecoveryProcSensitive(
            AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO);

	/**
	 * 更新全部对象 家具回收
	 * @param assetsFurnitureRecoveryProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRecoveryProcAll(AssetsFurnitureRecoveryProcDTO assetsFurnitureRecoveryProcDTO);

	/**
	 * 批量更新对象 家具回收
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureRecoveryProcList(@Param("dtoList") List<AssetsFurnitureRecoveryProcDTO> dtoList);

	/**
	 * 按主键删除 家具回收
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureRecoveryProcById(String id);

	/**
	 * 按主键批量删除 家具回收
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureRecoveryProcList(List<String> idList);
}
