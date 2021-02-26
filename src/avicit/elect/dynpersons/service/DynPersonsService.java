package avicit.elect.dynpersons.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.assetsattachment.dto.GetPersonDTO;
import avicit.assets.assetsattachment.dto.PersonLogVo;
import avicit.assets.assetsattachment.dto.PersonTotalVo;
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
import avicit.elect.dynpersons.dao.DynPersonsDAO;
import avicit.elect.dynpersons.dto.DynPersonsDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 00:05
 * @类说明：候选人表Service
 * @修改记录： 
 */
@Service
public class DynPersonsService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynPersonsService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynPersonsDAO dynPersonsDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynPersonsDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynPersonsDTO> searchDynPersonsByPage(QueryReqBean<DynPersonsDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynPersonsDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynPersonsDTO> dataList = dynPersonsDAO.searchDynPersonsByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynPersonsDTO> queryRespBean = new QueryRespBean<DynPersonsDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynPersonsByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param searchParams 条件
	* @return List<DynPersonsDTO>
	* @throws Exception
	*/
	public List<DynPersonsDTO> searchDynPersons(DynPersonsDTO searchParams)
			throws Exception {
		try {
			List<DynPersonsDTO>	dataList = dynPersonsDAO.searchDynPersons(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynPersons出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynPersonsDTO
	 * @throws Exception
	 */
	public DynPersonsDTO queryDynPersonsByPrimaryKey(String id) throws Exception {
		try {
			DynPersonsDTO dto = dynPersonsDAO.findDynPersonsById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynPersonsByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynPersons(DynPersonsDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynPersonsDAO.insertDynPersons(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynPersons出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynPersonsList(List<DynPersonsDTO> dtoList) throws Exception {
		try {
			List<DynPersonsDTO> beanList = new ArrayList<DynPersonsDTO>();
			for (DynPersonsDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynPersonsDAO.insertDynPersonsList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynPersonsList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonsAll(DynPersonsDTO dto) throws Exception {
		try {
			//记录日志
			DynPersonsDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynPersonsDAO.updateDynPersonsAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonsAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonsSensitive(DynPersonsDTO dto) throws Exception {
		try {
			//记录日志
			DynPersonsDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynPersonsDAO.updateDynPersonsSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonsSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynPersonsList(List<DynPersonsDTO> dtoList) throws Exception {
		try {
			return dynPersonsDAO.updateDynPersonsList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynPersonsList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynPersonsById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynPersonsDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynPersonsDAO.deleteDynPersonsById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynPersonsById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynPersonsByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynPersonsById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynPersonsDTO
	* @throws Exception
	*/
	private DynPersonsDTO findById(String id) throws Exception {
		try {
			DynPersonsDTO dto = dynPersonsDAO.findDynPersonsById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	public int searchByElectID(String electId) {
		return dynPersonsDAO.searchByElectID(electId);
	}

	/**
	 * 取得候选人投票结果名单
	 *
	 * @param getPersonDTO
	 * @return
	 */
	public List<PersonLogVo> searchDynPersonsBySort(GetPersonDTO getPersonDTO) {
		return dynPersonsDAO.searchDynPersonsBySort(getPersonDTO);
	}

	/**
	 * 取得候选人投票结果名单
	 *
	 * @return
	 */
	public List<PersonTotalVo> searchPersonsTotalGroupByDept() {
		return dynPersonsDAO.searchPersonsTotalGroupByDept();
	}

	/**
	 * 取得候选人投票结果名单
	 *
	 * @return
	 */
	public List<PersonTotalVo> searchPersonsTotalGroupByMajor() {
		return dynPersonsDAO.searchPersonsTotalGroupByMajor();
	}
}

