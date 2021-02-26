package avicit.assets.furniture.assetsfurniturescrapproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapSubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-20 17:18
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurnitureScrapSubDao {

	/**
	 * 分页查询  家具报废子表
	 * @param assetsFurnitureScrapSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureScrapSubDTO>
	 */
	public Page<AssetsFurnitureScrapSubDTO> searchAssetsFurnitureScrapSubByPage(
            @Param("bean") AssetsFurnitureScrapSubDTO assetsFurnitureScrapSubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具报废子表
	 * @param assetsFurnitureScrapSubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurnitureScrapSubDTO>
	 */
	public Page<AssetsFurnitureScrapSubDTO> searchAssetsFurnitureScrapSubByPageOr(
            @Param("bean") AssetsFurnitureScrapSubDTO assetsFurnitureScrapSubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具报废子表 
	 * @param id 主键id
	 * @return AssetsFurnitureScrapSubDTO
	 */
	public AssetsFurnitureScrapSubDTO findAssetsFurnitureScrapSubById(String id);

	/**
	 * 查询 家具报废子表
	 * @param pid 父id
	 * @return List<AssetsFurnitureScrapSubDTO>
	 */
	public List<AssetsFurnitureScrapSubDTO> findAssetsFurnitureScrapSubByPid(String pid);

	/**
	 * 新增家具报废子表
	 * @param assetsFurnitureScrapSubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurnitureScrapSub(AssetsFurnitureScrapSubDTO assetsFurnitureScrapSubDTO);

	/**
	 * 批量新增 家具报废子表
	 * @param assetsFurnitureScrapSubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurnitureScrapSubList(List<AssetsFurnitureScrapSubDTO> assetsFurnitureScrapSubDTOList);

	/**
	 * 更新部分对象 家具报废子表
	 * @param assetsFurnitureScrapSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureScrapSubSensitive(AssetsFurnitureScrapSubDTO assetsFurnitureScrapSubDTO);

	/**
	 * 更新全部对象 家具报废子表
	 * @param assetsFurnitureScrapSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurnitureScrapSubAll(AssetsFurnitureScrapSubDTO assetsFurnitureScrapSubDTO);

	/**
	 * 批量更新对象 家具报废子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurnitureScrapSubList(@Param("dtoList") List<AssetsFurnitureScrapSubDTO> dtoList);

	/**
	 * 按主键删除 家具报废子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurnitureScrapSubById(String id);

	/**
	 * 按主键批量删除 家具报废子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurnitureScrapSubList(List<String> idList);
}
