package avicit.assets.device.assetsdeviceinventory.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceinventory.dto.AssetsDeviceInventoryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 14:32
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceInventoryDao {

	/**
	* 分页查询  设备盘点
	* @param assetsDeviceInventoryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceInventoryDTO>
	*/
	public Page<AssetsDeviceInventoryDTO> searchAssetsDeviceInventoryByPage(
			@Param("bean") AssetsDeviceInventoryDTO assetsDeviceInventoryDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备盘点
	* @param assetsDeviceInventoryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceInventoryDTO>
	*/
	public Page<AssetsDeviceInventoryDTO> searchAssetsDeviceInventoryByPageOr(
			@Param("bean") AssetsDeviceInventoryDTO assetsDeviceInventoryDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备盘点
	* @param assetsDeviceInventoryDTO 查询对象
	* @return List<AssetsDeviceInventoryDTO>
	*/
	public List<AssetsDeviceInventoryDTO> searchAssetsDeviceInventory(
			AssetsDeviceInventoryDTO assetsDeviceInventoryDTO);

	/**
	 * 查询 设备盘点
	 * @param id 主键id
	 * @return AssetsDeviceInventoryDTO
	 */
	public AssetsDeviceInventoryDTO findAssetsDeviceInventoryById(String id);

	/**
	 * 新增设备盘点
	 * @param assetsDeviceInventoryDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceInventory(AssetsDeviceInventoryDTO assetsDeviceInventoryDTO);

	/**
	 * 批量新增 设备盘点
	 * @param assetsDeviceInventoryDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceInventoryList(List<AssetsDeviceInventoryDTO> assetsDeviceInventoryDTOList);

	/**
	* 更新部分对象 设备盘点
	* @param assetsDeviceInventoryDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceInventorySensitive(AssetsDeviceInventoryDTO assetsDeviceInventoryDTO);

	/**
	 * 更新全部对象 设备盘点
	 * @param assetsDeviceInventoryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceInventoryAll(AssetsDeviceInventoryDTO assetsDeviceInventoryDTO);

	/**
	 * 批量更新对象 设备盘点
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceInventoryList(@Param("dtoList") List<AssetsDeviceInventoryDTO> dtoList);

	/**
	 * 按主键删除 设备盘点
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceInventoryById(String id);

	/**
	 * 按主键批量删除 设备盘点
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceInventoryList(List<String> idList);
}
