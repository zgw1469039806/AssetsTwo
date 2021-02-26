package avicit.assets.device.nationalclassify.service;

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
import avicit.assets.device.nationalclassify.dao.NationalClassifyDao;
import avicit.assets.device.nationalclassify.dto.NationalClassifyDTO;
import avicit.assets.device.nationalclassify.dto.NationalClassifyTreeDTO;
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
public class NationalClassifyService  implements Serializable {

	private static final Logger LOGGER =  LoggerFactory.getLogger(NationalClassifyService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private NationalClassifyDao nationalClassifyDao;

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
	 * @return NationalClassifyDTO
	 * @throws Exception
	 */
	public NationalClassifyDTO getLastChildNodeByPID(String parentId) throws Exception {
		try{
			List<NationalClassifyDTO> dataList =  nationalClassifyDao.getLastChildNodeByPID(parentId);

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
	 * @return List<NationalClassifyDTO>
	 * @throws Exception
	 */
	public List<NationalClassifyDTO> getNodesByPackageNodeId(String packageNodeId) throws Exception {
		try{
			List<NationalClassifyDTO> dataList =  nationalClassifyDao.getNodesByPackageNodeId(packageNodeId);
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
	 * @return QueryRespBean<NationalClassifyDTO>
	 * @throws Exception
	 */
	public QueryRespBean<NationalClassifyDTO> searchNationalClassifyByPage(QueryReqBean<NationalClassifyDTO> queryReqBean,String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			NationalClassifyDTO searchParams = queryReqBean.getSearchParams();
			Page<NationalClassifyDTO> dataList =  nationalClassifyDao.searchNationalClassifyByPage(searchParams, oderby);
			QueryRespBean<NationalClassifyDTO> queryRespBean =new QueryRespBean<NationalClassifyDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchNationalClassifyByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
	
	public List<NationalClassifyTreeDTO> getNationalClassifyTree(String menuName) throws Exception {
		try{
            List<NationalClassifyTreeDTO> dataList =  nationalClassifyDao.getNationalClassifyTree(menuName);
			return dataList;
		}catch(Exception e){
			LOGGER.error("getNationalClassifyTree出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
    }
		
																												/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param oderby 排序
	 * @return QueryRespBean<NationalClassifyDTO>
	 * @throws Exception
	 */
	public QueryRespBean<NationalClassifyDTO> searchNationalClassifyByPageOr(QueryReqBean<NationalClassifyDTO> queryReqBean,String oderby) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			NationalClassifyDTO searchParams = queryReqBean.getSearchParams();
			Page<NationalClassifyDTO> dataList =  nationalClassifyDao.searchNationalClassifyByPageOr(searchParams,oderby);
			QueryRespBean<NationalClassifyDTO> queryRespBean =new QueryRespBean<NationalClassifyDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(Exception e){
			LOGGER.error("searchNationalClassifyByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(),e);
		}
	}
		/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<NationalClassifyDTO>
	 * @throws Exception
	 */
	public List<NationalClassifyDTO> searchNationalClassify(QueryReqBean<NationalClassifyDTO> queryReqBean) throws Exception {
	    try{
	    	NationalClassifyDTO searchParams = queryReqBean.getSearchParams();
	    	List<NationalClassifyDTO> dataList = nationalClassifyDao.searchNationalClassify(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	LOGGER.error("searchNationalClassify出错：", e);
	    	e.printStackTrace();
	    	throw new DaoException(e.getMessage(),e);
	    }
    }
	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return NationalClassifyDTO
	 * @throws Exception
	 */
	public NationalClassifyDTO queryNationalClassifyByPrimaryKey(String id) throws Exception {
		try{
			NationalClassifyDTO dto = nationalClassifyDao.findNationalClassifyById(id);
			//记录日志
			if(dto != null){
			  SysLogUtil.log4Query(dto);
			}
			return dto;
		}catch(Exception e){
	    	LOGGER.error("queryNationalClassifyByPrimaryKey出错：", e);
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
	public NationalClassifyDTO insertNationalClassify(NationalClassifyDTO dto) throws Exception {
		try{
			String id = GetRandomString(10);
			dto.setId(id);
			dto.setTreePath(dto.getTreePath() + "," + id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			nationalClassifyDao.insertNationalClassify(dto);
			
			//记录日志
			if(dto != null){
			  SysLogUtil.log4Insert(dto);
			}
			return dto;
		}catch(Exception e){
			LOGGER.error("insertNationalClassify出错：", e);
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
	public int insertNationalClassifyList(List<NationalClassifyDTO> dtoList) throws Exception {
		List<NationalClassifyDTO> demo = new ArrayList<NationalClassifyDTO>();
		for(NationalClassifyDTO dto: dtoList){
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
		    return nationalClassifyDao.insertNationalClassifyList(demo);
		}catch(Exception e){
			LOGGER.error("insertNationalClassifyList出错：", e);
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
	public int updateNationalClassify(NationalClassifyDTO dto) throws Exception {
			//记录日志
			NationalClassifyDTO old =findById(dto.getId());
			if(old != null){
			  SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = nationalClassifyDao.updateNationalClassifyAll(old);
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
	public int updateNationalClassifySensitive(NationalClassifyDTO dto) throws Exception {
		try{
			//记录日志
			NationalClassifyDTO old =findById(dto.getId());
			if(old != null){
			  SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = nationalClassifyDao.updateNationalClassifySensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		}catch(Exception e){
			LOGGER.error("updateNationalClassifySensitive出错：", e);
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
	public int updateNationalClassifyList(List<NationalClassifyDTO> dtoList) throws Exception {
		try{
            return nationalClassifyDao.updateNationalClassifyList(dtoList);	 
		}catch(Exception e){
			LOGGER.error("updateNationalClassifyList出错：", e);
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
	public int deleteNationalClassifyById(String id) throws Exception {
		if(StringUtils.isEmpty(id)){
		   throw new Exception("删除失败！传入的参数主键为null");
		   }
		try{
			//记录日志
			NationalClassifyDTO obje = findById(id);
			if(obje != null){
				SysLogUtil.log4Delete(obje);
			}
			return nationalClassifyDao.deleteNationalClassifyById(id);
		}catch(Exception e){
			LOGGER.error("deleteNationalClassifyById出错：", e);
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
	public int deleteNationalClassifyByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteNationalClassifyById(id);
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
	public int deleteNationalClassifyList(List<String> idlist) throws Exception{
		try{
		    return nationalClassifyDao.deleteNationalClassifyList(idlist);
		}catch(Exception e){
	    	LOGGER.error("deleteNationalClassifyList出错：", e);
	    	e.printStackTrace();
	    	throw e;
	    }
	}
		/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return NationalClassifyDTO
	 * @throws Exception
	 */
	private NationalClassifyDTO findById(String id) throws Exception {
		try{
			NationalClassifyDTO dto = nationalClassifyDao.findNationalClassifyById(id);
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
