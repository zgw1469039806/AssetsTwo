package avicit.assets.device.assetsreconstructioncheck.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsreconstructioncheck.dto.AssetsReconstructionCheckDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-02 09:07
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsReconstructionCheckDao {

	/**
	* 分页查询  设备临时大修改造申请表单
	* @param assetsReconstructionCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconstructionCheckDTO>
	*/
	public Page<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheckByPage(
            @Param("bean") AssetsReconstructionCheckDTO assetsReconstructionCheckDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备临时大修改造申请表单
	* @param assetsReconstructionCheckDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconstructionCheckDTO>
	*/
	public Page<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheckByPageOr(
            @Param("bean") AssetsReconstructionCheckDTO assetsReconstructionCheckDTO,
            @Param("pOrderBy") String orderBy);

	/**
	* 查询设备临时大修改造申请表单
	* @param assetsReconstructionCheckDTO 查询对象
	* @return List<AssetsReconstructionCheckDTO>
	*/
	public List<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheck(
            AssetsReconstructionCheckDTO assetsReconstructionCheckDTO);
	/**
	 * 查询 设备临时大修改造申请表单 
	 * @param id 主键id
	 * @return AssetsReconstructionCheckDTO
	 */
	public AssetsReconstructionCheckDTO findAssetsReconstructionCheckById(String id);

	/**
	 * 查询 设备临时大修改造申请表单
	 * @param pid 父id
	 * @return List<AssetsReconstructionCheckDTO>
	 */
	public List<AssetsReconstructionCheckDTO> findAssetsReconstructionCheckByPid(String pid);
	/**
	* 新增设备临时大修改造申请表单
	* @param assetsReconstructionCheckDTO 保存对象
	* @return int
	*/
	public int insertAssetsReconstructionCheck(AssetsReconstructionCheckDTO assetsReconstructionCheckDTO);

	/**
	 * 批量新增 设备临时大修改造申请表单
	 * @param assetsReconstructionCheckDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsReconstructionCheckList(List<AssetsReconstructionCheckDTO> assetsReconstructionCheckDTOList);

	/**
	 * 更新部分对象 设备临时大修改造申请表单
	 * @param assetsReconstructionCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionCheckSensitive(AssetsReconstructionCheckDTO assetsReconstructionCheckDTO);

	/**
	 * 更新全部对象 设备临时大修改造申请表单
	 * @param assetsReconstructionCheckDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionCheckAll(AssetsReconstructionCheckDTO assetsReconstructionCheckDTO);

	/**
	 * 批量更新对象 设备临时大修改造申请表单
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsReconstructionCheckList(@Param("dtoList") List<AssetsReconstructionCheckDTO> dtoList);

	/**
	 * 按主键删除 设备临时大修改造申请表单
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsReconstructionCheckById(String id);

	/**
	 * 按主键批量删除 设备临时大修改造申请表单
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsReconstructionCheckList(List<String> idList);
}
