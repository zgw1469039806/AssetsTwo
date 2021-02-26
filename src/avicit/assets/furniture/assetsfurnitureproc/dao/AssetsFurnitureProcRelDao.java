package avicit.assets.furniture.assetsfurnitureproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureproc.dto.AssetsFurnitureProcRelDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 09:09
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureProcRelDao {

	/**
	 * 分页查询  ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureProcRelDTO>
	 */
	public Page<AssetsFurnitureProcRelDTO> searchAssetsFurnitureProcRelByPage(
			@Param("bean") AssetsFurnitureProcRelDTO assetsFurnitureProcRelDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureProcRelDTO>
	 */
	public Page<AssetsFurnitureProcRelDTO> searchAssetsFurnitureProcRelByPageOr(
			@Param("bean") AssetsFurnitureProcRelDTO assetsFurnitureProcRelDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_FURNITURE_PROC_REL 
	 * @param id 主键id
	 * @return AssetsFurnitureProcRelDTO
	 */
	public AssetsFurnitureProcRelDTO findAssetsFurnitureProcRelById(String id);

	/**
	 * 查询 ASSETS_FURNITURE_PROC_REL
	 * @param pid 父id
	 * @return List<AssetsFurnitureProcRelDTO>
	 */
	public List<AssetsFurnitureProcRelDTO> findAssetsFurnitureProcRelByPid(String pid);

	/**
	 * 新增ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureProcRel(AssetsFurnitureProcRelDTO assetsFurnitureProcRelDTO);

	/**
	 * 批量新增 ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureProcRelList(List<AssetsFurnitureProcRelDTO> assetsFurnitureProcRelDTOList);

	/**
	 * 更新部分对象 ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureProcRelSensitive(AssetsFurnitureProcRelDTO assetsFurnitureProcRelDTO);

	/**
	 * 更新全部对象 ASSETS_FURNITURE_PROC_REL
	 * @param assetsFurnitureProcRelDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureProcRelAll(AssetsFurnitureProcRelDTO assetsFurnitureProcRelDTO);

	/**
	 * 批量更新对象 ASSETS_FURNITURE_PROC_REL
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureProcRelList(@Param("dtoList") List<AssetsFurnitureProcRelDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_FURNITURE_PROC_REL
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureProcRelById(String id);

	/**
	 * 按主键批量删除 ASSETS_FURNITURE_PROC_REL
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureProcRelList(List<String> idList);
}
