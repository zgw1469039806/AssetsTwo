package avicit.assets.furniture.furnitureclassify.service;

import java.io.Serializable;
import java.util.List;
import java.util.Random;
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
import avicit.assets.furniture.furnitureclassify.dao.FurnitureClassifyDao;
import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyDTO;
import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyTreeDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-05-28 09:07
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class FurnitureClassifyService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(FurnitureClassifyService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private FurnitureClassifyDao furnitureClassifyDao;

	public static String GetRandomString(int Len) {

		String[] baseString = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g",
				"h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B",
				"C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
				"X", "Y", "Z" };
		Random random = new Random();
		int length = baseString.length;
		String randomString = "";
		for (int i = 0; i < length; i++) {
			randomString += baseString[random.nextInt(length)];
		}
		random = new Random(System.currentTimeMillis());
		String resultStr = "";
		for (int i = 0; i < Len; i++) {
			resultStr += randomString.charAt(random.nextInt(randomString.length() - 1));
		}
		return resultStr;
	}
	
	/**
	 * 根据父节点id获取其排序最后一个直接子节点
	 * @param parentId 父节点id
	 * @return FurnitureClassifyDTO
	 * @throws Exception
	 */
	public FurnitureClassifyDTO getLastChildNodeByPID(String parentId) throws Exception {
		try{
			List<FurnitureClassifyDTO> dataList =  furnitureClassifyDao.getLastChildNodeByPID(parentId);

			if(dataList != null){
				return dataList.get(0);
			}
			return null;
		}catch(Exception e){
			LOGGER.error("getLastChildNodeByPID出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	/**
	 * 根据包节点id获取其下属所有节点，包括包节点
	 * @param：packageNodeId（包节点id）
	 * @return List<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public List<FurnitureClassifyDTO> getNodesByPackageNodeId(String packageNodeId) throws Exception {
		try{
			List<FurnitureClassifyDTO> dataList =  furnitureClassifyDao.getNodesByPackageNodeId(packageNodeId);
			return dataList;
		}catch(Exception e){
			LOGGER.error("getNodesByPackageNodeId出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param oderby 排序
	 * @return QueryRespBean<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public QueryRespBean<FurnitureClassifyDTO> searchFurnitureClassifyByPage(QueryReqBean<FurnitureClassifyDTO> queryReqBean,String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			FurnitureClassifyDTO searchParams = queryReqBean.getSearchParams();
			Page<FurnitureClassifyDTO> dataList =  furnitureClassifyDao.searchFurnitureClassifyByPage(searchParams, oderby);
			QueryRespBean<FurnitureClassifyDTO> queryRespBean =new QueryRespBean<FurnitureClassifyDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchFurnitureClassifyByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	public List<FurnitureClassifyTreeDTO> getFurnitureClassifyTree(String menuName) throws Exception {
		try{
            List<FurnitureClassifyTreeDTO> dataList =  furnitureClassifyDao.getFurnitureClassifyTree(menuName);
			return dataList;
		}catch(Exception e){
			LOGGER.error("getFurnitureClassifyTree出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
    }
		
																												/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param oderby 排序
	 * @return QueryRespBean<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public QueryRespBean<FurnitureClassifyDTO> searchFurnitureClassifyByPageOr(QueryReqBean<FurnitureClassifyDTO> queryReqBean,String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			FurnitureClassifyDTO searchParams = queryReqBean.getSearchParams();
			Page<FurnitureClassifyDTO> dataList =  furnitureClassifyDao.searchFurnitureClassifyByPageOr(searchParams,oderby);
			QueryRespBean<FurnitureClassifyDTO> queryRespBean =new QueryRespBean<FurnitureClassifyDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchFurnitureClassifyByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<FurnitureClassifyDTO>
	 * @throws Exception
	 */
	public List<FurnitureClassifyDTO> searchFurnitureClassify(QueryReqBean<FurnitureClassifyDTO> queryReqBean) throws Exception {
	    try{
	    	FurnitureClassifyDTO searchParams = queryReqBean.getSearchParams();
	    	List<FurnitureClassifyDTO> dataList = furnitureClassifyDao.searchFurnitureClassify(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	LOGGER.error("searchFurnitureClassify出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
    }
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return FurnitureClassifyDTO
	 * @throws Exception
	 */
	public FurnitureClassifyDTO queryFurnitureClassifyByPrimaryKey(String id) throws Exception {
		try{
			FurnitureClassifyDTO dto = furnitureClassifyDao.findFurnitureClassifyById(id);
			//记录日志
			if(dto != null){
			  SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryFurnitureClassifyByPrimaryKey出错：", e);
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
	public FurnitureClassifyDTO insertFurnitureClassify(FurnitureClassifyDTO dto) throws Exception {
		try{
			String id = GetRandomString(10);
			dto.setId(id);
			dto.setTreePath(dto.getTreePath() + "," + id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			furnitureClassifyDao.insertfurnitureClassify(dto);
			
			//记录日志
			if(dto != null){
			  SysLogUtil.log4Insert(dto);
			}
			return dto;
		}catch(Exception e){
			LOGGER.error("insertFurnitureClassify出错：", e);
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
	public int insertFurnitureClassifyList(List<FurnitureClassifyDTO> dtoList) throws Exception {
		List<FurnitureClassifyDTO> demo = new ArrayList<FurnitureClassifyDTO>();
		for(FurnitureClassifyDTO dto: dtoList){
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
		    return furnitureClassifyDao.insertFurnitureClassifyList(demo);
		}catch(Exception e){
			LOGGER.error("insertFurnitureClassifyList出错：", e);
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
	public int updateFurnitureClassify(FurnitureClassifyDTO dto) throws Exception {
			//记录日志
			FurnitureClassifyDTO old =findById(dto.getId());
			if(old != null){
			  SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = furnitureClassifyDao.updateFurnitureClassifyAll(old);
			if(ret ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return ret;
	}
	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateFurnitureClassifySensitive(FurnitureClassifyDTO dto) throws Exception {
		try{
			//记录日志
			FurnitureClassifyDTO old =findById(dto.getId());
			if(old != null){
			  SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = furnitureClassifyDao.updateFurnitureClassifySensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateFurnitureClassifySensitive出错：", e);
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
	public int updateFurnitureClassifyList(List<FurnitureClassifyDTO> dtoList) throws Exception {
		try{
            return furnitureClassifyDao.updateFurnitureClassifyList(dtoList);
		}catch(Exception e){
			LOGGER.error("updateFurnitureClassifyList出错：", e);
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
	public int deleteFurnitureClassifyById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		   throw new Exception("删除失败！传入的参数主键为null");
		   }
		try{
			//记录日志
			FurnitureClassifyDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return furnitureClassifyDao.deleteFurnitureClassifyById(id);
		}catch(Exception e){
			LOGGER.error("deleteFurnitureClassifyById出错：", e);
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
	public int deleteFurnitureClassifyByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteFurnitureClassifyById(id);
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
	public int deleteFurnitureClassifyList(List<String> idlist) throws Exception{
		try{
		    return furnitureClassifyDao.deleteFurnitureClassifyList(idlist);
		}catch(Exception e){
	    	LOGGER.error("deleteFurnitureClassifyList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
		/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return FurnitureClassifyDTO
	 * @throws Exception
	 */
	private FurnitureClassifyDTO findById(String id) throws Exception {
		try{
			FurnitureClassifyDTO dto = furnitureClassifyDao.findFurnitureClassifyById(id);
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
