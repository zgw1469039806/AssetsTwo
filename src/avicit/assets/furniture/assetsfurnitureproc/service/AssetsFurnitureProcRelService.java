package avicit.assets.furniture.assetsfurnitureproc.service;

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
import avicit.assets.furniture.assetsfurnitureproc.dto.AssetsFurnitureProcRelDTO;
import avicit.assets.furniture.assetsfurnitureproc.dao.AssetsFurnitureProcRelDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 09:09
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureProcRelService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureProcRelService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureProcRelDao assetsFurnitureProcRelDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureProcRelDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureProcRelDTO> searchAssetsFurnitureProcRelByPage(
			QueryReqBean<AssetsFurnitureProcRelDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureProcRelDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureProcRelDTO> dataList = assetsFurnitureProcRelDao
					.searchAssetsFurnitureProcRelByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureProcRelDTO> queryRespBean = new QueryRespBean<AssetsFurnitureProcRelDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureProcRelByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureProcRelDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureProcRelDTO> searchAssetsFurnitureProcRelByPageOr(
			QueryReqBean<AssetsFurnitureProcRelDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureProcRelDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureProcRelDTO> dataList = assetsFurnitureProcRelDao
					.searchAssetsFurnitureProcRelByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureProcRelDTO> queryRespBean = new QueryRespBean<AssetsFurnitureProcRelDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureProcRelByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureProcRelDTO
	 * @throws Exception
	 */
	public AssetsFurnitureProcRelDTO queryAssetsFurnitureProcRelByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureProcRelDTO dto = assetsFurnitureProcRelDao.findAssetsFurnitureProcRelById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureProcRelByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureProcRelDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureProcRelDTO> queryAssetsFurnitureProcRelByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureProcRelDTO> dto = assetsFurnitureProcRelDao.findAssetsFurnitureProcRelByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureProcRelByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureProcRel(AssetsFurnitureProcRelDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureProcRelDao.insertAssetsFurnitureProcRel(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureProcRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureProcRelList(List<AssetsFurnitureProcRelDTO> dtoList, String pid) throws Exception {
		List<AssetsFurnitureProcRelDTO> beanList = new ArrayList<AssetsFurnitureProcRelDTO>();
		for (AssetsFurnitureProcRelDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setFurId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsFurnitureProcRelDao.insertAssetsFurnitureProcRelList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureProcRelList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureProcRel(List<AssetsFurnitureProcRelDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureProcRelDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setFurId(pid);
				this.insertAssetsFurnitureProcRel(dto);
			} else {
				this.updateAssetsFurnitureProcRel(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureProcRel(AssetsFurnitureProcRelDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureProcRelDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureProcRelDao.updateAssetsFurnitureProcRelAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureProcRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureProcRelSensitive(AssetsFurnitureProcRelDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureProcRelDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureProcRelDao.updateAssetsFurnitureProcRelSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureProcRelSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureProcRelList(List<AssetsFurnitureProcRelDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureProcRelDao.updateAssetsFurnitureProcRelList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureProcRelList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureProcRelById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureProcRelDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureProcRelDao.deleteAssetsFurnitureProcRelById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureProcRelById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureProcRel(AssetsFurnitureProcRelDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureProcRelDao.deleteAssetsFurnitureProcRelById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureProcRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureProcRelByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureProcRelById(id);
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
	public int deleteAssetsFurnitureProcRelList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureProcRelDao.deleteAssetsFurnitureProcRelList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureProcRelList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureProcRelDTO
	 * @throws Exception
	 */
	private AssetsFurnitureProcRelDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureProcRelDTO dto = assetsFurnitureProcRelDao.findAssetsFurnitureProcRelById(id);
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
