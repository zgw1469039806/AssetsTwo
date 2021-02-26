package avicit.assets.device.assetsstdtempacceptance.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsstdtempacceptance.dto.AttInventoryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-19 20:37
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AttInventoryDao {
    
	/**
     * 分页查询  ATT_INVENTORY
     * @param attInventoryDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AttInventoryDTO>
     */
	public Page<AttInventoryDTO> searchAttInventoryByPage(@Param("bean") AttInventoryDTO attInventoryDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 ATT_INVENTORY
     * @param attInventoryDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AttInventoryDTO>
     */
	public Page<AttInventoryDTO> searchAttInventoryByPageOr(@Param("bean") AttInventoryDTO attInventoryDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 ATT_INVENTORY 
     * @param id 主键id
     * @return AttInventoryDTO
     */ 
    public AttInventoryDTO findAttInventoryById(String id);
    
    /**
     * 查询 ATT_INVENTORY
     * @param pid 父id
     * @return List<AttInventoryDTO>
     */
    public List<AttInventoryDTO> findAttInventoryByPid(String pid);
    
    /**
     * 新增ATT_INVENTORY
     * @param attInventoryDTO 保存对象
     * @return int
     */
    public int insertAttInventory(AttInventoryDTO attInventoryDTO);
    
    /**
     * 批量新增 ATT_INVENTORY
     * @param attInventoryDTOList 保存对象集合
     * @return int
     */
	public int insertAttInventoryList(List<AttInventoryDTO> attInventoryDTOList);
	
    /**
     * 更新部分对象 ATT_INVENTORY
     * @param attInventoryDTO 更新对象
     * @return int
     */
    public int updateAttInventorySensitive(AttInventoryDTO attInventoryDTO);
    
    /**
     * 更新全部对象 ATT_INVENTORY
     * @param attInventoryDTO 更新对象
     * @return int
     */
    public int updateAttInventoryAll(AttInventoryDTO attInventoryDTO);
    
    /**
     * 批量更新对象 ATT_INVENTORY
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAttInventoryList(@Param("dtoList") List<AttInventoryDTO> dtoList);
    
    /**
     * 按主键删除 ATT_INVENTORY
     * @param id 主键id
     * @return int
     */ 
    public int deleteAttInventoryById(String id);
    
    /**
     * 按主键批量删除 ATT_INVENTORY
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAttInventoryList(List<String> idList);
}
