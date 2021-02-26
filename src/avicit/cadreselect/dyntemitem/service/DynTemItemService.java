package avicit.cadreselect.dyntemitem.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.lang.StringUtils;
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
import avicit.cadreselect.dyntemitem.dao.DynTemItemDAO;
import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:54
 * @类说明：DYN_TEM_ITEMService
 * @修改记录： 
 */
@Service
public class DynTemItemService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynTemItemService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynTemItemDAO dynTemItemDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynTemItemDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynTemItemDTO> searchDynTemItemByPage(QueryReqBean<DynTemItemDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynTemItemDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynTemItemDTO> dataList = dynTemItemDAO.searchDynTemItemByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynTemItemDTO> queryRespBean = new QueryRespBean<DynTemItemDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynTemItemByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param queryReqBean 条件
	* @return List<DynTemItemDTO>
	* @throws Exception
	*/
	public List<DynTemItemDTO> searchDynTemItem(DynTemItemDTO searchParams)
			throws Exception {
		try {
			List<DynTemItemDTO> dataList = dynTemItemDAO.searchDynTemItem(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynTemItem出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynTemItemDTO
	 * @throws Exception
	 */
	public DynTemItemDTO queryDynTemItemByPrimaryKey(String id) throws Exception {
		try {
			DynTemItemDTO dto = dynTemItemDAO.findDynTemItemById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynTemItemByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynTemItem(DynTemItemDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynTemItemDAO.insertDynTemItem(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynTemItem出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynTemItemList(List<DynTemItemDTO> dtoList) throws Exception {
		try {
			List<DynTemItemDTO> beanList = new ArrayList<DynTemItemDTO>();
			for (DynTemItemDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynTemItemDAO.insertDynTemItemList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynTemItemList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemItemAll(DynTemItemDTO dto) throws Exception {
		try {
			//记录日志
			DynTemItemDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynTemItemDAO.updateDynTemItemAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemItemAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemItemSensitive(DynTemItemDTO dto) throws Exception {
		try {
			//记录日志
			DynTemItemDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynTemItemDAO.updateDynTemItemSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemItemSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemItemList(List<DynTemItemDTO> dtoList) throws Exception {
		try {
			return dynTemItemDAO.updateDynTemItemList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemItemList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynTemItemById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynTemItemDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynTemItemDAO.deleteDynTemItemById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynTemItemById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynTemItemByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynTemItemById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynTemItemDTO
	* @throws Exception
	*/
	private DynTemItemDTO findById(String id) throws Exception {
		try {
			DynTemItemDTO dto = dynTemItemDAO.findDynTemItemById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}

