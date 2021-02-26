package avicit.assets.device.assetstdevicesoftware.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetstdevicesoftware.dto.AssetsTdeviceSoftwareDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 17:24
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsTdeviceSoftwareDao {

	/**
	* 分页查询  测试设备软件
	* @param assetsTdeviceSoftwareDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceSoftwareDTO>
	*/
	public Page<AssetsTdeviceSoftwareDTO> searchAssetsTdeviceSoftwareByPage(
            @Param("bean") AssetsTdeviceSoftwareDTO assetsTdeviceSoftwareDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 测试设备软件
	* @param assetsTdeviceSoftwareDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceSoftwareDTO>
	*/
	public Page<AssetsTdeviceSoftwareDTO> searchAssetsTdeviceSoftwareByPageOr(
            @Param("bean") AssetsTdeviceSoftwareDTO assetsTdeviceSoftwareDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 测试设备软件
	 * @param id 主键id
	 * @return AssetsTdeviceSoftwareDTO
	 */
	public AssetsTdeviceSoftwareDTO findAssetsTdeviceSoftwareById(String id);

	/**
	 * 查询 测试设备软件集合
	 * @param unifiedid 统一编码unifiedid
	 * @return List<AssetsTdeviceSoftwareDTO>
	 */
	public List<AssetsTdeviceSoftwareDTO> findAssetsTdeviceSoftwareByUnifiedId(String unifiedid);

	/**
	* 新增测试设备软件
	* @param assetsTdeviceSoftwareDTO 保存对象
	* @return int
	*/
	public int insertAssetsTdeviceSoftware(AssetsTdeviceSoftwareDTO assetsTdeviceSoftwareDTO);

	/**
	 * 批量新增 测试设备软件
	 * @param assetsTdeviceSoftwareDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTdeviceSoftwareList(List<AssetsTdeviceSoftwareDTO> assetsTdeviceSoftwareDTOList);

	/**
	 * 更新部分对象 测试设备软件
	 * @param assetsTdeviceSoftwareDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceSoftwareSensitive(AssetsTdeviceSoftwareDTO assetsTdeviceSoftwareDTO);

	/**
	 * 更新全部对象 测试设备软件
	 * @param assetsTdeviceSoftwareDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceSoftwareAll(AssetsTdeviceSoftwareDTO assetsTdeviceSoftwareDTO);

	/**
	 * 批量更新对象 测试设备软件
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTdeviceSoftwareList(@Param("dtoList") List<AssetsTdeviceSoftwareDTO> dtoList);

	/**
	 * 按主键删除 测试设备软件
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTdeviceSoftwareById(String id);

	/**
	 * 按主键批量删除 测试设备软件
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTdeviceSoftwareList(List<String> idList);
}
