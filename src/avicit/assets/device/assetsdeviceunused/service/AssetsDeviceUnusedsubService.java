package avicit.assets.device.assetsdeviceunused.service;

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
import avicit.assets.device.assetsdeviceunused.dto.AssetsDeviceUnusedsubDTO;
import avicit.assets.device.assetsdeviceunused.dao.AssetsDeviceUnusedsubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-13 11:10
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceUnusedsubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceUnusedsubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceUnusedsubDao assetsDeviceUnusedsubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceUnusedsubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceUnusedsubDTO> searchAssetsDeviceUnusedsubByPage(
			QueryReqBean<AssetsDeviceUnusedsubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceUnusedsubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceUnusedsubDTO> dataList = assetsDeviceUnusedsubDao
					.searchAssetsDeviceUnusedsubByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceUnusedsubDTO> queryRespBean = new QueryRespBean<AssetsDeviceUnusedsubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceUnusedsubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceUnusedsubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceUnusedsubDTO> searchAssetsDeviceUnusedsubByPageOr(
			QueryReqBean<AssetsDeviceUnusedsubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceUnusedsubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceUnusedsubDTO> dataList = assetsDeviceUnusedsubDao
					.searchAssetsDeviceUnusedsubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceUnusedsubDTO> queryRespBean = new QueryRespBean<AssetsDeviceUnusedsubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceUnusedsubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceUnusedsubDTO
	 * @throws Exception
	 */
	public AssetsDeviceUnusedsubDTO queryAssetsDeviceUnusedsubByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceUnusedsubDTO dto = assetsDeviceUnusedsubDao.findAssetsDeviceUnusedsubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceUnusedsubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceUnusedsubDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceUnusedsubDTO> queryAssetsDeviceUnusedsubByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceUnusedsubDTO> dto = assetsDeviceUnusedsubDao.findAssetsDeviceUnusedsubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceUnusedsubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceUnusedsub(AssetsDeviceUnusedsubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceUnusedsubDao.insertAssetsDeviceUnusedsub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceUnusedsub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceUnusedsubList(List<AssetsDeviceUnusedsubDTO> dtoList, String pid) throws Exception {
		List<AssetsDeviceUnusedsubDTO> beanList = new ArrayList<AssetsDeviceUnusedsubDTO>();
		for (AssetsDeviceUnusedsubDTO dto : dtoList) {
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
			return assetsDeviceUnusedsubDao.insertAssetsDeviceUnusedsubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceUnusedsubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceUnusedsub(List<AssetsDeviceUnusedsubDTO> dtos, String pid) throws Exception {
		for (AssetsDeviceUnusedsubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsDeviceUnusedsub(dto);
			} else {
				this.updateAssetsDeviceUnusedsub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceUnusedsub(AssetsDeviceUnusedsubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceUnusedsubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceUnusedsubDao.updateAssetsDeviceUnusedsubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceUnusedsub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceUnusedsubSensitive(AssetsDeviceUnusedsubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceUnusedsubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceUnusedsubDao.updateAssetsDeviceUnusedsubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceUnusedsubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceUnusedsubList(List<AssetsDeviceUnusedsubDTO> dtoList) throws Exception {
		try {
			return assetsDeviceUnusedsubDao.updateAssetsDeviceUnusedsubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceUnusedsubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceUnusedsubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceUnusedsubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceUnusedsubDao.deleteAssetsDeviceUnusedsubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceUnusedsubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceUnusedsub(AssetsDeviceUnusedsubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceUnusedsubDao.deleteAssetsDeviceUnusedsubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceUnusedsub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceUnusedsubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceUnusedsubById(id);
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
	public int deleteAssetsDeviceUnusedsubList(List<String> idList) throws Exception {
		try {
			return assetsDeviceUnusedsubDao.deleteAssetsDeviceUnusedsubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceUnusedsubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceUnusedsubDTO
	 * @throws Exception
	 */
	private AssetsDeviceUnusedsubDTO findById(String id) throws Exception {
		try {
			AssetsDeviceUnusedsubDTO dto = assetsDeviceUnusedsubDao.findAssetsDeviceUnusedsubById(id);
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
