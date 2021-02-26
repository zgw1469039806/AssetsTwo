package avicit.cadreselect.dyntemplate.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.cadreselect.dyntemplate.dto.DynTemplateDTO;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:56
 * @类说明：模板表Dao
 * @修改记录： 
 */
@MyBatisRepository
public interface DynTemplateDAO {

	/**
	* 分页查询
	* @param dynTemplateDTO 查询对象
	* @param orderBy 排序条件
	* @param keyWord 关键字
	* @return Page<DynTemplateDTO>
	*/
	public Page<DynTemplateDTO> searchDynTemplateByPage(@Param("bean") DynTemplateDTO dynTemplateDTO, @Param("pOrderBy") String orderBy, @Param("keyWord") String keyWord);

	/**
	* 不分页查询
	* @param dynTemplateDTO 查询对象
	* @return List<DynTemplateDTO>
	*/
	public List<DynTemplateDTO> searchDynTemplate(@Param("bean") DynTemplateDTO dynTemplateDTO);

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynTemplateDTO
	 */
	public DynTemplateDTO findDynTemplateById(String id);

	/**
	* 新增
	* @param dynTemplateDTO 保存对象
	* @return int
	*/
	public int insertDynTemplate(DynTemplateDTO dynTemplateDTO);

	/**
	 * 批量新增
	 * @param dynTemplateDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynTemplateList(List<DynTemplateDTO> dynTemplateDTOList);

	/**
	 * 部分更新
	 * @param dynTemplateDTO 更新对象
	 * @return int
	 */
	public int updateDynTemplateSensitive(DynTemplateDTO dynTemplateDTO);

	/**
	 * 全部更新
	 * @param dynTemplateDTO 更新对象
	 * @return int
	 */
	public int updateDynTemplateAll(DynTemplateDTO dynTemplateDTO);

	/**
	 * 批量更新
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynTemplateList(@Param("dtoList") List<DynTemplateDTO> dtoList);

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynTemplateById(String id);

	/**
	 * 批量删除
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynTemplateList(List<String> idList);
}

