package avicit.assets.device.assetsshiftproc.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsshiftproc.dto.AssetsShiftProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-15 16:10
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsShiftProcDao {

    /**
     * 分页查询  ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 查询对象
     * @param orderBy            排序条件
     * @return Page<AssetsShiftProcDTO>
     */
    public Page<AssetsShiftProcDTO> searchAssetsShiftProcByPage(@Param("bean") AssetsShiftProcDTO assetsShiftProcDTO,
                                                                @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 查询对象
     * @param orderBy            排序条件
     * @return Page<AssetsShiftProcDTO>
     */
    public Page<AssetsShiftProcDTO> searchAssetsShiftProcByPageOr(@Param("bean") AssetsShiftProcDTO assetsShiftProcDTO,
                                                                  @Param("pOrderBy") String orderBy);

    /**
     * 查询ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 查询对象
     * @return List<AssetsShiftProcDTO>
     */
    public List<AssetsShiftProcDTO> searchAssetsShiftProc(AssetsShiftProcDTO assetsShiftProcDTO);

    /**
     * 查询 ASSETS_SHIFT_PROC
     *
     * @param id 主键id
     * @return AssetsShiftProcDTO
     */
    public AssetsShiftProcDTO findAssetsShiftProcById(String id);

    /**
     * 新增ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 保存对象
     * @return int
     */
    public int insertAssetsShiftProc(AssetsShiftProcDTO assetsShiftProcDTO);

    /**
     * 批量新增 ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsShiftProcList(List<AssetsShiftProcDTO> assetsShiftProcDTOList);

    /**
     * 更新部分对象 ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 更新对象
     * @return int
     */
    public int updateAssetsShiftProcSensitive(AssetsShiftProcDTO assetsShiftProcDTO);

    /**
     * 更新全部对象 ASSETS_SHIFT_PROC
     *
     * @param assetsShiftProcDTO 更新对象
     * @return int
     */
    public int updateAssetsShiftProcAll(AssetsShiftProcDTO assetsShiftProcDTO);

    /**
     * 批量更新对象 ASSETS_SHIFT_PROC
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsShiftProcList(@Param("dtoList") List<AssetsShiftProcDTO> dtoList);

    /**
     * 按主键删除 ASSETS_SHIFT_PROC
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsShiftProcById(String id);

    /**
     * 按主键批量删除 ASSETS_SHIFT_PROC
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsShiftProcList(List<String> idList);
}