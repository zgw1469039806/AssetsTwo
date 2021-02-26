package avicit.assets.device.assetsoperationcertificate.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationDeviceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 14:05
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsOperationDeviceDao {

	/**
	 * 分页查询  操作证设备关联表
	 * @param assetsOperationDeviceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsOperationDeviceDTO>
	 */
	public Page<AssetsOperationDeviceDTO> searchAssetsOperationDeviceByPage(
			@Param("bean") AssetsOperationDeviceDTO assetsOperationDeviceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 操作证设备关联表
	 * @param assetsOperationDeviceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsOperationDeviceDTO>
	 */
	public Page<AssetsOperationDeviceDTO> searchAssetsOperationDeviceByPageOr(
			@Param("bean") AssetsOperationDeviceDTO assetsOperationDeviceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 操作证设备关联表 
	 * @param id 主键id
	 * @return AssetsOperationDeviceDTO
	 */
	public AssetsOperationDeviceDTO findAssetsOperationDeviceById(String id);

	/**
	 * 查询 操作证设备关联表
	 * @param pid 父id
	 * @return List<AssetsOperationDeviceDTO>
	 */
	public List<AssetsOperationDeviceDTO> findAssetsOperationDeviceByPid(String pid);

	/**
	 * 新增操作证设备关联表
	 * @param assetsOperationDeviceDTO 保存对象
	 * @return int
	 */
	public int insertAssetsOperationDevice(AssetsOperationDeviceDTO assetsOperationDeviceDTO);

	/**
	 * 批量新增 操作证设备关联表
	 * @param assetsOperationDeviceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsOperationDeviceList(List<AssetsOperationDeviceDTO> assetsOperationDeviceDTOList);

	/**
	 * 更新部分对象 操作证设备关联表
	 * @param assetsOperationDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsOperationDeviceSensitive(AssetsOperationDeviceDTO assetsOperationDeviceDTO);

	/**
	 * 更新全部对象 操作证设备关联表
	 * @param assetsOperationDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsOperationDeviceAll(AssetsOperationDeviceDTO assetsOperationDeviceDTO);

	/**
	 * 批量更新对象 操作证设备关联表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsOperationDeviceList(@Param("dtoList") List<AssetsOperationDeviceDTO> dtoList);

	/**
	 * 按主键删除 操作证设备关联表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsOperationDeviceById(String id);

	/**
	 * 按主键批量删除 操作证设备关联表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsOperationDeviceList(List<String> idList);
}
