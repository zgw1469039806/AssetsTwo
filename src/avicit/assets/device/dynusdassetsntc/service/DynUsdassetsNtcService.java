package avicit.assets.device.dynusdassetsntc.service;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.assetsustdtempapplyctmain.service.AssetsUstdtempapplyCollectService;
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
import avicit.assets.device.dynusdassetsntc.dao.DynUsdassetsNtcDao;
import avicit.assets.device.dynusdassetsntc.dto.DynUsdassetsNtcDTO;


import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 18:51
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class DynUsdassetsNtcService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(DynUsdassetsNtcService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private DynUsdassetsNtcDao dynUsdassetsNtcDao;
	@Autowired
    private AssetsUstdtempapplyCollectService assetsUstdtempapplyCollectServiceSub;
    
    @Autowired
	private BpmOperateService bpmOperateService;
	
	@Autowired
	private BusinessService businessService;
	
																																																		/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @param orgIdentity 组织id
	 * @return QueryRespBean<DynUsdassetsNtcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynUsdassetsNtcDTO> searchDynUsdassetsNtcByPage(QueryReqBean<DynUsdassetsNtcDTO> queryReqBean,String orgIdentity,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynUsdassetsNtcDTO searchParams = queryReqBean.getSearchParams();
            Page<DynUsdassetsNtcDTO> dataList =  dynUsdassetsNtcDao.searchDynUsdassetsNtcByPage(searchParams,orgIdentity,orderBy);
			QueryRespBean<DynUsdassetsNtcDTO> queryRespBean =new QueryRespBean<DynUsdassetsNtcDTO>();
			for (DynUsdassetsNtcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			logger.error("searchDynUsdassetsNtcByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		 		 			
																																																		/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @param orgIdentity 组织id
	 * @return QueryRespBean<DynUsdassetsNtcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<DynUsdassetsNtcDTO> searchDynUsdassetsNtcByPageOr(QueryReqBean<DynUsdassetsNtcDTO> queryReqBean,String orgIdentity,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			DynUsdassetsNtcDTO searchParams = queryReqBean.getSearchParams();
            Page<DynUsdassetsNtcDTO> dataList =  dynUsdassetsNtcDao.searchDynUsdassetsNtcByPageOr(searchParams,orgIdentity,orderBy);
			QueryRespBean<DynUsdassetsNtcDTO> queryRespBean =new QueryRespBean<DynUsdassetsNtcDTO>();
			for (DynUsdassetsNtcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			logger.error("searchDynUsdassetsNtcByPage出错：", e);
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
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<DynUsdassetsNtcDTO>
	 * @throws Exception
	 */
	public List<DynUsdassetsNtcDTO> searchDynUsdassetsNtc(QueryReqBean<DynUsdassetsNtcDTO> queryReqBean) throws Exception {
	    try{
	    	DynUsdassetsNtcDTO searchParams = queryReqBean.getSearchParams();
	    	List<DynUsdassetsNtcDTO> dataList = dynUsdassetsNtcDao.searchDynUsdassetsNtc(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchDynUsdassetsNtc出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
    }
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return DynUsdassetsNtcDTO
	 * @throws Exception
	 */
	public DynUsdassetsNtcDTO queryDynUsdassetsNtcByPrimaryKey(String id) throws Exception {
		try{
			DynUsdassetsNtcDTO dto = dynUsdassetsNtcDao.findDynUsdassetsNtcById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	logger.error("queryDynUsdassetsNtcByPrimaryKey出错：", e);
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
	public String insertDynUsdassetsNtc(DynUsdassetsNtcDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dynUsdassetsNtcDao.insertDynUsdassetsNtc(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			logger.error("insertDynUsdassetsNtc出错：", e);
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
	public int insertDynUsdassetsNtcList(List<DynUsdassetsNtcDTO> dtoList) throws Exception {
		List<DynUsdassetsNtcDTO> beanList = new ArrayList<DynUsdassetsNtcDTO>();
		for(DynUsdassetsNtcDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return dynUsdassetsNtcDao.insertDynUsdassetsNtcList(beanList);
		}catch(Exception e){
			logger.error("insertDynUsdassetsNtcList出错：", e);
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
	public int updateDynUsdassetsNtc(DynUsdassetsNtcDTO dto) throws Exception {
			//记录日志
			DynUsdassetsNtcDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dynUsdassetsNtcDao.updateDynUsdassetsNtcAll(old);
			if(count ==0){
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
	public int updateDynUsdassetsNtcSensitive(DynUsdassetsNtcDTO dto) throws Exception {
			//记录日志
			DynUsdassetsNtcDTO  old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dynUsdassetsNtcDao.updateDynUsdassetsNtcSensitive(old);
			if(count ==0){
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
	public int updateDynUsdassetsNtcList(List<DynUsdassetsNtcDTO> dtoList) throws Exception {
		try{
            return dynUsdassetsNtcDao.updateDynUsdassetsNtcList(dtoList);	 
		}catch(Exception e){
			logger.error("updateDynUsdassetsNtcList出错：", e);
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
	public int deleteDynUsdassetsNtcById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
			 throw new Exception("删除失败！传入的参数主键为null");
		   }
		try{
			//记录日志
			DynUsdassetsNtcDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for(AssetsUstdtempapplyCollectDTO sub :assetsUstdtempapplyCollectServiceSub.queryAssetsUstdtempapplyCollectByPid(obje.getId())){
				assetsUstdtempapplyCollectServiceSub.deleteAssetsUstdtempapplyCollect(sub);
			}
			//删除主表
			return dynUsdassetsNtcDao.deleteDynUsdassetsNtcById(id);
		}catch(Exception e){
			logger.error("deleteDynUsdassetsNtcById出错：", e);
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
	public int deleteDynUsdassetsNtcByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteDynUsdassetsNtcById(id);
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
	public int deleteDynUsdassetsNtcList(List<String> idList) throws Exception{
		try{
		    return dynUsdassetsNtcDao.deleteDynUsdassetsNtcList(idList);
		}catch(Exception e){
	    	logger.error("deleteDynUsdassetsNtcList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return DynUsdassetsNtcDTO
	 * @throws Exception
	 */
	private DynUsdassetsNtcDTO findById(String id) throws Exception {
		try{
			DynUsdassetsNtcDTO dto = dynUsdassetsNtcDao.findDynUsdassetsNtcById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
    		logger.error("findById出错：", e);
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
	public StartResultBean insertDynUsdassetsNtcAndStartProcess(DynUsdassetsNtcDTO bean, Map<String, Object> parameter) throws Exception{
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String)parameter.get("processDefId");
		String formCode = (String)parameter.get("formCode");
		String jsonString = (String)parameter.get("jsonString");
		String userId = (String)parameter.get("userId");
		String deptId = (String)parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertDynUsdassetsNtc(bean);
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

