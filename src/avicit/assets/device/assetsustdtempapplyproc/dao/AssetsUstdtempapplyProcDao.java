package avicit.assets.device.assetsustdtempapplyproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdtempapplyproc.dto.AssetsUstdtempapplyProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-23 16:56
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdtempapplyProcDao {

	/**
	 * 分页查询  ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsUstdtempapplyProcDTO>
	 */
	public Page<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProcByPage(
			@Param("bean") AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsUstdtempapplyProcDTO>
	 */
	public Page<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProcByPageOr(
			@Param("bean") AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 查询对象
	 * @return List<AssetsUstdtempapplyProcDTO>
	 */
	public List<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProc(
			AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO);

	/**
	 * 查询 ASSETS_USTDTEMPAPPLY_PROC
	 * @param id 主键id
	 * @return AssetsUstdtempapplyProcDTO
	 */
	public AssetsUstdtempapplyProcDTO findAssetsUstdtempapplyProcById(String id);

	/**
	 * 新增ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 保存对象
	 * @return int
	 */
	public int insertAssetsUstdtempapplyProc(AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO);

	/**
	 * 批量新增 ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsUstdtempapplyProcList(List<AssetsUstdtempapplyProcDTO> assetsUstdtempapplyProcDTOList);

	/**
	 * 更新部分对象 ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUstdtempapplyProcSensitive(AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO);

	/**
	 * 更新全部对象 ASSETS_USTDTEMPAPPLY_PROC
	 * @param assetsUstdtempapplyProcDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUstdtempapplyProcAll(AssetsUstdtempapplyProcDTO assetsUstdtempapplyProcDTO);

	/**
	 * 批量更新对象 ASSETS_USTDTEMPAPPLY_PROC
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsUstdtempapplyProcList(@Param("dtoList") List<AssetsUstdtempapplyProcDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_USTDTEMPAPPLY_PROC
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsUstdtempapplyProcById(String id);

	/**
	 * 按主键批量删除 ASSETS_USTDTEMPAPPLY_PROC
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsUstdtempapplyProcList(List<String> idList);

	/**
	 * 通过申购单号查询单条记录
	 * @param subscribeNo 申购单号
	 * @return List<AssetsUstdtempapplyProcDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdtempapplyProcDTO> getAssetsUstdtempapplyProcBySubscribeNo(String subscribeNo);
}
