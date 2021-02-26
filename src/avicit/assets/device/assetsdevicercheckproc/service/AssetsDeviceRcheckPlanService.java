package avicit.assets.device.assetsdevicercheckproc.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdevicerchecktemporary.dto.AssetsDeviceRcheckTemporaryDTO;
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
import avicit.assets.device.assetsdevicercheckproc.dto.AssetsDeviceRcheckPlanDTO;
import avicit.assets.device.assetsdevicercheckproc.dao.AssetsDeviceRcheckPlanDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 10:33
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceRcheckPlanService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceRcheckPlanService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceRcheckPlanDao assetsDeviceRcheckPlanDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceRcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanByPage(
			QueryReqBean<AssetsDeviceRcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceRcheckPlanDTO> dataList = assetsDeviceRcheckPlanDao
					.searchAssetsDeviceRcheckPlanByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceRcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceRcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceRcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanByPageOr(
			QueryReqBean<AssetsDeviceRcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceRcheckPlanDTO> dataList = assetsDeviceRcheckPlanDao
					.searchAssetsDeviceRcheckPlanByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceRcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceRcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceRcheckPlanDTO
	 * @throws Exception
	 */
	public AssetsDeviceRcheckPlanDTO queryAssetsDeviceRcheckPlanByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceRcheckPlanDTO dto = assetsDeviceRcheckPlanDao.findAssetsDeviceRcheckPlanById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceRcheckPlanByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceRcheckPlanDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceRcheckPlanDTO> queryAssetsDeviceRcheckPlanByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceRcheckPlanDTO> dto = assetsDeviceRcheckPlanDao.findAssetsDeviceRcheckPlanByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceRcheckPlanByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceRcheckPlan(AssetsDeviceRcheckPlanDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceRcheckPlanDao.insertAssetsDeviceRcheckPlan(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceRcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceRcheckPlanList(List<AssetsDeviceRcheckPlanDTO> dtoList, String pid) throws Exception {
		List<AssetsDeviceRcheckPlanDTO> beanList = new ArrayList<AssetsDeviceRcheckPlanDTO>();
		for (AssetsDeviceRcheckPlanDTO dto : dtoList) {
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
			return assetsDeviceRcheckPlanDao.insertAssetsDeviceRcheckPlanList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceRcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceRcheckPlan(List<AssetsDeviceRcheckPlanDTO> dtos, String pid)
			throws Exception {
		for (AssetsDeviceRcheckPlanDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setProcId(pid);
				this.insertAssetsDeviceRcheckPlan(dto);
			} else {
				this.updateAssetsDeviceRcheckPlan(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckPlan(AssetsDeviceRcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceRcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceRcheckPlanDao.updateAssetsDeviceRcheckPlanAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceRcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckPlanSensitive(AssetsDeviceRcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceRcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceRcheckPlanDao.updateAssetsDeviceRcheckPlanSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceRcheckPlanSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRcheckPlanList(List<AssetsDeviceRcheckPlanDTO> dtoList) throws Exception {
		try {
			return assetsDeviceRcheckPlanDao.updateAssetsDeviceRcheckPlanList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceRcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckPlanById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceRcheckPlanDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceRcheckPlanDao.deleteAssetsDeviceRcheckPlanById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceRcheckPlanById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckPlan(AssetsDeviceRcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceRcheckPlanDao.deleteAssetsDeviceRcheckPlanById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceRcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRcheckPlanByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceRcheckPlanById(id);
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
	public int deleteAssetsDeviceRcheckPlanList(List<String> idList) throws Exception {
		try {
			return assetsDeviceRcheckPlanDao.deleteAssetsDeviceRcheckPlanList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceRcheckPlanList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceRcheckPlanDTO
	 * @throws Exception
	 */
	private AssetsDeviceRcheckPlanDTO findById(String id) throws Exception {
		try {
			AssetsDeviceRcheckPlanDTO dto = assetsDeviceRcheckPlanDao.findAssetsDeviceRcheckPlanById(id);
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
	 * 按条件查询

	 * @return List<AssetsDeviceRcheckPlanDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanMax(String procId) throws Exception {
		try {
			List<AssetsDeviceRcheckPlanDTO> dataList = assetsDeviceRcheckPlanDao
					.searchAssetsDeviceRcheckPlanMax(procId);
			return dataList;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceRcheckPlanMax出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	public List<AssetsDeviceRcheckPlanDTO> searchAssetsDeviceRcheckPlanList(String procId){
		try {
			List<AssetsDeviceRcheckPlanDTO> dataList = assetsDeviceRcheckPlanDao
					.searchAssetsDeviceRcheckPlanList(procId);
			return dataList;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceRcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
 }
