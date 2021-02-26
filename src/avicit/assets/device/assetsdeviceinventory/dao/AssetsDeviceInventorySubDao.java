package avicit.assets.device.assetsdeviceinventory.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceinventory.dto.AssetsDeviceInventorySubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 14:32
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceInventorySubDao {

	/**
	 * 分页查询  设备盘点子表
	 * @param assetsDeviceInventorySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceInventorySubDTO>
	 */
	public Page<AssetsDeviceInventorySubDTO> searchAssetsDeviceInventorySubByPage(
			@Param("bean") AssetsDeviceInventorySubDTO assetsDeviceInventorySubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 设备盘点子表
	 * @param assetsDeviceInventorySubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceInventorySubDTO>
	 */
	public Page<AssetsDeviceInventorySubDTO> searchAssetsDeviceInventorySubByPageOr(
			@Param("bean") AssetsDeviceInventorySubDTO assetsDeviceInventorySubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备盘点子表 
	 * @param id 主键id
	 * @return AssetsDeviceInventorySubDTO
	 */
	public AssetsDeviceInventorySubDTO findAssetsDeviceInventorySubById(String id);

	/**
	 * 查询 设备盘点子表
	 * @param pid 父id
	 * @return List<AssetsDeviceInventorySubDTO>
	 */
	public List<AssetsDeviceInventorySubDTO> findAssetsDeviceInventorySubByPid(String pid);

	/**
	 * 新增设备盘点子表
	 * @param assetsDeviceInventorySubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceInventorySub(AssetsDeviceInventorySubDTO assetsDeviceInventorySubDTO);

	/**
	 * 批量新增 设备盘点子表
	 * @param assetsDeviceInventorySubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceInventorySubList(List<AssetsDeviceInventorySubDTO> assetsDeviceInventorySubDTOList);

	/**
	 * 更新部分对象 设备盘点子表
	 * @param assetsDeviceInventorySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceInventorySubSensitive(AssetsDeviceInventorySubDTO assetsDeviceInventorySubDTO);

	/**
	 * 更新全部对象 设备盘点子表
	 * @param assetsDeviceInventorySubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceInventorySubAll(AssetsDeviceInventorySubDTO assetsDeviceInventorySubDTO);

	/**
	 * 批量更新对象 设备盘点子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceInventorySubList(@Param("dtoList") List<AssetsDeviceInventorySubDTO> dtoList);

	/**
	 * 按主键删除 设备盘点子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceInventorySubById(String id);

	/**
	 * 按主键批量删除 设备盘点子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceInventorySubList(List<String> idList);
}
