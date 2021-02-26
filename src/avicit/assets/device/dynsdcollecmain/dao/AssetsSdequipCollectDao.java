package avicit.assets.device.dynsdcollecmain.dao;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 18:57
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsSdequipCollectDao {
    
	/**
     * 分页查询  标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSdequipCollectDTO>
     */
	public Page<AssetsSdequipCollectDTO> searchAssetsSdequipCollectByPage(@Param("bean") AssetsSdequipCollectDTO assetsSdequipCollectDTO, @Param("pOrderBy") String orderBy) ;
   /**
     * 按or条件的分页查询 标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsSdequipCollectDTO>
     */
	public Page<AssetsSdequipCollectDTO> searchAssetsSdequipCollectByPageOr(@Param("bean") AssetsSdequipCollectDTO assetsSdequipCollectDTO, @Param("pOrderBy") String orderBy) ;
   
    /**
     * 查询 标准设备年度申购征集表单 
     * @param id 主键id
     * @return AssetsSdequipCollectDTO
     */ 
    public AssetsSdequipCollectDTO findAssetsSdequipCollectById(String id);
    
    /**
     * 查询 标准设备年度申购征集表单
     * @param pid 父id
     * @return List<AssetsSdequipCollectDTO>
     */
    public List<AssetsSdequipCollectDTO> findAssetsSdequipCollectByPid(String pid);
    
    /**
     * 新增标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 保存对象
     * @return int
     */
    public int insertAssetsSdequipCollect(AssetsSdequipCollectDTO assetsSdequipCollectDTO);
    
    /**
     * 批量新增 标准设备年度申购征集表单
     * @param assetsSdequipCollectDTOList 保存对象集合
     * @return int
     */
	public int insertAssetsSdequipCollectList(List<AssetsSdequipCollectDTO> assetsSdequipCollectDTOList);
	
    /**
     * 更新部分对象 标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 更新对象
     * @return int
     */
    public int updateAssetsSdequipCollectSensitive(AssetsSdequipCollectDTO assetsSdequipCollectDTO);
    
    /**
     * 更新全部对象 标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 更新对象
     * @return int
     */
    public int updateAssetsSdequipCollectAll(AssetsSdequipCollectDTO assetsSdequipCollectDTO);
    
    /**
     * 批量更新对象 标准设备年度申购征集表单
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsSdequipCollectList(@Param("dtoList") List<AssetsSdequipCollectDTO> dtoList);
    
    /**
     * 按主键删除 标准设备年度申购征集表单
     * @param id 主键id
     * @return int
     */ 
    public int deleteAssetsSdequipCollectById(String id);
    
    /**
     * 按主键批量删除 标准设备年度申购征集表单
     * @param idList 主键集合
     * @return int
     */ 
	public int deleteAssetsSdequipCollectList(List<String> idList);

    /**
     * 查询 标准设备年度申购征集表单
     * @param assetsSdequipCollectDTO 查询对象
     * @return List<AssetsSdequipCollectDTO>
     */
    public List<AssetsSdequipCollectDTO> searchAssetsSdequipCollect(AssetsSdequipCollectDTO assetsSdequipCollectDTO);
}
