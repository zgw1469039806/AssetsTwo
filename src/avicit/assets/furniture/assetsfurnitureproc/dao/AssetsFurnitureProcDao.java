package avicit.assets.furniture.assetsfurnitureproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureproc.dto.AssetsFurnitureProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 09:09
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureProcDao {

	/**
	* 分页查询  ASSETS_FURNITURE_PROC
	* @param assetsFurnitureProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureProcDTO>
	*/
	public Page<AssetsFurnitureProcDTO> searchAssetsFurnitureProcByPage(
			@Param("bean") AssetsFurnitureProcDTO assetsFurnitureProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_FURNITURE_PROC
	* @param assetsFurnitureProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureProcDTO>
	*/
	public Page<AssetsFurnitureProcDTO> searchAssetsFurnitureProcByPageOr(
			@Param("bean") AssetsFurnitureProcDTO assetsFurnitureProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 ASSETS_FURNITURE_PROC
	* @param assetsFurnitureProcDTO 查询对象
	* @return List<AssetsFurnitureProcDTO>
	*/
	public List<AssetsFurnitureProcDTO> searchAssetsFurnitureProc(AssetsFurnitureProcDTO assetsFurnitureProcDTO);

	/**
	 * 查询 ASSETS_FURNITURE_PROC
	 * @param id 主键id
	 * @return AssetsFurnitureProcDTO
	 */
	public AssetsFurnitureProcDTO findAssetsFurnitureProcById(String id);

	/**
	 * 新增ASSETS_FURNITURE_PROC
	 * @param assetsFurnitureProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureProc(AssetsFurnitureProcDTO assetsFurnitureProcDTO);

	/**
	 * 批量新增 ASSETS_FURNITURE_PROC
	 * @param assetsFurnitureProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureProcList(List<AssetsFurnitureProcDTO> assetsFurnitureProcDTOList);

	/**
	* 更新部分对象 ASSETS_FURNITURE_PROC
	* @param assetsFurnitureProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureProcSensitive(AssetsFurnitureProcDTO assetsFurnitureProcDTO);

	/**
	 * 更新全部对象 ASSETS_FURNITURE_PROC
	 * @param assetsFurnitureProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureProcAll(AssetsFurnitureProcDTO assetsFurnitureProcDTO);

	/**
	 * 批量更新对象 ASSETS_FURNITURE_PROC
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureProcList(@Param("dtoList") List<AssetsFurnitureProcDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_FURNITURE_PROC
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureProcById(String id);

	/**
	 * 按主键批量删除 ASSETS_FURNITURE_PROC
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureProcList(List<String> idList);
}
