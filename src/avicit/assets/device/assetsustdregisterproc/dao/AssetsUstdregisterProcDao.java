package avicit.assets.device.assetsustdregisterproc.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdregisterproc.dto.AssetsUstdregisterProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-11 12:56
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsUstdregisterProcDao {

    /**
     * 分页查询  ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 查询对象
     * @param orderBy                   排序条件
     * @return Page<AssetsUstdregisterProcDTO>
     */
    public Page<AssetsUstdregisterProcDTO> searchAssetsUstdregisterProcByPage(
            @Param("bean") AssetsUstdregisterProcDTO assetsUstdregisterProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 查询对象
     * @param orderBy                   排序条件
     * @return Page<AssetsUstdregisterProcDTO>
     */
    public Page<AssetsUstdregisterProcDTO> searchAssetsUstdregisterProcByPageOr(
            @Param("bean") AssetsUstdregisterProcDTO assetsUstdregisterProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 查询对象
     * @return List<AssetsUstdregisterProcDTO>
     */
    public List<AssetsUstdregisterProcDTO> searchAssetsUstdregisterProc(
            AssetsUstdregisterProcDTO assetsUstdregisterProcDTO);

    /**
     * 查询 ASSETS_USTDREGISTER_PROC
     *
     * @param id 主键id
     * @return AssetsUstdregisterProcDTO
     */
    public AssetsUstdregisterProcDTO findAssetsUstdregisterProcById(String id);

    /**
     * 新增ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 保存对象
     * @return int
     */
    public int insertAssetsUstdregisterProc(AssetsUstdregisterProcDTO assetsUstdregisterProcDTO);

    /**
     * 批量新增 ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsUstdregisterProcList(List<AssetsUstdregisterProcDTO> assetsUstdregisterProcDTOList);

    /**
     * 更新部分对象 ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdregisterProcSensitive(AssetsUstdregisterProcDTO assetsUstdregisterProcDTO);

    /**
     * 更新全部对象 ASSETS_USTDREGISTER_PROC
     *
     * @param assetsUstdregisterProcDTO 更新对象
     * @return int
     */
    public int updateAssetsUstdregisterProcAll(AssetsUstdregisterProcDTO assetsUstdregisterProcDTO);

    /**
     * 批量更新对象 ASSETS_USTDREGISTER_PROC
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsUstdregisterProcList(@Param("dtoList") List<AssetsUstdregisterProcDTO> dtoList);

    /**
     * 按主键删除 ASSETS_USTDREGISTER_PROC
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsUstdregisterProcById(String id);

    /**
     * 按主键批量删除 ASSETS_USTDREGISTER_PROC
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsUstdregisterProcList(List<String> idList);
}