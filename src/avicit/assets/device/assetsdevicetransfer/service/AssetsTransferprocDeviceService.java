package avicit.assets.device.assetsdevicetransfer.service;

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
import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;
import avicit.assets.device.assetsdevicetransfer.dao.AssetsTransferprocDeviceDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTransferprocDeviceService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsTransferprocDeviceService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTransferprocDeviceDao assetsTransferprocDeviceDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsTransferprocDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsTransferprocDeviceDTO> searchAssetsTransferprocDeviceByPage(
			QueryReqBean<AssetsTransferprocDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTransferprocDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTransferprocDeviceDTO> dataList = assetsTransferprocDeviceDao
					.searchAssetsTransferprocDeviceByPage(searchParams, orderBy);
			QueryRespBean<AssetsTransferprocDeviceDTO> queryRespBean = new QueryRespBean<AssetsTransferprocDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsTransferprocDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsTransferprocDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsTransferprocDeviceDTO> searchAssetsTransferprocDeviceByPageOr(
			QueryReqBean<AssetsTransferprocDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTransferprocDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTransferprocDeviceDTO> dataList = assetsTransferprocDeviceDao
					.searchAssetsTransferprocDeviceByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTransferprocDeviceDTO> queryRespBean = new QueryRespBean<AssetsTransferprocDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsTransferprocDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsTransferprocDeviceDTO
	 * @throws Exception
	 */
	public AssetsTransferprocDeviceDTO queryAssetsTransferprocDeviceByPrimaryKey(String id) throws Exception {
		try {
			AssetsTransferprocDeviceDTO dto = assetsTransferprocDeviceDao.findAssetsTransferprocDeviceById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsTransferprocDeviceByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsTransferprocDeviceDTO>
	 * @throws Exception
	 */
	public List<AssetsTransferprocDeviceDTO> queryAssetsTransferprocDeviceByPid(String pid) throws Exception {
		try {
			List<AssetsTransferprocDeviceDTO> dto = assetsTransferprocDeviceDao.findAssetsTransferprocDeviceByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsTransferprocDeviceByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsTransferprocDevice(AssetsTransferprocDeviceDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsTransferprocDeviceDao.insertAssetsTransferprocDevice(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsTransferprocDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTransferprocDeviceList(List<AssetsTransferprocDeviceDTO> dtoList, String pid)
			throws Exception {
		List<AssetsTransferprocDeviceDTO> beanList = new ArrayList<AssetsTransferprocDeviceDTO>();
		for (AssetsTransferprocDeviceDTO dto : dtoList) {
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
			return assetsTransferprocDeviceDao.insertAssetsTransferprocDeviceList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsTransferprocDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsTransferprocDevice(List<AssetsTransferprocDeviceDTO> dtos, String pid)
			throws Exception {
		for (AssetsTransferprocDeviceDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setProcId(pid);
				this.insertAssetsTransferprocDevice(dto);
			} else {
				this.updateAssetsTransferprocDevice(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTransferprocDevice(AssetsTransferprocDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTransferprocDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsTransferprocDeviceDao.updateAssetsTransferprocDeviceAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsTransferprocDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTransferprocDeviceSensitive(AssetsTransferprocDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTransferprocDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsTransferprocDeviceDao.updateAssetsTransferprocDeviceSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsTransferprocDeviceSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTransferprocDeviceList(List<AssetsTransferprocDeviceDTO> dtoList) throws Exception {
		try {
			return assetsTransferprocDeviceDao.updateAssetsTransferprocDeviceList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsTransferprocDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTransferprocDeviceById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsTransferprocDeviceDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTransferprocDeviceDao.deleteAssetsTransferprocDeviceById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTransferprocDeviceById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTransferprocDevice(AssetsTransferprocDeviceDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsTransferprocDeviceDao.deleteAssetsTransferprocDeviceById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTransferprocDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTransferprocDeviceByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsTransferprocDeviceById(id);
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
	public int deleteAssetsTransferprocDeviceList(List<String> idList) throws Exception {
		try {
			return assetsTransferprocDeviceDao.deleteAssetsTransferprocDeviceList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTransferprocDeviceList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTransferprocDeviceDTO
	 * @throws Exception
	 */
	private AssetsTransferprocDeviceDTO findById(String id) throws Exception {
		try {
			AssetsTransferprocDeviceDTO dto = assetsTransferprocDeviceDao.findAssetsTransferprocDeviceById(id);
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
