package avicit.elect.dynnumplate.service;

import java.io.Serializable;
import java.math.BigDecimal;
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
import avicit.elect.dynnumplate.dao.DynNumPlateDAO;
import avicit.elect.dynnumplate.dto.DynNumPlateDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：shiys
 * @邮箱：260289963@qq.com
 * @创建时间： 2021-02-05 09:30
 * @类说明：号码牌表Service
 * @修改记录： 
 */
@Service
public class DynNumPlateService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynNumPlateService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynNumPlateDAO dynNumPlateDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynNumPlateDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynNumPlateDTO> searchDynNumPlateByPage(QueryReqBean<DynNumPlateDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynNumPlateDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynNumPlateDTO> dataList = dynNumPlateDAO.searchDynNumPlateByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynNumPlateDTO> queryRespBean = new QueryRespBean<DynNumPlateDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynNumPlateByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @return List<DynNumPlateDTO>
	* @throws Exception
	*/
	public List<DynNumPlateDTO> searchDynNumPlate(DynNumPlateDTO searchParams) throws Exception {
		try {
			List<DynNumPlateDTO> dataList = dynNumPlateDAO.searchDynNumPlate(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynNumPlate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynNumPlateDTO
	 * @throws Exception
	 */
	public DynNumPlateDTO queryDynNumPlateByPrimaryKey(String id) throws Exception {
		try {
			DynNumPlateDTO dto = dynNumPlateDAO.findDynNumPlateById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynNumPlateByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynNumPlate(DynNumPlateDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynNumPlateDAO.insertDynNumPlate(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynNumPlate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynNumPlateList(List<DynNumPlateDTO> dtoList) throws Exception {
		try {
			List<DynNumPlateDTO> beanList = new ArrayList<DynNumPlateDTO>();
			for (DynNumPlateDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynNumPlateDAO.insertDynNumPlateList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynNumPlateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynNumPlateAll(DynNumPlateDTO dto) throws Exception {
		try {
			//记录日志
			DynNumPlateDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynNumPlateDAO.updateDynNumPlateAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynNumPlateAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynNumPlateSensitive(DynNumPlateDTO dto) throws Exception {
		try {
			//记录日志
			DynNumPlateDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynNumPlateDAO.updateDynNumPlateSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynNumPlateSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynNumPlateList(List<DynNumPlateDTO> dtoList) throws Exception {
		try {
			return dynNumPlateDAO.updateDynNumPlateList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynNumPlateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynNumPlateById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynNumPlateDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynNumPlateDAO.deleteDynNumPlateById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynNumPlateById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynNumPlateByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynNumPlateById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynNumPlateDTO
	* @throws Exception
	*/
	private DynNumPlateDTO findById(String id) throws Exception {
		try {
			DynNumPlateDTO dto = dynNumPlateDAO.findDynNumPlateById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

    public int searchLoginNum(String s) {
		return dynNumPlateDAO.searchLoginNum(s);
    }

	public void updateAllDynNumPlateLoginStatus(String status) {
		try {
			dynNumPlateDAO.updateAllDynNumPlateLoginStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateAllDynNumPlateLoginStatus出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 更新登录状态
	 *
	 * @param id
	 * @param maxCtn
	 * @return
	 * @throws Exception
	 */
	public int updateNumPlateLoginStatus(String id, BigDecimal maxCtn) throws Exception {
		try {
			return dynNumPlateDAO.updateNumPlateLoginStatus(id, maxCtn);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynNumPlateSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}

