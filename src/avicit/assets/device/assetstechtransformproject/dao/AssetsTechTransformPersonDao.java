package avicit.assets.device.assetstechtransformproject.dao;

import java.util.List;

import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformPersonDTO;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-09 10:25
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsTechTransformPersonDao {

    /**
     * 分页查询  ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 查询对象
     * @param orderBy                      排序条件
     * @return Page<AssetsTechTransformPersonDTO>
     */
    public Page<AssetsTechTransformPersonDTO> searchAssetsTechTransformPersonByPage(
            @Param("bean") AssetsTechTransformPersonDTO assetsTechTransformPersonDTO,
            @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 查询对象
     * @param orderBy                      排序条件
     * @return Page<AssetsTechTransformPersonDTO>
     */
    public Page<AssetsTechTransformPersonDTO> searchAssetsTechTransformPersonByPageOr(
            @Param("bean") AssetsTechTransformPersonDTO assetsTechTransformPersonDTO,
            @Param("pOrderBy") String orderBy);

    /**
     * 查询ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 查询对象
     * @return List<AssetsTechTransformPersonDTO>
     */
    public List<AssetsTechTransformPersonDTO> searchAssetsTechTransformPerson(
            AssetsTechTransformPersonDTO assetsTechTransformPersonDTO);

    /**
     * 查询 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param id 主键id
     * @return AssetsTechTransformPersonDTO
     */
    public AssetsTechTransformPersonDTO findAssetsTechTransformPersonById(String id);

    /**
     * 新增ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 保存对象
     * @return int
     */
    public int insertAssetsTechTransformPerson(AssetsTechTransformPersonDTO assetsTechTransformPersonDTO);

    /**
     * 批量新增 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsTechTransformPersonList(List<AssetsTechTransformPersonDTO> assetsTechTransformPersonDTOList);

    /**
     * 更新部分对象 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformPersonSensitive(AssetsTechTransformPersonDTO assetsTechTransformPersonDTO);

    /**
     * 更新全部对象 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param assetsTechTransformPersonDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformPersonAll(AssetsTechTransformPersonDTO assetsTechTransformPersonDTO);

    /**
     * 批量更新对象 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsTechTransformPersonList(@Param("dtoList") List<AssetsTechTransformPersonDTO> dtoList);

    /**
     * 按主键删除 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsTechTransformPersonById(String id);

    /**
     * 按主键批量删除 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsTechTransformPersonList(List<String> idList);

    /**
     * 按技改项目id批量删除 ASSETS_TECH_TRANSFORM_PERSON
     *
     * @param projectId 技改项目id
     * @return int
     */
    public int deleteAssetsTechTransformPersonByProjectId(String projectId);
}
