package avicit.assets.device.assetsdevicemcheckproc.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.bpmreform.bpmbusiness.dto.StartResultBean;
import avicit.platform6.bpmreform.bpmbusiness.service.BusinessService;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsdevicemcheckproc.dao.AssetsDeviceMcheckProcDao;
import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckProcDTO;

import avicit.assets.device.assetsdevicemcheckproc.dto.AssetsDeviceMcheckPlanDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-09 15:14
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceMcheckProcService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMcheckProcService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceMcheckProcDao assetsDeviceMcheckProcDao;
	@Autowired
	private AssetsDeviceMcheckPlanService assetsDeviceMcheckPlanServiceSub;

	@Autowired
	private BpmOperateService bpmOperateService;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private SysAutoCodeAPI sysAutoCodeAPI;
	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMcheckProcDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProcByPage(
			QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckProcDTO> dataList = assetsDeviceMcheckProcDao
					.searchAssetsDeviceMcheckProcByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckProcDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckProcDTO>();
			for (AssetsDeviceMcheckProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMcheckProcByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMcheckProcDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProcByPageOr(
			QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMcheckProcDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMcheckProcDTO> dataList = assetsDeviceMcheckProcDao
					.searchAssetsDeviceMcheckProcByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMcheckProcDTO> queryRespBean = new QueryRespBean<AssetsDeviceMcheckProcDTO>();
			for (AssetsDeviceMcheckProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMcheckProcByPage出错：", e);
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
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsDeviceMcheckProcDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceMcheckProcDTO> searchAssetsDeviceMcheckProc(
			QueryReqBean<AssetsDeviceMcheckProcDTO> queryReqBean) throws Exception {
		try {
			AssetsDeviceMcheckProcDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceMcheckProcDTO> dataList = assetsDeviceMcheckProcDao
					.searchAssetsDeviceMcheckProc(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMcheckProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceMcheckProcDTO
	 * @throws Exception
	 */
	public AssetsDeviceMcheckProcDTO queryAssetsDeviceMcheckProcByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceMcheckProcDTO dto = assetsDeviceMcheckProcDao.findAssetsDeviceMcheckProcById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceMcheckProcByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceMcheckProc(AssetsDeviceMcheckProcDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//给预约编号赋值
			Map<String,String> map = sysAutoCodeAPI.generateAutoCodeValue("","MAINTAIN_CODE",dto.getAutoCodeValue(),dto.getId(), false);
			if (map.get("result").equals("success")){
				dto.setMaintainCode(map.get("autoCodeValue"));
			}
			assetsDeviceMcheckProcDao.insertAssetsDeviceMcheckProc(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMcheckProc出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceMcheckProcList(List<AssetsDeviceMcheckProcDTO> dtoList) throws Exception {
		List<AssetsDeviceMcheckProcDTO> beanList = new ArrayList<AssetsDeviceMcheckProcDTO>();
		for (AssetsDeviceMcheckProcDTO dto : dtoList) {
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
			return assetsDeviceMcheckProcDao.insertAssetsDeviceMcheckProcList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMcheckProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckProc(AssetsDeviceMcheckProcDTO dto) throws Exception {
		//记录日志
		AssetsDeviceMcheckProcDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceMcheckProcDao.updateAssetsDeviceMcheckProcAll(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckProcSensitive(AssetsDeviceMcheckProcDTO dto) throws Exception {
		//记录日志
		AssetsDeviceMcheckProcDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceMcheckProcDao.updateAssetsDeviceMcheckProcSensitive(old);
		if (count == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return count;

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMcheckProcList(List<AssetsDeviceMcheckProcDTO> dtoList) throws Exception {
		try {
			return assetsDeviceMcheckProcDao.updateAssetsDeviceMcheckProcList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceMcheckProcList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckProcById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceMcheckProcDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for (AssetsDeviceMcheckPlanDTO sub : assetsDeviceMcheckPlanServiceSub
					.queryAssetsDeviceMcheckPlanByPid(obje.getId())) {
				assetsDeviceMcheckPlanServiceSub.deleteAssetsDeviceMcheckPlan(sub);
			}
			//删除主表
			return assetsDeviceMcheckProcDao.deleteAssetsDeviceMcheckProcById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMcheckProcById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMcheckProcByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceMcheckProcById(id);
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
	public int deleteAssetsDeviceMcheckProcList(List<String> idList) throws Exception {
		try {
			return assetsDeviceMcheckProcDao.deleteAssetsDeviceMcheckProcList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMcheckProcList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceMcheckProcDTO
	 * @throws Exception
	 */
	private AssetsDeviceMcheckProcDTO findById(String id) throws Exception {
		try {
			AssetsDeviceMcheckProcDTO dto = assetsDeviceMcheckProcDao.findAssetsDeviceMcheckProcById(id);
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
	public StartResultBean insertAssetsDeviceMcheckProcAndStartProcess(AssetsDeviceMcheckProcDTO bean,
			List<AssetsDeviceMcheckPlanDTO> beanSub, Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");

		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		bean.setGenerateBy(userId);
		//主表业务操作
		this.insertAssetsDeviceMcheckProc(bean);
		//子表业务操作
		assetsDeviceMcheckPlanServiceSub.insertOrUpdateAssetsDeviceMcheckPlan(beanSub, bean.getId());
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
