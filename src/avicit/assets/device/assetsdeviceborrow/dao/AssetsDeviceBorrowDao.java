package avicit.assets.device.assetsdeviceborrow.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.assetsdeviceborrow.dto.AssetsDeviceBorrowDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-15 16:48
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsDeviceBorrowDao {

	/**
	* 分页查询  统管设备借用
	* @param assetsDeviceBorrowDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceBorrowDTO>
	*/
	public Page<AssetsDeviceBorrowDTO> searchAssetsDeviceBorrowByPage(
            @Param("bean") AssetsDeviceBorrowDTO assetsDeviceBorrowDTO, @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 统管设备借用
	* @param assetsDeviceBorrowDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsDeviceBorrowDTO>
	*/
	public Page<AssetsDeviceBorrowDTO> searchAssetsDeviceBorrowByPageOr(
            @Param("bean") AssetsDeviceBorrowDTO assetsDeviceBorrowDTO, @Param("pOrderBy") String orderBy);

	/**
	* 查询统管设备借用
	* @param assetsDeviceBorrowDTO 查询对象
	* @return List<AssetsDeviceBorrowDTO>
	*/
	public List<AssetsDeviceBorrowDTO> searchAssetsDeviceBorrow(AssetsDeviceBorrowDTO assetsDeviceBorrowDTO);

	/**
	 * 查询 统管设备借用
	 * @param id 主键id
	 * @return AssetsDeviceBorrowDTO
	 */
	public AssetsDeviceBorrowDTO findAssetsDeviceBorrowById(String id);

	/**
	* 新增统管设备借用
	* @param assetsDeviceBorrowDTO 保存对象
	* @return int
	*/
	public int insertAssetsDeviceBorrow(AssetsDeviceBorrowDTO assetsDeviceBorrowDTO);

	/**
	 * 批量新增 统管设备借用
	 * @param assetsDeviceBorrowDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsDeviceBorrowList(List<AssetsDeviceBorrowDTO> assetsDeviceBorrowDTOList);

	/**
	 * 更新部分对象 统管设备借用
	 * @param assetsDeviceBorrowDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceBorrowSensitive(AssetsDeviceBorrowDTO assetsDeviceBorrowDTO);

	/**
	 * 更新全部对象 统管设备借用
	 * @param assetsDeviceBorrowDTO 更新对象
	 * @return int
	 */
	public int updateAssetsDeviceBorrowAll(AssetsDeviceBorrowDTO assetsDeviceBorrowDTO);

	/**
	 * 批量更新对象 统管设备借用
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsDeviceBorrowList(@Param("dtoList") List<AssetsDeviceBorrowDTO> dtoList);

	/**
	 * 按主键删除 统管设备借用
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsDeviceBorrowById(String id);

	/**
	 * 按主键批量删除 统管设备借用
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsDeviceBorrowList(List<String> idList);
}
