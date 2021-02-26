package avicit.assets.device.assetsoperationcertificate.service;

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
import avicit.assets.device.assetsoperationcertificate.dao.AssetsOperationCertificateDao;
import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationCertificateDTO;

import avicit.assets.device.assetsoperationcertificate.dto.AssetsOperationDeviceDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 14:05
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsOperationCertificateService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsOperationCertificateService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsOperationCertificateDao assetsOperationCertificateDao;
	@Autowired
	private AssetsOperationDeviceService assetsOperationDeviceServiceSub;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsOperationCertificateDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsOperationCertificateDTO> searchAssetsOperationCertificateByPage(
			QueryReqBean<AssetsOperationCertificateDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsOperationCertificateDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsOperationCertificateDTO> dataList = assetsOperationCertificateDao
					.searchAssetsOperationCertificateByPage(searchParams, orderBy);
			QueryRespBean<AssetsOperationCertificateDTO> queryRespBean = new QueryRespBean<AssetsOperationCertificateDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsOperationCertificateByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsOperationCertificateDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsOperationCertificateDTO> searchAssetsOperationCertificateByPageOr(
			QueryReqBean<AssetsOperationCertificateDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsOperationCertificateDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsOperationCertificateDTO> dataList = assetsOperationCertificateDao
					.searchAssetsOperationCertificateByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsOperationCertificateDTO> queryRespBean = new QueryRespBean<AssetsOperationCertificateDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsOperationCertificateByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件查询
	* @param queryReqBean 条件
	* @return List<AssetsOperationCertificateDTO>
	* @throws Exception
	*/
	public List<AssetsOperationCertificateDTO> searchAssetsOperationCertificate(
			QueryReqBean<AssetsOperationCertificateDTO> queryReqBean) throws Exception {
		try {
			AssetsOperationCertificateDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsOperationCertificateDTO> dataList = assetsOperationCertificateDao
					.searchAssetsOperationCertificate(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsOperationCertificate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsOperationCertificateDTO
	 * @throws Exception
	 */
	public AssetsOperationCertificateDTO queryAssetsOperationCertificateByPrimaryKey(String id) throws Exception {
		try {
			AssetsOperationCertificateDTO dto = assetsOperationCertificateDao.findAssetsOperationCertificateById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsOperationCertificateByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsOperationCertificate(AssetsOperationCertificateDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsOperationCertificateDao.insertAssetsOperationCertificate(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsOperationCertificate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsOperationCertificateList(List<AssetsOperationCertificateDTO> dtoList) throws Exception {
		List<AssetsOperationCertificateDTO> beanList = new ArrayList<AssetsOperationCertificateDTO>();
		for (AssetsOperationCertificateDTO dto : dtoList) {
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
			return assetsOperationCertificateDao.insertAssetsOperationCertificateList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsOperationCertificateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationCertificate(AssetsOperationCertificateDTO dto) throws Exception {
		//记录日志
		AssetsOperationCertificateDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsOperationCertificateDao.updateAssetsOperationCertificateAll(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationCertificateSensitive(AssetsOperationCertificateDTO dto) throws Exception {
		//记录日志
		AssetsOperationCertificateDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsOperationCertificateDao.updateAssetsOperationCertificateSensitive(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsOperationCertificateList(List<AssetsOperationCertificateDTO> dtoList) throws Exception {
		try {
			return assetsOperationCertificateDao.updateAssetsOperationCertificateList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsOperationCertificateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsOperationCertificateById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsOperationCertificateDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for (AssetsOperationDeviceDTO sub : assetsOperationDeviceServiceSub
					.queryAssetsOperationDeviceByPid(obje.getId())) {
				assetsOperationDeviceServiceSub.deleteAssetsOperationDevice(sub);
			}
			//删除主表
			return assetsOperationCertificateDao.deleteAssetsOperationCertificateById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsOperationCertificateById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsOperationCertificateByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsOperationCertificateById(id);
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
	public int deleteAssetsOperationCertificateList(List<String> idList) throws Exception {
		try {
			return assetsOperationCertificateDao.deleteAssetsOperationCertificateList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsOperationCertificateList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsOperationCertificateDTO
	 * @throws Exception
	 */
	private AssetsOperationCertificateDTO findById(String id) throws Exception {
		try {
			AssetsOperationCertificateDTO dto = assetsOperationCertificateDao.findAssetsOperationCertificateById(id);
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
