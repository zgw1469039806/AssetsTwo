package avicit.assets.device.assetsdeviceunused.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceunused.dto.AssetsDeviceUnusedDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 11:10
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceUnusedDao {

	/**
	* 分页查询  设备闲置
	* @param assetsDeviceUnusedDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceUnusedDTO>
	*/
	public Page<AssetsDeviceUnusedDTO> searchAssetsDeviceUnusedByPage(
            @Param("bean") AssetsDeviceUnusedDTO assetsDeviceUnusedDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备闲置
	* @param assetsDeviceUnusedDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceUnusedDTO>
	*/
	public Page<AssetsDeviceUnusedDTO> searchAssetsDeviceUnusedByPageOr(
            @Param("bean") AssetsDeviceUnusedDTO assetsDeviceUnusedDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备闲置
	* @param assetsDeviceUnusedDTO 查询对象
	* @return List<AssetsDeviceUnusedDTO>
	*/
	public List<AssetsDeviceUnusedDTO> searchAssetsDeviceUnused(AssetsDeviceUnusedDTO assetsDeviceUnusedDTO);

	/**
	 * 查询 设备闲置
	 * @param id 主键id
	 * @return AssetsDeviceUnusedDTO
	 */
	public AssetsDeviceUnusedDTO findAssetsDeviceUnusedById(String id);

	/**
	 * 新增设备闲置
	 * @param assetsDeviceUnusedDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceUnused(AssetsDeviceUnusedDTO assetsDeviceUnusedDTO);

	/**
	 * 批量新增 设备闲置
	 * @param assetsDeviceUnusedDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceUnusedList(List<AssetsDeviceUnusedDTO> assetsDeviceUnusedDTOList);

	/**
	* 更新部分对象 设备闲置
	* @param assetsDeviceUnusedDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceUnusedSensitive(AssetsDeviceUnusedDTO assetsDeviceUnusedDTO);

	/**
	 * 更新全部对象 设备闲置
	 * @param assetsDeviceUnusedDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceUnusedAll(AssetsDeviceUnusedDTO assetsDeviceUnusedDTO);

	/**
	 * 批量更新对象 设备闲置
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceUnusedList(@Param("dtoList") List<AssetsDeviceUnusedDTO> dtoList);

	/**
	 * 按主键删除 设备闲置
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceUnusedById(String id);

	/**
	 * 按主键批量删除 设备闲置
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceUnusedList(List<String> idList);
}
