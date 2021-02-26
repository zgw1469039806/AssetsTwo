package avicit.assets.device.assetsustdtempapplyctmain.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 16:24
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdtempapplyCollectDao {
    
	/**
     * 分页查询  非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsUstdtempapplyCollectDTO>
     */
	public Page<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollectByPage(@Param("bean") AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsUstdtempapplyCollectDTO>
     */
	public Page<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollectByPageOr(@Param("bean") AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 非标设备年度申购征集上报 
     * @param id 主键id
     * @return AssetsUstdtempapplyCollectDTO
     */ 
    public AssetsUstdtempapplyCollectDTO findAssetsUstdtempapplyCollectById(String id);
    
    /**
     * 查询 非标设备年度申购征集上报
     * @param pid 父id
     * @return List<AssetsUstdtempapplyCollectDTO>
     */
    public List<AssetsUstdtempapplyCollectDTO> findAssetsUstdtempapplyCollectByPid(String pid);
    
    /**
     * 新增非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 保存对象
     * @return int
     */
    public int insertAssetsUstdtempapplyCollect(AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO);
    
    /**
     * 批量新增 非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTOList 保存对象集合
     * @return int
     */
	public int insertAssetsUstdtempapplyCollectList(List<AssetsUstdtempapplyCollectDTO> assetsUstdtempapplyCollectDTOList);
	
    /**
     * 更新部分对象 非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdtempapplyCollectSensitive(AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO);
    
    /**
     * 更新全部对象 非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdtempapplyCollectAll(AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO);
    
    /**
     * 批量更新对象 非标设备年度申购征集上报
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsUstdtempapplyCollectList(@Param("dtoList") List<AssetsUstdtempapplyCollectDTO> dtoList);
    
    /**
     * 按主键删除 非标设备年度申购征集上报
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsUstdtempapplyCollectById(String id);
    
    /**
     * 按主键批量删除 非标设备年度申购征集上报
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAssetsUstdtempapplyCollectList(List<String> idList);

    /**
     * 查询非标设备年度申购征集上报
     * @param assetsUstdtempapplyCollectDTO 查询对象
     * @return List<AssetsUstdtempapplyCollectDTO>
     */
    public List<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollect(AssetsUstdtempapplyCollectDTO assetsUstdtempapplyCollectDTO);
}
