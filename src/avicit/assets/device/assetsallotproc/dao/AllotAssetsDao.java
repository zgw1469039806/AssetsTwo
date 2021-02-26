package avicit.assets.device.assetsallotproc.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsallotproc.dto.AllotAssetsDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-17 09:02
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AllotAssetsDao {

    /**
     * 分页查询  ALLOT_ASSETS
     *
     * @param allotAssetsDTO 查询对象
     * @param orderBy        排序条件
     * @return Page<AllotAssetsDTO>
     */
    public Page<AllotAssetsDTO> searchAllotAssetsByPage(@Param("bean") AllotAssetsDTO allotAssetsDTO,
                                                        @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ALLOT_ASSETS
     *
     * @param allotAssetsDTO 查询对象
     * @param orderBy        排序条件
     * @return Page<AllotAssetsDTO>
     */
    public Page<AllotAssetsDTO> searchAllotAssetsByPageOr(@Param("bean") AllotAssetsDTO allotAssetsDTO,
                                                          @Param("pOrderBy") String orderBy);

    /**
     * 查询 ALLOT_ASSETS
     *
     * @param id 主键id
     * @return AllotAssetsDTO
     */
    public AllotAssetsDTO findAllotAssetsById(String id);

    /**
     * 查询 ALLOT_ASSETS
     *
     * @param pid 父id
     * @return List<AllotAssetsDTO>
     */
    public List<AllotAssetsDTO> findAllotAssetsByPid(String pid);

    /**
     * 新增ALLOT_ASSETS
     *
     * @param allotAssetsDTO 保存对象
     * @return int
     */
    public int insertAllotAssets(AllotAssetsDTO allotAssetsDTO);

    /**
     * 批量新增 ALLOT_ASSETS
     *
     * @param allotAssetsDTOList 保存对象集合
     * @return int
     */
    public int insertAllotAssetsList(List<AllotAssetsDTO> allotAssetsDTOList);

    /**
     * 更新部分对象 ALLOT_ASSETS
     *
     * @param allotAssetsDTO 更新对象
     * @return int
     */
    public int updateAllotAssetsSensitive(AllotAssetsDTO allotAssetsDTO);

    /**
     * 更新全部对象 ALLOT_ASSETS
     *
     * @param allotAssetsDTO 更新对象
     * @return int
     */
    public int updateAllotAssetsAll(AllotAssetsDTO allotAssetsDTO);

    /**
     * 批量更新对象 ALLOT_ASSETS
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAllotAssetsList(@Param("dtoList") List<AllotAssetsDTO> dtoList);

    /**
     * 按主键删除 ALLOT_ASSETS
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAllotAssetsById(String id);

    /**
     * 按主键批量删除 ALLOT_ASSETS
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAllotAssetsList(List<String> idList);
}