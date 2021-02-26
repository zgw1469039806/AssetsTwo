package avicit.assets.assetsattachment.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.assetsattachment.dto.AssetsAttachmentDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-11 17:30
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsAttachmentDao {

	/**
	* 分页查询  资产附件表
	* @param assetsAttachmentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsAttachmentDTO>
	*/
	public Page<AssetsAttachmentDTO> searchAssetsAttachmentByPage(
            @Param("bean") AssetsAttachmentDTO assetsAttachmentDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 资产附件表
	* @param assetsAttachmentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsAttachmentDTO>
	*/
	public Page<AssetsAttachmentDTO> searchAssetsAttachmentByPageOr(
            @Param("bean") AssetsAttachmentDTO assetsAttachmentDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询资产附件表
	* @param assetsAttachmentDTO 查询对象
	* @return List<AssetsAttachmentDTO>
	*/
	public List<AssetsAttachmentDTO> searchAssetsAttachment(AssetsAttachmentDTO assetsAttachmentDTO);

	/**
	 * 查询 资产附件表
	 * @param id 主键id
	 * @return AssetsAttachmentDTO
	 */
	public AssetsAttachmentDTO findAssetsAttachmentById(String id);

	/**
	* 新增资产附件表
	* @param assetsAttachmentDTO 保存对象
	* @return int
	*/
	public int insertAssetsAttachment(AssetsAttachmentDTO assetsAttachmentDTO);

	/**
	 * 批量新增 资产附件表
	 * @param assetsAttachmentDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsAttachmentList(List<AssetsAttachmentDTO> assetsAttachmentDTOList);

	/**
	 * 更新部分对象 资产附件表
	 * @param assetsAttachmentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsAttachmentSensitive(AssetsAttachmentDTO assetsAttachmentDTO);

	/**
	 * 更新全部对象 资产附件表
	 * @param assetsAttachmentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsAttachmentAll(AssetsAttachmentDTO assetsAttachmentDTO);

	/**
	 * 批量更新对象 资产附件表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsAttachmentList(@Param("dtoList") List<AssetsAttachmentDTO> dtoList);

	/**
	 * 按主键删除 资产附件表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsAttachmentById(String id);

	/**
	 * 按主键批量删除 资产附件表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsAttachmentList(List<String> idList);
}
