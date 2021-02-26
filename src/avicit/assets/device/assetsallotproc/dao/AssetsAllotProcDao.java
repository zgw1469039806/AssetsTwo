package avicit.assets.device.assetsallotproc.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsallotproc.dto.AssetsAllotProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-17 09:02
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsAllotProcDao {

    /**
     * 分页查询  ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 查询对象
     * @param orderBy            排序条件
     * @return Page<AssetsAllotProcDTO>
     */
    public Page<AssetsAllotProcDTO> searchAssetsAllotProcByPage(@Param("bean") AssetsAllotProcDTO assetsAllotProcDTO,
                                                                @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 查询对象
     * @param orderBy            排序条件
     * @return Page<AssetsAllotProcDTO>
     */
    public Page<AssetsAllotProcDTO> searchAssetsAllotProcByPageOr(@Param("bean") AssetsAllotProcDTO assetsAllotProcDTO,
                                                                  @Param("pOrderBy") String orderBy);

    /**
     * 查询 ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 查询对象
     * @return List<AssetsAllotProcDTO>
     */
    public List<AssetsAllotProcDTO> searchAssetsAllotProc(AssetsAllotProcDTO assetsAllotProcDTO);

    /**
     * 查询 ASSETS_ALLOT_PROC
     *
     * @param id 主键id
     * @return AssetsAllotProcDTO
     */
    public AssetsAllotProcDTO findAssetsAllotProcById(String id);

    /**
     * 新增ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 保存对象
     * @return int
     */
    public int insertAssetsAllotProc(AssetsAllotProcDTO assetsAllotProcDTO);

    /**
     * 批量新增 ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsAllotProcList(List<AssetsAllotProcDTO> assetsAllotProcDTOList);

    /**
     * 更新部分对象 ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 更新对象
     * @return int
     */
    public int updateAssetsAllotProcSensitive(AssetsAllotProcDTO assetsAllotProcDTO);

    /**
     * 更新全部对象 ASSETS_ALLOT_PROC
     *
     * @param assetsAllotProcDTO 更新对象
     * @return int
     */
    public int updateAssetsAllotProcAll(AssetsAllotProcDTO assetsAllotProcDTO);

    /**
     * 批量更新对象 ASSETS_ALLOT_PROC
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsAllotProcList(@Param("dtoList") List<AssetsAllotProcDTO> dtoList);

    /**
     * 按主键删除 ASSETS_ALLOT_PROC
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsAllotProcById(String id);

    /**
     * 按主键批量删除 ASSETS_ALLOT_PROC
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsAllotProcList(List<String> idList);
}