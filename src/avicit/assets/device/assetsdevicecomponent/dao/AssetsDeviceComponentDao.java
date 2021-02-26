package avicit.assets.device.assetsdevicecomponent.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdevicecomponent.dto.AssetsDeviceComponentDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 11:13
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceComponentDao {

	/**
	* 分页查询  随机备件
	* @param assetsDeviceComponentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceComponentDTO>
	*/
	public Page<AssetsDeviceComponentDTO> searchAssetsDeviceComponentByPage(
			@Param("bean") AssetsDeviceComponentDTO assetsDeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 随机备件
	* @param assetsDeviceComponentDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceComponentDTO>
	*/
	public Page<AssetsDeviceComponentDTO> searchAssetsDeviceComponentByPageOr(
			@Param("bean") AssetsDeviceComponentDTO assetsDeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 随机备件
	 * @param id 主键id
	 * @return AssetsDeviceComponentDTO
	 */
	public AssetsDeviceComponentDTO findAssetsDeviceComponentById(String id);

	/**
	* 新增随机备件
	* @param assetsDeviceComponentDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceComponent(AssetsDeviceComponentDTO assetsDeviceComponentDTO);

	/**
	 * 批量新增 随机备件
	 * @param assetsDeviceComponentDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceComponentList(List<AssetsDeviceComponentDTO> assetsDeviceComponentDTOList);

	/**
	 * 更新部分对象 随机备件
	 * @param assetsDeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceComponentSensitive(AssetsDeviceComponentDTO assetsDeviceComponentDTO);

	/**
	 * 更新全部对象 随机备件
	 * @param assetsDeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceComponentAll(AssetsDeviceComponentDTO assetsDeviceComponentDTO);

	/**
	 * 批量更新对象 随机备件
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceComponentList(@Param("dtoList") List<AssetsDeviceComponentDTO> dtoList);

	/**
	 * 按主键删除 随机备件
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceComponentById(String id);

	/**
	 * 按主键批量删除 随机备件
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceComponentList(List<String> idList);
}
