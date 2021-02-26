package avicit.assets.device.assetsdevicereuse.service;

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
import avicit.assets.device.assetsdevicereuse.dto.AssetsDeviceReusesubDTO;
import avicit.assets.device.assetsdevicereuse.dao.AssetsDeviceReusesubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 19:33
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceReusesubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceReusesubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceReusesubDao assetsDeviceReusesubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceReusesubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceReusesubDTO> searchAssetsDeviceReusesubByPage(
			QueryReqBean<AssetsDeviceReusesubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceReusesubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceReusesubDTO> dataList = assetsDeviceReusesubDao
					.searchAssetsDeviceReusesubByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceReusesubDTO> queryRespBean = new QueryRespBean<AssetsDeviceReusesubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceReusesubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceReusesubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceReusesubDTO> searchAssetsDeviceReusesubByPageOr(
			QueryReqBean<AssetsDeviceReusesubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceReusesubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceReusesubDTO> dataList = assetsDeviceReusesubDao
					.searchAssetsDeviceReusesubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceReusesubDTO> queryRespBean = new QueryRespBean<AssetsDeviceReusesubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceReusesubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceReusesubDTO
	 * @throws Exception
	 */
	public AssetsDeviceReusesubDTO queryAssetsDeviceReusesubByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceReusesubDTO dto = assetsDeviceReusesubDao.findAssetsDeviceReusesubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceReusesubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceReusesubDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceReusesubDTO> queryAssetsDeviceReusesubByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceReusesubDTO> dto = assetsDeviceReusesubDao.findAssetsDeviceReusesubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceReusesubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceReusesub(AssetsDeviceReusesubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceReusesubDao.insertAssetsDeviceReusesub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceReusesub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceReusesubList(List<AssetsDeviceReusesubDTO> dtoList, String pid) throws Exception {
		List<AssetsDeviceReusesubDTO> beanList = new ArrayList<AssetsDeviceReusesubDTO>();
		for (AssetsDeviceReusesubDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setParentId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsDeviceReusesubDao.insertAssetsDeviceReusesubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceReusesubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceReusesub(List<AssetsDeviceReusesubDTO> dtos, String pid) throws Exception {
		for (AssetsDeviceReusesubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsDeviceReusesub(dto);
			} else {
				this.updateAssetsDeviceReusesub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceReusesub(AssetsDeviceReusesubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceReusesubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceReusesubDao.updateAssetsDeviceReusesubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceReusesub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceReusesubSensitive(AssetsDeviceReusesubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceReusesubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceReusesubDao.updateAssetsDeviceReusesubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceReusesubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceReusesubList(List<AssetsDeviceReusesubDTO> dtoList) throws Exception {
		try {
			return assetsDeviceReusesubDao.updateAssetsDeviceReusesubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceReusesubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceReusesubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceReusesubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceReusesubDao.deleteAssetsDeviceReusesubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceReusesubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceReusesub(AssetsDeviceReusesubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceReusesubDao.deleteAssetsDeviceReusesubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceReusesub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceReusesubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceReusesubById(id);
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
	public int deleteAssetsDeviceReusesubList(List<String> idList) throws Exception {
		try {
			return assetsDeviceReusesubDao.deleteAssetsDeviceReusesubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceReusesubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceReusesubDTO
	 * @throws Exception
	 */
	private AssetsDeviceReusesubDTO findById(String id) throws Exception {
		try {
			AssetsDeviceReusesubDTO dto = assetsDeviceReusesubDao.findAssetsDeviceReusesubById(id);
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
