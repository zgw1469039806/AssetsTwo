package avicit.assets.device.assetsaccidentproc.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsaccidentproc.dto.AssetsAccidentProcDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 20:11
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsAccidentProcDao {

    /**
     * 分页查询  ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 查询对象
     * @param orderBy               排序条件
     * @return Page<AssetsAccidentProcDTO>
     */
    public Page<AssetsAccidentProcDTO> searchAssetsAccidentProcByPage(
            @Param("bean") AssetsAccidentProcDTO assetsAccidentProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 查询对象
     * @param orderBy               排序条件
     * @return Page<AssetsAccidentProcDTO>
     */
    public Page<AssetsAccidentProcDTO> searchAssetsAccidentProcByPageOr(
            @Param("bean") AssetsAccidentProcDTO assetsAccidentProcDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 查询对象
     * @return List<AssetsAccidentProcDTO>
     */
    public List<AssetsAccidentProcDTO> searchAssetsAccidentProc(AssetsAccidentProcDTO assetsAccidentProcDTO);

    /**
     * 查询 ASSETS_ACCIDENT_PROC
     *
     * @param id 主键id
     * @return AssetsAccidentProcDTO
     */
    public AssetsAccidentProcDTO findAssetsAccidentProcById(String id);

    /**
     * 新增ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 保存对象
     * @return int
     */
    public int insertAssetsAccidentProc(AssetsAccidentProcDTO assetsAccidentProcDTO);

    /**
     * 批量新增 ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsAccidentProcList(List<AssetsAccidentProcDTO> assetsAccidentProcDTOList);

    /**
     * 更新部分对象 ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 更新对象
     * @return int
     */
    public int updateAssetsAccidentProcSensitive(AssetsAccidentProcDTO assetsAccidentProcDTO);

    /**
     * 更新全部对象 ASSETS_ACCIDENT_PROC
     *
     * @param assetsAccidentProcDTO 更新对象
     * @return int
     */
    public int updateAssetsAccidentProcAll(AssetsAccidentProcDTO assetsAccidentProcDTO);

    /**
     * 批量更新对象 ASSETS_ACCIDENT_PROC
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsAccidentProcList(@Param("dtoList") List<AssetsAccidentProcDTO> dtoList);

    /**
     * 按主键删除 ASSETS_ACCIDENT_PROC
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsAccidentProcById(String id);

    /**
     * 按主键批量删除 ASSETS_ACCIDENT_PROC
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsAccidentProcList(List<String> idList);
}