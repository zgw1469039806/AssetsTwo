package avicit.assets.device.dynusdassetsntc.service;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.dynusdassetsntc.dao.AssetsUstdCollectCmDao;
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;
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
import avicit.assets.device.dynusdassetsntc.dto.AssetsUstdCollectCmDTO;
import avicit.assets.device.dynusdassetsntc.dao.AssetsUstdCollectCmDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-04 19:12
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsUstdCollectCmService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsUstdCollectCmService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsUstdCollectCmDao assetsUstdCollectCmDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdCollectCmDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdCollectCmDTO> searchAssetsUstdCollectCmByPage(QueryReqBean<AssetsUstdCollectCmDTO> queryReqBean, String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdCollectCmDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdCollectCmDTO> dataList =  assetsUstdCollectCmDao.searchAssetsUstdCollectCmByPage(searchParams,orderBy);
			QueryRespBean<AssetsUstdCollectCmDTO> queryRespBean =new QueryRespBean<AssetsUstdCollectCmDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsUstdCollectCmByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsUstdCollectCmDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsUstdCollectCmDTO> searchAssetsUstdCollectCmByPageOr(QueryReqBean<AssetsUstdCollectCmDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsUstdCollectCmDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsUstdCollectCmDTO> dataList =  assetsUstdCollectCmDao.searchAssetsUstdCollectCmByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsUstdCollectCmDTO> queryRespBean =new QueryRespBean<AssetsUstdCollectCmDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsUstdCollectCmByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsUstdCollectCmDTO
	 * @throws Exception
	 */
	public AssetsUstdCollectCmDTO queryAssetsUstdCollectCmByPrimaryKey(String id) throws Exception {
		try{
			AssetsUstdCollectCmDTO dto = assetsUstdCollectCmDao.findAssetsUstdCollectCmById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsUstdCollectCmByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsUstdCollectCmDTO>
	 * @throws Exception
	 */
	public List<AssetsUstdCollectCmDTO> queryAssetsUstdCollectCmByPid(String pid) throws Exception {
		try{
			List<AssetsUstdCollectCmDTO> dto = assetsUstdCollectCmDao.findAssetsUstdCollectCmByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsUstdCollectCmByPid出错：", e);
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
	public String insertAssetsUstdCollectCm(AssetsUstdCollectCmDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsUstdCollectCmDao.insertAssetsUstdCollectCm(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAssetsUstdCollectCm出错：", e);
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
	public int insertAssetsUstdCollectCmList(List<AssetsUstdCollectCmDTO> dtoList,String pid) throws Exception {
		List<AssetsUstdCollectCmDTO> beanList = new ArrayList<AssetsUstdCollectCmDTO>();
		for(AssetsUstdCollectCmDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setHeaderIdCm(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return assetsUstdCollectCmDao.insertAssetsUstdCollectCmList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAssetsUstdCollectCmList出错：", e);
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
	public void insertOrUpdateAssetsUstdCollectCm(List<AssetsUstdCollectCmDTO> dtos,String pid)throws Exception {
		for(AssetsUstdCollectCmDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
				dto.setHeaderIdCm(pid);
				this.insertAssetsUstdCollectCm(dto);
			}else{
				this.updateAssetsUstdCollectCm(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsUstdCollectCm(AssetsUstdCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			AssetsUstdCollectCmDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsUstdCollectCmDao.updateAssetsUstdCollectCmAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdCollectCm出错：", e);
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
	public int updateAssetsUstdCollectCmSensitive(AssetsUstdCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			AssetsUstdCollectCmDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsUstdCollectCmDao.updateAssetsUstdCollectCmSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdCollectCmSensitive出错：", e);
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
	public int updateAssetsUstdCollectCmList(List<AssetsUstdCollectCmDTO> dtoList) throws Exception {
		try{
            return assetsUstdCollectCmDao.updateAssetsUstdCollectCmList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsUstdCollectCmList出错：", e);
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
	public int deleteAssetsUstdCollectCmById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AssetsUstdCollectCmDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsUstdCollectCmDao.deleteAssetsUstdCollectCmById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsUstdCollectCmById出错：", e);
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
	public int deleteAssetsUstdCollectCm(AssetsUstdCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return assetsUstdCollectCmDao.deleteAssetsUstdCollectCmById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAssetsUstdCollectCm出错：", e);
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
	public int deleteAssetsUstdCollectCmByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsUstdCollectCmById(id);
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
	public int deleteAssetsUstdCollectCmList(List<String> idList) throws Exception{
		try{
		    return assetsUstdCollectCmDao.deleteAssetsUstdCollectCmList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsUstdCollectCmList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsUstdCollectCmDTO
	 * @throws Exception
	 */
	private AssetsUstdCollectCmDTO findById(String id) throws Exception {
		try{
			AssetsUstdCollectCmDTO dto = assetsUstdCollectCmDao.findAssetsUstdCollectCmById(id);
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

