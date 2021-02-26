package avicit.assets.device.dynsdcollecmain.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynsdcollecmain.dto.DynSdCollecMainDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 18:57
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DynSdCollecMainDao {
    
    																																											/**
     * 分页查询  DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynSdCollecMainDTO>
     */
    public Page<DynSdCollecMainDTO> searchDynSdCollecMainByPage(@Param("bean") DynSdCollecMainDTO dynSdCollecMainDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    														
    																																											/**
     * 按or条件的分页查询 DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynSdCollecMainDTO>
     */
    public Page<DynSdCollecMainDTO> searchDynSdCollecMainByPageOr(@Param("bean") DynSdCollecMainDTO dynSdCollecMainDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    													    /**
     * 查询 DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 查询对象
     * @return List<DynSdCollecMainDTO>
     */
    public List<DynSdCollecMainDTO> searchDynSdCollecMain(DynSdCollecMainDTO dynSdCollecMainDTO);

    /**
     * 查询 DYN_SD_COLLEC_MAIN
     * @param id 主键id
     * @return DynSdCollecMainDTO
     */
    public DynSdCollecMainDTO findDynSdCollecMainById(String id);
    
    /**
     * 新增DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 保存对象
     * @return int
     */
    public int insertDynSdCollecMain(DynSdCollecMainDTO dynSdCollecMainDTO);
    
    /**
     * 批量新增 DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTOList 保存对象集合
     * @return int
     */
    public int insertDynSdCollecMainList(List<DynSdCollecMainDTO> dynSdCollecMainDTOList);
    
     /**
     * 更新部分对象 DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 更新对象
     * @return int
     */
    public int updateDynSdCollecMainSensitive(DynSdCollecMainDTO dynSdCollecMainDTO);
    
    /**
     * 更新全部对象 DYN_SD_COLLEC_MAIN
     * @param dynSdCollecMainDTO 更新对象
     * @return int
     */
    public int updateDynSdCollecMainAll(DynSdCollecMainDTO dynSdCollecMainDTO);
    
    /**
     * 批量更新对象 DYN_SD_COLLEC_MAIN
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateDynSdCollecMainList(@Param("dtoList") List<DynSdCollecMainDTO> dtoList);
    
    /**
     * 按主键删除 DYN_SD_COLLEC_MAIN
     * @param id 主键id
     * @return int
     */ 
    public int deleteDynSdCollecMainById(String id);
    
    /**
     * 按主键批量删除 DYN_SD_COLLEC_MAIN
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteDynSdCollecMainList(List<String> idList); 
}
