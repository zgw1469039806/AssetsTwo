package avicit.assets.device.assetsdevicetransfer.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsTransferprocDeviceDao {

	/**
	 * 分页查询  移交流程设备子表
	 * @param assetsTransferprocDeviceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsTransferprocDeviceDTO>
	 */
	public Page<AssetsTransferprocDeviceDTO> searchAssetsTransferprocDeviceByPage(
            @Param("bean") AssetsTransferprocDeviceDTO assetsTransferprocDeviceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 移交流程设备子表
	 * @param assetsTransferprocDeviceDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsTransferprocDeviceDTO>
	 */
	public Page<AssetsTransferprocDeviceDTO> searchAssetsTransferprocDeviceByPageOr(
            @Param("bean") AssetsTransferprocDeviceDTO assetsTransferprocDeviceDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 移交流程设备子表 
	 * @param id 主键id
	 * @return AssetsTransferprocDeviceDTO
	 */
	public AssetsTransferprocDeviceDTO findAssetsTransferprocDeviceById(String id);

	/**
	 * 查询 移交流程设备子表
	 * @param pid 父id
	 * @return List<AssetsTransferprocDeviceDTO>
	 */
	public List<AssetsTransferprocDeviceDTO> findAssetsTransferprocDeviceByPid(String pid);

	/**
	 * 新增移交流程设备子表
	 * @param assetsTransferprocDeviceDTO 保存对象
	 * @return int
	 */
	public int insertAssetsTransferprocDevice(AssetsTransferprocDeviceDTO assetsTransferprocDeviceDTO);

	/**
	 * 批量新增 移交流程设备子表
	 * @param assetsTransferprocDeviceDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsTransferprocDeviceList(List<AssetsTransferprocDeviceDTO> assetsTransferprocDeviceDTOList);

	/**
	 * 更新部分对象 移交流程设备子表
	 * @param assetsTransferprocDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTransferprocDeviceSensitive(AssetsTransferprocDeviceDTO assetsTransferprocDeviceDTO);

	/**
	 * 更新全部对象 移交流程设备子表
	 * @param assetsTransferprocDeviceDTO 更新对象
	 * @return int
	 */
	public int updateAssetsTransferprocDeviceAll(AssetsTransferprocDeviceDTO assetsTransferprocDeviceDTO);

	/**
	 * 批量更新对象 移交流程设备子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsTransferprocDeviceList(@Param("dtoList") List<AssetsTransferprocDeviceDTO> dtoList);

	/**
	 * 按主键删除 移交流程设备子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsTransferprocDeviceById(String id);

	/**
	 * 按主键批量删除 移交流程设备子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsTransferprocDeviceList(List<String> idList);
}
