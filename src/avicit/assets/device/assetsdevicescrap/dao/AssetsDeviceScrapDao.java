package avicit.assets.device.assetsdevicescrap.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicescrap.dto.AssetsDeviceScrapDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-10 15:32
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceScrapDao {

	/**
	* 分页查询  设备报废
	* @param assetsDeviceScrapDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceScrapDTO>
	*/
	public Page<AssetsDeviceScrapDTO> searchAssetsDeviceScrapByPage(
            @Param("bean") AssetsDeviceScrapDTO assetsDeviceScrapDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备报废
	* @param assetsDeviceScrapDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceScrapDTO>
	*/
	public Page<AssetsDeviceScrapDTO> searchAssetsDeviceScrapByPageOr(
            @Param("bean") AssetsDeviceScrapDTO assetsDeviceScrapDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询设备报废
	* @param assetsDeviceScrapDTO 查询对象
	* @return List<AssetsDeviceScrapDTO>
	*/
	public List<AssetsDeviceScrapDTO> searchAssetsDeviceScrap(AssetsDeviceScrapDTO assetsDeviceScrapDTO);

	/**
	 * 查询 设备报废
	 * @param id 主键id
	 * @return AssetsDeviceScrapDTO
	 */
	public AssetsDeviceScrapDTO findAssetsDeviceScrapById(String id);

	/**
	* 新增设备报废
	* @param assetsDeviceScrapDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceScrap(AssetsDeviceScrapDTO assetsDeviceScrapDTO);

	/**
	 * 批量新增 设备报废
	 * @param assetsDeviceScrapDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceScrapList(List<AssetsDeviceScrapDTO> assetsDeviceScrapDTOList);

	/**
	 * 更新部分对象 设备报废
	 * @param assetsDeviceScrapDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceScrapSensitive(AssetsDeviceScrapDTO assetsDeviceScrapDTO);

	/**
	 * 更新全部对象 设备报废
	 * @param assetsDeviceScrapDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceScrapAll(AssetsDeviceScrapDTO assetsDeviceScrapDTO);

	/**
	 * 批量更新对象 设备报废
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceScrapList(@Param("dtoList") List<AssetsDeviceScrapDTO> dtoList);

	/**
	 * 按主键删除 设备报废
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceScrapById(String id);

	/**
	 * 按主键批量删除 设备报废
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceScrapList(List<String> idList);
}
