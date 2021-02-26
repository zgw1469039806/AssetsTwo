package avicit.assets.device.assetstdeviceappproduct.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetstdeviceappproduct.dto.AssetsTdeviceAppproductDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 17:31
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsTdeviceAppproductDao {

	/**
	* 分页查询  测试设备适用产品
	* @param assetsTdeviceAppproductDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceAppproductDTO>
	*/
	public Page<AssetsTdeviceAppproductDTO> searchAssetsTdeviceAppproductByPage(
            @Param("bean") AssetsTdeviceAppproductDTO assetsTdeviceAppproductDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 测试设备适用产品
	* @param assetsTdeviceAppproductDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceAppproductDTO>
	*/
	public Page<AssetsTdeviceAppproductDTO> searchAssetsTdeviceAppproductByPageOr(
            @Param("bean") AssetsTdeviceAppproductDTO assetsTdeviceAppproductDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 测试设备适用产品
	 * @param id 主键id
	 * @return AssetsTdeviceAppproductDTO
	 */
	public AssetsTdeviceAppproductDTO findAssetsTdeviceAppproductById(String id);

	/**
	 * 查询 统一编码的测试设备集合
	 * @param unified_id unified_id
	 * @return List<AssetsTdeviceAppproductDTO>
	 */
	public List<AssetsTdeviceAppproductDTO> findAssetsTdeviceAppproductByUnifiedId(String unified_id);

	/**
	* 新增测试设备适用产品
	* @param assetsTdeviceAppproductDTO 保存对象
	* @return int
	*/
	public int insertAssetsTdeviceAppproduct(AssetsTdeviceAppproductDTO assetsTdeviceAppproductDTO);

	/**
	 * 批量新增 测试设备适用产品
	 * @param assetsTdeviceAppproductDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTdeviceAppproductList(List<AssetsTdeviceAppproductDTO> assetsTdeviceAppproductDTOList);

	/**
	 * 更新部分对象 测试设备适用产品
	 * @param assetsTdeviceAppproductDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceAppproductSensitive(AssetsTdeviceAppproductDTO assetsTdeviceAppproductDTO);

	/**
	 * 更新全部对象 测试设备适用产品
	 * @param assetsTdeviceAppproductDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceAppproductAll(AssetsTdeviceAppproductDTO assetsTdeviceAppproductDTO);

	/**
	 * 批量更新对象 测试设备适用产品
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTdeviceAppproductList(@Param("dtoList") List<AssetsTdeviceAppproductDTO> dtoList);

	/**
	 * 按主键删除 测试设备适用产品
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTdeviceAppproductById(String id);

	/**
	 * 按主键批量删除 测试设备适用产品
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTdeviceAppproductList(List<String> idList);
}
