package avicit.assets.device.assetsdevicemetering.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicemetering.dto.DynDeviceToolDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 16:14
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DynDeviceToolDao {

	/**
	 * 分页查询  DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<DynDeviceToolDTO>
	 */
	public Page<DynDeviceToolDTO> searchDynDeviceToolByPage(@Param("bean") DynDeviceToolDTO dynDeviceToolDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<DynDeviceToolDTO>
	 */
	public Page<DynDeviceToolDTO> searchDynDeviceToolByPageOr(@Param("bean") DynDeviceToolDTO dynDeviceToolDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 查询 DYN_DEVICE_TOOL 
	 * @param id 主键id
	 * @return DynDeviceToolDTO
	 */
	public DynDeviceToolDTO findDynDeviceToolById(String id);

	/**
	 * 查询 DYN_DEVICE_TOOL
	 * @param pid 父id
	 * @return List<DynDeviceToolDTO>
	 */
	public List<DynDeviceToolDTO> findDynDeviceToolByPid(String pid);

	/**
	 * 新增DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTO 保存对象
	 * @return int
	 */
	public int insertDynDeviceTool(DynDeviceToolDTO dynDeviceToolDTO);

	/**
	 * 批量新增 DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynDeviceToolList(List<DynDeviceToolDTO> dynDeviceToolDTOList);

	/**
	 * 更新部分对象 DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTO 更新对象
	 * @return int
	 */
	public int updateDynDeviceToolSensitive(DynDeviceToolDTO dynDeviceToolDTO);

	/**
	 * 更新全部对象 DYN_DEVICE_TOOL
	 * @param dynDeviceToolDTO 更新对象
	 * @return int
	 */
	public int updateDynDeviceToolAll(DynDeviceToolDTO dynDeviceToolDTO);

	/**
	 * 批量更新对象 DYN_DEVICE_TOOL
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynDeviceToolList(@Param("dtoList") List<DynDeviceToolDTO> dtoList);

	/**
	 * 按主键删除 DYN_DEVICE_TOOL
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynDeviceToolById(String id);

	/**
	 * 按主键批量删除 DYN_DEVICE_TOOL
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynDeviceToolList(List<String> idList);
}
