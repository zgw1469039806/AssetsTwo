package avicit.assets.device.dynsdcollecupld.service;
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
import avicit.assets.device.dynsdcollecupld.dto.DynSdCollecUpldDTO;
import avicit.assets.device.dynsdcollecupld.dao.DynSdCollecUpldDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-20 15:42
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class DynSdCollecUpldService  implements Serializable,InstanceDeleteEventListener {

	private static final Logger LOGGER =  LoggerFactory.getLogger(DynSdCollecUpldService.class);
	
	@Autowired
	private BpmOperateService bpmOperateService;
	
    private static final long serialVersionUID = 1L;
    
	
	@Autowired
	private DynSdCollecUpldDao dynSdCollecUpldDao;
	
	@Autowired
	private SwfUploadService sysAttachmentAPI;
	
	@Autowired
	private BusinessService businessService;

	
	
	@Override
	public void notify(String processInstanceId, String executionId, String formId) throws Exception {
		DynSdCollecUpldDao dynSdCollecUpldDao = SpringFactory.getBean(DynSdCollecUpldDao.class);
		dynSdCollecUpldDao.deleteDynSdCollecUpldById(formId);
	}
																																												/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param oderBy 排序
	 * @param orgIdentity 组织id
	 * @return QueryRespBean<DynSdCollecUpldDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynSdCollecUpldDTO> searchDynSdCollecUpldByPage(QueryReqBean<DynSdCollecUpldDTO> queryReqBean,String orgIdentity,String oderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynSdCollecUpldDTO searchParams = queryReqBean.getSearchParams();
			Page<DynSdCollecUpldDTO> dataList =  dynSdCollecUpldDao.searchDynSdCollecUpldByPage(searchParams,orgIdentity,oderBy);
			QueryRespBean<DynSdCollecUpldDTO> queryRespBean =new QueryRespBean<DynSdCollecUpldDTO>();
			for (DynSdCollecUpldDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchDynSdCollecUpldByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
			 			
																																												/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param oderBy 排序
	 * @param orgIdentity 组织id
	 * @return QueryRespBean<DynSdCollecUpldDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynSdCollecUpldDTO> searchDynSdCollecUpldByPageOr(QueryReqBean<DynSdCollecUpldDTO> queryReqBean,String orgIdentity,String oderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynSdCollecUpldDTO searchParams = queryReqBean.getSearchParams();
			Page<DynSdCollecUpldDTO> dataList =  dynSdCollecUpldDao.searchDynSdCollecUpldByPageOr(searchParams,orgIdentity,oderBy);
			QueryRespBean<DynSdCollecUpldDTO> queryRespBean =new QueryRespBean<DynSdCollecUpldDTO>();
			for (DynSdCollecUpldDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchDynSdCollecUpldByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
			 			/**
	 * 流程的编码转换成名称
	 * @param stateCode 编码
	 * @return String
	 */
	private String processStateCode2StateName(String stateCode){
		String stateName = "";
		if(stateCode != null && "active".equals(stateCode)){
			stateName = "流转中";
		}else if(stateCode !=null && "ended".equals(stateCode)){
			stateName = "结束";
		}else if(stateCode !=null && "start".equals(stateCode)){
			stateName = "草稿";
		}
		return stateName;
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean 查询条件
	 * @return List<DynSdCollecUpldDTO>
	 * @throws Exception
	 */
	public List<DynSdCollecUpldDTO> searchDynSdCollecUpld(QueryReqBean<DynSdCollecUpldDTO> queryReqBean) throws Exception {
	    try{
	    	DynSdCollecUpldDTO searchParams = queryReqBean.getSearchParams();
	    	List<DynSdCollecUpldDTO> dataList = dynSdCollecUpldDao.searchDynSdCollecUpld(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	LOGGER.error("searchDynSdCollecUpld出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
    }
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return DynSdCollecUpldDTO
	 * @throws Exception
	 */
	public DynSdCollecUpldDTO queryDynSdCollecUpldByPrimaryKey(String id) throws Exception {
		try{
			DynSdCollecUpldDTO dto = dynSdCollecUpldDao.findDynSdCollecUpldById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryDynSdCollecUpldByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
		/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertDynSdCollecUpld(DynSdCollecUpldDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynSdCollecUpldDao.insertDynSdCollecUpld(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertDynSdCollecUpld出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertDynSdCollecUpldList(List<DynSdCollecUpldDTO> dtoList) throws Exception {
		List<DynSdCollecUpldDTO> demo = new ArrayList<DynSdCollecUpldDTO>();
		for(DynSdCollecUpldDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			demo.add(dto);
		}
		try{
		    return dynSdCollecUpldDao.insertDynSdCollecUpldList(demo);
		}catch(Exception e){
			LOGGER.error("insertDynSdCollecUpldList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynSdCollecUpld(DynSdCollecUpldDTO dto) throws Exception {
		try{
			//记录日志
			DynSdCollecUpldDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dynSdCollecUpldDao.updateDynSdCollecUpldAll(old);
			if(ret ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		}catch(Exception e){
			LOGGER.error("updateDemoBusinessFlow出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateDynSdCollecUpldSensitive(DynSdCollecUpldDTO dto) throws Exception {
		try{
			//记录日志
			DynSdCollecUpldDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dynSdCollecUpldDao.updateDynSdCollecUpldSensitive(old);
			if(ret ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
		}catch(Exception e){
			LOGGER.error("updateDemoBusinessFlow出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}

	}
	
	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateDynSdCollecUpldList(List<DynSdCollecUpldDTO> dtoList) throws Exception {
		try{
            return dynSdCollecUpldDao.updateDynSdCollecUpldList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateDynSdCollecUpldList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}

	}
	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynSdCollecUpldById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			DynSdCollecUpldDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return dynSdCollecUpldDao.deleteDynSdCollecUpldById(id);
		}catch(Exception e){
			LOGGER.error("deleteDynSdCollecUpldById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynSdCollecUpldByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteDynSdCollecUpldById(id);
			String flowInstanceId = bpmOperateService.getInstanceIdByFormid(id);
			if(flowInstanceId != null && !"".equals(flowInstanceId)){
				bpmOperateService.deleteProcessInstanceCascade(flowInstanceId);
			}
			result++;
		}
		return result;
	}
	
	/**
	 * 批量删除数据2
	 * @param idlist 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteDynSdCollecUpldList(List<String> idlist) throws Exception{
		try{
		    return dynSdCollecUpldDao.deleteDynSdCollecUpldList(idlist);
		}catch(Exception e){
	    	LOGGER.error("deleteDynSdCollecUpldList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
		/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return DynSdCollecUpldDTO
	 * @throws Exception
	 */
	private DynSdCollecUpldDTO findById(String id) throws Exception {
		try{
			DynSdCollecUpldDTO dto = dynSdCollecUpldDao.findDynSdCollecUpldById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
    		LOGGER.error("findById出错：", e);
    		e.printStackTrace();
    		throw new DaoException(e.getMessage(),e);
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
	public StartResultBean insertDynSdCollecUpldAndStartProcess(DynSdCollecUpldDTO bean, Map<String, Object> parameter) throws Exception{
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String)parameter.get("processDefId");
		String formCode = (String)parameter.get("formCode");
		String jsonString = (String)parameter.get("jsonString");
		String userId = (String)parameter.get("userId");
		String deptId = (String)parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertDynSdCollecUpld(bean);
		//
		Map<String, Object> variables = new HashMap<String, Object>();
		//web表单传递过来(除表单对象外)的变量，可以为空
		if(jsonString != null && !"".equals(jsonString)){
			Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String)jsonString);
			variables.putAll(extVariables);
		}
		//把表单对象转换成map,传递给流程变量
		Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
		variables.putAll(pojoMap);
		String processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId, variables);
		// 返回对象
		return businessService.getStartResultBean(processInstanceId, bean.getId(), userId);
	}
}

