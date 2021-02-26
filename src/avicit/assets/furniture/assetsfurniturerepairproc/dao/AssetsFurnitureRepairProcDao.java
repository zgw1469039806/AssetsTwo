package avicit.assets.furniture.assetsfurniturerepairproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-19 09:30
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureRepairProcDao {

	/**
	* 分页查询  家具维修
	* @param assetsFurnitureRepairProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureRepairProcDTO>
	*/
	public Page<AssetsFurnitureRepairProcDTO> searchAssetsFurnitureRepairProcByPage(
            @Param("bean") AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 家具维修
	* @param assetsFurnitureRepairProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureRepairProcDTO>
	*/
	public Page<AssetsFurnitureRepairProcDTO> searchAssetsFurnitureRepairProcByPageOr(
            @Param("bean") AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 查询 家具维修
	* @param assetsFurnitureRepairProcDTO 查询对象
	* @return List<AssetsFurnitureRepairProcDTO>
	*/
	public List<AssetsFurnitureRepairProcDTO> searchAssetsFurnitureRepairProc(
            AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO);

	/**
	 * 查询 家具维修
	 * @param id 主键id
	 * @return AssetsFurnitureRepairProcDTO
	 */
	public AssetsFurnitureRepairProcDTO findAssetsFurnitureRepairProcById(String id);

	/**
	 * 新增家具维修
	 * @param assetsFurnitureRepairProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureRepairProc(AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO);

	/**
	 * 批量新增 家具维修
	 * @param assetsFurnitureRepairProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureRepairProcList(List<AssetsFurnitureRepairProcDTO> assetsFurnitureRepairProcDTOList);

	/**
	* 更新部分对象 家具维修
	* @param assetsFurnitureRepairProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureRepairProcSensitive(AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO);

	/**
	 * 更新全部对象 家具维修
	 * @param assetsFurnitureRepairProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRepairProcAll(AssetsFurnitureRepairProcDTO assetsFurnitureRepairProcDTO);

	/**
	 * 批量更新对象 家具维修
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureRepairProcList(@Param("dtoList") List<AssetsFurnitureRepairProcDTO> dtoList);

	/**
	 * 按主键删除 家具维修
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureRepairProcById(String id);

	/**
	 * 按主键批量删除 家具维修
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureRepairProcList(List<String> idList);
}
