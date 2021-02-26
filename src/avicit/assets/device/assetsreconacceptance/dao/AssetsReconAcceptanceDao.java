package avicit.assets.device.assetsreconacceptance.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsreconacceptance.dto.AssetsReconAcceptanceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-11 17:21
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsReconAcceptanceDao {

	/**
	* 分页查询  大修改造验收表
	* @param assetsReconAcceptanceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconAcceptanceDTO>
	*/
	public Page<AssetsReconAcceptanceDTO> searchAssetsReconAcceptanceByPage(
            @Param("bean") AssetsReconAcceptanceDTO assetsReconAcceptanceDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 大修改造验收表
	* @param assetsReconAcceptanceDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsReconAcceptanceDTO>
	*/
	public Page<AssetsReconAcceptanceDTO> searchAssetsReconAcceptanceByPageOr(
            @Param("bean") AssetsReconAcceptanceDTO assetsReconAcceptanceDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询大修改造验收表
	* @param assetsReconAcceptanceDTO 查询对象
	* @return List<AssetsReconAcceptanceDTO>
	*/
	public List<AssetsReconAcceptanceDTO> searchAssetsReconAcceptance(
            AssetsReconAcceptanceDTO assetsReconAcceptanceDTO);

	/**
	 * 查询 大修改造验收表
	 * @param id 主键id
	 * @return AssetsReconAcceptanceDTO
	 */
	public AssetsReconAcceptanceDTO findAssetsReconAcceptanceById(String id);

	/**
	* 新增大修改造验收表
	* @param assetsReconAcceptanceDTO 保存对象
	* @return int
	*/
	public int insertAssetsReconAcceptance(AssetsReconAcceptanceDTO assetsReconAcceptanceDTO);

	/**
	 * 批量新增 大修改造验收表
	 * @param assetsReconAcceptanceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsReconAcceptanceList(List<AssetsReconAcceptanceDTO> assetsReconAcceptanceDTOList);

	/**
	 * 更新部分对象 大修改造验收表
	 * @param assetsReconAcceptanceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconAcceptanceSensitive(AssetsReconAcceptanceDTO assetsReconAcceptanceDTO);

	/**
	 * 更新全部对象 大修改造验收表
	 * @param assetsReconAcceptanceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconAcceptanceAll(AssetsReconAcceptanceDTO assetsReconAcceptanceDTO);

	/**
	 * 批量更新对象 大修改造验收表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsReconAcceptanceList(@Param("dtoList") List<AssetsReconAcceptanceDTO> dtoList);

	/**
	 * 按主键删除 大修改造验收表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsReconAcceptanceById(String id);

	/**
	 * 按主键批量删除 大修改造验收表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsReconAcceptanceList(List<String> idList);
}
