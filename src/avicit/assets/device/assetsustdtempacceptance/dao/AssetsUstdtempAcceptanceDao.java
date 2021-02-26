package avicit.assets.device.assetsustdtempacceptance.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdtempacceptance.dto.AssetsUstdtempAcceptanceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 11:13
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdtempAcceptanceDao {
	/**
	 * 分页查询  ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsUstdtempAcceptanceDTO>
	 */
	public Page<AssetsUstdtempAcceptanceDTO> searchAssetsUstdtempAcceptanceByPage(
			@Param("bean") AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsUstdtempAcceptanceDTO>
	 */
	public Page<AssetsUstdtempAcceptanceDTO> searchAssetsUstdtempAcceptanceByPageOr(
			@Param("bean") AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 查询对象
	 * @return List<AssetsUstdtempAcceptanceDTO>
	 */
	public List<AssetsUstdtempAcceptanceDTO> searchAssetsUstdtempAcceptance(
			AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO);

	/**
	 * 查询 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param id 主键id
	 * @return AssetsUstdtempAcceptanceDTO
	 */
	public AssetsUstdtempAcceptanceDTO findAssetsUstdtempAcceptanceById(String id);

	/**
	 * 新增ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 保存对象
	 * @return int
	 */
	public int insertAssetsUstdtempAcceptance(AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO);

	/**
	 * 批量新增 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsUstdtempAcceptanceList(List<AssetsUstdtempAcceptanceDTO> assetsUstdtempAcceptanceDTOList);

	/**
	 * 更新部分对象 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUstdtempAcceptanceSensitive(AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO);

	/**
	 * 更新全部对象 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param assetsUstdtempAcceptanceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUstdtempAcceptanceAll(AssetsUstdtempAcceptanceDTO assetsUstdtempAcceptanceDTO);

	/**
	 * 批量更新对象 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsUstdtempAcceptanceList(@Param("dtoList") List<AssetsUstdtempAcceptanceDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsUstdtempAcceptanceById(String id);

	/**
	 * 按主键批量删除 ASSETS_USTDTEMP_ACCEPTANCE
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsUstdtempAcceptanceList(List<String> idList);

	/**
	 * 按验收单编号获取验收单数据
	 * @param acceptanceNo 验收单编号
	 * @return List<AssetsUstdtempAcceptanceDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdtempAcceptanceDTO> getAssetsUstdtempAcceptanceByAcceptanceNo(String acceptanceNo);
}
