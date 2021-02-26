package avicit.assets.device.assetsdevicespotcheck.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdevicespotcheck.dto.AssetsDeviceSpotCheckDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-03 16:36
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceSpotCheckDao {

	/**
	* 分页查询  设备点检
	* @param assetsDeviceSpotCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceSpotCheckDTO>
	*/
	public Page<AssetsDeviceSpotCheckDTO> searchAssetsDeviceSpotCheckByPage(
			@Param("bean") AssetsDeviceSpotCheckDTO assetsDeviceSpotCheckDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备点检
	* @param assetsDeviceSpotCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceSpotCheckDTO>
	*/
	public Page<AssetsDeviceSpotCheckDTO> searchAssetsDeviceSpotCheckByPageOr(
			@Param("bean") AssetsDeviceSpotCheckDTO assetsDeviceSpotCheckDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备点检
	 * @param id 主键id
	 * @return AssetsDeviceSpotCheckDTO
	 */
	public AssetsDeviceSpotCheckDTO findAssetsDeviceSpotCheckById(String id);

	/**
	* 新增设备点检
	* @param assetsDeviceSpotCheckDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceSpotCheck(AssetsDeviceSpotCheckDTO assetsDeviceSpotCheckDTO);

	/**
	 * 批量新增 设备点检
	 * @param assetsDeviceSpotCheckDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceSpotCheckList(List<AssetsDeviceSpotCheckDTO> assetsDeviceSpotCheckDTOList);

	/**
	 * 更新部分对象 设备点检
	 * @param assetsDeviceSpotCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceSpotCheckSensitive(AssetsDeviceSpotCheckDTO assetsDeviceSpotCheckDTO);

	/**
	 * 更新全部对象 设备点检
	 * @param assetsDeviceSpotCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceSpotCheckAll(AssetsDeviceSpotCheckDTO assetsDeviceSpotCheckDTO);

	/**
	 * 批量更新对象 设备点检
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceSpotCheckList(@Param("dtoList") List<AssetsDeviceSpotCheckDTO> dtoList);

	/**
	 * 按主键删除 设备点检
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceSpotCheckById(String id);

	/**
	 * 按主键批量删除 设备点检
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceSpotCheckList(List<String> idList);
}
