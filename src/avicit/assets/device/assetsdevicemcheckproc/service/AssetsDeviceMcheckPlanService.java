package avicit.assets.device.assetsdevicemcheckproc.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;
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
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;
import avicit.assets.device.assetsdevicemcheckproc.dao.AssetsDeviceMcheckPlanDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceMcheckPlanService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceMcheckPlanService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceMcheckPlanDao assetsDeviceMcheckPlanDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceMcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanByPage(
			QueryReqBean<AssetsDeviceMcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckPlanDTO> dataList = assetsDeviceMcheckPlanDao
					.searchAssetsDeviceMcheckPlanByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceMcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceMcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanByPageOr(
			QueryReqBean<AssetsDeviceMcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckPlanDTO> dataList = assetsDeviceMcheckPlanDao
					.searchAssetsDeviceMcheckPlanByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceMcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceMcheckPlanDTO
	 * @throws Exception
	 */
	public AssetsDeviceMcheckPlanDTO queryAssetsDeviceMcheckPlanByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceMcheckPlanDTO dto = assetsDeviceMcheckPlanDao.findAssetsDeviceMcheckPlanById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceMcheckPlanByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceMcheckPlanDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceMcheckPlanDTO> queryAssetsDeviceMcheckPlanByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceMcheckPlanDTO> dto = assetsDeviceMcheckPlanDao.findAssetsDeviceMcheckPlanByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceMcheckPlanByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceMcheckPlan(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceMcheckPlanDao.insertAssetsDeviceMcheckPlan(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceMcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceMcheckPlanList(List<AssetsDeviceMcheckPlanDTO> dtoList, String pid) throws Exception {
		List<AssetsDeviceMcheckPlanDTO> beanList = new ArrayList<AssetsDeviceMcheckPlanDTO>();
		for (AssetsDeviceMcheckPlanDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setProcId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsDeviceMcheckPlanDao.insertAssetsDeviceMcheckPlanList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceMcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceMcheckPlan(List<AssetsDeviceMcheckPlanDTO> dtos, String pid)
			throws Exception {
		for (AssetsDeviceMcheckPlanDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setProcId(pid);
				this.insertAssetsDeviceMcheckPlan(dto);
			} else {
				this.updateAssetsDeviceMcheckPlan(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckPlan(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceMcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceMcheckPlanDao.updateAssetsDeviceMcheckPlanAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceMcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckPlanSensitive(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceMcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceMcheckPlanDao.updateAssetsDeviceMcheckPlanSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceMcheckPlanSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckPlanList(List<AssetsDeviceMcheckPlanDTO> dtoList) throws Exception {
		try {
			return assetsDeviceMcheckPlanDao.updateAssetsDeviceMcheckPlanList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceMcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckPlanById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceMcheckPlanDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceMcheckPlanDao.deleteAssetsDeviceMcheckPlanById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceMcheckPlanById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckPlan(AssetsDeviceMcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceMcheckPlanDao.deleteAssetsDeviceMcheckPlanById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceMcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckPlanByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceMcheckPlanById(id);
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
	public int deleteAssetsDeviceMcheckPlanList(List<String> idList) throws Exception {
		try {
			return assetsDeviceMcheckPlanDao.deleteAssetsDeviceMcheckPlanList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceMcheckPlanList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceMcheckPlanDTO
	 * @throws Exception
	 */
	private AssetsDeviceMcheckPlanDTO findById(String id) throws Exception {
		try {
			AssetsDeviceMcheckPlanDTO dto = assetsDeviceMcheckPlanDao.findAssetsDeviceMcheckPlanById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 按计划ID查询ASSETS_DEVICE_MCHECK_PLAN根据台账记录ID和定检时间分组的日期最大的数据列表
	 * @return List<AssetsDeviceMcheckPlanDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceMcheckPlanDTO> searchAssetsDeviceMcheckPlanMax(String procId) throws Exception {
		try {
			List<AssetsDeviceMcheckPlanDTO> dataList = assetsDeviceMcheckPlanDao
					.searchAssetsDeviceMcheckPlanMax(procId);
			return dataList;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceMcheckPlanMax出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
