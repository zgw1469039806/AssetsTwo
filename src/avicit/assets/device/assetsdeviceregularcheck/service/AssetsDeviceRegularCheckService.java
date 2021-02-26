package avicit.assets.device.assetsdeviceregularcheck.service;

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
import avicit.assets.device.assetsdeviceregularcheck.dao.AssetsDeviceRegularCheckDao;
import avicit.assets.device.assetsdeviceregularcheck.dto.AssetsDeviceRegularCheckDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-03 15:41
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceRegularCheckService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceRegularCheckService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceRegularCheckDao assetsDeviceRegularCheckDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceRegularCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByPage(
			QueryReqBean<AssetsDeviceRegularCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRegularCheckDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceRegularCheckDTO> dList=assetsDeviceRegularCheckDao.searchAssetsDeviceRegularCheckByList(searchParams, orderBy);
			Page<AssetsDeviceRegularCheckDTO> dataList = assetsDeviceRegularCheckDao
					.searchAssetsDeviceRegularCheckByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRegularCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceRegularCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRegularCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}


	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceRegularCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByPageOr(
			QueryReqBean<AssetsDeviceRegularCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRegularCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceRegularCheckDTO> dataList = assetsDeviceRegularCheckDao
					.searchAssetsDeviceRegularCheckByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRegularCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceRegularCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRegularCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按时间条件查询的分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsDeviceRegularCheckDTO>
	 * @throws Exception
	 */
	public   QueryRespBean<AssetsDeviceRegularCheckDTO> searchAssetsDeviceRegularCheckByPageOrDate(
			QueryReqBean<AssetsDeviceRegularCheckDTO> queryReqBean, String orderBy) throws Exception{
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceRegularCheckDTO searchParams = queryReqBean.getSearchParams();


			Page<AssetsDeviceRegularCheckDTO> dataList = assetsDeviceRegularCheckDao
					.searchAssetsDeviceRegularCheckByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceRegularCheckDTO> queryRespBean = new QueryRespBean<AssetsDeviceRegularCheckDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceRegularCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceRegularCheck(List<AssetsDeviceRegularCheckDTO> dtos) throws Exception {
		for (AssetsDeviceRegularCheckDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceRegularCheck(dto);
			} else {
				this.updateAssetsDeviceRegularCheck(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceRegularCheck(AssetsDeviceRegularCheckDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceRegularCheckDao.insertAssetsDeviceRegularCheck(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceRegularCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceRegularCheckList(List<AssetsDeviceRegularCheckDTO> dtoList) throws Exception {
		List<AssetsDeviceRegularCheckDTO> beanList = new ArrayList<AssetsDeviceRegularCheckDTO>();
		for (AssetsDeviceRegularCheckDTO dto : dtoList) {
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
			return assetsDeviceRegularCheckDao.insertAssetsDeviceRegularCheckList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceRegularCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceRegularCheck(AssetsDeviceRegularCheckDTO dto) throws Exception {
		//记录日志
		AssetsDeviceRegularCheckDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceRegularCheckDao.updateAssetsDeviceRegularCheckSensitive(old);
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
	public int updateAssetsDeviceRegularCheckList(List<AssetsDeviceRegularCheckDTO> dtoList) throws Exception {
		try {
			return assetsDeviceRegularCheckDao.updateAssetsDeviceRegularCheckList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceRegularCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRegularCheckById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceRegularCheckDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceRegularCheckDao.deleteAssetsDeviceRegularCheckById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceRegularCheckById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceRegularCheckByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceRegularCheckById(id);
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
	public int deleteAssetsDeviceRegularCheckList(List<String> idList) throws Exception {
		try {
			return assetsDeviceRegularCheckDao.deleteAssetsDeviceRegularCheckList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceRegularCheckList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceRegularCheckDTO
	 * @throws Exception
	 */
	public  AssetsDeviceRegularCheckDTO findById(String id) throws Exception {
		try {
			AssetsDeviceRegularCheckDTO dto = assetsDeviceRegularCheckDao.findAssetsDeviceRegularCheckById(id);
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
	 * @param assetsDeviceRegularCheckDTO
	 * @return
	 * @throws Exception
	 */
	public  int updateAssetsDeviceRegularCheckAll(AssetsDeviceRegularCheckDTO assetsDeviceRegularCheckDTO) throws  Exception{
		try {
			return assetsDeviceRegularCheckDao.updateAssetsDeviceRegularCheckAll(assetsDeviceRegularCheckDTO);
		}catch (Exception e){
			logger.error("deleteAssetsDeviceRegularCheckList出错：", e);
			throw e;
		}

	}
}
