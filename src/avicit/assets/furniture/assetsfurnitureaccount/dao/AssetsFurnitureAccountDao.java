package avicit.assets.furniture.assetsfurnitureaccount.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-13 14:05
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureAccountDao {

	/**
	* 分页查询  ASSETS_FURNITURE_ACCOUNT
	* @param assetsFurnitureAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureAccountDTO>
	*/
	public Page<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccountByPage(
			@Param("bean") AssetsFurnitureAccountDTO assetsFurnitureAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_FURNITURE_ACCOUNT
	* @param assetsFurnitureAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureAccountDTO>
	*/
	public Page<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccountByPageOr(
			@Param("bean") AssetsFurnitureAccountDTO assetsFurnitureAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询ASSETS_FURNITURE_ACCOUNT
	 * @param assetsFurnitureAccountDTO 查询对象
	 * @return List<AssetsFurnitureAccountDTO>
	 */
	public List<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccount(
			AssetsFurnitureAccountDTO assetsFurnitureAccountDTO);

	/**
	 * 查询 ASSETS_FURNITURE_ACCOUNT
	 * @param id 主键id
	 * @return AssetsFurnitureAccountDTO
	 */
	public AssetsFurnitureAccountDTO findAssetsFurnitureAccountById(String id);

	/**
	 * 查询 ASSETS_FURNITURE_ACCOUNT
	 * @param unifiedId 统一编码
	 * @return AssetsFurnitureAccountDTO
	 */
	public AssetsFurnitureAccountDTO findAssetsFurnitureAccountByUnifiedId(String unifiedId);

	/**
	* 新增ASSETS_FURNITURE_ACCOUNT
	* @param assetsFurnitureAccountDTO 保存对象
	* @return int
	*/
	public int insertAssetsFurnitureAccount(AssetsFurnitureAccountDTO assetsFurnitureAccountDTO);

	/**
	 * 批量新增 ASSETS_FURNITURE_ACCOUNT
	 * @param assetsFurnitureAccountDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureAccountList(List<AssetsFurnitureAccountDTO> assetsFurnitureAccountDTOList);

	/**
	 * 更新部分对象 ASSETS_FURNITURE_ACCOUNT
	 * @param assetsFurnitureAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureAccountSensitive(AssetsFurnitureAccountDTO assetsFurnitureAccountDTO);

	/**
	 * 更新全部对象 ASSETS_FURNITURE_ACCOUNT
	 * @param assetsFurnitureAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureAccountAll(AssetsFurnitureAccountDTO assetsFurnitureAccountDTO);

	/**
	 * 批量更新对象 ASSETS_FURNITURE_ACCOUNT
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureAccountList(@Param("dtoList") List<AssetsFurnitureAccountDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_FURNITURE_ACCOUNT
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureAccountById(String id);

	/**
	 * 按主键批量删除 ASSETS_FURNITURE_ACCOUNT
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureAccountList(List<String> idList);
}
