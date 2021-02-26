package avicit.assets.device.dynsdcollecmain.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectCmDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 19:59
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsSdequipCollectCmDao {
    
	/**
     * 分页查询  标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSdequipCollectCmDTO>
     */
	public Page<AssetsSdequipCollectCmDTO> searchAssetsSdequipCollectCmByPage(@Param("bean") AssetsSdequipCollectCmDTO assetsSdequipCollectCmDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSdequipCollectCmDTO>
     */
	public Page<AssetsSdequipCollectCmDTO> searchAssetsSdequipCollectCmByPageOr(@Param("bean") AssetsSdequipCollectCmDTO assetsSdequipCollectCmDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 标准设备年度申购征集表单确认表 
     * @param id 主键id
     * @return AssetsSdequipCollectCmDTO
     */ 
    public AssetsSdequipCollectCmDTO findAssetsSdequipCollectCmById(String id);
    
    /**
     * 查询 标准设备年度申购征集表单确认表
     * @param pid 父id
     * @return List<AssetsSdequipCollectCmDTO>
     */
    public List<AssetsSdequipCollectCmDTO> findAssetsSdequipCollectCmByPid(String pid);
    
    /**
     * 新增标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTO 保存对象
     * @return int
     */
    public int insertAssetsSdequipCollectCm(AssetsSdequipCollectCmDTO assetsSdequipCollectCmDTO);
    
    /**
     * 批量新增 标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTOList 保存对象集合
     * @return int
     */
	public int insertAssetsSdequipCollectCmList(List<AssetsSdequipCollectCmDTO> assetsSdequipCollectCmDTOList);
	
    /**
     * 更新部分对象 标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTO 更新对象
     * @return int
     */
    public int updateAssetsSdequipCollectCmSensitive(AssetsSdequipCollectCmDTO assetsSdequipCollectCmDTO);
    
    /**
     * 更新全部对象 标准设备年度申购征集表单确认表
     * @param assetsSdequipCollectCmDTO 更新对象
     * @return int
     */
    public int updateAssetsSdequipCollectCmAll(AssetsSdequipCollectCmDTO assetsSdequipCollectCmDTO);
    
    /**
     * 批量更新对象 标准设备年度申购征集表单确认表
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsSdequipCollectCmList(@Param("dtoList") List<AssetsSdequipCollectCmDTO> dtoList);
    
    /**
     * 按主键删除 标准设备年度申购征集表单确认表
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsSdequipCollectCmById(String id);
    
    /**
     * 按主键批量删除 标准设备年度申购征集表单确认表
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAssetsSdequipCollectCmList(List<String> idList);
}
