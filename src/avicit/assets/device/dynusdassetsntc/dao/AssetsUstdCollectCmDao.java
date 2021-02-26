package avicit.assets.device.dynusdassetsntc.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 19:12
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdCollectCmDao {
    
	/**
     * 分页查询  非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsUstdCollectCmDTO>
     */
	public Page<AssetsUstdCollectCmDTO> searchAssetsUstdCollectCmByPage(@Param("bean") AssetsUstdCollectCmDTO assetsUstdCollectCmDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsUstdCollectCmDTO>
     */
	public Page<AssetsUstdCollectCmDTO> searchAssetsUstdCollectCmByPageOr(@Param("bean") AssetsUstdCollectCmDTO assetsUstdCollectCmDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 非标设备年度征集实际下发表 
     * @param id 主键id
     * @return AssetsUstdCollectCmDTO
     */ 
    public AssetsUstdCollectCmDTO findAssetsUstdCollectCmById(String id);
    
    /**
     * 查询 非标设备年度征集实际下发表
     * @param pid 父id
     * @return List<AssetsUstdCollectCmDTO>
     */
    public List<AssetsUstdCollectCmDTO> findAssetsUstdCollectCmByPid(String pid);
    
    /**
     * 新增非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTO 保存对象
     * @return int
     */
    public int insertAssetsUstdCollectCm(AssetsUstdCollectCmDTO assetsUstdCollectCmDTO);
    
    /**
     * 批量新增 非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTOList 保存对象集合
     * @return int
     */
	public int insertAssetsUstdCollectCmList(List<AssetsUstdCollectCmDTO> assetsUstdCollectCmDTOList);
	
    /**
     * 更新部分对象 非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdCollectCmSensitive(AssetsUstdCollectCmDTO assetsUstdCollectCmDTO);
    
    /**
     * 更新全部对象 非标设备年度征集实际下发表
     * @param assetsUstdCollectCmDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdCollectCmAll(AssetsUstdCollectCmDTO assetsUstdCollectCmDTO);
    
    /**
     * 批量更新对象 非标设备年度征集实际下发表
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsUstdCollectCmList(@Param("dtoList") List<AssetsUstdCollectCmDTO> dtoList);
    
    /**
     * 按主键删除 非标设备年度征集实际下发表
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsUstdCollectCmById(String id);
    
    /**
     * 按主键批量删除 非标设备年度征集实际下发表
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAssetsUstdCollectCmList(List<String> idList);
}
