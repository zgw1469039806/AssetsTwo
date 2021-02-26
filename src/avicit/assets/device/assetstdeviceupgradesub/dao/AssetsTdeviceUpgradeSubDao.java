package avicit.assets.device.assetstdeviceupgradesub.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetstdeviceupgradesub.dto.AssetsTdeviceUpgradeSubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 08:43
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsTdeviceUpgradeSubDao {

	/**
	* 分页查询  测试设备升级子表
	* @param assetsTdeviceUpgradeSubDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceUpgradeSubDTO>
	*/
	public Page<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSubByPage(
            @Param("bean") AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 测试设备升级子表
	* @param assetsTdeviceUpgradeSubDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceUpgradeSubDTO>
	*/
	public Page<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSubByPageOr(
            @Param("bean") AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询测试设备升级子表
	 * @param assetsTdeviceUpgradeSubDTO 查询对象
	 * @return List<AssetsTdeviceUpgradeSubDTO>
	 */
	public List<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSub(
            AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO);

	/**
	 * 查询 测试设备升级子表
	 * @param id 主键id
	 * @return AssetsTdeviceUpgradeSubDTO
	 */
	public AssetsTdeviceUpgradeSubDTO findAssetsTdeviceUpgradeSubById(String id);

	/**
	 * 查询 测试设备升级子表
	 * @param foreignkey 外键id
	 * @return List<AssetsTdeviceUpgradeSubDTO>
	 */
	public List<AssetsTdeviceUpgradeSubDTO> findAssetsTdeviceUpgradeSubByForeignKey(String foreignkey);

	/**
	 * 查询 测试设备升级子表
	 * @param tdeviceSoftwareId 软件台账ID
	 * @return List<AssetsTdeviceUpgradeSubDTO>
	 */
	public List<AssetsTdeviceUpgradeSubDTO> findTdeviceUpgradeByTdeviceSoftwareId(String tdeviceSoftwareId);

	/**
	* 新增测试设备升级子表
	* @param assetsTdeviceUpgradeSubDTO 保存对象
	* @return int
	*/
	public int insertAssetsTdeviceUpgradeSub(AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO);

	/**
	 * 批量新增 测试设备升级子表
	 * @param assetsTdeviceUpgradeSubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTdeviceUpgradeSubList(List<AssetsTdeviceUpgradeSubDTO> assetsTdeviceUpgradeSubDTOList);

	/**
	 * 更新部分对象 测试设备升级子表
	 * @param assetsTdeviceUpgradeSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeSubSensitive(AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO);

	/**
	 * 更新全部对象 测试设备升级子表
	 * @param assetsTdeviceUpgradeSubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeSubAll(AssetsTdeviceUpgradeSubDTO assetsTdeviceUpgradeSubDTO);

	/**
	 * 批量更新对象 测试设备升级子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeSubList(@Param("dtoList") List<AssetsTdeviceUpgradeSubDTO> dtoList);

	/**
	 * 按主键删除 测试设备升级子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTdeviceUpgradeSubById(String id);

	/**
	 * 按主键批量删除 测试设备升级子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTdeviceUpgradeSubList(List<String> idList);
}
