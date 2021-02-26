package avicit.assets.device.assetsdevicereuse.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicereuse.dto.AssetsDeviceReuseDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 19:33
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceReuseDao {

	/**
	* 分页查询  设备再用
	* @param assetsDeviceReuseDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceReuseDTO>
	*/
	public Page<AssetsDeviceReuseDTO> searchAssetsDeviceReuseByPage(
            @Param("bean") AssetsDeviceReuseDTO assetsDeviceReuseDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备再用
	* @param assetsDeviceReuseDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceReuseDTO>
	*/
	public Page<AssetsDeviceReuseDTO> searchAssetsDeviceReuseByPageOr(
            @Param("bean") AssetsDeviceReuseDTO assetsDeviceReuseDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备再用
	* @param assetsDeviceReuseDTO 查询对象
	* @return List<AssetsDeviceReuseDTO>
	*/
	public List<AssetsDeviceReuseDTO> searchAssetsDeviceReuse(AssetsDeviceReuseDTO assetsDeviceReuseDTO);

	/**
	 * 查询 设备再用
	 * @param id 主键id
	 * @return AssetsDeviceReuseDTO
	 */
	public AssetsDeviceReuseDTO findAssetsDeviceReuseById(String id);

	/**
	 * 新增设备再用
	 * @param assetsDeviceReuseDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceReuse(AssetsDeviceReuseDTO assetsDeviceReuseDTO);

	/**
	 * 批量新增 设备再用
	 * @param assetsDeviceReuseDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceReuseList(List<AssetsDeviceReuseDTO> assetsDeviceReuseDTOList);

	/**
	* 更新部分对象 设备再用
	* @param assetsDeviceReuseDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceReuseSensitive(AssetsDeviceReuseDTO assetsDeviceReuseDTO);

	/**
	 * 更新全部对象 设备再用
	 * @param assetsDeviceReuseDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceReuseAll(AssetsDeviceReuseDTO assetsDeviceReuseDTO);

	/**
	 * 批量更新对象 设备再用
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceReuseList(@Param("dtoList") List<AssetsDeviceReuseDTO> dtoList);

	/**
	 * 按主键删除 设备再用
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceReuseById(String id);

	/**
	 * 按主键批量删除 设备再用
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceReuseList(List<String> idList);
}
