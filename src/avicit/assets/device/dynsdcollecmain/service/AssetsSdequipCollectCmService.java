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
import avicit.assets.device.dynsdcollecmain.dto.AssetsSdequipCollectCmDTO;
import avicit.assets.device.dynsdcollecmain.dao.AssetsSdequipCollectCmDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 19:59
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsSdequipCollectCmService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(AssetsSdequipCollectCmService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private AssetsSdequipCollectCmDao assetsSdequipCollectCmDao;
	
	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSdequipCollectCmDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSdequipCollectCmDTO> searchAssetsSdequipCollectCmByPage(QueryReqBean<AssetsSdequipCollectCmDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSdequipCollectCmDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSdequipCollectCmDTO> dataList =  assetsSdequipCollectCmDao.searchAssetsSdequipCollectCmByPage(searchParams,orderBy);
			QueryRespBean<AssetsSdequipCollectCmDTO> queryRespBean =new QueryRespBean<AssetsSdequipCollectCmDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSdequipCollectCmByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsSdequipCollectCmDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsSdequipCollectCmDTO> searchAssetsSdequipCollectCmByPageOr(QueryReqBean<AssetsSdequipCollectCmDTO> queryReqBean,String orderBy) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsSdequipCollectCmDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsSdequipCollectCmDTO> dataList =  assetsSdequipCollectCmDao.searchAssetsSdequipCollectCmByPageOr(searchParams,orderBy);
			QueryRespBean<AssetsSdequipCollectCmDTO> queryRespBean =new QueryRespBean<AssetsSdequipCollectCmDTO>();


			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchAssetsSdequipCollectCmByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsSdequipCollectCmDTO
	 * @throws Exception
	 */
	public AssetsSdequipCollectCmDTO queryAssetsSdequipCollectCmByPrimaryKey(String id) throws Exception {
		try{
			AssetsSdequipCollectCmDTO dto = assetsSdequipCollectCmDao.findAssetsSdequipCollectCmById(id);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSdequipCollectCmByPrimaryKey出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
	}
	
	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsSdequipCollectCmDTO>
	 * @throws Exception
	 */
	public List<AssetsSdequipCollectCmDTO> queryAssetsSdequipCollectCmByPid(String pid) throws Exception {
		try{
			List<AssetsSdequipCollectCmDTO> dto = assetsSdequipCollectCmDao.findAssetsSdequipCollectCmByPid(pid);
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryAssetsSdequipCollectCmByPid出错：", e);
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
	public String insertAssetsSdequipCollectCm(AssetsSdequipCollectCmDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsSdequipCollectCmDao.insertAssetsSdequipCollectCm(dto);
			//记录日志
			if(dto != null){
				SysLogUtil.log4Insert(dto);
			}
			return id;
		}catch(Exception e){
			LOGGER.error("insertAssetsSdequipCollectCm出错：", e);
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
	public int insertAssetsSdequipCollectCmList(List<AssetsSdequipCollectCmDTO> dtoList,String pid) throws Exception {
		List<AssetsSdequipCollectCmDTO> beanList = new ArrayList<AssetsSdequipCollectCmDTO>();
		for(AssetsSdequipCollectCmDTO dto: dtoList){
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
		    return assetsSdequipCollectCmDao.insertAssetsSdequipCollectCmList(beanList);
		}catch(Exception e){
			LOGGER.error("insertAssetsSdequipCollectCmList出错：", e);
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
	public void insertOrUpdateAssetsSdequipCollectCm(List<AssetsSdequipCollectCmDTO> dtos,String pid)throws Exception {
		for(AssetsSdequipCollectCmDTO dto :dtos){
			if("".equals(dto.getId())||null==dto.getId()){
				dto.setAttribute01(pid);
				this.insertAssetsSdequipCollectCm(dto);
			}else{
				this.updateAssetsSdequipCollectCm(dto);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsSdequipCollectCm(AssetsSdequipCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSdequipCollectCmDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSdequipCollectCmDao.updateAssetsSdequipCollectCmAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollectCm出错：", e);
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
	public int updateAssetsSdequipCollectCmSensitive(AssetsSdequipCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			AssetsSdequipCollectCmDTO old =findById(dto.getId());
			if(old != null){
				SysLogUtil.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = assetsSdequipCollectCmDao.updateAssetsSdequipCollectCmSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollectCmSensitive出错：", e);
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
	public int updateAssetsSdequipCollectCmList(List<AssetsSdequipCollectCmDTO> dtoList) throws Exception {
		try{
            return assetsSdequipCollectCmDao.updateAssetsSdequipCollectCmList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateAssetsSdequipCollectCmList出错：", e);
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
	public int deleteAssetsSdequipCollectCmById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		throw new Exception("删除失败！传入的参数主键为null");
		}
		try{
			//记录日志
			AssetsSdequipCollectCmDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return assetsSdequipCollectCmDao.deleteAssetsSdequipCollectCmById(id);
		}catch(Exception e){
			LOGGER.error("deleteAssetsSdequipCollectCmById出错：", e);
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
	public int deleteAssetsSdequipCollectCm(AssetsSdequipCollectCmDTO dto) throws Exception {
		try{
			//记录日志
			if(dto != null){
				SysLogUtil.log4Delete(dto);
			}
			return assetsSdequipCollectCmDao.deleteAssetsSdequipCollectCmById(dto.getId());
		}catch(Exception e){
			LOGGER.error("deleteAssetsSdequipCollectCm出错：", e);
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
	public int deleteAssetsSdequipCollectCmByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteAssetsSdequipCollectCmById(id);
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
	public int deleteAssetsSdequipCollectCmList(List<String> idList) throws Exception{
		try{
		    return assetsSdequipCollectCmDao.deleteAssetsSdequipCollectCmList(idList);
		}catch(Exception e){
	    	LOGGER.error("deleteAssetsSdequipCollectCmList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsSdequipCollectCmDTO
	 * @throws Exception
	 */
	private AssetsSdequipCollectCmDTO findById(String id) throws Exception {
		try{
			AssetsSdequipCollectCmDTO dto = assetsSdequipCollectCmDao.findAssetsSdequipCollectCmById(id);
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

