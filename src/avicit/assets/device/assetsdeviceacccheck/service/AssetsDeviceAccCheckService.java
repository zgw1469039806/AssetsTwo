package avicit.assets.device.assetsdeviceacccheck.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
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
import avicit.assets.device.assetsdeviceacccheck.dao.AssetsDeviceAccCheckDao;
import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-04 12:51
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceAccCheckService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceAccCheckService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceAccCheckDao assetsDeviceAccCheckDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAccCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAccCheckDTO> searchAssetsDeviceAccCheckByPage(
			QueryReqBean<AssetsDeviceAccCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAccCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAccCheckDTO> dataList = assetsDeviceAccCheckDao
					.searchAssetsDeviceAccCheckByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAccCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceAccCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAccCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAccCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAccCheckDTO> searchAssetsDeviceAccCheckByPageOr(
			QueryReqBean<AssetsDeviceAccCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAccCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAccCheckDTO> dataList = assetsDeviceAccCheckDao
					.searchAssetsDeviceAccCheckByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAccCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceAccCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAccCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceAccCheck(List<AssetsDeviceAccCheckDTO> dtos) throws Exception {
		for (AssetsDeviceAccCheckDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceAccCheck(dto);
			} else {
				this.updateAssetsDeviceAccCheck(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceAccCheck(AssetsDeviceAccCheckDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceAccCheckDao.insertAssetsDeviceAccCheck(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAccCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceAccCheckList(List<AssetsDeviceAccCheckDTO> dtoList) throws Exception {
		List<AssetsDeviceAccCheckDTO> beanList = new ArrayList<AssetsDeviceAccCheckDTO>();
		for (AssetsDeviceAccCheckDTO dto : dtoList) {
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
			return assetsDeviceAccCheckDao.insertAssetsDeviceAccCheckList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAccCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAccCheck(AssetsDeviceAccCheckDTO dto) throws Exception {
		//记录日志
		AssetsDeviceAccCheckDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceAccCheckDao.updateAssetsDeviceAccCheckSensitive(old);
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
	public int updateAssetsDeviceAccCheckList(List<AssetsDeviceAccCheckDTO> dtoList) throws Exception {
		try {
			return assetsDeviceAccCheckDao.updateAssetsDeviceAccCheckList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAccCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAccCheckById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceAccCheckDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceAccCheckDao.deleteAssetsDeviceAccCheckById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAccCheckById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAccCheckByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceAccCheckById(id);
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
	public int deleteAssetsDeviceAccCheckList(List<String> idList) throws Exception {
		try {
			return assetsDeviceAccCheckDao.deleteAssetsDeviceAccCheckList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAccCheckList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceAccCheckDTO
	 * @throws Exception
	 */
	public AssetsDeviceAccCheckDTO findById(String id) throws Exception {
		try {
			AssetsDeviceAccCheckDTO dto = assetsDeviceAccCheckDao.findAssetsDeviceAccCheckById(id);
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
	 * 更新全部对象 设备定检
	 * @param assetsDeviceAccCheckDTO
	 * @return
	 * @throws Exception
	 */
	public  int updateAssetsDeviceAccCheckAll(AssetsDeviceAccCheckDTO assetsDeviceAccCheckDTO) throws  Exception{
		try {
			return assetsDeviceAccCheckDao.updateAssetsDeviceAccCheckAll(assetsDeviceAccCheckDTO);
		}catch (Exception e){
			logger.error("deleteAssetsDeviceRegularCheckList出错：", e);
			throw e;
		}

	}

}
