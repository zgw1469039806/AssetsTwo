package avicit.assets.furniture.assetsfurniturerepairproc.service;

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
import avicit.assets.furniture.assetsfurniturerepairproc.dto.AssetsFurnitureRepairSubDTO;
import avicit.assets.furniture.assetsfurniturerepairproc.dao.AssetsFurnitureRepairSubDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-19 09:30
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsFurnitureRepairSubService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsFurnitureRepairSubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureRepairSubDao assetsFurnitureRepairSubDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureRepairSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureRepairSubDTO> searchAssetsFurnitureRepairSubByPage(
			QueryReqBean<AssetsFurnitureRepairSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureRepairSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureRepairSubDTO> dataList = assetsFurnitureRepairSubDao
					.searchAssetsFurnitureRepairSubByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureRepairSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureRepairSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureRepairSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsFurnitureRepairSubDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsFurnitureRepairSubDTO> searchAssetsFurnitureRepairSubByPageOr(
			QueryReqBean<AssetsFurnitureRepairSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureRepairSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureRepairSubDTO> dataList = assetsFurnitureRepairSubDao
					.searchAssetsFurnitureRepairSubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureRepairSubDTO> queryRespBean = new QueryRespBean<AssetsFurnitureRepairSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsFurnitureRepairSubByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureRepairSubDTO
	 * @throws Exception
	 */
	public AssetsFurnitureRepairSubDTO queryAssetsFurnitureRepairSubByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureRepairSubDTO dto = assetsFurnitureRepairSubDao.findAssetsFurnitureRepairSubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureRepairSubByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsFurnitureRepairSubDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureRepairSubDTO> queryAssetsFurnitureRepairSubByPid(String pid) throws Exception {
		try {
			List<AssetsFurnitureRepairSubDTO> dto = assetsFurnitureRepairSubDao.findAssetsFurnitureRepairSubByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsFurnitureRepairSubByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureRepairSub(AssetsFurnitureRepairSubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureRepairSubDao.insertAssetsFurnitureRepairSub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureRepairSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureRepairSubList(List<AssetsFurnitureRepairSubDTO> dtoList, String pid)
			throws Exception {
		List<AssetsFurnitureRepairSubDTO> beanList = new ArrayList<AssetsFurnitureRepairSubDTO>();
		for (AssetsFurnitureRepairSubDTO dto : dtoList) {
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
			return assetsFurnitureRepairSubDao.insertAssetsFurnitureRepairSubList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsFurnitureRepairSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsFurnitureRepairSub(List<AssetsFurnitureRepairSubDTO> dtos, String pid)
			throws Exception {
		for (AssetsFurnitureRepairSubDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setParentId(pid);
				this.insertAssetsFurnitureRepairSub(dto);
			} else {
				this.updateAssetsFurnitureRepairSub(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRepairSub(AssetsFurnitureRepairSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureRepairSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureRepairSubDao.updateAssetsFurnitureRepairSubAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRepairSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRepairSubSensitive(AssetsFurnitureRepairSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureRepairSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureRepairSubDao.updateAssetsFurnitureRepairSubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRepairSubSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureRepairSubList(List<AssetsFurnitureRepairSubDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureRepairSubDao.updateAssetsFurnitureRepairSubList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsFurnitureRepairSubList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRepairSubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureRepairSubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureRepairSubDao.deleteAssetsFurnitureRepairSubById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRepairSubById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRepairSub(AssetsFurnitureRepairSubDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsFurnitureRepairSubDao.deleteAssetsFurnitureRepairSubById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRepairSub出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureRepairSubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsFurnitureRepairSubById(id);
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
	public int deleteAssetsFurnitureRepairSubList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureRepairSubDao.deleteAssetsFurnitureRepairSubList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsFurnitureRepairSubList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsFurnitureRepairSubDTO
	 * @throws Exception
	 */
	private AssetsFurnitureRepairSubDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureRepairSubDTO dto = assetsFurnitureRepairSubDao.findAssetsFurnitureRepairSubById(id);
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
