package avicit.assets.device.assetsdeviceacheckproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceAcheckProcDao {

	/**
	* 分页查询  设备精度检查计划表
	* @param assetsDeviceAcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAcheckProcDTO>
	*/
	public Page<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProcByPage(
			@Param("bean") AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备精度检查计划表
	* @param assetsDeviceAcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAcheckProcDTO>
	*/
	public Page<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProcByPageOr(
			@Param("bean") AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备精度检查计划表
	* @param assetsDeviceAcheckProcDTO 查询对象
	* @return List<AssetsDeviceAcheckProcDTO>
	*/
	public List<AssetsDeviceAcheckProcDTO> searchAssetsDeviceAcheckProc(
			AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO);

	/**
	 * 查询 设备精度检查计划表
	 * @param id 主键id
	 * @return AssetsDeviceAcheckProcDTO
	 */
	public AssetsDeviceAcheckProcDTO findAssetsDeviceAcheckProcById(String id);

	/**
	 * 新增设备精度检查计划表
	 * @param assetsDeviceAcheckProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceAcheckProc(AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO);

	/**
	 * 批量新增 设备精度检查计划表
	 * @param assetsDeviceAcheckProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceAcheckProcList(List<AssetsDeviceAcheckProcDTO> assetsDeviceAcheckProcDTOList);

	/**
	* 更新部分对象 设备精度检查计划表
	* @param assetsDeviceAcheckProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceAcheckProcSensitive(AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO);

	/**
	 * 更新全部对象 设备精度检查计划表
	 * @param assetsDeviceAcheckProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAcheckProcAll(AssetsDeviceAcheckProcDTO assetsDeviceAcheckProcDTO);

	/**
	 * 批量更新对象 设备精度检查计划表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceAcheckProcList(@Param("dtoList") List<AssetsDeviceAcheckProcDTO> dtoList);

	/**
	 * 按主键删除 设备精度检查计划表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckProcById(String id);

	/**
	 * 按主键批量删除 设备精度检查计划表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckProcList(List<String> idList);
}
