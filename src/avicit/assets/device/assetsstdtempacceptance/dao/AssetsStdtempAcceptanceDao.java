package avicit.assets.device.assetsstdtempacceptance.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsstdtempacceptance.dto.AssetsStdtempAcceptanceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-19 20:37
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsStdtempAcceptanceDao {
    
    																																																																																																																																																																																																																																				/**
     * 分页查询  标准设备验收
     * @param assetsStdtempAcceptanceDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsStdtempAcceptanceDTO>
     */
	public Page<AssetsStdtempAcceptanceDTO> searchAssetsStdtempAcceptanceByPage(@Param("bean") AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO, @Param("pOrderBy") String orderBy) ;
		
    																																																																																																																																																																																																																																				/**
     * 按or条件的分页查询 标准设备验收
     * @param assetsStdtempAcceptanceDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsStdtempAcceptanceDTO>
     */
	public Page<AssetsStdtempAcceptanceDTO> searchAssetsStdtempAcceptanceByPageOr(@Param("bean") AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO, @Param("pOrderBy") String orderBy) ;
	    /**
     * 查询 标准设备验收
     * @param assetsStdtempAcceptanceDTO 查询对象
     * @return List<AssetsStdtempAcceptanceDTO>
     */
    public List<AssetsStdtempAcceptanceDTO> searchAssetsStdtempAcceptance(AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO);

    /**
     * 查询 标准设备验收
     * @param id 主键id
     * @return AssetsStdtempAcceptanceDTO
     */
    public AssetsStdtempAcceptanceDTO findAssetsStdtempAcceptanceById(String id);
    
    /**
     * 新增标准设备验收
     * @param assetsStdtempAcceptanceDTO 保存对象
     * @return int
     */
    public int insertAssetsStdtempAcceptance(AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO);
    
    /**
     * 批量新增 标准设备验收
     * @param assetsStdtempAcceptanceDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsStdtempAcceptanceList(List<AssetsStdtempAcceptanceDTO> assetsStdtempAcceptanceDTOList);
    
     /**
     * 更新部分对象 标准设备验收
     * @param assetsStdtempAcceptanceDTO 更新对象
     * @return int
     */
    public int updateAssetsStdtempAcceptanceSensitive(AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO);
    
    /**
     * 更新全部对象 标准设备验收
     * @param assetsStdtempAcceptanceDTO 更新对象
     * @return int
     */
    public int updateAssetsStdtempAcceptanceAll(AssetsStdtempAcceptanceDTO assetsStdtempAcceptanceDTO);
    
    /**
     * 批量更新对象 标准设备验收
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsStdtempAcceptanceList(@Param("dtoList") List<AssetsStdtempAcceptanceDTO> dtoList);
    
    /**
     * 按主键删除 标准设备验收
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsStdtempAcceptanceById(String id);
    
    /**
     * 按主键批量删除 标准设备验收
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteAssetsStdtempAcceptanceList(List<String> idList); 
}
