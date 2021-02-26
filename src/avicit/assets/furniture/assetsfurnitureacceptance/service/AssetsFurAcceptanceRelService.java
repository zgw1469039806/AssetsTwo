package avicit.assets.furniture.assetsfurnitureacceptance.service;

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
import avicit.assets.furniture.assetsfurnitureacceptance.dto.AssetsFurAcceptanceRelDTO;
import avicit.assets.furniture.assetsfurnitureacceptance.dao.AssetsFurAcceptanceRelDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 08:34
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurAcceptanceRelService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurAcceptanceRelService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurAcceptanceRelDao assetsFurAcceptanceRelDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurAcceptanceRelDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurAcceptanceRelDTO> searchAssetsFurAcceptanceRelByPage(
			QueryReqBean<AssetsFurAcceptanceRelDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurAcceptanceRelDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurAcceptanceRelDTO> dataList = assetsFurAcceptanceRelDao
					.searchAssetsFurAcceptanceRelByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurAcceptanceRelDTO> queryRespBean = new QueryRespBean<AssetsFurAcceptanceRelDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurAcceptanceRelByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurAcceptanceRelDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurAcceptanceRelDTO> searchAssetsFurAcceptanceRelByPageOr(
			QueryReqBean<AssetsFurAcceptanceRelDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurAcceptanceRelDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurAcceptanceRelDTO> dataList = assetsFurAcceptanceRelDao
					.searchAssetsFurAcceptanceRelByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurAcceptanceRelDTO> queryRespBean = new QueryRespBean<AssetsFurAcceptanceRelDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurAcceptanceRelByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurAcceptanceRelDTO
	 * @throws Exception
	 */
	public AssetsFurAcceptanceRelDTO queryAssetsFurAcceptanceRelByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurAcceptanceRelDTO dto = assetsFurAcceptanceRelDao.findAssetsFurAcceptanceRelById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurAcceptanceRelByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurAcceptanceRelDTO>
	 * @throws Exception
	 */
	public List<AssetsFurAcceptanceRelDTO> queryAssetsFurAcceptanceRelByPid(String pid) throws Exception {
		try {
			List<AssetsFurAcceptanceRelDTO> dto = assetsFurAcceptanceRelDao.findAssetsFurAcceptanceRelByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurAcceptanceRelByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurAcceptanceRel(AssetsFurAcceptanceRelDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurAcceptanceRelDao.insertAssetsFurAcceptanceRel(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurAcceptanceRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurAcceptanceRelList(List<AssetsFurAcceptanceRelDTO> dtoList, String pid) throws Exception {
		List<AssetsFurAcceptanceRelDTO> beanList = new ArrayList<AssetsFurAcceptanceRelDTO>();
		for (AssetsFurAcceptanceRelDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setAcceptanceId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsFurAcceptanceRelDao.insertAssetsFurAcceptanceRelList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurAcceptanceRelList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurAcceptanceRel(List<AssetsFurAcceptanceRelDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurAcceptanceRelDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setAcceptanceId(pid);
				this.insertAssetsFurAcceptanceRel(dto);
			} else {
				this.updateAssetsFurAcceptanceRel(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurAcceptanceRel(AssetsFurAcceptanceRelDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurAcceptanceRelDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurAcceptanceRelDao.updateAssetsFurAcceptanceRelAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurAcceptanceRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurAcceptanceRelSensitive(AssetsFurAcceptanceRelDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurAcceptanceRelDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurAcceptanceRelDao.updateAssetsFurAcceptanceRelSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurAcceptanceRelSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurAcceptanceRelList(List<AssetsFurAcceptanceRelDTO> dtoList) throws Exception {
		try {
			return assetsFurAcceptanceRelDao.updateAssetsFurAcceptanceRelList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurAcceptanceRelList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurAcceptanceRelById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurAcceptanceRelDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurAcceptanceRelDao.deleteAssetsFurAcceptanceRelById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurAcceptanceRelById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurAcceptanceRel(AssetsFurAcceptanceRelDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurAcceptanceRelDao.deleteAssetsFurAcceptanceRelById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurAcceptanceRel出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurAcceptanceRelByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurAcceptanceRelById(id);
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
	public int deleteAssetsFurAcceptanceRelList(List<String> idList) throws Exception {
		try {
			return assetsFurAcceptanceRelDao.deleteAssetsFurAcceptanceRelList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurAcceptanceRelList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurAcceptanceRelDTO
	 * @throws Exception
	 */
	private AssetsFurAcceptanceRelDTO findById(String id) throws Exception {
		try {
			AssetsFurAcceptanceRelDTO dto = assetsFurAcceptanceRelDao.findAssetsFurAcceptanceRelById(id);
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
