package avicit.assets.device.assetsdevicecomponent.service;

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
import avicit.assets.device.assetsdevicecomponent.dao.AssetsDeviceComponentDao;
import avicit.assets.device.assetsdevicecomponent.dto.AssetsDeviceComponentDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-07 11:13
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceComponentService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceComponentService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceComponentDao assetsDeviceComponentDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceComponentDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceComponentDTO> searchAssetsDeviceComponentByPage(
			QueryReqBean<AssetsDeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceComponentDTO> dataList = assetsDeviceComponentDao
					.searchAssetsDeviceComponentByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceComponentDTO> queryRespBean = new QueryRespBean<AssetsDeviceComponentDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceComponentDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceComponentDTO> searchAssetsDeviceComponentByPageOr(
			QueryReqBean<AssetsDeviceComponentDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceComponentDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceComponentDTO> dataList = assetsDeviceComponentDao
					.searchAssetsDeviceComponentByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceComponentDTO> queryRespBean = new QueryRespBean<AssetsDeviceComponentDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceComponentByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceComponent(List<AssetsDeviceComponentDTO> dtos) throws Exception {
		for (AssetsDeviceComponentDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceComponent(dto);
			} else {
				this.updateAssetsDeviceComponent(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceComponent(AssetsDeviceComponentDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceComponentDao.insertAssetsDeviceComponent(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceComponent出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceComponentList(List<AssetsDeviceComponentDTO> dtoList) throws Exception {
		List<AssetsDeviceComponentDTO> beanList = new ArrayList<AssetsDeviceComponentDTO>();
		for (AssetsDeviceComponentDTO dto : dtoList) {
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
			return assetsDeviceComponentDao.insertAssetsDeviceComponentList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceComponent(AssetsDeviceComponentDTO dto) throws Exception {
		//记录日志
		AssetsDeviceComponentDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceComponentDao.updateAssetsDeviceComponentSensitive(old);
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
	public int updateAssetsDeviceComponentList(List<AssetsDeviceComponentDTO> dtoList) throws Exception {
		try {
			return assetsDeviceComponentDao.updateAssetsDeviceComponentList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceComponentList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceComponentById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceComponentDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceComponentDao.deleteAssetsDeviceComponentById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceComponentById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceComponentByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceComponentById(id);
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
	public int deleteAssetsDeviceComponentList(List<String> idList) throws Exception {
		try {
			return assetsDeviceComponentDao.deleteAssetsDeviceComponentList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceComponentList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceComponentDTO
	 * @throws Exception
	 */
	private AssetsDeviceComponentDTO findById(String id) throws Exception {
		try {
			AssetsDeviceComponentDTO dto = assetsDeviceComponentDao.findAssetsDeviceComponentById(id);
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
