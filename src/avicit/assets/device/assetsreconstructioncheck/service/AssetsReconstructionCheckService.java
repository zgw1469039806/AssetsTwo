package avicit.assets.device.assetsreconstructioncheck.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import org.springframework.util.Assert;

import avicit.platform6.bpm.api.listener.InstanceDeleteEventListener;
import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.bpmreform.bpmbusiness.service.BusinessService;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.assets.device.assetsreconstructioncheck.dto.AssetsReconstructionCheckDTO;
import avicit.assets.device.assetsreconstructioncheck.dao.AssetsReconstructionCheckDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-02 09:07
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsReconstructionCheckService implements Serializable, InstanceDeleteEventListener {

	private static final Logger logger = LoggerFactory.getLogger(AssetsReconstructionCheckService.class);

	@Autowired
	private BpmOperateService bpmOperateService;

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsReconstructionCheckDao assetsReconstructionCheckDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	@Autowired
	private BusinessService businessService;

	/**
	 * 可注册为流程的删除事件
	 * @param processInstanceId 流程实例id
	 * @param executionId 
	 * @param formId 表单id
	 * @throws Exception
	 */
	@Override
	public void notify(String processInstanceId, String executionId, String formId) throws Exception {
		AssetsReconstructionCheckDao assetsReconstructionCheckDao = SpringFactory
				.getBean(AssetsReconstructionCheckDao.class);
		assetsReconstructionCheckDao.deleteAssetsReconstructionCheckById(formId);
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsReconstructionCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheckByPage(
			QueryReqBean<AssetsReconstructionCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsReconstructionCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsReconstructionCheckDTO> dataList = assetsReconstructionCheckDao
					.searchAssetsReconstructionCheckByPage(searchParams, orderBy);
			QueryRespBean<AssetsReconstructionCheckDTO> queryRespBean = new QueryRespBean<AssetsReconstructionCheckDTO>();
			for (AssetsReconstructionCheckDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsReconstructionCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsReconstructionCheckDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheckByPageOr(
			QueryReqBean<AssetsReconstructionCheckDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsReconstructionCheckDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsReconstructionCheckDTO> dataList = assetsReconstructionCheckDao
					.searchAssetsReconstructionCheckByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsReconstructionCheckDTO> queryRespBean = new QueryRespBean<AssetsReconstructionCheckDTO>();
			for (AssetsReconstructionCheckDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsReconstructionCheckByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 流程的编码转换成名称
	* @param stateCode 编码
	* @return String
	*/
	private String processStateCode2StateName(String stateCode) {
		String stateName = "";
		if (stateCode != null && "active".equals(stateCode)) {
			stateName = "流转中";
		} else if (stateCode != null && "ended".equals(stateCode)) {
			stateName = "结束";
		} else if (stateCode != null && "start".equals(stateCode)) {
			stateName = "草稿";
		}
		return stateName;
	}

	/**
	 * 按条件查询，不分页
	 * @param queryReqBean 查询条件
	 * @return List<AssetsReconstructionCheckDTO>
	 * @throws Exception
	 */
	public List<AssetsReconstructionCheckDTO> searchAssetsReconstructionCheck(
			QueryReqBean<AssetsReconstructionCheckDTO> queryReqBean) throws Exception {
		try {
			AssetsReconstructionCheckDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsReconstructionCheckDTO> dataList = assetsReconstructionCheckDao
					.searchAssetsReconstructionCheck(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsReconstructionCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsReconstructionCheckDTO
	 * @throws Exception
	 */
	public AssetsReconstructionCheckDTO queryAssetsReconstructionCheckByPrimaryKey(String id) throws Exception {
		try {
			AssetsReconstructionCheckDTO dto = assetsReconstructionCheckDao.findAssetsReconstructionCheckById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsReconstructionCheckByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsReconstructionCheckDTO>
	 * @throws Exception
	 */
	public List<AssetsReconstructionCheckDTO> queryAssetsReconstructionCheckByPid(String pid) throws Exception {
		try {
			List<AssetsReconstructionCheckDTO> dto = assetsReconstructionCheckDao
					.findAssetsReconstructionCheckByPid(pid);
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsReconstructionCheckByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsReconstructionCheck(AssetsReconstructionCheckDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsReconstructionCheckDao.insertAssetsReconstructionCheck(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsReconstructionCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsReconstructionCheckList(List<AssetsReconstructionCheckDTO> dtoList) throws Exception {
		List<AssetsReconstructionCheckDTO> beanList = new ArrayList<AssetsReconstructionCheckDTO>();
		for (AssetsReconstructionCheckDTO dto : dtoList) {
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
			return assetsReconstructionCheckDao.insertAssetsReconstructionCheckList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsReconstructionCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);


	}}
/**
 * 新增或修改对象
 * @param dtos 对象集合
 * @return void
 * @throws Exception
 */
		public void insertOrUpdateAssetsReconstructionCheck(List<AssetsReconstructionCheckDTO> dtos, String pid)
			throws Exception {
			for (AssetsReconstructionCheckDTO dto : dtos) {
				if ("".equals(dto.getId()) || null == dto.getId()) {
					dto.setAttribute01(pid);
					this.insertAssetsReconstructionCheck(dto);
				} else {
					this.updateAssetsReconstructionCheck(dto);
				}
			}
		}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionCheck(AssetsReconstructionCheckDTO dto) throws Exception {
		try {
			//记录日志
			AssetsReconstructionCheckDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsReconstructionCheckDao.updateAssetsReconstructionCheckAll(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsReconstructionCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionCheckSensitive(AssetsReconstructionCheckDTO dto) throws Exception {
		try {
			//记录日志
			AssetsReconstructionCheckDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsReconstructionCheckDao.updateAssetsReconstructionCheckSensitive(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsReconstructionCheckSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionCheckList(List<AssetsReconstructionCheckDTO> dtoList) throws Exception {
		try {
			return assetsReconstructionCheckDao.updateAssetsReconstructionCheckList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsReconstructionCheckList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionCheckById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsReconstructionCheckDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsReconstructionCheckDao.deleteAssetsReconstructionCheckById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsReconstructionCheckById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	
		/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionCheck(AssetsReconstructionCheckDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsReconstructionCheckDao.deleteAssetsReconstructionCheckById(dto.getId());
		} catch (Exception e) {
			logger.error("deleteAssetsReconstructionCheck出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionCheckByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsReconstructionCheckById(id);
			String flowInstanceId = bpmOperateService.getInstanceIdByFormid(id);
			if (flowInstanceId != null && !"".equals(flowInstanceId)) {
				bpmOperateService.deleteProcessInstanceCascade(flowInstanceId);
			}
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
	public int deleteAssetsReconstructionCheckList(List<String> idList) throws Exception {
		try {
			return assetsReconstructionCheckDao.deleteAssetsReconstructionCheckList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsReconstructionCheckList出错：", e);
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsReconstructionCheckDTO
	* @throws Exception
	*/
	private AssetsReconstructionCheckDTO findById(String id) throws Exception {
		try {
			AssetsReconstructionCheckDTO dto = assetsReconstructionCheckDao.findAssetsReconstructionCheckById(id);
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

	/**
	* 保存表单并启动流程
	* @param bean 表单对象
	* @param parameter 启动流程所需要的参数
	* @return StartResultBean
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public StartResultBean insertAssetsReconstructionCheckAndStartProcess(AssetsReconstructionCheckDTO bean,
			Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertAssetsReconstructionCheck(bean);
		//
		Map<String, Object> variables = new HashMap<String, Object>();
		//web表单传递过来(除表单对象外)的变量，可以为空
		if (jsonString != null && !"".equals(jsonString)) {
			Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String) jsonString);
			variables.putAll(extVariables);
		}
		//把表单对象转换成map,传递给流程变量
		Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
		variables.putAll(pojoMap);
		String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId,
				variables);
		// 返回对象
		return businessService.getStartResultBean(processInstanceId, bean.getId(), userId);
	}
}
