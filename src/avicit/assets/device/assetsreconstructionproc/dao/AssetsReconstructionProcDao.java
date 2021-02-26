package avicit.assets.device.assetsreconstructionproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsreconstructionproc.dto.AssetsReconstructionProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-24 11:41
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsReconstructionProcDao {

	/**
	* 分页查询  ASSETS_RECONSTRUCTION_PROC
	* @param assetsReconstructionProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconstructionProcDTO>
	*/
	public Page<AssetsReconstructionProcDTO> searchAssetsReconstructionProcByPage(
			@Param("bean") AssetsReconstructionProcDTO assetsReconstructionProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_RECONSTRUCTION_PROC
	* @param assetsReconstructionProcDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconstructionProcDTO>
	*/
	public Page<AssetsReconstructionProcDTO> searchAssetsReconstructionProcByPageOr(
			@Param("bean") AssetsReconstructionProcDTO assetsReconstructionProcDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询ASSETS_RECONSTRUCTION_PROC
	* @param assetsReconstructionProcDTO 查询对象
	* @return List<AssetsReconstructionProcDTO>
	*/
	public List<AssetsReconstructionProcDTO> searchAssetsReconstructionProc(
			AssetsReconstructionProcDTO assetsReconstructionProcDTO);

	/**
	 * 查询 ASSETS_RECONSTRUCTION_PROC
	 * @param id 主键id
	 * @return AssetsReconstructionProcDTO
	 */
	public AssetsReconstructionProcDTO findAssetsReconstructionProcById(String id);

	/**
	* 新增ASSETS_RECONSTRUCTION_PROC
	* @param assetsReconstructionProcDTO 保存对象
	* @return int
	*/
	public int insertAssetsReconstructionProc(AssetsReconstructionProcDTO assetsReconstructionProcDTO);

	/**
	 * 批量新增 ASSETS_RECONSTRUCTION_PROC
	 * @param assetsReconstructionProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsReconstructionProcList(List<AssetsReconstructionProcDTO> assetsReconstructionProcDTOList);

	/**
	 * 更新部分对象 ASSETS_RECONSTRUCTION_PROC
	 * @param assetsReconstructionProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionProcSensitive(AssetsReconstructionProcDTO assetsReconstructionProcDTO);

	/**
	 * 更新全部对象 ASSETS_RECONSTRUCTION_PROC
	 * @param assetsReconstructionProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionProcAll(AssetsReconstructionProcDTO assetsReconstructionProcDTO);

	/**
	 * 批量更新对象 ASSETS_RECONSTRUCTION_PROC
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsReconstructionProcList(@Param("dtoList") List<AssetsReconstructionProcDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_RECONSTRUCTION_PROC
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsReconstructionProcById(String id);

	/**
	 * 按主键批量删除 ASSETS_RECONSTRUCTION_PROC
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsReconstructionProcList(List<String> idList);
}
