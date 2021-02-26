package avicit.assets.device.assetsdeviceregularcheck.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-03 15:41
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceRegularCheckDao {

	/**
	* 分页查询  设备定检
	* @param assetsDeviceRegularCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRegularCheckDTO>
	*/
	public Page<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByPage(
			@Param("bean") AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备定检
	* @param assetsDeviceRegularCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRegularCheckDTO>
	*/
	public Page<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByPageOr(
			@Param("bean") AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO, @Param("pOrderBy") String orderBy);


	/**
	 * 查询 设备定检
	 * @param id 主键id
	 * @return AssetsDeviceRegularCheckDTO
	 */
	public AssetsDeviceRegularCheckDTO findAssetsDeviceRegularCheckById(String id);

	/**
	* 新增设备定检
	* @param assetsDeviceRegularCheckDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceRegularCheck(AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO);

	/**
	 * 批量新增 设备定检
	 * @param assetsDeviceRegularCheckDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceRegularCheckList(List<AssetsDeviceRegularCheckDTO> assetsDeviceRegularCheckDTOList);

	/**
	 * 更新部分对象 设备定检
	 * @param assetsDeviceRegularCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRegularCheckSensitive(AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO);

	/**
	 * 更新全部对象 设备定检
	 * @param assetsDeviceRegularCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRegularCheckAll(AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO);

	/**
	 * 批量更新对象 设备定检
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceRegularCheckList(@Param("dtoList") List<AssetsDeviceRegularCheckDTO> dtoList);

	/**
	 * 按主键删除 设备定检
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceRegularCheckById(String id);

	/**
	 * 按主键批量删除 设备定检
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceRegularCheckList(List<String> idList);

	/**
	 * 按条件的查询列表 设备定检
	 * @param assetsDeviceRegularCheckDTO 查询对象
	 * @param orderBy 排序条件
	 * @return List<AssetsDeviceRegularCheckDTO>
	 */
	public List<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByList(@Param("bean") AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO,@Param("pOrderBy") String orderBy);
}
