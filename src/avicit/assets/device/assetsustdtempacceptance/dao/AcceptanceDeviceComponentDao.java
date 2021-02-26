package avicit.assets.device.assetsustdtempacceptance.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsustdtempacceptance.dto.AcceptanceDeviceComponentDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 11:13
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AcceptanceDeviceComponentDao {
	/**
	 * 分页查询  ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AcceptanceDeviceComponentDTO>
	 */
	public Page<AcceptanceDeviceComponentDTO> searchAcceptanceDeviceComponentByPage(@Param("bean") AcceptanceDeviceComponentDTO acceptanceDeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AcceptanceDeviceComponentDTO>
	 */
	public Page<AcceptanceDeviceComponentDTO> searchAcceptanceDeviceComponentByPageOr(@Param("bean") AcceptanceDeviceComponentDTO acceptanceDeviceComponentDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 ACCEPTANCE_DEVICE_COMPONENT 
	 * @param id 主键id
	 * @return AcceptanceDeviceComponentDTO
	 */
	public AcceptanceDeviceComponentDTO findAcceptanceDeviceComponentById(String id);

	/**
	 * 查询 ACCEPTANCE_DEVICE_COMPONENT
	 * @param pid 父id
	 * @return List<AcceptanceDeviceComponentDTO>
	 */
	public List<AcceptanceDeviceComponentDTO> findAcceptanceDeviceComponentByPid(String pid);

	/**
	 * 新增ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTO 保存对象
	 * @return int
	 */
	public int insertAcceptanceDeviceComponent(AcceptanceDeviceComponentDTO acceptanceDeviceComponentDTO);

	/**
	 * 批量新增 ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTOList 保存对象集合
	 * @return int
	 */
	public int insertAcceptanceDeviceComponentList(List<AcceptanceDeviceComponentDTO> acceptanceDeviceComponentDTOList);

	/**
	 * 更新部分对象 ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAcceptanceDeviceComponentSensitive(AcceptanceDeviceComponentDTO acceptanceDeviceComponentDTO);

	/**
	 * 更新全部对象 ACCEPTANCE_DEVICE_COMPONENT
	 * @param acceptanceDeviceComponentDTO 更新对象
	 * @return int
	 */
	public int updateAcceptanceDeviceComponentAll(AcceptanceDeviceComponentDTO acceptanceDeviceComponentDTO);

	/**
	 * 批量更新对象 ACCEPTANCE_DEVICE_COMPONENT
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAcceptanceDeviceComponentList(@Param("dtoList") List<AcceptanceDeviceComponentDTO> dtoList);

	/**
	 * 按主键删除 ACCEPTANCE_DEVICE_COMPONENT
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAcceptanceDeviceComponentById(String id);

	/**
	 * 按主键批量删除 ACCEPTANCE_DEVICE_COMPONENT
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAcceptanceDeviceComponentList(List<String> idList);
}
