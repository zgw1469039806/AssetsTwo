package avicit.assets.device.assetsstdtempapplyproc.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 16:59
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsSupplierDao {
    
	/**
     * 分页查询  ASSETS_SUPPLIER
     * @param assetsSupplierDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSupplierDTO>
     */
	public Page<AssetsSupplierDTO> searchAssetsSupplierByPage(@Param("bean") AssetsSupplierDTO assetsSupplierDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 ASSETS_SUPPLIER
     * @param assetsSupplierDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSupplierDTO>
     */
	public Page<AssetsSupplierDTO> searchAssetsSupplierByPageOr(@Param("bean") AssetsSupplierDTO assetsSupplierDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 ASSETS_SUPPLIER 
     * @param id 主键id
     * @return AssetsSupplierDTO
     */ 
    public AssetsSupplierDTO findAssetsSupplierById(String id);
    
    /**
     * 查询 ASSETS_SUPPLIER
     * @param pid 父id
     * @return List<AssetsSupplierDTO>
     */
    public List<AssetsSupplierDTO> findAssetsSupplierByPid(String pid);
    
    /**
     * 新增ASSETS_SUPPLIER
     * @param assetsSupplierDTO 保存对象
     * @return int
     */
    public int insertAssetsSupplier(AssetsSupplierDTO assetsSupplierDTO);
    
    /**
     * 批量新增 ASSETS_SUPPLIER
     * @param assetsSupplierDTOList 保存对象集合
     * @return int
     */
	public int insertAssetsSupplierList(List<AssetsSupplierDTO> assetsSupplierDTOList);
	
    /**
     * 更新部分对象 ASSETS_SUPPLIER
     * @param assetsSupplierDTO 更新对象
     * @return int
     */
    public int updateAssetsSupplierSensitive(AssetsSupplierDTO assetsSupplierDTO);
    
    /**
     * 更新全部对象 ASSETS_SUPPLIER
     * @param assetsSupplierDTO 更新对象
     * @return int
     */
    public int updateAssetsSupplierAll(AssetsSupplierDTO assetsSupplierDTO);
    
    /**
     * 批量更新对象 ASSETS_SUPPLIER
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsSupplierList(@Param("dtoList") List<AssetsSupplierDTO> dtoList);
    
    /**
     * 按主键删除 ASSETS_SUPPLIER
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsSupplierById(String id);
    
    /**
     * 按主键批量删除 ASSETS_SUPPLIER
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAssetsSupplierList(List<String> idList);
}
