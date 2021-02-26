package avicit.assets.furniture.assetsfurnituretransferproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-14 16:53
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureTransferProcDao {

	/**
	* 分页查询  家具移交
	* @param assetsFurnitureTransferProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureTransferProcDTO>
	*/
	public Page<AssetsFurnitureTransferProcDTO> searchAssetsFurnitureTransferProcByPage(
            @Param("bean") AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 家具移交
	* @param assetsFurnitureTransferProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsFurnitureTransferProcDTO>
	*/
	public Page<AssetsFurnitureTransferProcDTO> searchAssetsFurnitureTransferProcByPageOr(
            @Param("bean") AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 查询 家具移交
	* @param assetsFurnitureTransferProcDTO 查询对象
	* @return List<AssetsFurnitureTransferProcDTO>
	*/
	public List<AssetsFurnitureTransferProcDTO> searchAssetsFurnitureTransferProc(
            AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO);

	/**
	 * 查询 家具移交
	 * @param id 主键id
	 * @return AssetsFurnitureTransferProcDTO
	 */
	public AssetsFurnitureTransferProcDTO findAssetsFurnitureTransferProcById(String id);

	/**
	 * 新增家具移交
	 * @param assetsFurnitureTransferProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureTransferProc(AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO);

	/**
	 * 批量新增 家具移交
	 * @param assetsFurnitureTransferProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureTransferProcList(
            List<AssetsFurnitureTransferProcDTO> assetsFurnitureTransferProcDTOList);

	/**
	* 更新部分对象 家具移交
	* @param assetsFurnitureTransferProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsFurnitureTransferProcSensitive(
            AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO);

	/**
	 * 更新全部对象 家具移交
	 * @param assetsFurnitureTransferProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureTransferProcAll(AssetsFurnitureTransferProcDTO assetsFurnitureTransferProcDTO);

	/**
	 * 批量更新对象 家具移交
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureTransferProcList(@Param("dtoList") List<AssetsFurnitureTransferProcDTO> dtoList);

	/**
	 * 按主键删除 家具移交
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureTransferProcById(String id);

	/**
	 * 按主键批量删除 家具移交
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureTransferProcList(List<String> idList);
}
