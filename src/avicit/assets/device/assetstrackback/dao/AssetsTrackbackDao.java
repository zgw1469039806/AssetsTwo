package avicit.assets.device.assetstrackback.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetstrackback.dto.AssetsTrackbackDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:35
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsTrackbackDao {

	/**
	* 分页查询  超差追溯
	* @param assetsTrackbackDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTrackbackDTO>
	*/
	public Page<AssetsTrackbackDTO> searchAssetsTrackbackByPage(@Param("bean") AssetsTrackbackDTO assetsTrackbackDTO,
                                                                @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 超差追溯
	* @param assetsTrackbackDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsTrackbackDTO>
	*/
	public Page<AssetsTrackbackDTO> searchAssetsTrackbackByPageOr(@Param("bean") AssetsTrackbackDTO assetsTrackbackDTO,
                                                                  @Param("pOrderBy") String orderBy);

	/**
	* 查询超差追溯
	* @param assetsTrackbackDTO 查询对象
	* @return List<AssetsTrackbackDTO>
	*/
	public List<AssetsTrackbackDTO> searchAssetsTrackback(AssetsTrackbackDTO assetsTrackbackDTO);

	/**
	 * 查询 超差追溯
	 * @param id 主键id
	 * @return AssetsTrackbackDTO
	 */
	public AssetsTrackbackDTO findAssetsTrackbackById(String id);

	/**
	* 新增超差追溯
	* @param assetsTrackbackDTO 保存对象
	* @return int
	*/
	public int insertAssetsTrackback(AssetsTrackbackDTO assetsTrackbackDTO);

	/**
	 * 批量新增 超差追溯
	 * @param assetsTrackbackDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTrackbackList(List<AssetsTrackbackDTO> assetsTrackbackDTOList);

	/**
	 * 更新部分对象 超差追溯
	 * @param assetsTrackbackDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTrackbackSensitive(AssetsTrackbackDTO assetsTrackbackDTO);

	/**
	 * 更新全部对象 超差追溯
	 * @param assetsTrackbackDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTrackbackAll(AssetsTrackbackDTO assetsTrackbackDTO);

	/**
	 * 批量更新对象 超差追溯
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTrackbackList(@Param("dtoList") List<AssetsTrackbackDTO> dtoList);

	/**
	 * 按主键删除 超差追溯
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTrackbackById(String id);

	/**
	 * 按主键批量删除 超差追溯
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTrackbackList(List<String> idList);
}
