package avicit.assets.furniture.assetsfurnituretransferproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferSubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-14 16:53
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureTransferSubDao {

	/**
	 * 分页查询  家具移交子表
	 * @param assetsFurnitureTransferSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureTransferSubDTO>
	 */
	public Page<AssetsFurnitureTransferSubDTO> searchAssetsFurnitureTransferSubByPage(
            @Param("bean") AssetsFurnitureTransferSubDTO assetsFurnitureTransferSubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具移交子表
	 * @param assetsFurnitureTransferSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureTransferSubDTO>
	 */
	public Page<AssetsFurnitureTransferSubDTO> searchAssetsFurnitureTransferSubByPageOr(
            @Param("bean") AssetsFurnitureTransferSubDTO assetsFurnitureTransferSubDTO,
            @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具移交子表 
	 * @param id 主键id
	 * @return AssetsFurnitureTransferSubDTO
	 */
	public AssetsFurnitureTransferSubDTO findAssetsFurnitureTransferSubById(String id);

	/**
	 * 查询 家具移交子表
	 * @param pid 父id
	 * @return List<AssetsFurnitureTransferSubDTO>
	 */
	public List<AssetsFurnitureTransferSubDTO> findAssetsFurnitureTransferSubByPid(String pid);

	/**
	 * 新增家具移交子表
	 * @param assetsFurnitureTransferSubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureTransferSub(AssetsFurnitureTransferSubDTO assetsFurnitureTransferSubDTO);

	/**
	 * 批量新增 家具移交子表
	 * @param assetsFurnitureTransferSubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureTransferSubList(
            List<AssetsFurnitureTransferSubDTO> assetsFurnitureTransferSubDTOList);

	/**
	 * 更新部分对象 家具移交子表
	 * @param assetsFurnitureTransferSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureTransferSubSensitive(AssetsFurnitureTransferSubDTO assetsFurnitureTransferSubDTO);

	/**
	 * 更新全部对象 家具移交子表
	 * @param assetsFurnitureTransferSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureTransferSubAll(AssetsFurnitureTransferSubDTO assetsFurnitureTransferSubDTO);

	/**
	 * 批量更新对象 家具移交子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureTransferSubList(@Param("dtoList") List<AssetsFurnitureTransferSubDTO> dtoList);

	/**
	 * 按主键删除 家具移交子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureTransferSubById(String id);

	/**
	 * 按主键批量删除 家具移交子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureTransferSubList(List<String> idList);
}
