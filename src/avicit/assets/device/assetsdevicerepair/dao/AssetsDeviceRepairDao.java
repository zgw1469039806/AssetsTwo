package avicit.assets.device.assetsdevicerepair.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicerepair.dto.AssetsDeviceRepairDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 14:08
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceRepairDao {

	/**
	* 分页查询  设备维修
	* @param assetsDeviceRepairDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRepairDTO>
	*/
	public Page<AssetsDeviceRepairDTO> searchAssetsDeviceRepairByPage(
            @Param("bean") AssetsDeviceRepairDTO assetsDeviceRepairDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备维修
	* @param assetsDeviceRepairDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRepairDTO>
	*/
	public Page<AssetsDeviceRepairDTO> searchAssetsDeviceRepairByPageOr(
            @Param("bean") AssetsDeviceRepairDTO assetsDeviceRepairDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询设备维修
	* @param assetsDeviceRepairDTO 查询对象
	* @return List<AssetsDeviceRepairDTO>
	*/
	public List<AssetsDeviceRepairDTO> searchAssetsDeviceRepair(AssetsDeviceRepairDTO assetsDeviceRepairDTO);

	/**
	 * 查询 设备维修
	 * @param id 主键id
	 * @return AssetsDeviceRepairDTO
	 */
	public AssetsDeviceRepairDTO findAssetsDeviceRepairById(String id);

	/**
	* 新增设备维修
	* @param assetsDeviceRepairDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceRepair(AssetsDeviceRepairDTO assetsDeviceRepairDTO);

	/**
	 * 批量新增 设备维修
	 * @param assetsDeviceRepairDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceRepairList(List<AssetsDeviceRepairDTO> assetsDeviceRepairDTOList);

	/**
	 * 更新部分对象 设备维修
	 * @param assetsDeviceRepairDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRepairSensitive(AssetsDeviceRepairDTO assetsDeviceRepairDTO);

	/**
	 * 更新全部对象 设备维修
	 * @param assetsDeviceRepairDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRepairAll(AssetsDeviceRepairDTO assetsDeviceRepairDTO);

	/**
	 * 批量更新对象 设备维修
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceRepairList(@Param("dtoList") List<AssetsDeviceRepairDTO> dtoList);

	/**
	 * 按主键删除 设备维修
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceRepairById(String id);

	/**
	 * 按主键批量删除 设备维修
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceRepairList(List<String> idList);
}
