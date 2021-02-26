package avicit.assets.device.assetsdevicetransfer.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsDeviceTransferDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceTransferDao {

	/**
	* 分页查询  设备移交流程表
	* @param assetsDeviceTransferDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceTransferDTO>
	*/
	public Page<AssetsDeviceTransferDTO> searchAssetsDeviceTransferByPage(
            @Param("bean") AssetsDeviceTransferDTO assetsDeviceTransferDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 设备移交流程表
	* @param assetsDeviceTransferDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceTransferDTO>
	*/
	public Page<AssetsDeviceTransferDTO> searchAssetsDeviceTransferByPageOr(
            @Param("bean") AssetsDeviceTransferDTO assetsDeviceTransferDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询 设备移交流程表
	* @param assetsDeviceTransferDTO 查询对象
	* @return List<AssetsDeviceTransferDTO>
	*/
	public List<AssetsDeviceTransferDTO> searchAssetsDeviceTransfer(AssetsDeviceTransferDTO assetsDeviceTransferDTO);

	/**
	 * 查询 设备移交流程表
	 * @param id 主键id
	 * @return AssetsDeviceTransferDTO
	 */
	public AssetsDeviceTransferDTO findAssetsDeviceTransferById(String id);

	/**
	 * 新增设备移交流程表
	 * @param assetsDeviceTransferDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceTransfer(AssetsDeviceTransferDTO assetsDeviceTransferDTO);

	/**
	 * 批量新增 设备移交流程表
	 * @param assetsDeviceTransferDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceTransferList(List<AssetsDeviceTransferDTO> assetsDeviceTransferDTOList);

	/**
	* 更新部分对象 设备移交流程表
	* @param assetsDeviceTransferDTO 更新对象
	* @return int
	*/
	public int updateAssetsDeviceTransferSensitive(AssetsDeviceTransferDTO assetsDeviceTransferDTO);

	/**
	 * 更新全部对象 设备移交流程表
	 * @param assetsDeviceTransferDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceTransferAll(AssetsDeviceTransferDTO assetsDeviceTransferDTO);

	/**
	 * 批量更新对象 设备移交流程表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceTransferList(@Param("dtoList") List<AssetsDeviceTransferDTO> dtoList);

	/**
	 * 按主键删除 设备移交流程表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceTransferById(String id);

	/**
	 * 按主键批量删除 设备移交流程表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceTransferList(List<String> idList);
}
