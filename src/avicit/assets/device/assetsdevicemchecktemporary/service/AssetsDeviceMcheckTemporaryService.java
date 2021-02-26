package avicit.assets.device.assetsdevicemchecktemporary.service;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.assets.device.assetsdeviceachecktemporary.dto.AssetsDeviceAcheckTemporaryDTO;
import avicit.assets.device.assetsdevicemaintain.dao.AssetsDeviceMaintainDao;
import avicit.assets.device.assetsdevicemaintain.dto.AssetsDeviceMaintainDTO;
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
import avicit.assets.device.assetsdevicemchecktemporary.dao.AssetsDeviceMcheckTemporaryDao;
import avicit.assets.device.assetsdevicemchecktemporary.dto.AssetsDeviceMcheckTemporaryDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 16:09
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceMcheckTemporaryService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMcheckTemporaryService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceMcheckTemporaryDao assetsDeviceMcheckTemporaryDao;

	@Autowired
	private AssetsDeviceMaintainDao assetsDeviceMaintainDao;
	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporaryByPage(
			QueryReqBean<AssetsDeviceMcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckTemporaryDTO> dataList = assetsDeviceMcheckTemporaryDao
					.searchAssetsDeviceMcheckTemporaryByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckTemporaryDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMcheckTemporaryDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporaryByPageOr(
			QueryReqBean<AssetsDeviceMcheckTemporaryDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckTemporaryDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckTemporaryDTO> dataList = assetsDeviceMcheckTemporaryDao
					.searchAssetsDeviceMcheckTemporaryByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckTemporaryDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckTemporaryDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMcheckTemporaryByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceMcheckTemporary(List<AssetsDeviceMcheckTemporaryDTO> dtos) throws Exception {
		for (AssetsDeviceMcheckTemporaryDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceMcheckTemporary(dto);
			} else {
				this.updateAssetsDeviceMcheckTemporary(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceMcheckTemporary(AssetsDeviceMcheckTemporaryDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceMcheckTemporaryDao.insertAssetsDeviceMcheckTemporary(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMcheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceMcheckTemporaryList(List<AssetsDeviceMcheckTemporaryDTO> dtoList) throws Exception {
		List<AssetsDeviceMcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceMcheckTemporaryDTO>();
		for (AssetsDeviceMcheckTemporaryDTO dto : dtoList) {
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
			return assetsDeviceMcheckTemporaryDao.insertAssetsDeviceMcheckTemporaryList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckTemporary(AssetsDeviceMcheckTemporaryDTO dto) throws Exception {
		//记录日志
		AssetsDeviceMcheckTemporaryDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceMcheckTemporaryDao.updateAssetsDeviceMcheckTemporarySensitive(old);
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
	public int updateAssetsDeviceMcheckTemporaryList(List<AssetsDeviceMcheckTemporaryDTO> dtoList) throws Exception {
		try {
			return assetsDeviceMcheckTemporaryDao.updateAssetsDeviceMcheckTemporaryList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceMcheckTemporaryList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckTemporaryById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceMcheckTemporaryDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceMcheckTemporaryDao.deleteAssetsDeviceMcheckTemporaryById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMcheckTemporaryById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckTemporaryByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceMcheckTemporaryById(id);
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
	public int deleteAssetsDeviceMcheckTemporaryList(List<String> idList) throws Exception {
		try {
			return assetsDeviceMcheckTemporaryDao.deleteAssetsDeviceMcheckTemporaryList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMcheckTemporaryList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceMcheckTemporaryDTO
	 * @throws Exception
	 */
	private AssetsDeviceMcheckTemporaryDTO findById(String id) throws Exception {
		try {
			AssetsDeviceMcheckTemporaryDTO dto = assetsDeviceMcheckTemporaryDao.findAssetsDeviceMcheckTemporaryById(id);
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
	public int deleteAssetsDeviceMcheckTemporaryAll() throws Exception {
		try {
			return assetsDeviceMcheckTemporaryDao.deleteAssetsDeviceMcheckTemporaryAll();
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
	public int saveAssetsDeviceMcheckTemporary(String[] ids, Date endDate) throws Exception {
		Calendar cal = Calendar.getInstance();
		Date town= null;
		List<AssetsDeviceMcheckTemporaryDTO> beanList = new ArrayList<AssetsDeviceMcheckTemporaryDTO>();
		for (String item :ids){
			AssetsDeviceMaintainDTO regularCheck =	assetsDeviceMaintainDao.findAssetsDeviceMaintainById(item);//根据ID查询台账定检信息
			cal.setTime(endDate);
			long endTime = cal.getTimeInMillis();
			cal.setTime(regularCheck.getNextMaintainDate());
			long NextRegularCheckDate = cal.getTimeInMillis();
			int returnInt= (int) ((endTime-NextRegularCheckDate)/(1000*3600*24)/regularCheck.getMaintainCycle());//获取时间范围内需要的定检次数
			for(int i = 0 ;i<=returnInt;i++){
				AssetsDeviceMcheckTemporaryDTO dto=new AssetsDeviceMcheckTemporaryDTO();//创建临时表
				dto.setId(ComUtil.getId());
				dto.setUnifiedId(regularCheck.getUnifiedId());
				dto.setDeviceName(regularCheck.getDeviceName());
				dto.setDeviceCategory(regularCheck.getDeviceCategory());
				dto.setOwnerId(regularCheck.getOwnerId());
				dto.setOwnerDept(regularCheck.getOwnerDept());
				dto.setPositionId(regularCheck.getPositionId());
				dto.setMaintainPosition(regularCheck.getMaintainPosition());
				dto.setMaintainContent(regularCheck.getMaintainContent());
				dto.setMaintainItem(regularCheck.getMaintainItem());
				dto.setMaintainMode(regularCheck.getMaintainMode());
				dto.setMaintainCycle(regularCheck.getMaintainCycle().toString());
				dto.setLastMaintainDate(regularCheck.getLastMaintainDate());
				dto.setNextMaintainDate(regularCheck.getNextMaintainDate());

				dto.setMaintainId(regularCheck.getId());
				if(i==0)
					cal.add(Calendar.DAY_OF_MONTH,0);
				else
					cal.add(Calendar.DAY_OF_MONTH,regularCheck.getMaintainCycle().intValue());
				town=cal.getTime();
				dto.setMaintainDate(town);//精度检查时间赋值
				PojoUtil.setSysProperties(dto, OpType.insert);

				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
		}
		try {
			return assetsDeviceMcheckTemporaryDao.insertAssetsDeviceMcheckTemporaryList(beanList);//插入临时表数据
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 按条件查询

	 * @return List<AssetsDeviceMcheckTemporaryDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporary(
	) throws Exception {
		try {
			List<AssetsDeviceMcheckTemporaryDTO> dataList = assetsDeviceMcheckTemporaryDao
					.searchAssetsDeviceMcheckTemporary();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 按条件查询

	 * @return List<AssetsDeviceMcheckTemporaryDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceMcheckTemporaryDTO> searchAssetsDeviceMcheckTemporaryMax(
	) throws Exception {
		try {
			List<AssetsDeviceMcheckTemporaryDTO> dataList = assetsDeviceMcheckTemporaryDao
					.searchAssetsDeviceMcheckTemporaryMax();
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMheckTemporary出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

}
