package avicit.assets.device.assetsstdtempapplyproc.service;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
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
import avicit.assets.device.assetsstdtempapplyproc.dao.AssetsStdtempapplyProcDao;
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsStdtempapplyProcDTO;


import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 16:59
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsStdtempapplyProcService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(AssetsStdtempapplyProcService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsStdtempapplyProcDao assetsStdtempapplyProcDao;
	@Autowired
    private AssetsSupplierService  assetsSupplierServiceSub;
    
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
	 * @return QueryRespBean<AssetsStdtempapplyProcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProcByPage(QueryReqBean<AssetsStdtempapplyProcDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsStdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsStdtempapplyProcDTO> dataList =  assetsStdtempapplyProcDao.searchAssetsStdtempapplyProcByPage(searchParams,orderBy);
			QueryRespBean<AssetsStdtempapplyProcDTO> queryRespBean =new QueryRespBean<AssetsStdtempapplyProcDTO>();
			for (AssetsStdtempapplyProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			logger.error("searchAssetsStdtempapplyProcByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		
																																																																																																																																																																																																																																																																																																																																																													/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsStdtempapplyProcDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProcByPageOr(QueryReqBean<AssetsStdtempapplyProcDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsStdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsStdtempapplyProcDTO> dataList =  assetsStdtempapplyProcDao.searchAssetsStdtempapplyProcByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsStdtempapplyProcDTO> queryRespBean =new QueryRespBean<AssetsStdtempapplyProcDTO>();
			for (AssetsStdtempapplyProcDTO dto : dataList.getResult()) {
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			logger.error("searchAssetsStdtempapplyProcByPage出错：", e);
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
	 * @return List<AssetsStdtempapplyProcDTO>
	 * @throws Exception
	 */
	public List<AssetsStdtempapplyProcDTO> searchAssetsStdtempapplyProc(QueryReqBean<AssetsStdtempapplyProcDTO> queryReqBean) throws Exception {
	    try{
	    	AssetsStdtempapplyProcDTO searchParams = queryReqBean.getSearchParams();
	    	List<AssetsStdtempapplyProcDTO> dataList = assetsStdtempapplyProcDao.searchAssetsStdtempapplyProc(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchAssetsStdtempapplyProc出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
    }
	
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsStdtempapplyProcDTO
	 * @throws Exception
	 */
	public AssetsStdtempapplyProcDTO queryAssetsStdtempapplyProcByPrimaryKey(String id) throws Exception {
		try{
			AssetsStdtempapplyProcDTO dto = assetsStdtempapplyProcDao.findAssetsStdtempapplyProcById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	logger.error("queryAssetsStdtempapplyProcByPrimaryKey出错：", e);
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
	public String insertAssetsStdtempapplyProc(AssetsStdtempapplyProcDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);

            Map<String, String> map = sysAutoCodeAPI.generateAutoCodeValue("", "ASSETS_USTDTEMPAPPLY_PROC", dto.getAutoCodeValue(), dto.getId(), false);

            if(map.get("result").equals("success")){
                dto.setStdId(map.get("autoCodeValue"));
            }


            assetsStdtempapplyProcDao.insertAssetsStdtempapplyProc(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			logger.error("insertAssetsStdtempapplyProc出错：", e);
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
	public int insertAssetsStdtempapplyProcList(List<AssetsStdtempapplyProcDTO> dtoList) throws Exception {
		List<AssetsStdtempapplyProcDTO> beanList = new ArrayList<AssetsStdtempapplyProcDTO>();
		for(AssetsStdtempapplyProcDTO dto: dtoList){
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
		    return assetsStdtempapplyProcDao.insertAssetsStdtempapplyProcList(beanList);
		}catch(Exception e){
			logger.error("insertAssetsStdtempapplyProcList出错：", e);
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
	public int updateAssetsStdtempapplyProc(AssetsStdtempapplyProcDTO dto) throws Exception {
			//记录日志
			AssetsStdtempapplyProcDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsStdtempapplyProcDao.updateAssetsStdtempapplyProcAll(old);
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
	public int updateAssetsStdtempapplyProcSensitive(AssetsStdtempapplyProcDTO dto) throws Exception {
			//记录日志
			AssetsStdtempapplyProcDTO  old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsStdtempapplyProcDao.updateAssetsStdtempapplyProcSensitive(old);
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
	public int updateAssetsStdtempapplyProcList(List<AssetsStdtempapplyProcDTO> dtoList) throws Exception {
		try{
            return assetsStdtempapplyProcDao.updateAssetsStdtempapplyProcList(dtoList);	 
		}catch(Exception e){
			logger.error("updateAssetsStdtempapplyProcList出错：", e);
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
	public int deleteAssetsStdtempapplyProcById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
			 throw new Exception("删除失败！传入的参数主键为null");
		   }
		try{
			//记录日志
			AssetsStdtempapplyProcDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			//删除子表
			for(AssetsSupplierDTO sub :assetsSupplierServiceSub.queryAssetsSupplierByPid(obje.getId())){
				assetsSupplierServiceSub.deleteAssetsSupplier(sub);
			}
			//删除主表
			return assetsStdtempapplyProcDao.deleteAssetsStdtempapplyProcById(id);
		}catch(Exception e){
			logger.error("deleteAssetsStdtempapplyProcById出错：", e);
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
	public int deleteAssetsStdtempapplyProcByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsStdtempapplyProcById(id);
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
	public int deleteAssetsStdtempapplyProcList(List<String> idList) throws Exception{
		try{
		    return assetsStdtempapplyProcDao.deleteAssetsStdtempapplyProcList(idList);
		}catch(Exception e){
	    	logger.error("deleteAssetsStdtempapplyProcList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsStdtempapplyProcDTO
	 * @throws Exception
	 */
	private AssetsStdtempapplyProcDTO findById(String id) throws Exception {
		try{
			AssetsStdtempapplyProcDTO dto = assetsStdtempapplyProcDao.findAssetsStdtempapplyProcById(id);
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
	public StartResultBean insertAssetsStdtempapplyProcAndStartProcess(AssetsStdtempapplyProcDTO bean, Map<String, Object> parameter) throws Exception{
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String)parameter.get("processDefId");
		String formCode = (String)parameter.get("formCode");
		String jsonString = (String)parameter.get("jsonString");
		String userId = (String)parameter.get("userId");
		String deptId = (String)parameter.get("deptId");
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		this.insertAssetsStdtempapplyProc(bean);
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
	public void insertUserLog(AssetsDeviceAccountDTO dto)throws Exception {
		//1.调用新增方法，新增一条当前登录人查看台账的数据
		//2.判断dto是否为空，避免产生空指针异常
		//3.dto的id去查询当前台账表本条数据进行对比
	}
		

}

