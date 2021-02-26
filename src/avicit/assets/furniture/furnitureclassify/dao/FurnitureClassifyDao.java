package avicit.assets.furniture.furnitureclassify.dao;

import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyDTO;
import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyTreeDTO;
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
public interface FurnitureClassifyDao {
    
	/**
	 * 根据父节点id获取其排序最后一个直接子节点
	 * @param parentId 父节点id
	 * @return List<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public List<FurnitureClassifyDTO> getLastChildNodeByPID(@Param("parentId")String parentId);
	
	/**
	 * 根据包节点id获取其下属所有节点，包括包节点
	 * @param：packageNodeId（包节点id）
	 * @return List<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public List<FurnitureClassifyDTO> getNodesByPackageNodeId(@Param("packageNodeId")String packageNodeId);
    																											
	/**
     * 分页查询  FURNITURE_CLASSIFY
     * @param furnitureClassifyDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<FurnitureClassifyDTO>
     */
    public Page<FurnitureClassifyDTO> searchFurnitureClassifyByPage(@Param("bean")FurnitureClassifyDTO furnitureClassifyDTO,@Param("pOrderBy")String orderBy);
		
    public List<FurnitureClassifyTreeDTO> getFurnitureClassifyTree(@Param("menuName")String menuName) ;
    																											
    /**
     * 按or条件的分页查询 FURNITURE_CLASSIFY
     * @param furnitureClassifyDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<FurnitureClassifyDTO>
     */
    public Page<FurnitureClassifyDTO> searchFurnitureClassifyByPageOr(@Param("bean")FurnitureClassifyDTO furnitureClassifyDTO,@Param("pOrderBy")String orderBy);
	    
    /**
     * 查询FURNITURE_CLASSIFY
     * @param furnitureClassifyDTO 查询对象
     * @return List<FurnitureClassifyDTO>
     */
    public List<FurnitureClassifyDTO> searchFurnitureClassify(FurnitureClassifyDTO furnitureClassifyDTO);

    /**
     * 查询 FURNITURE_CLASSIFY
     * @param id 主键id
     * @return FurnitureClassifyDTO
     */
    public FurnitureClassifyDTO findFurnitureClassifyById(String id);
    
   /**
     * 新增FURNITURE_CLASSIFY
     * @return int
     */
    public int insertfurnitureClassify(FurnitureClassifyDTO furnitureClassifyDTO);
    
    /**
     * 批量新增 FURNITURE_CLASSIFY
     * @param furnitureClassifyDTOList 保存对象集合
     * @return int
     */
    public int insertFurnitureClassifyList(List<FurnitureClassifyDTO> furnitureClassifyDTOList);
    /**
     * 更新部分对象 FURNITURE_CLASSIFY
     * @param furnitureClassifyDTO 更新对象
     * @return int
     */
    public int updateFurnitureClassifySensitive(FurnitureClassifyDTO furnitureClassifyDTO);
    
    /**
     * 更新全部对象 FURNITURE_CLASSIFY
     * @param furnitureClassifyDTO 更新对象
     * @return int
     */
    public int updateFurnitureClassifyAll(FurnitureClassifyDTO furnitureClassifyDTO);
    
    /**
     * 批量更新对象 FURNITURE_CLASSIFY
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateFurnitureClassifyList(@Param("dtoList") List<FurnitureClassifyDTO> dtoList);
    
    /**
     * 按主键删除 FURNITURE_CLASSIFY
     * @param id 主键id
     * @return int
     */ 
    public int deleteFurnitureClassifyById(String id);
    
    /**
     * 按主键批量删除 FURNITURE_CLASSIFY
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteFurnitureClassifyList(List<String> idList);
    }
