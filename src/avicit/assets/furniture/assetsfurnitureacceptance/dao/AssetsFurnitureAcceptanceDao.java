package avicit.assets.furniture.assetsfurnitureacceptance.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureacceptance.dto.AssetsFurnitureAcceptanceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 08:34
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureAcceptanceDao {

	/**
	* 分页查询  ASSETS_FURNITURE_ACCEPTANCE
	* @param assetsFurnitureAcceptanceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureAcceptanceDTO>
	*/
	public Page<AssetsFurnitureAcceptanceDTO> searchAssetsFurnitureAcceptanceByPage(
			@Param("bean") AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_FURNITURE_ACCEPTANCE
	* @param assetsFurnitureAcceptanceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureAcceptanceDTO>
	*/
	public Page<AssetsFurnitureAcceptanceDTO> searchAssetsFurnitureAcceptanceByPageOr(
			@Param("bean") AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 查询 ASSETS_FURNITURE_ACCEPTANCE
	* @param assetsFurnitureAcceptanceDTO 查询对象
	* @return List<AssetsFurnitureAcceptanceDTO>
	*/
	public List<AssetsFurnitureAcceptanceDTO> searchAssetsFurnitureAcceptance(
			AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO);

	/**
	 * 查询 ASSETS_FURNITURE_ACCEPTANCE
	 * @param id 主键id
	 * @return AssetsFurnitureAcceptanceDTO
	 */
	public AssetsFurnitureAcceptanceDTO findAssetsFurnitureAcceptanceById(String id);

	/**
	 * 新增ASSETS_FURNITURE_ACCEPTANCE
	 * @param assetsFurnitureAcceptanceDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureAcceptance(AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO);

	/**
	 * 批量新增 ASSETS_FURNITURE_ACCEPTANCE
	 * @param assetsFurnitureAcceptanceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureAcceptanceList(List<AssetsFurnitureAcceptanceDTO> assetsFurnitureAcceptanceDTOList);

	/**
	* 更新部分对象 ASSETS_FURNITURE_ACCEPTANCE
	* @param assetsFurnitureAcceptanceDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureAcceptanceSensitive(AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO);

	/**
	 * 更新全部对象 ASSETS_FURNITURE_ACCEPTANCE
	 * @param assetsFurnitureAcceptanceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureAcceptanceAll(AssetsFurnitureAcceptanceDTO assetsFurnitureAcceptanceDTO);

	/**
	 * 批量更新对象 ASSETS_FURNITURE_ACCEPTANCE
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureAcceptanceList(@Param("dtoList") List<AssetsFurnitureAcceptanceDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_FURNITURE_ACCEPTANCE
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureAcceptanceById(String id);

	/**
	 * 按主键批量删除 ASSETS_FURNITURE_ACCEPTANCE
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureAcceptanceList(List<String> idList);
}
