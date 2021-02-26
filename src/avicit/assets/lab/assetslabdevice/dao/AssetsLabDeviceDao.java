package avicit.assets.lab.assetslabdevice.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.lab.assetslabdevice.dto.AssetsLabDeviceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 15:47
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsLabDeviceDao {

	/**
	* 分页查询  实验室和设备关联表
	* @param assetsLabDeviceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabDeviceDTO>
	*/
	public Page<AssetsLabDeviceDTO> searchAssetsLabDeviceByPage(@Param("bean") AssetsLabDeviceDTO assetsLabDeviceDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 实验室和设备关联表
	* @param assetsLabDeviceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabDeviceDTO>
	*/
	public Page<AssetsLabDeviceDTO> searchAssetsLabDeviceByPageOr(@Param("bean") AssetsLabDeviceDTO assetsLabDeviceDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 查询 实验室和设备关联表
	 * @param id 主键id
	 * @return AssetsLabDeviceDTO
	 */
	public AssetsLabDeviceDTO findAssetsLabDeviceById(String id);

	/**
	* 新增实验室和设备关联表
	* @param assetsLabDeviceDTO 保存对象
	* @return int
	*/
	public int insertAssetsLabDevice(AssetsLabDeviceDTO assetsLabDeviceDTO);

	/**
	 * 批量新增 实验室和设备关联表
	 * @param assetsLabDeviceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsLabDeviceList(List<AssetsLabDeviceDTO> assetsLabDeviceDTOList);

	/**
	 * 更新部分对象 实验室和设备关联表
	 * @param assetsLabDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabDeviceSensitive(AssetsLabDeviceDTO assetsLabDeviceDTO);

	/**
	 * 更新全部对象 实验室和设备关联表
	 * @param assetsLabDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabDeviceAll(AssetsLabDeviceDTO assetsLabDeviceDTO);

	/**
	 * 批量更新对象 实验室和设备关联表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsLabDeviceList(@Param("dtoList") List<AssetsLabDeviceDTO> dtoList);

	/**
	 * 按主键删除 实验室和设备关联表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsLabDeviceById(String id);

	/**
	 * 按主键批量删除 实验室和设备关联表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsLabDeviceList(List<String> idList);
}
