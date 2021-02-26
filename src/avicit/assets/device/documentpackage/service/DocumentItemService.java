package avicit.assets.device.documentpackage.service;

import java.io.Serializable;
import java.math.BigDecimal;
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
import avicit.assets.device.documentpackage.dto.DocumentItemDTO;
import avicit.assets.device.documentpackage.dao.DocumentItemDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 20:01
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class DocumentItemService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DocumentItemService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DocumentItemDao documentItemDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<DocumentItemDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DocumentItemDTO> searchDocumentItemByPage(QueryReqBean<DocumentItemDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DocumentItemDTO searchParams = queryReqBean.getSearchParams();
			Page<DocumentItemDTO> dataList = documentItemDao.searchDocumentItemByPage(searchParams, orderBy);
			QueryRespBean<DocumentItemDTO> queryRespBean = new QueryRespBean<DocumentItemDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDocumentItemByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<DocumentItemDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DocumentItemDTO> searchDocumentItemByPageOr(QueryReqBean<DocumentItemDTO> queryReqBean,
			String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DocumentItemDTO searchParams = queryReqBean.getSearchParams();
			Page<DocumentItemDTO> dataList = documentItemDao.searchDocumentItemByPageOr(searchParams, orderBy);
			QueryRespBean<DocumentItemDTO> queryRespBean = new QueryRespBean<DocumentItemDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDocumentItemByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return DocumentItemDTO
	 * @throws Exception
	 */
	public DocumentItemDTO queryDocumentItemByPrimaryKey(String id) throws Exception {
		try {
			DocumentItemDTO dto = documentItemDao.findDocumentItemById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryDocumentItemByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<DocumentItemDTO>
	 * @throws Exception
	 */
	public List<DocumentItemDTO> queryDocumentItemByPid(String pid) throws Exception {
		try {
			List<DocumentItemDTO> dto = documentItemDao.findDocumentItemByPid(pid);
			return dto;
		} catch (Exception e) {
			logger.error("queryDocumentItemByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertDocumentItem(DocumentItemDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);

			dto.setClickCount(0L);//点击数
			dto.setLikedCount(0L);//点赞数
			dto.setShareCount(0L);//分享数
			dto.setDownloadCount(0L);//下载数
			dto.setCommentCount(0L);//评论数
			dto.setEvaluateScore(BigDecimal.valueOf(0.0));//打分

			PojoUtil.setSysProperties(dto, OpType.insert);
			documentItemDao.insertDocumentItem(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertDocumentItem出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDocumentItemList(List<DocumentItemDTO> dtoList) throws Exception {
		List<DocumentItemDTO> beanList = new ArrayList<DocumentItemDTO>();
		for (DocumentItemDTO dto : dtoList) {
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
			return documentItemDao.insertDocumentItemList(beanList);
		} catch (Exception e) {
			logger.error("insertDocumentItemList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDocumentItem(DocumentItemDTO dto) throws Exception {
		try {
			//记录日志
			DocumentItemDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = documentItemDao.updateDocumentItemAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateDocumentItem出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDocumentItemSensitive(DocumentItemDTO dto) throws Exception {
		try {
			//记录日志
			DocumentItemDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = documentItemDao.updateDocumentItemSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateDocumentItemSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDocumentItemList(List<DocumentItemDTO> dtoList) throws Exception {
		try {
			return documentItemDao.updateDocumentItemList(dtoList);
		} catch (Exception e) {
			logger.error("updateDocumentItemList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDocumentItemById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			DocumentItemDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return documentItemDao.deleteDocumentItemById(id);
		} catch (Exception e) {
			logger.error("deleteDocumentItemById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteDocumentItem(DocumentItemDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return documentItemDao.deleteDocumentItemById(dto.getId());
		} catch (Exception e) {
			logger.error("deleteDocumentItem出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDocumentItemByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDocumentItemById(id);
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
	public int deleteDocumentItemList(List<String> idList) throws Exception {
		try {
			return documentItemDao.deleteDocumentItemList(idList);
		} catch (Exception e) {
			logger.error("deleteDocumentItemList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return DocumentItemDTO
	 * @throws Exception
	 */
	private DocumentItemDTO findById(String id) throws Exception {
		try {
			DocumentItemDTO dto = documentItemDao.findDocumentItemById(id);
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
