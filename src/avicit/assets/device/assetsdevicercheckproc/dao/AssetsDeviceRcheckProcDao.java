package avicit.assets.device.assetsdevicercheckproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:33
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceRcheckProcDao {

	/**
	* 分页查询  定期检查列表主表
	* @param assetsDeviceRcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRcheckProcDTO>
	*/
	public Page<AssetsDeviceRcheckProcDTO> searchAssetsDeviceRcheckProcByPage(
			@Param("bean") AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 定期检查列表主表
	* @param assetsDeviceRcheckProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRcheckProcDTO>
	*/
	public Page<AssetsDeviceRcheckProcDTO> searchAssetsDeviceRcheckProcByPageOr(
			@Param("bean") AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 定期检查列表主表
	* @param assetsDeviceRcheckProcDTO 查询对象
	* @return List<AssetsDeviceRcheckProcDTO>
	*/
	public List<AssetsDeviceRcheckProcDTO> searchAssetsDeviceRcheckProc(
			AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO);

	/**
	 * 查询 定期检查列表主表
	 * @param id 主键id
	 * @return AssetsDeviceRcheckProcDTO
	 */
	public AssetsDeviceRcheckProcDTO findAssetsDeviceRcheckProcById(String id);

	/**
	 * 新增定期检查列表主表
	 * @param assetsDeviceRcheckProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceRcheckProc(AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO);

	/**
	 * 批量新增 定期检查列表主表
	 * @param assetsDeviceRcheckProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceRcheckProcList(List<AssetsDeviceRcheckProcDTO> assetsDeviceRcheckProcDTOList);

	/**
	* 更新部分对象 定期检查列表主表
	* @param assetsDeviceRcheckProcDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceRcheckProcSensitive(AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO);

	/**
	 * 更新全部对象 定期检查列表主表
	 * @param assetsDeviceRcheckProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRcheckProcAll(AssetsDeviceRcheckProcDTO assetsDeviceRcheckProcDTO);

	/**
	 * 批量更新对象 定期检查列表主表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceRcheckProcList(@Param("dtoList") List<AssetsDeviceRcheckProcDTO> dtoList);

	/**
	 * 按主键删除 定期检查列表主表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckProcById(String id);

	/**
	 * 按主键批量删除 定期检查列表主表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckProcList(List<String> idList);
}
