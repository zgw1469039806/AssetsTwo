package avicit.assets.device.assetsdevicemcheckproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceMcheckPlanDao {

	/**
	 * 分页查询  ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceMcheckPlanDTO>
	 */
	public Page<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanByPage(
			@Param("bean") AssetsDeviceMcheckPlanDTO assetsDeviceMcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceMcheckPlanDTO>
	 */
	public Page<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanByPageOr(
			@Param("bean") AssetsDeviceMcheckPlanDTO assetsDeviceMcheckPlanDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_DEVICE_MCHECK_PLAN 
	 * @param id 主键id
	 * @return AssetsDeviceMcheckPlanDTO
	 */
	public AssetsDeviceMcheckPlanDTO findAssetsDeviceMcheckPlanById(String id);

	/**
	 * 查询 ASSETS_DEVICE_MCHECK_PLAN
	 * @param pid 父id
	 * @return List<AssetsDeviceMcheckPlanDTO>
	 */
	public List<AssetsDeviceMcheckPlanDTO> findAssetsDeviceMcheckPlanByPid(String pid);

	/**
	 * 新增ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceMcheckPlan(AssetsDeviceMcheckPlanDTO assetsDeviceMcheckPlanDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceMcheckPlanList(List<AssetsDeviceMcheckPlanDTO> assetsDeviceMcheckPlanDTOList);

	/**
	 * 更新部分对象 ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMcheckPlanSensitive(AssetsDeviceMcheckPlanDTO assetsDeviceMcheckPlanDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_MCHECK_PLAN
	 * @param assetsDeviceMcheckPlanDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceMcheckPlanAll(AssetsDeviceMcheckPlanDTO assetsDeviceMcheckPlanDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_MCHECK_PLAN
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceMcheckPlanList(@Param("dtoList") List<AssetsDeviceMcheckPlanDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_MCHECK_PLAN
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckPlanById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_MCHECK_PLAN
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceMcheckPlanList(List<String> idList);

	/**
	 * 按计划ID查询ASSETS_DEVICE_MCHECK_PLAN根据台账记录ID和定检时间分组的日期最大的数据列表
	 * @param procId
	 * @return List<AssetsDeviceMcheckPlanDTO>
	 */
	public List<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanMax(String procId);
}
