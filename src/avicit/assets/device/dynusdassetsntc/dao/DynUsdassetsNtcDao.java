package avicit.assets.device.dynusdassetsntc.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynusdassetsntc.dto.DynUsdassetsNtcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 18:51
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DynUsdassetsNtcDao {
    
    																																																	/**
     * 分页查询  DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynUsdassetsNtcDTO>
     */
    public Page<DynUsdassetsNtcDTO> searchDynUsdassetsNtcByPage(@Param("bean") DynUsdassetsNtcDTO dynUsdassetsNtcDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    					
    																																																	/**
     * 按or条件的分页查询 DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynUsdassetsNtcDTO>
     */
    public Page<DynUsdassetsNtcDTO> searchDynUsdassetsNtcByPageOr(@Param("bean") DynUsdassetsNtcDTO dynUsdassetsNtcDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    				    /**
     * 查询 DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 查询对象
     * @return List<DynUsdassetsNtcDTO>
     */
    public List<DynUsdassetsNtcDTO> searchDynUsdassetsNtc(DynUsdassetsNtcDTO dynUsdassetsNtcDTO);

    /**
     * 查询 DYN_USDASSETS_NTC
     * @param id 主键id
     * @return DynUsdassetsNtcDTO
     */
    public DynUsdassetsNtcDTO findDynUsdassetsNtcById(String id);
    
    /**
     * 新增DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 保存对象
     * @return int
     */
    public int insertDynUsdassetsNtc(DynUsdassetsNtcDTO dynUsdassetsNtcDTO);
    
    /**
     * 批量新增 DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTOList 保存对象集合
     * @return int
     */
    public int insertDynUsdassetsNtcList(List<DynUsdassetsNtcDTO> dynUsdassetsNtcDTOList);
    
     /**
     * 更新部分对象 DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 更新对象
     * @return int
     */
    public int updateDynUsdassetsNtcSensitive(DynUsdassetsNtcDTO dynUsdassetsNtcDTO);
    
    /**
     * 更新全部对象 DYN_USDASSETS_NTC
     * @param dynUsdassetsNtcDTO 更新对象
     * @return int
     */
    public int updateDynUsdassetsNtcAll(DynUsdassetsNtcDTO dynUsdassetsNtcDTO);
    
    /**
     * 批量更新对象 DYN_USDASSETS_NTC
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateDynUsdassetsNtcList(@Param("dtoList") List<DynUsdassetsNtcDTO> dtoList);
    
    /**
     * 按主键删除 DYN_USDASSETS_NTC
     * @param id 主键id
     * @return int
     */ 
    public int deleteDynUsdassetsNtcById(String id);
    
    /**
     * 按主键批量删除 DYN_USDASSETS_NTC
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteDynUsdassetsNtcList(List<String> idList); 
}
