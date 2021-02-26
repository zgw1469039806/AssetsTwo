package avicit.assets.lab.assetslaborder.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.lab.assetslaborder.dto.AssetsLabOrderDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 15:34
 * @类说明：请填写
 * @修改记录： 
 */
@MyBatisRepository
public interface AssetsLabOrderDao {

	/**
	* 分页查询  实验室预约流程
	* @param assetsLabOrderDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabOrderDTO>
	*/
	public Page<AssetsLabOrderDTO> searchAssetsLabOrderByPage(@Param("bean") AssetsLabOrderDTO assetsLabOrderDTO,
                                                              @Param("pOrderBy") String orderBy);

	/**
	* 按or条件的分页查询 实验室预约流程
	* @param assetsLabOrderDTO 查询对象
	* @param orderBy 排序条件
	* @return Page<AssetsLabOrderDTO>
	*/
	public Page<AssetsLabOrderDTO> searchAssetsLabOrderByPageOr(@Param("bean") AssetsLabOrderDTO assetsLabOrderDTO,
                                                                @Param("pOrderBy") String orderBy);

	/**
	* 查询实验室预约流程
	* @param assetsLabOrderDTO 查询对象
	* @return List<AssetsLabOrderDTO>
	*/
	public List<AssetsLabOrderDTO> searchAssetsLabOrder(AssetsLabOrderDTO assetsLabOrderDTO);

	/**
	 * 查询 实验室预约流程
	 * @param id 主键id
	 * @return AssetsLabOrderDTO
	 */
	public AssetsLabOrderDTO findAssetsLabOrderById(String id);

	/**
	* 新增实验室预约流程
	* @param assetsLabOrderDTO 保存对象
	* @return int
	*/
	public int insertAssetsLabOrder(AssetsLabOrderDTO assetsLabOrderDTO);

	/**
	 * 批量新增 实验室预约流程
	 * @param assetsLabOrderDTOList 保存对象集合
	 * @return int
	 */
	public int insertAssetsLabOrderList(List<AssetsLabOrderDTO> assetsLabOrderDTOList);

	/**
	 * 更新部分对象 实验室预约流程
	 * @param assetsLabOrderDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabOrderSensitive(AssetsLabOrderDTO assetsLabOrderDTO);

	/**
	 * 更新全部对象 实验室预约流程
	 * @param assetsLabOrderDTO 更新对象
	 * @return int
	 */
	public int updateAssetsLabOrderAll(AssetsLabOrderDTO assetsLabOrderDTO);

	/**
	 * 批量更新对象 实验室预约流程
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateAssetsLabOrderList(@Param("dtoList") List<AssetsLabOrderDTO> dtoList);

	/**
	 * 按主键删除 实验室预约流程
	 * @param id 主键id
	 * @return int
	 */
	public int deleteAssetsLabOrderById(String id);

	/**
	 * 按主键批量删除 实验室预约流程
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteAssetsLabOrderList(List<String> idList);
}
