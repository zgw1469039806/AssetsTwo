package avicit.assets.device.assetsdeviceachecktemporary.service;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceacccheck.dao.AssetsDeviceAccCheckDao;
import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsdeviceachecktemporary.dao.AssetsDeviceAcheckTemporaryDao;
import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 08:40
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceAcheckTemporaryService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceAcheckTemporaryService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceAcheckTemporaryDao assetsDeviceAcheckTemporaryDao;
	@Autowired
	private AssetsDeviceAccCheckDao assetsDeviceAccCheckDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporaryByPage(
			QueryReqBean<AssetsDeviceAcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckTemporaryDTO> dataList = assetsDeviceAcheckTemporaryDao
					.searchAssetsDeviceAcheckTemporaryByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckTemporaryDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporaryByPageOr(
			QueryReqBean<AssetsDeviceAcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckTemporaryDTO> dataList = assetsDeviceAcheckTemporaryDao
					.searchAssetsDeviceAcheckTemporaryByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckTemporaryDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceAcheckTemporary(List<AssetsDeviceAcheckTemporaryDTO> dtos) throws Exception {
		for (AssetsDeviceAcheckTemporaryDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceAcheckTemporary(dto);
			} else {
				this.updateAssetsDeviceAcheckTemporary(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceAcheckTemporary(AssetsDeviceAcheckTemporaryDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceAcheckTemporaryDao.insertAssetsDeviceAcheckTemporary(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceAcheckTemporaryList(List<AssetsDeviceAcheckTemporaryDTO> dtoList) throws Exception {
		List<AssetsDeviceAcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceAcheckTemporaryDTO>();
		for (AssetsDeviceAcheckTemporaryDTO dto : dtoList) {
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
			return assetsDeviceAcheckTemporaryDao.insertAssetsDeviceAcheckTemporaryList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckTemporary(AssetsDeviceAcheckTemporaryDTO dto) throws Exception {
		//记录日志
		AssetsDeviceAcheckTemporaryDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceAcheckTemporaryDao.updateAssetsDeviceAcheckTemporarySensitive(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckTemporaryList(List<AssetsDeviceAcheckTemporaryDTO> dtoList) throws Exception {
		try {
			return assetsDeviceAcheckTemporaryDao.updateAssetsDeviceAcheckTemporaryList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckTemporaryById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceAcheckTemporaryDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceAcheckTemporaryDao.deleteAssetsDeviceAcheckTemporaryById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAcheckTemporaryById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckTemporaryByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceAcheckTemporaryById(id);
			result++;
		}
		return result;
	}

	/**
	 * 批量删除数据2
	 * @param idList 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckTemporaryList(List<String> idList) throws Exception {
		try {
			return assetsDeviceAcheckTemporaryDao.deleteAssetsDeviceAcheckTemporaryList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAcheckTemporaryList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceAcheckTemporaryDTO
	 * @throws Exception
	 */
	public AssetsDeviceAcheckTemporaryDTO findById(String id) throws Exception {
		try {
			AssetsDeviceAcheckTemporaryDTO dto = assetsDeviceAcheckTemporaryDao.findAssetsDeviceAcheckTemporaryById(id);
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
	 * 清空数据表
	 *
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckTemporaryAll() throws Exception {
		try {
			return assetsDeviceAcheckTemporaryDao.deleteAssetsDeviceAcheckTemporaryAll();
		}catch (Exception e) {
			logger.error("deleteAssetsDeviceAcheckTemporaryById出错：", e);
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
	public int saveAssetsDeviceAcheckTemporary(String[] ids, Date endDate) throws Exception {
		Calendar cal = Calendar.getInstance();
		Date town= null;
		List<AssetsDeviceAcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceAcheckTemporaryDTO>();
		for (String item :ids){
			AssetsDeviceAccCheckDTO regularCheck =	assetsDeviceAccCheckDao.findAssetsDeviceAccCheckById(item);//根据ID查询台账定检信息
			cal.setTime(endDate);
			long endTime = cal.getTimeInMillis();
			cal.setTime(regularCheck.getNextAccCheckDate());
			long NextRegularCheckDate = cal.getTimeInMillis();
			int returnInt= (int) ((endTime-NextRegularCheckDate)/(1000*3600*24)/regularCheck.getAccCheckCycle());//获取时间范围内需要的定检次数
			for(int i = 0 ;i<=returnInt;i++){
				AssetsDeviceAcheckTemporaryDTO dto=new AssetsDeviceAcheckTemporaryDTO();//创建临时表
				dto.setId(ComUtil.getId());
				dto.setUnifiedId(regularCheck.getUnifiedId());
				dto.setDeviceName(regularCheck.getDeviceName());
				dto.setDeviceCategory(regularCheck.getDeviceCategory());
				dto.setDeviceModel(regularCheck.getDeviceModel());
				dto.setProductArea(regularCheck.getProductArea());
				dto.setPositionId(regularCheck.getPositionId());
				dto.setProductDate(regularCheck.getProductDate());
				dto.setUserId(regularCheck.getUserId());
				dto.setUserDept(regularCheck.getUserDept());
				dto.setLastAccCheckDate(regularCheck.getLastAccCheckDate());
				dto.setAccCheckCycle(regularCheck.getAccCheckCycle());
				dto.setNextAccCheckDate(regularCheck.getNextAccCheckDate());

				dto.setAttachment(regularCheck.getAttachment());
				dto.setCheckId(regularCheck.getId());
				if(i==0)
					cal.add(Calendar.DAY_OF_MONTH,0);
				else
					cal.add(Calendar.DAY_OF_MONTH,regularCheck.getAccCheckCycle().intValue());
				town=cal.getTime();
				dto.setAccCheckDate(town);//精度检查时间赋值
				PojoUtil.setSysProperties(dto, OpType.insert);

				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
		}
		try {
			return assetsDeviceAcheckTemporaryDao.insertAssetsDeviceAcheckTemporaryList(beanList);//插入临时表数据
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 按条件查询

	 * @return List<AssetsDeviceRcheckTemporaryDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporary(
	) throws Exception {
		try {
			List<AssetsDeviceAcheckTemporaryDTO> dataList = assetsDeviceAcheckTemporaryDao
					.searchAssetsDeviceAcheckTemporary();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 按条件查询

	 * @return List<AssetsDeviceRcheckTemporaryDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAcheckTemporaryDTO> searchAssetsDeviceAcheckTemporaryMax(
	) throws Exception {
		try {
			List<AssetsDeviceAcheckTemporaryDTO> dataList = assetsDeviceAcheckTemporaryDao
					.searchAssetsDeviceAcheckTemporaryMax();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
