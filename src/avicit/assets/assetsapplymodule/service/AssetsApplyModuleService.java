package avicit.assets.assetsapplymodule.service;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.helper.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.sfn.intercept.SelfDefinedQuery;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.assetsapplymodule.dao.AssetsApplyModuleDao;
import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-01 14:22
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsApplyModuleService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsApplyModuleService.class);
	
    private static final long serialVersionUID = 1L;
	
	@Autowired
	private AssetsApplyModuleDao assetsApplyModuleDao;

	
																																																																																																																																																													/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param oderby 排序
	 * @return QueryRespBean<AssetsApplyModuleDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsApplyModuleDTO> searchAssetsApplyModuleByPage(QueryReqBean<AssetsApplyModuleDTO> queryReqBean, String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsApplyModuleDTO searchParams = queryReqBean.getSearchParams();
            Page<AssetsApplyModuleDTO> dataList =  assetsApplyModuleDao.searchAssetsApplyModuleByPage(searchParams, oderby);
			QueryRespBean<AssetsApplyModuleDTO> queryRespBean =new QueryRespBean<AssetsApplyModuleDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsApplyModuleByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	
    }
		
																																																																																																																																																													/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param oderby 排序
	 * @return QueryRespBean<AssetsApplyModuleDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsApplyModuleDTO> searchAssetsApplyModuleByPageOr(QueryReqBean<AssetsApplyModuleDTO> queryReqBean, String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsApplyModuleDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsApplyModuleDTO> dataList =  assetsApplyModuleDao.searchAssetsApplyModuleByPageOr(searchParams, oderby);
			QueryRespBean<AssetsApplyModuleDTO> queryRespBean =new QueryRespBean<AssetsApplyModuleDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsApplyModuleByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		
		/**
	 * 新增或修改对象
	 * @param demos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsApplyModule(List<AssetsApplyModuleDTO> demos)throws Exception {
		for(AssetsApplyModuleDTO demo :demos){
			if("".equals(demo.getId())||null==demo.getId()){
				this.insertAssetsApplyModule(demo);
			}else{
				this.updateAssetsApplyModule(demo);
			}
		}
	}


	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsApplyModule(AssetsApplyModuleDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																						PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsApplyModuleDao.insertAssetsApplyModule(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		}catch(Exception e){
			LOGGER.error("insertAssetsApplyModule出错：", e);
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
	public int insertAssetsApplyModuleList(List<AssetsApplyModuleDTO> dtoList) throws Exception {
		List<AssetsApplyModuleDTO> demo = new ArrayList<AssetsApplyModuleDTO>();
		for(AssetsApplyModuleDTO dto: dtoList){
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
		    return assetsApplyModuleDao.insertAssetsApplyModuleList(demo);
		}catch(Exception e){
			LOGGER.error("insertAssetsApplyModuleList出错：", e);
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
	public int updateAssetsApplyModule(AssetsApplyModuleDTO dto) throws Exception {
			//记录日志
			AssetsApplyModuleDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = assetsApplyModuleDao.updateAssetsApplyModuleSensitive(old);
			if(ret ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
	}

	/**
	 * 绑定合同系统关联的数据
	 * @param list
	 * @return
	 */
	public int relateGS(List<AssetsApplyModuleDTO> list)throws Exception{
		int sum=0;
		//首先解除和合同系统关联的数据
		AssetsApplyModuleDTO assetsApplyModuleDTO = list.get(0);
		this.assetsApplyModuleDao.updateContract(assetsApplyModuleDTO.getContractId());

		for (int i=0;i<list.size();i++){
			AssetsApplyModuleDTO dto=list.get(i);
			if(!StringUtil.isBlank(dto.getId())){
				dto.setIsContractRelated("Y");
				PojoUtil.setSysProperties(dto, OpType.update);
				sum+=assetsApplyModuleDao.updateAssetsApplyModuleSensitive(dto);
			}
		}
		return sum;
	}

    /**
     * 合同审批结束，同步数据
     * @param applyList
     * @throws Exception
     */
	public int approvalFinish(List<AssetsApplyModuleDTO> applyList)throws Exception{
		int sum=0;
        for (int i=0;i<applyList.size();i++){
            AssetsApplyModuleDTO dto=applyList.get(i);
            PojoUtil.setSysProperties(dto, OpType.update);
            sum+=assetsApplyModuleDao.updateAssetsApplyModuleSensitive(dto);
        }
        return sum;
    }
	
	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsApplyModuleList(List<AssetsApplyModuleDTO> dtoList) throws Exception {
		try{
            return assetsApplyModuleDao.updateAssetsApplyModuleList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsApplyModuleList出错：", e);
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
	public int deleteAssetsApplyModuleById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		 	return 0;
		}
		try{
			//记录日志
			AssetsApplyModuleDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsApplyModuleDao.deleteAssetsApplyModuleById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsApplyModuleById出错：", e);
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
	public int deleteAssetsApplyModuleByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsApplyModuleById(id);
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
	public int deleteAssetsApplyModuleList(List<String> idlist) throws Exception{
		try{
		    return assetsApplyModuleDao.deleteAssetsApplyModuleList(idlist);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsApplyModuleList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
		
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsApplyModuleDTO
	 * @throws Exception
	 */
	private AssetsApplyModuleDTO findById(String id) throws Exception {
		try{
			AssetsApplyModuleDTO dto = assetsApplyModuleDao.findAssetsApplyModuleById(id);
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
	 * 根据申购Id(applyId)获取合同列表
	 * @param applyId 申购Id
	 * @return AssetsApplyModuleDTO
	 * @throws Exception
	 */
	public AssetsApplyModuleDTO getAssetsApplyModulesByApplyId(String applyId) throws Exception {
		try{
			List<AssetsApplyModuleDTO> dataList =  assetsApplyModuleDao.getAssetsApplyModulesByApplyId(applyId);

			if((dataList != null) && (dataList.size()>0)){
				return dataList.get(0);
			}
			return null;
		}catch(Exception e){
			LOGGER.error("getAssetsApplyModulesByApplyId出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}

	}

}

