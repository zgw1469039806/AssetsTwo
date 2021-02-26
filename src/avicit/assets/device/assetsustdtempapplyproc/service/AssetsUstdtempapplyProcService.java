package avicit.assets.device.assetsustdtempapplyproc.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
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
import avicit.assets.device.assetsustdtempapplyproc.dto.AssetsUstdtempapplyProcDTO;
import avicit.assets.device.assetsustdtempapplyproc.dao.AssetsUstdtempapplyProcDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-23 16:56
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsUstdtempapplyProcService implements Serializable, InstanceDeleteEventListener {

	private static final Logger logger = LoggerFactory.getLogger(AssetsUstdtempapplyProcService.class);

	@Autowired
	private BpmOperateService bpmOperateService;

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsUstdtempapplyProcDao assetsUstdtempapplyProcDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private SysAutoCodeAPI sysAutoCodeAPI;

	/**
	 * 可注册为流程的删除事件
	 * @param processInstanceId 流程实例id
	 * @param executionId
	 * @param formId 表单id
	 * @throws Exception
	 */
	@Override
	public void notify(String processInstanceId, String executionId, String formId) throws Exception {
		AssetsUstdtempapplyProcDao assetsUstdtempapplyProcDao = SpringFactory.getBean(AssetsUstdtempapplyProcDao.class);
		assetsUstdtempapplyProcDao.deleteAssetsUstdtempapplyProcById(formId);
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdtempapplyProcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProcByPage(
			QueryReqBean<AssetsUstdtempapplyProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdtempapplyProcDTO> dataList = assetsUstdtempapplyProcDao
					.searchAssetsUstdtempapplyProcByPage(searchParams, orderBy);
			QueryRespBean<AssetsUstdtempapplyProcDTO> queryRespBean = new QueryRespBean<AssetsUstdtempapplyProcDTO>();
			for (AssetsUstdtempapplyProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsUstdtempapplyProcByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdtempapplyProcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProcByPageOr(
			QueryReqBean<AssetsUstdtempapplyProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdtempapplyProcDTO> dataList = assetsUstdtempapplyProcDao
					.searchAssetsUstdtempapplyProcByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsUstdtempapplyProcDTO> queryRespBean = new QueryRespBean<AssetsUstdtempapplyProcDTO>();
			for (AssetsUstdtempapplyProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsUstdtempapplyProcByPage出错：", e);
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
	 * @return List<AssetsUstdtempapplyProcDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdtempapplyProcDTO> searchAssetsUstdtempapplyProc(
			QueryReqBean<AssetsUstdtempapplyProcDTO> queryReqBean) throws Exception {
		try {
			AssetsUstdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsUstdtempapplyProcDTO> dataList = assetsUstdtempapplyProcDao
					.searchAssetsUstdtempapplyProc(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsUstdtempapplyProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsUstdtempapplyProcDTO
	 * @throws Exception
	 */
	public AssetsUstdtempapplyProcDTO queryAssetsUstdtempapplyProcByPrimaryKey(String id) throws Exception {
		try {
			AssetsUstdtempapplyProcDTO dto = assetsUstdtempapplyProcDao.findAssetsUstdtempapplyProcById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsUstdtempapplyProcByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsUstdtempapplyProc(AssetsUstdtempapplyProcDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);

			Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "ASSETS_USTDTEMPAPPLY_PROC", dto.getAutoCodeValue(), dto.getId(), false);

			if(map.get("result").equals("success")){
				dto.setSubscribeNo(map.get("autoCodeValue"));
			}

			assetsUstdtempapplyProcDao.insertAssetsUstdtempapplyProc(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsUstdtempapplyProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsUstdtempapplyProcList(List<AssetsUstdtempapplyProcDTO> dtoList) throws Exception {
		List<AssetsUstdtempapplyProcDTO> beanList = new ArrayList<AssetsUstdtempapplyProcDTO>();
		for (AssetsUstdtempapplyProcDTO dto : dtoList) {
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
			return assetsUstdtempapplyProcDao.insertAssetsUstdtempapplyProcList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsUstdtempapplyProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsUstdtempapplyProc(AssetsUstdtempapplyProcDTO dto) throws Exception {
		try {
			//记录日志
			AssetsUstdtempapplyProcDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsUstdtempapplyProcDao.updateAssetsUstdtempapplyProcAll(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsUstdtempapplyProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsUstdtempapplyProcSensitive(AssetsUstdtempapplyProcDTO dto) throws Exception {
		try {
			//记录日志
			AssetsUstdtempapplyProcDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsUstdtempapplyProcDao.updateAssetsUstdtempapplyProcSensitive(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsUstdtempapplyProcSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsUstdtempapplyProcList(List<AssetsUstdtempapplyProcDTO> dtoList) throws Exception {
		try {
			return assetsUstdtempapplyProcDao.updateAssetsUstdtempapplyProcList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsUstdtempapplyProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsUstdtempapplyProcById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsUstdtempapplyProcDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsUstdtempapplyProcDao.deleteAssetsUstdtempapplyProcById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsUstdtempapplyProcById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsUstdtempapplyProcByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsUstdtempapplyProcById(id);
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
	public int deleteAssetsUstdtempapplyProcList(List<String> idList) throws Exception {
		try {
			return assetsUstdtempapplyProcDao.deleteAssetsUstdtempapplyProcList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsUstdtempapplyProcList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsUstdtempapplyProcDTO
	 * @throws Exception
	 */
	private AssetsUstdtempapplyProcDTO findById(String id) throws Exception {
		try {
			AssetsUstdtempapplyProcDTO dto = assetsUstdtempapplyProcDao.findAssetsUstdtempapplyProcById(id);
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
	public StartResultBean insertAssetsUstdtempapplyProcAndStartProcess(AssetsUstdtempapplyProcDTO bean,
																		Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertAssetsUstdtempapplyProc(bean);
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

	/**
	 * 通过申购单号查询单条记录
	 * @param subscribeNo 申购单号
	 * @return AssetsUstdtempapplyProcDTO
	 * @throws Exception
	 */
	public AssetsUstdtempapplyProcDTO getAssetsUstdtempapplyProcBySubscribeNo(String subscribeNo) throws Exception {
		try {
			List<AssetsUstdtempapplyProcDTO> dataList = assetsUstdtempapplyProcDao.getAssetsUstdtempapplyProcBySubscribeNo(subscribeNo);
			if((dataList != null) && (dataList.size()>0)){
				return dataList.get(0);
			}
			return null;
		} catch (Exception e) {
			logger.error("getAssetsUstdtempapplyProcBySubscribeNo出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
