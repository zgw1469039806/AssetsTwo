package avicit.assets.device.assetsdevicemcheckproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceMcheckProcDao {

	/**
	* 分页查询  ASSETS_DEVICE_MCHECK_PROC
	* @param assetsDeviceMcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMcheckProcDTO>
	*/
	public Page<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProcByPage(
			@Param("bean") AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_DEVICE_MCHECK_PROC
	* @param assetsDeviceMcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceMcheckProcDTO>
	*/
	public Page<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProcByPageOr(
			@Param("bean") AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 ASSETS_DEVICE_MCHECK_PROC
	* @param assetsDeviceMcheckProcDTO 查询对象
	* @return List<AssetsDeviceMcheckProcDTO>
	*/
	public List<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProc(
			AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO);

	/**
	 * 查询 ASSETS_DEVICE_MCHECK_PROC
	 * @param id 主键id
	 * @return AssetsDeviceMcheckProcDTO
	 */
	public AssetsDeviceMcheckProcDTO findAssetsDeviceMcheckProcById(String id);

	/**
	 * 新增ASSETS_DEVICE_MCHECK_PROC
	 * @param assetsDeviceMcheckProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceMcheckProc(AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_MCHECK_PROC
	 * @param assetsDeviceMcheckProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceMcheckProcList(List<AssetsDeviceMcheckProcDTO> assetsDeviceMcheckProcDTOList);

	/**
	* 更新部分对象 ASSETS_DEVICE_MCHECK_PROC
	* @param assetsDeviceMcheckProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceMcheckProcSensitive(AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_MCHECK_PROC
	 * @param assetsDeviceMcheckProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMcheckProcAll(AssetsDeviceMcheckProcDTO assetsDeviceMcheckProcDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_MCHECK_PROC
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceMcheckProcList(@Param("dtoList") List<AssetsDeviceMcheckProcDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_MCHECK_PROC
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckProcById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_MCHECK_PROC
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckProcList(List<String> idList);
}
