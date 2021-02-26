package avicit.assets.furniture.assetsfurnitureinventory.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventorySubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:15
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureInventorySubDao {

	/**
	 * 分页查询  家具盘点子表
	 * @param assetsFurnitureInventorySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureInventorySubDTO>
	 */
	public Page<AssetsFurnitureInventorySubDTO> searchAssetsFurnitureInventorySubByPage(
            @Param("bean") AssetsFurnitureInventorySubDTO assetsFurnitureInventorySubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具盘点子表
	 * @param assetsFurnitureInventorySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureInventorySubDTO>
	 */
	public Page<AssetsFurnitureInventorySubDTO> searchAssetsFurnitureInventorySubByPageOr(
            @Param("bean") AssetsFurnitureInventorySubDTO assetsFurnitureInventorySubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具盘点子表 
	 * @param id 主键id
	 * @return AssetsFurnitureInventorySubDTO
	 */
	public AssetsFurnitureInventorySubDTO findAssetsFurnitureInventorySubById(String id);

	/**
	 * 查询 家具盘点子表
	 * @param pid 父id
	 * @return List<AssetsFurnitureInventorySubDTO>
	 */
	public List<AssetsFurnitureInventorySubDTO> findAssetsFurnitureInventorySubByPid(String pid);

	/**
	 * 新增家具盘点子表
	 * @param assetsFurnitureInventorySubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureInventorySub(AssetsFurnitureInventorySubDTO assetsFurnitureInventorySubDTO);

	/**
	 * 批量新增 家具盘点子表
	 * @param assetsFurnitureInventorySubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureInventorySubList(
            List<AssetsFurnitureInventorySubDTO> assetsFurnitureInventorySubDTOList);

	/**
	 * 更新部分对象 家具盘点子表
	 * @param assetsFurnitureInventorySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureInventorySubSensitive(
            AssetsFurnitureInventorySubDTO assetsFurnitureInventorySubDTO);

	/**
	 * 更新全部对象 家具盘点子表
	 * @param assetsFurnitureInventorySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureInventorySubAll(AssetsFurnitureInventorySubDTO assetsFurnitureInventorySubDTO);

	/**
	 * 批量更新对象 家具盘点子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureInventorySubList(@Param("dtoList") List<AssetsFurnitureInventorySubDTO> dtoList);

	/**
	 * 按主键删除 家具盘点子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureInventorySubById(String id);

	/**
	 * 按主键批量删除 家具盘点子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureInventorySubList(List<String> idList);
}
