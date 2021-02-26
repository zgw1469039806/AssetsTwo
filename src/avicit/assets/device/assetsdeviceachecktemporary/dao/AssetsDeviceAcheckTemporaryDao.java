package avicit.assets.device.assetsdeviceachecktemporary.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 08:40
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceAcheckTemporaryDao {

	/**
	* 分页查询  ASSETS_DEVICE_ACHECK_TEMPORARY
	* @param assetsDeviceAcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporaryByPage(
			@Param("bean") AssetsDeviceAcheckTemporaryDTO assetsDeviceAcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_DEVICE_ACHECK_TEMPORARY
	* @param assetsDeviceAcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporaryByPageOr(
			@Param("bean") AssetsDeviceAcheckTemporaryDTO assetsDeviceAcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param id 主键id
	 * @return AssetsDeviceAcheckTemporaryDTO
	 */
	public AssetsDeviceAcheckTemporaryDTO findAssetsDeviceAcheckTemporaryById(String id);

	/**
	* 新增ASSETS_DEVICE_ACHECK_TEMPORARY
	* @param assetsDeviceAcheckTemporaryDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceAcheckTemporary(AssetsDeviceAcheckTemporaryDTO assetsDeviceAcheckTemporaryDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param assetsDeviceAcheckTemporaryDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceAcheckTemporaryList(
			List<AssetsDeviceAcheckTemporaryDTO> assetsDeviceAcheckTemporaryDTOList);

	/**
	 * 更新部分对象 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param assetsDeviceAcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAcheckTemporarySensitive(
			AssetsDeviceAcheckTemporaryDTO assetsDeviceAcheckTemporaryDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param assetsDeviceAcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAcheckTemporaryAll(AssetsDeviceAcheckTemporaryDTO assetsDeviceAcheckTemporaryDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceAcheckTemporaryList(@Param("dtoList") List<AssetsDeviceAcheckTemporaryDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckTemporaryById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_ACHECK_TEMPORARY
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckTemporaryList(List<String> idList);


	/**
	 * 清空数据表
	 * @return
	 */
	public int deleteAssetsDeviceAcheckTemporaryAll();

	/**
	 * 查询数据列表
	 * @return
	 */
	public List<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporary();

	/**
	 * 查询当前表中按精度台账表ID分组最大时间列表
	 * @return
	 */
	public  List<AssetsDeviceAcheckTemporaryDTO>   searchAssetsDeviceAcheckTemporaryMax();
}
