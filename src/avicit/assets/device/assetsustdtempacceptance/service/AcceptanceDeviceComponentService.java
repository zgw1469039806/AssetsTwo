package avicit.assets.device.assetsustdtempacceptance.service;

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
import avicit.assets.device.assetsustdtempacceptance.dto.AcceptanceDeviceComponentDTO;
import avicit.assets.device.assetsustdtempacceptance.dao.AcceptanceDeviceComponentDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-02 14:46
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AcceptanceDeviceComponentService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AcceptanceDeviceComponentService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AcceptanceDeviceComponentDao acceptanceDeviceComponentDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AcceptanceDeviceComponentDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AcceptanceDeviceComponentDTO> searchAcceptanceDeviceComponentByPage(
			QueryReqBean<AcceptanceDeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AcceptanceDeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AcceptanceDeviceComponentDTO> dataList = acceptanceDeviceComponentDao
					.searchAcceptanceDeviceComponentByPage(searchParams, orderBy);
			QueryRespBean<AcceptanceDeviceComponentDTO> queryRespBean = new QueryRespBean<AcceptanceDeviceComponentDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAcceptanceDeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AcceptanceDeviceComponentDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AcceptanceDeviceComponentDTO> searchAcceptanceDeviceComponentByPageOr(
			QueryReqBean<AcceptanceDeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AcceptanceDeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AcceptanceDeviceComponentDTO> dataList = acceptanceDeviceComponentDao
					.searchAcceptanceDeviceComponentByPageOr(searchParams, orderBy);
			QueryRespBean<AcceptanceDeviceComponentDTO> queryRespBean = new QueryRespBean<AcceptanceDeviceComponentDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAcceptanceDeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AcceptanceDeviceComponentDTO
	 * @throws Exception
	 */
	public AcceptanceDeviceComponentDTO queryAcceptanceDeviceComponentByPrimaryKey(String id) throws Exception {
		try {
			AcceptanceDeviceComponentDTO dto = acceptanceDeviceComponentDao.findAcceptanceDeviceComponentById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAcceptanceDeviceComponentByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AcceptanceDeviceComponentDTO>
	 * @throws Exception
	 */
	public List<AcceptanceDeviceComponentDTO> queryAcceptanceDeviceComponentByPid(String pid) throws Exception {
		try {
			List<AcceptanceDeviceComponentDTO> dto = acceptanceDeviceComponentDao
					.findAcceptanceDeviceComponentByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAcceptanceDeviceComponentByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAcceptanceDeviceComponent(AcceptanceDeviceComponentDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			acceptanceDeviceComponentDao.insertAcceptanceDeviceComponent(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAcceptanceDeviceComponent出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAcceptanceDeviceComponentList(List<AcceptanceDeviceComponentDTO> dtoList, String pid)
			throws Exception {
		List<AcceptanceDeviceComponentDTO> beanList = new ArrayList<AcceptanceDeviceComponentDTO>();
		for (AcceptanceDeviceComponentDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setAcceptanceId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return acceptanceDeviceComponentDao.insertAcceptanceDeviceComponentList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAcceptanceDeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAcceptanceDeviceComponent(List<AcceptanceDeviceComponentDTO> dtos, String pid)
			throws Exception {
		for (AcceptanceDeviceComponentDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setAcceptanceId(pid);
				this.insertAcceptanceDeviceComponent(dto);
			} else {
				this.updateAcceptanceDeviceComponent(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAcceptanceDeviceComponent(AcceptanceDeviceComponentDTO dto) throws Exception {
		try {
			//记录日志
			AcceptanceDeviceComponentDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = acceptanceDeviceComponentDao.updateAcceptanceDeviceComponentAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAcceptanceDeviceComponent出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAcceptanceDeviceComponentSensitive(AcceptanceDeviceComponentDTO dto) throws Exception {
		try {
			//记录日志
			AcceptanceDeviceComponentDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = acceptanceDeviceComponentDao.updateAcceptanceDeviceComponentSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAcceptanceDeviceComponentSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAcceptanceDeviceComponentList(List<AcceptanceDeviceComponentDTO> dtoList) throws Exception {
		try {
			return acceptanceDeviceComponentDao.updateAcceptanceDeviceComponentList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAcceptanceDeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAcceptanceDeviceComponentById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AcceptanceDeviceComponentDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return acceptanceDeviceComponentDao.deleteAcceptanceDeviceComponentById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAcceptanceDeviceComponentById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAcceptanceDeviceComponent(AcceptanceDeviceComponentDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return acceptanceDeviceComponentDao.deleteAcceptanceDeviceComponentById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAcceptanceDeviceComponent出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAcceptanceDeviceComponentByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAcceptanceDeviceComponentById(id);
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
	public int deleteAcceptanceDeviceComponentList(List<String> idList) throws Exception {
		try {
			return acceptanceDeviceComponentDao.deleteAcceptanceDeviceComponentList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAcceptanceDeviceComponentList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AcceptanceDeviceComponentDTO
	 * @throws Exception
	 */
	private AcceptanceDeviceComponentDTO findById(String id) throws Exception {
		try {
			AcceptanceDeviceComponentDTO dto = acceptanceDeviceComponentDao.findAcceptanceDeviceComponentById(id);
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
