package avicit.assets.device.dynsdcollecmain.service;
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
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectDTO;
import avicit.assets.device.dynsdcollecmain.dao.AssetsSdequipCollectDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 18:57
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsSdequipCollectService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsSdequipCollectService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsSdequipCollectDao assetsSdequipCollectDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSdequipCollectDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSdequipCollectDTO> searchAssetsSdequipCollectByPage(QueryReqBean<AssetsSdequipCollectDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSdequipCollectDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSdequipCollectDTO> dataList =  assetsSdequipCollectDao.searchAssetsSdequipCollectByPage(searchParams,orderBy);
			QueryRespBean<AssetsSdequipCollectDTO> queryRespBean =new QueryRespBean<AssetsSdequipCollectDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSdequipCollectByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSdequipCollectDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSdequipCollectDTO> searchAssetsSdequipCollectByPageOr(QueryReqBean<AssetsSdequipCollectDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSdequipCollectDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSdequipCollectDTO> dataList =  assetsSdequipCollectDao.searchAssetsSdequipCollectByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsSdequipCollectDTO> queryRespBean =new QueryRespBean<AssetsSdequipCollectDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSdequipCollectByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsSdequipCollectDTO
	 * @throws Exception
	 */
	public AssetsSdequipCollectDTO queryAssetsSdequipCollectByPrimaryKey(String id) throws Exception {
		try{
			AssetsSdequipCollectDTO dto = assetsSdequipCollectDao.findAssetsSdequipCollectById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSdequipCollectByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsSdequipCollectDTO>
	 * @throws Exception
	 */
	public List<AssetsSdequipCollectDTO> queryAssetsSdequipCollectByPid(String pid) throws Exception {
		try{
			List<AssetsSdequipCollectDTO> dto = assetsSdequipCollectDao.findAssetsSdequipCollectByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSdequipCollectByPid出错：", e);
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
	public String insertAssetsSdequipCollect(AssetsSdequipCollectDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsSdequipCollectDao.insertAssetsSdequipCollect(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAssetsSdequipCollect出错：", e);
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
	public int insertAssetsSdequipCollectList(List<AssetsSdequipCollectDTO> dtoList,String pid) throws Exception {
		List<AssetsSdequipCollectDTO> beanList = new ArrayList<AssetsSdequipCollectDTO>();
		for(AssetsSdequipCollectDTO dto: dtoList){
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setAttribute01(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try{
		    return assetsSdequipCollectDao.insertAssetsSdequipCollectList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAssetsSdequipCollectList出错：", e);
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
	public void insertOrUpdateAssetsSdequipCollect(List<AssetsSdequipCollectDTO> dtos,String pid)throws Exception {
		for(AssetsSdequipCollectDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
				dto.setAttribute01(pid);
				this.insertAssetsSdequipCollect(dto);
			}else{
				this.updateAssetsSdequipCollect(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsSdequipCollect(AssetsSdequipCollectDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSdequipCollectDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSdequipCollectDao.updateAssetsSdequipCollectAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollect出错：", e);
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
	public int updateAssetsSdequipCollectSensitive(AssetsSdequipCollectDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSdequipCollectDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSdequipCollectDao.updateAssetsSdequipCollectSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollectSensitive出错：", e);
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
	public int updateAssetsSdequipCollectList(List<AssetsSdequipCollectDTO> dtoList) throws Exception {
		try{
            return assetsSdequipCollectDao.updateAssetsSdequipCollectList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollectList出错：", e);
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
	public int deleteAssetsSdequipCollectById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AssetsSdequipCollectDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsSdequipCollectDao.deleteAssetsSdequipCollectById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsSdequipCollectById出错：", e);
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
	public int deleteAssetsSdequipCollect(AssetsSdequipCollectDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return assetsSdequipCollectDao.deleteAssetsSdequipCollectById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAssetsSdequipCollect出错：", e);
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
	public int deleteAssetsSdequipCollectByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsSdequipCollectById(id);
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
	public int deleteAssetsSdequipCollectList(List<String> idList) throws Exception{
		try{
		    return assetsSdequipCollectDao.deleteAssetsSdequipCollectList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsSdequipCollectList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsSdequipCollectDTO
	 * @throws Exception
	 */
	private AssetsSdequipCollectDTO findById(String id) throws Exception {
		try{
			AssetsSdequipCollectDTO dto = assetsSdequipCollectDao.findAssetsSdequipCollectById(id);
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
	 * @return List<AssetsSdequipCollectDTO>
	 * @throws Exception
	 */
	public List<AssetsSdequipCollectDTO> searchAssetsSdequipCollect(QueryReqBean<AssetsSdequipCollectDTO> queryReqBean) throws Exception {
		try{
			AssetsSdequipCollectDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsSdequipCollectDTO> dataList = assetsSdequipCollectDao.searchAssetsSdequipCollect(searchParams);
			return dataList;
		}catch(Exception e){
			LOGGER.error("searchAssetsSdequipCollect出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
}

