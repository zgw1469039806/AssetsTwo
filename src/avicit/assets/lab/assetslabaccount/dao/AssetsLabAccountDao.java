package avicit.assets.lab.assetslabaccount.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.lab.assetslabaccount.dto.AssetsLabAccountDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-21 16:08
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsLabAccountDao {

	/**
	* 分页查询  实验室台账
	* @param assetsLabAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabAccountDTO>
	*/
	public Page<AssetsLabAccountDTO> searchAssetsLabAccountByPage(
			@Param("bean") AssetsLabAccountDTO assetsLabAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 实验室台账
	* @param assetsLabAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabAccountDTO>
	*/
	public Page<AssetsLabAccountDTO> searchAssetsLabAccountByPageOr(
			@Param("bean") AssetsLabAccountDTO assetsLabAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询实验室台账
	 * @param assetsLabAccountDTO 查询对象
	 * @return List<AssetsLabAccountDTO>
	 */
	public List<AssetsLabAccountDTO> searchAssetsLabAccount(AssetsLabAccountDTO assetsLabAccountDTO);

	/**
	 * 查询 实验室台账
	 * @param id 主键id
	 * @return AssetsLabAccountDTO
	 */
	public AssetsLabAccountDTO findAssetsLabAccountById(String id);

	/**
	* 新增实验室台账
	* @param assetsLabAccountDTO 保存对象
	* @return int
	*/
	public int insertAssetsLabAccount(AssetsLabAccountDTO assetsLabAccountDTO);

	/**
	 * 批量新增 实验室台账
	 * @param assetsLabAccountDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsLabAccountList(List<AssetsLabAccountDTO> assetsLabAccountDTOList);

	/**
	 * 更新部分对象 实验室台账
	 * @param assetsLabAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabAccountSensitive(AssetsLabAccountDTO assetsLabAccountDTO);

	/**
	 * 更新全部对象 实验室台账
	 * @param assetsLabAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabAccountAll(AssetsLabAccountDTO assetsLabAccountDTO);

	/**
	 * 批量更新对象 实验室台账
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsLabAccountList(@Param("dtoList") List<AssetsLabAccountDTO> dtoList);

	/**
	 * 按主键删除 实验室台账
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsLabAccountById(String id);

	/**
	 * 按主键批量删除 实验室台账
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsLabAccountList(List<String> idList);
}
