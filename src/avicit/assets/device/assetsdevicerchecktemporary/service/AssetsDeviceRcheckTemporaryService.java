package avicit.assets.device.assetsdevicerchecktemporary.service;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceregularcheck.dao.AssetsDeviceRegularCheckDao;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsdevicerchecktemporary.dao.AssetsDeviceRcheckTemporaryDao;
import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-01 19:37
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceRcheckTemporaryService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceRcheckTemporaryService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceRcheckTemporaryDao assetsDeviceRcheckTemporaryDao;
	@Autowired
	private AssetsDeviceRegularCheckDao assetsDeviceRegularCheckDao;
	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceRcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryByPage(
			QueryReqBean<AssetsDeviceRcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceRcheckTemporaryDTO> dataList = assetsDeviceRcheckTemporaryDao
					.searchAssetsDeviceRcheckTemporaryByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceRcheckTemporaryDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceRcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryByPageOr(
			QueryReqBean<AssetsDeviceRcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceRcheckTemporaryDTO> dataList = assetsDeviceRcheckTemporaryDao
					.searchAssetsDeviceRcheckTemporaryByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceRcheckTemporaryDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件查询

	* @return List<AssetsDeviceRcheckTemporaryDTO>
	* @throws Exception
	*/
	public List<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporary(
			) throws Exception {
		try {
			List<AssetsDeviceRcheckTemporaryDTO> dataList = assetsDeviceRcheckTemporaryDao
					.searchAssetsDeviceRcheckTemporary();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceRcheckTemporaryDTO
	 * @throws Exception
	 */
	public AssetsDeviceRcheckTemporaryDTO queryAssetsDeviceRcheckTemporaryByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceRcheckTemporaryDTO dto = assetsDeviceRcheckTemporaryDao.findAssetsDeviceRcheckTemporaryById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceRcheckTemporaryByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertAssetsDeviceRcheckTemporary(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceRcheckTemporaryDao.insertAssetsDeviceRcheckTemporary(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceRcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceRcheckTemporaryList(List<AssetsDeviceRcheckTemporaryDTO> dtoList) throws Exception {
		List<AssetsDeviceRcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceRcheckTemporaryDTO>();
		for (AssetsDeviceRcheckTemporaryDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsDeviceRcheckTemporaryDao.insertAssetsDeviceRcheckTemporaryList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceRcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckTemporary(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		//记录日志
		AssetsDeviceRcheckTemporaryDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceRcheckTemporaryDao.updateAssetsDeviceRcheckTemporaryAll(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckTemporarySensitive(AssetsDeviceRcheckTemporaryDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceRcheckTemporaryDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceRcheckTemporaryDao.updateAssetsDeviceRcheckTemporarySensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsDeviceRcheckTemporarySensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckTemporaryList(List<AssetsDeviceRcheckTemporaryDTO> dtoList) throws Exception {
		try {
			return assetsDeviceRcheckTemporaryDao.updateAssetsDeviceRcheckTemporaryList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceRcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckTemporaryById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceRcheckTemporaryDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceRcheckTemporaryDao.deleteAssetsDeviceRcheckTemporaryById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceRcheckTemporaryById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckTemporaryByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceRcheckTemporaryById(id);
			result++;
		}
		return result;
	}
	/**
	 * 清空数据表
	 *
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckTemporaryAll() throws Exception {
		try {
			return assetsDeviceRcheckTemporaryDao.deleteAssetsDeviceRcheckTemporaryAll();
		}catch (Exception e) {
			logger.error("deleteAssetsDeviceRcheckTemporaryById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据2
	 * @param idList 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckTemporaryList(List<String> idList) throws Exception {
		try {
			return assetsDeviceRcheckTemporaryDao.deleteAssetsDeviceRcheckTemporaryList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceRcheckTemporaryList出错：", e);
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsDeviceRcheckTemporaryDTO
	* @throws Exception
	*/
	private AssetsDeviceRcheckTemporaryDTO findById(String id) throws Exception {
		try {
			AssetsDeviceRcheckTemporaryDTO dto = assetsDeviceRcheckTemporaryDao.findAssetsDeviceRcheckTemporaryById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 *生成定检计划临时表数据
	 * @param ids 选中数据台账定检信息表的ID列表
	 * @param endDate 定检范围的结束时间
	 * @return int
	 * @throws Exception
	 */
	public int saveAssetsDeviceRcheckTemporary(String[] ids, Date endDate) throws Exception {
		Calendar cal = Calendar.getInstance();
		Date town;
		List<AssetsDeviceRcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceRcheckTemporaryDTO>();
		for (String item :ids){
			AssetsDeviceRegularCheckDTO regularCheck =	assetsDeviceRegularCheckDao.findAssetsDeviceRegularCheckById(item);//根据ID查询台账定检信息
			cal.setTime(endDate);
			long endTime = cal.getTimeInMillis();
			cal.setTime(regularCheck.getNextRegularCheckDate());
			long NextRegularCheckDate = cal.getTimeInMillis();
			int returnInt= (int) ((endTime-NextRegularCheckDate)/(1000*3600*24)/regularCheck.getRegularCheckCycle());//获取时间范围内需要的定检次数
			for(int i = 0 ;i<=returnInt;i++){
				AssetsDeviceRcheckTemporaryDTO dto=new AssetsDeviceRcheckTemporaryDTO();//创建临时表
				dto.setId(ComUtil.getId());
				dto.setUnifiedId(regularCheck.getUnifiedId());
				dto.setDeviceName(regularCheck.getDeviceName());
				dto.setDeviceCategory(regularCheck.getDeviceCategory());
				dto.setDeviceModel(regularCheck.getDeviceModel());
				dto.setManufacturerId(regularCheck.getManufacturerId());
				dto.setOwnerId(regularCheck.getOwnerId());
				dto.setOwnerDept(regularCheck.getOwnerDept());
				dto.setPositionId(regularCheck.getPositionId());
				dto.setRegularCheckMode(regularCheck.getRegularCheckMode());
				dto.setRegularCheckCycle(regularCheck.getRegularCheckCycle());
				dto.setRegisterId(regularCheck.getRegisterId());
				dto.setAttachment(regularCheck.getAttachment());
				dto.setCheckId(regularCheck.getId());
				if(i==0)
					cal.add(Calendar.DAY_OF_MONTH,0);
				else
				cal.add(Calendar.DAY_OF_MONTH,regularCheck.getRegularCheckCycle().intValue());
				town=cal.getTime();
				dto.setRegularCheckDate(town);//定检时间赋值
				PojoUtil.setSysProperties(dto, OpType.insert);
//				if(i==returnInt){
//					try {
//						regularCheck.setLastRegularCheckDate(town);
//						cal.add(Calendar.DAY_OF_MONTH, regularCheck.getRegularCheckCycle().intValue() );
//						town = cal.getTime();
//						regularCheck.setNextRegularCheckDate(town);
//						int num = assetsDeviceRegularCheckDao.updateAssetsDeviceRegularCheckAll(regularCheck);//修改台账信息
//					}catch (Exception e){
//						logger.error("insertAssetsDeviceRcheckTemporaryList出错：", e);
//						throw new DaoException(e.getMessage(), e);
//
//					}
//				}
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
		}
		try {
			return assetsDeviceRcheckTemporaryDao.insertAssetsDeviceRcheckTemporaryList(beanList);//插入临时表数据
		} catch (Exception e) {
			logger.error("insertAssetsDeviceRcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}


	/**
	 * 按条件查询

	 * @return List<AssetsDeviceRcheckTemporaryDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceRcheckTemporaryDTO> searchAssetsDeviceRcheckTemporaryMax(
	) throws Exception {
		try {
			List<AssetsDeviceRcheckTemporaryDTO> dataList = assetsDeviceRcheckTemporaryDao
					.searchAssetsDeviceRcheckTemporaryMax();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
