package avicit.assets.furniture.assetsfurnituretransferproc.service;

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
import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferSubDTO;
import avicit.assets.furniture.assetsfurnituretransferproc.dao.AssetsFurnitureTransferSubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-14 16:53
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureTransferSubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureTransferSubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureTransferSubDao assetsFurnitureTransferSubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureTransferSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureTransferSubDTO> searchAssetsFurnitureTransferSubByPage(
			QueryReqBean<AssetsFurnitureTransferSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureTransferSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureTransferSubDTO> dataList = assetsFurnitureTransferSubDao
					.searchAssetsFurnitureTransferSubByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureTransferSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureTransferSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureTransferSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureTransferSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureTransferSubDTO> searchAssetsFurnitureTransferSubByPageOr(
			QueryReqBean<AssetsFurnitureTransferSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureTransferSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureTransferSubDTO> dataList = assetsFurnitureTransferSubDao
					.searchAssetsFurnitureTransferSubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureTransferSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureTransferSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureTransferSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureTransferSubDTO
	 * @throws Exception
	 */
	public AssetsFurnitureTransferSubDTO queryAssetsFurnitureTransferSubByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureTransferSubDTO dto = assetsFurnitureTransferSubDao.findAssetsFurnitureTransferSubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureTransferSubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureTransferSubDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureTransferSubDTO> queryAssetsFurnitureTransferSubByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureTransferSubDTO> dto = assetsFurnitureTransferSubDao
					.findAssetsFurnitureTransferSubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureTransferSubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureTransferSub(AssetsFurnitureTransferSubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureTransferSubDao.insertAssetsFurnitureTransferSub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureTransferSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureTransferSubList(List<AssetsFurnitureTransferSubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsFurnitureTransferSubDTO> beanList = new ArrayList<AssetsFurnitureTransferSubDTO>();
		for (AssetsFurnitureTransferSubDTO dto : dtoList) {
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
			return assetsFurnitureTransferSubDao.insertAssetsFurnitureTransferSubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureTransferSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureTransferSub(List<AssetsFurnitureTransferSubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureTransferSubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureTransferSub(dto);
			} else {
				this.updateAssetsFurnitureTransferSub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureTransferSub(AssetsFurnitureTransferSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureTransferSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureTransferSubDao.updateAssetsFurnitureTransferSubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureTransferSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureTransferSubSensitive(AssetsFurnitureTransferSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureTransferSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureTransferSubDao.updateAssetsFurnitureTransferSubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureTransferSubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureTransferSubList(List<AssetsFurnitureTransferSubDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureTransferSubDao.updateAssetsFurnitureTransferSubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureTransferSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureTransferSubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureTransferSubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureTransferSubDao.deleteAssetsFurnitureTransferSubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureTransferSubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureTransferSub(AssetsFurnitureTransferSubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureTransferSubDao.deleteAssetsFurnitureTransferSubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureTransferSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureTransferSubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureTransferSubById(id);
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
	public int deleteAssetsFurnitureTransferSubList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureTransferSubDao.deleteAssetsFurnitureTransferSubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureTransferSubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureTransferSubDTO
	 * @throws Exception
	 */
	private AssetsFurnitureTransferSubDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureTransferSubDTO dto = assetsFurnitureTransferSubDao.findAssetsFurnitureTransferSubById(id);
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
