package avicit.assets.device.assetsdeviceinventory.service;

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
import avicit.assets.device.assetsdeviceinventory.dto.AssetsDeviceInventorySubDTO;
import avicit.assets.device.assetsdeviceinventory.dao.AssetsDeviceInventorySubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 14:32
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceInventorySubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsDeviceInventorySubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceInventorySubDao assetsDeviceInventorySubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceInventorySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceInventorySubDTO> searchAssetsDeviceInventorySubByPage(
			QueryReqBean<AssetsDeviceInventorySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceInventorySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceInventorySubDTO> dataList = assetsDeviceInventorySubDao
					.searchAssetsDeviceInventorySubByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceInventorySubDTO> queryRespBean = new QueryRespBean<AssetsDeviceInventorySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceInventorySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceInventorySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsDeviceInventorySubDTO> searchAssetsDeviceInventorySubByPageOr(
			QueryReqBean<AssetsDeviceInventorySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceInventorySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceInventorySubDTO> dataList = assetsDeviceInventorySubDao
					.searchAssetsDeviceInventorySubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceInventorySubDTO> queryRespBean = new QueryRespBean<AssetsDeviceInventorySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsDeviceInventorySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceInventorySubDTO
	 * @throws Exception
	 */
	public AssetsDeviceInventorySubDTO queryAssetsDeviceInventorySubByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceInventorySubDTO dto = assetsDeviceInventorySubDao.findAssetsDeviceInventorySubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceInventorySubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsDeviceInventorySubDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceInventorySubDTO> queryAssetsDeviceInventorySubByPid(String pid) throws Exception {
		try {
			List<AssetsDeviceInventorySubDTO> dto = assetsDeviceInventorySubDao.findAssetsDeviceInventorySubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsDeviceInventorySubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceInventorySub(AssetsDeviceInventorySubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceInventorySubDao.insertAssetsDeviceInventorySub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceInventorySubList(List<AssetsDeviceInventorySubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsDeviceInventorySubDTO> beanList = new ArrayList<AssetsDeviceInventorySubDTO>();
		for (AssetsDeviceInventorySubDTO dto : dtoList) {
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
			return assetsDeviceInventorySubDao.insertAssetsDeviceInventorySubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsDeviceInventorySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceInventorySub(List<AssetsDeviceInventorySubDTO> dtos, String pid)
			throws Exception {
		for (AssetsDeviceInventorySubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsDeviceInventorySub(dto);
			} else {
				this.updateAssetsDeviceInventorySub(dto);
			}
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsDeviceInventorySub01(List<AssetsDeviceInventorySubDTO> dtos, String pid)
			throws Exception {
		for (AssetsDeviceInventorySubDTO dto : dtos) {
			dto.setDeviceId(dto.getId());
			dto.setId("");
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsDeviceInventorySub(dto);
			} else {
				this.updateAssetsDeviceInventorySub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceInventorySub(AssetsDeviceInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceInventorySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceInventorySubDao.updateAssetsDeviceInventorySubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceInventorySubSensitive(AssetsDeviceInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceInventorySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceInventorySubDao.updateAssetsDeviceInventorySubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceInventorySubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceInventorySubList(List<AssetsDeviceInventorySubDTO> dtoList) throws Exception {
		try {
			return assetsDeviceInventorySubDao.updateAssetsDeviceInventorySubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsDeviceInventorySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceInventorySubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceInventorySubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceInventorySubDao.deleteAssetsDeviceInventorySubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceInventorySubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceInventorySub(AssetsDeviceInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsDeviceInventorySubDao.deleteAssetsDeviceInventorySubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceInventorySubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceInventorySubById(id);
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
	public int deleteAssetsDeviceInventorySubList(List<String> idList) throws Exception {
		try {
			return assetsDeviceInventorySubDao.deleteAssetsDeviceInventorySubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsDeviceInventorySubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceInventorySubDTO
	 * @throws Exception
	 */
	private AssetsDeviceInventorySubDTO findById(String id) throws Exception {
		try {
			AssetsDeviceInventorySubDTO dto = assetsDeviceInventorySubDao.findAssetsDeviceInventorySubById(id);
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
