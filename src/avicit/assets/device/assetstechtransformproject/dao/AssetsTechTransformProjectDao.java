package avicit.assets.device.assetstechtransformproject.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformProjectDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 09:54
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsTechTransformProjectDao {

    /**
     * 分页查询  ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 查询对象
     * @param orderBy                       排序条件
     * @return Page<AssetsTechTransformProjectDTO>
     */
    public Page<AssetsTechTransformProjectDTO> searchAssetsTechTransformProjectByPage(@Param("bean") AssetsTechTransformProjectDTO assetsTechTransformProjectDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 查询对象
     * @param orderBy                       排序条件
     * @return Page<AssetsTechTransformProjectDTO>
     */
    public Page<AssetsTechTransformProjectDTO> searchAssetsTechTransformProjectByPageOr(@Param("bean") AssetsTechTransformProjectDTO assetsTechTransformProjectDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 查询对象
     * @return List<AssetsTechTransformProjectDTO>
     */
    public List<AssetsTechTransformProjectDTO> searchAssetsTechTransformProject(AssetsTechTransformProjectDTO assetsTechTransformProjectDTO);

    /**
     * 查询 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param id 主键id
     * @return AssetsTechTransformProjectDTO
     */
    public AssetsTechTransformProjectDTO findAssetsTechTransformProjectById(String id);

    /**
     * 新增ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 保存对象
     * @return int
     */
    public int insertAssetsTechTransformProject(AssetsTechTransformProjectDTO assetsTechTransformProjectDTO);

    /**
     * 批量新增 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsTechTransformProjectList(List<AssetsTechTransformProjectDTO> assetsTechTransformProjectDTOList);

    /**
     * 更新部分对象 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformProjectSensitive(AssetsTechTransformProjectDTO assetsTechTransformProjectDTO);

    /**
     * 更新全部对象 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param assetsTechTransformProjectDTO 更新对象
     * @return int
     */
    public int updateAssetsTechTransformProjectAll(AssetsTechTransformProjectDTO assetsTechTransformProjectDTO);

    /**
     * 批量更新对象 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsTechTransformProjectList(@Param("dtoList") List<AssetsTechTransformProjectDTO> dtoList);

    /**
     * 按主键删除 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsTechTransformProjectById(String id);

    /**
     * 按主键批量删除 ASSETS_TECH_TRANSFORM_PROJECT
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsTechTransformProjectList(List<String> idList);

    /**
     * 获取项目序号为projectNo，id不为projectId的技改项目数量
     *
     * @param projectNo 技改项目序号  projectId技改项目id
     * @return Integer
     */
    public Integer getTechTransformProjectCount(@Param("projectNo") String projectNo,  @Param("projectId") String projectId);
}
