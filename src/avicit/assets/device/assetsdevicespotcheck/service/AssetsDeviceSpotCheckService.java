package avicit.assets.device.assetsdevicespotcheck.service;

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
import avicit.assets.device.assetsdevicespotcheck.dao.AssetsDeviceSpotCheckDao;
import avicit.assets.device.assetsdevicespotcheck.dto.AssetsDeviceSpotCheckDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-03 16:36
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceSpotCheckService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceSpotCheckService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceSpotCheckDao assetsDeviceSpotCheckDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceSpotCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceSpotCheckDTO> searchAssetsDeviceSpotCheckByPage(
			QueryReqBean<AssetsDeviceSpotCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceSpotCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceSpotCheckDTO> dataList = assetsDeviceSpotCheckDao
					.searchAssetsDeviceSpotCheckByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceSpotCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceSpotCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceSpotCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceSpotCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceSpotCheckDTO> searchAssetsDeviceSpotCheckByPageOr(
			QueryReqBean<AssetsDeviceSpotCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceSpotCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceSpotCheckDTO> dataList = assetsDeviceSpotCheckDao
					.searchAssetsDeviceSpotCheckByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceSpotCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceSpotCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceSpotCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceSpotCheck(List<AssetsDeviceSpotCheckDTO> dtos) throws Exception {
		for (AssetsDeviceSpotCheckDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceSpotCheck(dto);
			} else {
				this.updateAssetsDeviceSpotCheck(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceSpotCheck(AssetsDeviceSpotCheckDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceSpotCheckDao.insertAssetsDeviceSpotCheck(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceSpotCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceSpotCheckList(List<AssetsDeviceSpotCheckDTO> dtoList) throws Exception {
		List<AssetsDeviceSpotCheckDTO> beanList = new ArrayList<AssetsDeviceSpotCheckDTO>();
		for (AssetsDeviceSpotCheckDTO dto : dtoList) {
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
			return assetsDeviceSpotCheckDao.insertAssetsDeviceSpotCheckList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceSpotCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceSpotCheck(AssetsDeviceSpotCheckDTO dto) throws Exception {
		//记录日志
		AssetsDeviceSpotCheckDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceSpotCheckDao.updateAssetsDeviceSpotCheckSensitive(old);
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
	public int updateAssetsDeviceSpotCheckList(List<AssetsDeviceSpotCheckDTO> dtoList) throws Exception {
		try {
			return assetsDeviceSpotCheckDao.updateAssetsDeviceSpotCheckList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceSpotCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceSpotCheckById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceSpotCheckDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceSpotCheckDao.deleteAssetsDeviceSpotCheckById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceSpotCheckById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceSpotCheckByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceSpotCheckById(id);
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
	public int deleteAssetsDeviceSpotCheckList(List<String> idList) throws Exception {
		try {
			return assetsDeviceSpotCheckDao.deleteAssetsDeviceSpotCheckList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceSpotCheckList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceSpotCheckDTO
	 * @throws Exception
	 */
	private AssetsDeviceSpotCheckDTO findById(String id) throws Exception {
		try {
			AssetsDeviceSpotCheckDTO dto = assetsDeviceSpotCheckDao.findAssetsDeviceSpotCheckById(id);
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
