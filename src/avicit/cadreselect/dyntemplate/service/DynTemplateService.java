package avicit.cadreselect.dyntemplate.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.cadreselect.dyntemplate.dto.*;
import avicit.cadreselect.dynvote.dao.DynVoteDAO;
import avicit.cadreselect.dynvote.dto.QueryVoteByIdDTO;
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
import avicit.cadreselect.dyntemplate.dao.DynTemplateDAO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:56
 * @类说明：模板表Service
 * @修改记录： 
 */
@Service
public class DynTemplateService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(DynTemplateService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private DynTemplateDAO dynTemplateDAO;

	@Autowired
	private DynVoteDAO voteDAO;
	
	/**
	* 查询（分页）
	* @param queryReqBean 分页
	* @param orderBy 排序语句
	* @param keyWord 快速查询条件
	* @return QueryRespBean<DynTemplateDTO>
	* @throws Exception
	*/
	public QueryRespBean<DynTemplateDTO> searchDynTemplateByPage(QueryReqBean<DynTemplateDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynTemplateDTO searchParams = queryReqBean.getSearchParams();
			//表单数据查询
			Page<DynTemplateDTO> dataList = dynTemplateDAO.searchDynTemplateByPage(searchParams, orderBy, keyWord);
			QueryRespBean<DynTemplateDTO> queryRespBean = new QueryRespBean<DynTemplateDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynTemplateByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 查询（不分页）
	* @return List<DynTemplateDTO>
	* @throws Exception
	*/
	public List<DynTemplateDTO> searchDynTemplate(DynTemplateDTO searchParams)
			throws Exception {
		try {
			List<DynTemplateDTO> dataList = dynTemplateDAO.searchDynTemplate(searchParams);
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("searchDynTemplate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}


	/**
	 * 主键查询
	 * @param id 主键id
	 * @return DynTemplateDTO
	 * @throws Exception
	 */
	public DynTemplateDTO queryDynTemplateByPrimaryKey(String id) throws Exception {
		try {
			DynTemplateDTO dto = dynTemplateDAO.findDynTemplateById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("queryDynTemplateByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertDynTemplate(DynTemplateDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynTemplateDAO.insertDynTemplate(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynTemplate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	public void saveDynTem(DynTemplateBO dynTemplateBO) throws Exception
	{
		try {
			dynTemplateDAO.saveDynTemplate(dynTemplateBO);
		}catch (Exception e){
			e.printStackTrace();
			logger.error("insertDynTemplate出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量新增
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynTemplateList(List<DynTemplateDTO> dtoList) throws Exception {
		try {
			List<DynTemplateDTO> beanList = new ArrayList<DynTemplateDTO>();
			for (DynTemplateDTO dto : dtoList) {
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Insert(dto);
				}
				beanList.add(dto);
			}
			return dynTemplateDAO.insertDynTemplateList(beanList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("insertDynTemplateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 全部更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemplateAll(DynTemplateDTO dto) throws Exception {
		try {
			//记录日志
			DynTemplateDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			int count = dynTemplateDAO.updateDynTemplateAll(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemplateAll出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 部分更新
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemplateSensitive(DynTemplateDTO dto) throws Exception {
		try {
			//记录日志
			DynTemplateDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = dynTemplateDAO.updateDynTemplateSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemplateSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynTemplateList(List<DynTemplateDTO> dtoList) throws Exception {
		try {
			return dynTemplateDAO.updateDynTemplateList(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateDynTemplateList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynTemplateById(String id) throws Exception {
		try {
			if (StringUtils.isEmpty(id)) {
				throw new Exception("删除失败！传入的参数主键为null");
			}
			//记录日志
			DynTemplateDTO dto = findById(id);
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return dynTemplateDAO.deleteDynTemplateById(id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteDynTemplateById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynTemplateByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteDynTemplateById(id);
			result++;
		}
		return result;
	}

	/**
	* 日志专用查询
	* @param id 主键id
	* @return DynTemplateDTO
	* @throws Exception
	*/
	private DynTemplateDTO findById(String id) throws Exception {
		try {
			DynTemplateDTO dto = dynTemplateDAO.findDynTemplateById(id);
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	//region

	/**
	 * 查询记录
	 * @return
	 */
	public List<DynRecord> toDeleteDynTemplate() {
		List<DynRecord>  list = dynTemplateDAO.toDeleteDynTemplate();
		return list;
	}

	public QueryDetailsDTO queryDetails(String id) {
		QueryDetailsDTO dto = voteDAO.queryDetails(id);
		return dto;
	}

	public PrintingDTO printing(String id) {
		PrintingDTO dto = voteDAO.printing(id);
		return dto;
	}
	//endregion
}

