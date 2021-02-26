package avicit.assets.device.assetsoperationcertificate.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationCertificateDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 14:05
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsOperationCertificateDao {

	/**
	* 分页查询  操作证台账
	* @param assetsOperationCertificateDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsOperationCertificateDTO>
	*/
	public Page<AssetsOperationCertificateDTO> searchAssetsOperationCertificateByPage(
			@Param("bean") AssetsOperationCertificateDTO assetsOperationCertificateDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 操作证台账
	* @param assetsOperationCertificateDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsOperationCertificateDTO>
	*/
	public Page<AssetsOperationCertificateDTO> searchAssetsOperationCertificateByPageOr(
			@Param("bean") AssetsOperationCertificateDTO assetsOperationCertificateDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 查询 操作证台账
	* @param assetsOperationCertificateDTO 查询对象
	* @return List<AssetsOperationCertificateDTO>
	*/
	public List<AssetsOperationCertificateDTO> searchAssetsOperationCertificate(
			AssetsOperationCertificateDTO assetsOperationCertificateDTO);

	/**
	 * 查询 操作证台账
	 * @param id 主键id
	 * @return AssetsOperationCertificateDTO
	 */
	public AssetsOperationCertificateDTO findAssetsOperationCertificateById(String id);

	/**
	 * 新增操作证台账
	 * @param assetsOperationCertificateDTO 保存对象
	 * @return int
	 */
	public int insertAssetsOperationCertificate(AssetsOperationCertificateDTO assetsOperationCertificateDTO);

	/**
	 * 批量新增 操作证台账
	 * @param assetsOperationCertificateDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsOperationCertificateList(
			List<AssetsOperationCertificateDTO> assetsOperationCertificateDTOList);

	/**
	* 更新部分对象 操作证台账
	* @param assetsOperationCertificateDTO 更新对象
	* @return int
	*/
	public int updateAssetsOperationCertificateSensitive(AssetsOperationCertificateDTO assetsOperationCertificateDTO);

	/**
	 * 更新全部对象 操作证台账
	 * @param assetsOperationCertificateDTO 更新对象
	 * @return int
	 */
	public int updateAssetsOperationCertificateAll(AssetsOperationCertificateDTO assetsOperationCertificateDTO);

	/**
	 * 批量更新对象 操作证台账
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsOperationCertificateList(@Param("dtoList") List<AssetsOperationCertificateDTO> dtoList);

	/**
	 * 按主键删除 操作证台账
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsOperationCertificateById(String id);

	/**
	 * 按主键批量删除 操作证台账
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsOperationCertificateList(List<String> idList);
}
