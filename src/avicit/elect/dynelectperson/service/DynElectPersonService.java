package avicit.elect.dynelectperson.service;

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
import avicit.elect.dynelectperson.dao.DynElectPersonDAO;
import avicit.elect.dynelectperson.dto.DynElectPersonDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:18
 * @类说明：
 * @修改记录： 
 */
@Service
public class DynElectPersonService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynElectPersonService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynElectPersonDAO dynElectPersonDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynElectPersonDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynElectPersonDTO> searchDynElectPersonByPage(QueryReqBean<DynElectPersonDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynElectPersonDTO searchParams = queryReqBean.getSearchParams();
			Page<DynElectPersonDTO> dataList = dynElectPersonDAO.searchDynElectPersonByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynElectPersonDTO> queryRespBean = new QueryRespBean<DynElectPersonDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDynElectPersonByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param queryReqBean 条件
	* @return List<DynElectPersonDTO>
	* @throws Exception
	*/
	public List<DynElectPersonDTO> searchDynElectPerson(DynElectPersonDTO searchParams)
			throws Exception {
		try {
			List<DynElectPersonDTO> dataList = dynElectPersonDAO.searchDynElectPerson(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchDynElectPerson出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectPersonDTO
	 * @throws Exception
	 */
	public DynElectPersonDTO queryDynElectPersonByPrimaryKey(String id) throws Exception {
		try {
			DynElectPersonDTO dto = dynElectPersonDAO.findDynElectPersonById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryDynElectPersonByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynElectPerson(DynElectPersonDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynElectPersonDAO.insertDynElectPerson(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertDynElectPerson出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynElectPersonList(List<DynElectPersonDTO> dtoList) throws Exception {
		List<DynElectPersonDTO> beanList = new ArrayList<DynElectPersonDTO>();
		for (DynElectPersonDTO dto : dtoList) {
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
			return dynElectPersonDAO.insertDynElectPersonList(beanList);
		} catch (Exception e) {
			logger.error("insertDynElectPersonList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectPersonAll(DynElectPersonDTO dto) throws Exception {
		//记录日志
		DynElectPersonDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		int ret = dynElectPersonDAO.updateDynElectPersonAll(dto);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectPersonSensitive(DynElectPersonDTO dto) throws Exception {
		try {
			//记录日志
			DynElectPersonDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynElectPersonDAO.updateDynElectPersonSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateDynElectPersonSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectPersonList(List<DynElectPersonDTO> dtoList) throws Exception {
		try {
			return dynElectPersonDAO.updateDynElectPersonList(dtoList);
		} catch (Exception e) {
			logger.error("updateDynElectPersonList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectPersonById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			DynElectPersonDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynElectPersonDAO.deleteDynElectPersonById(id);
		} catch (Exception e) {
			logger.error("deleteDynElectPersonById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectPersonByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynElectPersonById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynElectPersonDTO
	* @throws Exception
	*/
	private DynElectPersonDTO findById(String id) throws Exception {
		try {
			DynElectPersonDTO dto = dynElectPersonDAO.findDynElectPersonById(id);
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	public int queryEPNum() {
		return dynElectPersonDAO.queryEPNum();
	}

	/**
	 * 通过活动ID取得当前候选人
	 *
	 * @param electId
	 * @return
	 */
	public List<DynElectPersonDTO> getElectPersonByElectId(String electId) {
		return dynElectPersonDAO.getElectPersonByElectId(electId);
	}
}

