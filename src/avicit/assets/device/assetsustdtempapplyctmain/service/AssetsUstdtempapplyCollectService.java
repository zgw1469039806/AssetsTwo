package avicit.assets.device.assetsustdtempapplyctmain.service;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsustdtempapplyctmain.dto.AssetsUstdtempapplyCollectDTO;
import avicit.assets.device.assetsustdtempapplyctmain.dao.AssetsUstdtempapplyCollectDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-26 16:24
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsUstdtempapplyCollectService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsUstdtempapplyCollectService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsUstdtempapplyCollectDao assetsUstdtempapplyCollectDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdtempapplyCollectDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollectByPage(QueryReqBean<AssetsUstdtempapplyCollectDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdtempapplyCollectDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdtempapplyCollectDTO> dataList =  assetsUstdtempapplyCollectDao.searchAssetsUstdtempapplyCollectByPage(searchParams,orderBy);
			QueryRespBean<AssetsUstdtempapplyCollectDTO> queryRespBean =new QueryRespBean<AssetsUstdtempapplyCollectDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsUstdtempapplyCollectByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdtempapplyCollectDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollectByPageOr(QueryReqBean<AssetsUstdtempapplyCollectDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdtempapplyCollectDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdtempapplyCollectDTO> dataList =  assetsUstdtempapplyCollectDao.searchAssetsUstdtempapplyCollectByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsUstdtempapplyCollectDTO> queryRespBean =new QueryRespBean<AssetsUstdtempapplyCollectDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsUstdtempapplyCollectByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsUstdtempapplyCollectDTO
	 * @throws Exception
	 */
	public AssetsUstdtempapplyCollectDTO queryAssetsUstdtempapplyCollectByPrimaryKey(String id) throws Exception {
		try{
			AssetsUstdtempapplyCollectDTO dto = assetsUstdtempapplyCollectDao.findAssetsUstdtempapplyCollectById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsUstdtempapplyCollectByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsUstdtempapplyCollectDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdtempapplyCollectDTO> queryAssetsUstdtempapplyCollectByPid(String pid) throws Exception {
		try{
			List<AssetsUstdtempapplyCollectDTO> dto = assetsUstdtempapplyCollectDao.findAssetsUstdtempapplyCollectByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsUstdtempapplyCollectByPid出错：", e);
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
	public String insertAssetsUstdtempapplyCollect(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsUstdtempapplyCollectDao.insertAssetsUstdtempapplyCollect(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAssetsUstdtempapplyCollect出错：", e);
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
	public int insertAssetsUstdtempapplyCollectList(List<AssetsUstdtempapplyCollectDTO> dtoList,String pid) throws Exception {
		List<AssetsUstdtempapplyCollectDTO> beanList = new ArrayList<AssetsUstdtempapplyCollectDTO>();
		for(AssetsUstdtempapplyCollectDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setHeaderId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return assetsUstdtempapplyCollectDao.insertAssetsUstdtempapplyCollectList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAssetsUstdtempapplyCollectList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsUstdtempapplyCollect(List<AssetsUstdtempapplyCollectDTO> dtos,String pid)throws Exception {
		for(AssetsUstdtempapplyCollectDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
//				dto.setHeaderId(pid);
				this.insertAssetsUstdtempapplyCollect(dto);
			}else{
				this.updateAssetsUstdtempapplyCollect(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsUstdtempapplyCollect(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		try{
			//记录日志
			AssetsUstdtempapplyCollectDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsUstdtempapplyCollectDao.updateAssetsUstdtempapplyCollectAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdtempapplyCollect出错：", e);
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
	public int updateAssetsUstdtempapplyCollectSensitive(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		try{
			//记录日志
			AssetsUstdtempapplyCollectDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsUstdtempapplyCollectDao.updateAssetsUstdtempapplyCollectSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdtempapplyCollectSensitive出错：", e);
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
	public int updateAssetsUstdtempapplyCollectList(List<AssetsUstdtempapplyCollectDTO> dtoList) throws Exception {
		try{
            return assetsUstdtempapplyCollectDao.updateAssetsUstdtempapplyCollectList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdtempapplyCollectList出错：", e);
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
	public int deleteAssetsUstdtempapplyCollectById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AssetsUstdtempapplyCollectDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsUstdtempapplyCollectDao.deleteAssetsUstdtempapplyCollectById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsUstdtempapplyCollectById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsUstdtempapplyCollect(AssetsUstdtempapplyCollectDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return assetsUstdtempapplyCollectDao.deleteAssetsUstdtempapplyCollectById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAssetsUstdtempapplyCollect出错：", e);
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
	public int deleteAssetsUstdtempapplyCollectByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsUstdtempapplyCollectById(id);
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
	public int deleteAssetsUstdtempapplyCollectList(List<String> idList) throws Exception{
		try{
		    return assetsUstdtempapplyCollectDao.deleteAssetsUstdtempapplyCollectList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsUstdtempapplyCollectList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsUstdtempapplyCollectDTO
	 * @throws Exception
	 */
	private AssetsUstdtempapplyCollectDTO findById(String id) throws Exception {
		try{
			AssetsUstdtempapplyCollectDTO dto = assetsUstdtempapplyCollectDao.findAssetsUstdtempapplyCollectById(id);
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
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsUstdtempapplyCollectDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdtempapplyCollectDTO> searchAssetsUstdtempapplyCollect(QueryReqBean<AssetsUstdtempapplyCollectDTO> queryReqBean) throws Exception {
		try{
			AssetsUstdtempapplyCollectDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsUstdtempapplyCollectDTO> dataList = assetsUstdtempapplyCollectDao.searchAssetsUstdtempapplyCollect(searchParams);
			return dataList;
		}catch(Exception e){
			LOGGER.error("searchAssetsUstdtempapplyCollect出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		

}

