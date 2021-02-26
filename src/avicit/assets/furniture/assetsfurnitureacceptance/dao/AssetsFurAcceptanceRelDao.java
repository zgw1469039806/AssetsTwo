package avicit.assets.furniture.assetsfurnitureacceptance.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.furniture.assetsfurnitureacceptance.dto.AssetsFurAcceptanceRelDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 08:34
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFurAcceptanceRelDao {

	/**
	 * 分页查询  家具验收子表
	 * @param assetsFurAcceptanceRelDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurAcceptanceRelDTO>
	 */
	public Page<AssetsFurAcceptanceRelDTO> searchAssetsFurAcceptanceRelByPage(
			@Param("bean") AssetsFurAcceptanceRelDTO assetsFurAcceptanceRelDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 家具验收子表
	 * @param assetsFurAcceptanceRelDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsFurAcceptanceRelDTO>
	 */
	public Page<AssetsFurAcceptanceRelDTO> searchAssetsFurAcceptanceRelByPageOr(
			@Param("bean") AssetsFurAcceptanceRelDTO assetsFurAcceptanceRelDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 家具验收子表 
	 * @param id 主键id
	 * @return AssetsFurAcceptanceRelDTO
	 */
	public AssetsFurAcceptanceRelDTO findAssetsFurAcceptanceRelById(String id);

	/**
	 * 查询 家具验收子表
	 * @param pid 父id
	 * @return List<AssetsFurAcceptanceRelDTO>
	 */
	public List<AssetsFurAcceptanceRelDTO> findAssetsFurAcceptanceRelByPid(String pid);

	/**
	 * 新增家具验收子表
	 * @param assetsFurAcceptanceRelDTO 保存对象
	 * @return int
	 */
	public int insertAssetsFurAcceptanceRel(AssetsFurAcceptanceRelDTO assetsFurAcceptanceRelDTO);

	/**
	 * 批量新增 家具验收子表
	 * @param assetsFurAcceptanceRelDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsFurAcceptanceRelList(List<AssetsFurAcceptanceRelDTO> assetsFurAcceptanceRelDTOList);

	/**
	 * 更新部分对象 家具验收子表
	 * @param assetsFurAcceptanceRelDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurAcceptanceRelSensitive(AssetsFurAcceptanceRelDTO assetsFurAcceptanceRelDTO);

	/**
	 * 更新全部对象 家具验收子表
	 * @param assetsFurAcceptanceRelDTO 更新对象
	 * @return int
	 */
	public int updateAssetsFurAcceptanceRelAll(AssetsFurAcceptanceRelDTO assetsFurAcceptanceRelDTO);

	/**
	 * 批量更新对象 家具验收子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsFurAcceptanceRelList(@Param("dtoList") List<AssetsFurAcceptanceRelDTO> dtoList);

	/**
	 * 按主键删除 家具验收子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsFurAcceptanceRelById(String id);

	/**
	 * 按主键批量删除 家具验收子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsFurAcceptanceRelList(List<String> idList);
}
