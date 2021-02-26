package avicit.assets.device.assetsstdtempacceptance.service;
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
import avicit.assets.device.assetsstdtempacceptance.dto.AttInventoryDTO;
import avicit.assets.device.assetsstdtempacceptance.dao.AttInventoryDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-19 20:37
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AttInventoryService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AttInventoryService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AttInventoryDao attInventoryDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AttInventoryDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AttInventoryDTO> searchAttInventoryByPage(QueryReqBean<AttInventoryDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AttInventoryDTO searchParams = queryReqBean.getSearchParams();
			Page<AttInventoryDTO> dataList =  attInventoryDao.searchAttInventoryByPage(searchParams,orderBy);
			QueryRespBean<AttInventoryDTO> queryRespBean =new QueryRespBean<AttInventoryDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAttInventoryByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AttInventoryDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AttInventoryDTO> searchAttInventoryByPageOr(QueryReqBean<AttInventoryDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AttInventoryDTO searchParams = queryReqBean.getSearchParams();
			Page<AttInventoryDTO> dataList =  attInventoryDao.searchAttInventoryByPageOr(searchParams,orderBy);
			QueryRespBean<AttInventoryDTO> queryRespBean =new QueryRespBean<AttInventoryDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAttInventoryByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AttInventoryDTO
	 * @throws Exception
	 */
	public AttInventoryDTO queryAttInventoryByPrimaryKey(String id) throws Exception {
		try{
			AttInventoryDTO dto = attInventoryDao.findAttInventoryById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAttInventoryByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AttInventoryDTO>
	 * @throws Exception
	 */
	public List<AttInventoryDTO> queryAttInventoryByPid(String pid) throws Exception {
		try{
			List<AttInventoryDTO> dto = attInventoryDao.findAttInventoryByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAttInventoryByPid出错：", e);
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
	public String insertAttInventory(AttInventoryDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			attInventoryDao.insertAttInventory(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAttInventory出错：", e);
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
	public int insertAttInventoryList(List<AttInventoryDTO> dtoList,String pid) throws Exception {
		List<AttInventoryDTO> beanList = new ArrayList<AttInventoryDTO>();
		for(AttInventoryDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setFkSubColId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return attInventoryDao.insertAttInventoryList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAttInventoryList出错：", e);
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
	public void insertOrUpdateAttInventory(List<AttInventoryDTO> dtos,String pid)throws Exception {
		for(AttInventoryDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
				dto.setFkSubColId(pid);
				this.insertAttInventory(dto);
			}else{
				this.updateAttInventory(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAttInventory(AttInventoryDTO dto) throws Exception {
		try{
			//记录日志
			AttInventoryDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = attInventoryDao.updateAttInventoryAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAttInventory出错：", e);
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
	public int updateAttInventorySensitive(AttInventoryDTO dto) throws Exception {
		try{
			//记录日志
			AttInventoryDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = attInventoryDao.updateAttInventorySensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAttInventorySensitive出错：", e);
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
	public int updateAttInventoryList(List<AttInventoryDTO> dtoList) throws Exception {
		try{
            return attInventoryDao.updateAttInventoryList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAttInventoryList出错：", e);
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
	public int deleteAttInventoryById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AttInventoryDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return attInventoryDao.deleteAttInventoryById(id);
		}catch(Exception e){
			LOGGER.error("deleteAttInventoryById出错：", e);
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
	public int deleteAttInventory(AttInventoryDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return attInventoryDao.deleteAttInventoryById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAttInventory出错：", e);
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
	public int deleteAttInventoryByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAttInventoryById(id);
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
	public int deleteAttInventoryList(List<String> idList) throws Exception{
		try{
		    return attInventoryDao.deleteAttInventoryList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAttInventoryList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AttInventoryDTO
	 * @throws Exception
	 */
	private AttInventoryDTO findById(String id) throws Exception {
		try{
			AttInventoryDTO dto = attInventoryDao.findAttInventoryById(id);
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

