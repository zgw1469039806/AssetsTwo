package avicit.assets.furniture.assetsfurniturerepairproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairSubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-19 09:30
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureRepairSubDao {

	/**
	 * 分页查询  家具维修子表
	 * @param assetsFurnitureRepairSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureRepairSubDTO>
	 */
	public Page<AssetsFurnitureRepairSubDTO> searchAssetsFurnitureRepairSubByPage(
            @Param("bean") AssetsFurnitureRepairSubDTO assetsFurnitureRepairSubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具维修子表
	 * @param assetsFurnitureRepairSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureRepairSubDTO>
	 */
	public Page<AssetsFurnitureRepairSubDTO> searchAssetsFurnitureRepairSubByPageOr(
            @Param("bean") AssetsFurnitureRepairSubDTO assetsFurnitureRepairSubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具维修子表 
	 * @param id 主键id
	 * @return AssetsFurnitureRepairSubDTO
	 */
	public AssetsFurnitureRepairSubDTO findAssetsFurnitureRepairSubById(String id);

	/**
	 * 查询 家具维修子表
	 * @param pid 父id
	 * @return List<AssetsFurnitureRepairSubDTO>
	 */
	public List<AssetsFurnitureRepairSubDTO> findAssetsFurnitureRepairSubByPid(String pid);

	/**
	 * 新增家具维修子表
	 * @param assetsFurnitureRepairSubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureRepairSub(AssetsFurnitureRepairSubDTO assetsFurnitureRepairSubDTO);

	/**
	 * 批量新增 家具维修子表
	 * @param assetsFurnitureRepairSubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureRepairSubList(List<AssetsFurnitureRepairSubDTO> assetsFurnitureRepairSubDTOList);

	/**
	 * 更新部分对象 家具维修子表
	 * @param assetsFurnitureRepairSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRepairSubSensitive(AssetsFurnitureRepairSubDTO assetsFurnitureRepairSubDTO);

	/**
	 * 更新全部对象 家具维修子表
	 * @param assetsFurnitureRepairSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureRepairSubAll(AssetsFurnitureRepairSubDTO assetsFurnitureRepairSubDTO);

	/**
	 * 批量更新对象 家具维修子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureRepairSubList(@Param("dtoList") List<AssetsFurnitureRepairSubDTO> dtoList);

	/**
	 * 按主键删除 家具维修子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureRepairSubById(String id);

	/**
	 * 按主键批量删除 家具维修子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureRepairSubList(List<String> idList);
}
