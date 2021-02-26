package avicit.assets.device.assetsdevicercheckproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:33
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceRcheckPlanDao {

	/**
	 * 分页查询  定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceRcheckPlanDTO>
	 */
	public Page<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanByPage(
			@Param("bean") AssetsDeviceRcheckPlanDTO assetsDeviceRcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceRcheckPlanDTO>
	 */
	public Page<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanByPageOr(
			@Param("bean") AssetsDeviceRcheckPlanDTO assetsDeviceRcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 定期检查设备详情表 
	 * @param id 主键id
	 * @return AssetsDeviceRcheckPlanDTO
	 */
	public AssetsDeviceRcheckPlanDTO findAssetsDeviceRcheckPlanById(String id);

	/**
	 * 查询 定期检查设备详情表
	 * @param pid 父id
	 * @return List<AssetsDeviceRcheckPlanDTO>
	 */
	public List<AssetsDeviceRcheckPlanDTO> findAssetsDeviceRcheckPlanByPid(String pid);

	/**
	 * 新增定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceRcheckPlan(AssetsDeviceRcheckPlanDTO assetsDeviceRcheckPlanDTO);

	/**
	 * 批量新增 定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceRcheckPlanList(List<AssetsDeviceRcheckPlanDTO> assetsDeviceRcheckPlanDTOList);

	/**
	 * 更新部分对象 定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRcheckPlanSensitive(AssetsDeviceRcheckPlanDTO assetsDeviceRcheckPlanDTO);

	/**
	 * 更新全部对象 定期检查设备详情表
	 * @param assetsDeviceRcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRcheckPlanAll(AssetsDeviceRcheckPlanDTO assetsDeviceRcheckPlanDTO);

	/**
	 * 批量更新对象 定期检查设备详情表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceRcheckPlanList(@Param("dtoList") List<AssetsDeviceRcheckPlanDTO> dtoList);

	/**
	 * 按主键删除 定期检查设备详情表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckPlanById(String id);

	/**
	 * 按主键批量删除 定期检查设备详情表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckPlanList(List<String> idList);

	/**
	 *按计划ID查询ASSETS_DEVICE_RCHECK_PLAN根据台账记录ID和定检时间分组的日期最大的数据列表
	 * @param procId
	 * @return
	 */
	public List<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanMax(String procId);

	/**
	 *按计划ID查询ASSETS_DEVICE_RCHECK_PLAN根据台账记录ID和定检时间分组的日期最大的数据列表
	 * @param procId
	 * @return
	 */
	public List<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanList(String procId);
}
