package avicit.assets.device.assetsdevicemetering.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicemetering.dto.AssetsDeviceMeteringDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 16:14
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceMeteringDao {

	/**
	* 分页查询  设备计量
	* @param assetsDeviceMeteringDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMeteringDTO>
	*/
	public Page<AssetsDeviceMeteringDTO> searchAssetsDeviceMeteringByPage(
			@Param("bean") AssetsDeviceMeteringDTO assetsDeviceMeteringDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备计量
	* @param assetsDeviceMeteringDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMeteringDTO>
	*/
	public Page<AssetsDeviceMeteringDTO> searchAssetsDeviceMeteringByPageOr(
			@Param("bean") AssetsDeviceMeteringDTO assetsDeviceMeteringDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备计量
	* @param assetsDeviceMeteringDTO 查询对象
	* @return List<AssetsDeviceMeteringDTO>
	*/
	public List<AssetsDeviceMeteringDTO> searchAssetsDeviceMetering(AssetsDeviceMeteringDTO assetsDeviceMeteringDTO);

	/**
	 * 查询 设备计量
	 * @param id 主键id
	 * @return AssetsDeviceMeteringDTO
	 */
	public AssetsDeviceMeteringDTO findAssetsDeviceMeteringById(String id);

	/**
	 * 新增设备计量
	 * @param assetsDeviceMeteringDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceMetering(AssetsDeviceMeteringDTO assetsDeviceMeteringDTO);

	/**
	 * 批量新增 设备计量
	 * @param assetsDeviceMeteringDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceMeteringList(List<AssetsDeviceMeteringDTO> assetsDeviceMeteringDTOList);

	/**
	* 更新部分对象 设备计量
	* @param assetsDeviceMeteringDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceMeteringSensitive(AssetsDeviceMeteringDTO assetsDeviceMeteringDTO);

	/**
	 * 更新全部对象 设备计量
	 * @param assetsDeviceMeteringDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMeteringAll(AssetsDeviceMeteringDTO assetsDeviceMeteringDTO);

	/**
	 * 批量更新对象 设备计量
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceMeteringList(@Param("dtoList") List<AssetsDeviceMeteringDTO> dtoList);

	/**
	 * 按主键删除 设备计量
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceMeteringById(String id);

	/**
	 * 按主键批量删除 设备计量
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceMeteringList(List<String> idList);
}
