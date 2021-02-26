package avicit.assets.device.assetsdevicereuse.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdevicereuse.dto.AssetsDeviceReusesubDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-16 09:10
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface AssetsDeviceReusesubDao {

	/**
	 * 分页查询  设备再用子表
	 * @param assetsDeviceReusesubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceReusesubDTO>
	 */
	public Page<AssetsDeviceReusesubDTO> searchAssetsDeviceReusesubByPage(
            @Param("bean") AssetsDeviceReusesubDTO assetsDeviceReusesubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 按or条件的分页查询 设备再用子表
	 * @param assetsDeviceReusesubDTO 查询对象
	 * @param orderBy 排序条件
	 * @return Page<AssetsDeviceReusesubDTO>
	 */
	public Page<AssetsDeviceReusesubDTO> searchAssetsDeviceReusesubByPageOr(
            @Param("bean") AssetsDeviceReusesubDTO assetsDeviceReusesubDTO, @Param("pOrderBy") String orderBy);

	/**
	 * 查询 设备再用子表 
	 * @param id 主键id
	 * @return AssetsDeviceReusesubDTO
	 */
	public AssetsDeviceReusesubDTO findAssetsDeviceReusesubById(String id);

	/**
	 * 查询 设备再用子表
	 * @param pid 父id
	 * @return List<AssetsDeviceReusesubDTO>
	 */
	public List<AssetsDeviceReusesubDTO> findAssetsDeviceReusesubByPid(String pid);

	/**
	 * 新增设备再用子表
	 * @param assetsDeviceReusesubDTO 保存对象
	 * @return int
	 */
	public int insertAssetsDeviceReusesub(AssetsDeviceReusesubDTO assetsDeviceReusesubDTO);

	/**
	 * 批量新增 设备再用子表
	 * @param assetsDeviceReusesubDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceReusesubList(List<AssetsDeviceReusesubDTO> assetsDeviceReusesubDTOList);

	/**
	 * 更新部分对象 设备再用子表
	 * @param assetsDeviceReusesubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceReusesubSensitive(AssetsDeviceReusesubDTO assetsDeviceReusesubDTO);

	/**
	 * 更新全部对象 设备再用子表
	 * @param assetsDeviceReusesubDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceReusesubAll(AssetsDeviceReusesubDTO assetsDeviceReusesubDTO);

	/**
	 * 批量更新对象 设备再用子表
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceReusesubList(@Param("dtoList") List<AssetsDeviceReusesubDTO> dtoList);

	/**
	 * 按主键删除 设备再用子表
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceReusesubById(String id);

	/**
	 * 按主键批量删除 设备再用子表
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceReusesubList(List<String> idList);
}
