package avicit.assets.device.nationalclassify.dao;

import avicit.assets.device.nationalclassify.dto.NationalClassifyDTO;
import avicit.assets.device.nationalclassify.dto.NationalClassifyTreeDTO;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-05-28 09:07
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface NationalClassifyDao {
    
	/**
	 * 根据父节点id获取其排序最后一个直接子节点
	 * @param parentId 父节点id
	 * @return List<NationalClassifyDTO>
	 * @throws Exception
	 */
	public List<NationalClassifyDTO> getLastChildNodeByPID(@Param("parentId")String parentId);
	
	/**
	 * 根据包节点id获取其下属所有节点，包括包节点
	 * @param：packageNodeId（包节点id）
	 * @return List<NationalClassifyDTO>
	 * @throws Exception
	 */
	public List<NationalClassifyDTO> getNodesByPackageNodeId(@Param("packageNodeId")String packageNodeId);
    																											
	/**
     * 分页查询  NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<NationalClassifyDTO>
     */
    public Page<NationalClassifyDTO> searchNationalClassifyByPage(@Param("bean")NationalClassifyDTO nationalClassifyDTO,@Param("pOrderBy")String orderBy);
		
    public List<NationalClassifyTreeDTO> getNationalClassifyTree(@Param("menuName")String menuName) ;
    																											
    /**
     * 按or条件的分页查询 NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<NationalClassifyDTO>
     */
    public Page<NationalClassifyDTO> searchNationalClassifyByPageOr(@Param("bean")NationalClassifyDTO nationalClassifyDTO,@Param("pOrderBy")String orderBy);
	    
    /**
     * 查询NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 查询对象
     * @return List<NationalClassifyDTO>
     */
    public List<NationalClassifyDTO> searchNationalClassify(NationalClassifyDTO nationalClassifyDTO);

    /**
     * 查询 NATIONAL_CLASSIFY
     * @param id 主键id
     * @return NationalClassifyDTO
     */
    public NationalClassifyDTO findNationalClassifyById(String id);
    
   /**
     * 新增NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 保存对象
     * @return int
     */
    public int insertNationalClassify(NationalClassifyDTO nationalClassifyDTO);
    
    /**
     * 批量新增 NATIONAL_CLASSIFY
     * @param nationalClassifyDTOList 保存对象集合
     * @return int
     */
    public int insertNationalClassifyList(List<NationalClassifyDTO> nationalClassifyDTOList);
    /**
     * 更新部分对象 NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 更新对象
     * @return int
     */
    public int updateNationalClassifySensitive(NationalClassifyDTO nationalClassifyDTO);
    
    /**
     * 更新全部对象 NATIONAL_CLASSIFY
     * @param nationalClassifyDTO 更新对象
     * @return int
     */
    public int updateNationalClassifyAll(NationalClassifyDTO nationalClassifyDTO);
    
    /**
     * 批量更新对象 NATIONAL_CLASSIFY
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateNationalClassifyList(@Param("dtoList") List<NationalClassifyDTO> dtoList);
    
    /**
     * 按主键删除 NATIONAL_CLASSIFY
     * @param id 主键id
     * @return int
     */ 
    public int deleteNationalClassifyById(String id);
    
    /**
     * 按主键批量删除 NATIONAL_CLASSIFY
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteNationalClassifyList(List<String> idList);
    }
