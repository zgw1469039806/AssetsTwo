package avicit.assets.device.assetsdeviceacheckproc.dao;

import java.util.List;

import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceAcheckPlanDao {

	/**
	 * 分页查询  ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceAcheckPlanDTO>
	 */
	public Page<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanByPage(
			@Param("bean") AssetsDeviceAcheckPlanDTO assetsDeviceAcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceAcheckPlanDTO>
	 */
	public Page<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanByPageOr(
			@Param("bean") AssetsDeviceAcheckPlanDTO assetsDeviceAcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_DEVICE_ACHECK_PLAN 
	 * @param id 主键id
	 * @return AssetsDeviceAcheckPlanDTO
	 */
	public AssetsDeviceAcheckPlanDTO findAssetsDeviceAcheckPlanById(String id);

	/**
	 * 查询 ASSETS_DEVICE_ACHECK_PLAN
	 * @param pid 父id
	 * @return List<AssetsDeviceAcheckPlanDTO>
	 */
	public List<AssetsDeviceAcheckPlanDTO> findAssetsDeviceAcheckPlanByPid(String pid);

	/**
	 * 新增ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceAcheckPlan(AssetsDeviceAcheckPlanDTO assetsDeviceAcheckPlanDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceAcheckPlanList(List<AssetsDeviceAcheckPlanDTO> assetsDeviceAcheckPlanDTOList);

	/**
	 * 更新部分对象 ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAcheckPlanSensitive(AssetsDeviceAcheckPlanDTO assetsDeviceAcheckPlanDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_ACHECK_PLAN
	 * @param assetsDeviceAcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAcheckPlanAll(AssetsDeviceAcheckPlanDTO assetsDeviceAcheckPlanDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_ACHECK_PLAN
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceAcheckPlanList(@Param("dtoList") List<AssetsDeviceAcheckPlanDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_ACHECK_PLAN
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckPlanById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_ACHECK_PLAN
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceAcheckPlanList(List<String> idList);

	/**
	 *按计划ID查询AssetsDeviceAcheckPlanDTO根据台账记录ID和定检时间分组的日期最大的数据列表
	 * @param procId
	 * @return
	 */
	public List<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanMax(String procId);
}
