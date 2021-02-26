package avicit.assets.device.assetsdevicerchecktemporary.dao;

import java.util.Date;
import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-10 11:01
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceRcheckTemporaryDao {

	/**
	* 分页查询  定期检查设备详情表
	* @param assetsDeviceRcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryByPage(
			@Param("bean") AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 定期检查设备详情表
	* @param assetsDeviceRcheckTemporaryDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceRcheckTemporaryDTO>
	*/
	public Page<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryByPageOr(
			@Param("bean") AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO,
			@Param("pOrderBy") String orderBy);

	/**
	* 查询定期检查设备详情表
	* @return List<AssetsDeviceRcheckTemporaryDTO>
	*/
	public List<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporary();

	/**
	 * 查询 定期检查设备详情表
	 * @param id 主键id
	 * @return AssetsDeviceRcheckTemporaryDTO
	 */
	public AssetsDeviceRcheckTemporaryDTO findAssetsDeviceRcheckTemporaryById(String id);

	/**
	* 新增定期检查设备详情表
	* @param assetsDeviceRcheckTemporaryDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceRcheckTemporary(AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO);

	/**
	 * 批量新增 定期检查设备详情表
	 * @param assetsDeviceRcheckTemporaryDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceRcheckTemporaryList(
			List<AssetsDeviceRcheckTemporaryDTO> assetsDeviceRcheckTemporaryDTOList);

	/**
	 * 更新部分对象 定期检查设备详情表
	 * @param assetsDeviceRcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRcheckTemporarySensitive(
			AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO);

	/**
	 * 更新全部对象 定期检查设备详情表
	 * @param assetsDeviceRcheckTemporaryDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceRcheckTemporaryAll(AssetsDeviceRcheckTemporaryDTO assetsDeviceRcheckTemporaryDTO);

	/**
	 * 批量更新对象 定期检查设备详情表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceRcheckTemporaryList(@Param("dtoList") List<AssetsDeviceRcheckTemporaryDTO> dtoList);

	/**
	 * 按主键删除 定期检查设备详情表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckTemporaryById(String id);

	/**
	 * 清空数据表
	 * @return
	 */
	public int deleteAssetsDeviceRcheckTemporaryAll();
	/**
	 * 按主键批量删除 定期检查设备详情表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceRcheckTemporaryList(List<String> idList);

	/**
	 * 生成定检计划临时表数据
	 * @param ids 选中数据台账定检信息表的ID列表
	 * @param endDate 定检范围的结束时间
	 * @return int
	 */
	public int saveAssetsDeviceRcheckTemporary(String[] ids, Date endDate);

	/**
	 * 查询当前表中根据时间的最大数据列表
	 * @return
	 */
	public  List<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryMax();


}
