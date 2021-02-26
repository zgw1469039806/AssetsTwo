package avicit.assets.furniture.assetsfurnitureinventory.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventoryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:15
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureInventoryDao {

	/**
	* 分页查询  家具盘点
	* @param assetsFurnitureInventoryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureInventoryDTO>
	*/
	public Page<AssetsFurnitureInventoryDTO> searchAssetsFurnitureInventoryByPage(
            @Param("bean") AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 家具盘点
	* @param assetsFurnitureInventoryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureInventoryDTO>
	*/
	public Page<AssetsFurnitureInventoryDTO> searchAssetsFurnitureInventoryByPageOr(
            @Param("bean") AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 家具盘点
	* @param assetsFurnitureInventoryDTO 查询对象
	* @return List<AssetsFurnitureInventoryDTO>
	*/
	public List<AssetsFurnitureInventoryDTO> searchAssetsFurnitureInventory(
            AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO);

	/**
	 * 查询 家具盘点
	 * @param id 主键id
	 * @return AssetsFurnitureInventoryDTO
	 */
	public AssetsFurnitureInventoryDTO findAssetsFurnitureInventoryById(String id);

	/**
	 * 新增家具盘点
	 * @param assetsFurnitureInventoryDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureInventory(AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO);

	/**
	 * 批量新增 家具盘点
	 * @param assetsFurnitureInventoryDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureInventoryList(List<AssetsFurnitureInventoryDTO> assetsFurnitureInventoryDTOList);

	/**
	* 更新部分对象 家具盘点
	* @param assetsFurnitureInventoryDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureInventorySensitive(AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO);

	/**
	 * 更新全部对象 家具盘点
	 * @param assetsFurnitureInventoryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureInventoryAll(AssetsFurnitureInventoryDTO assetsFurnitureInventoryDTO);

	/**
	 * 批量更新对象 家具盘点
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureInventoryList(@Param("dtoList") List<AssetsFurnitureInventoryDTO> dtoList);

	/**
	 * 按主键删除 家具盘点
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureInventoryById(String id);

	/**
	 * 按主键批量删除 家具盘点
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureInventoryList(List<String> idList);
}
