package avicit.assets.device.assetstechtransformproject.service;

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
import avicit.assets.device.assetstechtransformproject.dto.AssetsTechTransformDeviceDTO;
import avicit.assets.device.assetstechtransformproject.dao.AssetsTechTransformDeviceDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 09:54
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTechTransformDeviceService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsTechTransformDeviceService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTechTransformDeviceDao assetsTechTransformDeviceDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsTechTransformDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsTechTransformDeviceDTO> searchAssetsTechTransformDeviceByPage(QueryReqBean<AssetsTechTransformDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTechTransformDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTechTransformDeviceDTO> dataList = assetsTechTransformDeviceDao
					.searchAssetsTechTransformDeviceByPage(searchParams, orderBy);
			QueryRespBean<AssetsTechTransformDeviceDTO> queryRespBean = new QueryRespBean<AssetsTechTransformDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsTechTransformDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsTechTransformDeviceDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsTechTransformDeviceDTO> searchAssetsTechTransformDeviceByPageOr(QueryReqBean<AssetsTechTransformDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTechTransformDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTechTransformDeviceDTO> dataList = assetsTechTransformDeviceDao.searchAssetsTechTransformDeviceByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTechTransformDeviceDTO> queryRespBean = new QueryRespBean<AssetsTechTransformDeviceDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsTechTransformDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsTechTransformDeviceDTO
	 * @throws Exception
	 */
	public AssetsTechTransformDeviceDTO queryAssetsTechTransformDeviceByPrimaryKey(String id) throws Exception {
		try {
			AssetsTechTransformDeviceDTO dto = assetsTechTransformDeviceDao.findAssetsTechTransformDeviceById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsTechTransformDeviceByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param projectId 技改项目id
	 * @return List<AssetsTechTransformDeviceDTO>
	 * @throws Exception
	 */
	public List<AssetsTechTransformDeviceDTO> queryAssetsTechTransformDeviceByProjectId(String projectId) throws Exception {
		try {
			List<AssetsTechTransformDeviceDTO> dto = assetsTechTransformDeviceDao.findAssetsTechTransformDeviceByProjectId(projectId);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsTechTransformDeviceByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsTechTransformDevice(AssetsTechTransformDeviceDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);

			//设置treePath
			if((dto.getTreePath() == null) || ("".equals(dto.getTreePath()))){
				dto.setTreePath(dto.getId());
			}
			else{
				dto.setTreePath(dto.getTreePath() + "," + dto.getId());
			}

			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsTechTransformDeviceDao.insertAssetsTechTransformDevice(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsTechTransformDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTechTransformDeviceList(List<AssetsTechTransformDeviceDTO> dtoList, String pid)
			throws Exception {
		List<AssetsTechTransformDeviceDTO> beanList = new ArrayList<AssetsTechTransformDeviceDTO>();
		for (AssetsTechTransformDeviceDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setProjectId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsTechTransformDeviceDao.insertAssetsTechTransformDeviceList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsTechTransformDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsTechTransformDevice(List<AssetsTechTransformDeviceDTO> dtos, String pid)
			throws Exception {
		for (AssetsTechTransformDeviceDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setProjectId(pid);
				this.insertAssetsTechTransformDevice(dto);
			} else {
				this.updateAssetsTechTransformDevice(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTechTransformDevice(AssetsTechTransformDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTechTransformDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsTechTransformDeviceDao.updateAssetsTechTransformDeviceAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsTechTransformDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTechTransformDeviceSensitive(AssetsTechTransformDeviceDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTechTransformDeviceDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsTechTransformDeviceDao.updateAssetsTechTransformDeviceSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsTechTransformDeviceSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTechTransformDeviceList(List<AssetsTechTransformDeviceDTO> dtoList) throws Exception {
		try {
			return assetsTechTransformDeviceDao.updateAssetsTechTransformDeviceList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsTechTransformDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTechTransformDeviceById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsTechTransformDeviceDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}

			//排序号在被删除设备排序号之后的设备排序号自减1
			reduceAssetsTechTransformDeviceSn(obje.getDeviceSn(), obje.getProjectId());

			return assetsTechTransformDeviceDao.deleteAssetsTechTransformDeviceById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTechTransformDeviceById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTechTransformDevice(AssetsTechTransformDeviceDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsTechTransformDeviceDao.deleteAssetsTechTransformDeviceById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTechTransformDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTechTransformDeviceByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsTechTransformDeviceById(id);
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
	public int deleteAssetsTechTransformDeviceList(List<String> idList) throws Exception {
		try {
			return assetsTechTransformDeviceDao.deleteAssetsTechTransformDeviceList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTechTransformDeviceList出错：", e);
			throw e;
		}
	}

	/**
	 * 根据父设备id获取该设备下的所有直系子设备
	 * @param pId 父设备id
	 * @return List<AssetsTechTransformDeviceDTO>
	 * @throws Exception
	 */
	public List<AssetsTechTransformDeviceDTO> getChildsTechTransformDeviceByPid(String pId) throws Exception {
		try {
			List<AssetsTechTransformDeviceDTO> dtoList = assetsTechTransformDeviceDao.findAssetsTechTransformDevicesByPid(pId);
			return dtoList;
		} catch (Exception e) {
			LOGGER.error("getChildsTechTransformDeviceByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 根据父设备id获取该设备下的最后一个直系子设备
	 * @param pId 父设备id
	 * @return AssetsTechTransformDeviceDTO
	 * @throws Exception
	 */
	public AssetsTechTransformDeviceDTO getLastChildTechTransformDeviceByPid(String pId) throws Exception {
		try {
			List<AssetsTechTransformDeviceDTO> dtoList = assetsTechTransformDeviceDao.findAssetsTechTransformDevicesByPid(pId);

			if((dtoList != null) && (dtoList.size()>0)){
				return dtoList.get(0);
			}
			return null;
		} catch (Exception e) {
			LOGGER.error("getLastChildTechTransformDeviceByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 根据treePath获取该路径下的排序号最大的排序号
	 * @param treePath 设备treePath
	 * @return AssetsTechTransformDeviceDTO
	 * @throws Exception
	 */
	public Long getMaxSnByTreepath(String treePath, String projectId) throws Exception {
		try {
			List<AssetsTechTransformDeviceDTO> dtoList = assetsTechTransformDeviceDao.findAssetsTechTransformDevicesByTreepath(treePath, projectId);

			if((dtoList != null) && (dtoList.size()>0)){
				return dtoList.get(0).getDeviceSn();
			}
			return -1L;
		} catch (Exception e) {
			LOGGER.error("getMaxSnByTreepath出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 技改项目projectId所属设备中所有大于startSn的排序号自增2
	 *
	 * @param startSn 起始更新排序号
	 * @return int
	 */
	public int increaseAssetsTechTransformDeviceSn(Long startSn, String projectId) throws Exception {
		try {
			int result = assetsTechTransformDeviceDao.increaseAssetsTechTransformDeviceSn(startSn, projectId);
			return result;
		} catch (Exception e) {
			LOGGER.error("increaseAssetsTechTransformDeviceSn出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 技改项目projectId所属设备中所有大于startSn的排序号自减1
	 *
	 * @param startSn 起始更新排序号
	 * @return int
	 */
	public int reduceAssetsTechTransformDeviceSn(Long startSn, String projectId) throws Exception {
		try {
			int result = assetsTechTransformDeviceDao.reduceAssetsTechTransformDeviceSn(startSn, projectId);
			return result;
		} catch (Exception e) {
			LOGGER.error("reduceAssetsTechTransformDeviceSn出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTechTransformDeviceDTO
	 * @throws Exception
	 */
	private AssetsTechTransformDeviceDTO findById(String id) throws Exception {
		try {
			AssetsTechTransformDeviceDTO dto = assetsTechTransformDeviceDao.findAssetsTechTransformDeviceById(id);
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

	/**
	 * 按技改项目id删除 ASSETS_TECH_TRANSFORM_DEVICE
	 * @param projectId 技改项目id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTechTransformDeviceByProjectId(String projectId) throws Exception {
		if (StringUtils.isEmpty(projectId)) {
			throw new Exception("删除失败！传入的技改项目id为null");
		}
		try {
			return assetsTechTransformDeviceDao.deleteAssetsTechTransformDeviceByProjectId(projectId);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsTechTransformDeviceByProjectId出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
