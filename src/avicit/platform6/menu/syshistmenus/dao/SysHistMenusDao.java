package avicit.platform6.menu.syshistmenus.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.sfn.intercept.SelfDefined;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.menu.syshistmenus.dto.SysHistMenusDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-05 17:18
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface SysHistMenusDao {
    
    																																																																																																			/**
     * 分页查询  系统历史菜单表
     * @param sysHistMenusDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<SysHistMenusDTO>
     */
	public Page<SysHistMenusDTO> searchSysHistMenusByPage(@Param("bean")SysHistMenusDTO sysHistMenusDTO,@Param("pOrderBy")String  orderBy) ;


    /**
     * 查詢我的瀏覽記錄
     * @param userId
     * @return
     */
    Page<SysHistMenusDTO> searchMySysHistMenus(String  userId);
    																																																																																																			/**
     * 按or条件的分页查询 系统历史菜单表
     * @param sysHistMenusDTO 查询对象
     * @param orderBy 排序条件
     * @return Page<SysHistMenusDTO>
     */
	public Page<SysHistMenusDTO> searchSysHistMenusByPageOr(@Param("bean")SysHistMenusDTO sysHistMenusDTO,@Param("pOrderBy")String  orderBy) ;
		
    /**
     * 查询 系统历史菜单表
     * @param id 主键id
     * @return SysHistMenusDTO
     */
    public SysHistMenusDTO findSysHistMenusById(String id);
    
         /**
     * 新增系统历史菜单表
     * @param sysHistMenusDTO 保存对象
     * @return int
     */
    public int insertSysHistMenus(SysHistMenusDTO sysHistMenusDTO);
    
    /**
     * 批量新增 系统历史菜单表
     * @param sysHistMenusDTOList 保存对象集合
     * @return int
     */
    public int insertSysHistMenusList(List<SysHistMenusDTO> sysHistMenusDTOList);
    
    /**
     * 更新部分对象 系统历史菜单表
     * @param sysHistMenusDTO 更新对象
     * @return int
     */
    public int updateSysHistMenusSensitive(SysHistMenusDTO sysHistMenusDTO);
    
    /**
     * 更新全部对象 系统历史菜单表
     * @param sysHistMenusDTO 更新对象
     * @return int
     */
    public int updateSysHistMenusAll(SysHistMenusDTO sysHistMenusDTO);
    
    /**
     * 批量更新对象 系统历史菜单表
     * @param dtoList 批量更新对象集合
     * @return int
     */
    public int updateSysHistMenusList(@Param("dtoList") List<SysHistMenusDTO> dtoList);
    
    /**
     * 按主键删除 系统历史菜单表
     * @param id 主键id
     * @return int
     */ 
    public int deleteSysHistMenusById(String id);
    
    /**
     * 按主键批量删除 系统历史菜单表
     * @param idList 主键集合
     * @return int
     */ 
    public int deleteSysHistMenusList(List<String> idList);
    }
