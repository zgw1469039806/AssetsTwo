package avicit.assets.device.dynsdcollecupld.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynsdcollecupld.dto.DynSdCollecUpldDTO;


/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 15:42
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface DynSdCollecUpldDao {
    
    																																											/**
     * 分页查询  DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynSdCollecUpldDTO>
     */
	public Page<DynSdCollecUpldDTO> searchDynSdCollecUpldByPage(@Param("bean") DynSdCollecUpldDTO dynSdCollecUpldDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
							
    																																											/**
     * 按or条件的分页查询 DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 查询对象
     * @param orgIdentity 组织id
     * @param orderBy 排序条件
     * @return Page<DynSdCollecUpldDTO>
     */
	public Page<DynSdCollecUpldDTO> searchDynSdCollecUpldByPageOr(@Param("bean") DynSdCollecUpldDTO dynSdCollecUpldDTO, @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy) ;
						    /**
     * 查询DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 查询对象
     * @return List<DynSdCollecUpldDTO>
     */
    public List<DynSdCollecUpldDTO> searchDynSdCollecUpld(DynSdCollecUpldDTO dynSdCollecUpldDTO);

    /**
     * 查询 DYN_SD_COLLEC_UPLD
     * @param id 主键id
     * @return DynSdCollecUpldDTO
     */
    public DynSdCollecUpldDTO findDynSdCollecUpldById(String id);
    
         /**
     * 新增DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 保存对象
     * @return int
     */
    public int insertDynSdCollecUpld(DynSdCollecUpldDTO dynSdCollecUpldDTO);
    
    /**
     * 批量新增 DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTOList 保存对象集合
     * @return int
     */
    public int insertDynSdCollecUpldList(List<DynSdCollecUpldDTO> dynSdCollecUpldDTOList);
    
    /**
     * 更新部分对象 DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 更新对象
     * @return int
     */
    public int updateDynSdCollecUpldSensitive(DynSdCollecUpldDTO dynSdCollecUpldDTO);
    
    /**
     * 更新全部对象 DYN_SD_COLLEC_UPLD
     * @param dynSdCollecUpldDTO 更新对象
     * @return int
     */
    public int updateDynSdCollecUpldAll(DynSdCollecUpldDTO dynSdCollecUpldDTO);
    
    /**
     * 批量更新对象 DYN_SD_COLLEC_UPLD
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateDynSdCollecUpldList(@Param("dtoList") List<DynSdCollecUpldDTO> dtoList);
    
    /**
     * 按主键删除 DYN_SD_COLLEC_UPLD
     * @param id 主键id
     * @return int
     */ 
    public int deleteDynSdCollecUpldById(String id);
    
    /**
     * 按主键批量删除 DYN_SD_COLLEC_UPLD
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteDynSdCollecUpldList(List<String> idList); 
    }
