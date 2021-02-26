package avicit.elect.dynelect.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.elect.dynnumplate.dto.DynNumPlateDTO;
import avicit.elect.dynnumplate.service.DynNumPlateService;
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
import avicit.elect.dynelect.dao.DynElectDAO;
import avicit.elect.dynelect.dto.DynElectDTO;
import org.springframework.util.CollectionUtils;
import avicit.elect.dynelectperson.dto.DynElectPersonDTO;
import avicit.elect.dynelectperson.service.DynElectPersonService;
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
public class DynElectService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynElectService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynElectDAO dynElectDAO;
	@Autowired
	private DynNumPlateService dynNumPlateService;
	@Autowired
	private DynElectPersonService dynElectPersonService;

	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynElectDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynElectDTO> searchDynElectByPage(QueryReqBean<DynElectDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynElectDTO searchParams = queryReqBean.getSearchParams();
			Page<DynElectDTO> dataList = dynElectDAO.searchDynElectByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynElectDTO> queryRespBean = new QueryRespBean<DynElectDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchDynElectByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @param queryReqBean 条件
	* @return List<DynElectDTO>
	* @throws Exception
	*/
	public List<DynElectDTO> searchDynElect(QueryReqBean<DynElectDTO> queryReqBean)
			throws Exception {
		try {
			DynElectDTO searchParams = queryReqBean.getSearchParams();
			List<DynElectDTO> dataList = dynElectDAO.searchDynElect(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchDynElect出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynElectDTO
	 * @throws Exception
	 */
	public DynElectDTO queryDynElectByPrimaryKey(String id) throws Exception {
		try {
			DynElectDTO dto = dynElectDAO.findDynElectById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryDynElectByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}


	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynElect(DynElectDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynElectDAO.insertDynElect(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertDynElect出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynElectList(List<DynElectDTO> dtoList) throws Exception {
		List<DynElectDTO> beanList = new ArrayList<DynElectDTO>();
		for (DynElectDTO dto : dtoList) {
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
			return dynElectDAO.insertDynElectList(beanList);
		} catch (Exception e) {
			logger.error("insertDynElectList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectAll(DynElectDTO dto) throws Exception {
		//记录日志
		DynElectDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		int ret = dynElectDAO.updateDynElectAll(dto);
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
	public int updateDynElectSensitive(DynElectDTO dto) throws Exception {
		try {
			//记录日志
			DynElectDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynElectDAO.updateDynElectSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			/*if (dto.getStatus().equals("1")){
				dynNumPlateService.updateAllDynNumPlateLoginStatus("0");
				logger.info("全量清空更新号码牌登录状态未0！");
			}*/
			return count;
		} catch (Exception e) {
			logger.error("updateDynElectSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynElectList(List<DynElectDTO> dtoList) throws Exception {
		try {
			return dynElectDAO.updateDynElectList(dtoList);
		} catch (Exception e) {
			logger.error("updateDynElectList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			DynElectDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynElectDAO.deleteDynElectById(id);
		} catch (Exception e) {
			logger.error("deleteDynElectById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynElectByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynElectById(id);
			// 删除子表数据
			DynElectPersonDTO queryParams = new DynElectPersonDTO();
			queryParams.setElectId(id);
			List<DynElectPersonDTO> list = dynElectPersonService.searchDynElectPerson(queryParams);
			for (DynElectPersonDTO dynElectPersonDTO : list) {
				dynElectPersonService.deleteDynElectPersonById(dynElectPersonDTO.getId());
			}
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynElectDTO
	* @throws Exception
	*/
	private DynElectDTO findById(String id) throws Exception {
		try {
			DynElectDTO dto = dynElectDAO.findDynElectById(id);
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 實投數
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int updateDynElectInvestNum(String id) throws Exception {
		try {
			int count = dynElectDAO.updateDynElectInvestNum(id);
			return count;
		} catch (Exception e) {
			logger.error("updateDynElectInvestNum：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 取得当前活动信息
	 *
	 * @return
	 */
	public DynElectDTO getCurrentElectDTO() {
		try {
			List<DynElectDTO> dynElectDTOS = dynElectDAO.getCurrentElectDTO();
			if (dynElectDTOS == null || dynElectDTOS.isEmpty()) {
				return null;
			}
			return dynElectDTOS.get(0);
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 取得当前活动信息
	 *
	 * @return
	 */
	public DynElectDTO getLastElectDTO() {
		try {
			List<DynElectDTO> dynElectDTOS = dynElectDAO.getCurrentElectDTO();
			if (dynElectDTOS == null || dynElectDTOS.isEmpty()) {
				return null;
			}
			if (dynElectDTOS.size() <= 1) {
				return null;
			}
			return dynElectDTOS.get(1);
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	public List<DynElectDTO> searchDynElectByStatus() {
		List<DynElectDTO> list=dynElectDAO.searchDynElectByStatus();
		return list;
	}
}

