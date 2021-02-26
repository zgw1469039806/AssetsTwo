package avicit.platform6.menu.syshistmenus.service;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.platform6.core.rest.msg.PageParameter;
import org.apache.commons.lang3.StringUtils;
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
import avicit.platform6.menu.syshistmenus.dao.SysHistMenusDao;
import avicit.platform6.menu.syshistmenus.dto.SysHistMenusDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-05 17:18
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class SysHistMenusService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(SysHistMenusService.class);
	
    private static final long serialVersionUID = 1L;
    //历史浏览记录10条
    private static final int HIST_VIEW_MENU_COUNT=10;
    private static final int HIST_VIEW_MENU_PAGE=1;
	
	@Autowired
	private SysHistMenusDao sysHistMenusDao;

	
																																																																																																				/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param oderby 排序
	 * @return QueryRespBean<SysHistMenusDTO>
	 * @throws Exception
	 */
	public QueryRespBean<SysHistMenusDTO> searchSysHistMenusByPage(QueryReqBean<SysHistMenusDTO> queryReqBean, String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			SysHistMenusDTO searchParams = queryReqBean.getSearchParams();
            Page<SysHistMenusDTO> dataList =  sysHistMenusDao.searchSysHistMenusByPage(searchParams, oderby);
			QueryRespBean<SysHistMenusDTO> queryRespBean =new QueryRespBean<SysHistMenusDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchSysHistMenusByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	
    }

	public List<SysHistMenusDTO> searchMySysHistMenus(String userId)throws Exception{
		try{
			PageParameter pageParameter=new PageParameter();
			pageParameter.setRows(HIST_VIEW_MENU_COUNT);
			pageParameter.setPage(HIST_VIEW_MENU_PAGE);
			PageHelper.startPage(pageParameter);
			Page<SysHistMenusDTO> dataList =this.sysHistMenusDao.searchMySysHistMenus(userId);
			return dataList.getResult();
		}catch (Exception e){
			LOGGER.error("searchMySysHistMenus出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		
																																																																																																				/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param oderby 排序
	 * @return QueryRespBean<SysHistMenusDTO>
	 * @throws Exception
	 */
	public QueryRespBean<SysHistMenusDTO> searchSysHistMenusByPageOr(QueryReqBean<SysHistMenusDTO> queryReqBean, String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			SysHistMenusDTO searchParams = queryReqBean.getSearchParams();
			Page<SysHistMenusDTO> dataList =  sysHistMenusDao.searchSysHistMenusByPageOr(searchParams, oderby);
			QueryRespBean<SysHistMenusDTO> queryRespBean =new QueryRespBean<SysHistMenusDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchSysHistMenusByPage出错：", e);
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
	public void insertOrUpdateSysHistMenus(List<SysHistMenusDTO> demos)throws Exception {
		for(SysHistMenusDTO demo :demos){
			if("".equals(demo.getId())||null==demo.getId()){
				this.insertSysHistMenus(demo);
			}else{
				this.updateSysHistMenus(demo);
			}
		}
	}


	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return int
	 * @throws Exception
	 */
	public int insertSysHistMenus(SysHistMenusDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
																																																																																																																																																																																																																																																																																																											PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = sysHistMenusDao.insertSysHistMenus(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		}catch(Exception e){
			LOGGER.error("insertSysHistMenus出错：", e);
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
	public int insertSysHistMenusList(List<SysHistMenusDTO> dtoList) throws Exception {
		List<SysHistMenusDTO> demo = new ArrayList<SysHistMenusDTO>();
		for(SysHistMenusDTO dto: dtoList){
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
		    return sysHistMenusDao.insertSysHistMenusList(demo);
		}catch(Exception e){
			LOGGER.error("insertSysHistMenusList出错：", e);
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
	public int updateSysHistMenus(SysHistMenusDTO dto) throws Exception {
			//记录日志
			SysHistMenusDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = sysHistMenusDao.updateSysHistMenusSensitive(old);
			if(ret ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
	}
	
	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateSysHistMenusList(List<SysHistMenusDTO> dtoList) throws Exception {
		try{
            return sysHistMenusDao.updateSysHistMenusList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateSysHistMenusList出错：", e);
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
	public int deleteSysHistMenusById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		 	return 0;
		}
		try{
			//记录日志
			SysHistMenusDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return sysHistMenusDao.deleteSysHistMenusById(id);
		}catch(Exception e){
			LOGGER.error("deleteSysHistMenusById出错：", e);
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
	public int deleteSysHistMenusByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteSysHistMenusById(id);
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
	public int deleteSysHistMenusList(List<String> idlist) throws Exception{
		try{
		    return sysHistMenusDao.deleteSysHistMenusList(idlist);
		}catch(Exception e){
	    	LOGGER.error("deleteSysHistMenusList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
		
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return SysHistMenusDTO
	 * @throws Exception
	 */
	private SysHistMenusDTO findById(String id) throws Exception {
		try{
			SysHistMenusDTO dto = sysHistMenusDao.findSysHistMenusById(id);
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
		

}

