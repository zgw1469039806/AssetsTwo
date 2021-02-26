package avicit.assets.device.assetstechtransformproject.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformDeviceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 09:54
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsTechTransformDeviceDao {

    /**
     * 分页查询  ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTO 查询对象
     * @param orderBy                      排序条件
     * @return Page<AssetsTechTransformDeviceDTO>
     */
    public Page<AssetsTechTransformDeviceDTO> searchAssetsTechTransformDeviceByPage(
            @Param("bean") AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO,
            @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTO 查询对象
     * @param orderBy                      排序条件
     * @return Page<AssetsTechTransformDeviceDTO>
     */
    public Page<AssetsTechTransformDeviceDTO> searchAssetsTechTransformDeviceByPageOr(
            @Param("bean") AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO,
            @Param("pOrderBy") String orderBy);

    /**
     * 查询 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param id 主键id
     * @return AssetsTechTransformDeviceDTO
     */
    public AssetsTechTransformDeviceDTO findAssetsTechTransformDeviceById(String id);

    /**
     * 查询 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param projectId 技改项目id
     * @return List<AssetsTechTransformDeviceDTO>
     */
    public List<AssetsTechTransformDeviceDTO> findAssetsTechTransformDeviceByProjectId(String projectId);

    /**
     * 新增ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTO 保存对象
     * @return int
     */
    public int insertAssetsTechTransformDevice(AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO);

    /**
     * 批量新增 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsTechTransformDeviceList(List<AssetsTechTransformDeviceDTO> assetsTechTransformDeviceDTOList);

    /**
     * 更新部分对象 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformDeviceSensitive(AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO);

    /**
     * 更新全部对象 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param assetsTechTransformDeviceDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformDeviceAll(AssetsTechTransformDeviceDTO assetsTechTransformDeviceDTO);

    /**
     * 批量更新对象 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsTechTransformDeviceList(@Param("dtoList") List<AssetsTechTransformDeviceDTO> dtoList);

    /**
     * 按主键删除 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsTechTransformDeviceById(String id);

    /**
     * 按主键批量删除 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsTechTransformDeviceList(List<String> idList);

    /*
    * 根据父设备id获取该设备下的直系子设备列表，并按排序号倒序排列
    *
    * @param pId 父设备id
    * @return List<AssetsTechTransformDeviceDTO>
    */
    public List<AssetsTechTransformDeviceDTO> findAssetsTechTransformDevicesByPid(@Param("pId") String pId);

    /*
     * 根据treePath获取该路径下的所有设备，并按排序号倒序排列
     *
     * @param treePath 设备treePath
     * @return List<AssetsTechTransformDeviceDTO>
     */
    public List<AssetsTechTransformDeviceDTO> findAssetsTechTransformDevicesByTreepath(@Param("treePath") String treePath, @Param("projectId") String projectId);

    /**
     * 技改项目projectId所属设备中所有大于startSn的排序号自增2
     *
     * @param startSn 起始更新排序号
     * @return int
     */
    public int increaseAssetsTechTransformDeviceSn(@Param("startSn") Long startSn, @Param("projectId") String projectId);

    /**
     * 技改项目projectId所属设备中所有大于startSn的排序号自减1
     *
     * @param startSn 起始更新排序号
     * @return int
     */
    public int reduceAssetsTechTransformDeviceSn(@Param("startSn") Long startSn, @Param("projectId") String projectId);

    /**
     * 按技改项目id删除 ASSETS_TECH_TRANSFORM_DEVICE
     *
     * @param projectId 技改项目id
     * @return int
     */
    public int deleteAssetsTechTransformDeviceByProjectId(String projectId);
}
