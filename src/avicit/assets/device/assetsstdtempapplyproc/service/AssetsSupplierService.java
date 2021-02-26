package avicit.assets.device.assetsstdtempapplyproc.service;
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
import avicit.assets.device.assetsstdtempapplyproc.dto.AssetsSupplierDTO;
import avicit.assets.device.assetsstdtempapplyproc.dao.AssetsSupplierDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 16:59
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsSupplierService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsSupplierService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsSupplierDao assetsSupplierDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSupplierDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSupplierDTO> searchAssetsSupplierByPage(QueryReqBean<AssetsSupplierDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSupplierDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSupplierDTO> dataList =  assetsSupplierDao.searchAssetsSupplierByPage(searchParams,orderBy);
			QueryRespBean<AssetsSupplierDTO> queryRespBean =new QueryRespBean<AssetsSupplierDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSupplierByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSupplierDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSupplierDTO> searchAssetsSupplierByPageOr(QueryReqBean<AssetsSupplierDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSupplierDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSupplierDTO> dataList =  assetsSupplierDao.searchAssetsSupplierByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsSupplierDTO> queryRespBean =new QueryRespBean<AssetsSupplierDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSupplierByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsSupplierDTO
	 * @throws Exception
	 */
	public AssetsSupplierDTO queryAssetsSupplierByPrimaryKey(String id) throws Exception {
		try{
			AssetsSupplierDTO dto = assetsSupplierDao.findAssetsSupplierById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSupplierByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsSupplierDTO>
	 * @throws Exception
	 */
	public List<AssetsSupplierDTO> queryAssetsSupplierByPid(String pid) throws Exception {
		try{
			List<AssetsSupplierDTO> dto = assetsSupplierDao.findAssetsSupplierByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSupplierByPid出错：", e);
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
	public String insertAssetsSupplier(AssetsSupplierDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsSupplierDao.insertAssetsSupplier(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAssetsSupplier出错：", e);
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
	public int insertAssetsSupplierList(List<AssetsSupplierDTO> dtoList,String pid) throws Exception {
		List<AssetsSupplierDTO> beanList = new ArrayList<AssetsSupplierDTO>();
		for(AssetsSupplierDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setLevelUpId(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return assetsSupplierDao.insertAssetsSupplierList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAssetsSupplierList出错：", e);
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
	public void insertOrUpdateAssetsSupplier(List<AssetsSupplierDTO> dtos,String pid)throws Exception {
		for(AssetsSupplierDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
				dto.setLevelUpId(pid);
				this.insertAssetsSupplier(dto);
			}else{
				this.updateAssetsSupplier(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsSupplier(AssetsSupplierDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSupplierDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSupplierDao.updateAssetsSupplierAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSupplier出错：", e);
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
	public int updateAssetsSupplierSensitive(AssetsSupplierDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSupplierDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSupplierDao.updateAssetsSupplierSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSupplierSensitive出错：", e);
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
	public int updateAssetsSupplierList(List<AssetsSupplierDTO> dtoList) throws Exception {
		try{
            return assetsSupplierDao.updateAssetsSupplierList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsSupplierList出错：", e);
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
	public int deleteAssetsSupplierById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AssetsSupplierDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsSupplierDao.deleteAssetsSupplierById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsSupplierById出错：", e);
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
	public int deleteAssetsSupplier(AssetsSupplierDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return assetsSupplierDao.deleteAssetsSupplierById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAssetsSupplier出错：", e);
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
	public int deleteAssetsSupplierByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsSupplierById(id);
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
	public int deleteAssetsSupplierList(List<String> idList) throws Exception{
		try{
		    return assetsSupplierDao.deleteAssetsSupplierList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsSupplierList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsSupplierDTO
	 * @throws Exception
	 */
	private AssetsSupplierDTO findById(String id) throws Exception {
		try{
			AssetsSupplierDTO dto = assetsSupplierDao.findAssetsSupplierById(id);
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

