package avicit.assets.device.assetsoperationcertificate.service;

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
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationDeviceDTO;
import avicit.assets.device.assetsoperationcertificate.dao.AssetsOperationDeviceDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 14:05
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsOperationDeviceService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsOperationDeviceService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsOperationDeviceDao assetsOperationDeviceDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsOperationDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsOperationDeviceDTO> searchAssetsOperationDeviceByPage(
			QueryReqBean<AssetsOperationDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsOperationDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsOperationDeviceDTO> dataList = assetsOperationDeviceDao
					.searchAssetsOperationDeviceByPage(searchParams, orderBy);
			QueryRespBean<AssetsOperationDeviceDTO> queryRespBean = new QueryRespBean<AssetsOperationDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsOperationDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsOperationDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsOperationDeviceDTO> searchAssetsOperationDeviceByPageOr(
			QueryReqBean<AssetsOperationDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsOperationDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsOperationDeviceDTO> dataList = assetsOperationDeviceDao
					.searchAssetsOperationDeviceByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsOperationDeviceDTO> queryRespBean = new QueryRespBean<AssetsOperationDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsOperationDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsOperationDeviceDTO
	 * @throws Exception
	 */
	public AssetsOperationDeviceDTO queryAssetsOperationDeviceByPrimaryKey(String id) throws Exception {
		try {
			AssetsOperationDeviceDTO dto = assetsOperationDeviceDao.findAssetsOperationDeviceById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsOperationDeviceByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsOperationDeviceDTO>
	 * @throws Exception
	 */
	public List<AssetsOperationDeviceDTO> queryAssetsOperationDeviceByPid(String pid) throws Exception {
		try {
			List<AssetsOperationDeviceDTO> dto = assetsOperationDeviceDao.findAssetsOperationDeviceByPid(pid);
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsOperationDeviceByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsOperationDevice(AssetsOperationDeviceDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsOperationDeviceDao.insertAssetsOperationDevice(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsOperationDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsOperationDeviceList(List<AssetsOperationDeviceDTO> dtoList) throws Exception {
		List<AssetsOperationDeviceDTO> beanList = new ArrayList<AssetsOperationDeviceDTO>();
		for (AssetsOperationDeviceDTO dto : dtoList) {
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
			return assetsOperationDeviceDao.insertAssetsOperationDeviceList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsOperationDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationDevice(AssetsOperationDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsOperationDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsOperationDeviceDao.updateAssetsOperationDeviceAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsOperationDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationDeviceSensitive(AssetsOperationDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsOperationDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsOperationDeviceDao.updateAssetsOperationDeviceSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsOperationDeviceSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationDeviceList(List<AssetsOperationDeviceDTO> dtoList) throws Exception {
		try {
			return assetsOperationDeviceDao.updateAssetsOperationDeviceList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsOperationDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsOperationDeviceById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsOperationDeviceDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsOperationDeviceDao.deleteAssetsOperationDeviceById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsOperationDeviceById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsOperationDevice(AssetsOperationDeviceDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsOperationDeviceDao.deleteAssetsOperationDeviceById(dto.getId());
		} catch (Exception e) {
			logger.error("deleteAssetsOperationDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsOperationDeviceByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsOperationDeviceById(id);
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
	public int deleteAssetsOperationDeviceList(List<String> idList) throws Exception {
		try {
			return assetsOperationDeviceDao.deleteAssetsOperationDeviceList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsOperationDeviceList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsOperationDeviceDTO
	 * @throws Exception
	 */
	private AssetsOperationDeviceDTO findById(String id) throws Exception {
		try {
			AssetsOperationDeviceDTO dto = assetsOperationDeviceDao.findAssetsOperationDeviceById(id);
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

}
