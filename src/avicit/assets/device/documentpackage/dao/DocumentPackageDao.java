package avicit.assets.device.documentpackage.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.assets.device.documentpackage.dto.DocumentPackageDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 20:01
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DocumentPackageDao {

	/**
	* 分页查询  DOCUMENT_PACKAGE
	* @param documentPackageDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<DocumentPackageDTO>
	*/
	public Page<DocumentPackageDTO> searchDocumentPackageByPage(@Param("bean") DocumentPackageDTO documentPackageDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 DOCUMENT_PACKAGE
	* @param documentPackageDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<DocumentPackageDTO>
	*/
	public Page<DocumentPackageDTO> searchDocumentPackageByPageOr(@Param("bean") DocumentPackageDTO documentPackageDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 查询 DOCUMENT_PACKAGE
	* @param documentPackageDTO 查询对象
	* @return List<DocumentPackageDTO>
	*/
	public List<DocumentPackageDTO> searchDocumentPackage(DocumentPackageDTO documentPackageDTO);

	/**
	 * 查询 DOCUMENT_PACKAGE
	 * @param id 主键id
	 * @return DocumentPackageDTO
	 */
	public DocumentPackageDTO findDocumentPackageById(String id);

	/**
	 * 新增DOCUMENT_PACKAGE
	 * @param documentPackageDTO 保存对象
	 * @return int
	 */
	public int insertDocumentPackage(DocumentPackageDTO documentPackageDTO);

	/**
	 * 批量新增 DOCUMENT_PACKAGE
	 * @param documentPackageDTOList 保存对象集合
	 * @return int
	 */
	public int insertDocumentPackageList(List<DocumentPackageDTO> documentPackageDTOList);

	/**
	* 更新部分对象 DOCUMENT_PACKAGE
	* @param documentPackageDTO 更新对象
	* @return int
	*/
	public int updateDocumentPackageSensitive(DocumentPackageDTO documentPackageDTO);

	/**
	 * 更新全部对象 DOCUMENT_PACKAGE
	 * @param documentPackageDTO 更新对象
	 * @return int
	 */
	public int updateDocumentPackageAll(DocumentPackageDTO documentPackageDTO);

	/**
	 * 批量更新对象 DOCUMENT_PACKAGE
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDocumentPackageList(@Param("dtoList") List<DocumentPackageDTO> dtoList);

	/**
	 * 按主键删除 DOCUMENT_PACKAGE
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDocumentPackageById(String id);

	/**
	 * 按主键批量删除 DOCUMENT_PACKAGE
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDocumentPackageList(List<String> idList);
}
