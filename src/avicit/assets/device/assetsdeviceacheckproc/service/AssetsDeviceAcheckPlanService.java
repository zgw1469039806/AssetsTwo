package avicit.assets.device.assetsdeviceacheckproc.service;

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
import avicit.assets.device.assetsdeviceacheckproc.dto.AssetsDeviceAcheckPlanDTO;
import avicit.assets.device.assetsdeviceacheckproc.dao.AssetsDeviceAcheckPlanDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-08 17:30
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceAcheckPlanService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceAcheckPlanService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceAcheckPlanDao assetsDeviceAcheckPlanDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceAcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanByPage(
			QueryReqBean<AssetsDeviceAcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckPlanDTO> dataList = assetsDeviceAcheckPlanDao
					.searchAssetsDeviceAcheckPlanByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceAcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceAcheckPlanDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanByPageOr(
			QueryReqBean<AssetsDeviceAcheckPlanDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAcheckPlanDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAcheckPlanDTO> dataList = assetsDeviceAcheckPlanDao
					.searchAssetsDeviceAcheckPlanByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAcheckPlanDTO> queryRespBean = new QueryRespBean<AssetsDeviceAcheckPlanDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceAcheckPlanByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceAcheckPlanDTO
	 * @throws Exception
	 */
	public AssetsDeviceAcheckPlanDTO queryAssetsDeviceAcheckPlanByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceAcheckPlanDTO dto = assetsDeviceAcheckPlanDao.findAssetsDeviceAcheckPlanById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceAcheckPlanByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceAcheckPlanDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAcheckPlanDTO> queryAssetsDeviceAcheckPlanByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceAcheckPlanDTO> dto = assetsDeviceAcheckPlanDao.findAssetsDeviceAcheckPlanByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceAcheckPlanByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceAcheckPlan(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceAcheckPlanDao.insertAssetsDeviceAcheckPlan(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceAcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceAcheckPlanList(List<AssetsDeviceAcheckPlanDTO> dtoList, String pid) throws Exception {
		List<AssetsDeviceAcheckPlanDTO> beanList = new ArrayList<AssetsDeviceAcheckPlanDTO>();
		for (AssetsDeviceAcheckPlanDTO dto : dtoList) {
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
			return assetsDeviceAcheckPlanDao.insertAssetsDeviceAcheckPlanList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceAcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceAcheckPlan(List<AssetsDeviceAcheckPlanDTO> dtos, String pid)
			throws Exception {
		for (AssetsDeviceAcheckPlanDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setProcId(pid);
				this.insertAssetsDeviceAcheckPlan(dto);
			} else {
				this.updateAssetsDeviceAcheckPlan(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckPlan(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceAcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceAcheckPlanDao.updateAssetsDeviceAcheckPlanAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceAcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckPlanSensitive(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceAcheckPlanDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceAcheckPlanDao.updateAssetsDeviceAcheckPlanSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceAcheckPlanSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAcheckPlanList(List<AssetsDeviceAcheckPlanDTO> dtoList) throws Exception {
		try {
			return assetsDeviceAcheckPlanDao.updateAssetsDeviceAcheckPlanList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceAcheckPlanList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckPlanById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceAcheckPlanDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceAcheckPlanDao.deleteAssetsDeviceAcheckPlanById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceAcheckPlanById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckPlan(AssetsDeviceAcheckPlanDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceAcheckPlanDao.deleteAssetsDeviceAcheckPlanById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceAcheckPlan出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAcheckPlanByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceAcheckPlanById(id);
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
	public int deleteAssetsDeviceAcheckPlanList(List<String> idList) throws Exception {
		try {
			return assetsDeviceAcheckPlanDao.deleteAssetsDeviceAcheckPlanList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceAcheckPlanList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceAcheckPlanDTO
	 * @throws Exception
	 */
	private AssetsDeviceAcheckPlanDTO findById(String id) throws Exception {
		try {
			AssetsDeviceAcheckPlanDTO dto = assetsDeviceAcheckPlanDao.findAssetsDeviceAcheckPlanById(id);
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
	public List<AssetsDeviceAcheckPlanDTO> searchAssetsDeviceAcheckPlanMax(String procId) throws Exception {
		try {
			List<AssetsDeviceAcheckPlanDTO> dataList = assetsDeviceAcheckPlanDao
					.searchAssetsDeviceAcheckPlanMax(procId);
			return dataList;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceRcheckPlanMax出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

}
