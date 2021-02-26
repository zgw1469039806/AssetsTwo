package avicit.assets.device.assetsstdtempapplyproc.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsStdtempapplyProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 16:59
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsStdtempapplyProcDao {
    
    																																																																																																																																																																																																																																																																																																																																																												/**
     * 分页查询  ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsStdtempapplyProcDTO>
     */
	public Page<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProcByPage(@Param("bean") AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO, @Param("pOrderBy") String orderBy) ;
		
    																																																																																																																																																																																																																																																																																																																																																												/**
     * 按or条件的分页查询 ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsStdtempapplyProcDTO>
     */
	public Page<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProcByPageOr(@Param("bean") AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO, @Param("pOrderBy") String orderBy) ;
	    /**
     * 查询 ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 查询对象
     * @return List<AssetsStdtempapplyProcDTO>
     */
    public List<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProc(AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO);

    /**
     * 查询 ASSETS_STDTEMPAPPLY_PROC
     * @param id 主键id
     * @return AssetsStdtempapplyProcDTO
     */
    public AssetsStdtempapplyProcDTO findAssetsStdtempapplyProcById(String id);
    
    /**
     * 新增ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 保存对象
     * @return int
     */
    public int insertAssetsStdtempapplyProc(AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO);
    
    /**
     * 批量新增 ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsStdtempapplyProcList(List<AssetsStdtempapplyProcDTO> assetsStdtempapplyProcDTOList);
    
     /**
     * 更新部分对象 ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 更新对象
     * @return int
     */
    public int updateAssetsStdtempapplyProcSensitive(AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO);
    
    /**
     * 更新全部对象 ASSETS_STDTEMPAPPLY_PROC
     * @param assetsStdtempapplyProcDTO 更新对象
     * @return int
     */
    public int updateAssetsStdtempapplyProcAll(AssetsStdtempapplyProcDTO assetsStdtempapplyProcDTO);
    
    /**
     * 批量更新对象 ASSETS_STDTEMPAPPLY_PROC
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsStdtempapplyProcList(@Param("dtoList") List<AssetsStdtempapplyProcDTO> dtoList);
    
    /**
     * 按主键删除 ASSETS_STDTEMPAPPLY_PROC
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsStdtempapplyProcById(String id);
    
    /**
     * 按主键批量删除 ASSETS_STDTEMPAPPLY_PROC
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteAssetsStdtempapplyProcList(List<String> idList); 
}
