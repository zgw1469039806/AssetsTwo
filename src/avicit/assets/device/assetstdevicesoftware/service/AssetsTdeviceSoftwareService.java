package avicit.assets.device.assetstdevicesoftware.service;

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
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetstdevicesoftware.dao.AssetsTdeviceSoftwareDao;
import avicit.assets.device.assetstdevicesoftware.dto.AssetsTdeviceSoftwareDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 17:24
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTdeviceSoftwareService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsTdeviceSoftwareService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTdeviceSoftwareDao assetsTdeviceSoftwareDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceSoftwareDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceSoftwareDTO> searchAssetsTdeviceSoftwareByPage(
			QueryReqBean<AssetsTdeviceSoftwareDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceSoftwareDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceSoftwareDTO> dataList = assetsTdeviceSoftwareDao
					.searchAssetsTdeviceSoftwareByPage(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceSoftwareDTO> queryRespBean = new QueryRespBean<AssetsTdeviceSoftwareDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceSoftwareByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceSoftwareDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceSoftwareDTO> searchAssetsTdeviceSoftwareByPageOr(
			QueryReqBean<AssetsTdeviceSoftwareDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceSoftwareDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceSoftwareDTO> dataList = assetsTdeviceSoftwareDao
					.searchAssetsTdeviceSoftwareByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceSoftwareDTO> queryRespBean = new QueryRespBean<AssetsTdeviceSoftwareDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceSoftwareByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsTdeviceSoftware(List<AssetsTdeviceSoftwareDTO> dtos) throws Exception {
		for (AssetsTdeviceSoftwareDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsTdeviceSoftware(dto);
			} else {
				this.updateAssetsTdeviceSoftware(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsTdeviceSoftware(AssetsTdeviceSoftwareDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsTdeviceSoftwareDao.insertAssetsTdeviceSoftware(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceSoftware出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTdeviceSoftwareList(List<AssetsTdeviceSoftwareDTO> dtoList) throws Exception {
		List<AssetsTdeviceSoftwareDTO> beanList = new ArrayList<AssetsTdeviceSoftwareDTO>();
		for (AssetsTdeviceSoftwareDTO dto : dtoList) {
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
			return assetsTdeviceSoftwareDao.insertAssetsTdeviceSoftwareList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceSoftwareList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTdeviceSoftware(AssetsTdeviceSoftwareDTO dto) throws Exception {
		//记录日志
		AssetsTdeviceSoftwareDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsTdeviceSoftwareDao.updateAssetsTdeviceSoftwareSensitive(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTdeviceSoftwareList(List<AssetsTdeviceSoftwareDTO> dtoList) throws Exception {
		try {
			return assetsTdeviceSoftwareDao.updateAssetsTdeviceSoftwareList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsTdeviceSoftwareList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceSoftwareById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsTdeviceSoftwareDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTdeviceSoftwareDao.deleteAssetsTdeviceSoftwareById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceSoftwareById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceSoftwareByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsTdeviceSoftwareById(id);
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
	public int deleteAssetsTdeviceSoftwareList(List<String> idList) throws Exception {
		try {
			return assetsTdeviceSoftwareDao.deleteAssetsTdeviceSoftwareList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceSoftwareList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTdeviceSoftwareDTO
	 * @throws Exception
	 */
	public AssetsTdeviceSoftwareDTO findById(String id) throws Exception {
		try {
			AssetsTdeviceSoftwareDTO dto = assetsTdeviceSoftwareDao.findAssetsTdeviceSoftwareById(id);
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

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTdeviceSoftwareDTO
	 * @throws Exception
	 */
	public List<AssetsTdeviceSoftwareDTO> findByUnifiedId(String id) throws Exception {
		try {
			List<AssetsTdeviceSoftwareDTO> dtos = assetsTdeviceSoftwareDao.findAssetsTdeviceSoftwareByUnifiedId(id);
			for(AssetsTdeviceSoftwareDTO dto : dtos) {
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Query(dto);
				}
			}
			return dtos;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

}
