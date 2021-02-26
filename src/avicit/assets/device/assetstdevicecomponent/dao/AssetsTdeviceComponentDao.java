package avicit.assets.device.assetstdevicecomponent.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetstdevicecomponent.dto.AssetsTdeviceComponentDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 16:26
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsTdeviceComponentDao {

	/**
	* 分页查询  测试设备组件
	* @param assetsTdeviceComponentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceComponentDTO>
	*/
	public Page<AssetsTdeviceComponentDTO> searchAssetsTdeviceComponentByPage(
            @Param("bean") AssetsTdeviceComponentDTO assetsTdeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 测试设备组件
	* @param assetsTdeviceComponentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTdeviceComponentDTO>
	*/
	public Page<AssetsTdeviceComponentDTO> searchAssetsTdeviceComponentByPageOr(
            @Param("bean") AssetsTdeviceComponentDTO assetsTdeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 测试设备组件
	 * @param id 主键id
	 * @return AssetsTdeviceComponentDTO
	 */
	public AssetsTdeviceComponentDTO findAssetsTdeviceComponentById(String id);

	/**
	* 新增测试设备组件
	* @param assetsTdeviceComponentDTO 保存对象
	* @return int
	*/
	public int insertAssetsTdeviceComponent(AssetsTdeviceComponentDTO assetsTdeviceComponentDTO);

	/**
	 * 批量新增 测试设备组件
	 * @param assetsTdeviceComponentDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTdeviceComponentList(List<AssetsTdeviceComponentDTO> assetsTdeviceComponentDTOList);

	/**
	 * 更新部分对象 测试设备组件
	 * @param assetsTdeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceComponentSensitive(AssetsTdeviceComponentDTO assetsTdeviceComponentDTO);

	/**
	 * 更新全部对象 测试设备组件
	 * @param assetsTdeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTdeviceComponentAll(AssetsTdeviceComponentDTO assetsTdeviceComponentDTO);

	/**
	 * 批量更新对象 测试设备组件
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTdeviceComponentList(@Param("dtoList") List<AssetsTdeviceComponentDTO> dtoList);

	/**
	 * 按主键删除 测试设备组件
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTdeviceComponentById(String id);

	/**
	 * 按主键批量删除 测试设备组件
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTdeviceComponentList(List<String> idList);
}
