package avicit.assets.device.assetsdevicemetering.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
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
import avicit.assets.device.assetsdevicemetering.dto.DynDeviceToolDTO;
import avicit.assets.device.assetsdevicemetering.dao.DynDeviceToolDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 16:14
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class DynDeviceToolService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(DynDeviceToolService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynDeviceToolDao dynDeviceToolDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<DynDeviceToolDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynDeviceToolDTO> searchDynDeviceToolByPage(QueryReqBean<DynDeviceToolDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynDeviceToolDTO searchParams = queryReqBean.getSearchParams();
			Page<DynDeviceToolDTO> dataList = dynDeviceToolDao.searchDynDeviceToolByPage(searchParams, orderBy);
			QueryRespBean<DynDeviceToolDTO> queryRespBean = new QueryRespBean<DynDeviceToolDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchDynDeviceToolByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<DynDeviceToolDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynDeviceToolDTO> searchDynDeviceToolByPageOr(QueryReqBean<DynDeviceToolDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynDeviceToolDTO searchParams = queryReqBean.getSearchParams();
			Page<DynDeviceToolDTO> dataList = dynDeviceToolDao.searchDynDeviceToolByPageOr(searchParams, orderBy);
			QueryRespBean<DynDeviceToolDTO> queryRespBean = new QueryRespBean<DynDeviceToolDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchDynDeviceToolByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return DynDeviceToolDTO
	 * @throws Exception
	 */
	public DynDeviceToolDTO queryDynDeviceToolByPrimaryKey(String id) throws Exception {
		try {
			DynDeviceToolDTO dto = dynDeviceToolDao.findDynDeviceToolById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryDynDeviceToolByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<DynDeviceToolDTO>
	 * @throws Exception
	 */
	public List<DynDeviceToolDTO> queryDynDeviceToolByPid(String pid) throws Exception {
		try {
			List<DynDeviceToolDTO> dto = dynDeviceToolDao.findDynDeviceToolByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryDynDeviceToolByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertDynDeviceTool(DynDeviceToolDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynDeviceToolDao.insertDynDeviceTool(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertDynDeviceTool出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynDeviceToolList(List<DynDeviceToolDTO> dtoList, String pid) throws Exception {
		List<DynDeviceToolDTO> beanList = new ArrayList<DynDeviceToolDTO>();
		for (DynDeviceToolDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setFkSubColId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return dynDeviceToolDao.insertDynDeviceToolList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertDynDeviceToolList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateDynDeviceTool(List<DynDeviceToolDTO> dtos, String pid) throws Exception {
		for (DynDeviceToolDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setFkSubColId(pid);
				this.insertDynDeviceTool(dto);
			} else {
				this.updateDynDeviceTool(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynDeviceTool(DynDeviceToolDTO dto) throws Exception {
		try {
			//记录日志
			DynDeviceToolDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynDeviceToolDao.updateDynDeviceToolAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateDynDeviceTool出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynDeviceToolSensitive(DynDeviceToolDTO dto) throws Exception {
		try {
			//记录日志
			DynDeviceToolDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynDeviceToolDao.updateDynDeviceToolSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateDynDeviceToolSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynDeviceToolList(List<DynDeviceToolDTO> dtoList) throws Exception {
		try {
			return dynDeviceToolDao.updateDynDeviceToolList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateDynDeviceToolList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynDeviceToolById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			DynDeviceToolDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return dynDeviceToolDao.deleteDynDeviceToolById(id);
		} catch (Exception e) {
			LOGGER.error("deleteDynDeviceToolById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynDeviceTool(DynDeviceToolDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynDeviceToolDao.deleteDynDeviceToolById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteDynDeviceTool出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynDeviceToolByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynDeviceToolById(id);
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
	public int deleteDynDeviceToolList(List<String> idList) throws Exception {
		try {
			return dynDeviceToolDao.deleteDynDeviceToolList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteDynDeviceToolList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return DynDeviceToolDTO
	 * @throws Exception
	 */
	private DynDeviceToolDTO findById(String id) throws Exception {
		try {
			DynDeviceToolDTO dto = dynDeviceToolDao.findDynDeviceToolById(id);
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

}
