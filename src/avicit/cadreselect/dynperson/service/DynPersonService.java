package avicit.cadreselect.dynperson.service;

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
import avicit.cadreselect.dynperson.dao.DynPersonDAO;
import avicit.cadreselect.dynperson.dto.DynPersonDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 11:44
 * @类说明：DYN_PERSONService
 * @修改记录： 
 */
@Service
public class DynPersonService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynPersonService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynPersonDAO dynPersonDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynPersonDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynPersonDTO> searchDynPersonByPage(QueryReqBean<DynPersonDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynPersonDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynPersonDTO> dataList = dynPersonDAO.searchDynPersonByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynPersonDTO> queryRespBean = new QueryRespBean<DynPersonDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynPersonByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param queryReqBean 条件
	* @return List<DynPersonDTO>
	* @throws Exception
	*/
	public List<DynPersonDTO> searchDynPerson(DynPersonDTO searchParams)
			throws Exception {
		try {
			List<DynPersonDTO> dataList = dynPersonDAO.searchDynPerson(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynPerson出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynPersonDTO
	 * @throws Exception
	 */
	public DynPersonDTO queryDynPersonByPrimaryKey(String id) throws Exception {
		try {
			DynPersonDTO dto = dynPersonDAO.findDynPersonById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynPersonByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynPerson(DynPersonDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynPersonDAO.insertDynPerson(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynPerson出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynPersonList(List<DynPersonDTO> dtoList) throws Exception {
		try {
			List<DynPersonDTO> beanList = new ArrayList<DynPersonDTO>();
			for (DynPersonDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynPersonDAO.insertDynPersonList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynPersonList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonAll(DynPersonDTO dto) throws Exception {
		try {
			//记录日志
			DynPersonDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynPersonDAO.updateDynPersonAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonSensitive(DynPersonDTO dto) throws Exception {
		try {
			//记录日志
			DynPersonDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynPersonDAO.updateDynPersonSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonList(List<DynPersonDTO> dtoList) throws Exception {
		try {
			return dynPersonDAO.updateDynPersonList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynPersonById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynPersonDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynPersonDAO.deleteDynPersonById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynPersonById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynPersonByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynPersonById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynPersonDTO
	* @throws Exception
	*/
	private DynPersonDTO findById(String id) throws Exception {
		try {
			DynPersonDTO dto = dynPersonDAO.findDynPersonById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}

