package avicit.assets.furniture.assetsfurniturescrapproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-20 17:18
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureScrapProcDao {

	/**
	* 分页查询  家具报废
	* @param assetsFurnitureScrapProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureScrapProcDTO>
	*/
	public Page<AssetsFurnitureScrapProcDTO> searchAssetsFurnitureScrapProcByPage(
            @Param("bean") AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 家具报废
	* @param assetsFurnitureScrapProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureScrapProcDTO>
	*/
	public Page<AssetsFurnitureScrapProcDTO> searchAssetsFurnitureScrapProcByPageOr(
            @Param("bean") AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 家具报废
	* @param assetsFurnitureScrapProcDTO 查询对象
	* @return List<AssetsFurnitureScrapProcDTO>
	*/
	public List<AssetsFurnitureScrapProcDTO> searchAssetsFurnitureScrapProc(
            AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO);

	/**
	 * 查询 家具报废
	 * @param id 主键id
	 * @return AssetsFurnitureScrapProcDTO
	 */
	public AssetsFurnitureScrapProcDTO findAssetsFurnitureScrapProcById(String id);

	/**
	 * 新增家具报废
	 * @param assetsFurnitureScrapProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureScrapProc(AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO);

	/**
	 * 批量新增 家具报废
	 * @param assetsFurnitureScrapProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureScrapProcList(List<AssetsFurnitureScrapProcDTO> assetsFurnitureScrapProcDTOList);

	/**
	* 更新部分对象 家具报废
	* @param assetsFurnitureScrapProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureScrapProcSensitive(AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO);

	/**
	 * 更新全部对象 家具报废
	 * @param assetsFurnitureScrapProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureScrapProcAll(AssetsFurnitureScrapProcDTO assetsFurnitureScrapProcDTO);

	/**
	 * 批量更新对象 家具报废
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureScrapProcList(@Param("dtoList") List<AssetsFurnitureScrapProcDTO> dtoList);

	/**
	 * 按主键删除 家具报废
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureScrapProcById(String id);

	/**
	 * 按主键批量删除 家具报废
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureScrapProcList(List<String> idList);
}
