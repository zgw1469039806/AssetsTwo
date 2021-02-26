package avicit.assets.furniture.assetsfurniturerecoveryproc.service;

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
import avicit.assets.furniture.assetsfurniturerecoveryproc.dto.AssetsFurnitureRecoverySubDTO;
import avicit.assets.furniture.assetsfurniturerecoveryproc.dao.AssetsFurnitureRecoverySubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-18 08:50
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureRecoverySubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureRecoverySubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureRecoverySubDao assetsFurnitureRecoverySubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureRecoverySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureRecoverySubDTO> searchAssetsFurnitureRecoverySubByPage(
			QueryReqBean<AssetsFurnitureRecoverySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureRecoverySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureRecoverySubDTO> dataList = assetsFurnitureRecoverySubDao
					.searchAssetsFurnitureRecoverySubByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureRecoverySubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureRecoverySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureRecoverySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureRecoverySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureRecoverySubDTO> searchAssetsFurnitureRecoverySubByPageOr(
			QueryReqBean<AssetsFurnitureRecoverySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureRecoverySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureRecoverySubDTO> dataList = assetsFurnitureRecoverySubDao
					.searchAssetsFurnitureRecoverySubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureRecoverySubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureRecoverySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureRecoverySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureRecoverySubDTO
	 * @throws Exception
	 */
	public AssetsFurnitureRecoverySubDTO queryAssetsFurnitureRecoverySubByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureRecoverySubDTO dto = assetsFurnitureRecoverySubDao.findAssetsFurnitureRecoverySubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureRecoverySubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureRecoverySubDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureRecoverySubDTO> queryAssetsFurnitureRecoverySubByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureRecoverySubDTO> dto = assetsFurnitureRecoverySubDao
					.findAssetsFurnitureRecoverySubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureRecoverySubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureRecoverySub(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureRecoverySubDao.insertAssetsFurnitureRecoverySub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureRecoverySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureRecoverySubList(List<AssetsFurnitureRecoverySubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsFurnitureRecoverySubDTO> beanList = new ArrayList<AssetsFurnitureRecoverySubDTO>();
		for (AssetsFurnitureRecoverySubDTO dto : dtoList) {
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
			return assetsFurnitureRecoverySubDao.insertAssetsFurnitureRecoverySubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureRecoverySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureRecoverySub(List<AssetsFurnitureRecoverySubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureRecoverySubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureRecoverySub(dto);
			} else {
				this.updateAssetsFurnitureRecoverySub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRecoverySub(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureRecoverySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureRecoverySubDao.updateAssetsFurnitureRecoverySubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRecoverySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRecoverySubSensitive(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureRecoverySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureRecoverySubDao.updateAssetsFurnitureRecoverySubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRecoverySubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRecoverySubList(List<AssetsFurnitureRecoverySubDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureRecoverySubDao.updateAssetsFurnitureRecoverySubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRecoverySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRecoverySubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureRecoverySubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureRecoverySubDao.deleteAssetsFurnitureRecoverySubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRecoverySubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRecoverySub(AssetsFurnitureRecoverySubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureRecoverySubDao.deleteAssetsFurnitureRecoverySubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRecoverySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRecoverySubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureRecoverySubById(id);
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
	public int deleteAssetsFurnitureRecoverySubList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureRecoverySubDao.deleteAssetsFurnitureRecoverySubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRecoverySubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureRecoverySubDTO
	 * @throws Exception
	 */
	private AssetsFurnitureRecoverySubDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureRecoverySubDTO dto = assetsFurnitureRecoverySubDao.findAssetsFurnitureRecoverySubById(id);
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
