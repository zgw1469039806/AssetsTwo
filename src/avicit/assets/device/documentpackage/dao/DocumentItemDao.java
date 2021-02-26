package avicit.assets.device.documentpackage.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.documentpackage.dto.DocumentItemDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 20:01
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DocumentItemDao {

	/**
	 * 分页查询  DOCUMENT_ITEM
	 * @param documentItemDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<DocumentItemDTO>
	 */
	public Page<DocumentItemDTO> searchDocumentItemByPage(@Param("bean") DocumentItemDTO documentItemDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 DOCUMENT_ITEM
	 * @param documentItemDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<DocumentItemDTO>
	 */
	public Page<DocumentItemDTO> searchDocumentItemByPageOr(@Param("bean") DocumentItemDTO documentItemDTO,
			@Param("pOrderBy") String orderBy);

	/**
	 * 查询 DOCUMENT_ITEM 
	 * @param id 主键id
	 * @return DocumentItemDTO
	 */
	public DocumentItemDTO findDocumentItemById(String id);

	/**
	 * 查询 DOCUMENT_ITEM
	 * @param pid 父id
	 * @return List<DocumentItemDTO>
	 */
	public List<DocumentItemDTO> findDocumentItemByPid(String pid);

	/**
	 * 新增DOCUMENT_ITEM
	 * @param documentItemDTO 保存对象
	 * @return int
	 */
	public int insertDocumentItem(DocumentItemDTO documentItemDTO);

	/**
	 * 批量新增 DOCUMENT_ITEM
	 * @param documentItemDTOList 保存对象集合
	 * @return int
	 */
	public int insertDocumentItemList(List<DocumentItemDTO> documentItemDTOList);

	/**
	 * 更新部分对象 DOCUMENT_ITEM
	 * @param documentItemDTO 更新对象
	 * @return int
	 */
	public int updateDocumentItemSensitive(DocumentItemDTO documentItemDTO);

	/**
	 * 更新全部对象 DOCUMENT_ITEM
	 * @param documentItemDTO 更新对象
	 * @return int
	 */
	public int updateDocumentItemAll(DocumentItemDTO documentItemDTO);

	/**
	 * 批量更新对象 DOCUMENT_ITEM
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDocumentItemList(@Param("dtoList") List<DocumentItemDTO> dtoList);

	/**
	 * 按主键删除 DOCUMENT_ITEM
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDocumentItemById(String id);

	/**
	 * 按主键批量删除 DOCUMENT_ITEM
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDocumentItemList(List<String> idList);
}
