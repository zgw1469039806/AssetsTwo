package avicit.assets.device.assetsdevicemchecktemporary.dao;

import java.util.List;

import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdevicemchecktemporary.dto.AssetsDeviceMcheckTemporaryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 16:09
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceMcheckTemporaryDao {

	/**
	* 分页查询  ASSETS_DEVICE_MCHECK_TEMPORARY
	* @param assetsDeviceMcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporaryByPage(
			@Param("bean") AssetsDeviceMcheckTemporaryDTO assetsDeviceMcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_DEVICE_MCHECK_TEMPORARY
	* @param assetsDeviceMcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporaryByPageOr(
			@Param("bean") AssetsDeviceMcheckTemporaryDTO assetsDeviceMcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param id 主键id
	 * @return AssetsDeviceMcheckTemporaryDTO
	 */
	public AssetsDeviceMcheckTemporaryDTO findAssetsDeviceMcheckTemporaryById(String id);

	/**
	* 新增ASSETS_DEVICE_MCHECK_TEMPORARY
	* @param assetsDeviceMcheckTemporaryDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceMcheckTemporary(AssetsDeviceMcheckTemporaryDTO assetsDeviceMcheckTemporaryDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param assetsDeviceMcheckTemporaryDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceMcheckTemporaryList(
			List<AssetsDeviceMcheckTemporaryDTO> assetsDeviceMcheckTemporaryDTOList);

	/**
	 * 更新部分对象 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param assetsDeviceMcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMcheckTemporarySensitive(
			AssetsDeviceMcheckTemporaryDTO assetsDeviceMcheckTemporaryDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param assetsDeviceMcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMcheckTemporaryAll(AssetsDeviceMcheckTemporaryDTO assetsDeviceMcheckTemporaryDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceMcheckTemporaryList(@Param("dtoList") List<AssetsDeviceMcheckTemporaryDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckTemporaryById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_MCHECK_TEMPORARY
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckTemporaryList(List<String> idList);


	/**
	 * 清空数据表
	 * @return
	 */
	public int deleteAssetsDeviceMcheckTemporaryAll();

	/**
	 * 查询数据列表
	 * @return
	 */
	public List<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporary();

	/**
	 * 查询当前表中按精度台账表ID分组最大时间列表
	 * @return
	 */
	public  List<AssetsDeviceMcheckTemporaryDTO>   searchAssetsDeviceMcheckTemporaryMax();
}
