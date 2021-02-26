package avicit.assets.device.assetstdeviceupgradeproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetstdeviceupgradeproc.dto.AssetsTdeviceUpgradeProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-31 14:13
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsTdeviceUpgradeProcDao {

	/**
	* 分页查询  测试设备升级流程
	* @param assetsTdeviceUpgradeProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceUpgradeProcDTO>
	*/
	public Page<AssetsTdeviceUpgradeProcDTO> searchAssetsTdeviceUpgradeProcByPage(
            @Param("bean") AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 测试设备升级流程
	* @param assetsTdeviceUpgradeProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceUpgradeProcDTO>
	*/
	public Page<AssetsTdeviceUpgradeProcDTO> searchAssetsTdeviceUpgradeProcByPageOr(
            @Param("bean") AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询测试设备升级流程
	* @param assetsTdeviceUpgradeProcDTO 查询对象
	* @return List<AssetsTdeviceUpgradeProcDTO>
	*/
	public List<AssetsTdeviceUpgradeProcDTO> searchAssetsTdeviceUpgradeProc(
            AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO);

	/**
	 * 查询 测试设备升级流程
	 * @param id 主键id
	 * @return AssetsTdeviceUpgradeProcDTO
	 */
	public AssetsTdeviceUpgradeProcDTO findAssetsTdeviceUpgradeProcById(String id);

	/**
	* 新增测试设备升级流程
	* @param assetsTdeviceUpgradeProcDTO 保存对象
	* @return int
	*/
	public int insertAssetsTdeviceUpgradeProc(AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO);

	/**
	 * 批量新增 测试设备升级流程
	 * @param assetsTdeviceUpgradeProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTdeviceUpgradeProcList(List<AssetsTdeviceUpgradeProcDTO> assetsTdeviceUpgradeProcDTOList);

	/**
	 * 更新部分对象 测试设备升级流程
	 * @param assetsTdeviceUpgradeProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeProcSensitive(AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO);

	/**
	 * 更新全部对象 测试设备升级流程
	 * @param assetsTdeviceUpgradeProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeProcAll(AssetsTdeviceUpgradeProcDTO assetsTdeviceUpgradeProcDTO);

	/**
	 * 批量更新对象 测试设备升级流程
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTdeviceUpgradeProcList(@Param("dtoList") List<AssetsTdeviceUpgradeProcDTO> dtoList);

	/**
	 * 按主键删除 测试设备升级流程
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTdeviceUpgradeProcById(String id);

	/**
	 * 按主键批量删除 测试设备升级流程
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTdeviceUpgradeProcList(List<String> idList);
}
