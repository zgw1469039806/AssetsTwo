package avicit.assets.device.assetsuserlog.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsuserlog.dto.AssetsUserLogDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 10:07
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsUserLogDao {

	/**
	* 分页查询  资产用户日志表
	* @param assetsUserLogDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsUserLogDTO>
	*/
	public Page<AssetsUserLogDTO> searchAssetsUserLogByPage(@Param("bean") AssetsUserLogDTO assetsUserLogDTO,
                                                            @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 资产用户日志表
	* @param assetsUserLogDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsUserLogDTO>
	*/
	public Page<AssetsUserLogDTO> searchAssetsUserLogByPageOr(@Param("bean") AssetsUserLogDTO assetsUserLogDTO,
                                                              @Param("pOrderBy") String orderBy);

	/**
	* 查询资产用户日志表
	* @param assetsUserLogDTO 查询对象
	* @return List<AssetsUserLogDTO>
	*/
	public List<AssetsUserLogDTO> searchAssetsUserLog(AssetsUserLogDTO assetsUserLogDTO);

	/**
	 * 查询 资产用户日志表
	 * @param id 主键id
	 * @return AssetsUserLogDTO
	 */
	public AssetsUserLogDTO findAssetsUserLogById(String id);

	/**
	* 新增资产用户日志表
	* @param assetsUserLogDTO 保存对象
	* @return int
	*/
	public int insertAssetsUserLog(AssetsUserLogDTO assetsUserLogDTO);

	/**
	 * 批量新增 资产用户日志表
	 * @param assetsUserLogDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsUserLogList(List<AssetsUserLogDTO> assetsUserLogDTOList);

	/**
	 * 更新部分对象 资产用户日志表
	 * @param assetsUserLogDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUserLogSensitive(AssetsUserLogDTO assetsUserLogDTO);

	/**
	 * 更新全部对象 资产用户日志表
	 * @param assetsUserLogDTO 更新对象
	 * @return int
	 */
	public int updateAssetsUserLogAll(AssetsUserLogDTO assetsUserLogDTO);

	/**
	 * 批量更新对象 资产用户日志表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsUserLogList(@Param("dtoList") List<AssetsUserLogDTO> dtoList);

	/**
	 * 按主键删除 资产用户日志表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsUserLogById(String id);

	/**
	 * 按主键批量删除 资产用户日志表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsUserLogList(List<String> idList);
}
