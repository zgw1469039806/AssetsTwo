package avicit.assets.device.assetsdeviceunused.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceunused.dto.AssetsDeviceUnusedsubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-16 08:45
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceUnusedsubDao {

	/**
	 * 分页查询  设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceUnusedsubDTO>
	 */
	public Page<AssetsDeviceUnusedsubDTO> searchAssetsDeviceUnusedsubByPage(
            @Param("bean") AssetsDeviceUnusedsubDTO assetsDeviceUnusedsubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceUnusedsubDTO>
	 */
	public Page<AssetsDeviceUnusedsubDTO> searchAssetsDeviceUnusedsubByPageOr(
            @Param("bean") AssetsDeviceUnusedsubDTO assetsDeviceUnusedsubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备闲置流程子表 
	 * @param id 主键id
	 * @return AssetsDeviceUnusedsubDTO
	 */
	public AssetsDeviceUnusedsubDTO findAssetsDeviceUnusedsubById(String id);

	/**
	 * 查询 设备闲置流程子表
	 * @param pid 父id
	 * @return List<AssetsDeviceUnusedsubDTO>
	 */
	public List<AssetsDeviceUnusedsubDTO> findAssetsDeviceUnusedsubByPid(String pid);

	/**
	 * 新增设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceUnusedsub(AssetsDeviceUnusedsubDTO assetsDeviceUnusedsubDTO);

	/**
	 * 批量新增 设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceUnusedsubList(List<AssetsDeviceUnusedsubDTO> assetsDeviceUnusedsubDTOList);

	/**
	 * 更新部分对象 设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceUnusedsubSensitive(AssetsDeviceUnusedsubDTO assetsDeviceUnusedsubDTO);

	/**
	 * 更新全部对象 设备闲置流程子表
	 * @param assetsDeviceUnusedsubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceUnusedsubAll(AssetsDeviceUnusedsubDTO assetsDeviceUnusedsubDTO);

	/**
	 * 批量更新对象 设备闲置流程子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceUnusedsubList(@Param("dtoList") List<AssetsDeviceUnusedsubDTO> dtoList);

	/**
	 * 按主键删除 设备闲置流程子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceUnusedsubById(String id);

	/**
	 * 按主键批量删除 设备闲置流程子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceUnusedsubList(List<String> idList);
}
