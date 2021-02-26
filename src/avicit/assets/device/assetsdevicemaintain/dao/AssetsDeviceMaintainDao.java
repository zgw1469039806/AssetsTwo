package avicit.assets.device.assetsdevicemaintain.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdevicemaintain.dto.AssetsDeviceMaintainDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-02 17:46
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceMaintainDao {

	/**
	* 分页查询  设备保养
	* @param assetsDeviceMaintainDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMaintainDTO>
	*/
	public Page<AssetsDeviceMaintainDTO> searchAssetsDeviceMaintainByPage(
			@Param("bean") AssetsDeviceMaintainDTO assetsDeviceMaintainDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备保养
	* @param assetsDeviceMaintainDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMaintainDTO>
	*/
	public Page<AssetsDeviceMaintainDTO> searchAssetsDeviceMaintainByPageOr(
			@Param("bean") AssetsDeviceMaintainDTO assetsDeviceMaintainDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备保养
	 * @param id 主键id
	 * @return AssetsDeviceMaintainDTO
	 */
	public AssetsDeviceMaintainDTO findAssetsDeviceMaintainById(String id);

	/**
	* 新增设备保养
	* @param assetsDeviceMaintainDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceMaintain(AssetsDeviceMaintainDTO assetsDeviceMaintainDTO);

	/**
	 * 批量新增 设备保养
	 * @param assetsDeviceMaintainDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceMaintainList(List<AssetsDeviceMaintainDTO> assetsDeviceMaintainDTOList);

	/**
	 * 更新部分对象 设备保养
	 * @param assetsDeviceMaintainDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMaintainSensitive(AssetsDeviceMaintainDTO assetsDeviceMaintainDTO);

	/**
	 * 更新全部对象 设备保养
	 * @param assetsDeviceMaintainDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMaintainAll(AssetsDeviceMaintainDTO assetsDeviceMaintainDTO);

	/**
	 * 批量更新对象 设备保养
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceMaintainList(@Param("dtoList") List<AssetsDeviceMaintainDTO> dtoList);

	/**
	 * 按主键删除 设备保养
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceMaintainById(String id);

	/**
	 * 按主键批量删除 设备保养
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceMaintainList(List<String> idList);
}
