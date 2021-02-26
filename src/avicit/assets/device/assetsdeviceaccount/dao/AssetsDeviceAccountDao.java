package avicit.assets.device.assetsdeviceaccount.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import org.apache.ibatis.annotations.Param;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 17:59
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceAccountDao {

	/**
	* 分页查询  ASSETS_DEVICE_ACCOUNT
	* @param assetsDeviceAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAccountDTO>
	*/
	public Page<AssetsDeviceAccountDTO> searchAssetsDeviceAccountByPage(
			@Param("bean") AssetsDeviceAccountDTO assetsDeviceAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 ASSETS_DEVICE_ACCOUNT
	* @param assetsDeviceAccountDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceAccountDTO>
	*/
	public Page<AssetsDeviceAccountDTO> searchAssetsDeviceAccountByPageOr(
			@Param("bean") AssetsDeviceAccountDTO assetsDeviceAccountDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询ASSETS_DEVICE_ACCOUNT
	* @param assetsDeviceAccountDTO 查询对象
	* @return List<AssetsDeviceAccountDTO>
	*/
	public List<AssetsDeviceAccountDTO> searchAssetsDeviceAccount(AssetsDeviceAccountDTO assetsDeviceAccountDTO);

	/**
	 * 查询 ASSETS_DEVICE_ACCOUNT
	 * @param id 主键id
	 * @return AssetsDeviceAccountDTO
	 */
	public AssetsDeviceAccountDTO findAssetsDeviceAccountById(String id);

	/**
	* 新增ASSETS_DEVICE_ACCOUNT
	* @param assetsDeviceAccountDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceAccount(AssetsDeviceAccountDTO assetsDeviceAccountDTO);

	/**
	 * 批量新增 ASSETS_DEVICE_ACCOUNT
	 * @param assetsDeviceAccountDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceAccountList(List<AssetsDeviceAccountDTO> assetsDeviceAccountDTOList);

	/**
	 * 更新部分对象 ASSETS_DEVICE_ACCOUNT
	 * @param assetsDeviceAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAccountSensitive(AssetsDeviceAccountDTO assetsDeviceAccountDTO);

	/**
	 * 为webservice调用修改设计的接口
	 * @param assetsDeviceAccountDTO
	 * @return
	 */
	int updateAssetsDeviceAccountSensitive4WS(AssetsDeviceAccountDTO assetsDeviceAccountDTO);

	/**
	 * 更新全部对象 ASSETS_DEVICE_ACCOUNT
	 * @param assetsDeviceAccountDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceAccountAll(AssetsDeviceAccountDTO assetsDeviceAccountDTO);

	/**
	 * 批量更新对象 ASSETS_DEVICE_ACCOUNT
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceAccountList(@Param("dtoList") List<AssetsDeviceAccountDTO> dtoList);

	/**
	 * 按主键删除 ASSETS_DEVICE_ACCOUNT
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceAccountById(String id);

	/**
	 * 按主键批量删除 ASSETS_DEVICE_ACCOUNT
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceAccountList(List<String> idList);

	/**
	 * 查询 ASSETS_DEVICE_ACCOUNT
	 * @param unifiedId 统一编号id
	 * @return AssetsDeviceAccountDTO
	 */
	public AssetsDeviceAccountDTO findAssetsDeviceAccountByUnifiedId(String unifiedId);

	/**
	 * 通过流水号查询台账记录
	 * @param serialNumber 流水号
	 * @return List<AssetsDeviceAccountDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAccountDTO> getAssetsDeviceAccountBySerialNumber(Long serialNumber);

	/**
	 * 获取当前台账的最大流水号
	 * @return Long
	 * @throws Exception
	 */
	public Long getMaxSerialNumber();
}
