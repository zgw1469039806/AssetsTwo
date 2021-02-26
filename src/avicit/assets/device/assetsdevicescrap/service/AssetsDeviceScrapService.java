package avicit.assets.device.assetsdevicescrap.service;

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
import avicit.assets.device.assetsdevicescrap.dto.AssetsDeviceScrapDTO;
import avicit.assets.device.assetsdevicescrap.dao.AssetsDeviceScrapDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-16 17:00
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceScrapService implements Serializable, InstanceDeleteEventListener {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceScrapService.class);

	@Autowired
	private BpmOperateService bpmOperateService;

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceScrapDao assetsDeviceScrapDao;

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
		AssetsDeviceScrapDao assetsDeviceScrapDao = SpringFactory.getBean(AssetsDeviceScrapDao.class);
		assetsDeviceScrapDao.deleteAssetsDeviceScrapById(formId);
	}

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceScrapDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceScrapDTO> searchAssetsDeviceScrapByPage(
			QueryReqBean<AssetsDeviceScrapDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceScrapDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceScrapDTO> dataList = assetsDeviceScrapDao.searchAssetsDeviceScrapByPage(searchParams,
					orderBy);
			QueryRespBean<AssetsDeviceScrapDTO> queryRespBean = new QueryRespBean<AssetsDeviceScrapDTO>();
			for (AssetsDeviceScrapDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceScrapByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceScrapDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceScrapDTO> searchAssetsDeviceScrapByPageOr(
			QueryReqBean<AssetsDeviceScrapDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceScrapDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceScrapDTO> dataList = assetsDeviceScrapDao.searchAssetsDeviceScrapByPageOr(searchParams,
					orderBy);
			QueryRespBean<AssetsDeviceScrapDTO> queryRespBean = new QueryRespBean<AssetsDeviceScrapDTO>();
			for (AssetsDeviceScrapDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceScrapByPage出错：", e);
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
	 * @return List<AssetsDeviceScrapDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceScrapDTO> searchAssetsDeviceScrap(QueryReqBean<AssetsDeviceScrapDTO> queryReqBean)
			throws Exception {
		try {
			AssetsDeviceScrapDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceScrapDTO> dataList = assetsDeviceScrapDao.searchAssetsDeviceScrap(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceScrap出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceScrapDTO
	 * @throws Exception
	 */
	public AssetsDeviceScrapDTO queryAssetsDeviceScrapByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceScrapDTO dto = assetsDeviceScrapDao.findAssetsDeviceScrapById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceScrapByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertAssetsDeviceScrap(AssetsDeviceScrapDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceScrapDao.insertAssetsDeviceScrap(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceScrap出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceScrapList(List<AssetsDeviceScrapDTO> dtoList) throws Exception {
		List<AssetsDeviceScrapDTO> beanList = new ArrayList<AssetsDeviceScrapDTO>();
		for (AssetsDeviceScrapDTO dto : dtoList) {
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
			return assetsDeviceScrapDao.insertAssetsDeviceScrapList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceScrapList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceScrap(AssetsDeviceScrapDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceScrapDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsDeviceScrapDao.updateAssetsDeviceScrapAll(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsDeviceScrap出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceScrapSensitive(AssetsDeviceScrapDTO dto) throws Exception {
		try {
			//记录日志
			AssetsDeviceScrapDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int ret = assetsDeviceScrapDao.updateAssetsDeviceScrapSensitive(old);
			if (ret == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		} catch (Exception e) {
			logger.error("updateAssetsDeviceScrapSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceScrapList(List<AssetsDeviceScrapDTO> dtoList) throws Exception {
		try {
			return assetsDeviceScrapDao.updateAssetsDeviceScrapList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceScrapList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceScrapById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceScrapDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceScrapDao.deleteAssetsDeviceScrapById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceScrapById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceScrapByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsDeviceScrapById(id);
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
	public int deleteAssetsDeviceScrapList(List<String> idList) throws Exception {
		try {
			return assetsDeviceScrapDao.deleteAssetsDeviceScrapList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceScrapList出错：", e);
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsDeviceScrapDTO
	* @throws Exception
	*/
	private AssetsDeviceScrapDTO findById(String id) throws Exception {
		try {
			AssetsDeviceScrapDTO dto = assetsDeviceScrapDao.findAssetsDeviceScrapById(id);
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
	public StartResultBean insertAssetsDeviceScrapAndStartProcess(AssetsDeviceScrapDTO bean,
			Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertAssetsDeviceScrap(bean);
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
