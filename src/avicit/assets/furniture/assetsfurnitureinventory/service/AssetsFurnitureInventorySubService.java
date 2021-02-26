package avicit.assets.furniture.assetsfurnitureinventory.service;

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
import avicit.assets.furniture.assetsfurnitureinventory.dto.AssetsFurnitureInventorySubDTO;
import avicit.assets.furniture.assetsfurnitureinventory.dao.AssetsFurnitureInventorySubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:15
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureInventorySubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureInventorySubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureInventorySubDao assetsFurnitureInventorySubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureInventorySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureInventorySubDTO> searchAssetsFurnitureInventorySubByPage(
			QueryReqBean<AssetsFurnitureInventorySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureInventorySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureInventorySubDTO> dataList = assetsFurnitureInventorySubDao
					.searchAssetsFurnitureInventorySubByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureInventorySubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureInventorySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureInventorySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureInventorySubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureInventorySubDTO> searchAssetsFurnitureInventorySubByPageOr(
			QueryReqBean<AssetsFurnitureInventorySubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureInventorySubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureInventorySubDTO> dataList = assetsFurnitureInventorySubDao
					.searchAssetsFurnitureInventorySubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureInventorySubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureInventorySubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureInventorySubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureInventorySubDTO
	 * @throws Exception
	 */
	public AssetsFurnitureInventorySubDTO queryAssetsFurnitureInventorySubByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureInventorySubDTO dto = assetsFurnitureInventorySubDao.findAssetsFurnitureInventorySubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureInventorySubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureInventorySubDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureInventorySubDTO> queryAssetsFurnitureInventorySubByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureInventorySubDTO> dto = assetsFurnitureInventorySubDao
					.findAssetsFurnitureInventorySubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureInventorySubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureInventorySub(AssetsFurnitureInventorySubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureInventorySubDao.insertAssetsFurnitureInventorySub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureInventorySubList(List<AssetsFurnitureInventorySubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsFurnitureInventorySubDTO> beanList = new ArrayList<AssetsFurnitureInventorySubDTO>();
		for (AssetsFurnitureInventorySubDTO dto : dtoList) {
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
			return assetsFurnitureInventorySubDao.insertAssetsFurnitureInventorySubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureInventorySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureInventorySub(List<AssetsFurnitureInventorySubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureInventorySubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureInventorySub(dto);
			} else {
				this.updateAssetsFurnitureInventorySub(dto);
			}
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureInventorySub01(List<AssetsFurnitureInventorySubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureInventorySubDTO dto : dtos) {
		    dto.setFurnitureId(dto.getId());
			dto.setId("");
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureInventorySub(dto);
			} else {
				this.updateAssetsFurnitureInventorySub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureInventorySub(AssetsFurnitureInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureInventorySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureInventorySubDao.updateAssetsFurnitureInventorySubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureInventorySubSensitive(AssetsFurnitureInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureInventorySubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureInventorySubDao.updateAssetsFurnitureInventorySubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureInventorySubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureInventorySubList(List<AssetsFurnitureInventorySubDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureInventorySubDao.updateAssetsFurnitureInventorySubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureInventorySubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureInventorySubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureInventorySubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureInventorySubDao.deleteAssetsFurnitureInventorySubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureInventorySubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureInventorySub(AssetsFurnitureInventorySubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureInventorySubDao.deleteAssetsFurnitureInventorySubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureInventorySub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureInventorySubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureInventorySubById(id);
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
	public int deleteAssetsFurnitureInventorySubList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureInventorySubDao.deleteAssetsFurnitureInventorySubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureInventorySubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureInventorySubDTO
	 * @throws Exception
	 */
	private AssetsFurnitureInventorySubDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureInventorySubDTO dto = assetsFurnitureInventorySubDao.findAssetsFurnitureInventorySubById(id);
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
