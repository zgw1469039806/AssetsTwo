package avicit.assets.device.dynreconmsg.dao;

import java.util.List;
import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import org.apache.ibatis.annotations.Param;
import avicit.assets.device.dynreconmsg.dto.DynReconMsgDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 19:14
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface DynReconMsgDao {

	/**
	* 分页查询  DYN_RECON_MSG
	* @param dynReconMsgDTO 查询对象
	* @param orgIdentity 组织id
	* @param orderBy 排序条件
	* @return Page<DynReconMsgDTO>
	*/
	public Page<DynReconMsgDTO> searchDynReconMsgByPage(@Param("bean") DynReconMsgDTO dynReconMsgDTO,
                                                        @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy);
	public Page<DynReconMsgDTO> findDynReconMsg();

	/**
	* 按or条件的分页查询 DYN_RECON_MSG
	* @param dynReconMsgDTO 查询对象
	* @param orgIdentity 组织id
	* @param orderBy 排序条件
	* @return Page<DynReconMsgDTO>
	*/
	public Page<DynReconMsgDTO> searchDynReconMsgByPageOr(@Param("bean") DynReconMsgDTO dynReconMsgDTO,
                                                          @Param("org") String orgIdentity, @Param("pOrderBy") String orderBy);

	/**
	* 查询 DYN_RECON_MSG
	* @param dynReconMsgDTO 查询对象
	* @return List<DynReconMsgDTO>
	*/
	public List<DynReconMsgDTO> searchDynReconMsg(DynReconMsgDTO dynReconMsgDTO);

	/**
	 * 查询 DYN_RECON_MSG
	 * @param id 主键id
	 * @return DynReconMsgDTO
	 */
	public DynReconMsgDTO findDynReconMsgById(String id);

	/**
	 * 新增DYN_RECON_MSG
	 * @param dynReconMsgDTO 保存对象
	 * @return int
	 */
	public int insertDynReconMsg(DynReconMsgDTO dynReconMsgDTO);

	/**
	 * 批量新增 DYN_RECON_MSG
	 * @param dynReconMsgDTOList 保存对象集合
	 * @return int
	 */
	public int insertDynReconMsgList(List<DynReconMsgDTO> dynReconMsgDTOList);

	/**
	* 更新部分对象 DYN_RECON_MSG
	* @param dynReconMsgDTO 更新对象
	* @return int
	*/
	public int updateDynReconMsgSensitive(DynReconMsgDTO dynReconMsgDTO);

	/**
	 * 更新全部对象 DYN_RECON_MSG
	 * @param dynReconMsgDTO 更新对象
	 * @return int
	 */
	public int updateDynReconMsgAll(DynReconMsgDTO dynReconMsgDTO);

	/**
	 * 批量更新对象 DYN_RECON_MSG
	 * @param dtoList 批量更新对象集合
	 * @return int
	 */
	public int updateDynReconMsgList(@Param("dtoList") List<DynReconMsgDTO> dtoList);

	/**
	 * 按主键删除 DYN_RECON_MSG
	 * @param id 主键id
	 * @return int
	 */
	public int deleteDynReconMsgById(String id);

	/**
	 * 按主键批量删除 DYN_RECON_MSG
	 * @param idList 主键集合
	 * @return int
	 */
	public int deleteDynReconMsgList(List<String> idList);
}
