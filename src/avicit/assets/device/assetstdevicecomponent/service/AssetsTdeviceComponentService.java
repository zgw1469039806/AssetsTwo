package avicit.assets.device.assetstdevicecomponent.service;

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
import avicit.assets.device.assetstdevicecomponent.dao.AssetsTdeviceComponentDao;
import avicit.assets.device.assetstdevicecomponent.dto.AssetsTdeviceComponentDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 16:26
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTdeviceComponentService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsTdeviceComponentService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTdeviceComponentDao assetsTdeviceComponentDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceComponentDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceComponentDTO> searchAssetsTdeviceComponentByPage(
			QueryReqBean<AssetsTdeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceComponentDTO> dataList = assetsTdeviceComponentDao
					.searchAssetsTdeviceComponentByPage(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceComponentDTO> queryRespBean = new QueryRespBean<AssetsTdeviceComponentDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceComponentDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceComponentDTO> searchAssetsTdeviceComponentByPageOr(
			QueryReqBean<AssetsTdeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceComponentDTO> dataList = assetsTdeviceComponentDao
					.searchAssetsTdeviceComponentByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceComponentDTO> queryRespBean = new QueryRespBean<AssetsTdeviceComponentDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsTdeviceComponent(List<AssetsTdeviceComponentDTO> dtos) throws Exception {
		for (AssetsTdeviceComponentDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsTdeviceComponent(dto);
			} else {
				this.updateAssetsTdeviceComponent(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsTdeviceComponent(AssetsTdeviceComponentDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsTdeviceComponentDao.insertAssetsTdeviceComponent(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceComponent出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTdeviceComponentList(List<AssetsTdeviceComponentDTO> dtoList) throws Exception {
		List<AssetsTdeviceComponentDTO> beanList = new ArrayList<AssetsTdeviceComponentDTO>();
		for (AssetsTdeviceComponentDTO dto : dtoList) {
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
			return assetsTdeviceComponentDao.insertAssetsTdeviceComponentList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTdeviceComponent(AssetsTdeviceComponentDTO dto) throws Exception {
		//记录日志
		AssetsTdeviceComponentDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsTdeviceComponentDao.updateAssetsTdeviceComponentSensitive(old);
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
	public int updateAssetsTdeviceComponentList(List<AssetsTdeviceComponentDTO> dtoList) throws Exception {
		try {
			return assetsTdeviceComponentDao.updateAssetsTdeviceComponentList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsTdeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceComponentById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsTdeviceComponentDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTdeviceComponentDao.deleteAssetsTdeviceComponentById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceComponentById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceComponentByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsTdeviceComponentById(id);
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
	public int deleteAssetsTdeviceComponentList(List<String> idList) throws Exception {
		try {
			return assetsTdeviceComponentDao.deleteAssetsTdeviceComponentList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceComponentList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTdeviceComponentDTO
	 * @throws Exception
	 */
	private AssetsTdeviceComponentDTO findById(String id) throws Exception {
		try {
			AssetsTdeviceComponentDTO dto = assetsTdeviceComponentDao.findAssetsTdeviceComponentById(id);
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

}
