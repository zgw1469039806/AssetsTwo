package avicit.elect.dynelectlog.service;

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
import avicit.elect.dynelectlog.dao.DynElectLogDAO;
import avicit.elect.dynelectlog.dto.DynElectLogDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:36
 * @类说明：选举记录表Service
 * @修改记录： 
 */
@Service
public class DynElectLogService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynElectLogService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynElectLogDAO dynElectLogDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynElectLogDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynElectLogDTO> searchDynElectLogByPage(QueryReqBean<DynElectLogDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynElectLogDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynElectLogDTO> dataList = dynElectLogDAO.searchDynElectLogByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynElectLogDTO> queryRespBean = new QueryRespBean<DynElectLogDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynElectLogByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param searchParams 条件
	* @return List<DynElectLogDTO>
	* @throws Exception
	*/
	public List<DynElectLogDTO> searchDynElectLog(DynElectLogDTO searchParams)
			throws Exception {
		try {
			List<DynElectLogDTO> dataList = dynElectLogDAO.searchDynElectLog(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynElectLog出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectLogDTO
	 * @throws Exception
	 */
	public DynElectLogDTO queryDynElectLogByPrimaryKey(String id) throws Exception {
		try {
			DynElectLogDTO dto = dynElectLogDAO.findDynElectLogById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynElectLogByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynElectLog(DynElectLogDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynElectLogDAO.insertDynElectLog(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynElectLog出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynElectLogList(List<DynElectLogDTO> dtoList) throws Exception {
		try {
			List<DynElectLogDTO> beanList = new ArrayList<DynElectLogDTO>();
			for (DynElectLogDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynElectLogDAO.insertDynElectLogList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynElectLogList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectLogAll(DynElectLogDTO dto) throws Exception {
		try {
			//记录日志
			DynElectLogDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynElectLogDAO.updateDynElectLogAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynElectLogAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectLogSensitive(DynElectLogDTO dto) throws Exception {
		try {
			//记录日志
			DynElectLogDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynElectLogDAO.updateDynElectLogSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynElectLogSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectLogList(List<DynElectLogDTO> dtoList) throws Exception {
		try {
			return dynElectLogDAO.updateDynElectLogList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynElectLogList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectLogById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynElectLogDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynElectLogDAO.deleteDynElectLogById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynElectLogById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectLogByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynElectLogById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynElectLogDTO
	* @throws Exception
	*/
	private DynElectLogDTO findById(String id) throws Exception {
		try {
			DynElectLogDTO dto = dynElectLogDAO.findDynElectLogById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

    public Integer searchByElectId(String electId) {
		return dynElectLogDAO.searchByElectId(electId);
    }
}

