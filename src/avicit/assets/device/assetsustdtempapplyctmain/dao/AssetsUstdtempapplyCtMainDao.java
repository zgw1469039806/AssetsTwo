package avicit.assets.device.assetsustdtempapplyctmain.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCtMainDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 16:24
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdtempapplyCtMainDao {
    
    																									/**
     * 分页查询  非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<AssetsUstdtempapplyCtMainDTO>
     */
    public Page<AssetsUstdtempapplyCtMainDTO> searchAssetsUstdtempapplyCtMainByPage(@Param("bean") AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    																										
    																									/**
     * 按or条件的分页查询 非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<AssetsUstdtempapplyCtMainDTO>
     */
    public Page<AssetsUstdtempapplyCtMainDTO> searchAssetsUstdtempapplyCtMainByPageOr(@Param("bean") AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
  	    																									    /**
     * 查询 非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 查询对象
     * @return List<AssetsUstdtempapplyCtMainDTO>
     */
    public List<AssetsUstdtempapplyCtMainDTO> searchAssetsUstdtempapplyCtMain(AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO);

    /**
     * 查询 非标设备年度申购征集上报表头
     * @param id 主键id
     * @return AssetsUstdtempapplyCtMainDTO
     */
    public AssetsUstdtempapplyCtMainDTO findAssetsUstdtempapplyCtMainById(String id);
    
    /**
     * 新增非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 保存对象
     * @return int
     */
    public int insertAssetsUstdtempapplyCtMain(AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO);
    
    /**
     * 批量新增 非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsUstdtempapplyCtMainList(List<AssetsUstdtempapplyCtMainDTO> assetsUstdtempapplyCtMainDTOList);
    
     /**
     * 更新部分对象 非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdtempapplyCtMainSensitive(AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO);
    
    /**
     * 更新全部对象 非标设备年度申购征集上报表头
     * @param assetsUstdtempapplyCtMainDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdtempapplyCtMainAll(AssetsUstdtempapplyCtMainDTO assetsUstdtempapplyCtMainDTO);
    
    /**
     * 批量更新对象 非标设备年度申购征集上报表头
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsUstdtempapplyCtMainList(@Param("dtoList") List<AssetsUstdtempapplyCtMainDTO> dtoList);
    
    /**
     * 按主键删除 非标设备年度申购征集上报表头
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsUstdtempapplyCtMainById(String id);
    
    /**
     * 按主键批量删除 非标设备年度申购征集上报表头
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteAssetsUstdtempapplyCtMainList(List<String> idList); 
}
