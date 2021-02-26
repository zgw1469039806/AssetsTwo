package avicit.assets.device.dynassetsreconst.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynassetsreconst.dto.AssetsReconstructionRDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 18:52
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsReconstructionRDao {

	/**
	 * 分页查询  大修改造下发
	 * @param assetsReconstructionRDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsReconstructionRDTO>
	 */
	public Page<AssetsReconstructionRDTO> searchAssetsReconstructionRByPage(
            @Param("bean") AssetsReconstructionRDTO assetsReconstructionRDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 大修改造下发
	 * @param assetsReconstructionRDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsReconstructionRDTO>
	 */
	public Page<AssetsReconstructionRDTO> searchAssetsReconstructionRByPageOr(
            @Param("bean") AssetsReconstructionRDTO assetsReconstructionRDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 大修改造下发 
	 * @param id 主键id
	 * @return AssetsReconstructionRDTO
	 */
	public AssetsReconstructionRDTO findAssetsReconstructionRById(String id);

	/**
	 * 查询 大修改造下发
	 * @param pid 父id
	 * @return List<AssetsReconstructionRDTO>
	 */
	public List<AssetsReconstructionRDTO> findAssetsReconstructionRByPid(String pid);

	/**
	 * 新增大修改造下发
	 * @param assetsReconstructionRDTO 保存对象
	 * @return int
	 */
	public int insertAssetsReconstructionR(AssetsReconstructionRDTO assetsReconstructionRDTO);

	/**
	 * 批量新增 大修改造下发
	 * @param assetsReconstructionRDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsReconstructionRList(List<AssetsReconstructionRDTO> assetsReconstructionRDTOList);

	/**
	 * 更新部分对象 大修改造下发
	 * @param assetsReconstructionRDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionRSensitive(AssetsReconstructionRDTO assetsReconstructionRDTO);

	/**
	 * 更新全部对象 大修改造下发
	 * @param assetsReconstructionRDTO 更新对象
	 * @return int
	 */
	public int updateAssetsReconstructionRAll(AssetsReconstructionRDTO assetsReconstructionRDTO);

	/**
	 * 批量更新对象 大修改造下发
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsReconstructionRList(@Param("dtoList") List<AssetsReconstructionRDTO> dtoList);

	/**
	 * 按主键删除 大修改造下发
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsReconstructionRById(String id);

	/**
	 * 按主键批量删除 大修改造下发
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsReconstructionRList(List<String> idList);
}
