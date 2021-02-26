package avicit.assets.device.documentpackage.service;

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
import avicit.assets.device.documentpackage.dao.DocumentPackageDao;
import avicit.assets.device.documentpackage.dto.DocumentPackageDTO;

import avicit.assets.device.documentpackage.dto.DocumentItemDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 20:01
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class DocumentPackageService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DocumentPackageService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DocumentPackageDao documentPackageDao;
	@Autowired
	private DocumentItemService documentItemServiceSub;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<DocumentPackageDTO>
	* @throws Exception
	*/
	public QueryRespBean<DocumentPackageDTO> searchDocumentPackageByPage(QueryReqBean<DocumentPackageDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DocumentPackageDTO searchParams = queryReqBean.getSearchParams();
			Page<DocumentPackageDTO> dataList = documentPackageDao.searchDocumentPackageByPage(searchParams, orderBy);
			QueryRespBean<DocumentPackageDTO> queryRespBean = new QueryRespBean<DocumentPackageDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDocumentPackageByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<DocumentPackageDTO>
	* @throws Exception
	*/
	public QueryRespBean<DocumentPackageDTO> searchDocumentPackageByPageOr(
			QueryReqBean<DocumentPackageDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DocumentPackageDTO searchParams = queryReqBean.getSearchParams();
			Page<DocumentPackageDTO> dataList = documentPackageDao.searchDocumentPackageByPageOr(searchParams, orderBy);
			QueryRespBean<DocumentPackageDTO> queryRespBean = new QueryRespBean<DocumentPackageDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDocumentPackageByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件查询
	* @param queryReqBean 条件
	* @return List<DocumentPackageDTO>
	* @throws Exception
	*/
	public List<DocumentPackageDTO> searchDocumentPackage(QueryReqBean<DocumentPackageDTO> queryReqBean)
			throws Exception {
		try {
			DocumentPackageDTO searchParams = queryReqBean.getSearchParams();
			List<DocumentPackageDTO> dataList = documentPackageDao.searchDocumentPackage(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchDocumentPackage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return DocumentPackageDTO
	 * @throws Exception
	 */
	public DocumentPackageDTO queryDocumentPackageByPrimaryKey(String id) throws Exception {
		try {
			DocumentPackageDTO dto = documentPackageDao.findDocumentPackageById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryDocumentPackageByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertDocumentPackage(DocumentPackageDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			documentPackageDao.insertDocumentPackage(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertDocumentPackage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDocumentPackageList(List<DocumentPackageDTO> dtoList) throws Exception {
		List<DocumentPackageDTO> beanList = new ArrayList<DocumentPackageDTO>();
		for (DocumentPackageDTO dto : dtoList) {
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
			return documentPackageDao.insertDocumentPackageList(beanList);
		} catch (Exception e) {
			logger.error("insertDocumentPackageList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDocumentPackage(DocumentPackageDTO dto) throws Exception {
		//记录日志
		DocumentPackageDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = documentPackageDao.updateDocumentPackageAll(old);
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
	public int updateDocumentPackageSensitive(DocumentPackageDTO dto) throws Exception {
		//记录日志
		DocumentPackageDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = documentPackageDao.updateDocumentPackageSensitive(old);
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
	public int updateDocumentPackageList(List<DocumentPackageDTO> dtoList) throws Exception {
		try {
			return documentPackageDao.updateDocumentPackageList(dtoList);
		} catch (Exception e) {
			logger.error("updateDocumentPackageList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDocumentPackageById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			DocumentPackageDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for (DocumentItemDTO sub : documentItemServiceSub.queryDocumentItemByPid(obje.getId())) {
				documentItemServiceSub.deleteDocumentItem(sub);
			}
			//删除主表
			return documentPackageDao.deleteDocumentPackageById(id);
		} catch (Exception e) {
			logger.error("deleteDocumentPackageById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDocumentPackageByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDocumentPackageById(id);
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
	public int deleteDocumentPackageList(List<String> idList) throws Exception {
		try {
			return documentPackageDao.deleteDocumentPackageList(idList);
		} catch (Exception e) {
			logger.error("deleteDocumentPackageList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return DocumentPackageDTO
	 * @throws Exception
	 */
	private DocumentPackageDTO findById(String id) throws Exception {
		try {
			DocumentPackageDTO dto = documentPackageDao.findDocumentPackageById(id);
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
