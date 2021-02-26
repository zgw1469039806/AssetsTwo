package avicit.assets.device.assetsdeviceacccheck.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-04 12:51
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceAccCheckDao {

	/**
	* 分页查询  设备精度检查
	* @param assetsDeviceAccCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAccCheckDTO>
	*/
	public Page<AssetsDeviceAccCheckDTO> searchAssetsDeviceAccCheckByPage(
			@Param("bean") AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备精度检查
	* @param assetsDeviceAccCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAccCheckDTO>
	*/
	public Page<AssetsDeviceAccCheckDTO> searchAssetsDeviceAccCheckByPageOr(
			@Param("bean") AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备精度检查
	 * @param id 主键id
	 * @return AssetsDeviceAccCheckDTO
	 */
	public AssetsDeviceAccCheckDTO findAssetsDeviceAccCheckById(String id);

	/**
	* 新增设备精度检查
	* @param assetsDeviceAccCheckDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceAccCheck(AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO);

	/**
	 * 批量新增 设备精度检查
	 * @param assetsDeviceAccCheckDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceAccCheckList(List<AssetsDeviceAccCheckDTO> assetsDeviceAccCheckDTOList);

	/**
	 * 更新部分对象 设备精度检查
	 * @param assetsDeviceAccCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAccCheckSensitive(AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO);

	/**
	 * 更新全部对象 设备精度检查
	 * @param assetsDeviceAccCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAccCheckAll(AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO);

	/**
	 * 批量更新对象 设备精度检查
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceAccCheckList(@Param("dtoList") List<AssetsDeviceAccCheckDTO> dtoList);

	/**
	 * 按主键删除 设备精度检查
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceAccCheckById(String id);

	/**
	 * 按主键批量删除 设备精度检查
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceAccCheckList(List<String> idList);
}
