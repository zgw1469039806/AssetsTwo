package avicit.assets.device.assetsfrmlossproc.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsfrmlossproc.dto.AssetsFrmlossProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-05 15:44
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsFrmlossProcDao {

    /**
     * 分页查询  ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsFrmlossProcDTO>
     */
    public Page<AssetsFrmlossProcDTO> searchAssetsFrmlossProcByPage(
            @Param("bean") AssetsFrmlossProcDTO assetsFrmlossProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<AssetsFrmlossProcDTO>
     */
    public Page<AssetsFrmlossProcDTO> searchAssetsFrmlossProcByPageOr(
            @Param("bean") AssetsFrmlossProcDTO assetsFrmlossProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 查询对象
     * @return List<AssetsFrmlossProcDTO>
     */
    public List<AssetsFrmlossProcDTO> searchAssetsFrmlossProc(AssetsFrmlossProcDTO assetsFrmlossProcDTO);

    /**
     * 查询 ASSETS_FRMLOSS_PROC
     * @param id 主键id
     * @return AssetsFrmlossProcDTO
     */
    public AssetsFrmlossProcDTO findAssetsFrmlossProcById(String id);

    /**
     * 新增ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 保存对象
     * @return int
     */
    public int insertAssetsFrmlossProc(AssetsFrmlossProcDTO assetsFrmlossProcDTO);

    /**
     * 批量新增 ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsFrmlossProcList(List<AssetsFrmlossProcDTO> assetsFrmlossProcDTOList);

    /**
     * 更新部分对象 ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 更新对象
     * @return int
     */
    public int updateAssetsFrmlossProcSensitive(AssetsFrmlossProcDTO assetsFrmlossProcDTO);

    /**
     * 更新全部对象 ASSETS_FRMLOSS_PROC
     * @param assetsFrmlossProcDTO 更新对象
     * @return int
     */
    public int updateAssetsFrmlossProcAll(AssetsFrmlossProcDTO assetsFrmlossProcDTO);

    /**
     * 批量更新对象 ASSETS_FRMLOSS_PROC
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsFrmlossProcList(@Param("dtoList") List<AssetsFrmlossProcDTO> dtoList);

    /**
     * 按主键删除 ASSETS_FRMLOSS_PROC
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsFrmlossProcById(String id);

    /**
     * 按主键批量删除 ASSETS_FRMLOSS_PROC
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsFrmlossProcList(List<String> idList);
}
