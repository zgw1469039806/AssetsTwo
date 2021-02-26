package avicit.assets.assetsapplymodule.dao;

import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 14:22
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsApplyModuleDao {

    /**
     * 分页查询  ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTO 查询对象
     * @param orderBy              排序条件
     * @return Page<AssetsApplyModuleDTO>
     */
    public Page<AssetsApplyModuleDTO> searchAssetsApplyModuleByPage(@Param("bean") AssetsApplyModuleDTO assetsApplyModuleDTO, @Param("pOrderBy") String orderBy);

    /**
     * 按or条件的分页查询 ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTO 查询对象
     * @param orderBy              排序条件
     * @return Page<AssetsApplyModuleDTO>
     */
    public Page<AssetsApplyModuleDTO> searchAssetsApplyModuleByPageOr(@Param("bean") AssetsApplyModuleDTO assetsApplyModuleDTO, @Param("pOrderBy") String orderBy);

    /**
     * 查询 ASSETS_APPLY_MODULE
     *
     * @param id 主键id
     * @return AssetsApplyModuleDTO
     */
    public AssetsApplyModuleDTO findAssetsApplyModuleById(String id);

    /**
     * 新增ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTO 保存对象
     * @return int
     */
    public int insertAssetsApplyModule(AssetsApplyModuleDTO assetsApplyModuleDTO);

    /**
     * 批量新增 ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTOList 保存对象集合
     * @return int
     */
    public int insertAssetsApplyModuleList(List<AssetsApplyModuleDTO> assetsApplyModuleDTOList);

    /**
     * 更新部分对象 ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTO 更新对象
     * @return int
     */
    public int updateAssetsApplyModuleSensitive(AssetsApplyModuleDTO assetsApplyModuleDTO);

    /**
     * 解除和合同系统关联的数据
     *
     * @param contractId
     * @return
     */
    int updateContract(String contractId);

    /**
     * 更新全部对象 ASSETS_APPLY_MODULE
     *
     * @param assetsApplyModuleDTO 更新对象
     * @return int
     */
    public int updateAssetsApplyModuleAll(AssetsApplyModuleDTO assetsApplyModuleDTO);

    /**
     * 批量更新对象 ASSETS_APPLY_MODULE
     *
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateAssetsApplyModuleList(@Param("dtoList") List<AssetsApplyModuleDTO> dtoList);

    /**
     * 按主键删除 ASSETS_APPLY_MODULE
     *
     * @param id 主键id
     * @return int
     */
    public int deleteAssetsApplyModuleById(String id);

    /**
     * 按主键批量删除 ASSETS_APPLY_MODULE
     *
     * @param idList 主键集合
     * @return int
     */
    public int deleteAssetsApplyModuleList(List<String> idList);

    /**
     * 根据申购Id(applyId)获取合同列表
     * @param applyId 申购Id
     * @return List<AssetsApplyModuleDTO>
     * @throws Exception
     */
    public List<AssetsApplyModuleDTO> getAssetsApplyModulesByApplyId(String applyId);
}
