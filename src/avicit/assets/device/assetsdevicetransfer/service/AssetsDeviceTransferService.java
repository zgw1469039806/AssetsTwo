package avicit.assets.device.assetsdevicetransfer.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import avicit.platform6.api.sysautocode.SysAutoCodeAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
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
import avicit.assets.device.assetsdevicetransfer.dao.AssetsDeviceTransferDao;
import avicit.assets.device.assetsdevicetransfer.dto.AssetsDeviceTransferDTO;

import avicit.assets.device.assetsdevicetransfer.dto.AssetsTransferprocDeviceDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 19:36
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceTransferService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceTransferService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceTransferDao assetsDeviceTransferDao;
	@Autowired
	private AssetsTransferprocDeviceService assetsTransferprocDeviceServiceSub;

	@Autowired
	private BpmOperateService bpmOperateService;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private SysUserDeptPositionAPI sysUserDeptPositionAPI;	/* 用SysUserDeptPositionAPI接口 必须这样写 */

	@Autowired
	private SysAutoCodeAPI sysAutoCodeAPI;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceTransferDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceTransferDTO> searchAssetsDeviceTransferByPage(
			QueryReqBean<AssetsDeviceTransferDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceTransferDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceTransferDTO> dataList = assetsDeviceTransferDao
					.searchAssetsDeviceTransferByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceTransferDTO> queryRespBean = new QueryRespBean<AssetsDeviceTransferDTO>();
			for (AssetsDeviceTransferDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceTransferByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceTransferDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceTransferDTO> searchAssetsDeviceTransferByPageOr(
			QueryReqBean<AssetsDeviceTransferDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceTransferDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceTransferDTO> dataList = assetsDeviceTransferDao
					.searchAssetsDeviceTransferByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceTransferDTO> queryRespBean = new QueryRespBean<AssetsDeviceTransferDTO>();
			for (AssetsDeviceTransferDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceTransferByPage出错：", e);
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
	 * @return List<AssetsDeviceTransferDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceTransferDTO> searchAssetsDeviceTransfer(QueryReqBean<AssetsDeviceTransferDTO> queryReqBean)
			throws Exception {
		try {
			AssetsDeviceTransferDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceTransferDTO> dataList = assetsDeviceTransferDao.searchAssetsDeviceTransfer(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceTransfer出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceTransferDTO
	 * @throws Exception
	 */
	public AssetsDeviceTransferDTO queryAssetsDeviceTransferByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceTransferDTO dto = assetsDeviceTransferDao.findAssetsDeviceTransferById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceTransferByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsDeviceTransfer(AssetsDeviceTransferDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);

			/* 根据表单接收人的ID将接收人的部门ID查询出来，写入设备移交主表 */
			String receiverId = dto.getReceiver();	/* 在需要保存的DTO中获取接收人的ID */
			/* 通过接收人的ID在sysUserDeptPositionAPI接口里的方法查询接收人的部门ID，再写入到DTO实体中 */
			String deptId = sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(receiverId);
			dto.setReceiverDept(deptId);

			PojoUtil.setSysProperties(dto, OpType.insert);

			//设置移交编号
			Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "DEVICE_TRANSFER_PROC", dto.getAutoCodeValue(), dto.getId(), false);
			//	参数一：编码id（参数一、二任填一个即可）
			//	参数二：编码Code（参数一、二任填一个即可）
			//	参数三：当前码值
			//	参数四：表单id
			//	参数五：是否使用跳码
			if(map.get("result").equals("success")){
				dto.setProcId(map.get("autoCodeValue"));
			}

			assetsDeviceTransferDao.insertAssetsDeviceTransfer(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceTransfer出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceTransferList(List<AssetsDeviceTransferDTO> dtoList) throws Exception {
		List<AssetsDeviceTransferDTO> beanList = new ArrayList<AssetsDeviceTransferDTO>();
		for (AssetsDeviceTransferDTO dto : dtoList) {
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
			return assetsDeviceTransferDao.insertAssetsDeviceTransferList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceTransferList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceTransfer(AssetsDeviceTransferDTO dto) throws Exception {
		//记录日志
		AssetsDeviceTransferDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceTransferDao.updateAssetsDeviceTransferAll(old);
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
	public int updateAssetsDeviceTransferSensitive(AssetsDeviceTransferDTO dto) throws Exception {
		//记录日志
		AssetsDeviceTransferDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int count = assetsDeviceTransferDao.updateAssetsDeviceTransferSensitive(old);
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
	public int updateAssetsDeviceTransferList(List<AssetsDeviceTransferDTO> dtoList) throws Exception {
		try {
			return assetsDeviceTransferDao.updateAssetsDeviceTransferList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceTransferList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceTransferById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceTransferDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for (AssetsTransferprocDeviceDTO sub : assetsTransferprocDeviceServiceSub
					.queryAssetsTransferprocDeviceByPid(obje.getId())) {
				assetsTransferprocDeviceServiceSub.deleteAssetsTransferprocDevice(sub);
			}
			//删除主表
			return assetsDeviceTransferDao.deleteAssetsDeviceTransferById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceTransferById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceTransferByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceTransferById(id);
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
	public int deleteAssetsDeviceTransferList(List<String> idList) throws Exception {
		try {
			return assetsDeviceTransferDao.deleteAssetsDeviceTransferList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceTransferList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceTransferDTO
	 * @throws Exception
	 */
	private AssetsDeviceTransferDTO findById(String id) throws Exception {
		try {
			AssetsDeviceTransferDTO dto = assetsDeviceTransferDao.findAssetsDeviceTransferById(id);
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
	public StartResultBean insertAssetsDeviceTransferAndStartProcess(AssetsDeviceTransferDTO bean,
			List<AssetsTransferprocDeviceDTO> beanSub, Map<String, Object> parameter) throws Exception {
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String) parameter.get("processDefId");
		String formCode = (String) parameter.get("formCode");
		String jsonString = (String) parameter.get("jsonString");
		String userId = (String) parameter.get("userId");
		String deptId = (String) parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//主表业务操作
		this.insertAssetsDeviceTransfer(bean);
		//子表业务操作
		assetsTransferprocDeviceServiceSub.insertOrUpdateAssetsTransferprocDevice(beanSub, bean.getId());
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
