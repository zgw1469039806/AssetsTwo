package avicit.assets.lab.assetslabdevice.service;

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
import avicit.assets.lab.assetslabdevice.dao.AssetsLabDeviceDao;
import avicit.assets.lab.assetslabdevice.dto.AssetsLabDeviceDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-24 15:47
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsLabDeviceService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsLabDeviceService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsLabDeviceDao assetsLabDeviceDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsLabDeviceDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsLabDeviceDTO> searchAssetsLabDeviceByPage(QueryReqBean<AssetsLabDeviceDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsLabDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsLabDeviceDTO> dataList = assetsLabDeviceDao.searchAssetsLabDeviceByPage(searchParams, orderBy);
			QueryRespBean<AssetsLabDeviceDTO> queryRespBean = new QueryRespBean<AssetsLabDeviceDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsLabDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsLabDeviceDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsLabDeviceDTO> searchAssetsLabDeviceByPageOr(
			QueryReqBean<AssetsLabDeviceDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsLabDeviceDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsLabDeviceDTO> dataList = assetsLabDeviceDao.searchAssetsLabDeviceByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsLabDeviceDTO> queryRespBean = new QueryRespBean<AssetsLabDeviceDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsLabDeviceByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsLabDevice(List<AssetsLabDeviceDTO> dtos) throws Exception {
		for (AssetsLabDeviceDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsLabDevice(dto);
			} else {
				this.updateAssetsLabDevice(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsLabDevice(AssetsLabDeviceDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsLabDeviceDao.insertAssetsLabDevice(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsLabDevice出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsLabDeviceList(List<AssetsLabDeviceDTO> dtoList) throws Exception {
		List<AssetsLabDeviceDTO> beanList = new ArrayList<AssetsLabDeviceDTO>();
		for (AssetsLabDeviceDTO dto : dtoList) {
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
			return assetsLabDeviceDao.insertAssetsLabDeviceList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsLabDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsLabDevice(AssetsLabDeviceDTO dto) throws Exception {
		//记录日志
		AssetsLabDeviceDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsLabDeviceDao.updateAssetsLabDeviceSensitive(old);
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
	public int updateAssetsLabDeviceList(List<AssetsLabDeviceDTO> dtoList) throws Exception {
		try {
			return assetsLabDeviceDao.updateAssetsLabDeviceList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsLabDeviceList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsLabDeviceById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsLabDeviceDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsLabDeviceDao.deleteAssetsLabDeviceById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsLabDeviceById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsLabDeviceByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsLabDeviceById(id);
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
	public int deleteAssetsLabDeviceList(List<String> idList) throws Exception {
		try {
			return assetsLabDeviceDao.deleteAssetsLabDeviceList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsLabDeviceList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsLabDeviceDTO
	 * @throws Exception
	 */
	private AssetsLabDeviceDTO findById(String id) throws Exception {
		try {
			AssetsLabDeviceDTO dto = assetsLabDeviceDao.findAssetsLabDeviceById(id);
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
