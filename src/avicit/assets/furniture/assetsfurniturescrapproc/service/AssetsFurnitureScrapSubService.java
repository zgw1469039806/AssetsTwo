package avicit.assets.furniture.assetsfurniturescrapproc.service;

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
import avicit.assets.furniture.assetsfurniturescrapproc.dto.AssetsFurnitureScrapSubDTO;
import avicit.assets.furniture.assetsfurniturescrapproc.dao.AssetsFurnitureScrapSubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-20 17:18
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureScrapSubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureScrapSubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureScrapSubDao assetsFurnitureScrapSubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureScrapSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureScrapSubDTO> searchAssetsFurnitureScrapSubByPage(
			QueryReqBean<AssetsFurnitureScrapSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureScrapSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureScrapSubDTO> dataList = assetsFurnitureScrapSubDao
					.searchAssetsFurnitureScrapSubByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureScrapSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureScrapSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureScrapSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureScrapSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureScrapSubDTO> searchAssetsFurnitureScrapSubByPageOr(
			QueryReqBean<AssetsFurnitureScrapSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureScrapSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureScrapSubDTO> dataList = assetsFurnitureScrapSubDao
					.searchAssetsFurnitureScrapSubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureScrapSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureScrapSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureScrapSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureScrapSubDTO
	 * @throws Exception
	 */
	public AssetsFurnitureScrapSubDTO queryAssetsFurnitureScrapSubByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureScrapSubDTO dto = assetsFurnitureScrapSubDao.findAssetsFurnitureScrapSubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureScrapSubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureScrapSubDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureScrapSubDTO> queryAssetsFurnitureScrapSubByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureScrapSubDTO> dto = assetsFurnitureScrapSubDao.findAssetsFurnitureScrapSubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureScrapSubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureScrapSub(AssetsFurnitureScrapSubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureScrapSubDao.insertAssetsFurnitureScrapSub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureScrapSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureScrapSubList(List<AssetsFurnitureScrapSubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsFurnitureScrapSubDTO> beanList = new ArrayList<AssetsFurnitureScrapSubDTO>();
		for (AssetsFurnitureScrapSubDTO dto : dtoList) {
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
			return assetsFurnitureScrapSubDao.insertAssetsFurnitureScrapSubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureScrapSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureScrapSub(List<AssetsFurnitureScrapSubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureScrapSubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureScrapSub(dto);
			} else {
				this.updateAssetsFurnitureScrapSub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureScrapSub(AssetsFurnitureScrapSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureScrapSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureScrapSubDao.updateAssetsFurnitureScrapSubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureScrapSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureScrapSubSensitive(AssetsFurnitureScrapSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureScrapSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureScrapSubDao.updateAssetsFurnitureScrapSubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureScrapSubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureScrapSubList(List<AssetsFurnitureScrapSubDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureScrapSubDao.updateAssetsFurnitureScrapSubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureScrapSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureScrapSubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureScrapSubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureScrapSubDao.deleteAssetsFurnitureScrapSubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureScrapSubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureScrapSub(AssetsFurnitureScrapSubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureScrapSubDao.deleteAssetsFurnitureScrapSubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureScrapSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureScrapSubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureScrapSubById(id);
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
	public int deleteAssetsFurnitureScrapSubList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureScrapSubDao.deleteAssetsFurnitureScrapSubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureScrapSubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureScrapSubDTO
	 * @throws Exception
	 */
	private AssetsFurnitureScrapSubDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureScrapSubDTO dto = assetsFurnitureScrapSubDao.findAssetsFurnitureScrapSubById(id);
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
